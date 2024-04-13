Return-Path: <linux-kernel+bounces-143883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8626D8A3EBA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 23:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3E51F217B6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 21:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5205644A;
	Sat, 13 Apr 2024 21:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RIhlfSa7"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F36C1EB31
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 21:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713043672; cv=none; b=aiHP9FqAEhQtWVU5EHKxh9dcfRdiyh40mJuaXAYq/KTvw/jwp8UKyPRLoLe8jDHw1sh/gzL1tYxlzMLpI6GeUyw3/DIG3UY8caSFP5ubFMlyhnbRjYEPFpnEZFK2cyq+AWIAqmG10QNzxx+etE93NQvfYMjy2emL0TfVluM4opA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713043672; c=relaxed/simple;
	bh=WNLd9EcndabDAeWQ9Cd/Qcu4JrXSt7DWCJoe9nGgKUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZQAaVmQkkIvI1S2MjjSqsGAKmAN40/0HCmL1cUr8TsvLr0p67vSt+kIkDLd1UESUKno+y0/QV0XlWaNOB8VrVoveo62CYLc76ARUNRXov73gZXIdsQ1ygsnMBlODU+c3HzBp+6kgrl9m4uNzToX+ankhmCmzRZFtyrlmfFy9GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RIhlfSa7; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so5142303a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 14:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713043669; x=1713648469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mQk6Npg49mlyzD38L+YDjKT/YbU4SEnG0KL0Ydq3zk8=;
        b=RIhlfSa7IbLTQjbIoPKagCznko8BkG9xR7W2W++EbL5HC+bK9h0SS33mEUlmqYjA1J
         aOFFwbUNEqI1X68j0aFoUDUPd57YxrxOECO1fIAt/PDcmG6lx9jLcULtSZZnvYe1EiS7
         Yr5EZqMHuxrweACe6BM/sMPdWvfjs8ID2Ie99oRUF2r3x5sfb16LT0d3wfxKsrzocvI0
         wcsolQj3rf1AJeuGtowloZkonNTo8s4IQqGIn2LAdvXJjCIvKcrLmsFg2Nn4YQwyVbcw
         c18zaOpMNle1T7+58KqCEsvvUfbY5mNfr23ZuqIa2C1m/3qxdCzl0p8Axru/jE72EZ4C
         A2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713043669; x=1713648469;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQk6Npg49mlyzD38L+YDjKT/YbU4SEnG0KL0Ydq3zk8=;
        b=QhTpIOk+VjzOvkQA0mceXMNi544dkH/F2UWizJC3bxxFshfyFcl/SaTzXfehCB/5R6
         zOdtgIXCsJT6/MHC8+o4l7QhpgDGzZ7hqKDDkvhOn78LdqHp7rcP+MXERxkr4qpy8EFT
         j6rEmEsZJ6Xi7D7F0G3N7R+pocbNI5p+ze+YDZbeTAo+t7eCyl5L3zVKQL4C5o8z+uZ3
         zSImRe3LgG15ckuxw7A22aSPkxhoMQ66fUHRNs32tKyEZPDjQz5+rQd6QFt6LYK0QmWH
         c3BvQap1FMkQFU0hmQ9botStSmIxVCusLLGBaXqto6w7QbFC4WvuWh2elNE+zI1B0lbE
         fK2w==
X-Forwarded-Encrypted: i=1; AJvYcCUGkhXMQIq1gKEiJ0ttoYoo5g8ILoM3mKgin1EZHy84M5l6OEnmhlEFejcEo3MzxS0dVSyNZpWDnS5vssg8TxeWNYVrgOQ0/UYFvevw
X-Gm-Message-State: AOJu0YwgVPvS7q7S/3btnzIAesbEvPh5Dq90b+4Z1Qo8u/SIwHSpzLrN
	v5hfugdQSfMP/e2z6p+5jRGSstTX4XsX1EeFcMdrgHLoJOYF4qrtz9ZGhcp+qtI=
X-Google-Smtp-Source: AGHT+IFfQSnL4MNNFkXbY7KbB9xm8Pv2zIu6igGXtj2hRYd7g+pXy58uB6ahfj+OXZeXUxBNPTL2tQ==
X-Received: by 2002:a50:9e4d:0:b0:56d:faa3:7dac with SMTP id z71-20020a509e4d000000b0056dfaa37dacmr4929773ede.9.1713043668818;
        Sat, 13 Apr 2024 14:27:48 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id b44-20020a509f2f000000b005701ded12a8sm293416edf.69.2024.04.13.14.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 14:27:48 -0700 (PDT)
Message-ID: <72cf2a5d-55d2-4117-8b80-b3e517a7a9eb@linaro.org>
Date: Sat, 13 Apr 2024 23:27:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/6] dt-bindings: ROHM BD96801 PMIC regulators
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <cover.1712920132.git.mazziesaccount@gmail.com>
 <27a1c489f62e46a80643fe86cca101fb5aadb7f4.1712920132.git.mazziesaccount@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <27a1c489f62e46a80643fe86cca101fb5aadb7f4.1712920132.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/04/2024 13:21, Matti Vaittinen wrote:
> ROHM BD96801 is a highly configurable automotive grade PMIC. Introduce
> DT bindings for the BD96801 regulators.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
> Revision history:
> - No changes since RFCv1

Subject: missing "regulator" prefix, as first.

> 
>  .../regulator/rohm,bd96801-regulator.yaml     | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd96801-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd96801-regulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd96801-regulator.yaml
> new file mode 100644
> index 000000000000..4015802a3d84
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/rohm,bd96801-regulator.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/rohm,bd96801-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ROHM BD96801 Power Management Integrated Circuit regulators
> +
> +maintainers:
> +  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> +
> +description: |
> +  This module is part of the ROHM BD96801 MFD device. For more details
> +  see Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml.
> +
> +  The regulator controller is represented as a sub-node of the PMIC node
> +  on the device tree.
> +
> +  Regulator nodes should be named to BUCK_<number> and LDO_<number>.
> +  The valid names for BD96801 regulator nodes are
> +  BUCK1, BUCK2, BUCK3, BUCK4, LDO5, LDO6, LDO7
> +
> +patternProperties:
> +  "^LDO[5-7]$":

lowercase

> +    type: object
> +    description:
> +      Properties for single LDO regulator.
> +    $ref: regulator.yaml#

Missing unevaluatedProperties: false

> +
> +    properties:
> +      regulator-name:
> +        pattern: "^ldo[5-7]$"
> +        description:
> +          Name of the regulator. Should be "ldo5", ..., "ldo7"

Why do you enforce the name? The name should match board schematics, not
regulator datasheet.

> +      rohm,initial-voltage-microvolt:
> +        description:
> +          Initial voltage for regulator. Voltage can be tuned +/-150 mV from
> +          this value. NOTE, This can be modified via I2C only when PMIC is in
> +          STBY state.
> +        minimum: 300000
> +        maximum: 3300000

Hm, regulator min/max microvolts properties don't work for you? The
initial will be just middle?

> +
> +  "^BUCK[1-4]$":

lowercase

> +    type: object
> +    description:
> +      Properties for single BUCK regulator.
> +    $ref: regulator.yaml#
> +
> +    properties:
> +      regulator-name:
> +        pattern: "^buck[1-4]$"
> +        description:
> +          should be "buck1", ..., "buck4"
> +      rohm,initial-voltage-microvolt:
> +        description:
> +          Initial voltage for regulator. Voltage can be tuned +/-150 mV from
> +          this value. NOTE, This can be modified via I2C only when PMIC is in
> +          STBY state.
> +        minimum: 500000
> +        maximum: 3300000

Missing blank line

> +      rohm,keep-on-stby:
> +        description:
> +          Keep the regulator powered when PMIC transitions to STBY state.
> +        type: boolean
> +
> +    required:
> +      - regulator-name
> +  additionalProperties: false

Blank line

> +additionalProperties: false

Best regards,
Krzysztof


