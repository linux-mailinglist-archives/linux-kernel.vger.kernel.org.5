Return-Path: <linux-kernel+bounces-126354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5299C893584
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 21:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2931C21D09
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840641474B7;
	Sun, 31 Mar 2024 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="VgWn/Atb"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B917D4369A;
	Sun, 31 Mar 2024 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711912497; cv=none; b=AubCnFPCiZTL5Oo8HHYCPNqqPZhrEZQlzKcK/7NEaCfRzpQdxyi1LSMD498H5dfZ/gIaf5bWFP/AqiQh6zD4lD4BPR9vf1itbc7WgzbMYGYQDrICpKa1P41h9u4Il2RJTgwLegUBTcTnlvnRm25M05EcbMyY2V9UhpR7dz3WtyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711912497; c=relaxed/simple;
	bh=4XfDyaQ9bya6jdRl1VsE2e280IWYoB8Rrf67+vm7OK0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=g1EXIoOgpI8VPQmVW+mu2Kt3kX8ZzCgSShRYxhar3wKb+uRgkaPDz9R3uqDBmEsVcw1iU3bWloeFPWLtYQRZ1Tzc5FiMq477ht4XZlF1JuC/vLtVxlwkXe5PbWDuf7epuu32tyVWVEYS8VSNAk9vIpWZVdfuks1+K/dGuFXxy2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=VgWn/Atb; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711912492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qn2MVzEDKVFO1DX6f7CmDPOEzy2LVdncSew+2Dkz+C8=;
	b=VgWn/AtbPVFaqgm6OePTFe0S598DRZW/QlL8nvS2/8Pg+jB8eDy1X7+X/2O//9KjfmCefq
	UzE0VkBzQPcaqgz9U6/vSn1npKTAX4cgjIZiCJGF3TNedEryR6OJ4bp49elXc0EpXawoUa
	6ObzNNMEJhdEs3H4gWETP5QZdSBa6ya/ADBgjWALKAc7jz44eEfP15nXIAsF9n/2AhGoTO
	aDVM/5Q8m61jrGAzEAWXEEmyJcjJdncz1miyYt+Uyrii28Bo375isRd2P85Bp/ZHLKxwzY
	ccCcgIsysqK+BHhjDpeHkmQzTnyEnEAQr5P/j4y+yJ/bs8xTe3j472Up/R4Riw==
Date: Sun, 31 Mar 2024 21:14:52 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Folker Schwesinger <dev@folker-schwesinger.de>
Cc: Vinod Koul <vkoul@kernel.org>, Yogesh Hegde <yogi.kernel@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>, Chris Ruehl <chris.ruehl@gtsys.com.hk>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Christopher Obbard <chris.obbard@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add enable-strobe-pulldown to
 emmc phy on ROCK 4C+
In-Reply-To: <20240327192641.14220-3-dev@folker-schwesinger.de>
References: <20240327192641.14220-1-dev@folker-schwesinger.de>
 <20240327192641.14220-3-dev@folker-schwesinger.de>
Message-ID: <5da4c8a299f9987e7a0f91549d6e0206@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-27 20:26, Folker Schwesinger wrote:
> Commit 8b5c2b45b8f0 disabled the internal pull-down for the strobe line
> causing I/O errors in HS400 mode for various eMMC modules.
> 
> Enable the internal strobe pull-down for the ROCK 4C+ board. Also 
> re-enable
> HS400 mode, that was replaced with HS200 mode as a workaround for the
> stability issues in:
> 2bd1d2dd808c ("arm64: dts: rockchip: Disable HS400 for eMMC on ROCK 
> 4C+").
> 
> Fixes: 8b5c2b45b8f0 ("phy: rockchip: set pulldown for strobe line in 
> dts")
> Signed-off-by: Folker Schwesinger <dev@folker-schwesinger.de>

Looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts
> b/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts
> index 7baf9d1b22fd..972aea843afd 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts
> @@ -151,6 +151,7 @@ &cpu_b1 {
>  };
> 
>  &emmc_phy {
> +	rockchip,enable-strobe-pulldown;
>  	status = "okay";
>  };
> 
> @@ -549,7 +550,8 @@ &saradc {
>  &sdhci {
>  	max-frequency = <150000000>;
>  	bus-width = <8>;
> -	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
> +	mmc-hs400-enhanced-strobe;
>  	non-removable;
>  	status = "okay";
>  };

