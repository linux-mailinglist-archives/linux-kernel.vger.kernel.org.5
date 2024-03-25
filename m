Return-Path: <linux-kernel+bounces-116715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9017B88A2CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4531C39363
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FCE5C83;
	Mon, 25 Mar 2024 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VGwolsAz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rzLb8OnV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k1GzKVvx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ePNDNeqq"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA08D1292D2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711356487; cv=none; b=l2PZk4hRnuabvyh8dOQMp+8FuMqziMf960Uxu8KxTNzBCE9DOg+If3aKd5if4xSG0LM1uwSA8M5KeVN+j0+rwDhfl7TWUoDg4Dh94otg0x6FB/Ko86dHeDoQeoITHtkm3tdXUe5Fh5+UqPPu21+nLLY7KLJ4mOMjXq9x8lhrvoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711356487; c=relaxed/simple;
	bh=Y2V2lDPB8c0lqfJfWoRMPnzYxJksB+we6Ivu66REzwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q7ToN37OtqcVzep83Y2V5sxGmnlY1oiGml62dUOH7Zs9jvYFu3ie30oT5NpAF81+/xQkBaUA6X6+Q1+1FFBsxGFOOQqKcGao/6jpRJbVQvc3KXzZRABo/SMqzyqwKDzElHkf/bwNH9ABO9sATizq1ENciHOO/K704H/W/WG78Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VGwolsAz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rzLb8OnV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k1GzKVvx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ePNDNeqq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D7DDA33E03;
	Mon, 25 Mar 2024 08:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711356484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UoLCbiPNyGOCHEsF3WOBCQJ3VKUAUZzDN/UCGvN0Zj4=;
	b=VGwolsAztygtZMuYItfZ+0R2WVWT49VOhj3P2tSEWO3FhFAlKXyamNnbbwCnmvyvWgOoz3
	ArQoG3KFenhBOrtxdryHfi3LvymSNLIVMgIqC0gIRi1AYqbvza0UPjTU8oi9+Kebo7WOpF
	ZMrIm3o7Hkicna6zDM7jSLVv+6aKcWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711356484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UoLCbiPNyGOCHEsF3WOBCQJ3VKUAUZzDN/UCGvN0Zj4=;
	b=rzLb8OnVM4UQYwsqzOlyIHVkGC0UTYidqikF9YmGp/wDkCHE0NAFilCAzsoojXO1QY0KNi
	wy2GfO+sI9uGMwAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711356483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UoLCbiPNyGOCHEsF3WOBCQJ3VKUAUZzDN/UCGvN0Zj4=;
	b=k1GzKVvxSSHpmH4xdmdl8I6qFrViYgKLzPnlatUszjAq+8mccB8Nb5VmDR4hJqGcJHHS8z
	h/VJSFxmaraQecB93ajg0jeq/UsR2AfwVBqmKDPwhIj8PiVk7+JuucrN9mQ198TZrbjrSk
	mkWttivOGd0l3surpUB2i8sq4qXn4CM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711356483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UoLCbiPNyGOCHEsF3WOBCQJ3VKUAUZzDN/UCGvN0Zj4=;
	b=ePNDNeqq9ZILfs2PqwJqT9YgZaAme/yqjfoFR21dHP5WLQRLpZ4P92F5lOYtXQmro+9exh
	IpD/6g1a9+CKMjDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B924613503;
	Mon, 25 Mar 2024 08:48:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id voyyLEM6AWYRJQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 25 Mar 2024 08:48:03 +0000
Message-ID: <8b146695-4ff5-4f9a-ab64-6cbed4168f98@suse.cz>
Date: Mon, 25 Mar 2024 09:48:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/slub: mark racy accesses on slab->slabs
Content-Language: en-US
To: linke li <lilinke99@qq.com>
Cc: xujianhao01@gmail.com, Chengming Zhou <chengming.zhou@linux.dev>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <tencent_909E215498A54E4E100E456A92A7F13DAD06@qq.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <tencent_909E215498A54E4E100E456A92A7F13DAD06@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.79
X-Spamd-Result: default: False [-2.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,qq.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email];
	 FREEMAIL_TO(0.00)[qq.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmail.com,linux.dev,linux.com,kernel.org,google.com,lge.com,linux-foundation.org,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On 3/21/24 4:48 AM, linke li wrote:
> The reads of slab->slabs are racy because it may be changed by
> put_cpu_partial concurrently. In slabs_cpu_partial_show() and 
> show_slab_objects(), slab->slabs is only used for showing information.
> 
> Data-racy reads from shared variables that are used only for diagnostic
> purposes should typically use data_race(), since it is normally not a
> problem if the values are off by a little.
> 
> This patch is aimed at reducing the number of benign races reported by
> KCSAN in order to focus future debugging effort on harmful races.
> 
> Signed-off-by: linke li <lilinke99@qq.com>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Chengming provided feedback to v1 but not offered a Reviewed-by: AFAICS? Or
maybe will offer it now? :)

Vlastimil

> ---
>  mm/slub.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 2ef88bbf56a3..0d700f6ca547 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6052,7 +6052,7 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
>  				else if (flags & SO_OBJECTS)
>  					WARN_ON_ONCE(1);
>  				else
> -					x = slab->slabs;
> +					x = data_race(slab->slabs);
>  				total += x;
>  				nodes[node] += x;
>  			}
> @@ -6257,7 +6257,7 @@ static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
>  		slab = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
>  
>  		if (slab)
> -			slabs += slab->slabs;
> +			slabs += data_race(slab->slabs);
>  	}
>  #endif
>  
> @@ -6271,7 +6271,7 @@ static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
>  
>  		slab = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
>  		if (slab) {
> -			slabs = READ_ONCE(slab->slabs);
> +			slabs = data_race(slab->slabs);
>  			objects = (slabs * oo_objects(s->oo)) / 2;
>  			len += sysfs_emit_at(buf, len, " C%d=%d(%d)",
>  					     cpu, objects, slabs);


