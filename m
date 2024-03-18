Return-Path: <linux-kernel+bounces-105836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1D287E535
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C86701C20FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599E02C690;
	Mon, 18 Mar 2024 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oTwkafZ8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="j2hftKGP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oTwkafZ8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="j2hftKGP"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FB22C1B9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710751716; cv=none; b=ERbd9N9sGnM6WKg00EqPmRbPpfaU1hA8wFoBqa8hU/2KYOAeV5gYFuhF5O8uo0HiX9GK9HEeGDtRv4PWMk6XIIIxOAqh+06isSDYa7xS66j4cJYlM5z75tCzb1C9eItKn/ht7qhkICRQlTbI+DN7PC/42HPU/gH2OnkgqJqDSms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710751716; c=relaxed/simple;
	bh=8Fymkj2RAhgYwoOMAv5HH2psFdB5h6gX6JwERO/pMSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mu+i8TkOUspn0mYIoTTOQkvzEJZE8Eq0Smfa2nZboHHkY7rp+F4NW5hfICIbpEIhLo5y3G44CE2XotPwydHVqcdQEeT17fEBG2EJa9aQ6CKtkaqTyJzyckHLe3OhRh0Zr/w5rYH7WF0Vs3juL47/wLXCWN5FmAJP7CR9tvMrmR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oTwkafZ8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=j2hftKGP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oTwkafZ8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=j2hftKGP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 245475C2C7;
	Mon, 18 Mar 2024 08:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710751707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GdkzrNaPtEVEtt2kiY3Zyg869C8fmWrE5dcBL0lwOP4=;
	b=oTwkafZ84BJTO46pVmS9oqb2R7XDmou1TmfuBg9BHAxU4iQ2f8x49pfMaj6bePQyfIFRVI
	cr9E2u4XaMkyf5A+75jl2XVeYZLHIFIe5U4bnlYGH+Hsaxw7XdfuY0RSPeWZvKrF853x8i
	meD0qmOtUaLU1fi1ZUoiahuphhyc31U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710751707;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GdkzrNaPtEVEtt2kiY3Zyg869C8fmWrE5dcBL0lwOP4=;
	b=j2hftKGPhYlRIJw9w1AV5NOppSVeqap+7QJcDIBFYYgIg5PwitsCeDO0Zn7OqJGN1JTyLa
	Ae/rqmeIS/FVrPDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710751707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GdkzrNaPtEVEtt2kiY3Zyg869C8fmWrE5dcBL0lwOP4=;
	b=oTwkafZ84BJTO46pVmS9oqb2R7XDmou1TmfuBg9BHAxU4iQ2f8x49pfMaj6bePQyfIFRVI
	cr9E2u4XaMkyf5A+75jl2XVeYZLHIFIe5U4bnlYGH+Hsaxw7XdfuY0RSPeWZvKrF853x8i
	meD0qmOtUaLU1fi1ZUoiahuphhyc31U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710751707;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GdkzrNaPtEVEtt2kiY3Zyg869C8fmWrE5dcBL0lwOP4=;
	b=j2hftKGPhYlRIJw9w1AV5NOppSVeqap+7QJcDIBFYYgIg5PwitsCeDO0Zn7OqJGN1JTyLa
	Ae/rqmeIS/FVrPDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B9E81349D;
	Mon, 18 Mar 2024 08:48:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q6hAAtv/92UGPgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 18 Mar 2024 08:48:27 +0000
Message-ID: <dd16e7cf-fd37-44a3-89de-ebb92acdad74@suse.cz>
Date: Mon, 18 Mar 2024 09:48:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm,page_owner: Fix recursion
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Michal Hocko <mhocko@suse.com>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>
References: <20240315222610.6870-1-osalvador@suse.de>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240315222610.6870-1-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.50
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.50 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 MID_RHS_MATCH_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.cz:dkim];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,google.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oTwkafZ8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=j2hftKGP
X-Rspamd-Queue-Id: 245475C2C7

On 3/15/24 23:26, Oscar Salvador wrote:
> Prior to 217b2119b9e2 ("mm,page_owner: implement the tracking of the stacks count")
> the only place where page_owner could potentially go into recursion due to
> its need of allocating more memory was in save_stack(), which ends up calling
> into stackdepot code with the possibility of allocating memory.
> 
> We made sure to guard against that by signaling that the current task was
> already in page_owner code, so in case a recursion attempt was made, we
> could catch that and return dummy_handle.
> 
> After above commit, a new place in page_owner code was introduced where we
> could allocate memory, meaning we could go into recursion would we take that
> path.
> 
> Make sure to signal that we are in page_owner in that codepath as well.
> Move the guard code into two helpers {un}set_current_in_page_owner()
> and use them prior to calling in the two functions that might allocate
> memory.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Fixes: 217b2119b9e2 ("mm,page_owner: implement the tracking of the stacks count")

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
> Changes from v1 -> v2:
>  Wrap {un}set_current_in_page_owner directly around kmalloc call
>  (Vlastimil feedback)
> ---
>  mm/page_owner.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index e96dd9092658..cde1ee0f9005 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -54,6 +54,22 @@ static depot_stack_handle_t early_handle;
>  
>  static void init_early_allocated_pages(void);
>  
> +static inline void set_current_in_page_owner(void)
> +{
> +	/*
> +	 * Avoid recursion.
> +	 *
> +	 * We might need to allocate more memory from page_owner code, so make
> +	 * sure to signal it in order to avoid recursion.
> +	 */
> +	current->in_page_owner = 1;
> +}
> +
> +static inline void unset_current_in_page_owner(void)
> +{
> +	current->in_page_owner = 0;
> +}
> +
>  static int __init early_page_owner_param(char *buf)
>  {
>  	int ret = kstrtobool(buf, &page_owner_enabled);
> @@ -133,23 +149,16 @@ static noinline depot_stack_handle_t save_stack(gfp_t flags)
>  	depot_stack_handle_t handle;
>  	unsigned int nr_entries;
>  
> -	/*
> -	 * Avoid recursion.
> -	 *
> -	 * Sometimes page metadata allocation tracking requires more
> -	 * memory to be allocated:
> -	 * - when new stack trace is saved to stack depot
> -	 */
>  	if (current->in_page_owner)
>  		return dummy_handle;
> -	current->in_page_owner = 1;
>  
> +	set_current_in_page_owner();
>  	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 2);
>  	handle = stack_depot_save(entries, nr_entries, flags);
>  	if (!handle)
>  		handle = failure_handle;
> +	unset_current_in_page_owner();
>  
> -	current->in_page_owner = 0;
>  	return handle;
>  }
>  
> @@ -164,9 +173,13 @@ static void add_stack_record_to_list(struct stack_record *stack_record,
>  	gfp_mask &= (GFP_ATOMIC | GFP_KERNEL);
>  	gfp_mask |= __GFP_NOWARN;
>  
> +	set_current_in_page_owner();
>  	stack = kmalloc(sizeof(*stack), gfp_mask);
> -	if (!stack)
> +	if (!stack) {
> +		unset_current_in_page_owner();
>  		return;
> +	}
> +	unset_current_in_page_owner();
>  
>  	stack->stack_record = stack_record;
>  	stack->next = NULL;


