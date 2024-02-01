Return-Path: <linux-kernel+bounces-47620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF60845051
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E598E1F26F1B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8528038FBA;
	Thu,  1 Feb 2024 04:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="BjwurPLZ"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458B83A8C5;
	Thu,  1 Feb 2024 04:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706762022; cv=none; b=MdJQyA+Bo/EcCvJKkdWxakAekYHJxRZTzJcnTGcH6lcRfum8kCY1Elt4xWYLvXrW7kpr3BGZJGPh7/gohP3B5DalU5iKSu4YdJvXEThqG8tb86xqNDZ4aOGOQnwMgzTMlz5Y6E7KQNM33Np/inam6e4lDOABaJQapVZiMZ7AM40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706762022; c=relaxed/simple;
	bh=svpo0MdNtx/yQkVM0zdwCyl9XZXkEQKOgAq8FLJLYJI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J3zC5Zkz9ZplHhDTkTnG0kQ6PwcCFTBzYQGrGH2Avw2ORKn/bR+45nd2LHRCyPGylMcoyY2D7qia8HRUkIv9uYjwmq/qV+wz5AXw9x30TRFke64ANqFNavOuB9Wb1iCXBFupQ/Fm6M1OvyrMGZ9fNNGCg3iqsI9QEUQbDtvkAJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=BjwurPLZ; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-76-194.adl-apt-pir-bras31.tpg.internode.on.net [14.2.76.194])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DF516200EF;
	Thu,  1 Feb 2024 12:33:37 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1706762018;
	bh=lBcqegpsp9dEZEdmLm8wG2kv9Gwq3fYLCeomI3yn6lU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BjwurPLZ0/3XT9axSg4fADQzwaSK0SWeSYfWCzJdbpm6O4GH9yKHNiUMyziICeOcX
	 chUczHM9a6c06OFZf8Co82qEf5kMSIvPe2qf919eC2dzPwzSZzhr2GYqX9q18iNhDA
	 DcQORA+RMZtKlQcORJyiHBKjy9G64k0G9YW9n822t9sWQBnrY/KuWxFFhk+wGUztbN
	 5Mwmi0ZPzjehaoUK1c5r3dk+3aj1dP/b+YDbgHI8dDeDSNrZD6MsrA6a6YpbgjyP7Q
	 K9isyB9Trt20+NYEj8ZOMT5GieV7FTQVLpyz0os05N+RxD9CPxtcxSoD0dNPU+tw1K
	 4n5ZJ2tNH/rrw==
Message-ID: <b07068223fbc64c453fde6913edce842647dd2c8.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 09/21] ARM: dts: aspeed: yosemite4: Enable interrupt
 setting for pca9555
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Feb 2024 15:03:37 +1030
In-Reply-To: <20240131084134.328307-10-Delphine_CC_Chiu@wiwynn.com>
References: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240131084134.328307-10-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-31 at 16:41 +0800, Delphine CC Chiu wrote:
> Enable interrupt setting for pca9555
>=20
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
> Changelog:
>   - v4
>     - Revise device node name
>   - v1
>     - enable interrupt setting for pca9555
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 56 +++++++++++++++++--
>  1 file changed, 52 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index cbf385e72e57..4b23e467690f 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -832,30 +832,78 @@ power-sensor@12 {
> =20
>  	gpio@20 {
>  		compatible =3D "nxp,pca9555";
> -		reg =3D <0x20>;
> +		pinctrl-names =3D "default";
>  		gpio-controller;
>  		#gpio-cells =3D <2>;
> +		reg =3D <0x20>;
> +		interrupt-parent =3D <&gpio0>;
> +		interrupts =3D <98 IRQ_TYPE_LEVEL_LOW>;
> +		gpio-line-names =3D
> +		"P48V-OCP-GPIO1","P48V-OCP-GPIO2",
> +		"P48V-OCP-GPIO3","FAN-BOARD-0-REVISION-0-R",
> +		"FAN-BOARD-0-REVISION-1-R","FAN-BOARD-1-REVISION-0-R",
> +		"FAN-BOARD-1-REVISION-1-R","RST-MUX-R-N",
> +		"RST-LED-CONTROL-FAN-BOARD-0-N","RST-LED-CONTROL-FAN-BOARD-1-N",
> +		"RST-IOEXP-FAN-BOARD-0-N","RST-IOEXP-FAN-BOARD-1-N",
> +		"PWRGD-LOAD-SWITCH-FAN-BOARD-0-R","PWRGD-LOAD-SWITCH-FAN-BOARD-1-R",
> +		"","";

Perhaps the addition of the line names should go in a separate patch?
They seem unrelated to the interrupt configuration. The query applies
to the hunks below as well.

>  	};
> =20
>  	gpio@21 {
>  		compatible =3D "nxp,pca9555";
> -		reg =3D <0x21>;
> +		pinctrl-names =3D "default";
>  		gpio-controller;
>  		#gpio-cells =3D <2>;
> +		reg =3D <0x21>;
> +		interrupt-parent =3D <&gpio0>;
> +		interrupts =3D <98 IRQ_TYPE_LEVEL_LOW>;
> +		gpio-line-names =3D
> +		"HSC-OCP-SLOT-ODD-GPIO1","HSC-OCP-SLOT-ODD-GPIO2",
> +		"HSC-OCP-SLOT-ODD-GPIO3","HSC-OCP-SLOT-EVEN-GPIO1",
> +		"HSC-OCP-SLOT-EVEN-GPIO2","HSC-OCP-SLOT-EVEN-GPIO3",
> +		"ADC-TYPE-0-R","ADC-TYPE-1-R",
> +		"MEDUSA-BOARD-REV-0","MEDUSA-BOARD-REV-1",
> +		"MEDUSA-BOARD-REV-2","MEDUSA-BOARD-TYPE",
> +		"DELTA-MODULE-TYPE","P12V-HSC-TYPE",
> +		"","";
>  	};
> =20
>  	gpio@22 {
>  		compatible =3D "nxp,pca9555";
> -		reg =3D <0x22>;
> +		pinctrl-names =3D "default";
>  		gpio-controller;
>  		#gpio-cells =3D <2>;
> +		reg =3D <0x22>;
> +		interrupt-parent =3D <&gpio0>;
> +		interrupts =3D <98 IRQ_TYPE_LEVEL_LOW>;
> +		gpio-line-names =3D
> +		"CARD-TYPE-SLOT1","CARD-TYPE-SLOT2",
> +		"CARD-TYPE-SLOT3","CARD-TYPE-SLOT4",
> +		"CARD-TYPE-SLOT5","CARD-TYPE-SLOT6",
> +		"CARD-TYPE-SLOT7","CARD-TYPE-SLOT8",
> +		"OC-P48V-HSC-0-N","FLT-P48V-HSC-0-N",
> +		"OC-P48V-HSC-1-N","FLT-P48V-HSC-1-N",
> +		"EN-P48V-AUX-0","EN-P48V-AUX-1",
> +		"PWRGD-P12V-AUX-0","PWRGD-P12V-AUX-1";
>  	};
> =20
>  	gpio@23 {
>  		compatible =3D "nxp,pca9555";
> -		reg =3D <0x23>;
> +		pinctrl-names =3D "default";
>  		gpio-controller;
>  		#gpio-cells =3D <2>;
> +		reg =3D <0x23>;
> +		interrupt-parent =3D <&gpio0>;
> +		interrupts =3D <98 IRQ_TYPE_LEVEL_LOW>;

Just confirming the interrupt lines from the expanders are all wired up
to the one GPIO input pin on the BMC?

Andrew

