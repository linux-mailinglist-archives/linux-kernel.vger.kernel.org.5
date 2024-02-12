Return-Path: <linux-kernel+bounces-61716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2759F8515A3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C7DA1C22B7F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FC7446DD;
	Mon, 12 Feb 2024 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="hKvwAEs2"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8209D446C6;
	Mon, 12 Feb 2024 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745127; cv=none; b=f143Y6vA8v7Wamv4dhAxTIIYRTkK7XoRtW0x56RR7DEUWl4Cl2atGOCEP3rEobgpdTBKe0a0qeWgqz/zQAMnUeDUFmvY61DhHIZb917L5qwSDOS6tYso+ABRkNL27v9Oqx7oz1rRm76P9GIJYobcbDbT6/WtVH/dTbB7U/cjiBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745127; c=relaxed/simple;
	bh=mS0QhgJRzDgpI1qejlkyrBiVokQtbL0nQyIAi02mXLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptnuP+dlmgAf7OH/dKQxCOCcX4gxIhEpeOz+k9CsUzWsswiUr9gKisvCUW6N/9Kmx5i2gYW20BUW9BTr5U/jsTisVo0VS7OEP+WLCkMiM9w8Eh6Re0K217ZEhldEFnhZMqAiRh7pCXu/FAPZZoKTiKWtNMNRKtpemaJmU9P+hVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=hKvwAEs2; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1707745120; bh=mS0QhgJRzDgpI1qejlkyrBiVokQtbL0nQyIAi02mXLY=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=hKvwAEs28HIyFqEXxo44kgbOwyoLnFFAZp90jAS/Llo2jOz/P6ARvDQJAsopKKlE2
	 hDVIKi7ZwuOjbNGfEEeLr5JVeMDbhs9c5O2yMzM33DvQPq/zBGprAU71+PZEjUc2Xo
	 uL0TSaWGAMZeYZTE2ET+K0Qk71Jb7Pw4Kfh9s8bw=
Date: Mon, 12 Feb 2024 14:38:40 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrey Skvortsov <andrej.skvortzov@gmail.com>, Icenowy Zheng <icenowy@aosc.io>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: iio: magnetometer: Add DT binding for
 Voltafield AF8133J
Message-ID: <i2q2vntbhilrpwppzl367ndoetbyd6guyti4t4n7vtg5pwq7bi@tjkio7zpwrfw>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrey Skvortsov <andrej.skvortzov@gmail.com>, Icenowy Zheng <icenowy@aosc.io>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240211205211.2890931-1-megi@xff.cz>
 <20240211205211.2890931-3-megi@xff.cz>
 <20240212114738.0000535b@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240212114738.0000535b@Huawei.com>

Hi Jonathan,

thanks for the feedback.

On Mon, Feb 12, 2024 at 11:47:38AM +0000, Jonathan Cameron wrote:
> On Sun, 11 Feb 2024 21:51:58 +0100
> Ondřej Jirman <megi@xff.cz> wrote:
> 
> > From: Icenowy Zheng <icenowy@aosc.io>
> 
> Title doesn't need to mention binding (it's implicit from the dt-bindings bit
> dt-bindings: iio: magnetometer: Add Voltafield AF8133J
> 
> > 
> > Voltafield AF8133J is a simple magnetometer sensor produced by Voltafield
> > Technology Corp, with dual power supplies (one for core and one for I/O)
> > and active-low reset pin.
> > 
> > The sensor has configurable range 1.2 - 2.2 mT and a software controlled
> > standby mode.
> > 
> > Add a device tree binding for it.
> > 
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > Signed-off-by: Ondřej Jirman <megi@xff.cz>
> 
> Hi Ondřej
> 
> A few quick comments.
> 
> 
> > ---
> >  .../iio/magnetometer/voltafield,af8133j.yaml  | 58 +++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml b/Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml
> > new file mode 100644
> > index 000000000000..ab56c0f798ad
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml
> > @@ -0,0 +1,58 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/magnetometer/voltafield,af8133j.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Voltafield AF8133J magnetometer sensor
> > +
> > +maintainers:
> > +  - Ondřej Jirman <megi@xff.cz>
> > +
> > +properties:
> > +  compatible:
> > +    - voltafield,af8133j
> Test your bindings (as described in the bot message).
>     const: voltafield,af8133j

I did, but didn't notice that DT_SCHEMA_FILES= didn't work as expected when
provided with full path to the bindings file. :)

Just using DT_SCHEMA_FILES=voltafield,af8133j.yaml works better and catches this
issue.

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    description: |
> No need for the | as the formatting doesn't need to be preserved.
> 
> > +      an pin needed for AF8133J to set the reset state. This should be usually
> 
> A pin
> 
> > +      active low.
> > +
> > +  avdd-supply:
> > +    description: |
> > +      an optional regulator that needs to be on to provide AVDD power (Working
> 
> An optional (if it were optional, A regulator if not)
> 
> > +      power, usually 3.3V) to the sensor.
> Seems unlikely the power supply is optional (though specifying it in DT might be -
> however see below).
> 
> > +
> > +  dvdd-supply:
> > +    description: |
> > +      an optional regulator that needs to be on to provide DVDD power (Digital
> > +      IO power, 1.8V~AVDD) to the sensor.
> > +
> > +  mount-matrix:
> > +    description: an optional 3x3 mounting rotation matrix.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> 
> Any power supply that is required for operation should be listed here (even though
> we can rely on the stub supplies if it isn't in the DT).
> I used to think this wasn't necessary, so lots of bindings upstream don't yet
> have it.

By stub supply you mean dummy supply created when the *-supply property is not
specified in DT? Or something else?

Because DTC_CHK prints a warning if I make the proerty required in bindings and
not specify it in DT

arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2b.dtb: magnetometer@1c: 'avdd-supply' is a required property
	from schema $id: http://devicetree.org/schemas/iio/magnetometer/voltafield,af8133j.yaml#


kind regards,
	o.

> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        magnetometer@1c {
> > +            compatible = "voltafield,af8133j";
> > +            reg = <0x1c>;
> > +            avdd-supply = <&reg_dldo1>;
> > +            dvdd-supply = <&reg_dldo1>;
> > +            reset-gpios = <&pio 1 1 GPIO_ACTIVE_LOW>;
> > +        };
> > +    };
> 

