Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABEC79DBE0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 00:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237565AbjILWZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 18:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbjILWZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:25:40 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B5D10E9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 15:25:36 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bc0d39b52cso46594975ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 15:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1694557536; x=1695162336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eosgCoWZNOmDvLUWrLZ0oih5y0eXb3zNPfDtn21F2w4=;
        b=qoEA+GEBtVQJCBJ1uhINBq8/nsUzcZC/gUGlFwz7xjfMUKxTB/OWC4XUjfwqDeYwTn
         di43at8N7AhBCetqPihXqOP7ZIHlM+fFMUDIt5Pe89V6uG8u+69DPCrvRgjeHzlY46Ev
         W0C2VOp0SgNXs8i6Q9utHSA7qTZ9NH+xB0L8jgcKmRdlycoXdkUkpoZpZ0lCz7A75iBe
         qbieHUlDuSUemfWgRH6Jsi5ekGQbtn+kaSAa+OvTQTOJH22BxXjHW9mGaLA9Ia13LHKQ
         LBh0mLlH/T2JNe5hXPPeYAvNCAXAw9W8CEtHp7jtUQmnp6PXLCDJLJf//YMD1Gflva6K
         ysGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694557536; x=1695162336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eosgCoWZNOmDvLUWrLZ0oih5y0eXb3zNPfDtn21F2w4=;
        b=ualCt/dTkvDBQWV0EfRX4WoVKgwoC2kYPD4YdipQ+XyvTJpzXvwpiS9DMuoUsQnSO+
         m2Yk13KkMQrhTMU/uTrxfyKcF60AV2wn4VLhOizggcJ/aR7vEHGEZaU6LQz9W6mrIjrL
         fJXbcZmvwqC1KXvzN+pI6BEGhM7DACrEQcoB/jNvGlX7D/G7NQxpZtCg7mYiBZFGXGEE
         MZhhki1W9QMd8iX34VXDgj1xqazgs6uEDflTI8mDM4E337ae8IKNKuLdCaAJ6HwqiyfP
         7bd37fx4etO7gT2y2YAgNjJ3F+1Fqan9WixmFsJ8G113FAABrkoulF1nJ6UJXhafOt04
         f7rw==
X-Gm-Message-State: AOJu0YxB+5twKEiRErfmDxe8ag8ZZU0KMYsKACmNKhnL8NOmmq3zk1rf
        0BCYTXVXA4ahGFCs43kS2JCJVqhYFip3IlpvHNs=
X-Google-Smtp-Source: AGHT+IF3XE+5q0CM9oPZGwbLk4S5RJ6zkW4JTV+x3Noccxf2ycMnON1Hzj2AMEQTS7gVww/PdUVCdw==
X-Received: by 2002:a17:903:503:b0:1bc:1189:17f with SMTP id jn3-20020a170903050300b001bc1189017fmr1074878plb.42.1694557536039;
        Tue, 12 Sep 2023 15:25:36 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id g8-20020a1709029f8800b001b8baa83639sm8970731plq.200.2023.09.12.15.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 15:25:35 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qgBp6-00EPFH-0O;
        Wed, 13 Sep 2023 08:25:32 +1000
Date:   Wed, 13 Sep 2023 08:25:32 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     cheng.lin130@zte.com.cn
Cc:     djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiang.yong5@zte.com.cn,
        wang.liang82@zte.com.cn, liu.dong3@zte.com.cn
Subject: Re: [PATCH v2] xfs: introduce protection for drop nlink
Message-ID: <ZQDlXPJJvp7wctbZ@dread.disaster.area>
References: <202309111612569712762@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309111612569712762@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 04:12:56PM +0800, cheng.lin130@zte.com.cn wrote:
> From: Cheng Lin <cheng.lin130@zte.com.cn>
> 
> When abnormal drop_nlink are detected on the inode,
> shutdown filesystem, to avoid corruption propagation.
> 
> Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
> ---
>  fs/xfs/xfs_fsops.c | 3 +++
>  fs/xfs/xfs_inode.c | 9 +++++++++
>  fs/xfs/xfs_mount.h | 1 +
>  3 files changed, 13 insertions(+)
> 
> diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
> index 7cb75cb6b..6fc1cfe83 100644
> --- a/fs/xfs/xfs_fsops.c
> +++ b/fs/xfs/xfs_fsops.c
> @@ -543,6 +543,9 @@ xfs_do_force_shutdown(
>  	} else if (flags & SHUTDOWN_CORRUPT_ONDISK) {
>  		tag = XFS_PTAG_SHUTDOWN_CORRUPT;
>  		why = "Corruption of on-disk metadata";
> +	} else if (flags & SHUTDOWN_CORRRUPT_ABN) {
> +		tag = XFS_PTAG_SHUTDOWN_CORRUPT;
> +		why = "Corruption of Abnormal conditions";

We don't need a new shutdown tag. We can consider this in-memory
corruption because we detected it in memory before it went to disk
(SHUTDOWN_CORRUPT_INCORE) or even on-disk corruption because the
reference count on disk is likely wrong at this point......

>  	} else if (flags & SHUTDOWN_DEVICE_REMOVED) {
>  		tag = XFS_PTAG_SHUTDOWN_IOERROR;
>  		why = "Block device removal";
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 9e62cc500..2d41f2461 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -919,6 +919,15 @@ xfs_droplink(
>  	xfs_trans_t *tp,
>  	xfs_inode_t *ip)
>  {
> +
> +	if (VFS_I(ip)->i_nlink == 0) {
> +		xfs_alert(ip->i_mount,
> +			  "%s: Deleting inode %llu with no links.",
> +			  __func__, ip->i_ino);
> +		xfs_force_shutdown(ip->i_mount, SHUTDOWN_CORRRUPT_ABN);
> +		return -EFSCORRUPTED;
> +	}
> +
>  	xfs_trans_ichgtime(tp, ip, XFS_ICHGTIME_CHG);
> 
>  	drop_nlink(VFS_I(ip));

I'd kind of prefer that drop_nlink() be made to return an error on
underrun - if it's important enough to drop a warning in the log and
potentially panic the kernel, it's important enough to tell the
filesystem an underrun has occurred.  But that opens a whole new can
of worms, so I think this will be fine.

Note that we don't actually need a call to shut the filesystem down.
Simply returning -EFSCORRUPTED will result in the filesystem being
shut down if the transaction is dirty when it gets cancelled due to
the droplink error.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
