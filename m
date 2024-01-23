Return-Path: <linux-kernel+bounces-34876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 580788388A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A582BB22946
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013745647E;
	Tue, 23 Jan 2024 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H24+KO6I"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DCE55E76
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705997660; cv=none; b=gvvZDFK0SRChzb/MuyjBOQiiapC0NAmE7XI+uUVgRNrnbNxeYKHmCtG/gY3vg/5KENNkgZkBvLWpuja9WjyWEt6Td4pPeC/ZI4urbyMpz9XFuroz517OhhRBQ+GhL+yUkNSwZwSPZKKXvuP1LyFIvkgABOCj11mUrchKAC1K8Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705997660; c=relaxed/simple;
	bh=QX5dXGPVFC2GlgMSYCYr4vitUrAfk3lD43zb+xwiNbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thB/e3n49dSEsj34eYmMkYym8fLA2rGMcF1uuPLDARFsOzFNk8X9KatIHLDqIjwjY8LX/ytDqKX9PsE1mgncd3wKJBeb2S2bVUpkT8A9zQpgLC7IpKp4ChK3MT95bb5mQRemb9ub6eARa2LTrfB9JwryAjM3IuykvpKNPPToyCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H24+KO6I; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33922b66bd7so2716802f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705997656; x=1706602456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bGTW2KjPX1DyoVAx6boPY1syN6WdPLTcHzvIcsq/rwE=;
        b=H24+KO6IP3RdeeMyQs4CySKnv4y40foqQyyMc1QUm5jprjq1J1egoUpO/YB1+fu48t
         aQ3JgrVDxoDY/ZXiduGXN2jvYM2dwCqWfRHAAxCwVr0rekZRFs1rMDNGvzkUyjt3gGrm
         cFbcQxEadeiXNbgTXL6vZSeF+kv/g587zMZPgNnfaDo1cFkP77YQFAp/SWUNQrWafqhx
         XsVhwnRJ8D3NZAQ660yVTR9iKa4FWNOlfVY2H7rPiRBopuALAeyjTFrqb7tPR5RYzZY6
         WtF7StPbCdmApC+1xpmi+Ie7zg1EnYkOOXmHFEJqrry4HUU3FU14xoA/pVPFIUoGcd7o
         jaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705997656; x=1706602456;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGTW2KjPX1DyoVAx6boPY1syN6WdPLTcHzvIcsq/rwE=;
        b=h+MbaP9mYYTW9SvFAXJvjkYFUMO2ni+lYKDbkN4eSVMONxJXmY/pNzySXWrFYOg7qW
         4R2e1McaZMuQ84G5SXsCzPzOpiEeMVd7UQf5oUKg7eUOoR3iSAB0GPUdms7kuFjkRfgk
         5MiEJ++QTJ4rAM/t4xZzitY/FH05/XU1tr12eHNt1t6/KD2gZrvyW2n1NABzc8H0Lfhr
         rpgjtT4Hywzkp3fslR/jNG6pnMkzVCIbwDRZRdFssWEKqgWEtgxltUM3oVVjppDIkhbM
         jz9FpG8YWHoc0O8iGLeymBlbDpuaiDh9RVlMQbHk9muUmM7vfxBywb59I5P5RCRmJGOX
         7JAQ==
X-Gm-Message-State: AOJu0YxhIQuDqzO1OAdYpx1ujx52TTvv2QOlCphVOYvLQujU2P2lkfNb
	3rYilVa9GrDNe7wkOQ0LNUFa20I/CQ8yI9TaBMvXTSBOPMvq/4DBZvj5n4CkZHY=
X-Google-Smtp-Source: AGHT+IGXenXglCIvo7MSzk/Hn2hfrsplt/zhr0Yqu2V33WH+ieHTcrkTeB9PUKWHLbxYTG/OVRwouQ==
X-Received: by 2002:a5d:456f:0:b0:337:b636:8e3 with SMTP id a15-20020a5d456f000000b00337b63608e3mr3130251wrc.47.1705997656646;
        Tue, 23 Jan 2024 00:14:16 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d42c4000000b003392c3141absm7105622wrr.1.2024.01.23.00.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 00:14:16 -0800 (PST)
Message-ID: <a60e90c7-deeb-4680-b055-340fbd51cb48@linaro.org>
Date: Tue, 23 Jan 2024 09:14:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: mailbox: fsl,mu: add i.MX95
 Generic/ELE/V2X MU compatible
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
References: <20240122-imx-mailbox-v2-0-7b3c80333b92@nxp.com>
 <20240122-imx-mailbox-v2-1-7b3c80333b92@nxp.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240122-imx-mailbox-v2-1-7b3c80333b92@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/01/2024 07:19, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX95 Generic, Secure Enclave and V2X Message Unit compatible string.
> And some MUs has internal RAMs for SCMI shared buffer usage.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/mailbox/fsl,mu.yaml        | 50 +++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> index 12e7a7d536a3..d10c6fed291b 100644
> --- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> @@ -29,10 +29,14 @@ properties:
>        - const: fsl,imx8ulp-mu
>        - const: fsl,imx8-mu-scu
>        - const: fsl,imx8-mu-seco
> -      - const: fsl,imx93-mu-s4
>        - const: fsl,imx8ulp-mu-s4
> +      - const: fsl,imx93-mu-s4
> +      - const: fsl,imx95-mu-ele
> +      - const: fsl,imx95-mu-v2x
>        - items:
> -          - const: fsl,imx93-mu
> +          - enum:
> +              - fsl,imx93-mu
> +              - fsl,imx95-mu
>            - const: fsl,imx8ulp-mu
>        - items:
>            - enum:
> @@ -95,6 +99,17 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  ranges: true
> +
> +  "#address-cells": true
> +
> +  "#size-cells": true

Please narrow the addressing.

> +
> +patternProperties:
> +  "^sram@[a-z0-9]+":

Use proper regex for unit address.  a-f

> +    $ref: /schemas/sram/sram.yaml#
> +    unevaluatedProperties: false
> +
>  required:
>    - compatible
>    - reg
> @@ -134,3 +149,34 @@ examples:
>          interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
>          #mbox-cells = <2>;
>      };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    mu2: mailbox@445b0000 {
> +        #address-cells = <1>;

Please follow order of properties as written in DTS coding style.

> +        #size-cells = <1>;
> +        compatible = "fsl,imx95-mu", "fsl,imx8ulp-mu";
> +        reg = <0x445b0000 0x10000>;
> +        interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
> +        ranges;
> +        #mbox-cells = <2>;
> +
> +        sram@445b1000 {
> +            compatible = "mmio-sram";
> +            reg = <0x445b1000 0x400>;
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            ranges = <0x0 0x445b1000 0x400>;

Same here.


Best regards,
Krzysztof


