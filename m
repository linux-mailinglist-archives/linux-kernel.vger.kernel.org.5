Return-Path: <linux-kernel+bounces-60770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 763FD85093E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D710286CC7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4725C61A;
	Sun, 11 Feb 2024 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GtTD4Oud"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906955C61B
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707655175; cv=none; b=Sh1ReOfjUJggdWIzAOxKQxX1afxsf40PJpFeHHqZhCRU9cprOUJj+FHe1DeBMZGRCHBikXQnT35anlnrV8AiE8gSaXDNY90RBcrBfRZ1lbm1eq+hvpwDeIenSmQsHrfnBGy2K1KnjNl/J5vCy2VgKB0khQMt8bQ9mriwtdC0srE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707655175; c=relaxed/simple;
	bh=2V2yDYxoItFhXUCgtvJq5rQNVrqpcDr4wZ0AGQqNdxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g5wcG+oGs5Gi1DuNsYzqH2P+atbbrsN8iJpxv9PNrY+8xnszG68ivhwDnOS5ZqtXXVe1reN5eUL6JB/HGIZ+H76N9IdqcGTJvB21DEotNMH5ObHqFa5V4qXXqepaqUt4DPY75TKEP+glOhnc3XbeycOekpOCuz1NFU2nkImgczw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GtTD4Oud; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-410d087c528so378095e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 04:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707655172; x=1708259972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1BAd8bQbs7lW+hpkF4LWcpfhLI7MuGzzyc9i8yKpXHQ=;
        b=GtTD4Oud2jKW2ptTIzUmakhnuZDKh8Tduqu/+Wk+9oeRSU7WI77/nUwnQ0kEs4oEnv
         tUZTi86or9W/flp6W88xVdPJaF9rxQX6KAlV6o2GDIEMlXBFNPW5e/ZuHAAtGEmQqBDf
         0n/FkneWLX0yTaUz3XDagfm1g5Sr2BqVXw5a/Uui8Foj4K7XvrwR3mwJSavNb+HEj414
         210B3psjf8H47q7rGHeYFfXIVNNjy5UM68Wz4k01lYCIX0o/RoB8TcD+U1YWvsgxKzM1
         rXVrRX0ITfTSgsX2Sp07bDUDkdenGmYC1wlMcDzU5vRDWK/mnXpeWpdPO1zIOYo8V1Jo
         kL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707655172; x=1708259972;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BAd8bQbs7lW+hpkF4LWcpfhLI7MuGzzyc9i8yKpXHQ=;
        b=Odotf9w1zC/E7aNau03XizCuCu1egGWXjqDoBs+LcIAGszJv0dC7f2+MLIBehLFWbk
         3oMNoaiuV9pMlT2B0X70ZWp230MFLE6UzC6BsmDW/F6tieb7Zwrp2VcwBHPxwba5zjrK
         OfIGWF9ukj1tSbAG5gTvUgY1FmdTx2jovUUvplKSgLbmBKqOgUIfvw74LW/RCHnPt4pS
         WYikdOSZ80MgNfb1G4MnaOGESAGnbDP/CHXzgSv+XL76IAWEyQEqh9uB/CPAGMhNJvSx
         Hr+pd3tLDghLJ8dyceLxmMnjVResYd/7Sk2AKRdeBhepDxZ6G6KiDBQVLXkhAWvWXwWF
         AaRA==
X-Forwarded-Encrypted: i=1; AJvYcCWDx6h36n6pXZ3eM11z9sEdpCvwHqs9ebzoNXUsAaICoSofUVCnPVO33NA7lKdQAR1hWV0mlm8fEoJFzUrBhFUC6JJb/T1tnHIq/j0h
X-Gm-Message-State: AOJu0YwTTC76oSsCHJ1rot/1hWr0ucw/BtzG8Ca8CxCNZymAaNbFSjY9
	xPv2M3AfxVrxDULAFrw1AyHlVtaLLKb+gQoLJETllkrWc8+VN3fGJQwmYvp8q3w=
X-Google-Smtp-Source: AGHT+IEwhANyeu9YJWIz0cH62qpG7jJB5CW5p4OeQZ5+pTL2vhXmrQvVHa8/Vus+Voudd1GDJn1Omw==
X-Received: by 2002:a05:600c:3591:b0:410:8ab6:8c7d with SMTP id p17-20020a05600c359100b004108ab68c7dmr3308232wmq.0.1707655171807;
        Sun, 11 Feb 2024 04:39:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWNq0JdqO8YR6VYQ5z5T14JjOBBnJ3gUhdIk9azS5RTw6JLGcTCn08VU0FwLA2tKQVo+krhJ7ALx95LBxOUBJogAtreQ2kpWTVszCm8Gu73XloPKx7n7N0UoaxN6GjuNPHeo9MLSd4ibXQsRjES18eALGSA7dfinpKXKsWxSrw/8LwSv1Cjh8G0UcdWd6wasNhlXQMO7BePblYO0cEL8Dhvjt8M4xduafv58sERzn30ZEmDAOFoQvcc8d/v0i/GsccsS3BzhHbkCw9Dgju/SfAexwNtkPWwXHo96QWoHv3H5sObJskrlbbFmuC7qf7dVDcTlC+TNj2wbxHHmFh/dGp72JDXs9yqWdLM9mG9lUCFdyjYmWdwplzPlQGO73w9uYevHStJtgXLqZeoZtRPbmkQQHjmiqho7zShGp6841GbnyU3G6LJtyM7QGJURo/Afn961G72jIptqjWZHXgh7WGaur3WgGdU+SLLK3iyJ8fNCIDet5Qb+q+4b4vXZsvRgx+BXhnFPqxcVuu+bLFjiQ==
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id jh3-20020a05600ca08300b0040fc2f07ed5sm5828554wmb.27.2024.02.11.04.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 04:39:31 -0800 (PST)
Message-ID: <7e127492-f0ff-43d1-87f4-ad562604a836@linaro.org>
Date: Sun, 11 Feb 2024 13:39:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/14] dt-bindings: soc: imx: fsl,imx-anatop: add
 binding
Content-Language: en-US
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240210012114.489102-1-sre@kernel.org>
 <20240210012114.489102-6-sre@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240210012114.489102-6-sre@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/02/2024 02:18, Sebastian Reichel wrote:
> Add missing binding for i.MX anatop syscon.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  .../bindings/soc/imx/fsl,imx-anatop.yaml      | 125 ++++++++++++++++++
>  1 file changed, 125 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-anatop.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx-anatop.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx-anatop.yaml
> new file mode 100644
> index 000000000000..436fdae1879e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx-anatop.yaml
> @@ -0,0 +1,125 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/imx/fsl,imx-anatop.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ANATOP register
> +
> +maintainers:
> +  - Shawn Guo <shawnguo@kernel.org>
> +  - Sascha Hauer <s.hauer@pengutronix.de>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,imx6sl-anatop
> +              - fsl,imx6sll-anatop
> +              - fsl,imx6sx-anatop
> +              - fsl,imx6ul-anatop
> +              - fsl,imx7d-anatop
> +          - const: fsl,imx6q-anatop
> +          - const: syscon
> +          - const: simple-mfd
> +      - items:
> +          - const: fsl,imx6q-anatop
> +          - const: syscon
> +          - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 3

You need to describe items instead (items: - description: ...)

> +
> +  tempmon:
> +    type: object
> +    unevaluatedProperties: false
> +    $ref: /schemas/thermal/imx-thermal.yaml

That's confusing. The imx-thermal has phandle to anatop and is a child
of it. Please sort it out, e.g. deprecate one way.

> +
> +patternProperties:
> +  "regulator-((3p0)|(vddcore)|(vddsoc))$":
> +    type: object
> +    unevaluatedProperties: false
> +    $ref: /schemas/regulator/anatop-regulator.yaml
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx6ul-clock.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    anatop: anatop@20c8000 {
> +        compatible = "fsl,imx6ul-anatop", "fsl,imx6q-anatop",
> +                     "syscon", "simple-mfd";
> +        reg = <0x020c8000 0x1000>;
> +        interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
> +
> +        reg_3p0: regulator-3p0 {
> +            compatible = "fsl,anatop-regulator";
> +                regulator-name = "vdd3p0";

Messed indentation.



Best regards,
Krzysztof


