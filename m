Return-Path: <linux-kernel+bounces-28237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F388882FC00
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A07828D68F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E15210F3;
	Tue, 16 Jan 2024 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WbvBWDaH"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECDC210EC;
	Tue, 16 Jan 2024 20:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435869; cv=none; b=LfYiwizqVcBkDrZFSpWzXNoUtHjdk9o7YFJRlowzS25v/kcnwdBF2xJSrNFAXrrYJvasOOlZzjyp4yMmUHW6rAlIor6Y9YfMB5Dvzq91Lzsk2xoXt/2DdUSP0QUzS36N2WtD6G887SkZbMC9yk7nXo9xeQq7jjxcpsNQlWRIfPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435869; c=relaxed/simple;
	bh=Ot5DoXHaRejr+Ouk7XMENcjD7AuNVLbmSQjIHDwjPeI=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-GND-Sasl; b=U5yHh18cPNkaf3yANFkvIvwH4qhKPZ4qA+Q7Ao80oviUrckQi2EqIUTIdM4+46YuW6b7Tx2Mu4FievBsj3YFtKfHEMns5m/qtzt+WjZb6rxBS/+Prsp0Reg2FtbpiAwVTc2N+yPWLFZLBBpJVVqujNN2+/S6gUTTkNxH9LagXDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WbvBWDaH; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2233040004;
	Tue, 16 Jan 2024 20:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705435856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=boLTDxiJRvuGbhONOmfvkdNsFpD/vXpoBMU87w5mD8k=;
	b=WbvBWDaHd/y7DH+O+mClgauo0TFfzW4s+WOGBo3FcocXlI/MIYyhppWOD2/Z6hylV41+k9
	GdwSS39jouA2y9ffGk+8N1/TzyZr53wdHTLznzIIWSQWmlGuPZwcP8BHW0TuIkrmnSGd5y
	+sfyhiB7D65S7C8N0437c5c0D3+wavBZuQPPOmQLNX7hQfBJvKsRwBGg0lg9sAHuFvOEJ+
	St5QGEKDC7/D9tK16XhPFi+F0QsWJY/1vqCQkvl0FaFR4Se7bneP64Bh53ZuMoRlwRByCC
	+C/rbOd1tQ8R42DeSxsRApcjsCqf/AuCTGf1KEz1VaKynENntWKecBLyifB2sQ==
Date: Tue, 16 Jan 2024 21:10:52 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Conor Dooley <conor@kernel.org>
Cc: Dharma Balasubiramani <dharma.b@microchip.com>,
	conor.dooley@microchip.com, sam@ravnborg.org, bbrezillon@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, lee@kernel.org,
	thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
	linux-pwm@vger.kernel.org, linux4microchip@microchip.com
Subject: Re: [PATCH v2 2/3] dt-bindings: atmel,hlcdc: convert pwm bindings to
 json-schema
Message-ID: <20240116201052544a0791@mail.local>
References: <20240116113800.82529-1-dharma.b@microchip.com>
 <20240116113800.82529-3-dharma.b@microchip.com>
 <20240116-rising-gap-df4124f191a0@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116-rising-gap-df4124f191a0@spud>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 16/01/2024 18:03:19+0000, Conor Dooley wrote:
> On Tue, Jan 16, 2024 at 05:07:59PM +0530, Dharma Balasubiramani wrote:
> > Convert device tree bindings for Atmel's HLCDC PWM controller to YAML
> > format.
> > 
> > Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> > ---
> > changelog
> > v1 -> v2
> > - Remove the explicit copyrights.
> > - Modify title (not include words like binding/driver).
> > - Modify description actually describing the hardware and not the driver.
> > - Remove pinctrl properties which aren't required.
> > - Drop parent node and it's other sub-device node which are not related here.
> > ---
> >  .../bindings/pwm/atmel,hlcdc-pwm.yaml         | 47 +++++++++++++++++++
> >  .../bindings/pwm/atmel-hlcdc-pwm.txt          | 29 ------------
> >  2 files changed, 47 insertions(+), 29 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml b/Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml
> > new file mode 100644
> > index 000000000000..751122309fa9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml
> > @@ -0,0 +1,47 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> 
> The original file has no license, but was originally written by a
> free-electrons employee, so the relicensing here is fine.
> 

I confirm relicensing is fine, even assigning the copyright to
Microchip (note that Bootlin is legally the same entity as
free-electrons)

> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/atmel,hlcdc-pwm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Atmel's HLCDC's PWM controller
> > +
> > +maintainers:
> > +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> > +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> > +  - Claudiu Beznea <claudiu.beznea@tuxon.dev>
> > +
> > +description: |
> 
> Again, the | is not needed here.
> 
> > +  The LCDC integrates a Pulse Width Modulation (PWM) Controller. This block
> > +  generates the LCD contrast control signal (LCD_PWM) that controls the
> > +  display's contrast by software. LCDC_PWM is an 8-bit PWM signal that can be
> > +  converted to an analog voltage with a simple passive filter. LCD display
> > +  panels have different backlight specifications in terms of minimum/maximum
> > +  values for PWM frequency. If the LCDC PWM frequency range does not match the
> > +  LCD display panel, it is possible to use the standalone PWM Controller to
> > +  drive the backlight.
> > +
> > +properties:
> > +  compatible:
> > +    const: atmel,hlcdc-pwm
> > +
> > +  "#pwm-cells":
> > +    const: 3
> > +    description: |
> > +      This PWM chip uses the default 3 cells bindings defined in pwm.yaml in
> > +      this directory.
> 
> I would delete this description tbh.
> 
> > +
> > +required:
> > +  - compatible
> > +  - "#pwm-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    pwm: pwm {
> > +      compatible = "atmel,hlcdc-pwm";
> > +      pinctrl-names = "default";
> > +      pinctrl-0 = <&pinctrl_lcd_pwm>;
> > +      #pwm-cells = <3>;
> > +    };
> 
> The label here is not used and can be dropped. Otherwise,
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> 
> Cheers,
> Conor.
> 
> > diff --git a/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt b/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
> > deleted file mode 100644
> > index afa501bf7f94..000000000000
> > --- a/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
> > +++ /dev/null
> > @@ -1,29 +0,0 @@
> > -Device-Tree bindings for Atmel's HLCDC (High-end LCD Controller) PWM driver
> > -
> > -The Atmel HLCDC PWM is subdevice of the HLCDC MFD device.
> > -See ../mfd/atmel-hlcdc.txt for more details.
> > -
> > -Required properties:
> > - - compatible: value should be one of the following:
> > -   "atmel,hlcdc-pwm"
> > - - pinctr-names: the pin control state names. Should contain "default".
> > - - pinctrl-0: should contain the pinctrl states described by pinctrl
> > -   default.
> > - - #pwm-cells: should be set to 3. This PWM chip use the default 3 cells
> > -   bindings defined in pwm.yaml in this directory.
> > -
> > -Example:
> > -
> > -	hlcdc: hlcdc@f0030000 {
> > -		compatible = "atmel,sama5d3-hlcdc";
> > -		reg = <0xf0030000 0x2000>;
> > -		clocks = <&lcdc_clk>, <&lcdck>, <&clk32k>;
> > -		clock-names = "periph_clk","sys_clk", "slow_clk";
> > -
> > -		hlcdc_pwm: hlcdc-pwm {
> > -			compatible = "atmel,hlcdc-pwm";
> > -			pinctrl-names = "default";
> > -			pinctrl-0 = <&pinctrl_lcd_pwm>;
> > -			#pwm-cells = <3>;
> > -		};
> > -	};
> > -- 
> > 2.25.1
> > 



-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

