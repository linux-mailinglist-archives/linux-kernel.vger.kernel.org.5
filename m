Return-Path: <linux-kernel+bounces-41187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2300383ED28
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F7C1C2181E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 13:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2575B25602;
	Sat, 27 Jan 2024 13:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="YGrl7iSk"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9396F1DDFF;
	Sat, 27 Jan 2024 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706360833; cv=none; b=tK4Tcoz/Mk7gfUDA9YXb2mJWpC0fiWgLd8nfxZUdAWQuZci3k5H4U7sFpTf6fpEZ/sCm+T09dwC3aa96h+f4ljJ8bPsfxJpRmkPp8j5IuYqr0XvjvRhFGuhFY+wXiVzc9akkMoZH8BYCRaQ9kCmO/qKzp6xZ7MCuELqEpR0WO8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706360833; c=relaxed/simple;
	bh=JCvoHA0/qZEJ9T70bn2gqXNKKniUNZy/q0IbAmnDqY8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=NIUdeihW29seOEvvCE91rXppfiAW5QFrWJNwFpQjEjKa6wl0IsiyMsQv1ZHXCAsTwjig8kWecXNOg86BgDfOFScRDS5gD9evN/sCK1Xqgri9UaHMiOviDduC/S5QxBKmvIpPaTOXYTCWHHjRYS4WLvO1v/YmeOz4DLun1Yc1WqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=YGrl7iSk; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706360826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bk6+Qt63zpVKPvyd59TSkCFvtJ6XCqIm1CpEdsrrlXQ=;
	b=YGrl7iSkAgKAzurcYoY/JBmDgFQE0odHd3zkM3PxCL83Fa+MKdZDh1Mq3b9/MFZlvQggke
	say9hMDzfc0XCQ/QAPGm8VllGkJUomoCT/5UKfD3Ujo17f932cd0YUb76PGv4inbaA6oJe
	halMkO29kTzipj+WpHcWCo2kCcVPyUigUxpibk244bLAR78FMJrs/UeYgj5DDwohr7Y6q0
	sURPtUyX3WAV8NCI+/LL/dVUnzRCEhgogRp6AKiP/O2qV1yNE/khCl/bCg3WO4cwlTOlOl
	srmG9SxpfHhJlk+Uba6S3SbZEdLWKZnFjUB8LJ4tr3O0EKe/TzkMhwo4BQKc8w==
Date: Sat, 27 Jan 2024 14:07:06 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/4] arm64: dts: rockchip: aliase sdmmc as mmc1 for Cool
 Pi 4B
In-Reply-To: <20240127092034.887085-1-andyshrk@163.com>
References: <20240127092034.887085-1-andyshrk@163.com>
Message-ID: <3e9760ae2dfb48e544b11801f02c2690@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-27 10:20, Andy Yan wrote:
> Follow others rk3588 based boards, and u-boot only use mmc0/1
> as mmc boot targets, so aliase sdmmc as mmc1.
> 
> Fixes: 3f5d336d64d6 ("arm64: dts: rockchip: Add support for rk3588s
> based board Cool Pi 4B")
> Signed-off-by: Andy Yan <andyshrk@163.com>

Makes sense to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
> 
>  arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
> b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
> index 3fae40b9ae1b..3b9d21a6f8bf 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
> @@ -20,8 +20,8 @@ / {
> 
>  	aliases {
>  		mmc0 = &sdhci;
> -		mmc1 = &sdio;
> -		mmc2 = &sdmmc;
> +		mmc1 = &sdmmc;
> +		mmc2 = &sdio;
>  	};
> 
>  	analog-sound {

