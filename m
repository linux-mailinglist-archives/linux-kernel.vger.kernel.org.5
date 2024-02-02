Return-Path: <linux-kernel+bounces-49380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282268469BF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D169B2825C9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEF517C69;
	Fri,  2 Feb 2024 07:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wBqMaEym"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C9D17BA4
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 07:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706859959; cv=none; b=q1z05qUva28gidWQ6jhyWlzfLYIRFLlfTKRQUl3/ZPVgwoJUN/Sc5PHayyzacZwMWJYLGij22daZRcBCpn8RiWoYEH6m2yIdJ2PpxMMsZTZf7CQxcrJHa4M0sWFzbqlpKlyOmtwIwn6fSXSRuok3PyHRRjD3CS562LvjmL/BDFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706859959; c=relaxed/simple;
	bh=NAsooKUMZ6cRT7XPqJjE+9VvMXnUOT5yUMaTp3y7h0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WYnt53eizEyKZc5is9GISiIlhqPGDlkG+obnqLD68tE7KnG2tyFt4ulZs1gI27Y1KVWVxia0PFDglcJGYLjy7c7EI9oX5Qx7FXp9irPInVf2MkvN1v1DyD/7/MfNLW2BnZh4wBQClfhyrMdwf4ZuTS5jjdQk96dfBe2JI5bGpG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wBqMaEym; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55f03ede12cso2358426a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 23:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706859956; x=1707464756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FMbsAERs2rab2klKMjzdXggrU7C85LLi4M4OtVPYEoc=;
        b=wBqMaEymCuq14vkLy9pVFSW5741xC1OFFcBnDdc1JFdcz7+jQ8i38GmVqGYJ9cC1jj
         qvjFsK5LiiWKv4x2Ss/BU+ZBQtTR0HEUE6ZtOPj3VqiddMlOt8o+m9gEbC0U6CSnha7U
         ddt1ens8ZPzq94UjHy6GEKBt7OdhQI6iyT97tAmwFZR8azVw45ZauyglrPuSLcP4L/r4
         lDiU1wjaypGz2YvSlh7RC73S6hjgnYRzI6RIOFfOpK/opB54eEhDrO+RzwsTef6S1Vn+
         U70tzI/Aa6j043plCRW50gsoj/vzyWDd+Aj6vSjexYpTUvofJesBcEYT5Ja01cf3yJLm
         LfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706859956; x=1707464756;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FMbsAERs2rab2klKMjzdXggrU7C85LLi4M4OtVPYEoc=;
        b=i89lCsAHIH4ZtXwbLmqkyCulTk+0BMmexZrU2GISQu9hIRb1wzVU6erOnfQmn8F16T
         daRQSsMIfd8ea0iBb5P+iSKkpeqGYUn7TQ+KDi2Z1Vj+vG9h6bUHRwBCKl1pP/X1eLSv
         /Kg6J2DCQOkosztfCxstZ8EzikzOaEF9j4s8QD/x7M5xXLajNZ1NPiTmp3ea+bRFzgl0
         rdpMQNRdfGdhOACFdifEqd1uKDgOnakoPWQt8mF9Ov8p+C9BPG5Y+yE6hy1DTV+Slzkt
         PUyv++R8ApO5SGoVd4CPxSYnIHGmq4WcK+ojpsITRk+2y/otwA6U9hVJrOhuwfwrW6PG
         pMfQ==
X-Gm-Message-State: AOJu0Ywidhm7jXeTw9WO56GuVHytlnXj+GHpDuJqVcdxi6hl5i3Y45EU
	zRNQVYZ9vYBBgP/S5Oq9O57S4NpSjF3ug+byhVY9eEbMsNea+AUy7nFWfB1/FHY=
X-Google-Smtp-Source: AGHT+IEyxsNxiMuwL3uzYLii1hFVrh4VLP2keiW3l91Jpx0fb4fpxbnrR6I2DVY4suvdJnUcE6REyg==
X-Received: by 2002:aa7:c718:0:b0:55f:f13b:9b62 with SMTP id i24-20020aa7c718000000b0055ff13b9b62mr478863edq.2.1706859955785;
        Thu, 01 Feb 2024 23:45:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUIx0O0cGAowPI4Y3BYEppq2FCSzTCYiWkE8WqTLqEDCitiWXX5mJI2bWpgSGFHOYydG2t0lNYefEteGMj4P0mKNSfl+3UB0hwI/5rSOixC2mQDtYh6tBJDcnunVp9s7ilX3xniZ2EYeCjDCLLNzaiaUaJfyJON0t3kuYRxOATcg5NuF5ZejjiYkdBSwhYUZBCcYYCcylI7zjSU/rQVRkiE2vU6f2JSARD/FrmnPfjhhleA0FeQwyK5TcKItl8biOsKvZUjP/IVtGf9vrofKtwN1uk+6NZ34DB71Uac3sa2AUiTOZqhVXFTcYUAhLzndLXHMBk/dnl7eOt9Fr9XM37nuMfy5jrC3n8xyEYCmun4QdGwSHF4PH3nHSAmIjXmYTuANz+LRntqyRFEQONC9oNw+0XEf5tX5u3rhi7THno04HqEDFIBLlRkTK8rk1+AOFVP3ER5yZlrrS0y5TC2HXBf7JBrHRKNAau2IfnjWVdr1897ZqCfs89ZmXq1SLMs1p1gHP+CFPoGwfe5hv5DJHcgosKUPI/8Hz4U1hIWIu5+do3/D1IOFOtRfH8QRPUo/Kt6OLLLILakX640kYQC2VVj5lPw0b1ptTNRKloT1J2LAx2Z19EaytE=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id x2-20020aa7dac2000000b0055f129cea52sm71587eds.49.2024.02.01.23.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 23:45:55 -0800 (PST)
Message-ID: <94dfc4c4-5fe6-438d-bcda-4f818eafd2f0@linaro.org>
Date: Fri, 2 Feb 2024 08:45:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v5 6/9] dt-bindings: net: Document Qcom QCA807x
 PHY package
Content-Language: en-US
To: Christian Marangi <ansuelsmth@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Frank Rowand <frowand.list@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
 <20240201151747.7524-7-ansuelsmth@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240201151747.7524-7-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2024 16:17, Christian Marangi wrote:
> Document Qcom QCA807x PHY package.
> 
> Qualcomm QCA807X Ethernet PHY is PHY package of 2 or 5
> IEEE 802.3 clause 22 compliant 10BASE-Te, 100BASE-TX and
> 1000BASE-T PHY-s.
> 
> Document the required property to make the PHY package correctly
> configure and work.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/net/qcom,qca807x.yaml | 142 ++++++++++++++++++

Your bindings header must be squashed here. Headers are not separate
thing from the bindings.

>  1 file changed, 142 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/qcom,qca807x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/qcom,qca807x.yaml b/Documentation/devicetree/bindings/net/qcom,qca807x.yaml
> new file mode 100644
> index 000000000000..1c3692897b02
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/qcom,qca807x.yaml
> @@ -0,0 +1,142 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/qcom,qca807x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm QCA807X Ethernet PHY

What is "X"? Wildcards are usually not expected.

> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +  - Robert Marko <robert.marko@sartura.hr>
> +
> +description: |
> +  Qualcomm QCA807X Ethernet PHY is PHY package of 2 or 5
> +  IEEE 802.3 clause 22 compliant 10BASE-Te, 100BASE-TX and
> +  1000BASE-T PHY-s.
> +
> +  They feature 2 SerDes, one for PSGMII or QSGMII connection with
> +  MAC, while second one is SGMII for connection to MAC or fiber.
> +
> +  Both models have a combo port that supports 1000BASE-X and
> +  100BASE-FX fiber.
> +
> +  Each PHY inside of QCA807x series has 4 digitally controlled
> +  output only pins that natively drive LED-s for up to 2 attached
> +  LEDs. Some vendor also use these 4 output for GPIO usage without
> +  attaching LEDs.
> +
> +  Note that output pins can be set to drive LEDs OR GPIO, mixed
> +  definition are not accepted.
> +
> +  PHY package can be configured in 3 mode following this table:
> +
> +                First Serdes mode       Second Serdes mode
> +  Option 1      PSGMII for copper       Disabled
> +                ports 0-4
> +  Option 2      PSGMII for copper       1000BASE-X / 100BASE-FX
> +                ports 0-4
> +  Option 3      QSGMII for copper       SGMII for
> +                ports 0-3               copper port 4
> +
> +$ref: ethernet-phy-package.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,qca807x-package
> +
> +  qcom,package-mode:

Where is definition of this property with type and description?

> +    enum:
> +      - qsgmii
> +      - psgmii
> +
> +  qcom,tx-driver-strength:

Use proper unit suffix.

https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml

> +    description: set the TX Amplifier value in mv.
> +      If not defined, 600mw is set by default.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [140, 160, 180, 200, 220,
> +           240, 260, 280, 300, 320,
> +           400, 500, 600]
> +
> +patternProperties:
> +  ^ethernet-phy(@[a-f0-9]+)?$:
> +    $ref: ethernet-phy.yaml#
> +
> +    properties:
> +      gpio-controller:
> +        description: set the output lines as GPIO instead of LEDs
> +        type: boolean
> +
> +      '#gpio-cells':
> +        description: number of GPIO cells for the PHY
> +        const: 2
> +
> +    dependencies:
> +      gpio-controller: ['#gpio-cells']

Why do you need it? None of gpio-controllers do it, I think.

> +
> +    if:
> +      required:
> +        - gpio-controller
> +    then:
> +      properties:
> +        leds: false
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false


Best regards,
Krzysztof


