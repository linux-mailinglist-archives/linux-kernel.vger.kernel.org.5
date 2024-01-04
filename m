Return-Path: <linux-kernel+bounces-16562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C4B82403C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3D91C23926
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1C421115;
	Thu,  4 Jan 2024 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuiBeJvy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9516C20DE8;
	Thu,  4 Jan 2024 11:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-59574cbcd50so170716eaf.2;
        Thu, 04 Jan 2024 03:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704366339; x=1704971139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33k36f8Faxes4Uh+MDJB0eG9QKaunjv3b4A+01J9zO8=;
        b=IuiBeJvy0qqiZOUPAnmmAetsjDy/y3wZ+Qzi+wKRquWP+T5IvtxGniN7hbt7Aetv2K
         G5ptABSyVuki1f8JBVkDSy8RFNHF2LeRafPT/dV1OxmN+o8n5s4xhwBGqhA9UooAcSh6
         3hMQFr74k5wNPVUDJtOFs7pSumjYmL+Ea2R+Ix96ACQNLIPFBtmlfMSz4KS+38CvJ3l6
         oxvjLCI9ucYDRBOFwjYoxWiaCPfKWbunPGVgUt8wrYn2L9VUdtb9Zxx3GIW64be1qhOr
         QwDAuiZImfSPDxzqi7bMxBrdaoJSxRaxWYRpsBJBSy1WXafzZEyn73DfJ6+RcRbtIRTw
         dMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704366339; x=1704971139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33k36f8Faxes4Uh+MDJB0eG9QKaunjv3b4A+01J9zO8=;
        b=c7xdxg+PjB1ZMz5vNxbqwEKvavJzbnWgGGP+rPgo4lQVEwQM8znvgtQjDSB7ZEbr8P
         D0B1osT2lwirEUywx/NT9PFrYpmffuAQICbtPVizRpCkDMDoOctwJ6H2XlaiV1zSBI3o
         D6sjAdfec6YusiCKVEGjpvaQTxsj+T/61bCwORlv8fS9gw1A2Us0Ecd35U/UOaUNahLS
         OByBFvXtovpNtHaoxbODWXikof6QKA9yEDimwUEjYhWubsD4KCQqV73IxyxF2nKhbUJo
         +WldqddqzIaiVnHjn4/Y7Cfj9xVnYzHJFG9ZZFUoXY0sfnFAA41uSB7iCehnkP3RCzJf
         ykng==
X-Gm-Message-State: AOJu0YweiIbefWVCmrp2YRFh+x2dxca8HLaXGJCa1GeMwVFtLTMUOImD
	n50qKeXnXb0gvMhVK4jK/MdnLugy2BmO52iOQ6w=
X-Google-Smtp-Source: AGHT+IENYWER6Vza2TQZqJ8LdAUT8zGqLmb+qv+Zf0ES7HnFW+IqKSg4fLwHvgD+uz5WoD92uj0SmHN0k283SnG/864=
X-Received: by 2002:a4a:ae44:0:b0:594:1671:f4e2 with SMTP id
 a4-20020a4aae44000000b005941671f4e2mr295462oon.16.1704366339302; Thu, 04 Jan
 2024 03:05:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229090643.116575-1-qiujingbao.dlmu@gmail.com>
 <20231229090643.116575-4-qiujingbao.dlmu@gmail.com> <942d79d0-08a8-4cda-90de-57daa44d9dd7@linaro.org>
In-Reply-To: <942d79d0-08a8-4cda-90de-57daa44d9dd7@linaro.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Thu, 4 Jan 2024 19:05:28 +0800
Message-ID: <CAJRtX8Rv0Ws=fcgDf2jh6GRz3ba+CkjH4u6JUPZnN61-CqqzZA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] dt-bindings: mfd: sophgo: add misc MFD for Sophgo
 CV1800 series SoC.
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dlan@gentoo.org, inochiama@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 4:36=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 29/12/2023 10:06, Jingbao Qiu wrote:
> > Add devicetree binding to describe the MFD for Sophgo CV1800 SoC.
>
> SoC does not have MFDs. We already talked about this.

I'm sorry for that. I will fix the comment.

>
> >
> > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > ---
> > This patch depends on the clk driver
> > Clk driver link:
> > https://lore.kernel.org/all/IA1PR20MB49539CDAD9A268CBF6CA184BBB9FA@IA1P=
R20MB4953.namprd20.prod.outlook.com/
>
> How? Really, explain me how this depends on driver? Because if it does,
> then it is clear NAK as binding cannot depend on driver.

I will fix it.

>
> Wait, this is v4, not v1!
>
> Include full changelog.
>
> So you just ignored all the comments? NAK.

Thanks,I will  keep consistent versioning and changelogs.

>
> >
> >  .../bindings/mfd/sophgo,cv1800-misc.yaml      | 69 +++++++++++++++++++
> >  1 file changed, 69 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/sophgo,cv1800=
-misc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/sophgo,cv1800-misc.y=
aml b/Documentation/devicetree/bindings/mfd/sophgo,cv1800-misc.yaml
> > new file mode 100644
> > index 000000000000..6fd574a2a945
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/sophgo,cv1800-misc.yaml
> > @@ -0,0 +1,69 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/sophgo,cv1800-misc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sophgo CV1800 SoC MISC hardware block
> > +
> > +maintainers:
> > +  - Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > +
> > +description:
> > +  This hardware block is an independently powered module within
> > +  the CV1800 SoC. This hardware block contains RTC, Power-On-Reset/POR=
.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: sophgo,cv1800-misc
> > +      - const: syscon
> > +      - const: simple-mfd
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  rtc:
> > +    # Child node
>
> Drop, it's obvious.

I will do that.

>
> > +    $ref: /schemas/rtc/sophgo,cv1800-rtc.yaml
> > +    type: object
> > +    description:
> > +      RTC for the SoC. This child node definition
> > +      should follow the bindings specified in
> > +      Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml.
> > +
> > +  por:
> > +    # Child node
>
> Drop

I will do that.

>
> > +    $ref: /schemas/power/sophgo,cv1800-por.yaml
> > +    type: object
> > +    description:
> > +      Power-On-Reset/POR for the SoC. This child node definition
> > +      should follow the bindings specified in
> > +      Documentation/devicetree/bindings/power/sophgo,cv1800-por.yaml.
>
> You do not have any resources, so no need for this child.

I will do that.

>
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - rtc
> > +  - por
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    misc@5025000 {
>
>
> misc can be anything.

Actually, there are RTC and (Power On Reset/POR) here. I can't find a suita=
ble
word to describe him. Can you give me some advice?

Best regards,
Jingbao Qiu
>
> > +      compatible =3D "sophgo,cv1800-misc", "syscon", "simple-mfd";
> > +      reg =3D <0x05025000 0x2000>;
> > +
> > +      rtc  {
> > +        compatible =3D "sophgo,cv1800-rtc";
> > +        interrupts =3D <17 IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks =3D <&clk 15>;
> > +      };
> > +
> > +      por  {
> > +        compatible =3D "sophgo,cv1800-por";
> > +      };
> > +    };
>
> Best regards,
> Krzysztof
>

