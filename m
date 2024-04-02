Return-Path: <linux-kernel+bounces-127551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B026894D88
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B3A9B22C43
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398D157880;
	Tue,  2 Apr 2024 08:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Hh/PhP4d"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919F11772D;
	Tue,  2 Apr 2024 08:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712046692; cv=none; b=kf3b0Q0fRce4RFGP6fJRDOMmiZNSq2a2CO9Vq9kRslEmNqObAN/BVOdx7fe0m2LCX1GRzusneTcNL+Do9defooR02zNYaDPNGjkJlxbGfDQCBkz8FE7ZtGlaRTB0wzNN6LJRYbIxdd+a36pLKRkQ9PL8DW/vRSLuMwrlHzqfqT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712046692; c=relaxed/simple;
	bh=JY4ED/+4PB+ORvPhQlRpW0Q8Y/u6TEuHgOSWHoB9PyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZV74kLTmqQMHeKc7t4d5+Z3SMqsv+dDa2g60412u/mcs54gXSlHsWVoEI2aouhghMD7yo5i2ibkzU7YR46LL4WrwHjsHmHX+kYKsRSWkH33IN2Ace9vf5viObWfU2z7P4sa5JriVU1ckfwsKZVJQNpV6AOMHZn1mQfp/XmJ1tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Hh/PhP4d; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.1.105] (unknown [103.86.18.232])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7E76F3A2;
	Tue,  2 Apr 2024 10:30:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712046652;
	bh=JY4ED/+4PB+ORvPhQlRpW0Q8Y/u6TEuHgOSWHoB9PyU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hh/PhP4d4ueDNpTQV+YLPys/QUg62YZlGeyWuDc92InrrZp31Bj76VZ32egn/IqOL
	 8FW7vfPHswmCUhzEaG0UJknBC2uRKxpc/UEW4VPAOiqKJpycD4m49z+bGbCn4aR2oi
	 jVEd8pAT/deK0ulsos7TG6lrqnNXpt32tFtIuhec=
Message-ID: <d46380d7-e296-445b-a294-b0231ea45518@ideasonboard.com>
Date: Tue, 2 Apr 2024 14:01:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] media: i2c: Add imx283 camera sensor driver
To: Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20240402-kernel-name-extraversion-v1-0-57bb38de841b@ideasonboard.com>
Content-Language: en-US
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20240402-kernel-name-extraversion-v1-0-57bb38de841b@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

PLease ignore the series, I was testing/learning the b4 tool.

I did pass --offline-mode but it has sent the patches anyway :-//

On 02/04/24 1:59 pm, Umang Jain wrote:
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
> Changes in v4:
> - fix 32-bit build error around u64 divisions (use do_div)
> - Fix hmax default and minimum values
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
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
> Kieran Bingham (1):
>        media: i2c: Add imx283 camera sensor driver
>
> Umang Jain (2):
>        media: dt-bindings: media: Add bindings for IMX283
>        fixups
>
>   .../devicetree/bindings/media/i2c/sony,imx283.yaml |  107 ++
>   MAINTAINERS                                        |    9 +
>   drivers/media/i2c/Kconfig                          |   10 +
>   drivers/media/i2c/Makefile                         |    1 +
>   drivers/media/i2c/imx283.c                         | 1605 ++++++++++++++++++++
>   5 files changed, 1732 insertions(+)
> ---
> base-commit: 54ee11761885407056f4ca60309739e2db6b02dc
> change-id: 20240402-kernel-name-extraversion-2b08d441e08c
>
> Best regards,


