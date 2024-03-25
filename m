Return-Path: <linux-kernel+bounces-116704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8867E88A2C2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F721C36058
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34BC136E12;
	Mon, 25 Mar 2024 10:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="miKh7Uc9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vyi52dy2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="miKh7Uc9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vyi52dy2"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4A367A1A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711355845; cv=none; b=KWcPiSie2zusjPRXOPuc1bkkXEd/bNFKxTXL4MMPaHpliHJ7yZEDG/B3w9COXX1a/zt7B5FJhaDixKsT3+qXWJ8uIcbPPE9fH9CSmit8m73JJLG0v9vFv+F7tgRKhFF8eG9L7wuxrf4GDwu2KMTJQ6GwjA0jOSID/0TbL6nMeiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711355845; c=relaxed/simple;
	bh=DZEY33ELCrX3XxyJob4OURhuX65fNk8+JowzAS0zJ0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V950C/Mb+Vi42m0U26HWeY0NbDu3DDSMPrIUS/r8PvDEHjRR7yere6QuVqr5T/qT4rpJBqq7JojidmH2qdgX4CnGHlk0N6G/tPnsZbAYtvO56kt2ZpKbB4MHfUOlNk8wVSlN53BebQoQgFEFk0StH2nNuFYARfPU1A3iy3YsI9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=miKh7Uc9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vyi52dy2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=miKh7Uc9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vyi52dy2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D09CF20ACD;
	Mon, 25 Mar 2024 08:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711355841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WFQLPMdnm6Vb5R5hL3AhD23eFZIrDhtHvEGc7c8NawQ=;
	b=miKh7Uc9Go2lsd+lz6z5odw8nBqRC9SMVAgYW7Mm9Ie6Wjli4cWp8XYQzuoXfPu3T5eErF
	T7B/igWffe6Xj1iy4g8tuL+m9lM6wzTqPa954PvDjOEDuW7cCi+TEuWQCNhHKUP7fUjh2E
	+smQQzbC96K7v0LlFXFbkw9U5mwXynA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711355841;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WFQLPMdnm6Vb5R5hL3AhD23eFZIrDhtHvEGc7c8NawQ=;
	b=vyi52dy2jR9n1ZjsDFypwWY5JKlHtTsfDXNVZaTGvO/5mJ3r4DUAcOxb7CgCNSeeVxNoKp
	/sWqbPTAoJRPPRAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711355841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WFQLPMdnm6Vb5R5hL3AhD23eFZIrDhtHvEGc7c8NawQ=;
	b=miKh7Uc9Go2lsd+lz6z5odw8nBqRC9SMVAgYW7Mm9Ie6Wjli4cWp8XYQzuoXfPu3T5eErF
	T7B/igWffe6Xj1iy4g8tuL+m9lM6wzTqPa954PvDjOEDuW7cCi+TEuWQCNhHKUP7fUjh2E
	+smQQzbC96K7v0LlFXFbkw9U5mwXynA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711355841;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WFQLPMdnm6Vb5R5hL3AhD23eFZIrDhtHvEGc7c8NawQ=;
	b=vyi52dy2jR9n1ZjsDFypwWY5JKlHtTsfDXNVZaTGvO/5mJ3r4DUAcOxb7CgCNSeeVxNoKp
	/sWqbPTAoJRPPRAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DFA013503;
	Mon, 25 Mar 2024 08:37:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pK42JsE3AWaxIgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 25 Mar 2024 08:37:21 +0000
Message-ID: <a3413438-ca3a-4248-8b00-c59ce3808474@suse.cz>
Date: Mon, 25 Mar 2024 09:37:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next] mm/slub: remove dummy slabinfo functions
To: Xiu Jianfeng <xiujianfeng@huaweicloud.com>, cl@linux.com,
 penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
 akpm@linux-foundation.org, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, xiujianfeng@huawei.com
References: <20240321131733.268615-1-xiujianfeng@huaweicloud.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240321131733.268615-1-xiujianfeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.79
X-Spamd-Result: default: False [-2.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.990];
	 BAYES_HAM(-3.00)[100.00%];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email];
	 FREEMAIL_TO(0.00)[huaweicloud.com,linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On 3/21/24 2:17 PM, Xiu Jianfeng wrote:
> From: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> The SLAB implementation has been removed since 6.8, so there is no
> other version of slabinfo_show_stats() and slabinfo_write(), then we
> can remove these two dummy functions.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Thanks, added to slab/for-6.10/cleanup

> ---
> v2: correct removed version
> ---
>  mm/slab.h        |  3 ---
>  mm/slab_common.c |  2 --
>  mm/slub.c        | 10 ----------
>  3 files changed, 15 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index d2bc9b191222..78e205b46e19 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -496,9 +496,6 @@ struct slabinfo {
>  };
>  
>  void get_slabinfo(struct kmem_cache *s, struct slabinfo *sinfo);
> -void slabinfo_show_stats(struct seq_file *m, struct kmem_cache *s);
> -ssize_t slabinfo_write(struct file *file, const char __user *buffer,
> -		       size_t count, loff_t *ppos);
>  
>  #ifdef CONFIG_SLUB_DEBUG
>  #ifdef CONFIG_SLUB_DEBUG_ON
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index f5234672f03c..67c03d6bd26c 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1078,7 +1078,6 @@ static void cache_show(struct kmem_cache *s, struct seq_file *m)
>  		   sinfo.limit, sinfo.batchcount, sinfo.shared);
>  	seq_printf(m, " : slabdata %6lu %6lu %6lu",
>  		   sinfo.active_slabs, sinfo.num_slabs, sinfo.shared_avail);
> -	slabinfo_show_stats(m, s);
>  	seq_putc(m, '\n');
>  }
>  
> @@ -1155,7 +1154,6 @@ static const struct proc_ops slabinfo_proc_ops = {
>  	.proc_flags	= PROC_ENTRY_PERMANENT,
>  	.proc_open	= slabinfo_open,
>  	.proc_read	= seq_read,
> -	.proc_write	= slabinfo_write,
>  	.proc_lseek	= seq_lseek,
>  	.proc_release	= seq_release,
>  };
> diff --git a/mm/slub.c b/mm/slub.c
> index 1bb2a93cf7b6..cc7e68fbdbba 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -7099,14 +7099,4 @@ void get_slabinfo(struct kmem_cache *s, struct slabinfo *sinfo)
>  	sinfo->objects_per_slab = oo_objects(s->oo);
>  	sinfo->cache_order = oo_order(s->oo);
>  }
> -
> -void slabinfo_show_stats(struct seq_file *m, struct kmem_cache *s)
> -{
> -}
> -
> -ssize_t slabinfo_write(struct file *file, const char __user *buffer,
> -		       size_t count, loff_t *ppos)
> -{
> -	return -EIO;
> -}
>  #endif /* CONFIG_SLUB_DEBUG */


