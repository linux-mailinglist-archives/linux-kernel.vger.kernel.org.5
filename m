Return-Path: <linux-kernel+bounces-88635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C59D386E4A1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2851F26565
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BDE70AD7;
	Fri,  1 Mar 2024 15:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OC0qNVoZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jyC/HNgI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RTnMNSFG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dU4opQGH"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB57F39846
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 15:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709308024; cv=none; b=qG3YxYWXYsvB21RUdYP2L26rJnUmceUlDngJGBo9DlELRVZ7DcUZWkfwDzLE91c1TZ0rrjWsGIOK12aeKToOhtixjzgIL8FTrzrP2q2EXSC2FvhMGxtEZgUVqj2mraKw+UOtH0o5NrHT3AiUPclUm4mBpHNnoFaGP8xGMvDfUgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709308024; c=relaxed/simple;
	bh=mSpA9QeMIDTM3naGVSFzrcWhKYfr37Rc0rwjjtZe14k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AJyBQze0FNIJVI0/mtCr8TbnfwfOG1uR7gy2xwVDmmINUgq4+n71DQWk3V8Z7el5Fh0KLh2Q4NlcgrgT9ovwNOrBuvLENt1yT9InsfILCJc7ROLyv9gzdTmsz3M/7sDw/1XC66kQq7ps7D1RX00q4rr8b+UWMFAC2NrfEtdvrDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OC0qNVoZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jyC/HNgI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RTnMNSFG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dU4opQGH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 82F3E33C1D;
	Fri,  1 Mar 2024 15:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709308017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XlsPmO0fYs6SV3Rau9KRVldMtwtUf8pufWAUkARxZXc=;
	b=OC0qNVoZ+k9G46etcUxkDUZR0vndVc6ZWhzmyZh35km3jWHLlxNcWjeRQN5wA1WT/cYjKT
	VoO35WagYG+I2iGwrrHhbWFfynDoaqGi4QP5G5rXvTaRGUCMSZGFPRkL/6kzBM36j4kbyQ
	PoFb3GEq2FIjte1iB0qJTPRUe90FZ48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709308017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XlsPmO0fYs6SV3Rau9KRVldMtwtUf8pufWAUkARxZXc=;
	b=jyC/HNgItckgoR/hI5xTj/QUOoG9qu3++IWRcOxopMjHrTmZb2oK4O1k1YT1kD6v6ThI8J
	UG2oNPl/h0nxnUBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709308015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XlsPmO0fYs6SV3Rau9KRVldMtwtUf8pufWAUkARxZXc=;
	b=RTnMNSFGIC3SZNc48wg1ezIQpnd5FM703bbBzlXGQt7a1Su3o7ITdIxV22cho5GvEKnvL4
	qAFbxIfW7cw2JMp+3cXKzhDq0eYk9Cfn8OlUzFWZX21D+8jdlO/vgiwiZUsvxfk4VdM74M
	JE5allTLXG9yGgYaOAn1/3h0gLrfpsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709308015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XlsPmO0fYs6SV3Rau9KRVldMtwtUf8pufWAUkARxZXc=;
	b=dU4opQGHMtCz9ljRUmzqo3IGUzMT0LBKW13pODYCPdTnjpr2uTT3Znm/dBzY3g1CjJ17BY
	fkQWOuZzB4IonEAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6920113A80;
	Fri,  1 Mar 2024 15:46:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T349GW/44WXvAwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 01 Mar 2024 15:46:55 +0000
Message-ID: <abf77db9-afb1-4ce8-bb23-5a98b18096b5@suse.cz>
Date: Fri, 1 Mar 2024 16:46:55 +0100
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
	none
X-Spam-Level: 
X-Spam-Score: 0.21
X-Spamd-Result: default: False [0.21 / 50.00];
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
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 BAYES_HAM(-0.00)[20.91%];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:email];
	 FREEMAIL_TO(0.00)[windriver.com,linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On 2/28/24 04:04, Xiaolei Wang wrote:
> For earlier kmem cache creation, slab_sysfs_init() has not been called.
> Consequently, kmem_cache_destroy() cannot utilize kobj_type::release to
> release the kmem_cache structure. Therefore, tweak kmem_cache_release()
> to use slab_kmem_cache_release() for releasing kmem_cache when slab_state
> isn't FULL. This will fixes the memory leaks like following:
> 
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

Thanks, added to slab/for-next

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


