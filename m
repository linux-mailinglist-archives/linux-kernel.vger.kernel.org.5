Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1C27CD818
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjJRJbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjJRJbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:31:18 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB131BE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:30:47 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id D1D473200AF1;
        Wed, 18 Oct 2023 05:30:45 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 18 Oct 2023 05:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697621445; x=1697707845; bh=8c
        ly2LTXugCW0URdraIBz7FF8OXwxO5w40tU9akFI8o=; b=Z1BLS8h3bsCmn4Ose0
        m0G6APl8uHCyI1KOTJupnNXibtB3PJqcR5otmud3QuQzhtNmVZckk63DWuSiLFaz
        bR9yB1Rnov2vBNF7oLJ9HpfwIwerfhByEij5dUxfdVGHQW2U78WBYin4563bxcJQ
        cl09WHK4//oVsGpchvOX4+aCwC9ePSk3n73G61S5HBDrg4i8HFLcN+tuhx6Gd0/j
        vtNZNfNo8ijFvorHfIW2IdqV2/cDhgeb9zsByNeqsljt7Yk7stwXgAXleqEx7CYg
        Xva8MpeHVJvn20oti7wqX5+CGA5z7sgdFmKh9HuFgdVr0UigvoTaqdD4k0oUETfz
        Rv7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697621445; x=1697707845; bh=8cly2LTXugCW0
        URdraIBz7FF8OXwxO5w40tU9akFI8o=; b=eHSWUwYalvutHn0AZBz8k0RiFf0N9
        0Sh2FYMqiT2zHq2cYrCygc46eOTg/2b8R0WBjOKk0fXc9REfoCsN5DcrfUITVvtm
        ydy3TLSeWMLV0R7hqHE2vlwBJ7GJWBPanbTtVocvkg/pUY9aeAr1Z1yvZ2Pl372c
        G4+/mvF+i2a/H9RWiuqDXSMbS+MRn+k4V4ZGZlpg/8eP/JlkqrnHleOr6+AUAm/O
        hpk9ssuh6LzMxC4IJgta+JxR2HQXd/dXBiMVO8EW4iMrLis4xOEpnInMDLwRutly
        IjQv3lsHtE8oV//C3wFX/2VmMpg2zdLXULJWT5e7TsV76ly5asUjys89Q==
X-ME-Sender: <xms:xaUvZT_CXi2hngxur_ic3o229LS-VjWnqceCAWKrzIwevrCgnj9OZg>
    <xme:xaUvZftq52_NT1uwTyruxNiAAaEaoPSvNT1REXTRcXacUrqk_ej5YRtFCTvNOk2Rf
    _EbRcDZQWoIoPxt4h0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeeggdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:xaUvZRBnatBXvx-JyWh-lmKamq4Y45UyY_u4T4ZigSSBoU15rhM2zg>
    <xmx:xaUvZfetiX02GdZ0IPPGKI6R51TMlAk92ip3si-Nt7f5_HOv8Be5zw>
    <xmx:xaUvZYPA4vOnF-cVNl-fLY6irwrjzIKoEm8bxshaFJeT179pb_6Efw>
    <xmx:xaUvZVopnTueZaFIdFtVyGQQ1JSDgLpX-7U1FAzi5IOqvZqgxMym_g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 148E4B60089; Wed, 18 Oct 2023 05:30:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <bfdc04b3-d776-4cb9-a95a-eec317e792e1@app.fastmail.com>
In-Reply-To: <20231018081941.475277-6-saeed@kernel.org>
References: <20231018081941.475277-1-saeed@kernel.org>
 <20231018081941.475277-6-saeed@kernel.org>
Date:   Wed, 18 Oct 2023 11:30:24 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Saeed Mahameed" <saeed@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Leon Romanovsky" <leonro@nvidia.com>,
        "Jason Gunthorpe" <jgg@nvidia.com>, "Jiri Pirko" <jiri@nvidia.com>,
        "Saeed Mahameed" <saeedm@nvidia.com>
Subject: Re: [PATCH 5/5] misc: mlx5ctl: Add umem reg/unreg ioctl
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
> From: Saeed Mahameed <saeedm@nvidia.com>

>
> To do so this patch introduces two ioctls:
>
> MLX5CTL_IOCTL_UMEM_REG(va_address, size):
>  - calculate page fragments from the user provided virtual address
>  - pin the pages, and allocate a sg list
>  - dma map the sg list
>  - create a UMEM device object that points to the dma addresses
>  - add a driver umem object to an xarray data base for bookkeeping
>  - return UMEM ID to user so it can be used in subsequent rpcs
>
> MLX5CTL_IOCTL_UMEM_UNREG(umem_id):
>  - user provides a pre allocated umem ID
>  - unwinds the above
>

> +static ssize_t mlx5ctl_ioctl_umem_reg(struct file *file, unsigned long 
> arg)
> +{
> +	struct mlx5ctl_fd *mfd = file->private_data;
> +	struct mlx5ctl_umem_reg umem_reg;
> +	int umem_id;
> +
> +	if (copy_from_user(&umem_reg, (void __user *)arg, sizeof(umem_reg)))
> +		return -EFAULT;

Instead of an in-place cast, the usual way to do it is to
have a local pointer of the correct type
(struct mlx5ctl_umem_reg __iomem *) as the function argument.

> +
> +	umem_id = mlx5ctl_umem_reg(mfd->umem_db, (unsigned 
> long)umem_reg.addr, umem_reg.len);

umem_reg.addr seems to be a user space address, so I would
suggest consistently passing it as a 'void __user *' instead
of casting to (unsigned long) here. You can use u64_to_user_ptr()
to handle the pointer conversion correctly across all
architectures that way, and get better type checking.

> @@ -24,6 +24,14 @@ struct mlx5ctl_cmdrpc {
>  	__aligned_u64 flags;
>  };
> 
> +struct mlx5ctl_umem_reg {
> +	__aligned_u64 addr; /* user address */
> +	__aligned_u64 len; /* user buffer length */
> +	__aligned_u64 flags;
> +	__u32 umem_id; /* returned device's umem ID */
> +	__u32 reserved[7];
> +};
> +

You have a 'flags' argument that is never accessed and can
probably be removed. If the intention was to make the ioctl
extensible for the future, this doesn't work unless you
ensure that only known flags (i.e. none at this point)
are set, and it's probably a bad idea anyway, compared
to creating a new ioctl command with new semantics.

Same for the 'reserved' fields except as needed for padding.

> +#define MLX5CTL_IOCTL_UMEM_UNREG \
> +	_IOWR(MLX5CTL_IOCTL_MAGIC, 0x3, unsigned long)

The use of 'unsigned long' here is wrong, this just makes
the command incompatible with compat mode, since
that type has different sizes. It also doesn't
match what the implementation uses, as that does
not try to read and write an 'unsigned long'
from user memory but instead takes the argument
itself as an integer. If you want to keep the use
of direct integer arguments (instead of pointer to
__u32 or __u64) here, this would have to be

   _IO(MLX5CTL_IOCTL_MAGIC, 0x3)

     Arnd
