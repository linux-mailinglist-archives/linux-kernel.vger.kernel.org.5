Return-Path: <linux-kernel+bounces-10362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7673181D361
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 10:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66146B22366
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 09:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A9C9466;
	Sat, 23 Dec 2023 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hpldx0ms"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DC88F4E;
	Sat, 23 Dec 2023 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a235500d0e1so273882266b.2;
        Sat, 23 Dec 2023 01:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703324696; x=1703929496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KncKIn34n06J8Iyw7C8FwmMQf6a0ixS63Gg+pcARM3A=;
        b=Hpldx0msCpnWZ3XOXxpEdYdK65sZOmIcl15Oz0F4ynegvZzFnJyi+mctlIbLzMW/Ez
         uXXbiqCM9lNe4ff8b3xsvRYe4RcWkmoy3IvSJ7KgMQYgN3Yx2vAq0QR59A7ov3TNt2+m
         csdA/NnqbdaBaXMol7/GSrLLhQyzUz4npStNfCz0EY2hfXrwNIW0s1yF0MxluJTuxhYm
         BXao08AB+n829qDNKo36xLGdq9tes2RyXeLeesOAy5XYsHwlZifQueekK5XsYQrX1Zim
         F5OFtvpqXv9JbqD7ORE4fwdEvS5Up7VPNxjv/M9dqZKZrDGSXLBuQX9Sy0gWYJ79eHCB
         Botg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703324696; x=1703929496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KncKIn34n06J8Iyw7C8FwmMQf6a0ixS63Gg+pcARM3A=;
        b=U9lI0AjfJ/a5p1rkdnWb4pQg56m1A/+oGJJpzC1ae5Cpgdg5HYn5Dud6L6BSoQ9VJb
         lpgdaYQH5YVMeUTmPL87ayzOzb7DVT4n7DpW8DhpdQ8dS4WXVNrE9PT2Mijh0F2qiIVT
         zLS79AyJA1mujwqjVIQNQLuKkgrgPfCdM8pJpd1z908YNWRmAjP3nfYMCIoiJDj5hCOV
         L8r1J7R9eLeYuVNiHs/ghgWji5h0LCz+zSQbX+cxi3fl3TzAnaGXzVf3v6UZEdhBvN7c
         TtLQIm3jiCAMLIM/66KREjS0ypiKdKg1PujX0/Tsm52+PeIV13PexU6CzC5BvlEpBmVZ
         zCmQ==
X-Gm-Message-State: AOJu0YyHAPLHSEm4zDszYhOdu2GUGEB8OV0+FnIzfEBYufDttBZEKBu7
	dYhBTpyfIKm25a3/Ijz+gDokhzR98aU=
X-Google-Smtp-Source: AGHT+IEXJOdLjcbdeDWFI7+r8eT5mgDA5Efe7uFnv+JWbumMbVAgpnNrUO9HSM6MfuboYc4Jc9FmTw==
X-Received: by 2002:a17:906:d157:b0:a1e:1da1:73c0 with SMTP id br23-20020a170906d15700b00a1e1da173c0mr1577317ejb.10.1703324696379;
        Sat, 23 Dec 2023 01:44:56 -0800 (PST)
Received: from cjw-notebook (188-23-116-43.adsl.highway.telekom.at. [188.23.116.43])
        by smtp.gmail.com with ESMTPSA id 19-20020a170906011300b00a2351e4c8e6sm2903909eje.198.2023.12.23.01.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 01:44:56 -0800 (PST)
Date: Sat, 23 Dec 2023 10:44:53 +0100
From: Christoph Winklhofer <cj.winklhofer@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: krzysztof.kozlowski@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: w1: UART 1-wire bus
Message-ID: <ZYasFZhjsjJ7PC61@cjw-notebook>
References: <20231221065049.30703-1-cj.winklhofer@gmail.com>
 <20231221065049.30703-2-cj.winklhofer@gmail.com>
 <20231221205958.GA73493-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221205958.GA73493-robh@kernel.org>

On Thu, Dec 21, 2023 at 02:59:58PM -0600, Rob Herring wrote:
> On Thu, Dec 21, 2023 at 07:50:47AM +0100, Christoph Winklhofer wrote:
> > Add device tree binding for UART 1-wire bus.
> > 
> > Signed-off-by: Christoph Winklhofer <cj.winklhofer@gmail.com>
> > ---
> >  .../devicetree/bindings/w1/w1-uart.yaml       | 44 +++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/w1/w1-uart.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/w1/w1-uart.yaml b/Documentation/devicetree/bindings/w1/w1-uart.yaml
> > new file mode 100644
> > index 000000000000..93d83c42c407
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/w1/w1-uart.yaml
> > @@ -0,0 +1,44 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/w1/w1-uart.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: UART 1-Wire Bus
> > +
> > +maintainers:
> > +  - Christoph Winklhofer <cj.winklhofer@gmail.com>
> > +
> > +description: |
> > +  UART 1-wire bus. Utilizes the UART interface via the Serial Device Bus
> > +  to create the 1-Wire timing patterns.
> > +
> > +  The UART peripheral must support full-duplex and operate in open-drain
> > +  mode. The timing patterns are generated by a specific combination of
> > +  baud-rate and transmitted byte, which corresponds to a 1-Wire read bit,
> > +  write bit or reset pulse.
> > +
> > +  The default baud-rate for reset and presence detection is 9600 and for
> > +  a 1-Wire read or write operation 115200. In case the actual baud-rate
> > +  is different from the requested one, the transmitted byte is adapted
> > +  to generate the 1-Wire timing patterns.
> > +
> > +  https://www.analog.com/en/technical-articles/using-a-uart-to-implement-a-1wire-bus-master.html
> > +
> > +
> > +properties:
> > +  compatible:
> > +    const: w1-uart
> > +
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    serial {
> > +      onewire {
> 
> Have you tried this in an actual DT? Assuming the UART node has a 
> schema, it should be a warning because child node names are explicit in 
> serial.yaml unfortunately. IOW, you need to add "onewire" to 
> serial.yaml.
>

Thank you! It was tested on an older DT with the wildcard pattern. I
updated my test-system and now get the warning. On the Raspberry PI, 
a DT overlay was used, in this case there is no warning with:

  make CHECK_DTBS=y overlays/w1-uart.dtbo ARCH=arm

Is it possible to do a validation for a DT overlay? Since the overlay
may be incomplete, only existing nodes or properties could be checked.

Thanks!
Christoph

