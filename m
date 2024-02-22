Return-Path: <linux-kernel+bounces-76701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2102485FB42
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11AD21C2123F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E94D1482FD;
	Thu, 22 Feb 2024 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FICcqJjW"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEDF1474D0;
	Thu, 22 Feb 2024 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708612202; cv=none; b=GylnuzZ5WPYTwLeblDwk+ijd2aTbWSiv+tXpZfFOMkTXTHvF81tM+IXeocXVrhzzgLmq14e8UmDJ24HDdrVX+bq+3YV5iTCv1kjhaVTf3sxD78198yrdQp6ZxKh2wYDIyyFF/SOZuhAwdzf+lppLWeF9OcRqey4BqR3+FuH6sJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708612202; c=relaxed/simple;
	bh=eVT6NRXuFee0b5qT1stFSBw6MLt6eYJNdZ0wkAk4zvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FjLyxboF9fKusNECD6WgMR/KnsTA11OB/RB//3JfeUJTAoARIiaMSW3xsuih/GvPbd54SypPxhLwEuEEdOiA5zCT2dv2Z4WfWf8mdJ6sjDjkN2Bru1gx+Y2h2KTsPxbfx+VbLuOBTx8TQvKoHNvURVPlbVJulI9SsLuHmzy3DUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FICcqJjW; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708612196;
	bh=eVT6NRXuFee0b5qT1stFSBw6MLt6eYJNdZ0wkAk4zvE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FICcqJjWCoyNQyb/649yHJNbZ1FUOhDVyNw1DHCIRzS/ll5j+mw+39USh8Qo6zOf6
	 kGfy79xPRtuor6C54lXoJZvqYjle760NG8W8EM9fO/5e4eVbhyMfh117fn8Tp0WWwC
	 ROsAK9uW2iHp7nJOSQOSLdG1fYMXVcqPf8nxlODTs+XR4FDiILqTfHMkzMjKm3hi2R
	 RZywMTZHPltOSlRp8MpdDBYHEpnBHm6APrck0/xnBxjv+rbTgdE2vdgO0xzxqGQANF
	 n3s1AvbUxMfYu8xly5Yl9VSEl9UxDRz9ywUgklHHjC/XOAlrZ6p1LETRHEL0xWDXKd
	 nftCxXkVKHQHA==
Received: from [100.74.67.65] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 827A3378206B;
	Thu, 22 Feb 2024 14:29:55 +0000 (UTC)
Message-ID: <766a4e5b-01fc-4fee-affa-9921ed7cd8f3@collabora.com>
Date: Thu, 22 Feb 2024 15:29:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 02/21] media: cadence: csi2rx: configure DPHY before
 starting source stream
Content-Language: en-US
To: Jai Luthra <j-luthra@ti.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, Vaishnav Achath
 <vaishnav.a@ti.com>, Maxime Ripard <mripard@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Changhuang Liang <changhuang.liang@starfivetech.com>,
 Jack Zhu <jack.zhu@starfivetech.com>, Jayshri Pawar <jpawar@cadence.com>
References: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
 <20240222-multistream-v1-2-1837ed916eeb@ti.com>
From: Julien Massot <julien.massot@collabora.com>
In-Reply-To: <20240222-multistream-v1-2-1837ed916eeb@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jai,

On 2/22/24 12:31, Jai Luthra wrote:
> From: Pratyush Yadav <p.yadav@ti.com>
> 
> When the source device is operating above 1.5 Gbps per lane, it needs to
> send the Skew Calibration Sequence before sending any HS data. If the
> DPHY is initialized after the source stream is started, then it might
> miss the sequence and not be able to receive data properly. Move the
> start of source subdev to the end of the sequence to make sure
> everything is ready to receive data before the source starts streaming.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Signed-off-by: Jai Luthra <j-luthra@ti.com>

Thanks for your patch!
This patch is useful even at lower data rate than 1.5 Gbps.
I'm having the issue at 800Mbps with max96714F deserializer.

Should this patch deserve a Fixes tag?
Fixes: 3295cf1241d3 ("media: cadence: Add support for external dphy")

Reviewed-by: Julien Massot <julien.massot@collabora.com>
Tested-by: Julien Massot <julien.massot@collabora.com>

> ---
>   drivers/media/platform/cadence/cdns-csi2rx.c | 26 ++++++++++++++------------
>   1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> index 70b7f8a9e4f2..75e602c1d762 100644
> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> @@ -243,10 +243,6 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
>   
>   	writel(reg, csi2rx->base + CSI2RX_STATIC_CFG_REG);
>   
> -	ret = v4l2_subdev_call(csi2rx->source_subdev, video, s_stream, true);
> -	if (ret)
> -		goto err_disable_pclk;
> -
>   	/* Enable DPHY clk and data lanes. */
>   	if (csi2rx->dphy) {
>   		reg = CSI2RX_DPHY_CL_EN | CSI2RX_DPHY_CL_RST;
> @@ -256,6 +252,13 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
>   		}
>   
>   		writel(reg, csi2rx->base + CSI2RX_DPHY_LANE_CTRL_REG);
> +
> +		ret = csi2rx_configure_ext_dphy(csi2rx);
> +		if (ret) {
> +			dev_err(csi2rx->dev,
> +				"Failed to configure external DPHY: %d\n", ret);
> +			goto err_disable_pclk;
> +		}
>   	}
>   
>   	/*
> @@ -295,14 +298,9 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
>   
>   	reset_control_deassert(csi2rx->sys_rst);
>   
> -	if (csi2rx->dphy) {
> -		ret = csi2rx_configure_ext_dphy(csi2rx);
> -		if (ret) {
> -			dev_err(csi2rx->dev,
> -				"Failed to configure external DPHY: %d\n", ret);
> -			goto err_disable_sysclk;
> -		}
> -	}
> +	ret = v4l2_subdev_call(csi2rx->source_subdev, video, s_stream, true);
> +	if (ret)
> +		goto err_disable_sysclk;
>   
>   	clk_disable_unprepare(csi2rx->p_clk);
>   
> @@ -316,6 +314,10 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
>   		clk_disable_unprepare(csi2rx->pixel_clk[i - 1]);
>   	}
>   
> +	if (csi2rx->dphy) {
> +		writel(0, csi2rx->base + CSI2RX_DPHY_LANE_CTRL_REG);
> +		phy_power_off(csi2rx->dphy);
> +	}
>   err_disable_pclk:
>   	clk_disable_unprepare(csi2rx->p_clk);
>   
> 

-- 
Julien Massot
Senior Software Engineer
Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

