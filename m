Return-Path: <linux-kernel+bounces-62312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 197C0851E68
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68CA2B259F9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EDC481A8;
	Mon, 12 Feb 2024 20:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NZIJN/dR"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660CA47774;
	Mon, 12 Feb 2024 20:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768406; cv=none; b=f3rFnz0zCxLv0z2kdFP17sDv4HOj49FFiyHG29yEsKzz/fNztiCfzg1xRmouZ+qiOb4IST3rzh2Yc/6XSIjKx5mAjeqy2+xJuwGUqVUooRjGUkHYbm7j1TfdSu7nmcKck+Uol8pesRRg+aH15Z0ip7S3FV2+AB+fTdHr1B7Jeb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768406; c=relaxed/simple;
	bh=qjnuNmyiSEgjXChpUCI23C69eglKvom+rZJQQTSpY/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qq5GqjShMALxUQOBsJNf3I2WwwgxM/KLRKCm1Os6Jm/5n3eP1VJoVM4s9gp5JmlWCAPffhPwsOLNXC/RU+q8X9qiAV+UbuyQwyJr/6cYMmqKEyDZXp2nZIADOtHJGTfyO4zftQQLqwZNWQR+5cinHgwJ7BzuPv6O3oabouUijkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NZIJN/dR; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A0F5720003;
	Mon, 12 Feb 2024 20:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707768400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DmUCDESvsxbZN+wVj59NCC6P8oLMuz68MnJi+35+qlM=;
	b=NZIJN/dRwj4uo/4RHtNgV2rs3wfihfQB/dIO+krOPVIxVT9gJ41UqNlUlD5izVO2SujknE
	sUGS+/+xjldiHGdTBRRZ11lCzCL760fv/1VREKkQMqmTbHxqd/1fv3E/gFF/3LbhydrKBl
	++VF2PYRVPGt3praoi5Bs2UfnTXB2ox8vhR8jDvLHtLBp23j5pFJ8G8g79mzHAh2Gq6miq
	SNuyLMvakfrEvywhl/58+LjyIT+Xjy6LidrArONkg/O6vxUKBr23RLsQyf2oMYwI1Y76TB
	AK1+cOu07Ews3PIik4hewHaGvCBqt5rLBWeowV20F9iov1u1XJ+Ac1/PXJXBcQ==
Date: Mon, 12 Feb 2024 21:06:36 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Josua Mayer <josua@solid-run.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH v6 2/7] dt-bindings: rtc: abx80x: convert to yaml
Message-ID: <2024021220055301ade3d4@mail.local>
References: <20240212-add-am64-som-v6-0-b59edb2bc8c3@solid-run.com>
 <20240212-add-am64-som-v6-2-b59edb2bc8c3@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212-add-am64-som-v6-2-b59edb2bc8c3@solid-run.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 12/02/2024 18:38:09+0100, Josua Mayer wrote:
> Convert the abracon abx80x rtc text bindings to dt-schema format.
> 
> In addition to the text description reference generic interrupts
> properties and add an example.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Did something change since v6? If not, why didn't you collect the
reviewed-by tag?

> ---
>  .../devicetree/bindings/rtc/abracon,abx80x.txt     | 31 ---------
>  .../devicetree/bindings/rtc/abracon,abx80x.yaml    | 79 ++++++++++++++++++++++
>  2 files changed, 79 insertions(+), 31 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt b/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
> deleted file mode 100644
> index 2405e35a1bc0..000000000000
> --- a/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -Abracon ABX80X I2C ultra low power RTC/Alarm chip
> -
> -The Abracon ABX80X family consist of the ab0801, ab0803, ab0804, ab0805, ab1801,
> -ab1803, ab1804 and ab1805. The ab0805 is the superset of ab080x and the ab1805
> -is the superset of ab180x.
> -
> -Required properties:
> -
> - - "compatible": should one of:
> -        "abracon,abx80x"
> -        "abracon,ab0801"
> -        "abracon,ab0803"
> -        "abracon,ab0804"
> -        "abracon,ab0805"
> -        "abracon,ab1801"
> -        "abracon,ab1803"
> -        "abracon,ab1804"
> -        "abracon,ab1805"
> -        "microcrystal,rv1805"
> -	Using "abracon,abx80x" will enable chip autodetection.
> - - "reg": I2C bus address of the device
> -
> -Optional properties:
> -
> -The abx804 and abx805 have a trickle charger that is able to charge the
> -connected battery or supercap. Both the following properties have to be defined
> -and valid to enable charging:
> -
> - - "abracon,tc-diode": should be "standard" (0.6V) or "schottky" (0.3V)
> - - "abracon,tc-resistor": should be <0>, <3>, <6> or <11>. 0 disables the output
> -                          resistor, the other values are in kOhm.
> diff --git a/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml b/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
> new file mode 100644
> index 000000000000..58dbbca27deb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/abracon,abx80x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Abracon ABX80X I2C ultra low power RTC/Alarm chip
> +
> +maintainers:
> +  - linux-rtc@vger.kernel.org
> +
> +allOf:
> +  - $ref: rtc.yaml#
> +
> +properties:
> +  compatible:
> +    description:
> +      The wildcard 'abracon,abx80x' may be used to support a mix
> +      of different abracon rtc`s. In this case the driver
> +      must perform auto-detection from ID register.
> +    enum:
> +      - abracon,abx80x
> +      - abracon,ab0801
> +      - abracon,ab0803
> +      - abracon,ab0804
> +      - abracon,ab0805
> +      - abracon,ab1801
> +      - abracon,ab1803
> +      - abracon,ab1804
> +      - abracon,ab1805
> +      - microcrystal,rv1805
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  abracon,tc-diode:
> +    description:
> +      Trickle-charge diode type.
> +      Required to enable charging backup battery.
> +
> +      Supported are 'standard' diodes with a 0.6V drop
> +      and 'schottky' diodes with a 0.3V drop.
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum:
> +      - standard
> +      - schottky
> +
> +  abracon,tc-resistor:
> +    description:
> +      Trickle-charge resistor value in kOhm.
> +      Required to enable charging backup battery.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 3, 6, 11]
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        rtc@69 {
> +            compatible = "abracon,abx80x";
> +            reg = <0x69>;
> +            abracon,tc-diode = "schottky";
> +            abracon,tc-resistor = <3>;
> +            interrupts = <44 IRQ_TYPE_EDGE_FALLING>;
> +        };
> +    };
> 
> -- 
> 2.35.3
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

