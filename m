Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC617CD763
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjJRJC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJRJCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:02:24 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE77FEA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:02:22 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id D091A3200B11;
        Wed, 18 Oct 2023 05:02:21 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 18 Oct 2023 05:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697619741; x=1697706141; bh=/6
        9j3hXZYCUlxIkqapaFj++HVDN18WQt0u8wr2jBqgk=; b=sEk8LzaJPZfb+m2p5v
        iCdapM+nd25Yef+7Tk94lj0d9hLBRZlqV1yTvs28bxDadWfxwoOQfADf846T1c8W
        sPpgG6Io/uHToKsHBIf3wwVpTdLALYNUeAmWolqc+akZ8bTLtaS8kg6Fu/0jt703
        mAOWCtkBST7iFTBR75zAfN2r8C1tk+vxesaGCISJIdv9Y6MKMURFd/RC6EjjfO7s
        ihh1aLnLQGnf0lcWUjo/TDghSxvo1DLWZQuS4m/NJP8RduPIpa5Jut5ezZyLwbQc
        DgS7C5RS4l+sUknr/+b4T206hCDJ4V8DOYvmIGB/f7NMNI8xfBzY7BDs1SBSEQBj
        hiug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697619741; x=1697706141; bh=/69j3hXZYCUlx
        IkqapaFj++HVDN18WQt0u8wr2jBqgk=; b=UWjoI0FfU1QSPibA547jAbuotqinO
        DbIsH+hA36TfmPpjLdzmuW5yj3QWqYfk9JGQEFbKTVT2HovfNwF4SV3SYrY1kZaj
        RYNELKy20J4mFEiBcSFdyMUI39+Km7nEkXn0OjWJ+aVcBPji7MrKiWm0diFV2XuD
        xN3nHYialcbmu2US5ZB7Ukg38Bx0/6gxK1ZGTDJxfCkEypM3+4O18LP3C6d28hYL
        aj8/lTLVUBUemvNFT2RGrJqT+q3ye7LrPIfY0wph4bwu9OHd9niHs6KrntpLryCh
        oE1xwL8PnjDsHd4jEbkcen9i5FNHwN1ev43jxnGZOqJEYDLFIx8wUhUHw==
X-ME-Sender: <xms:HZ8vZQSzZkUpxMR1sN2PVyoP57MHE1d4W8PXbseWWba2-wXW1BiLuQ>
    <xme:HZ8vZdzsNZkpoUvsFxRdkIaeMA5Q_9T0M8R4CH4ZIw4Db2rSeksdBxpWFYI-Yy5di
    579Ado9mqxTwc7IpLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeeggddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:HZ8vZd3Z88heq_MYcYGPrlZJS_6mZQiv2EZRG9fSysCwAfpR-2sYPg>
    <xmx:HZ8vZUC9L2gtdYB1KKCjNDKgcoH0X27EedPwXSjSzbwbo7aIlZczLQ>
    <xmx:HZ8vZZjYnnNl9haceQxYiWRDIV9dyKP_sYV4YaRfJcVRLk9__-mGxw>
    <xmx:HZ8vZZeyCnDJrGztA_Ier-ACNyqaJvlZzO9fgNplbjY2At8uSoAJnQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3394DB60089; Wed, 18 Oct 2023 05:02:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <6fb88a6a-dd66-4368-8da9-596f384fe5bc@app.fastmail.com>
In-Reply-To: <20231018081941.475277-4-saeed@kernel.org>
References: <20231018081941.475277-1-saeed@kernel.org>
 <20231018081941.475277-4-saeed@kernel.org>
Date:   Wed, 18 Oct 2023 11:02:00 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Saeed Mahameed" <saeed@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Leon Romanovsky" <leonro@nvidia.com>,
        "Jason Gunthorpe" <jgg@nvidia.com>, "Jiri Pirko" <jiri@nvidia.com>,
        "Saeed Mahameed" <saeedm@nvidia.com>
Subject: Re: [PATCH 3/5] misc: mlx5ctl: Add info ioctl
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023, at 10:19, Saeed Mahameed wrote:

> Implement INFO ioctl to return the allocated UID and the capability flags
> and some other useful device information such as the underlying ConnectX
> device.

I'm commenting on the ABI here, ignoring everything for the moment.

>  static const struct file_operations mlx5ctl_fops = {
>  	.owner = THIS_MODULE,
>  	.open = mlx5ctl_open,
>  	.release = mlx5ctl_release,
> +	.unlocked_ioctl = mlx5ctl_ioctl,
>  };

There should be a .compat_ioctl entry as well, to allow 32-bit
tasks to use the same interface.
 
>  static int mlx5ctl_probe(struct auxiliary_device *adev,
> diff --git a/include/uapi/misc/mlx5ctl.h b/include/uapi/misc/mlx5ctl.h
> new file mode 100644
> index 000000000000..81d89cd285fc
> --- /dev/null
> +++ b/include/uapi/misc/mlx5ctl.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB WITH Linux-syscall-note */
> +/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
> +
> +#ifndef __MLX5CTL_IOCTL_H__
> +#define __MLX5CTL_IOCTL_H__
> +
> +struct mlx5ctl_info {
> +	__aligned_u64 flags;
> +	__u32 size;
> +	__u8 devname[64]; /* underlaying ConnectX device */
> +	__u16 uctx_uid; /* current process allocated UCTX UID */

I don't know what a UCTX UID is, but if this is related to
uid_t, it has to be 32 bit wide.

> +	__u16 reserved1;
> +	__u32 uctx_cap; /* current process effective UCTX cap */
> +	__u32 dev_uctx_cap; /* device's UCTX capabilities */
> +	__u32 ucap; /* process user capability */
> +	__u32 reserved2[4];
> +};

If I'm counting right, this structure has a size of
108 bytes but an alignment of 8 bytes, so you end up with
a 4-byte hole at the end, which introduces a risk of
leaking kernel data. Maybe give it an extra reserved word?

     Arnd
