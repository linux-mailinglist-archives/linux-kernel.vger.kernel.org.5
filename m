Return-Path: <linux-kernel+bounces-146492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACA58A6601
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4CB41F23601
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1C8154C11;
	Tue, 16 Apr 2024 08:23:24 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837CE84FD4;
	Tue, 16 Apr 2024 08:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713255804; cv=none; b=jczVNOxUDp1ChkZi75z9HJKX3ucFAmrqKYlhbpOADAJuigl/5XjNXO/eAA7HQIhnKZcPGC4wSMwf64Rr6XQgrP9eIvwk6vpQdNBR0w77ps8mDwoi3Dg3LjFcjC1WQu7c6JqWIOKRDf4ITX+x0f2T+BoFQ2NUUlrj3nxdkA16DbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713255804; c=relaxed/simple;
	bh=p68xkyKuBZA7fEKJRalJTGKpkaBVQFxxtFERSe+QPME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZT59JbmKjwz4FDRG65lYhu7M46nQy7aM8LeqMioiUKL9xTc1AkvrzcMgFHiRTSBAuH1XJLkhbUKOcgfaik7cvhcEjbDlYs3HbkTTadUVRltnHsK9yHznKIZo1txDVbdh27dBSKfHw8FmYXyKLwZ1cF2FHx5gUhQvBX3df/qNNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e8616c3.versanet.de ([94.134.22.195] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rwe5z-0006fs-Ci; Tue, 16 Apr 2024 10:23:15 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonas Karlman <jonas@kwiboo.se>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: Add Radxa ZERO 3W/3E
Date: Tue, 16 Apr 2024 10:23:14 +0200
Message-ID: <5772116.DvuYhMxLoT@diego>
In-Reply-To: <f5a9e7c0-1d8c-462b-bf7a-d6aa73f63afa@kwiboo.se>
References:
 <20240415150349.2207075-1-jonas@kwiboo.se>
 <20240415150349.2207075-3-jonas@kwiboo.se>
 <f5a9e7c0-1d8c-462b-bf7a-d6aa73f63afa@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 16. April 2024, 10:05:09 CEST schrieb Jonas Karlman:
> On 2024-04-15 17:03, Jonas Karlman wrote:
> > The Radxa ZERO 3W/3E is an ultra-small, high-performance single board
> > computer based on the Rockchip RK3566, with a compact form factor and
> > rich interfaces.
> > 
> > The ZERO 3W and ZERO 3E are basically the same size and model, but
> > differ only in storage and network interfaces.
> > 
> > - eMMC (3W)
> > - SD-card (both)
> > - Ethernet (3E)
> > - WiFi/BT (3W)
> > 
> > This adds initial support for eMMC, SD-card, Ethernet, HDMI and USB.
> > 
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > ---
> > v2: Add to Makefile
> > v3: Sort hdmi-con and leds nodes alphabetically
> > v3: Sort pmic@20 and regulator@40 nodes by reg
> > v3: Change to regulator-off-in-suspend for vdd_logic
> > 
> > Following issue is reported by dtbs_check and is fixed by patch at [1]:
> > 
> >   hdmi@fe0a0000: Unevaluated properties are not allowed ('#sound-dai-cells' was unexpected)
> >   from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#
> > 
> > [1] https://lore.kernel.org/linux-rockchip/3a035c16-75b5-471d-aa9d-e91c2bb9f8d0@gmail.com/
> > ---
> >  arch/arm64/boot/dts/rockchip/Makefile         |   2 +
> >  .../dts/rockchip/rk3566-radxa-zero-3e.dts     |  41 ++
> >  .../dts/rockchip/rk3566-radxa-zero-3w.dts     |  26 +
> >  .../boot/dts/rockchip/rk3566-radxa-zero3.dtsi | 443 ++++++++++++++++++
> >  4 files changed, 512 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3e.dts
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3w.dts
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-radxa-zero3.dtsi
> > 
> 
> [snip]
> 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero3.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero3.dtsi
> > new file mode 100644
> > index 000000000000..ea8ade3a4c99
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero3.dtsi
> 
> [snip]
> 
> > +
> > +&i2c0 {
> > +	status = "okay";
> > +
> 
> [snip]
> 
> > +	vdd_cpu: regulator@40 {
> > +		compatible = "silergy,syr827";
> 
> After checking once more on schematic and inspecting the board this is
> actually a RK860-0 regulator and should use following:
> 
>   compatible = "rockchip,rk8600";
> 
> Will send a v4 with this change later this week.

ok, will wait for that then.

Heiko



