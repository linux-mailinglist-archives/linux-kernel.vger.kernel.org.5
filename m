Return-Path: <linux-kernel+bounces-60765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04463850934
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB3E1C20E29
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32245A108;
	Sun, 11 Feb 2024 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lfyRtA93"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36EA61683
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707654670; cv=none; b=FmDJeoT8ug3M6IsCTRVOoozOchmrrh2PCR7pkYIhHDV3z5kWayWPZLeHJv9RQZytXDs38Ul7qSBBdYSHd+Vz+jZ2YY4tU0/GaDYJ1Jd7aNr8/X72vg63K+7O+ZiRhjkzcYfZfmViHqrqUFchfPhkY2wAe2wwaZRR/OEaIBZnVFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707654670; c=relaxed/simple;
	bh=Byh3QALddwWbe09AZxoMPKkeSBdvpBUaUYu9tQY4iJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iGyoY6jPfiZqwnkDXwcyVwVAlkM1Zj/CWfkj0XGLcpk5q98A8QMhx1geAMDn1cdTfUnhZp6mYiRxgGHO3flWhoKVFzashXGqipnulyoA3p/im5YIeKEwbfVbjqoQq2XKhLyoMyXggSAC/+EjG/B15cRz/BPETO/YQspw9vwdkOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lfyRtA93; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41090edfeb3so7372905e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 04:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707654667; x=1708259467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TlhezHxMst/l6Js8Jb5c85s1kBor6lNLzw63UUzO3EM=;
        b=lfyRtA93WLZPbtOnsmvZNyRHD94VW00tq7dlW2mcO5cngx7nSG1REuGmBIY5dfLMxl
         sBt88m32+UCKBt8n6kNQmJrr/RDVzKzShOutxULrONDm8AYSG8EcPDg3Ls2rFHl/OI3w
         PEGKI403c2yxaoMy2ciFVS/8r3M/9YuRyzf/7IuiitaLaVhOAIHT/ozKA5CCQdzKkLs8
         zWExwy+YFfkixgl6PPkKiQzk1BrYc9dtdbf/3ytpeN5BCZjelQEn0DoDMIIEu2bUs8i3
         YjXJbS0lpWfwjq6ZB7Hs62eKNEjqU8qMvLl5WDRqKhIZ60RT3WXxPFPJiysq1n5k6XRr
         ICqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707654667; x=1708259467;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TlhezHxMst/l6Js8Jb5c85s1kBor6lNLzw63UUzO3EM=;
        b=kdok7lBw6UGAmAYHP9jA/BtTnTPNc0j7fMIrnenzz7F1ehjCaaZHWhP6wEYrVCCAd6
         xFjsP6yOEKRBpDlIuPpFTfvq3CAj9hRtwSYReh1ENhBKYYMl8+cyqgwLfEH9F/ci0wqV
         U9Jdx2Zc6eO4L+0uNUMsm1H1uJVXoX489Sz3FVzrU70XkpTT6s8s0q8bFgN44OuhZqmK
         sMcjhntlEvdLrajWcQmLurwECs9URKDHZh33FrFPqlf0LAixVn1F2ylUKF/GmLWDDrtX
         k1+Lc6tyxKKUWT2eLxuqlUDmTU+QBdxuq7R/YZdOL7mHZ/exLJHo6SkidXy3Jn5QXVHW
         EJ6g==
X-Gm-Message-State: AOJu0Yze4uS7JU5Znu9ermkad5P9vjJwKTbH/YGJ5EZRedPul7L9cKQH
	7Da3ZM2UX1zBkHT8U0aex6cyBAlOGwaYUVUPKJSqkQ07yrKGu49uKJ/wXfwDa4U=
X-Google-Smtp-Source: AGHT+IEQttI9s33BqHQN0cE7nLErLNgK/WU+pW8bh1hWuTsdasRUhwLno6Q3sp/UONX8XquJhQ3NGw==
X-Received: by 2002:a05:600c:4588:b0:40f:cf69:3e1a with SMTP id r8-20020a05600c458800b0040fcf693e1amr3603529wmo.39.1707654666794;
        Sun, 11 Feb 2024 04:31:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBgt7FE3xiJd48SCWwRYMplcc4Dpm2vk4VRnwHt1XOtFzYrqbiQ1ygkj9y6qUKO2uZFqjIFyuYxn3+Tr2pm4ao3EpDmrSLZKpb3N/hR476FoUw2JVhNvqXtW5td5YagoPt+2gxiL8cV41hYH6d2+wZXv5lIOTslP6No3rDW5n9Tjhy1JsSgk2oAqVXZcpI61WGz9mrRiM5fOrCNCaYs3EFm4ya3ahSER7zYJ2ij0QeReascnfKILkxUc6c70okRUrzaWAjZoiVkATMWZ4fGBQtqA1b80b7VCZsf+6k9VHtvLWCiX1Xtq6IssAx03Mez1L2xXx/VXnCsXCu3lQXKflL81rt69aqw5QgAmAxX0SMefMORaneTBqeaYxIJXkXRa77IbYCiWYioZRx10uD5stuwNwuiHOL/+wt0GJlOyeHnv7oLpz/1ZrsldX7urc6kEot5Y8t1Tjfuf/VHUhIyUZLUh7exTJZUdkta+hAJZaADLBu58qyj1e7KAsgcJuJSY//Y2+WF5rYaN9DlIDr4w==
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id k20-20020a7bc414000000b004104c42ad5asm5703347wmi.22.2024.02.11.04.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 04:31:06 -0800 (PST)
Message-ID: <38e18310-4eba-4daa-b780-c719f38d3c5f@linaro.org>
Date: Sun, 11 Feb 2024 13:31:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/14] dt-bindings: bus: imx-weim: convert to YAML
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
 <20240210012114.489102-3-sre@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240210012114.489102-3-sre@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/02/2024 02:18, Sebastian Reichel wrote:
> Convert the i.MX  Wireless External Interface Module binding to YAML.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  .../devicetree/bindings/bus/fsl,imx-weim.yaml | 225 ++++++++++++++++++
>  .../devicetree/bindings/bus/imx-weim.txt      | 117 ---------
>  2 files changed, 225 insertions(+), 117 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx-weim.yaml
>  delete mode 100644 Documentation/devicetree/bindings/bus/imx-weim.txt
> 
> diff --git a/Documentation/devicetree/bindings/bus/fsl,imx-weim.yaml b/Documentation/devicetree/bindings/bus/fsl,imx-weim.yaml
> new file mode 100644
> index 000000000000..3d27bdaef304
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/fsl,imx-weim.yaml
> @@ -0,0 +1,225 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/fsl,imx-weim.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX Wireless External Interface Module (WEIM)

This patchset does not do what I asked to, but maybe that's just
coincidence that you send conversion now.

To recall:

https://lore.kernel.org/all/cee1ca11-03bf-4a0b-9ff3-490457f9fbe8@linaro.org/

> +
> +maintainers:
> +  - Shawn Guo <shawnguo@kernel.org>
> +  - Sascha Hauer <s.hauer@pengutronix.de>
> +
> +description:
> +  The term "wireless" does not imply that the WEIM is literally an interface
> +  without wires. It simply means that this module was originally designed for
> +  wireless and mobile applications that use low-power technology. The actual
> +  devices are instantiated from the child nodes of a WEIM node.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - fsl,imx1-weim
> +          - fsl,imx27-weim
> +          - fsl,imx50-weim
> +          - fsl,imx51-weim
> +          - fsl,imx6q-weim
> +      - items:
> +          - enum:
> +              - fsl,imx31-weim
> +              - fsl,imx35-weim
> +          - const: fsl,imx27-weim
> +      - items:
> +          - enum:
> +              - fsl,imx6sx-weim
> +              - fsl,imx6ul-weim
> +          - const: fsl,imx6q-weim
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 2
> +
> +  '#size-cells':
> +    const: 1
> +
> +  ranges: true
> +
> +  fsl,weim-cs-gpr:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      Phandle to the system General Purpose Register controller that contains
> +      WEIM CS GPR register, e.g. IOMUXC_GPR1 on i.MX6Q. IOMUXC_GPR1[11:0]
> +      should be set up as one of the following 4 possible values depending on
> +      the CS space configuration.
> +
> +      IOMUXC_GPR1[11:0]    CS0    CS1    CS2    CS3
> +      ---------------------------------------------
> +              05          128M     0M     0M     0M
> +              033          64M    64M     0M     0M
> +              0113         64M    32M    32M     0M
> +              01111        32M    32M    32M    32M
> +
> +      In case that the property is absent, the reset value or what bootloader
> +      sets up in IOMUXC_GPR1[11:0] will be used.
> +
> +  fsl,burst-clk-enable:
> +    type: boolean
> +    description:
> +      The presence of this property indicates that the weim bus should operate
> +      in Burst Clock Mode.
> +
> +  fsl,continuous-burst-clk:
> +    type: boolean
> +    description:
> +      Make Burst Clock to output continuous clock. Without this option Burst
> +      Clock will output clock only when necessary.
> +
> +patternProperties:
> +  "^.*@[0-7],[0-9a-f]+$":
> +    description: Devices attached to chip selects are represented as subnodes.
> +    type: object
> +    additionalProperties: true
> +    properties:
> +      fsl,weim-cs-timing:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        description:
> +          Timing values for the child node.
> +    required:
> +      - fsl,weim-cs-timing

You need to integrate it into mc-peripheral-props.yaml. Also check how
other bus controllers define children schema.


required: block goes here.

> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              enum:
> +                - fsl,imx50-weim



Best regards,
Krzysztof


