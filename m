Return-Path: <linux-kernel+bounces-60787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAF085096E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 14:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA311F21CBE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256455B5B8;
	Sun, 11 Feb 2024 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vdIFcBMJ"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686795B5A6
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707658782; cv=none; b=B2rmjXLfYrp0A1VguKyU04p0rXmEwPK6DycsY1CiZSLM8zcoWcbJ87q69SBlEIJxcBU42SLMUAlzGeHbX6/cqNoo0l5Xc2sJO5RqU31Ikg6ajhh515WIu9+ahVc29zTWShkIKbrTYaQsVKmZyMchBpdVpXJ8M1YQSL9hKCViJ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707658782; c=relaxed/simple;
	bh=KFXA3+R8s3SRSrnMPGr4IKA8IpENg695bBUFqWDk888=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYJq7k51H26jmsnz24FDMrgOLIvj34VtwxKDwVmqgQlANC9IjUxL4aq3oyVqrgAkogcy0jTRN9JLPhRmcfhHpG4bhP/bklweDPU9iI9SKWzl8DwlJG7MfC88eG5UTVtAPjIUi+wBDWzEGAaJJaa3KXPnTkpN4xOqu4geIuqk+Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vdIFcBMJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-410c59a3e46so1740485e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 05:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707658778; x=1708263578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6G9u/3Fv5PjWFy9vLWBNpDOe87eSjSZPsXbRj18KFs8=;
        b=vdIFcBMJpTeIbykH9RIIj3s2tJfUwjLY+liZ0oO/FqCBxlwxfHEK4T68mptubBNF8I
         3RngXlsBr2WIEew9mZt67fAe9viA7/zrm65R73zPzQhi4YSbseaIQGXrsqbu1fRZj+EI
         K69F7T6HBQ4jI0BwtmgYeZDAKKVQ3Kkq7jfCBA1RAQeh/RgOaWnaFdhr2JbffYHf9OFd
         I8UvTO25m2JCrPHtpjroCCIYlv+Cgm4sN02858J7LQz7EqNpHeAcX/th86FykXqgTEBB
         +X/JwOYB2Fw38FhouvaQ+C1h+yTW8nviQTrFEo5sJqAwJki7ggEGVlwI4D27UcyINfEU
         SoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707658778; x=1708263578;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6G9u/3Fv5PjWFy9vLWBNpDOe87eSjSZPsXbRj18KFs8=;
        b=abWsTgMSBFUrQiaWxa/Gj4cxyKCPFdaB5oqinyZtOwUMaxCrfjmd2+tZzR9NIXaoEe
         /tbFI3q5XiwbEaaqT5skOk+bmQ9hcX3gMUfAmQuVafVatAoZB9aHMNwQ+OUhegR0DIgJ
         HIUBe3sLmhNIICFIHYYo/djfdBAvT1i1yX4/UKT+JWNrNDxCZ+OdD6Onk3NJWbKVFZl5
         N4soGHP60xnqCWCYKIyL3Z6kfwB/gm3zGSdxrginfSw736JJaU816khn9pt86cykuaxR
         2bmEtLh4PqU9VYxNCt3k6hjg9SzyNhj9EcfzxTWMyPbE9AvCT1g1ItX1gblPaiE7Ctu2
         ySnw==
X-Gm-Message-State: AOJu0YyVa8H+JudVT2QYd3jsku+Yz7gfybn/5Qi2XtYnpi4VL0HtFWhx
	q4mEaRLF9Sl2IDYZGvhFDdC/aNecQOynwhwSHSv9OWi0kda9ORWtXUNk+ncyiso=
X-Google-Smtp-Source: AGHT+IFhKe1Ykkm1DMRUxBcpjsBg4xpnvNk23OIVIgnQlMx0Ax0hAYhxRnQLZMqoPn7GtxgmI6HcaQ==
X-Received: by 2002:a05:600c:1548:b0:40f:d25c:41d0 with SMTP id f8-20020a05600c154800b0040fd25c41d0mr4205573wmg.29.1707658778513;
        Sun, 11 Feb 2024 05:39:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX4punkyvwAWYEniQVwYVWbB/v6b+g/PXt7uDYTIxJstOipFWEm7iWnAZn5ShkiRbYtOlTmEL2ePa1gLfuyYDYvfke0pN0THBEMVxJADXdih1B7pKpPQm8zpDd+auAvCvNZWuDiJece1udC1Im02ybYLzd8YocKCdHcauBXN2zQlMXshLWdB44QZ0h2fCk/il8Gj2c2bmyIc5lbqiZsP/C0q3Okwgxz2Iyuk4laObqp65Kc9XBSfMmwTxWJA0rClYWk7cyuBcp5rq9wD1RsO+XTkHOtqJXvhddwSjyLtgld+2HUJmESyyz/HVm0uFNmPAAG8IfkPd7yUX60NP9dj9LcGjzOLD55oTQ9XAQW2d0u85FG+cgVjmuvi8z2t7mmhxxVpE24l+zndY0Oeooilei3HSNJs9OeNrpBXiblLydzOC4HjwhMs36D3kH309Bh0C63IZudNC3h21Z4+uZzh1qDO2DodA6oBP4aZ7vTsuI=
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id v1-20020a05600c214100b00410395dc7d1sm5828918wml.7.2024.02.11.05.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 05:39:38 -0800 (PST)
Message-ID: <18ac05fb-a78d-4e95-a73d-461f509cdc5f@linaro.org>
Date: Sun, 11 Feb 2024 14:39:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/22] dt-bindings: chrome: Add binding for ChromeOS Pogo
 pin connector
Content-Language: en-US
To: Stephen Boyd <swboyd@chromium.org>, chrome-platform@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
 Pin-yen Lin <treapking@chromium.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>
References: <20240210070934.2549994-1-swboyd@chromium.org>
 <20240210070934.2549994-19-swboyd@chromium.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240210070934.2549994-19-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/02/2024 08:09, Stephen Boyd wrote:
> Describe the set of pins used to connect the detachable keyboard on
> detachable ChromeOS devices. The set of pins is called the "pogo pins".
> It's basically USB 2.0 with an extra pin for base detection. We expect
> to find a keyboard on the other side of this connector with a specific
> vid/pid, so describe that as a child device at the port of the usb
> device connected upstream.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: <chrome-platform@lists.linux.dev>
> Cc: Pin-yen Lin <treapking@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../chrome/google,pogo-pin-connector.yaml     | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/chrome/google,pogo-pin-connector.yaml
> 
> diff --git a/Documentation/devicetree/bindings/chrome/google,pogo-pin-connector.yaml b/Documentation/devicetree/bindings/chrome/google,pogo-pin-connector.yaml
> new file mode 100644
> index 000000000000..5ba68fd95fcd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/chrome/google,pogo-pin-connector.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/chrome/google,pogo-pin-connector.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Google Pogo Pin Connector
> +
> +maintainers:
> +  - Stephen Boyd <swboyd@chromium.org>
> +

Missing description describing the hardware.

> +properties:
> +  compatible:
> +    const: google,pogo-pin-connector
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description: Connection to USB2 port providing USB signals
> +    required:
> +      - endpoint

Drop required.


> +
> +patternProperties:
> +  "^keyboard@[0-9a-f]{1,2}$":
> +    description: The detachable keyboard

If this is detachable why do you define it in DT? Only hard-wired USB
devices, which need some sort of special handling. are described in DT.

> +    type: object
> +    $ref: /schemas/usb/usb-device.yaml

On this level:
unevaluatedProperties: false

> +
> +required:
> +  - compatible
> +  - '#address-cells'
> +  - '#size-cells'

Use one type of quotes, either ' or ".

> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    connector {
> +        compatible = "google,pogo-pin-connector";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        keyboard@2 {
> +          compatible = "usb18d1,504c";

Messed indentation.

> +          reg = <2>;
> +        };
> +
Best regards,
Krzysztof


