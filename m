Return-Path: <linux-kernel+bounces-18659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FDA8260AB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912ED28368B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29828C12;
	Sat,  6 Jan 2024 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CIVjDSn8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4C38839
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5537dd673e5so434891a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 08:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704559722; x=1705164522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1gxkkyY0NgnEFE0qenhqy+2FYmyUU46vZMZfH25Y2gs=;
        b=CIVjDSn8KdIynOJIK2X1C7LE9x3O4nsBZ9LhTCI+Vh2kLW/l8Ef0dFlTRWJBqw61ZD
         yT5ScpNIl83NKj19pn5PfZbGj8tCTsCDD8lqaTF4AysiDjcPJ6ek64kHN07yJOh2/EkC
         dnkRwcM5Ub0L4DSACLOo/5vtmSdGVUhJyx4Rb8ZFtA6AgI78x3QxkxFV8NIcL3E5j2Up
         OO7oCrr/71ih1PtR7nOkcZreL4WdoMxoDPiRMXTmAzdZUA7hoKSLVHA1BMYwp48NLtWX
         ttLuDgUmP4BOjjJdRcxyCSRCz5/cR8LiidBXiQK0E/5hzHR+VgrDeIC3mbLrLQR+EOg+
         Fd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704559722; x=1705164522;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gxkkyY0NgnEFE0qenhqy+2FYmyUU46vZMZfH25Y2gs=;
        b=hAlWx3qOeohkKQVx3sqiQm8XLcOMhhFUZv6r7IYEZGgi5wc/qLfFETYH8sLqlZOkul
         G1D6Nc11MzMI+2Lndhv8vb0OjKNNsHS6dGWA/ZhJs9MVunZVBiPAIC3v3A0Yh2xEoICF
         M+vOM5wsF1dFKaWOC3eDneOXZmtlOfmWYNweMxconyn/w+UmMa14faQyAKDZPDwQKf4V
         UfO0eEcASNH10h2YKYHRNrhQzXBe/xE9/guFKY9aOJL//LH57+BkLzjbI2ptDqLoN4JZ
         nVW/wlzReILqLIU/XL4YWGEVqZ+k/hPvpXLQX92ia2egDNia3qxJ9jPkBj/F0dY/3QOH
         x2pA==
X-Gm-Message-State: AOJu0YwW4D+jcK/e6huzh2c9uqSztCM0XLbFXhusJ4/rX7W7UO+7jwGG
	WEo7mg2AcHTO0k1dgx2VejGtmGyTu/w9Rg==
X-Google-Smtp-Source: AGHT+IF6s0LqDLu8k0+eOXzOcZDpdRNOyP6ZwUXPdc5ARCh6iNnTQuCm7g5/cckLDa/hiQkoggMoJQ==
X-Received: by 2002:a50:d78c:0:b0:557:7386:3c44 with SMTP id w12-20020a50d78c000000b0055773863c44mr218366edi.65.1704559721921;
        Sat, 06 Jan 2024 08:48:41 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id t21-20020a508d55000000b00554753ec02fsm2326764edt.86.2024.01.06.08.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jan 2024 08:48:41 -0800 (PST)
Message-ID: <ce7184e5-7901-4763-984d-492e8e97e36b@linaro.org>
Date: Sat, 6 Jan 2024 17:48:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: power: supply: stc3117: Convert to DT
 schema format
To: Bhavin Sharma <bhavin.sharma@siliconsignals.io>, sre@kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240106133546.936261-1-bhavin.sharma@siliconsignals.io>
 <20240106133546.936261-2-bhavin.sharma@siliconsignals.io>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240106133546.936261-2-bhavin.sharma@siliconsignals.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/01/2024 14:35, Bhavin Sharma wrote:
> Convert the binding to DT schema format.

Subject: It's totally wrong. There is no conversion. If you claim
otherwise, please point me to removal of any file in this patch.

> 
> Changes in V2 resolved below errors:

Changelog goes under ---

> 	1. string value is redundantly quoted with any quotes (quoted-strings)
> 	2. found character '\t' that cannot start any token

Heh, you still did not test it.


> 
> Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> ---
>  .../bindings/power/supply/stc3117-fg.yaml     | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/stc3117-fg.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/stc3117-fg.yaml b/Documentation/devicetree/bindings/power/supply/stc3117-fg.yaml
> new file mode 100644
> index 000000000..d6607a5ea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/stc3117-fg.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/stc3117-fg.yaml#

Namke matching compatible.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STC3117 Fuel Gauge Unit Power Supply
> +
> +maintainers:
> +  - Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> +  - Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> +
> +allOf:
> +  - $ref: power-supply.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - st,stc3117-fgu

Can stc3117 be anything else? IOW, why "fgu" is needed?

> +
> +  reg:
> +    maxItems: 1

No properties? No resources?

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false

unevaluatedProperties instead

> +
> +examples:
> +  - |
> +    &i2c6 {

Just i2c {

> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      st3117: stc3117@70 {

Drop label.

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +        compatible = "st,stc3117-fgu";
> +        reg = <0x70>;
> +        status = "okay";

Drop status. Add missing properties for this to be complete.

> +      };
> +    };

Best regards,
Krzysztof


