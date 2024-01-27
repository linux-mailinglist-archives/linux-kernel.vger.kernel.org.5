Return-Path: <linux-kernel+bounces-41188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB2483ED2A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD9D1F22777
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 13:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3EB25602;
	Sat, 27 Jan 2024 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="myTKKSpI"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9DF25767;
	Sat, 27 Jan 2024 13:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706360861; cv=none; b=Pz8kiGaYdsTcyv7ndJsVQppfVDfvO2Vlrhp7PAEmhjJn3AD43oysg1WNWqcxz0JS1sY53cezKR0j5Cr/iST9tHk4BVM/8PZxCZs2z/2Tk92XcyjibAl4QPBFMuj1WPf/0TGJS21V81XRwsQykv3plhd/wzqrpXLp68L4SAUPEwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706360861; c=relaxed/simple;
	bh=VdDVrcmnVLhEnRhxTWbAnTZr+VR7An2f/2UozYO++mE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KiHzT7EMLWGvtUebFEvE125tn6ZLDTqMQfwHJoMGf+0aMm9uhfQ/f8YX5nNICnHjXUyifJQqmjwM9RKfoWt6e/SgAD3FxbBfR+p72N15GDd0qFrlo6GYzYd/7XxDKcebL1okNbbO3s8cS0hLFPQO0YmgsawAK9ibkFSnSU9Qz4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=myTKKSpI; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706360857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NWFCJoKsrjTpLmlUTqh23lBnyqiCJSoh/6mW7sdVJc=;
	b=myTKKSpItOZgqMHfDMdRpPGMEAXHCRByEjKeT72UXSP6WQnnZBINs/1AoB0lGwv2JjWD+T
	hayovHfO0DY4lISK4r0LAsykYNOCazvAMJC3wSdIgFcSONdwmugutF9BCDx35+cW3UaTgL
	c0ocZmre3zRaG1T6NS9GKZUtkIjQ6jn1dK1Vq8p/jOaxf552RKDvLr0xZvZFSrOMyo9em2
	EZMfzPAGS6DDO9b6ZvFpQUfi62hesPtXavnIlTQ55N6kzNrMDBDcYI0T7KJcn9GjCUVAqd
	3s9TpSpphBmNNb55ZBdrlqczEa13mD2zU5V4oOmSHAHhwgafhC4ATA6cioscPg==
Date: Sat, 27 Jan 2024 14:07:36 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/4] arm64: dts: rockchip: aliase sdmmc as mmc1 for Cool
 Pi CM5 EVB
In-Reply-To: <20240127092034.887085-2-andyshrk@163.com>
References: <20240127092034.887085-1-andyshrk@163.com>
 <20240127092034.887085-2-andyshrk@163.com>
Message-ID: <8fbc0caf535e24e86c8b2458b63a130c@manjaro.org>
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
> Fixes: 791c154c3982 ("arm64: dts: rockchip: Add support for rk3588
> based board Cool Pi CM5 EVB")
> Signed-off-by: Andy Yan <andyshrk@163.com>

Makes sense to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
> 
>  arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
> index 0b02f4d6e003..cce1c8e83587 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
> @@ -16,8 +16,8 @@ / {
> 
>  	aliases {
>  		mmc0 = &sdhci;
> -		mmc1 = &sdio;
> -		mmc2 = &sdmmc;
> +		mmc1 = &sdmmc;
> +		mmc2 = &sdio;
>  		serial2 = &uart2;
>  	};

