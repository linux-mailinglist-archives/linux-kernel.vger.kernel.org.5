Return-Path: <linux-kernel+bounces-85285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D92A86B378
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1600B233FE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C9215DBB5;
	Wed, 28 Feb 2024 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6kTsMcX"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2334152E14;
	Wed, 28 Feb 2024 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134895; cv=none; b=Su68aWoIjPbsDF8tF81nuZ5LEoZAturgMnZHoSNpxqjHuAROTrDx6jssH7lkGaskAbFc370/CBapxD5ftuiSp2LzTmHsnkbqPH/sWYuwvJMaK2LpElyqeznM5bmdLvw5bMdf7z0Ov3CdEFhzhWSGCGoViEfYJzp3sop7PrfHICE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134895; c=relaxed/simple;
	bh=9i1q127oWjdJ+t9z1pQacKuTLS2LK+k8327gtEih0HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCtNGdx9l7ZzIdaFdDxYGlYcVVzmx57S7Hws3ujTcso00iNbx3p/7lPaUROZmGP+aAYQJpolxG+9BoUdk512rGGfufrKwZvwMEC5IcUIMYrJeaTvoPf+gzl2O5Y8qAOtUnAuUUcNGxrsWXE4au+v+znz26iyEFkcMndhF60KpQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6kTsMcX; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso707448466b.2;
        Wed, 28 Feb 2024 07:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709134892; x=1709739692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O6ajv5WB4Bbxg+l7rcG1Skw2klg4SLTom1IzidWxyp0=;
        b=Z6kTsMcXBtXnYuKk5Id3G7PrfRKhyGG0W0dKNeKN0lilI9ikslsZNXC8c++ekppZIg
         J6hq5rft2AjJIkdLnQAPzIgL38xf5Gwy94RIU/OqBU+eQXajdOlzmiWll3oiDwaxdXEp
         3YppJ8YrG5yber4UFd5YDOQPGz5WWv210IhzxfTXb+0bpQMAhcteOkWAefgG5iAfhNlV
         8Rt2FyXK3WeRjn+NhAojfcyk3+pGeUP0Rh3qIF1CBCH4iGi4We1NAYx8KMGXq5Sgvmvb
         +TcSEi4KklQ+5Fr/jJ4aHzKJhU4cUeMiK8TPUyvoRvUc1iGd1G99BI5tczKYK9rIAXBF
         BBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709134892; x=1709739692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6ajv5WB4Bbxg+l7rcG1Skw2klg4SLTom1IzidWxyp0=;
        b=SCp/MJTQ0RhO1zPwDgcST/wGrR0avnAb6mtgb3L+lDspVKzS7C0pvKsRtHK9cYvwQE
         UtcWJ76M2T3kvTEzAdoMQXsa9pVMb4V+DuaDq1F+OI24apkjL2LrGOz15FdLvG+q8P36
         oME9thfNAjN5vk4RIY23H/IeO9dAPeLR0F+W6kKC5MmmwzXUbRS9GxieQWzyCYj9yhcl
         gQUjuVKX8L5SHsBFcB9YqDST3OPaa6f5dTkYDUldWHL564MN5n8Sy4A3N/lUfOQndUfB
         VinjN3ooxSqGzw1LJpss5MCTpz1Qcme26a9T/mfOIrHga3x6CYyn+yrCLhBNx791IJXE
         EHtw==
X-Forwarded-Encrypted: i=1; AJvYcCVzkE3Z4Lu8Xkc02mmIFrkZ8SV2qQL3SWNlJ/BnvWr4h+8Xa9Eu6A5liMneVG3rgT8KbsWyH/uyZCrcik+wtpYV0QaYPWHQQCiUS/i7P775ac/jf6l5gktOLzoE18zLBLI8ZzH37c8ny9B8UQsUYZcHZ9oImgVr2NfCpLTcYILNi6+LMw==
X-Gm-Message-State: AOJu0YyePrW+MgiFWxHK+ab9Fcmz4WVSvp1AxwYSVBCJzmaU79OCxlEF
	N99A0Rs40cJBZeD7df15Qw1IfbD/EfeJuVHlp1ZVbd6J20CSpInuX0i643dW
X-Google-Smtp-Source: AGHT+IHSpViTIZ64bBjjRxqqZXU7O0E93QpwOrVzZct6s/wb3v0mbHX9WV7MhgL/Mp0j+kpqsEs5fg==
X-Received: by 2002:a17:906:b58:b0:a43:ff8c:6d9c with SMTP id v24-20020a1709060b5800b00a43ff8c6d9cmr48027ejg.56.1709134892125;
        Wed, 28 Feb 2024 07:41:32 -0800 (PST)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id cu13-20020a170906ba8d00b00a43215bff13sm1975290ejd.117.2024.02.28.07.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 07:41:31 -0800 (PST)
Date: Wed, 28 Feb 2024 16:41:29 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: pwm: add support for MC33XS2410
Message-ID: <20240228154129.GA749753@debian>
References: <20240228133236.748225-1-dima.fedrau@gmail.com>
 <20240228133236.748225-2-dima.fedrau@gmail.com>
 <6dd18b29-6e45-4c35-8f7e-5248b057449d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dd18b29-6e45-4c35-8f7e-5248b057449d@linaro.org>

Am Wed, Feb 28, 2024 at 02:59:48PM +0100 schrieb Krzysztof Kozlowski:
> On 28/02/2024 14:32, Dimitri Fedrau wrote:
> > Adding documentation for MC33XS2410 pwm driver.
> 
> Driver as Linux driver? If so, please rephrase to describe hardware.
> 
Will fix it.
> > 
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > ---
> >  .../bindings/pwm/nxp,mc33xs2410.yaml          | 105 ++++++++++++++++++
> >  1 file changed, 105 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml b/Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml
> > new file mode 100644
> > index 000000000000..bd387dbe69be
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml
> > @@ -0,0 +1,105 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/nxp,mc33xs2410.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MC33XS2410 PWM driver
> 
> Driver as Linux driver? If so, please rephrase to describe hardware.
>
Will fix it.
> > +
> > +maintainers:
> > +  - Dimitri Fedrau <dima.fedrau@gmail.com>
> > +
> > +allOf:
> > +  - $ref: pwm.yaml#
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: nxp,mc33xs2410
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 10000000
> > +
> > +  spi-cpha: true
> > +
> > +  spi-cs-setup-delay-ns:
> > +    minimum: 100
> > +    default: 100
> > +
> > +  spi-cs-hold-delay-ns:
> > +    minimum: 10
> > +    default: 10
> > +
> > +  spi-cs-inactive-delay-ns:
> > +    minimum: 300
> > +    default: 300
> > +
> > +  reset-gpios:
> > +    description:
> > +      GPIO connected to the active low reset pin.
> > +    maxItems: 1
> > +
> > +  "#pwm-cells":
> > +    const: 3
> > +
> > +  pwms:
> > +    description:
> > +      Direct inputs(di0-3) are used to directly turn-on or turn-off the
> > +      outputs. The external PWM clock can be used if the internal clock
> > +      doesn't meet timing requirements.
> 
> pwm is input for pwm?
> 
Yes.
> > +    maxItems: 5
> > +
> > +  pwm-names:
> > +    items:
> > +      - const: di0
> > +      - const: di1
> > +      - const: di2
> > +      - const: di3
> > +      - const: ext_clk
> 
> Aren't these clocks?
> 
di0-3 are PWM input signals which are translated to output voltage "vpwr".
ext_clk is described as PWM clock in the datasheet. Didn't used it, just
mentioned it here for completeness.
> > +
> > +  vdd-supply:
> > +    description:
> > +      Logic supply voltage
> > +
> > +  vspi-supply:
> > +    description:
> > +      Supply voltage for SPI
> > +
> > +  vpwr-supply:
> > +    description:
> > +      Power switch supply
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> 
> Instead:
> unevaluatedProperties: false
> 
Will fix it.
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +       pwm@0 {
> > +           compatible = "nxp,mc33xs2410";
> > +           reg = <0x0>;
> > +           spi-max-frequency = <4000000>;
> > +           spi-cpha;
> > +           spi-cs-setup-delay-ns = <100>;
> > +           spi-cs-hold-delay-ns = <10>;
> > +           spi-cs-inactive-delay-ns = <300>;
> > +           reset-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
> > +           #pwm-cells = <3>;
> 
> Make example complete, so provide all properties, like interrupts, pwms
> and whatever you have in the binding.
> 
I could make the binding complete, but I haven't used all properties nor
does the driver supports them.
> Best regards,
> Krzysztof
> 
Best regards,
Dimitri

