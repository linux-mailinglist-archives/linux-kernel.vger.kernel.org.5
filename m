Return-Path: <linux-kernel+bounces-65220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D61F8549AA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0EFDB2661F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9295381B;
	Wed, 14 Feb 2024 12:51:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A682852F72;
	Wed, 14 Feb 2024 12:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915111; cv=none; b=mIY6A8MybAYcZJMNbqhMzSMVUcXZ0HrTfCcnBxUhnAQpzlV+JLQTPSUdnvB0BLpTtiFL1yyBVbGq3fVHFuCwlv60G+SA40k8L1yMiN/VU5PcbzQkfBvJ+ilozCoi3ExjaEuaoVX/fdQJXJqPADyUuWbrlEYCiWLGS23fyBXDB6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915111; c=relaxed/simple;
	bh=h0bXe5xX9YW/t/MGvWzQw9+QyBCufsFJVGdR4dnIIOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwDa+gQK2scD49t/zSWwbyVSesSG454aMAgs/d9bh//oC7BeOv8SztH7uJ/NzEtq2gDURwEi88+UAvWIIYMNpUQq1RB71U2CbvKQqyEW6ibvPXVWSglLXsCHZNZnJRwekQfQGLPYPJN+cNDc34zzKpulLiQbho+DvHgPGKRGZkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663E4C433C7;
	Wed, 14 Feb 2024 12:51:49 +0000 (UTC)
Message-ID: <f2fc7350-d39e-45c2-bfa2-9ee502d8bdec@xs4all.nl>
Date: Wed, 14 Feb 2024 13:51:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: Add dependency of ov7670/mcam/cafe on
 CONFIG_V4L2_ASYNC explicitly
Content-Language: en-US, nl
To: Dawei Li <dawei.li@shingroup.cn>, mchehab@kernel.org
Cc: sakari.ailus@linux.intel.com, laurent.pinchart@ideasonboard.com,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 hdegoede@redhat.com, oe-kbuild-all@lists.linux.dev, set_pte_at@outlook.com,
 kernel test robot <lkp@intel.com>
References: <202402130955.f6uxzdCA-lkp@intel.com>
 <20240214113830.3656367-1-dawei.li@shingroup.cn>
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <20240214113830.3656367-1-dawei.li@shingroup.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/02/2024 12:38, Dawei Li wrote:
> Kernel test robot reports:
>    ld: drivers/media/i2c/ov7670.o: in function `ov7670_remove':
>    drivers/media/i2c/ov7670.c:2011: undefined reference to
>    `v4l2_async_unregister_subdev'
>    ld: drivers/media/i2c/ov7670.o: in function `ov7670_parse_dt':
>    drivers/media/i2c/ov7670.c:1836: undefined reference to
>    `v4l2_fwnode_endpoint_parse'
>    ld: drivers/media/i2c/ov7670.o: in function `ov7670_probe':
>    drivers/media/i2c/ov7670.c:1990: undefined reference to
>    `v4l2_async_register_subdev'
>    ld: drivers/media/platform/marvell/cafe-driver.o: in function
>    `cafe_pci_probe':
>>> drivers/media/platform/marvell/cafe-driver.c:543: undefined reference
>    to `v4l2_async_nf_init'
>>> ld: drivers/media/platform/marvell/cafe-driver.c:545: undefined
>    reference to `__v4l2_async_nf_add_i2c'
>    ld: drivers/media/platform/marvell/mcam-core.o: in function
>    `mccic_shutdown':
>>> drivers/media/platform/marvell/mcam-core.c:1931: undefined reference to
>    `v4l2_async_nf_unregister'
>>> ld: drivers/media/platform/marvell/mcam-core.c:1932: undefined reference
>    to `v4l2_async_nf_cleanup'
>    ld: drivers/media/platform/marvell/mcam-core.o: in function
>    `mccic_register':
>    drivers/media/platform/marvell/mcam-core.c:1910: undefined reference to
>    `v4l2_async_nf_unregister'
>    ld: drivers/media/platform/marvell/mcam-core.c:1911: undefined reference
>    to `v4l2_async_nf_cleanup'
>>> ld: drivers/media/platform/marvell/mcam-core.c:1873: undefined reference
>    to `v4l2_async_nf_register'
> 
> Add explicit dependency on CONFIG_V4L2_ASYNC to mute ld errors.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402130955.f6uxzdCA-lkp@intel.com/
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>

This is a duplicate of:

https://patchwork.linuxtv.org/project/linux-media/patch/20240213095555.454392-1-arnd@kernel.org/

The ov7670 undefined reference has been resolved quite some time ago, this
kernel test robot build is from a 6 months old tree.

I'll take Arnd's patch instead of yours.

Regards,

	Hans

> ---
>  drivers/media/i2c/Kconfig              | 1 +
>  drivers/media/platform/marvell/Kconfig | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
> index 4c3435921f19..453cb4b81d6f 100644
> --- a/drivers/media/i2c/Kconfig
> +++ b/drivers/media/i2c/Kconfig
> @@ -523,6 +523,7 @@ config VIDEO_OV7640
>  	  module will be called ov7640.
>  
>  config VIDEO_OV7670
> +	select V4L2_ASYNC
>  	tristate "OmniVision OV7670 sensor support"
>  	help
>  	  This is a Video4Linux2 sensor driver for the OmniVision
> diff --git a/drivers/media/platform/marvell/Kconfig b/drivers/media/platform/marvell/Kconfig
> index d6499ffe30e8..48f5484478a0 100644
> --- a/drivers/media/platform/marvell/Kconfig
> +++ b/drivers/media/platform/marvell/Kconfig
> @@ -11,6 +11,7 @@ config VIDEO_CAFE_CCIC
>  	select VIDEOBUF2_VMALLOC
>  	select VIDEOBUF2_DMA_CONTIG
>  	select VIDEOBUF2_DMA_SG
> +	select V4L2_ASYNC
>  	help
>  	  This is a video4linux2 driver for the Marvell 88ALP01 integrated
>  	  CMOS camera controller.  This is the controller found on first-
> @@ -27,6 +28,7 @@ config VIDEO_MMP_CAMERA
>  	select VIDEOBUF2_VMALLOC
>  	select VIDEOBUF2_DMA_CONTIG
>  	select VIDEOBUF2_DMA_SG
> +	select V4L2_ASYNC
>  	help
>  	  This is a Video4Linux2 driver for the integrated camera
>  	  controller found on Marvell Armada 610 application


