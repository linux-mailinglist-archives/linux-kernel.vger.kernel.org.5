Return-Path: <linux-kernel+bounces-135572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5719689C7C1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB341F2321B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8309713F44B;
	Mon,  8 Apr 2024 15:05:25 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B2E13F425;
	Mon,  8 Apr 2024 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712588725; cv=none; b=p52/rjkAHWmJT/4Qf/0IXmfLARAYG86rjnPq/e54q8f4leyTjyx4Spku4BR/FFHpCWacLvJXMT6Rp6aNKI82xY98oOkawhSUXEetbIsnxqjs5UtBujHDht0u0x18iUP0/RsBpK4EKc6r83tTTN/vq4suX0ZCVjDY5IW3VLENsi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712588725; c=relaxed/simple;
	bh=JQQaCwBNLuDCVNbN4RvS+OFwumZuXU9MQIz0FYSG1zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RWw7aE1No/P56GxbsarKgAPp6n8lduR/M+VdsHKr/2BLiYLSr+CunU483irALweFWAhE8VrkoQOdUu7OqdALEKid2TYYqmgfLHlmhmoh6VR79Cw+OxlhEVvTv0X7YAp649ki31SsnN5IFZ3Oli6z4ZE8ciei36beyT204qXs6ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e8616c3.versanet.de ([94.134.22.195] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rtqYK-0007Xz-Fd; Mon, 08 Apr 2024 17:04:56 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>, Jonas Karlman <jonas@kwiboo.se>
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject:
 Re: [PATCH 1/1] arm64: dts: rockchip: enable onboard spi flash for rock-3a
Date: Mon, 08 Apr 2024 17:04:55 +0200
Message-ID: <3066222.xgJ6IN8ObU@diego>
In-Reply-To: <b32c284e-f3ec-44b0-abbd-7fa403bc9870@kwiboo.se>
References:
 <20240408124005.182565-1-amadeus@jmu.edu.cn>
 <421ab43b-ff92-41c6-9904-3c7681c926be@kwiboo.se>
 <b32c284e-f3ec-44b0-abbd-7fa403bc9870@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Montag, 8. April 2024, 16:56:59 CEST schrieb Jonas Karlman:
> On 2024-04-08 16:44, Jonas Karlman wrote:
> > On 2024-04-08 14:40, Chukun Pan wrote:
> >> There is a mx25u12835f spi flash on this board, enable it.
> >>
> >> [    2.525805] spi-nor spi4.0: mx25u12835f (16384 Kbytes)
> >>
> >> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> >> ---
> >>  arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> >> index a5e974ea659e..d8738cc47c73 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> >> @@ -757,6 +757,18 @@ &sdmmc2 {
> >>  	status = "okay";
> >>  };
> >>  
> >> +&sfc {
> > 
> > This is missing:
> > 
> > 	#address-cells = <1>;
> > 	#size-cells = <0>;
> > 
> >> +	status = "okay";
> >> +
> >> +	flash@0 {
> >> +		compatible = "jedec,spi-nor";
> >> +		reg = <0x0>;
> >> +		spi-max-frequency = <50000000>;
> > 
> > At least in U-Boot the spi clock only support 24, 100 or 200 mhz and I
> > am pretty sure the spi flash support 100mhz, so I would suggest you test
> > with 100mhz, same as used on other rk356x boards.
> 
> Sorry, looked at spi clock instead of sfc clock.
> sfc clock support 24, 50, 75, 100, 125 and 150 mhz.

I think in some previous discussion the agreement was that the node
should specify the max frequency the flash supports and have the
controller worry about its own clock ranges.

Though in this case the 50MHz for the flash even matches the clock
frequency supported by the sfc



