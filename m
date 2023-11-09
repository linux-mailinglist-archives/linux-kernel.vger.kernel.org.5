Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8320F7E65CA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 09:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbjKII4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 03:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjKII4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 03:56:17 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7187171D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 00:56:14 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40839652b97so3702715e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 00:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699520173; x=1700124973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C/Oc2Ri08TlARcuCbFX7jlwJIbMzeX1P2oeV470H4hk=;
        b=acNULdN1ij2WrwhgGcnf7bHJtkAORvy+gP/mpevmLEDxPg22hZRZ7i1NWSEeUeZ/oq
         TnlBBT9f7hbJp7sViFWMHXmdBh8FGAWCE7r2Q98zQ2gbVHf552w2ENmt6cU1laZvLTTj
         py5gNyF3jum2O1BKm3+YnZxDfJ6SrNypYRpKoiwkURr89WNyyq9JfF7j/Z/VxCTtJUnY
         HZIk1THyQUSCwDLrd01t3PNETwhD1IYMKiu4C6rKkdAEPgo70UcOGnU/+8ikpnyxCQ8L
         eQ9WQ7uWow46tNb3ESsa8MKU88A/vw4ZtkOBu88D72RefyM4VRrr7dJAj/YY4Dm22LtK
         qT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699520173; x=1700124973;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/Oc2Ri08TlARcuCbFX7jlwJIbMzeX1P2oeV470H4hk=;
        b=qFywpvdE0JffNFkiPfh+YduEwBfQczPSdu162hQvrlBx5Xn4csUVFvqcksJmEaIVqD
         w2EM7DJ0I46ogVmB1EQqeQyFB6gVYw4iEGooXkLo8aiwHL/QET4ngkevkRmeEDC3Wsld
         LVpQLAtaqQuVtRRUIDd48RNtKee++nh9iM1iUpUm/n7YS2fOi9hvhinJTyLmjZspxg/w
         Sc/OZd9JNOJE68ROgVMqdqNYy5DBIO85gyNWDuw+SolLrq4yu1bUfQcNpgrJ5DQbe465
         p+AM2evZ4qheL9VlP6sdVIUnWq23lTFshnKBLwCc9TOnYUMCuAm9KN91GDpa/2H4fSkn
         TXrQ==
X-Gm-Message-State: AOJu0YzqCgoKeBnrtxOvUY0AxWiJkGRnvZr3C+i+YA2skMVEJ7u8IQfW
        TEgECWfDv2TjfEQrnIYPDsBKfQ==
X-Google-Smtp-Source: AGHT+IHxV0c5K+HW648KGXbRUM/dBxgAWN/R3MureWTsp8lzf6mVtsfAt6CPWUk7l/CmSjN0DyPJ7w==
X-Received: by 2002:a05:600c:32a7:b0:408:fe93:a2f7 with SMTP id t39-20020a05600c32a700b00408fe93a2f7mr4067831wmp.37.1699520173091;
        Thu, 09 Nov 2023 00:56:13 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id q3-20020a05600c46c300b00405442edc69sm1412660wmo.14.2023.11.09.00.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 00:56:12 -0800 (PST)
Message-ID: <f9d25b19-ef26-480a-ae47-60dcba704ee5@linaro.org>
Date:   Thu, 9 Nov 2023 09:56:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add mps mp5990 driver bindings
Content-Language: en-US
To:     Peter Yin <peteryin.openbmc@gmail.com>, patrick@stwcx.xyz,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20231109044844.614007-1-peteryin.openbmc@gmail.com>
 <20231109044844.614007-2-peteryin.openbmc@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231109044844.614007-2-peteryin.openbmc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2023 05:48, Peter Yin wrote:
> Add a device tree bindings for mp5990 device.
> 
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
>  .../devicetree/bindings/hwmon/mps,mp5990.yaml | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/mps,mp5990.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/mps,mp5990.yaml b/Documentation/devicetree/bindings/hwmon/mps,mp5990.yaml
> new file mode 100644
> index 000000000000..bfd0cf7d3470
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/mps,mp5990.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/mps,mp5990.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Monolithic Power Systems Devices MP5990 Hot-Swap Controller
> +
> +maintainers:
> +  - Peter Yin <peteryin.openbmc@gmail.com>
> +
> +description: |
> +  Monolithic Power Systems Devices MP5990 Hot-Swap Controller
> +
> +  Datasheets:
> +  https://www.monolithicpower.com/en/mp5990.html
> +
> +properties:
> +  compatible:
> +    const: mps,mp5990
> +
> +  reg:
> +    maxItems: 1

This is missing some properties... or is a candidate for
trivial-devices.yaml.

I guess it is fine as initial submission:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

