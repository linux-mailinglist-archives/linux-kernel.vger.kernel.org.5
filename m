Return-Path: <linux-kernel+bounces-84614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF32286A908
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6151F2482A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1F324B4A;
	Wed, 28 Feb 2024 07:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JHupWgBj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ixu5VBa1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KPvuFSE8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="asXayAvQ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3460724B2A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 07:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709105647; cv=none; b=oFXDkhX6AqxysEIwnxYweLMlUCdyuz1X5YVBPD2dx8P8FDVrtkct6uLPIU1IaxkPg3x0krXQXC3iQisxZ+t1O7WtgCYe4sTssRhdJUkVWrlF+inFIrqljrgTpBl+XDPcB8d1y8DuyVyq85/gSELcKg1fHqLDDDySl4y6qms7QVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709105647; c=relaxed/simple;
	bh=tdDvgiy8X8lnCdeKkV6NHw4CMK1Fk9sPi5iB9X0MBpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=scu5GdpM8XkqphWmzRjKKHVelQvESnITUoHNxnk+tx3O6CgvzhzQPLLelKTftcY0w3mk486nMLDdMVkiy2OWqY2o5HVk4lpQJ1qgoyN48XLCzoeRS0ym8f72RVxnKlC+Zw/mqrkjr8cJaERN4rOeDt8fYYcfs/MTbMPGPYiXJ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JHupWgBj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ixu5VBa1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KPvuFSE8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=asXayAvQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EEFB722629;
	Wed, 28 Feb 2024 07:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709105643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3LGzcqdUbWrUK1m7X7UOq9Nhx08BLmfyHuXvzkmxkM=;
	b=JHupWgBjEBJmo+JDVbK8fWllVwHxJU/i8Ffni5FWDaF9+Fy6WAgzOWdOcWgCrLAdZUpBqS
	AxitScqVQst9xqXcdRF5YJr+XyE+LrV5XwnasqnuSnZGG8/rcsXTJ0qquo9PJEvMDnBk46
	p+Ll4ybR5fSp7PO7JSsbq3ymxrD+nLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709105643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3LGzcqdUbWrUK1m7X7UOq9Nhx08BLmfyHuXvzkmxkM=;
	b=ixu5VBa1f8NYrwhfdeSht1EYBLeAEbY7Tzw2L0lgvompxa4vsmROSgDFaGdfaqBi1oXnXu
	Jeef1q8hSkdxmnAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709105641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3LGzcqdUbWrUK1m7X7UOq9Nhx08BLmfyHuXvzkmxkM=;
	b=KPvuFSE8rukyjepDCC0pQX38Zy6VGSFg5OSSYUumDOgkOZBWaR1b6OK47TO7bL4RX+Ma9D
	oEaDQJi/H27a/QP+pij764buHVekBpmDNXuhMJti9B61ttYmqrCRupQDu6ZT5i2u966bMq
	eGkpbqc/Ta4ytZnzTaPr5pTn/Kb8bSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709105641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3LGzcqdUbWrUK1m7X7UOq9Nhx08BLmfyHuXvzkmxkM=;
	b=asXayAvQezsfrfzn2cp5BgtQp9DedUPHih+W2KBjgMoQ66f+GtLsBYAf2dvAUPCupDDOEV
	6Vvolxem+n9MJQCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6C2A13AAA;
	Wed, 28 Feb 2024 07:34:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QHHyL+jh3mWKEQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 28 Feb 2024 07:34:00 +0000
Message-ID: <303e28cb-9c9e-470c-bee2-b7cf4b12e810@suse.cz>
Date: Wed, 28 Feb 2024 08:34:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slab: Fix a kmemleak in kmem_cache_destroy()
To: Xiaolei Wang <xiaolei.wang@windriver.com>, cl@linux.com,
 penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
 akpm@linux-foundation.org, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240228030408.2740647-1-xiaolei.wang@windriver.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240228030408.2740647-1-xiaolei.wang@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KPvuFSE8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=asXayAvQ
X-Spamd-Result: default: False [1.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-0.00)[23.01%];
	 MID_RHS_MATCH_FROM(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:email,suse.cz:dkim];
	 FREEMAIL_TO(0.00)[windriver.com,linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.20
X-Rspamd-Queue-Id: EEFB722629
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

On 2/28/24 04:04, Xiaolei Wang wrote:
> For earlier kmem cache creation, slab_sysfs_init() has not been called.
> Consequently, kmem_cache_destroy() cannot utilize kobj_type::release to
> release the kmem_cache structure. Therefore, tweak kmem_cache_release()
> to use slab_kmem_cache_release() for releasing kmem_cache when slab_state
> isn't FULL. This will fixes the memory leaks like following:

So do I understand correctly the leak happens when a cache is destroyed
while slab_state < FULL? Do we ever destroy a cache that early?

> unreferenced object 0xffff0000c2d87080 (size 128):
>    comm "swapper/0", pid 1, jiffies 4294893428
>    hex dump (first 32 bytes):
>      00 00 00 00 ad 4e ad de ff ff ff ff 6b 6b 6b 6b .....N......kkkk
>      ff ff ff ff ff ff ff ff b8 ab 48 89 00 80 ff ff.....H.....
>    backtrace (crc 8819d0f6):
>      [<ffff80008317a298>] kmemleak_alloc+0xb0/0xc4
>      [<ffff8000807e553c>] kmem_cache_alloc_node+0x288/0x3a8
>      [<ffff8000807e95f0>] __kmem_cache_create+0x1e4/0x64c
>      [<ffff8000807216bc>] kmem_cache_create_usercopy+0x1c4/0x2cc
>      [<ffff8000807217e0>] kmem_cache_create+0x1c/0x28
>      [<ffff8000819f6278>] arm_v7s_alloc_pgtable+0x1c0/0x6d4
>      [<ffff8000819f53a0>] alloc_io_pgtable_ops+0xe8/0x2d0
>      [<ffff800084b2d2c4>] arm_v7s_do_selftests+0xe0/0x73c
>      [<ffff800080016b68>] do_one_initcall+0x11c/0x7ac
>      [<ffff800084a71ddc>] kernel_init_freeable+0x53c/0xbb8
>      [<ffff8000831728d8>] kernel_init+0x24/0x144
>      [<ffff800080018e98>] ret_from_fork+0x10/0x20
> 
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
>  mm/slab_common.c | 8 ++++++--
>  mm/slub.c        | 6 ++----
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 238293b1dbe1..b6b35bcdd196 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -404,8 +404,12 @@ EXPORT_SYMBOL(kmem_cache_create);
>   */
>  static void kmem_cache_release(struct kmem_cache *s)
>  {
> -	sysfs_slab_unlink(s);
> -	sysfs_slab_release(s);
> +	if (slab_state >= FULL) {
> +		sysfs_slab_unlink(s);
> +		sysfs_slab_release(s);
> +	} else {
> +		slab_kmem_cache_release(s);
> +	}
>  }
>  #else
>  static void kmem_cache_release(struct kmem_cache *s)
> diff --git a/mm/slub.c b/mm/slub.c
> index 2ef88bbf56a3..9ba59d064b6d 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6792,14 +6792,12 @@ static int sysfs_slab_add(struct kmem_cache *s)
>  
>  void sysfs_slab_unlink(struct kmem_cache *s)
>  {
> -	if (slab_state >= FULL)
> -		kobject_del(&s->kobj);
> +	kobject_del(&s->kobj);
>  }
>  
>  void sysfs_slab_release(struct kmem_cache *s)
>  {
> -	if (slab_state >= FULL)
> -		kobject_put(&s->kobj);
> +	kobject_put(&s->kobj);
>  }
>  
>  /*


