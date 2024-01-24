Return-Path: <linux-kernel+bounces-36973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFCC83A9AC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3BAD1C20AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1247163121;
	Wed, 24 Jan 2024 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGxLVozF"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A99ACA69;
	Wed, 24 Jan 2024 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099158; cv=none; b=hNZMRusVkBSconp7kUjhukkjHhklecn2DuxUYioSoeWyXxIzL/p2QGUpBo4unbyDHgDUW1GAozmSQ8leSD1j+6BQXczNO7FfWLHtKP3hCvuB+0zKXex+puI2WlArkGzfkLESfyQR61xj/B3Clf318BbGcJgxzc2/zja+/oykGdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099158; c=relaxed/simple;
	bh=hQNdd0xiX0XMUYJoc1lP2vAqQQSZFwXEGvLtOasANJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7FDuMGgkj+KGQaJBtwk8eocH6cGEYCq8hOh5XT6cSPMfuKcsqJ16fWxnpYmhM3+Coo/qLR72KnZBf8dJTDgWpeyTOphZd08LZHd7z/ychH4xqh/9jBkvdwzl7Xm7I4c8dcFjv2O0F/O89jlEy6Fr3PDOUFlWyG7csQZ9OddIqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGxLVozF; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50eabfac2b7so6933243e87.0;
        Wed, 24 Jan 2024 04:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706099154; x=1706703954; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GZMD/+q+fu28yD+oCinP7dETgM2Kd7uFmJijVzeanNw=;
        b=TGxLVozF9+BScZp8katAdRT0F22ss9UIEfoiDZysgvUHQjR8j/RKxZT+an05oacxlM
         YUKipcYlb2s50uC3b40wT/t4RHALXu8NmQWcliLk7SN7o5UnjMscx/gax1PfbF3Z4Spc
         rOhZvujB72UeQMPc1t9M/m/QU1KaZwOEr0hUkUZeBc4nDd1NHccEo6uZlFtz2/uIHXkW
         390We7agL9LFMPgItquBSiNbl02NlZN3urD8uRzUjNWD1Nz+LNdnrPytnHT4u4SLAenA
         cwI4PD4AhyMcACX3CagppWlow9edbvO4qeuicPFxcrjj8Q+CoLK4jPXYlWrYur9/kQfn
         u+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706099154; x=1706703954;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GZMD/+q+fu28yD+oCinP7dETgM2Kd7uFmJijVzeanNw=;
        b=jFGPyf6IdevmnFN5xXhfY1zHuJHYwg+DVbhTqRyfCDfu3bc7ZSorymjjKNKGbYTM2h
         1wiLBVJyege+w9qY1U1APcQDxjtVWJVbj3BODjzkXwb6ajDTLVhtP7GWL6RO2PbqsnQG
         4w8hTZZi2BTlflZaEf85WlZ7HYP1Z99rF3a4hdk5FWOIZbSIss62ExaYwMhkuuCCFYJE
         dWvcekVXDsJ6vqnt4iPRkt2N4SEjuyZ6GIEH3RnXX6yenLqH1ffn2n6BSYGH9JY7vGFf
         LCH3V2+7ApqftppT815REhNl7vtQaRomcSYynh1lSdhaBtEWPTj5LxaRCSZGwTw6jjk5
         CG/Q==
X-Gm-Message-State: AOJu0YzauqTJ5t5/leiRemzOEEdkBaVoodQ7aV1HncCONG/c3C0QRRFr
	Rg6SfF553j4QNGf+idQjy7hEhc0oq3nAPMSwBGgtJYpnH7VSd76c
X-Google-Smtp-Source: AGHT+IGvEFncMsjx5jz8DnA32Cm63E4LfeYOX1DdNxBmFDnVr6uZ99jeN3saFXSKRWS+HJcYAsUlvg==
X-Received: by 2002:a19:654e:0:b0:510:676:7966 with SMTP id c14-20020a19654e000000b0051006767966mr1281867lfj.59.1706099153849;
        Wed, 24 Jan 2024 04:25:53 -0800 (PST)
Received: from localhost ([2a05:3580:f312:6c01:1b8f:2a1b:d18:1951])
        by smtp.gmail.com with ESMTPSA id 9-20020ac25f49000000b0051015e306e7sm37909lfz.84.2024.01.24.04.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 04:25:53 -0800 (PST)
Date: Wed, 24 Jan 2024 15:25:53 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alain Volmat <alain.volmat@foss.st.com>,
	Pavel Machek <pavel@ucw.cz>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH] arm64: dts: sun50i-a64-pinephone: Add front/back cameras
Message-ID: <ZbEB0TCTkzIYnLZD@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alain Volmat <alain.volmat@foss.st.com>,
	Pavel Machek <pavel@ucw.cz>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
References: <20240123214729.2852346-1-andrej.skvortzov@gmail.com>
 <rkx4iuuudkk7iaaudmr3ccwpatps7kz2qyjalcfzp4ongmbaby@rcosajd6c746>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rkx4iuuudkk7iaaudmr3ccwpatps7kz2qyjalcfzp4ongmbaby@rcosajd6c746>

Hi Ondrey,

On 24-01-23 23:01, Ondřej Jirman wrote:
> Hi Andrey,
> 
> On Wed, Jan 24, 2024 at 12:47:29AM +0300, Andrey Skvortsov wrote:
> > From: Ondřej Jirman <megi@xff.cz>
> > 
> > Pinephone has OV5640 back camera and GC2145 front camera. Add support
> > for both.
> 
> The upstream driver doesn't support multiple endpoints per port. See:
> 
> https://elixir.bootlin.com/linux/v6.8-rc1/source/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml#L43
> 
> Only one endpoint is allowed/supported. Looking throught LKML, I don't
> see the support for multiple parallel interface endpoints being added
> recently...
>
> So this patch will not work, and will cause DTS validation errors.

Thank you! I've not run dtb validation before submission, sorry for that.
I've ran 'make dtbs_check' and have several question now.

1. I don't see any complaints about multiple endpoints definitions.

IMHO, it looks okay from binding point of view according to that
video-interfaces.yaml [1].

I know that currently multiple endpoint implementation for parallel
interface is missing in sun6i_csi. Current out-of-tree implementation
doesn't require any change in bindings (Hopefully it will be upstream one
day) Or do you mean this change has to be submitted upstream only once
sun6i_csi gets fixed?


2. dtbs_check complaints about missing link-frequencies for recently
submitted gc2145. [2]
```
front-camera@3c: port:endpoint: 'link-frequencies' is a required property
```

I've looked at other drivers and link-frequencies are used only
mostly for CSI-2 endpoints. Should it be required for CPI/DVP ?

Not many mainline drivers support CSI-2 and DVP: ov5640, s5k5baf,
mt9mt114. Only mt9mt114 uses link-frequencies property for DVP and it
should match PCLK (double pixelrate). [3]

Should I define link-frequencies for DVP as a double pixelrate here as
well and handle that in the driver?

Currently gc2145 doesn't support DVP, but I have basic working support
for DVP for the upstreamed driver for a long time and waited for it to be merged
into mainline. I'd like to submit it for review. Until now I thought,
that submitted gc2145 bindings will be the same for DVP and CSI-2
support and therefore submitted this change.

Are they? Or should I introduce bus-type and conditionally
handle requirements in yaml if link-frequencies can be ignored for DVP?

Something link this
```
        properties:
          link-frequencies: true

          bus-type:
            enum:
              - 4 # CSI-2 D-PHY
              - 5 # Parallel

        required:
          - bus-type

        allOf:
          - if:
              properties:
                bus-type:
                  const: 4
            then:
              required:
                - link-frequencies
```

Should I better submit DVP support to the gc2145 driver first and only then
submit this change? 

> 
> Kind regards,
> 	o.
> 
> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > ---
> >  .../dts/allwinner/sun50i-a64-pinephone.dtsi   | 91 +++++++++++++++++++
> >  1 file changed, 91 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > index 87847116ab6d..4104a136ff75 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > @@ -36,6 +36,15 @@ chosen {
> >  		stdout-path = "serial0:115200n8";
> >  	};
> >  
> > +	i2c_csi: i2c-csi {
> > +		compatible = "i2c-gpio";
> > +		sda-gpios = <&pio 4 13 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>; /* PE13 */
> > +		scl-gpios = <&pio 4 12 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>; /* PE12 */
> > +		i2c-gpio,delay-us = <3>;
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +	};
> > +
> >  	leds {
> >  		compatible = "gpio-leds";
> >  
> > @@ -124,6 +133,36 @@ &cpu3 {
> >  	cpu-supply = <&reg_dcdc2>;
> >  };
> >  
> > +&csi {
> > +	pinctrl-0 = <&csi_pins>, <&csi_mclk_pin>;
> > +	status = "okay";
> > +
> > +	port {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		csi_ov5640_ep: endpoint@0 {
> > +			reg = <0>;
> > +			remote-endpoint = <&ov5640_ep>;
> > +			bus-width = <8>;
> > +			hsync-active = <1>; /* Active high */
> > +			vsync-active = <0>; /* Active low */
> > +			data-active = <1>;  /* Active high */
> > +			pclk-sample = <1>;  /* Rising */
> > +		};
> > +
> > +		csi_gc2145_ep: endpoint@1 {
> > +			reg = <1>;
> > +			remote-endpoint = <&gc2145_ep>;
> > +			bus-width = <8>;
> > +			hsync-active = <1>;
> > +			vsync-active = <1>;
> > +			data-active = <1>;
> > +			pclk-sample = <1>;
> > +		};
> > +	};
> > +};
> > +
> >  &dai {
> >  	status = "okay";
> >  };
> > @@ -158,6 +197,58 @@ &ehci1 {
> >  	status = "okay";
> >  };
> >  
> > +&i2c_csi {
> > +	gc2145: front-camera@3c {
> > +		compatible = "galaxycore,gc2145";
> > +		reg = <0x3c>;
> > +		clocks = <&ccu CLK_CSI_MCLK>;
> > +		clock-names = "xclk";

That should be removed to fix
```
front-camera@3c: 'clock-names' does not match any of the regexes: 'pinctrl-[0-9]+'
```
when running 'make dtbs_check'

> > +		avdd-supply = <&reg_dldo3>;
> > +		dvdd-supply = <&reg_aldo1>;
> > +		iovdd-supply = <&reg_eldo3>;
> > +		reset-gpios = <&pio 4 16 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>; /* PE16 */
> > +		powerdown-gpios = <&pio 4 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>; /* PE17 */
> > +		rotation = <270>;
> > +		orientation = <0>;
> > +
> > +		port {
> > +			gc2145_ep: endpoint {
> > +				remote-endpoint = <&csi_gc2145_ep>;
> > +				bus-width = <8>;
> > +				hsync-active = <1>;
> > +				vsync-active = <1>;
> > +				data-active = <1>;
> > +				pclk-sample = <1>;
> > +			};
> > +		};
> > +	};
> > +
> > +	ov5640: rear-camera@4c {
> > +		compatible = "ovti,ov5640";
> > +		reg = <0x4c>;
> > +		clocks = <&ccu CLK_CSI_MCLK>;
> > +		clock-names = "xclk";
> > +		AVDD-supply = <&reg_dldo3>;
> > +		DOVDD-supply = <&reg_aldo1>; /* shared with AFVCC */
> > +		DVDD-supply = <&reg_eldo3>;
> > +		reset-gpios = <&pio 3 3 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>; /* PD3 */
> > +		powerdown-gpios = <&pio 2 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>; /* PC0 */
> > +		rotation = <90>;
> > +		orientation = <1>;
> > +
> > +		port {
> > +			ov5640_ep: endpoint {
> > +				remote-endpoint = <&csi_ov5640_ep>;
> > +				bus-width = <8>;
> > +				hsync-active = <1>; /* Active high */
> > +				vsync-active = <0>; /* Active low */
> > +				data-active = <1>;  /* Active high */
> > +				pclk-sample = <1>;  /* Rising */
> > +			};
> > +		};
> > +	};
> > +};
> > +
> >  &i2c0 {
> >  	status = "okay";
> >  
> > -- 
> > 2.43.0
> > 



1. https://elixir.bootlin.com/linux/v6.8-rc1/source/Documentation/devicetree/bindings/media/video-interfaces.yaml#L41
2. https://elixir.bootlin.com/linux/v6.8-rc1/source/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml#L65
3. https://elixir.bootlin.com/linux/v6.8-rc1/source/drivers/media/i2c/mt9m114.c#L2256

-- 
Best regards,
Andrey Skvortsov

