Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6C07FD186
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjK2I75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjK2I7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:59:53 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA4312C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:59:59 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cc02e77a9cso3898354b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701248399; x=1701853199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lM4/6bPxfuZqProEDtAoywGbydqp6bvtnJKh8H9AEJI=;
        b=0XbO+ZFNvjBfcXxU7lnqtHhBBuZbQNZh6wyi05HSQWi5GDMJhhAPl/2svlJ2sp1Z+T
         sKKe3Hohm1to0ifgFSNxTItGx93UoSqn3y1aRFLlzd0YSBXQcc8K9aaO5LIJNN9AH+9F
         6v5VP3Tj4JwoYNHRxc9c9y92qrKODc6Ehx2i424jIzXESCD4DnNIPk4VBHkKpxnKMWC3
         41uvx84A/nBkeM5qqpqIOE86cIz4SJIkm1iSLa0ZeiJyK6O1UeS/yz7M6MVyG43fINtM
         XgSTIQlmwHsjqp/9I+YwXAhOUfHucZCcFeeQ6UesLfeECxvxUvjBZwlxtabM/yWhGyZo
         W3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701248399; x=1701853199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lM4/6bPxfuZqProEDtAoywGbydqp6bvtnJKh8H9AEJI=;
        b=qKt+pXRwMUJogtIR8Bv+ZxO1GmdIRdInQtEYtPg8ZI3971f9Ss1jKWGhQOJ/Dxy+C0
         epcLAinA4szPB+w9HKeM/0Q6y5K35eWGaQu8wNW3mQJuOSLVRM5/CWPMtVzifWCsFa9y
         8pbCm50KOQeIN7bxGbfCENnYss2lVYOlxUnHBpoVjui7v8AiX0R0AiMGVMqueJ9fWVQ8
         fLJuw2YvwWutNBbvfGR3hvmmeOp6hHwP+gbtpoHeFpHc40s3AZGOC5GYpOnHQArctmin
         mWng50wu66iytJGgwN3RONxBpTvhwuk6aFrIL3BKucKXPUClqQgWZfz7pcH/rU6YuU5B
         YBdQ==
X-Gm-Message-State: AOJu0YyHhQ+6QxQSJI08LPnrsG7bqyuhqkOEucDoPv6e+w/d3iiVLT22
        seHEJTeuCafAtk8DkOuQWrrS3A==
X-Google-Smtp-Source: AGHT+IF5+UKBkNuqEW1VygjsHj4mijbjOJsqWXzU2xxnEfe6/0lcOCiwMlyx5JAJMb4qfZvnqvythw==
X-Received: by 2002:a05:6a20:914b:b0:18c:548d:3d23 with SMTP id x11-20020a056a20914b00b0018c548d3d23mr16809715pzc.59.1701248399356;
        Wed, 29 Nov 2023 00:59:59 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id ji5-20020a170903324500b001cfad1a60cesm8859189plb.137.2023.11.29.00.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 00:59:59 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1r8GQG-001RbE-1Y;
        Wed, 29 Nov 2023 19:59:56 +1100
Date:   Wed, 29 Nov 2023 19:59:56 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Zhang Tianci <zhangtianci.1997@bytedance.com>,
        Brian Foster <bfoster@redhat.com>, Ben Myers <bpm@sgi.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xieyongji@bytedance.com, me@jcix.top
Subject: Re: [PATCH v2 2/2] xfs: update dir3 leaf block metadata after swap
Message-ID: <ZWb9jMQSjbqqzrob@dread.disaster.area>
References: <20231129075832.73600-1-zhangjiachen.jaycee@bytedance.com>
 <20231129075832.73600-3-zhangjiachen.jaycee@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129075832.73600-3-zhangjiachen.jaycee@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 03:58:32PM +0800, Jiachen Zhang wrote:
> From: Zhang Tianci <zhangtianci.1997@bytedance.com>
> 
> xfs_da3_swap_lastblock() copy the last block content to the dead block,
> but do not update the metadata in it. We need update some metadata
> for some kinds of type block, such as dir3 leafn block records its
> blkno, we shall update it to the dead block blkno. Otherwise,
> before write the xfs_buf to disk, the verify_write() will fail in
> blk_hdr->blkno != xfs_buf->b_bn, then xfs will be shutdown.
> 
> We will get this warning:
> 
>   XFS (dm-0): Metadata corruption detected at xfs_dir3_leaf_verify+0xa8/0xe0 [xfs], xfs_dir3_leafn block 0x178
>   XFS (dm-0): Unmount and run xfs_repair
>   XFS (dm-0): First 128 bytes of corrupted metadata buffer:
>   00000000e80f1917: 00 80 00 0b 00 80 00 07 3d ff 00 00 00 00 00 00  ........=.......
>   000000009604c005: 00 00 00 00 00 00 01 a0 00 00 00 00 00 00 00 00  ................
>   000000006b6fb2bf: e4 44 e3 97 b5 64 44 41 8b 84 60 0e 50 43 d9 bf  .D...dDA..`.PC..
>   00000000678978a2: 00 00 00 00 00 00 00 83 01 73 00 93 00 00 00 00  .........s......
>   00000000b28b247c: 99 29 1d 38 00 00 00 00 99 29 1d 40 00 00 00 00  .).8.....).@....
>   000000002b2a662c: 99 29 1d 48 00 00 00 00 99 49 11 00 00 00 00 00  .).H.....I......
>   00000000ea2ffbb8: 99 49 11 08 00 00 45 25 99 49 11 10 00 00 48 fe  .I....E%.I....H.
>   0000000069e86440: 99 49 11 18 00 00 4c 6b 99 49 11 20 00 00 4d 97  .I....Lk.I. ..M.
>   XFS (dm-0): xfs_do_force_shutdown(0x8) called from line 1423 of file fs/xfs/xfs_buf.c.  Return address = 00000000c0ff63c1
>   XFS (dm-0): Corruption of in-memory data detected.  Shutting down filesystem
>   XFS (dm-0): Please umount the filesystem and rectify the problem(s)
> 
> From the log above, we know xfs_buf->b_no is 0x178, but the block's hdr record
> its blkno is 0x1a0.
> 
> Fixes: 24df33b45ecf ("xfs: add CRC checking to dir2 leaf blocks")
> Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> Suggested-by: Dave Chinner <david@fromorbit.com>
> ---
>  fs/xfs/libxfs/xfs_da_btree.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
> index e576560b46e9..d11e6286e466 100644
> --- a/fs/xfs/libxfs/xfs_da_btree.c
> +++ b/fs/xfs/libxfs/xfs_da_btree.c
> @@ -2318,8 +2318,17 @@ xfs_da3_swap_lastblock(
>  	 * Copy the last block into the dead buffer and log it.
>  	 */
>  	memcpy(dead_buf->b_addr, last_buf->b_addr, args->geo->blksize);
> -	xfs_trans_log_buf(tp, dead_buf, 0, args->geo->blksize - 1);
>  	dead_info = dead_buf->b_addr;
> +	/*
> +	 * If xfs enable crc, the node/leaf block records its blkno, we
> +	 * must update it.
> +	 */

I'd combine this comment into the comment 3 lines above.

> +	if (xfs_has_crc(mp)) {
> +		struct xfs_da3_blkinfo *da3 = container_of(dead_info, struct xfs_da3_blkinfo, hdr);

Line length too long.

And using container_of() is rather unique an unusual, and not done
anywhere else in the code. dead_buf->b_addr is a void pointer,
so no cast is necessary:

		struct xfs_da3_blkinfo *da3 = dead_buf->b_addr;


> +
> +		da3->blkno = cpu_to_be64(xfs_buf_daddr(dead_buf));
> +	}
> +	xfs_trans_log_buf(tp, dead_buf, 0, args->geo->blksize - 1);
>  	/*
>  	 * Get values from the moved block.
>  	 */

And whitespace for readability before the next code block. IOWs:

	/*
	 * Copy the last block into the dead buffer, update the block info
	 * header and log it.
	 */
	memcpy(dead_buf->b_addr, last_buf->b_addr, args->geo->blksize);
	if (xfs_has_crc(mp)) {
		struct xfs_da3_blkinfo *da3 = dead_buf->b_addr

		da3->blkno = cpu_to_be64(xfs_buf_daddr(dead_buf));
	}
	xfs_trans_log_buf(tp, dead_buf, 0, args->geo->blksize - 1);
	dead_info = dead_buf->b_addr;

	/*
	 * Get values from the moved block.
	 */

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
