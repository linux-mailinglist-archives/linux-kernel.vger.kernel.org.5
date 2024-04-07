Return-Path: <linux-kernel+bounces-134339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 624A989B07A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2E82817B3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30AD1CFAF;
	Sun,  7 Apr 2024 10:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Nn+4xQw3"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22A4225A8;
	Sun,  7 Apr 2024 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712486102; cv=none; b=YY799/JIznk+yWe3YZ93cn6lsulCk8xDhItuScAV5xJ8p0zcjT1cX7Wqj1SKl92M1VjOdZU1t5s0Cia4/ANqGTF+VZV6fX9urzVaLclyqIQtGNjVbSMSkv4m2159Mg6kzFq9rhuyrAC5FSsgY7Z+JUX3bPTWQBVmryfSP+YBf0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712486102; c=relaxed/simple;
	bh=VL1e8azOM16bAEF6tCIMCeW2TuGuy/DHc1aHDl6mU20=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=FFZSNiFZh5xMctNZLyVhSCvZS8gWBK7zMt6GIOVsJyRt6wWwkwYV6ATUEWtOYDZujHt2OnVnbmnswVMWMdOl1gZrmGZSQYR34iYP1pylf2H0RFUFdN/voTS+r9p20Pp8GqqIPko4s4FHUyqwfffaQ84XE/+uXJRQxyfsII4lf1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Nn+4xQw3; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712486097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nnkgjIAGlSsg32B6HsyGYPTLxAnBFcSJIms9CJisy9s=;
	b=Nn+4xQw3yv23dlcKZOZ6Ve/hbS9IzxAqXaAJwREqZ4veh/oceQyKaB2e6qr3AQYnJdp8p/
	oCQ3r2AhXkqxg+GituD+jyl8ScN2g3DyQPYuucPhkEE0xP8JlfnjvBE3ULmXs1/0RQ4k/Y
	2Dwk2X3l5u5BNllRUKGo8c/zhZbkIRFfydWNgBiTqbnHxWlMXtlW53S/eqze3vSBAMWlcN
	DQlwvukxpvETalmwV7v5ZVeTqhIfMcZxsjqSicPzzt79jW52aH4BxcE7rgtR83ogP4gb0P
	SxapiRGdDB4M3oKBSD3QTpKazV0nPRHNl5AczVDiH0k2ltmDXPmtxaIBhKhiTg==
Date: Sun, 07 Apr 2024 12:34:57 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: rockchip: drop redundant
 bus-scan-delay-ms in Pinebook
In-Reply-To: <20240407102854.38672-2-krzysztof.kozlowski@linaro.org>
References: <20240407102854.38672-1-krzysztof.kozlowski@linaro.org>
 <20240407102854.38672-2-krzysztof.kozlowski@linaro.org>
Message-ID: <87f751ad473b0fb221357bafff00d462@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Krzysztof,

On 2024-04-07 12:28, Krzysztof Kozlowski wrote:
> There is no "bus-scan-delay-ms" property in the PCI bindings or Linux
> driver, so assume this was copied from downstream.  This fixes
> dtbs_check warning:
> 
>   rk3399-pinebook-pro.dtb: pcie@f8000000: Unevaluated properties are
> not allowed ('bus-scan-delay-ms' was unexpected)

Please note that it's been already deleted. [1]

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=43853e843aa6c3d47ff2b0cce898318839483d05

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> index 054c6a4d1a45..294eb2de263d 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> @@ -779,7 +779,6 @@ &pcie_phy {
>  };
> 
>  &pcie0 {
> -	bus-scan-delay-ms = <1000>;
>  	ep-gpios = <&gpio2 RK_PD4 GPIO_ACTIVE_HIGH>;
>  	num-lanes = <4>;
>  	pinctrl-names = "default";

