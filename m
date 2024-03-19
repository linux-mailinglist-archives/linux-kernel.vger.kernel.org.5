Return-Path: <linux-kernel+bounces-107577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 479A687FE6B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14831F2472F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B9283CD0;
	Tue, 19 Mar 2024 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OQUTd8Iv"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BA183CAE;
	Tue, 19 Mar 2024 13:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710853820; cv=none; b=XzGRX+r/wUZwV7HfQhFiMPnwwjPPrbPq5w+Q/aT2dyR2eyu1jCIxckI+qdp0wfJ9UimVKuEWwmHVAahD3i/WHPJ3v5BCb3g6wLCltmgztFMXP3QDFTHgIHRn5lswLIhXWRmhImdr6Hsg416TDpY1X0cDkcjVirx+N/9YomsjFN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710853820; c=relaxed/simple;
	bh=SpyapOi+YNjXiDlh3WYtvbhPHkpVL36i0qOTdjclph0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KY5rSWrqv23AMwo+fKWDY/S1jtfV2TZ5VnbubpQOCgvT1U1OZDn5g9dUo/+L5dHAyLFtYDp4dUXosObMvm/g8QCQO+m3tBWiFyalpMFMWmdmadgfVeBIuhgYanFhdDeLcJlAPNBHBfKGyR8pnqzLtmKdVw0Vskl+oSwjG6avw4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=OQUTd8Iv; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.1.105] (unknown [103.86.18.138])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1F756C80;
	Tue, 19 Mar 2024 14:09:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710853788;
	bh=SpyapOi+YNjXiDlh3WYtvbhPHkpVL36i0qOTdjclph0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OQUTd8IvUiJQefhyc0KfsTRBDB2wMr4qpIRGCnB2T8ZQ+ZRzuKmi91XN77DNfsT7V
	 CUoF8VZ9lWbnJHErxDD/O/swhh3/jXwuIPoyH9J3vzU38J1Z0kHsz4sF17YYEUjOZQ
	 7V7XT1mcQUyE/q8ylxXtXoEEl3AIfX6Kks+4EEvk=
Message-ID: <4bb01eb0-bf53-43f2-a488-7959aadacc3b@ideasonboard.com>
Date: Tue, 19 Mar 2024 18:40:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] media: i2c: Add imx283 camera sensor driver
Content-Language: en-US
To: linux-media@vger.kernel.org
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 willl will <will@willwhang.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, tomi.valkeinen@ideasonboard.com,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 open list <linux-kernel@vger.kernel.org>
References: <20240313070705.91140-1-umang.jain@ideasonboard.com>
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20240313070705.91140-1-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Ping for review and also the streams API streams_mask issue mentioned 
below.

Is anyone interested in looking at this particular issue?

On 13/03/24 12:36 pm, Umang Jain wrote:
> Add a v4l2 subdevice driver for the Sony IMX283 image sensor.
>    
> The IMX283 is a 20MP Diagonal 15.86 mm (Type 1) CMOS Image Sensor with
> Square Pixel for Color Cameras.
>      
> The following features are supported:
> - Manual exposure an gain control support
> - vblank/hblank/link freq control support
> - Test pattern support control
> - Arbitrary horizontal and vertical cropping
> - Supported resolution:
>     - 5472x3648 @ 20fps (SRGGB12)
>     - 5472x3648 @ 25fps (SRGGB10)
>     - 2736x1824 @ 50fps (SRGGB12)
>
> The driver is tested on mainline branch v6.8-rc2 on IMX8MP Debix-SOM-A.
> Additional testing has been done on RPi5 with the downstream BSP.
>
> Changes in v3:
> - fix headers includes
> - Improve #define(s) readability
> - Drop __func__ from error logs
> - Use HZ_PER_MHZ instead of MEGA
> - mdsel* variables should be u8
> - Use container_of_const() instead of container_of()
> - Use clamp() used of clamp_t variant
> - Use streams API imx283_{enable|disable}_streams (**NOTE**)
> - Properly fix PM runtime handling
>    (pm_ptr(), DEFINE_RUNTIME_DEV_PM_OPS,
>     imx283_runtime_suspend, imx283_runtime_resume)
> - Fix format modifiers, signed-ness at various places
>
>
> **NOTE**
> There is streams mask issue, as no routes are defined with 1 pad:
> For testing, I have the following applied locally:
> ```
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 4c6198c48dd6..38545d779620 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -2115,8 +2115,10 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>          if (pad >= sd->entity.num_pads)
>                  return -EINVAL;
>   
> -       if (!streams_mask)
> -               return 0;
> +       if (!streams_mask) {
> +               dev_err(sd->dev, "no streams mask, returning ....\n");
> +               //return 0;
> +       }
>   
>          /* Fallback on .s_stream() if .enable_streams() isn't available. */
>          if (!sd->ops->pad || !sd->ops->pad->enable_streams)
> ```
>
> changes in v2 (summary):
> - Use u32 wherever possible
> - Use MEGA macro instead of self defined MHZ() macro
> - Properly refine regs using CCI
> - Drop tracking of current mode. Shifted to infer from active state directly.
>    (Laurent's review)
> - Cont. from above: Pass the struct imx283_mode to functions whereever required.
> - Remove unused comments
> - Remove custom mutex. Use control handler one instead.
> - Drop imx283_reset_colorspace() and inline
> - Set colorspace field properly (drop _DEFAULTS)
> - Use __maybe_unused for imx283_power_on() and imx283_power_off()
> - Store controls  v4l2_ctrl handles for those required, not all.
> - Drop imx283_free_controls(). Use v4l2_ctrl_handler_free
> - fix reset-gpios handling and add it to DT schema
> - fix data-lanes property in DT schema
> - fix IMX283 Kconfig
> - Remove unused macros
> - Alphabetical case consistency
>
> Kieran Bingham (1):
>    media: i2c: Add imx283 camera sensor driver
>
> Umang Jain (1):
>    media: dt-bindings: media: Add bindings for IMX283
>
>   .../bindings/media/i2c/sony,imx283.yaml       |  107 ++
>   MAINTAINERS                                   |    9 +
>   drivers/media/i2c/Kconfig                     |   10 +
>   drivers/media/i2c/Makefile                    |    1 +
>   drivers/media/i2c/imx283.c                    | 1596 +++++++++++++++++
>   5 files changed, 1723 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx283.yaml
>   create mode 100644 drivers/media/i2c/imx283.c
>


