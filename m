Return-Path: <linux-kernel+bounces-32428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE599835BB0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77849284D1E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E35E12E4B;
	Mon, 22 Jan 2024 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEls0NK8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F49FBE1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705908860; cv=none; b=tTdKxnfNPzjhd2OyBO2d+7RHarsO3WxMrZCsh7nOvdsxOdBLe7zPCgryBMziEvt2kUs2nGuPah5UaTUHdHjk41MQ6/g79NC/oV7AtpxZCaDBvCD71BleYt3rSIFXpgyu6w7WSIan2SBi54Mqz/WNiHyTFPRluB/9NJTUJBL3Hok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705908860; c=relaxed/simple;
	bh=FMSjJS1WV5njtl/Y28CewL/VTjUBcIvACGaXMr5ZtWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIosu/83oee+/IbINWYovrr3KeYuDIJEoinTWyyD6YpclyOLOx2xVaSrgiIaF3cGLuj7ik9AgajF9z+i4dOT4TnTxtMBjJcVcxCVmZNB8KR0DGaevS3uIuaGQtYrUCbE8cJbpBjDho/LtuBzscH3Mw2uGltfRpsyCFTHGCLbP7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEls0NK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D25C433F1;
	Mon, 22 Jan 2024 07:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705908860;
	bh=FMSjJS1WV5njtl/Y28CewL/VTjUBcIvACGaXMr5ZtWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEls0NK8UEGPwSV9O5f0KT6MWVj03wkHBHN8PBWz8ns6/D3b/srmK4/3wbmH+V4uQ
	 FFqAB5aEgMk8pQxWeLXwII9rhB/8Xm1j+WHxC4HufIsJJ0ZGdKXmGjCHbvHpF4nYAy
	 +BE3Z3RqEGW4YH6K28Pva9ESUeR6U98z4jcXC09CrgNOuxoyOfRiQ7/XPvMCwIk3Lk
	 wocjF8NhI1B/1cAcejUjRSPOkogeZWVd45so/OsHuCDFWKYlnecPY4cQT76OTgbzJG
	 WUi508pRBTPTOMt2X9lDajOmvbpnit3kIjah7WPMVMXTsJK8vBsOAPAFuNIQ38OjWY
	 G2G+NX9zCOJDw==
Date: Mon, 22 Jan 2024 13:04:16 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.intel.com, Basavaraj.Hiregoudar@amd.com,
	Sunil-kumar.Dommati@amd.com, vinod.koul@intel.com,
	venkataprasad.potturu@amd.com,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 02/13] drivers: soundwire: amd: update license
Message-ID: <Za4aeN7vJ-Ln2fxA@matsya>
References: <20240110094416.853610-1-Vijendar.Mukunda@amd.com>
 <20240110094416.853610-3-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110094416.853610-3-Vijendar.Mukunda@amd.com>

On 10-01-24, 15:14, Vijendar Mukunda wrote:

Why is the title "drivers: soundwire: "

git log drivers/soundwire/amd*
Tells me you didnt do that in past why now..?

> Update license to dual license to align with Sound Open Firmware (SOF)
> driver as SOF uses dual license.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  drivers/soundwire/amd_manager.c   | 4 ++--
>  drivers/soundwire/amd_manager.h   | 2 +-
>  include/linux/soundwire/sdw_amd.h | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
> index 3a99f6dcdfaf..afa2d83b7e69 100644
> --- a/drivers/soundwire/amd_manager.c
> +++ b/drivers/soundwire/amd_manager.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>  /*
>   * SoundWire AMD Manager driver
>   *
> @@ -1207,5 +1207,5 @@ module_platform_driver(amd_sdw_driver);
>  
>  MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
>  MODULE_DESCRIPTION("AMD SoundWire driver");
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("Dual BSD/GPL");
>  MODULE_ALIAS("platform:" DRV_NAME);
> diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
> index 5f040151a259..f57165bbb9d9 100644
> --- a/drivers/soundwire/amd_manager.h
> +++ b/drivers/soundwire/amd_manager.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
>  /*
>   * Copyright (C) 2023 Advanced Micro Devices, Inc. All rights reserved.
>   */
> diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
> index 41dd64941cef..56b4117c087a 100644
> --- a/include/linux/soundwire/sdw_amd.h
> +++ b/include/linux/soundwire/sdw_amd.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
>  /*
>   * Copyright (C) 2023 Advanced Micro Devices, Inc. All rights reserved.
>   */
> -- 
> 2.34.1

-- 
~Vinod

