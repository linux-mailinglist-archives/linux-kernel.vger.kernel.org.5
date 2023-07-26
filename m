Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C2F762B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjGZGRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjGZGQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:16:27 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65450272A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:16:11 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1bbaa549bcbso738264fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690352170; x=1690956970;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ernir9u51/wgEye25LX0mupcEC1sFM0DouRjZV8wYio=;
        b=mt0UlGQ+pmHA4qsqZUGV/XJMAnbmqyj7W4s+pzNrncfLZ7ChSjR4TPLMFahkrUdNPS
         pREQHpbS1fqUtiUTovbKERHPbh6y1752E1KyEmRuwfFu0Y4v8Js2vepTAsx7AgB52Uxp
         x4ZPwdtT90KwoXfBSGPnH3vbd4a63QxanuH1cQDJKgp3LkADl02PlaTux9pD8umzu92d
         plCQiKPT41d4QhEIy1VpswauWNAvF6i+gk8TJ20lMzIUCOUP6LR3Itn+4pdr1L+YWIkO
         NbRdjovP5A3CT48I1aiDQw/Ffg997BQuRckM85Io9cw0VOixd1cGAI2bEq1+Ci2nHeXL
         1/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690352170; x=1690956970;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ernir9u51/wgEye25LX0mupcEC1sFM0DouRjZV8wYio=;
        b=VKwwI+LFzDrh0UVdN7cmXJxck2rDqhF3PcBhpvFfDyuXIMK9EhMAcDFX2cfGolbR7W
         1M5ZtQ0/WFjJUl1ugOdIawlkt6UEpzIo4CbMRxYuZ3pp48fO7FZHY2/HsNN8yocYn0EX
         GSYbgy55LjL8Oxl+1sKGDlPScYSIDQ5o3FhvEgahw6WHcgbjdr2X0Z9Q4JG24XrVpXks
         wzNLNhcc4YZ6YFPaBvVrfnsTTfY2Zm3lXsh8D8jaH2oGBMuwaSyGaLSvDtaObSKSGeOY
         VQ3nsCYP6nAx9IaPuc0hI8XrF+YtMB+dzKncM/B0QbMfBtSAvnTO7cAR9PRiV3KF+Deo
         jB6Q==
X-Gm-Message-State: ABy/qLYSaOZ/ksxz3HLyfR2HsY+lD6rcCfuBKikq1QtifVn5G1NfP7Kg
        /weiSJr+GMD2LFQ7VWIOot4A9hawiv7r+4MB
X-Google-Smtp-Source: APBJJlHbQ9CllM7PkHL9SiMMNcT+1jT3DpoYfjjxzgjrSEyUIazflX54y7Z8vXRECvLCSSElJcO8RQ==
X-Received: by 2002:a05:6871:593:b0:1ba:2a58:b15e with SMTP id u19-20020a056871059300b001ba2a58b15emr1490083oan.2.1690352170466;
        Tue, 25 Jul 2023 23:16:10 -0700 (PDT)
Received: from liuchao-VM ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id bn9-20020a056a00324900b00678afd48250sm10551739pfb.218.2023.07.25.23.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 23:16:09 -0700 (PDT)
Date:   Wed, 26 Jul 2023 14:16:05 +0800
From:   Chao Liu <chaoliu719@gmail.com>
To:     Chao Yu <chao@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Liu <liuchao@coolpad.com>
Subject: Re: [PATCH v2] f2fs: introduce two helper functions for the largest
 cached extent
Message-ID: <ZMC6JfDFOo3WrRsC@liuchao-VM>
References: <20230725013607.4134123-1-chaoliu719@gmail.com>
 <16625fbb-3dc0-34d5-ee75-fe010aa0d9ec@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16625fbb-3dc0-34d5-ee75-fe010aa0d9ec@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7ÔÂ 26 09:24, Chao Yu wrote:
> On 2023/7/25 9:36, Chao Liu wrote:
> > From: Chao Liu <liuchao@coolpad.com>
> >
> > This patch is a cleanup:
> > 1. Merge __drop_largest_extent() since it has only one caller.
> > 2. Introduce __unlock_tree_with_checking_largest() and
> >     __drop_largest_extent() to help manage largest and largest_update
> >     in extent_tree.
> >
> > Signed-off-by: Chao Liu <liuchao@coolpad.com>
> > ---
> > v2: Make sure et->largest_updated gets updated within &et->lock.
> >      Thanks to Chao Yu for pointing out.
> > ---
> >   fs/f2fs/extent_cache.c | 66 ++++++++++++++++++++----------------------
> >   fs/f2fs/f2fs.h         |  4 +--
> >   2 files changed, 33 insertions(+), 37 deletions(-)
> >
> > diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> > index 0e2d49140c07f..cfc69621a8a26 100644
> > --- a/fs/f2fs/extent_cache.c
> > +++ b/fs/f2fs/extent_cache.c
> > @@ -19,6 +19,12 @@
> >   #include "node.h"
> >   #include <trace/events/f2fs.h>
> > +static void __drop_largest_extent(struct extent_tree *et)
> > +{
> > +	et->largest.len = 0;
> > +	et->largest_updated = true;
> > +}
> > +
> >   bool sanity_check_extent_cache(struct inode *inode)
> >   {
> >   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> > @@ -35,8 +41,7 @@ bool sanity_check_extent_cache(struct inode *inode)
> >   	/* Let's drop, if checkpoint got corrupted. */
> >   	if (is_set_ckpt_flags(sbi, CP_ERROR_FLAG)) {
> > -		ei->len = 0;
> > -		et->largest_updated = true;
> > +		__drop_largest_extent(et);
>
> __drop_largest_extent_force(et);
>
> >   		return true;
> >   	}
> > @@ -310,6 +315,8 @@ static void __detach_extent_node(struct f2fs_sb_info *sbi,
> >   	if (et->cached_en == en)
> >   		et->cached_en = NULL;
> > +
> > +	/* keep the largest as we can still use it */
>
> The comments doesn't match below code?
>

Sorry for not explaining this earlier.

It's just a hint and has nothing to do with the code below. It
simply explains that we don't need to disable the largest here, which
makes the whole code logic of the largest more clear. :)

If it's not fitting, please let me know, and I'll drop them.

> >   	kmem_cache_free(extent_node_slab, en);
> >   }
> > @@ -385,15 +392,6 @@ static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
> >   	return count - atomic_read(&et->node_cnt);
> >   }
> > -static void __drop_largest_extent(struct extent_tree *et,
> > -					pgoff_t fofs, unsigned int len)
> > -{
> > -	if (fofs < et->largest.fofs + et->largest.len &&
> > -			fofs + len > et->largest.fofs) {
> > -		et->largest.len = 0;
> > -		et->largest_updated = true;
> > -	}
> > -}
>
> What about:
>
> static void __drop_largest_extent_cond(struct extent_tree *et,
> 					pgoff_t fofs, unsigned int len,
> 					bool force)
> {
> 	if (force || (fofs < et->largest.fofs + et->largest.len &&
> 			fofs + len > et->largest.fofs)) {
> 		et->largest.len = 0;
> 		et->largest_updated = true;
> 	}
> }
>
> static void __drop_largest_extent_force(struct extent_tree *et)
> {
> 	__drop_largest_extent_cond(et, 0, 0, true);
> }
>

Thank you. I feel it matches better with the existing code
organization style. Let me apply it in v3.

> >   void f2fs_init_read_extent_tree(struct inode *inode, struct page *ipage)
> >   {
> > @@ -601,6 +599,19 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
> >   	return en;
> >   }
> > +static void __unlock_tree_with_checking_largest(struct extent_tree *et,
> > +						struct inode *inode)
> > +{
> > +	if (et->type == EX_READ && et->largest_updated) {
> > +		et->largest_updated = false;
> > +		write_unlock(&et->lock);
> > +		f2fs_mark_inode_dirty_sync(inode, true);
> > +		return;
> > +	}
> > +
> > +	write_unlock(&et->lock);
> > +}
> > +
> >   static void __update_extent_tree_range(struct inode *inode,
> >   			struct extent_info *tei, enum extent_type type)
> >   {
> > @@ -612,7 +623,6 @@ static void __update_extent_tree_range(struct inode *inode,
> >   	struct rb_node **insert_p = NULL, *insert_parent = NULL;
> >   	unsigned int fofs = tei->fofs, len = tei->len;
> >   	unsigned int end = fofs + len;
> > -	bool updated = false;
> >   	bool leftmost = false;
> >   	if (!et)
> > @@ -636,11 +646,10 @@ static void __update_extent_tree_range(struct inode *inode,
> >   		prev = et->largest;
> >   		dei.len = 0;
> > -		/*
> > -		 * drop largest extent before lookup, in case it's already
> > -		 * been shrunk from extent tree
> > -		 */
> > -		__drop_largest_extent(et, fofs, len);
>
> __drop_largest_extent_cond(et, fofs, len, false);
>
> > +		/* updates may cause largest extent cache to become invalid */
> > +		if (fofs < et->largest.fofs + et->largest.len &&
> > +		    fofs + len > et->largest.fofs)
> > +			__drop_largest_extent(et);
> >   	}
> >   	/* 1. lookup first extent node in range [fofs, fofs + len - 1] */
> > @@ -733,8 +742,7 @@ static void __update_extent_tree_range(struct inode *inode,
> >   		if (dei.len >= 1 &&
> >   				prev.len < F2FS_MIN_EXTENT_LEN &&
> >   				et->largest.len < F2FS_MIN_EXTENT_LEN) {
> > -			et->largest.len = 0;
> > -			et->largest_updated = true;
> > +			__drop_largest_extent(et);
>
> __drop_largest_extent_force(et);
>
> >   			set_inode_flag(inode, FI_NO_EXTENT);
> >   		}
> >   	}
> > @@ -742,10 +750,6 @@ static void __update_extent_tree_range(struct inode *inode,
> >   	if (is_inode_flag_set(inode, FI_NO_EXTENT))
> >   		__free_extent_tree(sbi, et);
> > -	if (et->largest_updated) {
> > -		et->largest_updated = false;
> > -		updated = true;
> > -	}
>
> I guess we'd better keep previous logic.

Ok, I will drop these changes in v3. Ditto for __drop_extent_tree().

>
> >   	goto out_read_extent_cache;
> >   update_age_extent_cache:
> >   	if (!tei->last_blocks)
> > @@ -757,10 +761,7 @@ static void __update_extent_tree_range(struct inode *inode,
> >   		__insert_extent_tree(sbi, et, &ei,
> >   					insert_p, insert_parent, leftmost);
> >   out_read_extent_cache:
> > -	write_unlock(&et->lock);
> > -
> > -	if (updated)
> > -		f2fs_mark_inode_dirty_sync(inode, true);
>
> Ditto,
>
> > +	__unlock_tree_with_checking_largest(et, inode);
> >   }
> >   #ifdef CONFIG_F2FS_FS_COMPRESSION
> > @@ -1092,7 +1093,6 @@ static void __drop_extent_tree(struct inode *inode, enum extent_type type)
> >   {
> >   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> >   	struct extent_tree *et = F2FS_I(inode)->extent_tree[type];
> > -	bool updated = false;
> >   	if (!__may_extent_tree(inode, type))
> >   		return;
> > @@ -1101,14 +1101,10 @@ static void __drop_extent_tree(struct inode *inode, enum extent_type type)
> >   	__free_extent_tree(sbi, et);
> >   	if (type == EX_READ) {
> >   		set_inode_flag(inode, FI_NO_EXTENT);
> > -		if (et->largest.len) {
> > -			et->largest.len = 0;
> > -			updated = true;
> > -		}
> > +		if (et->largest.len)
> > +			__drop_largest_extent(et);
> >   	}
> > -	write_unlock(&et->lock);
> > -	if (updated)
> > -		f2fs_mark_inode_dirty_sync(inode, true);
>
> Ditto,
>
> Thanks,
>
> > +	__unlock_tree_with_checking_largest(et, inode);
> >   }
> >   void f2fs_drop_extent_tree(struct inode *inode)
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index d372bedb0fe4e..da02e120e5ea6 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -665,7 +665,7 @@ struct extent_tree {
> >   struct extent_tree_info {
> >   	struct radix_tree_root extent_tree_root;/* cache extent cache entries */
> > -	struct mutex extent_tree_lock;	/* locking extent radix tree */
> > +	struct mutex extent_tree_lock;		/* locking extent radix tree */
> >   	struct list_head extent_list;		/* lru list for shrinker */
> >   	spinlock_t extent_lock;			/* locking extent lru list */
> >   	atomic_t total_ext_tree;		/* extent tree count */
> > @@ -766,7 +766,7 @@ enum {
> >   	FI_ACL_MODE,		/* indicate acl mode */
> >   	FI_NO_ALLOC,		/* should not allocate any blocks */
> >   	FI_FREE_NID,		/* free allocated nide */
> > -	FI_NO_EXTENT,		/* not to use the extent cache */
> > +	FI_NO_EXTENT,		/* not to use the read extent cache */
> >   	FI_INLINE_XATTR,	/* used for inline xattr */
> >   	FI_INLINE_DATA,		/* used for inline data*/
> >   	FI_INLINE_DENTRY,	/* used for inline dentry */
