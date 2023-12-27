Return-Path: <linux-kernel+bounces-12195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F60581F132
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 19:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E21C1F21FC0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C3846BA7;
	Wed, 27 Dec 2023 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yt5cJEX0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5894655B;
	Wed, 27 Dec 2023 18:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B9FC433CA;
	Wed, 27 Dec 2023 18:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703701650;
	bh=oyeL33g+9I+GVA+WFvuGJ+woG2igHBp3hw/HUXkmR1o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Yt5cJEX0sFi+XvmFwPc2Jh5rN7+8VemwEzH8NJPQYx/Ib8RTYqy2173po6ePEjNux
	 YT8nL4SKmr6edPnW+a6iTlE2zU1NT2g5BfSnQDXPzw4e5QseT1cJEXUBV/uvbWbKvS
	 198Be5Z6NuQxXaBdyJmU0nf+AGrHMkW+V+99IC+AkPmyVdQINb9B354fxIwH9JT3xX
	 zN0AuDSLJDsC7xWF96fHWZqOUjtobOPhQCayRoUSuJcurs/XW24Bxlvuqr0hlRwKw9
	 xW12bkB8b5xedokqaBvKSLLOBg3h9rAcdefvbruTM04YVd+aCt8t1sCZpjv2Ma1AEu
	 FTZh5hrIgXDpg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ccc80791e1so20449741fa.1;
        Wed, 27 Dec 2023 10:27:30 -0800 (PST)
X-Gm-Message-State: AOJu0Yw3Mt0dDLoI1mOum40cvXDUA0NX9hU7ReA/n9DYIHIVML8digdV
	/YdSgdB1lsCUeP+j+4LByElHx5y5CFsg56ROqA==
X-Google-Smtp-Source: AGHT+IH8nMyV28fe3BaJG8zJjdPFE095W0Lg1zumW1PhWjglNwi9cB/ff+b+TdEmGOf5hI23YuimFZtwX70lSpkxhJ4=
X-Received: by 2002:a2e:3509:0:b0:2cc:dea3:23b with SMTP id
 z9-20020a2e3509000000b002ccdea3023bmr662036ljz.3.1703701648332; Wed, 27 Dec
 2023 10:27:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227-mbly-clk-v2-0-a05db63c380f@bootlin.com> <20231227-mbly-clk-v2-3-a05db63c380f@bootlin.com>
In-Reply-To: <20231227-mbly-clk-v2-3-a05db63c380f@bootlin.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 27 Dec 2023 11:27:15 -0700
X-Gmail-Original-Message-ID: <CAL_JsqJD4ZeR+n09gC2fXnk1MFuqO0c0zADSg_-MiY65pck1Yw@mail.gmail.com>
Message-ID: <CAL_JsqJD4ZeR+n09gC2fXnk1MFuqO0c0zADSg_-MiY65pck1Yw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] dt-bindings: soc: mobileye: add EyeQ5 OLB system controller
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, linux-mips@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 10:24=E2=80=AFAM Th=C3=A9o Lebrun <theo.lebrun@boot=
lin.com> wrote:
>
> Add documentation to describe the "Other Logic Block" syscon.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> ---
>  .../bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  | 44 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 45 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq=
5-olb.yaml b/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-=
olb.yaml
> new file mode 100644
> index 000000000000..b148a49b08f1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.y=
aml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/mobileye/mobileye,eyeq5-olb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mobileye EyeQ5 SoC system controller
> +
> +maintainers:
> +  - Gr=C3=A9gory Clement <gregory.clement@bootlin.com>
> +  - Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> +  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
> +
> +description:
> +  OLB ("Other Logic Block") is a hardware block grouping smaller blocks.=
 Clocks,
> +  resets, pinctrl are being handled from here.

I don't see resets or pinctrl in the binding. Please make it complete
whether you have the driver or not.

As-is, you don't need clocks to be a child node.

> +
> +properties:
> +  compatible:
> +    items:
> +      - const: mobileye,eyeq5-olb
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  reg-io-width:
> +    const: 4

Why do you need this? It is not a generic block and can only ever be 1 valu=
e.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-io-width
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    olb@e00000 {
> +      compatible =3D "mobileye,eyeq5-olb", "syscon", "simple-mfd";
> +      reg =3D <0xe00000 0x400>;
> +      reg-io-width =3D <4>;

Make this example complete and drop the child node example.

Rob

