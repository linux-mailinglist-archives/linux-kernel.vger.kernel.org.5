Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E940F7D3807
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjJWN22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjJWN21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:28:27 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD557E8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 06:28:24 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cace3e142eso16946275ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 06:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698067704; x=1698672504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sa6E4Qj1oc9mMqsv5L9bh8Mbh/T7iNaz8w1q2WI91v8=;
        b=XgEXL+9D25ypiK5fi/37uxEUkRROtQMltU7UlzPEumbysvq8JAvkH+GV1RI6A3ccH3
         ZqO84ndGvSX+LB2vjuFubu9QvSlOxL4nuDzo/6mCdm7s/O+H+ex9Xlf93hyn1xZlUXrD
         l1h9luIeYmce9xSihZqAbzcQSGrIhxPIKi/DBFS9Sq0o8+WgidmB27kF6ng0+PY71qdV
         gFwePtk9gk16kHKppF7m1nwkq5EQz/C5iszlNshDRFQctFffU69DfbK3RRCw6/eZ8eFB
         5332WakRgtHlXG5VfcBZ/mNpon7QYJx5nPXR4Q6uAoTUk8xv3GOir+nokyULTfq31MnA
         Kj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698067704; x=1698672504;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sa6E4Qj1oc9mMqsv5L9bh8Mbh/T7iNaz8w1q2WI91v8=;
        b=kfwDypGMl7oo7o+VzvxDxWRXLfzeU5t2UVxM0V/p7pjSyU7fOiWq0GIjD+OUvjmNf4
         AigA/JJodAOLTxNsBWKw5Mleu05Lv5cCtb7NS5zi+4+4zKFpCSaI84NGw5ZUNIe1kBTf
         Mxk1NfU0dPgZ2GhPAX+IV4N9nXask/9Eq7wxMWZCneUljTpKM+Z7DzWDer0WlKa8VCA0
         aEf8JYOqsxtoFlH9Jc5U6X9o+uSY77oTaJLk0LhWZd1WgjsM3DDTbKbwkwndFZZRvQKB
         5Mt+Y7KCPmHod4ZENG8g6miQFQPBX9xA0N/5mhaFNiG7n5J2Ih6geP+9aZmBpfORuC1c
         CPOA==
X-Gm-Message-State: AOJu0Yz4/l/mpUCikSlSvC44z9HBK7NslkF2dkdVM/dfetAdHJ2S5MZO
        ANt4UZqWIuOOrvTem/12tJs=
X-Google-Smtp-Source: AGHT+IFvottFAmnA7SB2WAWQGZ9+jtpVVAczNTCh+JHMH8eODQoBHsYfdkkToljNxaQi/f+AKQzL6g==
X-Received: by 2002:a17:902:da8e:b0:1ca:4681:eb39 with SMTP id j14-20020a170902da8e00b001ca4681eb39mr7180734plx.17.1698067704143;
        Mon, 23 Oct 2023 06:28:24 -0700 (PDT)
Received: from [10.0.2.15] ([103.37.201.177])
        by smtp.gmail.com with ESMTPSA id u15-20020a170902e80f00b001c9d2360b2asm5898797plg.22.2023.10.23.06.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 06:28:23 -0700 (PDT)
Message-ID: <339774d7-b50b-b4bc-7c49-b128b781428b@gmail.com>
Date:   Tue, 17 Oct 2023 17:35:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] jfs: fix array-index-out-of-bounds in dbAdjTree
Content-Language: en-US
To:     dave.kleikamp@oracle.com, shaggy@kernel.org
Cc:     Linux-kernel-mentees@lists.linuxfoundation.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+39ba34a099ac2e9bd3cb@syzkaller.appspotmail.com
References: <20231017120356.55322-1-ghandatmanas@gmail.com>
From:   Manas Ghandat <ghandatmanas@gmail.com>
In-Reply-To: <20231017120356.55322-1-ghandatmanas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a friendly remainder

On 17/10/23 17:33, Manas Ghandat wrote:
> Currently there is a bound check missing in the dbAdjTree while
> accessing the dmt_stree. To add the required check added the bool is_ctl
> which is required to determine the size as suggest in the following
> commit.
> https://lore.kernel.org/linux-kernel-mentees/f9475918-2186-49b8-b801-6f0f9e75f4fa@oracle.com/
>
> Reported-by: syzbot+39ba34a099ac2e9bd3cb@syzkaller.appspotmail.com
> Fixes: https://syzkaller.appspot.com/bug?extid=39ba34a099ac2e9bd3cb
> Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
> ---
>   fs/jfs/jfs_dmap.c | 57 ++++++++++++++++++++++++++---------------------
>   1 file changed, 31 insertions(+), 26 deletions(-)
>
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index 88afd108c2dd..57fba21994c3 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -63,10 +63,10 @@
>    */
>   static void dbAllocBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
>   			int nblocks);
> -static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval);
> -static int dbBackSplit(dmtree_t * tp, int leafno);
> -static int dbJoin(dmtree_t * tp, int leafno, int newval);
> -static void dbAdjTree(dmtree_t * tp, int leafno, int newval);
> +static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval, bool is_ctl);
> +static int dbBackSplit(dmtree_t * tp, int leafno, bool is_ctl);
> +static int dbJoin(dmtree_t * tp, int leafno, int newval, bool is_ctl);
> +static void dbAdjTree(dmtree_t * tp, int leafno, int newval, bool is_ctl);
>   static int dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc,
>   		    int level);
>   static int dbAllocAny(struct bmap * bmp, s64 nblocks, int l2nb, s64 * results);
> @@ -2096,7 +2096,7 @@ static int dbFreeDmap(struct bmap * bmp, struct dmap * dp, s64 blkno,
>   		 * system.
>   		 */
>   		if (dp->tree.stree[word] == NOFREE)
> -			dbBackSplit((dmtree_t *) & dp->tree, word);
> +			dbBackSplit((dmtree_t *) & dp->tree, word, false);
>   
>   		dbAllocBits(bmp, dp, blkno, nblocks);
>   	}
> @@ -2182,7 +2182,7 @@ static void dbAllocBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
>   			 * the binary system of the leaves if need be.
>   			 */
>   			dbSplit(tp, word, BUDMIN,
> -				dbMaxBud((u8 *) & dp->wmap[word]));
> +				dbMaxBud((u8 *) & dp->wmap[word]),false);
>   
>   			word += 1;
>   		} else {
> @@ -2222,7 +2222,7 @@ static void dbAllocBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
>   				 * system of the leaves to reflect the current
>   				 * allocation (size).
>   				 */
> -				dbSplit(tp, word, size, NOFREE);
> +				dbSplit(tp, word, size, NOFREE, false);
>   
>   				/* get the number of dmap words handled */
>   				nw = BUDSIZE(size, BUDMIN);
> @@ -2329,7 +2329,7 @@ static int dbFreeBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
>   			/* update the leaf for this dmap word.
>   			 */
>   			rc = dbJoin(tp, word,
> -				    dbMaxBud((u8 *) & dp->wmap[word]));
> +				    dbMaxBud((u8 *) & dp->wmap[word]),false);
>   			if (rc)
>   				return rc;
>   
> @@ -2362,7 +2362,7 @@ static int dbFreeBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
>   
>   				/* update the leaf.
>   				 */
> -				rc = dbJoin(tp, word, size);
> +				rc = dbJoin(tp, word, size, false);
>   				if (rc)
>   					return rc;
>   
> @@ -2514,16 +2514,16 @@ dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc, int level)
>   		 * that it is at the front of a binary buddy system.
>   		 */
>   		if (oldval == NOFREE) {
> -			rc = dbBackSplit((dmtree_t *) dcp, leafno);
> +			rc = dbBackSplit((dmtree_t *) dcp, leafno, true);
>   			if (rc) {
>   				release_metapage(mp);
>   				return rc;
>   			}
>   			oldval = dcp->stree[ti];
>   		}
> -		dbSplit((dmtree_t *) dcp, leafno, dcp->budmin, newval);
> +		dbSplit((dmtree_t *) dcp, leafno, dcp->budmin, newval, true);
>   	} else {
> -		rc = dbJoin((dmtree_t *) dcp, leafno, newval);
> +		rc = dbJoin((dmtree_t *) dcp, leafno, newval, true);
>   		if (rc) {
>   			release_metapage(mp);
>   			return rc;
> @@ -2554,7 +2554,7 @@ dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc, int level)
>   				 */
>   				if (alloc) {
>   					dbJoin((dmtree_t *) dcp, leafno,
> -					       oldval);
> +					       oldval, true);
>   				} else {
>   					/* the dbJoin() above might have
>   					 * caused a larger binary buddy system
> @@ -2564,9 +2564,9 @@ dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc, int level)
>   					 */
>   					if (dcp->stree[ti] == NOFREE)
>   						dbBackSplit((dmtree_t *)
> -							    dcp, leafno);
> +							    dcp, leafno, true);
>   					dbSplit((dmtree_t *) dcp, leafno,
> -						dcp->budmin, oldval);
> +						dcp->budmin, oldval, true);
>   				}
>   
>   				/* release the buffer and return the error.
> @@ -2614,7 +2614,7 @@ dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc, int level)
>    *
>    * serialization: IREAD_LOCK(ipbmap) or IWRITE_LOCK(ipbmap) held on entry/exit;
>    */
> -static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval)
> +static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval, bool is_ctl)
>   {
>   	int budsz;
>   	int cursz;
> @@ -2636,7 +2636,7 @@ static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval)
>   		while (cursz >= splitsz) {
>   			/* update the buddy's leaf with its new value.
>   			 */
> -			dbAdjTree(tp, leafno ^ budsz, cursz);
> +			dbAdjTree(tp, leafno ^ budsz, cursz, is_ctl);
>   
>   			/* on to the next size and buddy.
>   			 */
> @@ -2648,7 +2648,7 @@ static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval)
>   	/* adjust the dmap tree to reflect the specified leaf's new
>   	 * value.
>   	 */
> -	dbAdjTree(tp, leafno, newval);
> +	dbAdjTree(tp, leafno, newval, is_ctl);
>   }
>   
>   
> @@ -2679,7 +2679,7 @@ static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval)
>    *
>    * serialization: IREAD_LOCK(ipbmap) or IWRITE_LOCK(ipbmap) held on entry/exit;
>    */
> -static int dbBackSplit(dmtree_t * tp, int leafno)
> +static int dbBackSplit(dmtree_t * tp, int leafno, bool is_ctl)
>   {
>   	int budsz, bud, w, bsz, size;
>   	int cursz;
> @@ -2730,7 +2730,7 @@ static int dbBackSplit(dmtree_t * tp, int leafno)
>   				 * system in two.
>   				 */
>   				cursz = leaf[bud] - 1;
> -				dbSplit(tp, bud, cursz, cursz);
> +				dbSplit(tp, bud, cursz, cursz, is_ctl);
>   				break;
>   			}
>   		}
> @@ -2758,7 +2758,7 @@ static int dbBackSplit(dmtree_t * tp, int leafno)
>    *
>    * RETURN VALUES: none
>    */
> -static int dbJoin(dmtree_t * tp, int leafno, int newval)
> +static int dbJoin(dmtree_t * tp, int leafno, int newval, bool is_ctl)
>   {
>   	int budsz, buddy;
>   	s8 *leaf;
> @@ -2813,12 +2813,12 @@ static int dbJoin(dmtree_t * tp, int leafno, int newval)
>   			if (leafno < buddy) {
>   				/* leafno is the left buddy.
>   				 */
> -				dbAdjTree(tp, buddy, NOFREE);
> +				dbAdjTree(tp, buddy, NOFREE, is_ctl);
>   			} else {
>   				/* buddy is the left buddy and becomes
>   				 * leafno.
>   				 */
> -				dbAdjTree(tp, leafno, NOFREE);
> +				dbAdjTree(tp, leafno, NOFREE, is_ctl);
>   				leafno = buddy;
>   			}
>   
> @@ -2831,7 +2831,7 @@ static int dbJoin(dmtree_t * tp, int leafno, int newval)
>   
>   	/* update the leaf value.
>   	 */
> -	dbAdjTree(tp, leafno, newval);
> +	dbAdjTree(tp, leafno, newval, is_ctl);
>   
>   	return 0;
>   }
> @@ -2852,15 +2852,20 @@ static int dbJoin(dmtree_t * tp, int leafno, int newval)
>    *
>    * RETURN VALUES: none
>    */
> -static void dbAdjTree(dmtree_t * tp, int leafno, int newval)
> +static void dbAdjTree(dmtree_t * tp, int leafno, int newval, bool is_ctl)
>   {
>   	int lp, pp, k;
> -	int max;
> +	int max, size;
> +
> +	size = is_ctl ? CTLTREESIZE : TREESIZE;
>   
>   	/* pick up the index of the leaf for this leafno.
>   	 */
>   	lp = leafno + le32_to_cpu(tp->dmt_leafidx);
>   
> +	if (lp > size || lp < 0)
> +		return;
> +
>   	/* is the current value the same as the old value ?  if so,
>   	 * there is nothing to do.
>   	 */
