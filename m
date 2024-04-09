Return-Path: <linux-kernel+bounces-136957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2373D89DA4C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87C651F21878
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E878136678;
	Tue,  9 Apr 2024 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1/fUEmSe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wUM4KL06";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1/fUEmSe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wUM4KL06"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466DD13541A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669190; cv=none; b=oDr0JbfzbndJWHCwUWQDaOidaAdb6fB9a3ZfwzvlNHm2FtW7/b5tljjdflTpi1wReBr3owxRITvfULoioAxPiWv3ehfFZqXZXutMwSfefi+v/KpEzEKGEOZct2CBuV5c/CEolv01LkXivRpBORbfEO3OjXd8PY/IT7o2zBgkpxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669190; c=relaxed/simple;
	bh=TMtKxl24PYN/bpk3kKRldCGFMaQIXg1N5z48IGM5Wxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JGxf6rNBq5aK1KGfM0dCrATPwKG3INSkA132UDnM5vL0VzH6NUh7WTvNvGAlMQqzBF8F/YjHm1c/zivD/KLNiY5Twf2sso90OfYPYlvoZHkhNzsn3Hsjyr0oiRznqi11UGHfj3VyCWnOb72byT3vdiVDEytSyPTqgumvfB1Ss2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1/fUEmSe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wUM4KL06; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1/fUEmSe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wUM4KL06; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 96750339F6;
	Tue,  9 Apr 2024 13:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712669183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MvS1rJ5mx8pYO7vENhq0cJL3Mk1dX9RkykjtDYlgdds=;
	b=1/fUEmSe/yWXn4yOhZef9JXXB06grucSLWkEzhty23m0DtaWlU/0c/Z76rcXArnEK1I++0
	gnW94TpBssECU05F5uTDAd0EDWIL/eaxPiLL+jYbdrx8B37pHcRx14hOKbhaMv4Xl+zSvc
	b9ElegCpZT6ZER0XexUdK2uM6+X+S70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712669183;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MvS1rJ5mx8pYO7vENhq0cJL3Mk1dX9RkykjtDYlgdds=;
	b=wUM4KL06rtPnKuUWzBGdjnTEGzeZToveQOZg4Ug8V10Zca+0Nn3dnppKU4X2KHbw7e6GGP
	90pOtWBOVrfniFBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712669183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MvS1rJ5mx8pYO7vENhq0cJL3Mk1dX9RkykjtDYlgdds=;
	b=1/fUEmSe/yWXn4yOhZef9JXXB06grucSLWkEzhty23m0DtaWlU/0c/Z76rcXArnEK1I++0
	gnW94TpBssECU05F5uTDAd0EDWIL/eaxPiLL+jYbdrx8B37pHcRx14hOKbhaMv4Xl+zSvc
	b9ElegCpZT6ZER0XexUdK2uM6+X+S70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712669183;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MvS1rJ5mx8pYO7vENhq0cJL3Mk1dX9RkykjtDYlgdds=;
	b=wUM4KL06rtPnKuUWzBGdjnTEGzeZToveQOZg4Ug8V10Zca+0Nn3dnppKU4X2KHbw7e6GGP
	90pOtWBOVrfniFBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89D35136D9;
	Tue,  9 Apr 2024 13:26:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K4JSIf9BFWa0HQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 09 Apr 2024 13:26:23 +0000
Message-ID: <9e0de158-f7b3-4602-8552-f568a96c3c65@suse.cz>
Date: Tue, 9 Apr 2024 15:26:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm,page_owner: Defer enablement of static branch
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20240409131715.13632-1-osalvador@suse.de>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240409131715.13632-1-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-8.29 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Score: -8.29
X-Spam-Flag: NO

On 4/9/24 3:17 PM, Oscar Salvador wrote:
> Kefeng Wang reported that he was seeing some memory leaks with kmemleak
> with page_owner enabled.
> The reason behind is that we enable the page_owner_inited static branch
> and then proceed with the linking of stack_list struct to dummy_stack,
> which means that exists a race window between these two steps where we
> can have pages already being allocated calling add_stack_record_to_list(),
> allocating objects and linking them to stack_list, but then we set
> stack_list pointing to dummy_stack in init_page_owner.
> Which means that the objects that have been allocated during that time
> window are unreferenced and lost.
> 
> Fix this by deferring the enablement of the branch until we have properly
> set up the list.
> 
> Reported-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Closes: https://lore.kernel.org/linux-mm/74b147b0-718d-4d50-be75-d6afc801cd24@huawei.com/
> Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Fixes: 4bedfb314bdd ("mm,page_owner: maintain own list of stack_records structs")

That's in rc1 so ideally mm-hotfixes.

> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
> Special thanks and kudos go to Kefeng Wang for helping me out chasing
> down this bug, as I could not reproduce it with any of my machines, and
> to Vlastimil to bring another pair of eyes, which was very helpful.
> 
>  mm/page_owner.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 9bef0b442863..742f432e5bf0 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -118,7 +118,6 @@ static __init void init_page_owner(void)
>  	register_dummy_stack();
>  	register_failure_stack();
>  	register_early_stack();
> -	static_branch_enable(&page_owner_inited);
>  	init_early_allocated_pages();
>  	/* Initialize dummy and failure stacks and link them to stack_list */
>  	dummy_stack.stack_record = __stack_depot_get_stack_record(dummy_handle);
> @@ -129,6 +128,7 @@ static __init void init_page_owner(void)
>  		refcount_set(&failure_stack.stack_record->count, 1);
>  	dummy_stack.next = &failure_stack;
>  	stack_list = &dummy_stack;
> +	static_branch_enable(&page_owner_inited);
>  }
>  
>  struct page_ext_operations page_owner_ops = {


