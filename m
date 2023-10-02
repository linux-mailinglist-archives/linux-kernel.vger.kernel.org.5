Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9DE7B4B09
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 06:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjJBEgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 00:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJBEf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 00:35:58 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DFEB4
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 21:35:55 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1c735473d1aso30158455ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 21:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696221355; x=1696826155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+QJdTadjS8UJxjgx2mNiZLVXiy8/ENWxPVhe2tdfgqY=;
        b=gzv0z+0hx8Ii0H030RGciwoyuIkl72x3iZa22gAQpyxQAf8tu+WQQjTxRyYEvCijBj
         MCzYfgAVzD+Jp4RePxEldEu8LZHXpOTcwBd3SuPeiQ28VZ3tgFxy0cTpZAa/GxZMjHTw
         9NNasLQGpB9xvPmON2Rl+RhzWuIfLyjdX1VlT8zWicMPCqICojk52NT1AE15RREbb6t2
         okclvxDdtWKc9SmKwaD/X+3j4AGqdTi9Cn6+Kqff9DWPzBO/rbtAbdSyc0nc4V1OY7FB
         DAr8sOCjlO3iDs9xPkhvAUlvTRo2i8f9RY0NuDdcDxuyYh/x9swQ9BHixoX0mlhiRov/
         7mTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696221355; x=1696826155;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+QJdTadjS8UJxjgx2mNiZLVXiy8/ENWxPVhe2tdfgqY=;
        b=VvOGzFOAdMGW3kvDnI+I318IweD4/DFkrR/yJ+w6/4ZcOoaG/y+LpOuUhVbDTPsubN
         RF7W81pID6VX+JMXNRemzoH+8Yuka915sbbTx9yY14nHIzMnR+5w6sp4iM+mdDlsru9E
         EKOQ2SKtwi+HvHF1IE6gQ7G1VKMZo/0eRHsUFNlCA3VEXr9HgXOxcp3ZJOekt71QG2xd
         WHp5sHelxZqJGy1TqzLIHmDKMBqK0EBVSj89NkZmTxhU5LkZ6QcoVD0lsva8BXIUv8h8
         WMZfkKVJ+dapq8VIk8vuEa4F/wIOkGp9EX+S46ws+uXNus91WnI/+3XhVRVT242dhS6a
         2BMQ==
X-Gm-Message-State: AOJu0YyYU50rPuYU8/r9f9d8/ks0PP+CQUE6k182y0XbJJaizyH0nbkR
        0BiEsVKAHAjlAX7XXLUjKYN4riPynHIYMdLFG2E=
X-Google-Smtp-Source: AGHT+IGi7XaUnIoApjJmGGM4nSA7Rar2ynZKxKiTDnf7E5OilAOUT8g+toeKDeeP3+tg4AzHJq3dqw==
X-Received: by 2002:a17:903:2587:b0:1c2:218c:3762 with SMTP id jb7-20020a170903258700b001c2218c3762mr7020364plb.42.1696221355305;
        Sun, 01 Oct 2023 21:35:55 -0700 (PDT)
Received: from [10.0.2.15] ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902768a00b001c7276398f1sm9339272pll.164.2023.10.01.21.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 21:35:54 -0700 (PDT)
Message-ID: <7ce1a9af-e966-2d1e-2e80-bb019a35a22b@gmail.com>
Date:   Mon, 2 Oct 2023 10:05:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] jfs: fix array-index-out-of-bounds in dbFindLeaf
Content-Language: en-US
To:     dave.kleikamp@oracle.com, shaggy@kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+aea1ad91e854d0a83e04@syzkaller.appspotmail.com
References: <20230922120341.10805-1-ghandatmanas@gmail.com>
From:   Manas Ghandat <ghandatmanas@gmail.com>
In-Reply-To: <20230922120341.10805-1-ghandatmanas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

just a friendly ping

On 22/09/23 17:33, Manas Ghandat wrote:
> Currently while searching for dmtree_t for sufficient free blocks there
> is an array out of bounds while getting element in tp->dm_stree. To add
> the required check for out of bound we first need to determine the type
> of dmtree. Thus added an extra parameter to dbFindLeaf so that the type
> of tree can be determined and the required check can be applied.
>
> Reported-by: syzbot+aea1ad91e854d0a83e04@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=aea1ad91e854d0a83e04
> Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
> ---
> V1 -> V2: Updated dbFindLeaf function.
>
>   fs/jfs/jfs_dmap.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index a14a0f18a4c4..cee5164c4879 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -87,7 +87,7 @@ static int dbAllocCtl(struct bmap * bmp, s64 nblocks, int l2nb, s64 blkno,
>   static int dbExtend(struct inode *ip, s64 blkno, s64 nblocks, s64 addnblocks);
>   static int dbFindBits(u32 word, int l2nb);
>   static int dbFindCtl(struct bmap * bmp, int l2nb, int level, s64 * blkno);
> -static int dbFindLeaf(dmtree_t * tp, int l2nb, int *leafidx);
> +static int dbFindLeaf(dmtree_t *tp, int l2nb, int *leafidx, int type);
>   static int dbFreeBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
>   		      int nblocks);
>   static int dbFreeDmap(struct bmap * bmp, struct dmap * dp, s64 blkno,
> @@ -1709,7 +1709,7 @@ static int dbFindCtl(struct bmap * bmp, int l2nb, int level, s64 * blkno)
>   		 * dbFindLeaf() returns the index of the leaf at which
>   		 * free space was found.
>   		 */
> -		rc = dbFindLeaf((dmtree_t *) dcp, l2nb, &leafidx);
> +		rc = dbFindLeaf((dmtree_t *) dcp, l2nb, &leafidx, 0);
>   
>   		/* release the buffer.
>   		 */
> @@ -1956,7 +1956,7 @@ dbAllocDmapLev(struct bmap * bmp,
>   	 * free space.  if sufficient free space is found, dbFindLeaf()
>   	 * returns the index of the leaf at which free space was found.
>   	 */
> -	if (dbFindLeaf((dmtree_t *) & dp->tree, l2nb, &leafidx))
> +	if (dbFindLeaf((dmtree_t *) &dp->tree, l2nb, &leafidx, 1))
>   		return -ENOSPC;
>   
>   	if (leafidx < 0)
> @@ -2920,14 +2920,18 @@ static void dbAdjTree(dmtree_t * tp, int leafno, int newval)
>    *	leafidx	- return pointer to be set to the index of the leaf
>    *		  describing at least l2nb free blocks if sufficient
>    *		  free blocks are found.
> + *	type	- type of dmtree
>    *
>    * RETURN VALUES:
>    *	0	- success
>    *	-ENOSPC	- insufficient free blocks.
>    */
> -static int dbFindLeaf(dmtree_t * tp, int l2nb, int *leafidx)
> +static int dbFindLeaf(dmtree_t *tp, int l2nb, int *leafidx, int type)
>   {
>   	int ti, n = 0, k, x = 0;
> +	int max_size;
> +
> +	max_size = type ? TREESIZE : CTLTREESIZE;
>   
>   	/* first check the root of the tree to see if there is
>   	 * sufficient free space.
> @@ -2948,6 +2952,8 @@ static int dbFindLeaf(dmtree_t * tp, int l2nb, int *leafidx)
>   			/* sufficient free space found.  move to the next
>   			 * level (or quit if this is the last level).
>   			 */
> +			if (x + n > max_size)
> +				return -ENOSPC;
>   			if (l2nb <= tp->dmt_stree[x + n])
>   				break;
>   		}
