Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269D679C3E8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242509AbjILDRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242589AbjILDRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:17:18 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F2258D1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 19:47:23 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bf7b5e1f06so9224005ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 19:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694486842; x=1695091642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NfvEGWDbhOo/S364toZIJ0BhQdCJEFDoaQPD6f/HhMI=;
        b=kvKTN3B555y7t53xkgQbToYdOb0aUDkUJiTrh3lgYWUoTyzqmI3I2ADRpk4lnXZndp
         kTFx/UzLqclTBGNZqkoZodP/BSWixvHdShGQGnVGf1uQsY5rX1rRZmgL9nAqojOl8did
         SfoC3fxkJC21tzm3ReOQv2i8iTkWWTvgxvx8B4JFxcr9xq/DuCz/0QYkznMlRk03HZSt
         N9DA0tQMi14vbVAceB1R/PQzK9INrMv6FxXFePAt56zHWUY1mJRYeqAjfIjKaIpG9MSI
         eHyhaWilBiAbRnwNIcCtVkH0PjrKgQIuMLEIFvGc6J9N97VQNurgQe98/vj93ZXrEZ+Q
         Ivsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694486842; x=1695091642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NfvEGWDbhOo/S364toZIJ0BhQdCJEFDoaQPD6f/HhMI=;
        b=kn2j83GONr5sv/gPEQW4Ko4S8F03KSh4boceI3STrp9AuO1p0vnKP0KRSfMv7DVgx2
         cwoi4S6BsoAqVTPRASzBczEpmlsvDjJ+J57gGHKlTCjQ/Mmpp/Q0p4ANAvlRHwt2NKtf
         QbhmW6HMnPtSITAUrdI9g+5Qw34MIHiVLpX0+uYLy0ge9bdVT9xkahTzlWKBryI3Th6K
         8of3i7pStfvGdLob9TnYR/O7J31048/UtremqejkYy2US6vEUPGpHlJs5HItIipRikZ6
         J5bdn8g8vBx+vCqs0JuosQORW6kMPloKGKZI3sICAH9fz9wsY1/hivbREgh2R+8ukGhN
         KDIw==
X-Gm-Message-State: AOJu0Yz/+aXS2100UmvoUlUi1pNgwF6idkrnwfvJVHTMNUikr6c5eW75
        gm7FphqY1LCdNE5/5bmq5H0rLg==
X-Google-Smtp-Source: AGHT+IGtwigtlc+yswA+x812kGiyEPkeJYniOcEAzIAhOgNBsweHqaSLdkMnCfxVmwzCsPKMZ4Gnfw==
X-Received: by 2002:a17:903:2448:b0:1c1:ee23:bb75 with SMTP id l8-20020a170903244800b001c1ee23bb75mr13145737pls.1.1694486842466;
        Mon, 11 Sep 2023 19:47:22 -0700 (PDT)
Received: from [10.84.155.178] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902bc4800b001bf846dd2ebsm7129710plz.303.2023.09.11.19.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 19:47:21 -0700 (PDT)
Message-ID: <e639a428-0fb7-7329-ce52-e51f7951a146@bytedance.com>
Date:   Tue, 12 Sep 2023 10:47:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: linux-next: build failure after merge of the bcachefs tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230912120429.7852428f@canb.auug.org.au>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230912120429.7852428f@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 2023/9/12 10:04, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the bcachefs tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> fs/bcachefs/btree_cache.c: In function 'bch2_fs_btree_cache_exit':
> fs/bcachefs/btree_cache.c:403:9: error: implicit declaration of function 'unregister_shrinker'; did you mean 'unregister_chrdev'? [-Werror=implicit-function-declaration]
>    403 |         unregister_shrinker(&bc->shrink);
>        |         ^~~~~~~~~~~~~~~~~~~
>        |         unregister_chrdev
> fs/bcachefs/btree_cache.c: In function 'bch2_fs_btree_cache_init':
> fs/bcachefs/btree_cache.c:479:15: error: implicit declaration of function 'register_shrinker'; did you mean 'register_chrdev'? [-Werror=implicit-function-declaration]
>    479 |         ret = register_shrinker(&bc->shrink, "%s/btree_cache", c->name);
>        |               ^~~~~~~~~~~~~~~~~
>        |               register_chrdev
> cc1: all warnings being treated as errors
> 
> Caused by commits
> 
>    5ec30115c066 ("bcachefs: Initial commit")
> 
> interacting with commit
> 
>    eba045d9350d ("mm: shrinker: remove old APIs")
> 
> from v6.6-rc1.
> 
> I have applied the following merge resolution patch for today.  More may
> be needed.

Thanks for doing this! Some needed fixes below.

> 
>  From 801ad185700d9a7abcf156233b9db6cf6d831581 Mon Sep 17 00:00:00 2001
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 12 Sep 2023 11:27:22 +1000
> Subject: [PATCH] bcachefs: convert to dynamically allocated shrinkers
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>   fs/bcachefs/btree_cache.c     | 19 +++++++++++--------
>   fs/bcachefs/btree_key_cache.c | 18 +++++++++++-------
>   fs/bcachefs/btree_types.h     |  4 ++--
>   fs/bcachefs/fs.c              |  2 +-
>   fs/bcachefs/sysfs.c           |  2 +-
>   5 files changed, 26 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/bcachefs/btree_cache.c b/fs/bcachefs/btree_cache.c
> index 245ddd92b2d1..7f0eded6c296 100644
> --- a/fs/bcachefs/btree_cache.c
> +++ b/fs/bcachefs/btree_cache.c
> @@ -285,7 +285,7 @@ static int btree_node_write_and_reclaim(struct bch_fs *c, struct btree *b)
>   static unsigned long bch2_btree_cache_scan(struct shrinker *shrink,
>   					   struct shrink_control *sc)
>   {
> -	struct bch_fs *c = container_of(shrink, struct bch_fs,
> +	struct bch_fs *c = container_of(&shrink, struct bch_fs,
>   					btree_cache.shrink);

The shrink passed in here will be a local variable, so its address can
not be used directly. So need to be modified as follows:

	struct bch_fs *c = shrink->private_data;

>   	struct btree_cache *bc = &c->btree_cache;
>   	struct btree *b, *t;
> @@ -384,7 +384,7 @@ static unsigned long bch2_btree_cache_scan(struct shrinker *shrink,
>   static unsigned long bch2_btree_cache_count(struct shrinker *shrink,
>   					    struct shrink_control *sc)
>   {
> -	struct bch_fs *c = container_of(shrink, struct bch_fs,
> +	struct bch_fs *c = container_of(&shrink, struct bch_fs,
>   					btree_cache.shrink);

Ditto.

>   	struct btree_cache *bc = &c->btree_cache;
>   
> @@ -400,7 +400,7 @@ void bch2_fs_btree_cache_exit(struct bch_fs *c)
>   	struct btree *b;
>   	unsigned i, flags;
>   
> -	unregister_shrinker(&bc->shrink);
> +	shrinker_free(bc->shrink);
>   
>   	/* vfree() can allocate memory: */
>   	flags = memalloc_nofs_save();
> @@ -454,6 +454,7 @@ void bch2_fs_btree_cache_exit(struct bch_fs *c)
>   int bch2_fs_btree_cache_init(struct bch_fs *c)
>   {
>   	struct btree_cache *bc = &c->btree_cache;
> +	struct shrinker *shrink;
>   	unsigned i;
>   	int ret = 0;
>   
> @@ -473,12 +474,14 @@ int bch2_fs_btree_cache_init(struct bch_fs *c)
>   
>   	mutex_init(&c->verify_lock);
>   
> -	bc->shrink.count_objects	= bch2_btree_cache_count;
> -	bc->shrink.scan_objects		= bch2_btree_cache_scan;
> -	bc->shrink.seeks		= 4;
> -	ret = register_shrinker(&bc->shrink, "%s/btree_cache", c->name);
> -	if (ret)
> +	shrink = shrinker_alloc(0, "%s/btree_cache", c->name);
> +	if (!shrink)
>   		goto err;

Here the 'ret' needs to be set to -ENOMEM.

	if (!shrink) {
		ret = -ENOMEM;
		goto err;
	}


> +	bc->shrink = shrink;
> +	shrink->count_objects	= bch2_btree_cache_count;
> +	shrink->scan_objects	= bch2_btree_cache_scan;
> +	shrink->seeks		= 4;

	shrink->private_data = c;

> +	shrinker_register(shrink);
>   
>   	return 0;
>   err:
> diff --git a/fs/bcachefs/btree_key_cache.c b/fs/bcachefs/btree_key_cache.c
> index 505e7c365ab7..88d33690233b 100644
> --- a/fs/bcachefs/btree_key_cache.c
> +++ b/fs/bcachefs/btree_key_cache.c
> @@ -838,7 +838,7 @@ void bch2_btree_key_cache_drop(struct btree_trans *trans,
>   static unsigned long bch2_btree_key_cache_scan(struct shrinker *shrink,
>   					   struct shrink_control *sc)
>   {
> -	struct bch_fs *c = container_of(shrink, struct bch_fs,
> +	struct bch_fs *c = container_of(&shrink, struct bch_fs,
>   					btree_key_cache.shrink);

	struct bch_fs *c = shrink->private_data;

>   	struct btree_key_cache *bc = &c->btree_key_cache;
>   	struct bucket_table *tbl;
> @@ -936,7 +936,7 @@ static unsigned long bch2_btree_key_cache_scan(struct shrinker *shrink,
>   static unsigned long bch2_btree_key_cache_count(struct shrinker *shrink,
>   					    struct shrink_control *sc)
>   {
> -	struct bch_fs *c = container_of(shrink, struct bch_fs,
> +	struct bch_fs *c = container_of(&shrink, struct bch_fs,
>   					btree_key_cache.shrink);

Ditto.

>   	struct btree_key_cache *bc = &c->btree_key_cache;
>   	long nr = atomic_long_read(&bc->nr_keys) -
> @@ -957,7 +957,7 @@ void bch2_fs_btree_key_cache_exit(struct btree_key_cache *bc)
>   	int cpu;
>   #endif
>   
> -	unregister_shrinker(&bc->shrink);
> +	shrinker_free(bc->shrink);
>   
>   	mutex_lock(&bc->lock);
>   
> @@ -1031,6 +1031,7 @@ void bch2_fs_btree_key_cache_init_early(struct btree_key_cache *c)
>   int bch2_fs_btree_key_cache_init(struct btree_key_cache *bc)
>   {
>   	struct bch_fs *c = container_of(bc, struct bch_fs, btree_key_cache);
> +	struct shrinker *shrink;
>   
>   #ifdef __KERNEL__
>   	bc->pcpu_freed = alloc_percpu(struct btree_key_cache_freelist);
> @@ -1043,11 +1044,14 @@ int bch2_fs_btree_key_cache_init(struct btree_key_cache *bc)

	struct bch_fs *c = container_of(bc, struct bch_fs, btree_key_cache);

>   
>   	bc->table_init_done = true;
>   
> -	bc->shrink.seeks		= 0;
> -	bc->shrink.count_objects	= bch2_btree_key_cache_count;
> -	bc->shrink.scan_objects		= bch2_btree_key_cache_scan;
> -	if (register_shrinker(&bc->shrink, "%s/btree_key_cache", c->name))
> +	shrink = shrinker_alloc(0, "%s/btree_key_cache", c->name);
> +	if (!shrink)
>   		return -BCH_ERR_ENOMEM_fs_btree_cache_init;
> +	bc->shrink = shrink;
> +	shrink->seeks		= 0;
> +	shrink->count_objects	= bch2_btree_key_cache_count;
> +	shrink->scan_objects	= bch2_btree_key_cache_scan;

	shrink->private_data = c;

> +	shrinker_register(shrink);
>   	return 0;
>   }
>   
> diff --git a/fs/bcachefs/btree_types.h b/fs/bcachefs/btree_types.h
> index 70398aaa095e..fac0abdaf167 100644
> --- a/fs/bcachefs/btree_types.h
> +++ b/fs/bcachefs/btree_types.h
> @@ -163,7 +163,7 @@ struct btree_cache {
>   	unsigned		used;
>   	unsigned		reserve;
>   	atomic_t		dirty;
> -	struct shrinker		shrink;
> +	struct shrinker		*shrink;
>   
>   	/*
>   	 * If we need to allocate memory for a new btree node and that
> @@ -321,7 +321,7 @@ struct btree_key_cache {
>   	bool			table_init_done;
>   	struct list_head	freed_pcpu;
>   	struct list_head	freed_nonpcpu;
> -	struct shrinker		shrink;
> +	struct shrinker		*shrink;
>   	unsigned		shrink_iter;
>   	struct btree_key_cache_freelist __percpu *pcpu_freed;
>   
> diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> index 48431700b83e..bdc8573631bd 100644
> --- a/fs/bcachefs/fs.c
> +++ b/fs/bcachefs/fs.c
> @@ -1885,7 +1885,7 @@ static struct dentry *bch2_mount(struct file_system_type *fs_type,
>   		sb->s_flags	|= SB_POSIXACL;
>   #endif
>   
> -	sb->s_shrink.seeks = 0;
> +	sb->s_shrink->seeks = 0;
>   
>   	vinode = bch2_vfs_inode_get(c, BCACHEFS_ROOT_SUBVOL_INUM);
>   	ret = PTR_ERR_OR_ZERO(vinode);
> diff --git a/fs/bcachefs/sysfs.c b/fs/bcachefs/sysfs.c
> index 41c6900c34c1..a9f480c26bb4 100644
> --- a/fs/bcachefs/sysfs.c
> +++ b/fs/bcachefs/sysfs.c
> @@ -522,7 +522,7 @@ STORE(bch2_fs)
>   
>   		sc.gfp_mask = GFP_KERNEL;
>   		sc.nr_to_scan = strtoul_or_return(buf);
> -		c->btree_cache.shrink.scan_objects(&c->btree_cache.shrink, &sc);
> +		c->btree_cache.shrink->scan_objects(c->btree_cache.shrink, &sc);
>   	}
>   
>   	if (attr == &sysfs_btree_wakeup)
