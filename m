Return-Path: <linux-kernel+bounces-52659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21769849B21
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFEB7283F83
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AD637709;
	Mon,  5 Feb 2024 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NY2nAND6"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6633EA9C;
	Mon,  5 Feb 2024 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137481; cv=none; b=E8PUY8frrf/ndNNhIf4pRAcb1s4kWPyltrHSyqo6yv2dePjmPgXToWFoqEb1HkoZ7cWckkeG3GXPmIYYvvFotNIfW0u1/4WXPsHTiycOE6of3dDzdJI2O6xhFywZ6I2qJ3At4/OKNWHppV5WBmA7Ut2aoRS7xmqdctdoqCamF/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137481; c=relaxed/simple;
	bh=kzC+y21TP7jfpyjHZghz3kIfpx76cEBRO1F6nDVMDFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=el+r5S1NfpNPwCTT66pX/MqFOLULOVTd3lUc1Y1nuydhjPfkSHhULjxSk1/m6kfMzkwxH1sXaKqgz87F07jZQlW+CSscwXT5Sn21NAp1BOC0GR2Wa1MzqCC1Pd8XDtAnn/VIwM4t0/yGnyABRpMcYBQMZ5/rd47joOSpJ2KXep0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NY2nAND6; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707137479; x=1738673479;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kzC+y21TP7jfpyjHZghz3kIfpx76cEBRO1F6nDVMDFw=;
  b=NY2nAND6PPDieg/TwmVSXkvmievUdeyPkxuhg32poajyeXUb7zgGZCkc
   JfiRLuyqWMSwLXl6P6zUwKZ/it3lFm2MN6yfEM5wofxgpUZ2IIKHCJ2oC
   hTpfZ4jM/EJ237UmBo5lslzWFA6ieJ4UbCRYE+4xL30WDgb4N2i6SyK0t
   zy0hBOlKgGMBNHgVTCr4bYLj/EQ42I2jjw1rfJq52XI2KUY9Um8YSNXLM
   Ts/wQXaTTF56CZEmujOcURgLr/SaM2wyq7LI1905Qf7e6Os5yqo+zlLMV
   rQK5wy381DzBMbH+wY/zFcQmXPb4mrGjR2WZEZaRI4N/Z//hd/VeVMmpk
   g==;
X-CSE-ConnectionGUID: 9VixgTOORmy9tv6DYqUlyA==
X-CSE-MsgGUID: f2hqAhSKRXS31XIQDqqNVg==
X-IronPort-AV: E=Sophos;i="6.05,245,1701154800"; 
   d="scan'208";a="17127398"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Feb 2024 05:51:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 05:50:56 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 5 Feb 2024 05:50:53 -0700
Message-ID: <399c1ecd-c4fb-481f-b95a-afd71fb2d4fa@microchip.com>
Date: Mon, 5 Feb 2024 13:50:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: ata: atmel: remove at91 compact flash
 documentation
To: Hari Prasath Gujulan Elango <Hari.PrasathGE@microchip.com>,
	<dlemoal@kernel.org>, <cassel@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-ide@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240205105201.81060-1-Hari.PrasathGE@microchip.com>
Content-Language: en-US, fr-FR
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20240205105201.81060-1-Hari.PrasathGE@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 05/02/2024 at 11:52, Hari Prasath G E - I63539 wrote:
> The compatible "at91rm9200-cf" is not used by any driver,hence remove the
> corresponding documentation.
> 
> Signed-off-by: Hari Prasath Gujulan Elango <Hari.PrasathGE@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   .../devicetree/bindings/ata/atmel-at91_cf.txt | 19 -------------------
>   1 file changed, 19 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/ata/atmel-at91_cf.txt
> 
> diff --git a/Documentation/devicetree/bindings/ata/atmel-at91_cf.txt b/Documentation/devicetree/bindings/ata/atmel-at91_cf.txt
> deleted file mode 100644
> index c1d22b3ae134..000000000000
> --- a/Documentation/devicetree/bindings/ata/atmel-at91_cf.txt
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -Atmel AT91RM9200 CompactFlash
> -
> -Required properties:
> -- compatible : "atmel,at91rm9200-cf".
> -- reg : should specify localbus address and size used.
> -- gpios : specifies the gpio pins to control the CF device. Detect
> -  and reset gpio's are mandatory while irq and vcc gpio's are
> -  optional and may be set to 0 if not present.
> -
> -Example:
> -compact-flash@50000000 {
> -	compatible = "atmel,at91rm9200-cf";
> -	reg = <0x50000000 0x30000000>;
> -	gpios = <&pioC 13 0	/* irq */
> -		 &pioC 15 0 	/* detect */
> -		 0		/* vcc */
> -		 &pioC  5 0	/* reset */
> -		>;
> -};


