Return-Path: <linux-kernel+bounces-25346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D3382CE10
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 19:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E26B61C21098
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 18:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA64569C;
	Sat, 13 Jan 2024 18:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekhCaxae"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99D15257;
	Sat, 13 Jan 2024 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-557c188f313so11181635a12.1;
        Sat, 13 Jan 2024 10:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705169096; x=1705773896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AhKW9vV6IhRimImnuy7kTVRnEpSaiNSa1m/etVcloMg=;
        b=ekhCaxaeAh+q7qxATxpe4JNJm61autuL7phtumqqPIFTiofIXcxG/Vj9c7Y4VarIZW
         dTmZSjOJnhXWBzN4h/Qf4DwhyvoNJKhnfzAzrxbqnbO7OulruWMYWwc8z2y+j4b9joU7
         ihHnndG+yYmK6st229DQBtCBdibvcIr8W5V/b0bDxJ7RNgPtETOpcNyshwJvPnKoSVdk
         RgBxr5COAT2dMKmpk3UeBDcXwMTl/Ua7UG4kTl5D+opI8MMhJYYtgS2PRegqG00cV87b
         NCVA4eqpn95KzSUCd9Q8/G33zJJx7kx0wy3lCUBZ3QlwMNHNwR3JZhgBUuLcdudHLAib
         C9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705169096; x=1705773896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhKW9vV6IhRimImnuy7kTVRnEpSaiNSa1m/etVcloMg=;
        b=udBEpzmN4i4jQh7rQEr7SzWN/aHvpNwc3yANzZ1vWsEWw4f64TgmnN+/EFMtsVvWQm
         jvh02O9Mlo6vlKIls5CzsGlqseAZPKYd6l3FPP8fJ2Ws0lJ4iJN6jtjaN7TrYVELpZKX
         6Q74nVGbljftUyWCekr1dNcqb8IVqRK821FPsiKKmWKv+Oi10E/Xwwc7mMSb41nfRa+v
         wlRtyV+C/txKG0FY48iL5R+n/p7WaNNb0Gyfy7bHf35CcI7RWjF2/OS0JFys5HYJr4bQ
         L2cXnOb2ZwMAa3SJDeiUqIMPRxrPYJS8MQRmK7yTZ2FHxCQlmJ4vMmQuXZUMMiw/2/hW
         RaqA==
X-Gm-Message-State: AOJu0YykJzH0GdrsOzpw1bSYUh/Zbxgo7RLqk+fa8o7JUmD3iO30oKXw
	6nva7BxE4tUxJkxQX2PnT7xXDy6vtuo=
X-Google-Smtp-Source: AGHT+IFJrtj8W8dev25IrMHGcj/DImhmwZ5y8Lb28rX0zHq3TV8Xvw+tyZcvRGB1Oc5HAyCoZ+yBog==
X-Received: by 2002:a05:6402:1ca8:b0:558:81d8:ccd7 with SMTP id cz8-20020a0564021ca800b0055881d8ccd7mr2834099edb.31.1705169095651;
        Sat, 13 Jan 2024 10:04:55 -0800 (PST)
Received: from cjw-notebook (2a02-8388-0502-f480-6c32-186a-368b-d6a9.cable.dynamic.v6.surfer.at. [2a02:8388:502:f480:6c32:186a:368b:d6a9])
        by smtp.gmail.com with ESMTPSA id et6-20020a056402378600b0055410f0d709sm3133388edb.19.2024.01.13.10.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 10:04:55 -0800 (PST)
Date: Sat, 13 Jan 2024 19:04:52 +0100
From: Christoph Winklhofer <cj.winklhofer@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: w1: UART 1-Wire bus
Message-ID: <ZaLQxGjjmA_iKOv2@cjw-notebook>
References: <20240106-w1-uart-v4-0-7fe1378a8b3e@gmail.com>
 <20240106-w1-uart-v4-1-7fe1378a8b3e@gmail.com>
 <20240113013917.GA3795949-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240113013917.GA3795949-robh@kernel.org>

On Fri, Jan 12, 2024 at 07:39:17PM -0600, Rob Herring wrote:
> On Sat, Jan 06, 2024 at 05:02:24PM +0100, Christoph Winklhofer wrote:
> > Add device tree binding for UART 1-Wire bus.
> > 
> > Signed-off-by: Christoph Winklhofer <cj.winklhofer@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/w1/w1-uart.yaml | 62 +++++++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/w1/w1-uart.yaml b/Documentation/devicetree/bindings/w1/w1-uart.yaml
> > new file mode 100644
> > index 000000000000..6b90693b2ca0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/w1/w1-uart.yaml
> > @@ -0,0 +1,62 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/w1/w1-uart.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
..
> > +properties:
> > +  compatible:
> > +    const: w1-uart
> > +
> > +  reset-speed:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 9600
> > +    description: |
> 
> Don't need '|' if no formatting
> 

Ok.

> > +      The baud rate for the 1-Wire reset and presence detect.
> > +
> > +  touch_0-speed:
> 
> Don't use '_' in property names.
> 
> I'm somewhat familar with 1-wire, but I don't get what 'touch' means 
> here. I assume these are low and high times which are a function of the 
> baudrate.
> 

I change the name to 'write-0-speed' and 'write-1-speed'. The function
in the w1-framework is named 'touch_bit' - therefore the previous
naming. 

It is the baud-rate used in the 1-Wire cycle to write a 0-Bit
(write-0-speed) and to perform a 1-Wire cycle that writes a 1-Bit and
reads a 0-Bit or 1-Bit (write-1-speed).

> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 115200
> > +    description: |
> > +      The baud rate for the 1-Wire write-0 cycle (touch bit 0).
> > +
> > +  touch_1-speed:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 115200
> > +    description: |
> > +      The baud rate for the 1-Wire write-1 and read cycle (touch bit 1).
> > +
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: false
> 
> w1.txt says there can be a child node for the 1-wire device. You need 
> 'type: object'. Or w1.txt needs to be converted to schema and referenced 
> here (along with using unevaluatedProperties here instead).
> 
> Rob

Will change it to type object. However, I also tried to convert w1.txt
to w1.yaml - I am not quite sure, so I add an excerpt of my attempt.
The example in w1.txt builds fine. Is oneOf allowed as a top-level
property, the documentation only mentions allOf?
Only one child should be allowed, but I did not find a way to restrict
this.

# w1-uart.yaml:
unevaluatedProperties:
  $ref: w1.yaml

# w1.yaml:
properties:
  compatible:
    enum:
      - maxim,ds2760

oneOf:
  - $ref: /schemas/power/supply/maxim,ds2760.yaml

unevaluatedProperties: false
#

Thank you for the review!

Kind regards,
Christoph

