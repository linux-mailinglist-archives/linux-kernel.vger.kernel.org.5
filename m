Return-Path: <linux-kernel+bounces-2215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B76B8159AC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 14:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F9B31C21793
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5462D63C;
	Sat, 16 Dec 2023 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="s7136yAp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA46A30642
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8C8E13F2C5
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 13:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1702735076;
	bh=1IDqTgxXQymbTimq5NcK1mhvY0gI9NehYSyLAkXJSA4=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=s7136yApbUMQIVm5zgZmdOTlzWyCrnNdkOAFsY5rmrEctRk7Ji4EE+b+lh4dxJQ/4
	 EstfAwxqgzdF2QW+9uEwprda72J2+s+1W6Nbf+S1kCyGBkLWJO+XoKyrItVAvovK1B
	 m50AEF8cKQQqrgq8EC0iK20eM2p2ze8CPvGEqDVsDqsoOCKdgSZw6pIKdL5CCku5SG
	 tvJFQ4BnSvWF7FEP9924+je/593NZk8l332anB4kl9UfawKcPSPFgJ3kmPt0FLnVUG
	 DC8HbVPDMsUywzD6Db9qxcIVceb+BotGpU6YJLyr0PA1PUHjmPuwUgYlCuZuX7Kj4Z
	 I/AR8E7IRiiSw==
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4257b29b96aso25665231cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 05:57:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702735075; x=1703339875;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1IDqTgxXQymbTimq5NcK1mhvY0gI9NehYSyLAkXJSA4=;
        b=qwS54RyUF+D4Escnvs0XacRTU/mnij/riCFQ98J021iYGA4Ur/lSYLOaS4e9iOSBiU
         DWDMFKDN/XarqGQwq2TlTej3wVpBDd8Td79RtUsy8Ij6udNlyf6HMIG6867Pv2tJZLqf
         DSkfogCAqTQW6VSd3o3JWeGASNDqUkMswATbTQLq5l0gCMwCiL46J+DXjvT8/wrmCeuB
         nmx7VUsDCGc9OVo0n8ZotlOvUVhcbqtvSiWK5r5jKlsSX4pLhufw8jxcJZn2tc+x4oTA
         V+QnphwLjdxOui+xy8Ks5z1K+Blmm55bRV/GX9SIsre1SjhP3CthChP5NZwygjys4oQI
         q9cw==
X-Gm-Message-State: AOJu0YyM5jdW9ylMe6MeeLPmfVibgX1CoWyluUCR5z1cQEMtyilk9YfY
	/TjI3jkO9PG1YNWX8SNJbzxDSRYhjjdCdbE50luo6mmAklRnVwqfOqPY9fNIfXAL9El7B3TUR45
	eqSXmOANYWLsngdVDnC+qkq7lvpC3qcKGCZ6dr9i03fIYlPK2ZL+YxuydNA==
X-Received: by 2002:ac8:5d8d:0:b0:425:72f3:efc2 with SMTP id d13-20020ac85d8d000000b0042572f3efc2mr17906426qtx.23.1702735075348;
        Sat, 16 Dec 2023 05:57:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2z15djvfq92lfCW5SVLTfQogWiKIQlYCWLwzNRZaqcornDI7KUR95VQS0vrC8KmFSlGJ+d0WEqwEbw0+MxUQ=
X-Received: by 2002:ac8:5d8d:0:b0:425:72f3:efc2 with SMTP id
 d13-20020ac85d8d000000b0042572f3efc2mr17906407qtx.23.1702735074956; Sat, 16
 Dec 2023 05:57:54 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 16 Dec 2023 05:57:54 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231215202137.GA317624-robh@kernel.org>
References: <20231215143906.3651122-1-emil.renner.berthing@canonical.com>
 <20231215143906.3651122-2-emil.renner.berthing@canonical.com> <20231215202137.GA317624-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sat, 16 Dec 2023 05:57:54 -0800
Message-ID: <CAJM55Z9pBpYfwpxPH7bUumuosVDn9DHLSBngW6CtG7aK_z+_bQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] dt-bindings: pinctrl: Add thead,th1520-pinctrl bindings
To: Rob Herring <robh@kernel.org>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Hoan Tran <hoan@os.amperecomputing.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"

Rob Herring wrote:
> On Fri, Dec 15, 2023 at 03:38:59PM +0100, Emil Renner Berthing wrote:
> > Add bindings for the pin controllers on the T-Head TH1520 RISC-V SoC.
> >
> > Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > ---
> >  .../pinctrl/thead,th1520-pinctrl.yaml         | 156 ++++++++++++++++++
> >  1 file changed, 156 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
> > new file mode 100644
> > index 000000000000..1b1b446cd498
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
> > @@ -0,0 +1,156 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pinctrl/thead,th1520-pinctrl.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: T-Head TH1520 SoC pin controller
> > +
> > +maintainers:
> > +  - Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > +
> > +description: |
> > +  Pinmux and pinconf controller in the T-Head TH1520 RISC-V SoC.
> > +
> > +  The TH1520 has 3 groups of pads each controlled from different memory ranges.
> > +  Confusingly the memory ranges are named
> > +    PADCTRL_AOSYS  -> PAD Group 1
> > +    PADCTRL1_APSYS -> PAD Group 2
> > +    PADCTRL0_APSYS -> PAD Group 3
>
> Are the programming models different?

Yes, they control different pads and different number of pads. Pad group 1 also
has some special pins that have bespoke pinconf, no pinconf and/or no
pinmux and a
"gap" in the registers. Also if some day we'll need to set up pinmux
on behald of the
audio co-processor then pad group 1 will be even more special.

> > +
> > +  Each pad can be muxed individually to up to 5 different functions. For most
> > +  pads only a few of those 5 configurations are valid though, and a few pads in
> > +  group 1 does not support muxing at all.
> > +
> > +  Pinconf is fairly regular except for a few pads in group 1 that either can't
> > +  be configured or has some special functions. The rest have configurable drive
> > +  strength, input enable, schmitt trigger, slew rate, pull-up and pull-down in
> > +  addition to a special strong pull up.
> > +
> > +  Certain pads in group 1 can be muxed to AUDIO_PA0 - AUDIO_PA30 functions and
> > +  are then meant to be used by the audio co-processor. Each such pad can then
> > +  be further muxed to either audio GPIO or one of 4 functions such as UART, I2C
> > +  and I2S. If the audio pad is muxed to one of the 4 functions then pinconf is
> > +  also configured in different registers. All of this is done from a different
> > +  AUDIO_IOCTRL memory range and is left to the audio co-processor for now.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - thead,th1520-group1-pinctrl
> > +      - thead,th1520-group2-pinctrl
> > +      - thead,th1520-group3-pinctrl
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +patternProperties:
> > +  '-[0-9]+$':
>
> Please make this a bit more specific. "-grp-[0-9]+$"?

Oh, I was just trying to copy what other drivers did, but I see now that eg.
mediatek,mt6779-pinctrl is not in the majority. Unfortunately "group" already
has 2 meanings in this context. One are the pad groups from the datasheet
described above and then there are the mux groups in the pinctrl framework,
which in this case just contains a single pin since each pin can be muxed
individually. Can we come up with a better name or should we just add this 3rd
type of group?

> > +    patternProperties:
> > +      '-pins$':
> > +        type: object
> > +        $ref: /schemas/pinctrl/pincfg-node.yaml
> > +        description:
> > +          A pinctrl node should contain at least one subnode describing one
> > +          or more pads and their associated pinmux and pinconf settings.
> > +
> > +        properties:
> > +          pins:
> > +            $ref: /schemas/types.yaml#/definitions/string-array
>
> Type is defined in pinmux-node.yaml. You need to reference it and drop
> this.
>
> Normally the possible values are listed out.

This seems to work for me:

allOf:
  - if:
      properties:
        compatible:
          const: thead,th1520-group1-pinctrl
    then:
      patternProperties:
        '-[0-9]+$':
          patternProperties:
            '-pins$':
              properties:
                pins:
                  items:
                    enum:
                      - OSC_CLK_IN
                      - OSC_CLK_OUT
		      ...
  - if:
      properties:
        compatible:
          const: thead,th1520-group2-pinctrl
    then:
      patternProperties:
        '-[0-9]+$':
          patternProperties:
            '-pins$':
              properties:
                pins:
                  items:
                    enum:
                      - QSPI1_SCLK
                      - QSPI1_CSN0
		      ...
  ...

Would that be the way to go about it?

> > +            description: List of pads that properties in the node apply to.
> > +
> > +          function:
> > +            $ref: /schemas/types.yaml#/definitions/string
> > +            enum: [ "0", "1", "2", "3", "4", "5" ]
> > +            description: The mux function to select for the given pins.
> > +
> > +          bias-disable: true
> > +
> > +          bias-pull-up:
> > +            type: boolean
> > +
> > +          bias-pull-down:
> > +            type: boolean
> > +
> > +          drive-strength:
> > +            enum: [ 1, 2, 3, 5, 7, 8, 10, 12, 13, 15, 16, 18, 20, 21, 23, 25 ]
> > +
> > +          input-enable: true
> > +
> > +          input-disable: true
> > +
> > +          input-schmitt-enable: true
> > +
> > +          input-schmitt-disable: true
> > +
> > +          slew-rate:
> > +            maximum: 1
> > +
> > +          thead,strong-pull-up:
> > +            oneOf:
> > +              - type: boolean
> > +              - $ref: /schemas/types.yaml#/definitions/uint32
> > +                enum: [ 0, 2100 ]
> > +            description: Enable or disable strong 2.1kOhm pull-up.
>
> bias-pull-up can already specify the strength in Ohms.

The strong pull up is a separate bit that can be enabled independently from the
regular pull-up/down, so in theory you could enable both the regular pull-up
and the strong pull-up at the same time, or even the regular poll-down and the
strong pull-up which is probably not advised.
So the idea here was just to make sure that you can do eg.

	thead,strong-pull-up = <0>;

to make sure the bit is cleared.

Thanks!
/Emil

