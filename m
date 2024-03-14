Return-Path: <linux-kernel+bounces-102901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEA587B82C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2708B20CA7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6EC10A0C;
	Thu, 14 Mar 2024 06:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D7OPkPWJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/gaZxBl0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D7OPkPWJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/gaZxBl0"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703F4FC02
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 06:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710399592; cv=none; b=OdQ3Uxkly7D7BAhSiLrVLGIQp0pnQ8/VIIyXjPB9EgkhagMGq//hT6IgIhLhcM6283vZUYEeImMMnUh7yUkZt3ygLsSqi7Z4f36x3F1YmLV7hLmJsemIDGBjH0IZms8YjkcKfnaUBXTt2LbAsW8p3nvm7UTfqZeoNzRdlPPf220=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710399592; c=relaxed/simple;
	bh=EPTkeADMkq8+UlqcvCgbDsEoG0WAPvrJD9MYSsSFKvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCFdbX15iQjz/Cu0FSz8tGDSPRLy5XWYfsewKPIxgeR1sCr42cjFX0HwFxnR7Vllt/vqPD0CQIHW6SwnhUjrjVtGvpEUNT47NhR97HnASX+hk5VSW45QtE13XaE/N/zaNVFH3/XTzFr83UcR6f8AGJj56h4eX+3ESBwO7DF1gZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D7OPkPWJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/gaZxBl0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D7OPkPWJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/gaZxBl0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6286F1F801;
	Thu, 14 Mar 2024 06:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710399588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S/5e7/owEFh+yr96zv8SqWUtyqNGdFYUZ+h1W9s6ozQ=;
	b=D7OPkPWJUgWV/2f84L84GCu5/sYWALDcfxNzugLTztfS73Ph0StDReqqc6JlTHBQkWaBYB
	lEo3kCOPg7QdiznRsKw6uRbrjF46E1WE8kg/7lQ6oyARZ/6ZtTBXwUK9uK/klEr+fAewRN
	VeBVpPAhbeyL+jvDceyIlo2IdEElxiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710399588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S/5e7/owEFh+yr96zv8SqWUtyqNGdFYUZ+h1W9s6ozQ=;
	b=/gaZxBl0yDhi9jv0y3aIpb2Hay2USbcXMVir5gpQeoXDxasNyOZ7/CnZeY4hLPDOZBiMvy
	QtCTa6aae10vLpCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710399588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S/5e7/owEFh+yr96zv8SqWUtyqNGdFYUZ+h1W9s6ozQ=;
	b=D7OPkPWJUgWV/2f84L84GCu5/sYWALDcfxNzugLTztfS73Ph0StDReqqc6JlTHBQkWaBYB
	lEo3kCOPg7QdiznRsKw6uRbrjF46E1WE8kg/7lQ6oyARZ/6ZtTBXwUK9uK/klEr+fAewRN
	VeBVpPAhbeyL+jvDceyIlo2IdEElxiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710399588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S/5e7/owEFh+yr96zv8SqWUtyqNGdFYUZ+h1W9s6ozQ=;
	b=/gaZxBl0yDhi9jv0y3aIpb2Hay2USbcXMVir5gpQeoXDxasNyOZ7/CnZeY4hLPDOZBiMvy
	QtCTa6aae10vLpCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C45C213977;
	Thu, 14 Mar 2024 06:59:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EcAlLWOg8mW7BwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 14 Mar 2024 06:59:47 +0000
Date: Thu, 14 Mar 2024 08:01:07 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lei Yang <leiyang@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] mm,page_owner: Fix recursion
Message-ID: <ZfKgs9E2ozZER20D@localhost.localdomain>
References: <20240313234245.18824-1-osalvador@suse.de>
 <2ff96a50-fc65-4e42-b15d-097c0f15a455@I-love.SAKURA.ne.jp>
 <ZfKPf_pGxv-xtSPN@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfKPf_pGxv-xtSPN@localhost.localdomain>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.06
X-Spamd-Result: default: False [-2.06 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,redhat.com,vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.76)[84.22%]
X-Spam-Flag: NO

On Thu, Mar 14, 2024 at 06:47:43AM +0100, Oscar Salvador wrote:
> On Thu, Mar 14, 2024 at 12:01:24PM +0900, Tetsuo Handa wrote:
> > Maybe culprit for a page owner refcount bug reported at
> > https://syzkaller.appspot.com/bug?id=8e4e66dfe299a2a00204ad220c641daaf1486a00 , for
> > that commit went to next-20240214 and syzbot started failing to test since next-20240215 ?
> > 
> > Please send this patch to linux-next.git as soon as possible (or can someone experiencing
> > this bug try booting linux-next.git with this patch applied, so that we can check whether
> > syzbot can resume testing linux-next.git), and then send to linux.git together (so that
> > various trees which depend on linux.git won't start failing to boot).
> 
> No, that is something else that I already started fixing a few days ago.
> I think I will have the fix ready today.

I already have the fix. I will do some more testing and then I will send
it out.

Thanks

-- 
Oscar Salvador
SUSE Labs

