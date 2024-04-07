Return-Path: <linux-kernel+bounces-134596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A7E89B35C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4154A1C21295
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFE93BBD6;
	Sun,  7 Apr 2024 17:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="oGsnrqIR"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4C43AC0C;
	Sun,  7 Apr 2024 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712511997; cv=none; b=XTCG43am+R/HmlKQkkG7OUxsK42HbYMgZPcgEmGG1Nz5vbN65qMXs3w8qj74ozGInL9r+jGMPNE+onN7agCbQ6RKJI2YH7mt0mNs9hp0NBpb74OO+eERIwDgsyLVFSKNlFYH5fOv3X9TmnVe+TuwNDczIx+Y3/irJVTXqultF0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712511997; c=relaxed/simple;
	bh=wS0Kf9GMR29AKfGXnkeq+MMuWkzI46z6LdicyuJ79IE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=LtlPCQEXRGHruXqTDFqLK9iEQj0HRj4Y7hroVWIP63KlgYhY5dZ/we00sdWlMkGaMQnjxWi5V8hANHt2wsJKXhZYyNaOwZw/nMJDtzlQN6zZ95SmuPlh0gpUeDA9O13sQGK1XghD8rn1TdcxSlTWe8lKZjecNByyc0Aw+GAWBwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=oGsnrqIR; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712511992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iQ0RagVYlpoPCOEVbhL/XEghMJXfL6hPUtcOCd5OGRs=;
	b=oGsnrqIRNGRlLM3EkygQhgdBR5bwCsZNnXfXnwrjL3RwVRav1uvLDjcZST3k/keAjhT0Gx
	SOzxCmNtzBoujd6+9/L0XQXQTTbV5C3npoRMhyVaEn9ISPcsdx7ZXbtKTneCPAkaT08Ccs
	fM6TKVB6Xg7rNRj/TKoUrs9Em6DaIJFZL46r5GTjn4gM6ak37glpHG22fUOSSXMUxr3S1s
	LoiB2h3bXpD5IKY4EWztqPna0ePZwfc90PB5egRweQm95Xw3CrjCI8lwKobSZJI/i666c6
	oPcOEfj1ndMuwK3XbbQQZQOsNx6j23H1blZ08VXWXD5SEZexkpljARW4KtoHug==
Date: Sun, 07 Apr 2024 19:46:31 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: efectn@6tel.net
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 sebastian.reichel@collabora.com, Muhammed Efe Cetin <efectn@protonmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: mark system power controller and
 fix typo on orangepi-5-plus
In-Reply-To: <20240407173210.372585-1-efectn@6tel.net>
References: <20240407173210.372585-1-efectn@6tel.net>
Message-ID: <fe326de6e370fa98f89751f9bb69e2af@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-07 19:32, efectn@6tel.net wrote:
> From: Muhammed Efe Cetin <efectn@protonmail.com>
> 
> Mark the PMIC as system power controller, so the board will shut-down
> properly and fix the typo on rk806_dvs1_null pins property.
> 
> Fixes: 236d225e1ee7 ("arm64: dts: rockchip: Add board device tree for
> rk3588-orangepi-5-plus")
> Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>

Looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> index 1b606ea5b6cf..1a604429fb26 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> @@ -485,6 +485,7 @@ pmic@0 {
>  		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
>  			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
>  		spi-max-frequency = <1000000>;
> +		system-power-controller;
> 
>  		vcc1-supply = <&vcc5v0_sys>;
>  		vcc2-supply = <&vcc5v0_sys>;
> @@ -506,7 +507,7 @@ pmic@0 {
>  		#gpio-cells = <2>;
> 
>  		rk806_dvs1_null: dvs1-null-pins {
> -			pins = "gpio_pwrctrl2";
> +			pins = "gpio_pwrctrl1";
>  			function = "pin_fun0";
>  		};

