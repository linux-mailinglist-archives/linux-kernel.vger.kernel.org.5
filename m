Return-Path: <linux-kernel+bounces-4816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF77C818268
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935CF1C21AAF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979F0C2C1;
	Tue, 19 Dec 2023 07:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g8eaZDKi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C30CC158
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2358a75b69so406490666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 23:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702971626; x=1703576426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UlFPWwZAspV5NaIaNj4ycQ59oICMhP/Gq68b8xEeGAc=;
        b=g8eaZDKiTS43N0nXpRKcCpIdgqhvKo/kDPj7VUTUEfxYg2b2hYVv0wWEZ4xV9CTLjc
         4r49JqzjAM+SFqWXi+7YOOhuNq+0oXhooZ1QmmnU9Gf4vocKma2ZwPRB+t4uF8xhVDjl
         pe+5AjbmGCZ3HcWahEQ7HlrnKIaRE4Poeo7D0lMvucZ7RiPCYpJPI79st91lpDvH8o3M
         iOCju4J/e6Wwu6kzItZwr8k2iXeLeMwVIj+WGmAZOQ0mY2DJzsBKDMs2HDZ/p83rN+yT
         88bxbg2GHqMJgdac4dNiu23Ebd/eFIGr3d6Mjl7OGaC4jiIKDQQaYV6VhW3LiilRXXJx
         nXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702971626; x=1703576426;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UlFPWwZAspV5NaIaNj4ycQ59oICMhP/Gq68b8xEeGAc=;
        b=oBwdWQwL5zcRVYn9HenxRUs0cHopBvn+/osNF97WOn4YfN3bmP7PK5KS3GmbTF9OrZ
         a7EUHtBwctmUZpqpeF9RvI49kyuIktaGyWPeBd7lDZQijWmhKH/8a3Q/68OdC3yr8+lP
         6qZauqxeWjj4f3UkaXBvt0/th74OZE0BHzLzc0eGuybQLtDXDcMbqfKdLTK7YEBoMD1z
         8dRv/j9US6ohrSK0/aQSU0f4fFvWGj7RFIWi9qhhMsXOzHLiVq/uwplfRZgXKV5YrZWk
         aoljxoDpq/KPeVzv212jvMXjFbNdfU2+4d5sGEBbqBEfCtwOnxtDQP92zAWN4gIajqRn
         yHvg==
X-Gm-Message-State: AOJu0YwT4S2JGokS8txm4mO9EpgrljF78GEZwWkegGqrzmtKqLuhfRr9
	fU6vljiMXdrf8MMO2r/ta1ZT4Q==
X-Google-Smtp-Source: AGHT+IFIyD+UyRA9SVbO1zduytVwClyFAfhpLu92qtfBHcG+oa34xkqAPcspfTnVN2zwYMc1EIsC1g==
X-Received: by 2002:a17:906:2087:b0:a23:6249:ee99 with SMTP id 7-20020a170906208700b00a236249ee99mr575088ejq.11.1702971626310;
        Mon, 18 Dec 2023 23:40:26 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id vi7-20020a170907d40700b00a1dc7e789fbsm14935769ejc.21.2023.12.18.23.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 23:40:25 -0800 (PST)
Message-ID: <c6d8c1f2-082d-43c1-8768-c0004d3fe386@linaro.org>
Date: Tue, 19 Dec 2023 08:40:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: reset: mobileye,eyeq5-reset: add
 bindings
Content-Language: en-US
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
References: <20231218-mbly-reset-v1-0-b4688b916213@bootlin.com>
 <20231218-mbly-reset-v1-1-b4688b916213@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231218-mbly-reset-v1-1-b4688b916213@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/12/2023 18:16, Théo Lebrun wrote:
> Add DT-Schema bindings for the EyeQ5 reset controller.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  .../bindings/reset/mobileye,eyeq5-reset.yaml       | 69 +++++++++++++++++++
>  MAINTAINERS                                        |  2 +
>  include/dt-bindings/reset/mobileye,eyeq5-reset.h   | 80 ++++++++++++++++++++++
>  3 files changed, 151 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml b/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
> new file mode 100644
> index 000000000000..cab6a75ba59d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/mobileye,eyeq5-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mobileye EyeQ5 reset controller
> +
> +description:
> +  The EyeQ5 reset driver handles three reset domains. It is custom to this
> +  platform, its registers live in a shared region called OLB.
> +
> +maintainers:
> +  - Grégory Clement <gregory.clement@bootlin.com>
> +  - Théo Lebrun <theo.lebrun@bootlin.com>
> +  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "^reset-controller$"
> +    description:
> +      We have no unique address, we rely on OLB.

NAK, third time.

> +
> +  compatible:
> +    const: mobileye,eyeq5-reset
> +
> +  "#reset-cells":
> +    const: 2
> +    description:
> +      The first cell is the domain (0 to 2 inclusive) and the second one is the
> +      reset index inside that domain.
> +
> +  mobileye,olb:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      A phandle to the OLB syscon. This is a fallback to using the parent as
> +      syscon node.

No, the same rationale as before.

> +
> +required:
> +  - compatible
> +  - "#reset-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    olb@e00000 {
> +      compatible = "mobileye,eyeq5-olb", "syscon", "simple-mfd";

No, the same rationale as before.


> +      reg = <0xe00000 0x400>;
> +      reg-io-width = <4>;
> +
> +      reset-controller {
> +        compatible = "mobileye,eyeq5-reset";
> +        #reset-cells = <2>;
> +      };
> +    };
> +
> +  - |
> +    olb: olb@e00000 {
> +      compatible = "mobileye,eyeq5-olb", "syscon", "simple-mfd";

No, the same rationale as before. The hardware is either A or B, not both.


> +      reg = <0xe00000 0x400>;
> +      reg-io-width = <4>;
> +    };
> +
> +    reset-controller {
> +      compatible = "mobileye,eyeq5-reset";
> +      #reset-cells = <2>;
> +      mobileye,olb = <&olb>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4a7bd6b40d74..9096a940b425 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14553,9 +14553,11 @@ M:	Théo Lebrun <theo.lebrun@bootlin.com>
>  L:	linux-mips@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/mips/mobileye.yaml
> +F:	Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
>  F:	arch/mips/boot/dts/mobileye/
>  F:	arch/mips/configs/generic/board-eyeq5.config
>  F:	arch/mips/generic/board-epm5.its.S
> +F:	include/dt-bindings/reset/mobileye,eyeq5-reset.h
>  F:	include/dt-bindings/soc/mobileye,eyeq5.h
>  
>  MODULE SUPPORT
> diff --git a/include/dt-bindings/reset/mobileye,eyeq5-reset.h b/include/dt-bindings/reset/mobileye,eyeq5-reset.h
> new file mode 100644
> index 000000000000..ce59fe5409ac
> --- /dev/null
> +++ b/include/dt-bindings/reset/mobileye,eyeq5-reset.h
> @@ -0,0 +1,80 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (C) 2023 Mobileye Vision Technologies Ltd.
> + */
> +
> +#ifndef _DT_BINDINGS_RESET_MOBILEYE_EYEQ5_RESET_H
> +#define _DT_BINDINGS_RESET_MOBILEYE_EYEQ5_RESET_H
> +
> +/* Domain 0 */
> +
> +/* 0..2 are reserved */

No, they are not. IDs cannot be reserved. IDs start from 0 and are
incremented by 1. Reserving an ID contradicts to entire point of that
ID, so either drop entire file or make this proper IDs.

> +#define EQ5R_D0_CAN0				3
> +#define EQ5R_D0_CAN1				4
> +#define EQ5R_D0_CAN2				5
> +#define EQ5R_D0_SPI0				6
> +#define EQ5R_D0_SPI1				7
> +#define EQ5R_D0_SPI2				8
> +#define EQ5R_D0_SPI3				9

...

> +
> +#define EQ5R_D2_MULTIPHY_SWRST_DIS		12
> +#define EQ5R_D2_MULTIPHY_APB_RST_DIS		13
> +/* 14 is refclk select, ie not a reset */
> +#define EQ5R_D2_PCIE0_LINK_MGMT_RST		15
> +#define EQ5R_D2_PCIE1_LINK_MGMT_RST		16
> +#define EQ5R_D2_PCIE0_LINK_PM_RST		17
> +#define EQ5R_D2_PCIE1_LINK_PM_RST		18
> +/* 19..31 are unknown */

No, they are not unknown. They are explicitly implemented by driver or
these are not IDs.

Best regards,
Krzysztof


