Return-Path: <linux-kernel+bounces-99276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39058785CF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B6028195A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8BD48792;
	Mon, 11 Mar 2024 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ciMd9Sfh"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E044594B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710176137; cv=none; b=o02V3sWZsnanHdCr8o3y4INXdu3Q1a5lvk2k7o9aRuTEHfBnLIs1YiGqS5pJJZfokHVdERAzlwH2ebVrR93k3uSBzofm9r4UzHw+Br23tHngQ+LGHJhBEVA+WGRNjl6CnxCxzaYRM+i8HFHm0q06kdmMUNxupknh6q46ho9xpj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710176137; c=relaxed/simple;
	bh=oz2AhnMnqKeJCiy1sEwnUYrMKp52jC5sQnFpOO9Lfw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0NDfp2wAZPPgm5O70e6nJLV3hDs9WbwD/i7FtR7LGcIjV/JVp1p84/xQKIgpBSPGMfcU2tCdy9PQMZJcQCX621Z81hcW8QF36/DJ71eokpoDwFSH2KWDyzL8kz5XSQLfDFAzLw2/86hSy0S5m8ScVN/Lop339+xkDTJ6fUR34w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ciMd9Sfh; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5131c0691feso5945574e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710176132; x=1710780932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QRBazjZ4ooJccMR7Nywf/WMFMtOUOpJov8lMBOj6eEA=;
        b=ciMd9SfhdzoeyO1XAAxds4fTjmO5+JZlrqVnnb9guu+dlihPjIlcrOfe8LBOYc4Fxx
         5ZQZttUazyE03OCVX4KBGuvMCxtrMdJ/Vl3ItUiZeULdj6P/0qd/I1AA7g9Y4BamlR5W
         4GOhW+rrgUTVynpP3UXwI51zLaaFkpC/89Bsz0i38Of0PTNmn8ianxCwQRIQjk4IjYNG
         VDoG48dRgQpjpiOcVa8j1VHvsb+kJ3ikUK6d59pHYyYpa6DFe5SFQAcpuRTlJsC5FaDa
         rn2qH7etMP9NwnlBzBikt2WTF8tsJ+E7k7t9oeqv5MM9Xq8Xa79tiuKNw/Pw6ovgcZnn
         dQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710176132; x=1710780932;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRBazjZ4ooJccMR7Nywf/WMFMtOUOpJov8lMBOj6eEA=;
        b=eGvAXZht4Eb0H6j624C8ui3sobYDmKnV1pbqkdF/dTYgWiN6M+o/7384D6Jhk+O9Bt
         CJ0RvxMAo48OlQuMnI5rKozLMtSdEW2Fmd6q9ogQEhajmd0imUOneDOXLgciTuPf1kaq
         azDBDJJ6NT6nlTOegdjUBklb1pJDOiY8Mjuj9AiAdrESsMXG1mdudnS426g8ejbQbkE2
         NMPrEDJp9Y1yC6gr5Vv2Z5sXhfco+4PHjwgG2e+NFofiED5i65VzUVwSAlHKNH1AWlO9
         GoEfKmNWmPzI6C7O4XE0Y2eVh7XqKc3TrWttwzqBYCk/BrXDQv/4B8zM7VOIos0GKZrk
         4tSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaZQXYPzMBRSZPiV/iKxWksfruky22WNfHL5WIJ0+U2YKFgikeklRsb0VvgIZBYYW40wbEos02GApI5fx6W3JB5npjhKm2gEq519D3
X-Gm-Message-State: AOJu0YyAspTHu+6ng+d8Y9YrUnSF2klBM+nMaU7VS+160d8+Wh5lcpmG
	E2YVZEqlw2ldon83BED4i+lPdy+Eq2GxXgL9mGMsY7m/vOabv2Sd6H6vh2bg3uQ=
X-Google-Smtp-Source: AGHT+IGOY67IrkqCiB1cD3YKFOgbzoG+b1J/HDUBnxkdAT3fcbak6FrRlrBMpl+LnL0MgIlypybrDw==
X-Received: by 2002:ac2:598b:0:b0:513:97e3:43cf with SMTP id w11-20020ac2598b000000b0051397e343cfmr3944161lfn.32.1710176132345;
        Mon, 11 Mar 2024 09:55:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id z11-20020a05600c0a0b00b00412f428aedasm16278722wmp.46.2024.03.11.09.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 09:55:31 -0700 (PDT)
Message-ID: <6fb70adb-aa85-4b9c-b093-afa4ec7ed056@linaro.org>
Date: Mon, 11 Mar 2024 17:55:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: hwmon: Add maxim max31790 driver
 bindings
Content-Language: en-US
To: Chanh Nguyen <chanh@os.amperecomputing.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Justin Ledford
 <justinledford@google.com>, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Open Source Submission <patches@amperecomputing.com>
Cc: Phong Vo <phong@os.amperecomputing.com>,
 Thang Nguyen <thang@os.amperecomputing.com>,
 Quan Nguyen <quan@os.amperecomputing.com>
References: <20240311111347.23067-1-chanh@os.amperecomputing.com>
 <20240311111347.23067-2-chanh@os.amperecomputing.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240311111347.23067-2-chanh@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/03/2024 12:13, Chanh Nguyen wrote:
> Add a device tree bindings for max31790 device.

Subject: drop "driver", bindings are about hardware.

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

> 
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> ---
>  .../devicetree/bindings/hwmon/max31790.yaml   | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/max31790.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/max31790.yaml b/Documentation/devicetree/bindings/hwmon/max31790.yaml
> new file mode 100644
> index 000000000000..5a93e6bdebda
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/max31790.yaml

Filename like compatible.

> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/max31790.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: The Maxim MAX31790 Fan Controller
> +
> +maintainers:
> +  - Jean Delvare <jdelvare@suse.com>
> +  - Guenter Roeck <linux@roeck-us.net>

You should have here someone responsible for hardware, not subsystem
maintainers.

> +
> +description: >
> +  The MAX31790 controls the speeds of up to six fans using six
> +  independent PWM outputs. The desired fan speeds (or PWM duty cycles)
> +  are written through the I2C interface.
> +
> +  Datasheets:
> +    https://datasheets.maximintegrated.com/en/ds/MAX31790.pdf
> +
> +properties:
> +  compatible:
> +    const: maxim,max31790
> +
> +  reg:
> +    maxItems: 1

That's weirdly empty.

> +
> +required:
> +  - compatible
> +  - reg
> +

You miss allOf: with $ref to fan controller schema.

> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      max31790@20 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


Best regards,
Krzysztof


