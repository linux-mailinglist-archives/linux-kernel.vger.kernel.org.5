Return-Path: <linux-kernel+bounces-16435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B677F823E8F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8701C23912
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DC520323;
	Thu,  4 Jan 2024 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DEZWq1mA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CA8208BE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50eac018059so372513e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 01:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704360311; x=1704965111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f5UeSk+rYU6U1fSddtaMrbcYWqgT9+CuQL8j56T6xbs=;
        b=DEZWq1mAWQTUG/j0wxNDzgmhiovZ0ujUiXUAP1ExYZkr+xzIjiNAGGJMOl0ORhpEUk
         0Pn952519NBn3iG9yT3nv640wmjcg1N96JdRkF5rDsHjoHlNVpbTRp7SxoyerVpuwTVU
         jC+JZ8AZSrjrvGrDk+Onu8qE5UEUMkfAAT3KEVmVAaeFFYkxgeN5hV/bkFdH+QD+VOBo
         dV/FDEOOyIL3buNlxEFLe+Vt3jsZ7dLIOHO2VgBCSlqUy8B+8rYqFY+x7qw1Gmi7q9v8
         njHuTmZ99fSQcBRscg1tS3/Na+bo/XetEQffkwDB7QLj72Iv/MtPHCvnSiWWO5yaLOpL
         zXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704360311; x=1704965111;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5UeSk+rYU6U1fSddtaMrbcYWqgT9+CuQL8j56T6xbs=;
        b=Z5VkVc71qvGM5aL+SlnoNiAW/JWQx5hxmc4GYSH0LFJdt9AuKsJGuh03aeNOBq8Qer
         BOc/uZzk/L5acxyKWF60kbCwNbkdmZjuUCfGcDVhXcKgDOkQ6KhJs5Elk5uT9Yu8cfj6
         pkn4hYb2ZSnyxdDN2qsDKx7aFgZkl5GoYqLvzv11T4gbMsVOar8MUkirhxCFO7tLyj3S
         aN2CIfyI+sj/86eS6eJyTzQNk0mSXkaxGOrv65GNpSDJgHipH53U8C6zDR3xG4a81FAT
         md51JBPETMcYUFZz+n1h1yBA1az3s70QC62jD470d92mOS68b3FjblkuXC8GmmK61Zv0
         47TQ==
X-Gm-Message-State: AOJu0YwmVDxxPTnWTFB5SOt6GYg+Anqk4LvsdE/wH0ZGQO+RvONdYvMh
	3oIxkwYvG9w2gyZybOaOtTbvicxsbKz2JA==
X-Google-Smtp-Source: AGHT+IGOmKUJHCtEr2ZzdVpiHkMD9NCcF3RO9C/xpRphhwj+uGI82OBiGM8cnTdVitN6ax0sg7G3Xg==
X-Received: by 2002:a05:6512:2026:b0:50e:a6f8:aace with SMTP id s6-20020a056512202600b0050ea6f8aacemr173198lfs.35.1704360311316;
        Thu, 04 Jan 2024 01:25:11 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id i3-20020a1709061cc300b00a26a9593a68sm12981693ejh.76.2024.01.04.01.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 01:25:10 -0800 (PST)
Message-ID: <9cecc4bd-34ec-4b34-b0c8-de02473f038a@linaro.org>
Date: Thu, 4 Jan 2024 10:25:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/5] dt-bindings: regulator: add documentation entry
 for 88pm88x-regulator
Content-Language: en-US
To: Karel Balej <karelb@gimli.ms.mff.cuni.cz>, Karel Balej
 <balejk@matfyz.cz>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20231228100208.2932-1-karelb@gimli.ms.mff.cuni.cz>
 <20231228100208.2932-4-karelb@gimli.ms.mff.cuni.cz>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231228100208.2932-4-karelb@gimli.ms.mff.cuni.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/12/2023 10:39, Karel Balej wrote:
> From: Karel Balej <balejk@matfyz.cz>
> 

A nit, subject: drop second/last, redundant "documentation entry". The
"dt-bindings" prefix is already stating that these are bindings.

> The Marvell 88PM88X PMICs provide regulators among other things.
> Document how to use them.


You did not document them in the bindings. You just added example to
make it complete. Where is the binding change?

What's more, I have doubts that you tested it.


> 
> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> ---
>  .../bindings/mfd/marvell,88pm88x.yaml         | 17 +++++++++++
>  .../regulator/marvell,88pm88x-regulator.yaml  | 28 +++++++++++++++++++
>  2 files changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/marvell,88pm88x-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml b/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
> index 115b41c9f22c..e6944369fc5c 100644
> --- a/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
> +++ b/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
> @@ -54,6 +54,23 @@ examples:
>          onkey {
>            compatible = "marvell,88pm88x-onkey";
>          };
> +
> +        regulators {
> +          ldo2: ldo2 {
> +            regulator-min-microvolt = <3100000>;
> +            regulator-max-microvolt = <3300000>;
> +            };
> +
> +          ldo15: ldo15 {
> +            regulator-min-microvolt = <3300000>;
> +            regulator-max-microvolt = <3300000>;
> +            };
> +
> +          buck2: buck2 {
> +            regulator-min-microvolt = <1800000>;
> +            regulator-max-microvolt = <1800000>;
> +            };
> +        };
>        };
>      };
>  ...
> diff --git a/Documentation/devicetree/bindings/regulator/marvell,88pm88x-regulator.yaml b/Documentation/devicetree/bindings/regulator/marvell,88pm88x-regulator.yaml
> new file mode 100644
> index 000000000000..c6ac17b113e7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/marvell,88pm88x-regulator.yaml
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/marvell,88pm88x-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell 88PM88X PMICs regulators
> +
> +maintainers:
> +  - Karel Balej <balejk@matfyz.cz>
> +
> +description: |
> +  This module is part of the Marvell 88PM88X MFD device. For more details
> +  see Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml.
> +
> +  The regulator controller is represented as a sub-node of the PMIC node
> +  in the device tree.
> +
> +  The valid names for 88PM886 regulator nodes are ldo[1-9], ldo1[0-6], buck[1-5].

Don't repeat constraints in free form text.

> +
> +patternProperties:
> +  "^(ldo|buck)[0-9]+$":

You need to fix the pattern to be narrow. buck0 and buck6 are not correct.


> +    type: object
> +    description:
> +      Properties for single regulator.
> +    $ref: regulator.yaml#

Not many benefits of this being in its own schema.

> +
> +additionalProperties: false

Best regards,
Krzysztof


