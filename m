Return-Path: <linux-kernel+bounces-126356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 778F0893593
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 21:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4D11F230FA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA53C1474AB;
	Sun, 31 Mar 2024 19:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="sAQzvu77"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601C61465A2;
	Sun, 31 Mar 2024 19:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711912965; cv=none; b=nx2CU5B7dsF7bpx0B8JTibwDIyFajeKimdoUzlvGm1bLBxedHED3XOMK8AgaFrKFRWoElVB9A3i+ZBIu5J8z79RX6Ir6k5vesygMXXeb1LXmpIynXwxlnCT3hHf/iWPthLesF1QSJpIsf6s15JikNT5ZeUuUd1E/7G7t3vxrLgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711912965; c=relaxed/simple;
	bh=WKVHeP66kFTRktX7k2f2mUWgSFyBKbvOLpB0tC3Wi2k=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=F0/a6IhpHm2YJfZCRX/q/AGZPGT84A19pvXUn2P+DlaB2SyDqEQD6l0lpy3QOkOQJLO5/A9NIRDRIEFb5bcsTxC0uVH9+kOySNVm88drzwDH7PN6NPhkzwvPYqdcD5NQy6L2aZogPMTim22DiUBSPBFyfSvEWsgfvzMbCZNWCR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=sAQzvu77; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711912469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OlRjQH5mzHvnoGJJbl73nKh6pzQqm/NFoJCNeZ2UIfA=;
	b=sAQzvu77PsDyTWExc6QexiCdxZnVrro+QcyOOCuSWQNw4PoJVMAEycsFHfL7FO/yYCHhJL
	OcwActpQQa8w+OOsve30gyiLXhHt/9dtSrwRcoVW9gGpgqQsvZ5D2ViGEu0d7Dob9SOekS
	wM1C/h1ZRuuHYJ20S7TqVPdLGo54WykRQQp4QVhWFYhq8c9IMR+OFcN8RyBgOmds+kUvPL
	80FAwyC2y7ygRfyJEzoJ8BR4MVD23a6nluJJ8BmU+J3ExkHuX1TTCsnGkKkzu9MdBZZQL/
	LUwrmF+xwx/2UXV/87CYZpkDhR4fDb2kZ6Ucu0vewkZRAqvdGB3Zf0rPcSBy1g==
Date: Sun, 31 Mar 2024 21:14:26 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Folker Schwesinger <dev@folker-schwesinger.de>
Cc: Vinod Koul <vkoul@kernel.org>, Yogesh Hegde <yogi.kernel@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>, Chris Ruehl <chris.ruehl@gtsys.com.hk>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Christopher Obbard <chris.obbard@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: Add enable-strobe-pulldown to
 emmc phy on ROCK Pi 4
In-Reply-To: <20240327192641.14220-2-dev@folker-schwesinger.de>
References: <20240327192641.14220-1-dev@folker-schwesinger.de>
 <20240327192641.14220-2-dev@folker-schwesinger.de>
Message-ID: <2a07639d8d84ec4443c8aeb84b6260f4@manjaro.org>
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
> Enable the internal strobe pull-down for ROCK Pi 4 boards. Also 
> re-enable
> HS400 mode, that was replaced with HS200 mode as a workaround for the
> stability issues in:
> cee572756aa2 ("arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi 
> 4").
> 
> This was tested on ROCK 4SE and ROCK Pi 4B+.
> 
> Fixes: 8b5c2b45b8f0 ("phy: rockchip: set pulldown for strobe line in 
> dts")
> Signed-off-by: Folker Schwesinger <dev@folker-schwesinger.de>

Looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> index 281a12180703..b9d6284bb804 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> @@ -194,6 +194,7 @@ &cpu_b1 {
>  };
> 
>  &emmc_phy {
> +	rockchip,enable-strobe-pulldown;
>  	status = "okay";
>  };
> 
> @@ -648,7 +649,8 @@ &saradc {
>  &sdhci {
>  	max-frequency = <150000000>;
>  	bus-width = <8>;
> -	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
> +	mmc-hs400-enhanced-strobe;
>  	non-removable;
>  	status = "okay";
>  };

