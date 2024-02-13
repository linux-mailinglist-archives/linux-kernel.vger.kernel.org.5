Return-Path: <linux-kernel+bounces-63854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A6F85358A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B641C24AF1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BE65F551;
	Tue, 13 Feb 2024 16:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zy+f35Fj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FE8XoO3Y";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zy+f35Fj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FE8XoO3Y"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CEC5F491
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840220; cv=none; b=o911ngiCgETRnEZze8QJXl6OqeXf9b3ApjWNTbiGgosNzUxOaCJQg2zU/kKLChMTxM+CwArW88tSlVO6gdU0Q1VbllmJQNb7wj9JeTNX/uJ0p2ImIcCss0OouZwk2/Xn5UIoo72yK03+cHWHakT2sbthRwCnfXlrtRGfopH5/6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840220; c=relaxed/simple;
	bh=rPDyBYSXDCsz5GJMe18opVkoOGsbwpQe287yIr4tPqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmXhn/3D7G8tWT8BWufU6nu2Hps6ZNF0SALEx+KbkeLeKJL3Vwn2lkeCRbn0rGXQTef7sKXS6vnow1FmBr5GMhBTXsZcBPglsyXlYO1M1tc0Cxo5xfgDwuY6c+Jy1w1YTdkx75s7hvNd0Srl6yTSUgAUpSxnbIFQxbg/HY2Vs7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zy+f35Fj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FE8XoO3Y; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zy+f35Fj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FE8XoO3Y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CC1A01FCE6;
	Tue, 13 Feb 2024 16:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707840213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FRNhjJkgXL7v16ZU0iS2vdAZzEHkrAUpw4bf8r6ZDEw=;
	b=Zy+f35FjpVmxtg237HXhU3wXU4q82NcWwOfCXnQm6NcCnHtYS8itTBh5i9ty1JqgapXpIu
	mC3lB2vZ/C9YdPgoytALScmPR/UDV1uYoHrmOdux1SFNrNZKrD+IgPYIqobqsOYR9M26BT
	jwAWpjb+cBrbDmJ5qlfl2lFoozubtEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707840213;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FRNhjJkgXL7v16ZU0iS2vdAZzEHkrAUpw4bf8r6ZDEw=;
	b=FE8XoO3YAebclHOu7Kze9qUhPPIPinRmWaprVrIK6Q8n0kkOLGEEUQoD/aLo1zdKLXMUMY
	lhf37WClN5sYdNDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707840213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FRNhjJkgXL7v16ZU0iS2vdAZzEHkrAUpw4bf8r6ZDEw=;
	b=Zy+f35FjpVmxtg237HXhU3wXU4q82NcWwOfCXnQm6NcCnHtYS8itTBh5i9ty1JqgapXpIu
	mC3lB2vZ/C9YdPgoytALScmPR/UDV1uYoHrmOdux1SFNrNZKrD+IgPYIqobqsOYR9M26BT
	jwAWpjb+cBrbDmJ5qlfl2lFoozubtEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707840213;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FRNhjJkgXL7v16ZU0iS2vdAZzEHkrAUpw4bf8r6ZDEw=;
	b=FE8XoO3YAebclHOu7Kze9qUhPPIPinRmWaprVrIK6Q8n0kkOLGEEUQoD/aLo1zdKLXMUMY
	lhf37WClN5sYdNDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 545EE1329E;
	Tue, 13 Feb 2024 16:03:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id kUPbEdWSy2VSBQAAn2gu4w
	(envelope-from <osalvador@suse.de>); Tue, 13 Feb 2024 16:03:33 +0000
Date: Tue, 13 Feb 2024 17:04:38 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v8 2/5] mm,page_owner: Implement the tracking of the
 stacks count
Message-ID: <ZcuTFo-EMWjbRsd6@localhost.localdomain>
References: <20240212223029.30769-1-osalvador@suse.de>
 <20240212223029.30769-3-osalvador@suse.de>
 <8ff46f99-d167-448f-9aae-a634b8aae4d0@suse.cz>
 <ZcuK2I6ZwFwFX-G5@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcuK2I6ZwFwFX-G5@localhost.localdomain>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Zy+f35Fj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FE8XoO3Y
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,suse.com,google.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.80)[99.15%]
X-Spam-Score: -4.31
X-Rspamd-Queue-Id: CC1A01FCE6
X-Spam-Flag: NO

On Tue, Feb 13, 2024 at 04:29:28PM +0100, Oscar Salvador wrote:
> I thought about giving them a refcount of 1, because we only print
> stacks which refcount > 1 anyways, but setting it to 0 has comes with
> the advantage of catching spurious increments, should someone call
> refcount_inc on those (which should not really happen).

On a second thought, I think we want a refcount of 1 for these stacks
at the beginning.
So should we e.g: re-enter page_owner, we would increment dummy_stack's
refcount. If refcount is 0, we will get a warning.



-- 
Oscar Salvador
SUSE Labs

