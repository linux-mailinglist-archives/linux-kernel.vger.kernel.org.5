Return-Path: <linux-kernel+bounces-63191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EA2852C25
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFCDF1F217EB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702F022097;
	Tue, 13 Feb 2024 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0RefKy/B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lKYqmnyW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0RefKy/B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lKYqmnyW"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F361C6AD
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707815919; cv=none; b=brXK1Iwh8yjZD6Pastk+0FNjiRDvxov69+EweTZS1ytDSdpllt5FNdAeohsErGAfbW0uArfRJCjkXGb/Aql0+DtlY/0cTzXsOK5kxhUwsfcLIlsY6/0vrh3n/DIInrysfSVRK/DouRELqruLD28+YIqNu6U1/rrjgWXWjAfUxhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707815919; c=relaxed/simple;
	bh=QHpTrfbD6Cxc5A4xZJUViFMjJoNOL0P5llt+klEf9CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpgjoh8tAd1Nqr4A9HtLIHHb1pFQiEvReB7/uslSqThjKfMXquxnzLXT8IioINeJyk2lN81rwTViMBrM0HSfzk8BCFFYfzjzx6dcV/dRUQGUZi19l4rGnT8PeXujGhcJiqOoUXiR6uKSBZwDvuGas0ja9V3O4Vz+Ije04ShEZz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0RefKy/B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lKYqmnyW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0RefKy/B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lKYqmnyW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4AAE321C24;
	Tue, 13 Feb 2024 09:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707815916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ebQ/QBmagH33BuOSYaJpuDXGz/X0XyWgvNd0wEUstmk=;
	b=0RefKy/BFhW6IL4S8ZED0cHTokViyCdUZdXFqd8QDtpPHktN1KHvGTvv3VM2xkCUyXNuFe
	e16OA0s/AlSETxp2TXJjv/GKqaOvoNidqEYXScRdx4FedhAYfner85CnTqGTHzKPTP173q
	wq0kG9DCndIAIrrvIWVulYGLMt/jewc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707815916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ebQ/QBmagH33BuOSYaJpuDXGz/X0XyWgvNd0wEUstmk=;
	b=lKYqmnyWD/dpwkkLrpGerzGn0YJfZ0bOQhltIjMTlsFCPHmtV4EcU4rnOm8zMVqEcZbEUk
	Uxpxi7tEy9ygw9DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707815916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ebQ/QBmagH33BuOSYaJpuDXGz/X0XyWgvNd0wEUstmk=;
	b=0RefKy/BFhW6IL4S8ZED0cHTokViyCdUZdXFqd8QDtpPHktN1KHvGTvv3VM2xkCUyXNuFe
	e16OA0s/AlSETxp2TXJjv/GKqaOvoNidqEYXScRdx4FedhAYfner85CnTqGTHzKPTP173q
	wq0kG9DCndIAIrrvIWVulYGLMt/jewc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707815916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ebQ/QBmagH33BuOSYaJpuDXGz/X0XyWgvNd0wEUstmk=;
	b=lKYqmnyWD/dpwkkLrpGerzGn0YJfZ0bOQhltIjMTlsFCPHmtV4EcU4rnOm8zMVqEcZbEUk
	Uxpxi7tEy9ygw9DQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C8A7F13A0E;
	Tue, 13 Feb 2024 09:18:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 7qDHLeszy2VGIAAAn2gu4w
	(envelope-from <osalvador@suse.de>); Tue, 13 Feb 2024 09:18:35 +0000
Date: Tue, 13 Feb 2024 10:19:45 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v8 3/5] mm,page_owner: Display all stacks and their count
Message-ID: <Zcs0MdpWwRTv_Uzy@localhost.localdomain>
References: <20240212223029.30769-1-osalvador@suse.de>
 <20240212223029.30769-4-osalvador@suse.de>
 <CANpmjNM8pWMvEYW1YffTjy5xRgyeTOP0sGJoV31pbKU1dH5b9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNM8pWMvEYW1YffTjy5xRgyeTOP0sGJoV31pbKU1dH5b9w@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.18
X-Spamd-Result: default: False [-4.18 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-0.995];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-2.88)[99.48%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,suse.com,suse.cz,gmail.com,google.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On Tue, Feb 13, 2024 at 09:38:43AM +0100, Marco Elver wrote:
> On Mon, 12 Feb 2024 at 23:29, Oscar Salvador <osalvador@suse.de> wrote:
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> 
> Acked-by: Marco Elver <elver@google.com>

Thanks!

 
> > +                       /* This pairs with smp_load_acquire() from function
> 
> Comment should be
> 
> /*
>  *
> ...
>  */

Yap, fat fingers here.

> > +       if (!*ppos) {
> > +               /*
> > +                * This pairs with smp_store_release() from function
> > +                * add_stack_record_to_list(), so we get a consistent
> > +                * value of stack_list.
> > +                */
> > +               stack = smp_load_acquire(&stack_list);
> 
> I'm not sure if it'd make your code simpler or not: there is
> <linux/llist.h> for singly-linked linked lists, although the code to
> manage the list is simple enough I'm indifferent here. Only consider
> it if it helps you make the code simpler.

I will check if it eases the code somehow.


> > +static void stack_stop(struct seq_file *m, void *v)
> > +{
> > +}
> 
> Is this function even needed if it's empty? I recall there were some
> boilerplate "nop" functions that could be used.

I will check if seq already provides a dummy function for these cases.

-- 
Oscar Salvador
SUSE Labs

