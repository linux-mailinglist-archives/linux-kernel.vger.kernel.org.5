Return-Path: <linux-kernel+bounces-63801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3223D85349B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0831F24CBB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E705DF30;
	Tue, 13 Feb 2024 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s9snqPdm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3G41LElH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s9snqPdm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3G41LElH"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ED05DF1F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838103; cv=none; b=WlzmSOxbeB2bF4AZ8rGghhG13opwYrMug2amgeeFTLTCkl0X2Kjo+Fwa5zSXNfSWljjl6zZiycrpyTN9nwYS8YDBHTc256uZbnpxVWsFLe3WCyLFTrO5rm3/yBtXKqSVdRwO73PTsrE4BQpeoTWnbHU4QE55K3Ki74sa2iBn2bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838103; c=relaxed/simple;
	bh=Rr2j/IFiXol9Mw+JdHIp1YqM70+RP6dRKHr/Kkpocsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8vUxzhF6Z+N7rjmSPWhEjDXI1+DN6ayD0qThWbibIQJaQ8XbFPTp59WR2/xQsJ8w+NRNflBMb+rfYexWeJeCmKwhoKQ/c6xamLeB9fn5lGit2Nn/u3tgqDdXzXLVF5mI27KERa+68u955asG9nsCQhGepmnSvaqz9v+D/L6Das=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=s9snqPdm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3G41LElH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=s9snqPdm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3G41LElH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BC0C121F56;
	Tue, 13 Feb 2024 15:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707838099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UOqyyr9J8HQa/t+lFwrZoSXmef4Harx/aN0fYbsHfuw=;
	b=s9snqPdmjc0zE/IWEh7KNMpJIvChwViTVyraSTzNTLOzzr/0Onf6O/x11sPa27GJ5kiIcs
	b3xrhw3zQOaSF8yUwuC2jzIPRRfSCJOuqhhY5an0VrmBP7BSW8J0rQ4+FTM8+m+dmLfnms
	Iq73rl3G2QCAZhVOgNzASXinHvaiyGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707838099;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UOqyyr9J8HQa/t+lFwrZoSXmef4Harx/aN0fYbsHfuw=;
	b=3G41LElH0mWmFp3mfaiiLSZLKdMgQ/TyT4p978X73j3rv+uO5b5gweuImbQbibhiMBr+O8
	ZQtb4hH1E45S5ICg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707838099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UOqyyr9J8HQa/t+lFwrZoSXmef4Harx/aN0fYbsHfuw=;
	b=s9snqPdmjc0zE/IWEh7KNMpJIvChwViTVyraSTzNTLOzzr/0Onf6O/x11sPa27GJ5kiIcs
	b3xrhw3zQOaSF8yUwuC2jzIPRRfSCJOuqhhY5an0VrmBP7BSW8J0rQ4+FTM8+m+dmLfnms
	Iq73rl3G2QCAZhVOgNzASXinHvaiyGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707838099;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UOqyyr9J8HQa/t+lFwrZoSXmef4Harx/aN0fYbsHfuw=;
	b=3G41LElH0mWmFp3mfaiiLSZLKdMgQ/TyT4p978X73j3rv+uO5b5gweuImbQbibhiMBr+O8
	ZQtb4hH1E45S5ICg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4220513A0E;
	Tue, 13 Feb 2024 15:28:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id kxJfC5OKy2ULfAAAn2gu4w
	(envelope-from <osalvador@suse.de>); Tue, 13 Feb 2024 15:28:19 +0000
Date: Tue, 13 Feb 2024 16:29:28 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v8 2/5] mm,page_owner: Implement the tracking of the
 stacks count
Message-ID: <ZcuK2I6ZwFwFX-G5@localhost.localdomain>
References: <20240212223029.30769-1-osalvador@suse.de>
 <20240212223029.30769-3-osalvador@suse.de>
 <8ff46f99-d167-448f-9aae-a634b8aae4d0@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ff46f99-d167-448f-9aae-a634b8aae4d0@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-5.44 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,suse.com,google.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.34)[90.43%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -5.44

On Tue, Feb 13, 2024 at 02:42:25PM +0100, Vlastimil Babka wrote:
> On 2/12/24 23:30, Oscar Salvador wrote:
> >  	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
> >  	page_ext_put(page_ext);
> > +	inc_stack_record_count(handle);
> 
> What if this is dummy handle, which means we have recursed in page owner,
> and we'll by trying to kmalloc() its struct stack and link it to the
> stack_list because it was returned for the first time? Also failure_handle.
> Could you pre-create static (not kmalloc) struct stack for these handles
> with refcount of 0 and insert them to stack_list, all during
> init_page_owner()? Bonus: no longer treating stack_list == NULL in a special
> way in add_stack_record_to_list() (although you don't need to handle it
> extra even now, AFAICS).

Good catch. I did not think about this scenario, but this could
definitely happen.
Yeah, maybe creating an array of 2 structs for {dummy,failure}_handle
and link them into stack_list.

I thought about giving them a refcount of 1, because we only print
stacks which refcount > 1 anyways, but setting it to 0 has comes with
the advantage of catching spurious increments, should someone call
refcount_inc on those (which should not really happen).

I will try to implement it.

Thanks

-- 
Oscar Salvador
SUSE Labs

