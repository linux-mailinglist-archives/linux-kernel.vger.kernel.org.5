Return-Path: <linux-kernel+bounces-109903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE431885789
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5501D1F2212D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785CB56B9C;
	Thu, 21 Mar 2024 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BbPO6PGh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n26LMD+u";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QXQXMhSU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T+Ezg7cD"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B630A56766
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711017422; cv=none; b=ZaBlgkSy6g/zJafFZWWb/0d12H2y2uH8islTfL4aO3/VJe3AsCATkBuMEay9NchX5ThiD5T85eELOGRxFLOp/3MWL1tNPEEcLMDds2xWTi+inWMeTFdFnDYS4AOLTNXT325gCp75KonsQ2xUF+4kHZesGSZkesYt/EBOASqlzfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711017422; c=relaxed/simple;
	bh=7i50QrITbUsGiZ+KpquvMbAgXC7O2jDc5g3kQXOAhkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/1mc5CjbhIYneIPGNWdKT1DdwA2SxFGbJpj00opwkCt6fL78+G2fSTPBH8r7p0sqJfdjb70V/k56XRRSS6jg1bJVNasxzN4ON+ZxSzU/dE/VjopElbtQLxRs448ewocdk1VBdF3kj0dDts5SIGHw8cXKRU+apWnfAndeXWAuwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BbPO6PGh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n26LMD+u; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QXQXMhSU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T+Ezg7cD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 01CD05CC60;
	Thu, 21 Mar 2024 10:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711017419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qrUdzGmZxUrHcwBEsnHbHsFb6putT1o5r8sGWCVKxZE=;
	b=BbPO6PGh3EgaMNUVfDcWNqgrBPxVoHeBGq+cDiTyeqGO7bpV4QkaMrHfxIwF37VLoa62AG
	1kUUVX5uRiAtTDrAqsF8s0P/xQtuDrcNXVRwgkMbIkM+Xh2rqFygQnd4DeSj+tBJeBngVg
	ruZjXMovT8N2pLmYJ1lSalnBWUA0GqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711017419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qrUdzGmZxUrHcwBEsnHbHsFb6putT1o5r8sGWCVKxZE=;
	b=n26LMD+uKQ5LYmwOgYlz3/RzWELw/fdblv83H0njtvrAsU8h04OI4+26z/XnGZItZsjIwU
	yadLNY+CtzmhdGAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711017418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qrUdzGmZxUrHcwBEsnHbHsFb6putT1o5r8sGWCVKxZE=;
	b=QXQXMhSUoTyMOk6lCDl8D4amQh693Fkn/Qm1D4p1cwrRvavAmfzglSnbhPsMKLYtz7cGqK
	RhxZIpBaAflapVNvPnUjVfRgb7+op4tUe5W2+srZPQxjXX5pcCYpwLhHZCaRbm4cdcqACu
	lb7bOXMqfXyC/jLeqMbAdQlusxZfb28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711017418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qrUdzGmZxUrHcwBEsnHbHsFb6putT1o5r8sGWCVKxZE=;
	b=T+Ezg7cDMAgwTycg3GetI6HynCAGs7mkbKj2I8iu0LgVsmeCZg5C8DAzmhw4ZGCQaG8cN0
	zWX494RdbUryQuCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCA06136AD;
	Thu, 21 Mar 2024 10:36:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id azc/NckN/GVtIQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 21 Mar 2024 10:36:57 +0000
Message-ID: <71e4b82b-8f32-41f1-afd1-5238e88bf0e7@suse.cz>
Date: Thu, 21 Mar 2024 11:36:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm,page_owner: Fix refcount imbalance
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Michal Hocko <mhocko@suse.com>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 syzbot+41bbfdb8d41003d12c0f@syzkaller.appspotmail.com
References: <20240319183212.17156-1-osalvador@suse.de>
 <20240319183212.17156-2-osalvador@suse.de>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240319183212.17156-2-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.79
X-Spamd-Result: default: False [-2.79 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[41bbfdb8d41003d12c0f];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,google.com,gmail.com,i-love.sakura.ne.jp,syzkaller.appspotmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

On 3/19/24 19:32, Oscar Salvador wrote:
> Current code does not contemplate scenarios were an allocation and
> free operation on the same pages do not handle it in the same amount
> at once.
> To give an example, page_alloc_exact(), where we will allocate a page
> of enough order to stafisfy the size request, but we will free the
> remainings right away.
> 
> In the above example, we will increment the stack_record refcount
> only once, but we will decrease it the same number of times as number
> of unused pages we have to free.
> This will lead to a warning because of refcount imbalance.
> 
> Fix this by recording the number of base pages in the refcount field.
> 
> Reported-by: syzbot+41bbfdb8d41003d12c0f@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-mm/00000000000090e8ff0613eda0e5@google.com
> Fixes: 217b2119b9e2 ("mm,page_owner: implement the tracking of the stacks count")
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

With the fixup,

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

But I think you'll need to resend with the missing hunk already applied, it
had broken whitespace in your email and IIUC this is was dropped from mm tree.

Also I'd suggest a change:

> +++ b/mm/page_owner.c
> @@ -196,9 +196,11 @@ static void add_stack_record_to_list(struct stack_record *stack_record,
>  	spin_unlock_irqrestore(&stack_list_lock, flags);
>  }
>  
> -static void inc_stack_record_count(depot_stack_handle_t handle, gfp_t gfp_mask)
> +static void inc_stack_record_count(depot_stack_handle_t handle, gfp_t gfp_mask,
> +				   int nr_base_pages)
>  {
>  	struct stack_record *stack_record = __stack_depot_get_stack_record(handle);
> +	int old = REFCOUNT_SATURATED;
>  
>  	if (!stack_record)
>  		return;
> @@ -210,22 +212,18 @@ static void inc_stack_record_count(depot_stack_handle_t handle, gfp_t gfp_mask)
>  	 * Since we do not use STACK_DEPOT_FLAG_GET API, let us
>  	 * set a refcount of 1 ourselves.
>  	 */
> -	if (refcount_read(&stack_record->count) == REFCOUNT_SATURATED) {
> -		int old = REFCOUNT_SATURATED;

I think this was useful optimization in that most cases the count is not
REFCOUNT_SATURATED so we don't have to go for the expensive cmpxchg all the
time. Or do I miss a reason why this was changed?

> -
> -		if (atomic_try_cmpxchg_relaxed(&stack_record->count.refs, &old, 1))
> -			/* Add the new stack_record to our list */
> -			add_stack_record_to_list(stack_record, gfp_mask);
> -	}
> -	refcount_inc(&stack_record->count);
> +	if (atomic_try_cmpxchg_relaxed(&stack_record->count.refs, &old, 1))
> +		add_stack_record_to_list(stack_record, gfp_mask);
> +	refcount_add(nr_base_pages, &stack_record->count);
>  }
>  


