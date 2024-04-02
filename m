Return-Path: <linux-kernel+bounces-127442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56551894B64
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7BA1F232E5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74698224D4;
	Tue,  2 Apr 2024 06:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="C9ZQyeyy"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC0A224CF;
	Tue,  2 Apr 2024 06:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712039206; cv=none; b=kyAclrmXo6etYvYmkuHpCXNA+YUSMiTB6BQO6zm7h3pGzai2PZmUyTkNSYwsGpMIRM5wtFDHPqA+FySs/fzb77xo5Ji7rM5pWV1LxIFMQoc7feeMWB439/b9IQPnL7lsXhQ4f4lJ9wwEnricvkQbOKihasBJF/tnMouczh1LIkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712039206; c=relaxed/simple;
	bh=yqD5MObG4KrAAgzNU/IpEzitbWP0Yvfm1MK6uF7+aXs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJXWJ9DOCQ4uwamikgMfLtl0k7Rzdj3WzO6u3U/lxzsP8bZpawkNZBL4viHWGHC+e/Yad95Abyrn41TiI+rE5YpZIkMbjdEO5j6OBwlVsG+bSYf+Zd8omxlWzGxiWigxxs2Xh8Og/aWeEBtCoBQoL3clBLM+WAnNYdppqnpZMm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=C9ZQyeyy; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712039205; x=1743575205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yqD5MObG4KrAAgzNU/IpEzitbWP0Yvfm1MK6uF7+aXs=;
  b=C9ZQyeyyqCAxusZff7HuWvaZocUcNy1a/vtA7Ns+uBdiXzbtI/Dm8yQI
   hQZP5IMA7hXLZzcTM99RyAUpinQvSisGGyWMJWCoZ9x8RBNsyzPt9AFy9
   0jRZbidnkgV+yUPWJbUP8G74fL2tK9QFwEYCQd6h750GgFqtslBRXCTFI
   /OWX+lAd5Q50c/sgy8gSXjViFBzhlh3ENe4nGSYwMvuucez/UFYtd3C37
   0ta9OBzGuDTWyEQQAsLs11XtW8AYRY7uS3dk40DySledZwJD22GsLw3pi
   TLIMnoUbKjvW/mKWSc/11wWlsmqQOsSY+Kr6AazRRQ256R0W7OlA2OtIG
   w==;
X-CSE-ConnectionGUID: eXYBbngjQseUqzhgkPLNmw==
X-CSE-MsgGUID: ITlnMxOJQluG160vKvKt8A==
X-IronPort-AV: E=Sophos;i="6.07,174,1708412400"; 
   d="scan'208";a="249894645"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2024 23:26:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 23:26:19 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 1 Apr 2024 23:26:19 -0700
Date: Tue, 2 Apr 2024 08:26:18 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Conor Dooley <conor@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"Rob Herring" <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>, <UNGLinuxDriver@microchip.com>,
	"David S. Miller" <davem@davemloft.net>, Bjarni Jonasson
	<bjarni.jonasson@microchip.com>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFT 01/10] arm64: dts: microchip: sparx5: fix mdio reg
Message-ID: <20240402062618.au3uzqul3tk7sxaz@DEN-DL-M31836.microchip.com>
References: <20240401153740.123978-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240401153740.123978-1-krzk@kernel.org>

The 04/01/2024 17:37, Krzysztof Kozlowski wrote:

Hi,

I have not tested this patch on HW but I have checked the registers info
and this change seems correct.

Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>

 
> Correct the reg address of mdio node to match unit address.  Assume the
> reg is not correct and unit address was correct, because there is
> alerady node using the existing reg 0x110102d4.
> 
>   sparx5.dtsi:443.25-451.5: Warning (simple_bus_reg): /axi@600000000/mdio@6110102f8: simple-bus unit address format error, expected "6110102d4"
> 
> Fixes: d0f482bb06f9 ("arm64: dts: sparx5: Add the Sparx5 switch node")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Not tested on hardware
> ---
>  arch/arm64/boot/dts/microchip/sparx5.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
> index 24075cd91420..5d820da8c69d 100644
> --- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
> +++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
> @@ -447,7 +447,7 @@ mdio2: mdio@6110102f8 {
>                         pinctrl-names = "default";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> -                       reg = <0x6 0x110102d4 0x24>;
> +                       reg = <0x6 0x110102f8 0x24>;
>                 };
> 
>                 mdio3: mdio@61101031c {
> --
> 2.34.1
> 

-- 
/Horatiu

