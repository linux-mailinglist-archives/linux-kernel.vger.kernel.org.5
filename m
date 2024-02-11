Return-Path: <linux-kernel+bounces-60784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E38850966
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 14:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 447DC1C21501
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135735B5AE;
	Sun, 11 Feb 2024 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vqfrK1cl"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2E45A4ED
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707658472; cv=none; b=H/VjuMc7G5FXQSIYz1ihoTvmHdrov1KDpu8BqqpoSHwDW4PZ1T/HtEa5+VfIya6tkt0Yv9FAyv0SEFihV0wzPPWH5y3G/ku8jWAw8Zyuo/wQ4Kw8Ov5Xx+/1Wpcx31LaWe/LdEMI2x0m7RVh6ykSw3GEHTbFn0Hdvk2IQbjfoLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707658472; c=relaxed/simple;
	bh=xvNiWukWCe+C/SyP1ywkdWgpW5FFMbX/gws1Qcs0Ftc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QPbXFcIpk+ODLbDyveJ1lQm8ZeJ4JblpiSekPcoqxwrUnuZD/TMlGOMXNc6Ie9U03ElOkT8h5kFB6UmKYE1LqhhvWWngzKsgiImzi6BWP/Q+UP1UiW9zztIcGZbpP8LfJvzGkr8Kwkd84CtD2WrmetdBvy1HJ+BPXoXwJ68l60c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vqfrK1cl; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-410a12519bcso8037275e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 05:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707658468; x=1708263268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eocj8gtmTR/cV4HIoTvUSwCUKD7UJ8ziNY39AisweBQ=;
        b=vqfrK1cl8YFhsohHrGX0OSBhgDOiJeF9RgaegALYchkEvtZ1v4EwG38kQZLSh2npDP
         d/LqzjvhRgj9en01+2mi2qrcG/c5fsm0BnpVDHl2dLt2JU5tcv4AbwZJHX3SmJK1B3Qu
         qkVHWcRo/eqkzZS7AtIGeqRc61ZKO/1jpHZMMdaQqbmiGe1ubgbGom/TciNuQJdCkdY8
         FupNTVnOmSV4ukTm+0G9HCoDL8dgbzfl9SCTPVHXISSWRpXHIw8ZV8NkIttf44EYXTAp
         VukdLxPryDc7HRfIIsKDgktXNOjUn5HlTfYuUaJOrUVg2O4VF5L2uu4gDwAs1Qnp5yyg
         2dBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707658468; x=1708263268;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eocj8gtmTR/cV4HIoTvUSwCUKD7UJ8ziNY39AisweBQ=;
        b=HVtoBBI7y3WudEzJ/Ddtt47+xmM5Lu9msJ+CGCcbznJahW17JOK3x4PXdjymkWK7Pe
         J+a8H4cuQYSnDgx1mjJjfnkK+r+BjSVMiEyD5zc23gDHVO8lvRqYHu+9Q0Tkiatd7iG8
         YZvjVFEF527ciBsN+2Qj+JuTmcAQkpFv5FrMzNR/vQUlCbeiiENhZb0RJMAcLV/nG/BZ
         5I63xkqIT/Un3mnsHIx9SQJlU5nfr511ApmqJDU2CdvhePF/0UazyYyiQNna/UnAxvsy
         kXf8jRUrkE/1IHwebVXgyVSbW2IWVu5zmF+eS08hy8oSDD3lEtDYKB0bpHYUw9RPvxyj
         SgNw==
X-Gm-Message-State: AOJu0YxpDstF0eBzyMn/x9kiUFikK8jUVP+wJMeLRdqhtTzSTl4WB/Ki
	jAexe1pQVINLBqUSu7Zr3DIrME+kguKOcDJUwdZPlzoK2fNeyz0M6YSfVKjE9z8=
X-Google-Smtp-Source: AGHT+IGZuQ9JzcvtX4xhAH3cy1BjiccK9fkywtjsXoTTzSlVq6CaDAKUVTHZM1Qcy8tT7r4p0CocsQ==
X-Received: by 2002:a05:600c:1382:b0:410:4032:725b with SMTP id u2-20020a05600c138200b004104032725bmr3751129wmf.22.1707658468080;
        Sun, 11 Feb 2024 05:34:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXg/jahrIkV8EPzEnTgRIb7cvYOitfsH2MGVHGQbzFsA/7nd6vWww+1F08Mr3fuuNlmeLIxLBPR3aSMtrWPdb5SWVrz3AEtPA7T6UYWndwylc24vbhGI7sasuS1cgpVzFghslV/yq7CkaH78ABEfv1QX09IVf6BUH48K9RUlVlfoQdiVJEGpTABesJdVXzyuUNftrSRpYNiCMS8sU4oIhaBZP7H8L37dUOzBd4jOMIbeg5HwLs9VEHWvlP7ZCX5LmyOZFbHfAF+xDOVb/ty0WvNo9qR8Xu4mjXZY3obEpkyT4FjjAZXzJ/tEJrlLyxKRYfFHRC7qxexB6aTT56+n7cV/Fv0a7wtjYQWXoZXIlBu5mZoMxp79YCJ0YqEibG+ktYu4HKq/KiIKcmlsPQVAZkCI1CDgXeQ1VafKAtTz0xDwPSchAZ1QY3BxT2SibOsBon4ziYDmrKbQwEQSOjapR01PMopKcxuZ/+rYRIpGZgOTbAK9InUUE26r2EcyD02ITPx7IO9dT1mh9PiVGJvLLQ0fRFwCzFdJYln8xa1k9tK12PDfoJ3SmEt
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c298400b0040fdc7f4fcdsm5876671wmd.4.2024.02.11.05.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 05:34:27 -0800 (PST)
Message-ID: <46ac6ab8-b0a5-497d-91b6-1d2ced33184b@linaro.org>
Date: Sun, 11 Feb 2024 14:34:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/22] dt-bindings: chrome: Add
 google,cros-ec-typec-switch binding
Content-Language: en-US
To: Stephen Boyd <swboyd@chromium.org>, chrome-platform@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
 Pin-yen Lin <treapking@chromium.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 Prashant Malani <pmalani@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>
References: <20240210070934.2549994-1-swboyd@chromium.org>
 <20240210070934.2549994-14-swboyd@chromium.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240210070934.2549994-14-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/02/2024 08:09, Stephen Boyd wrote:
> Add a binding for the USB type-c switch controls found on some ChromeOS
> Embedded Controllers (ECs). When this device is a mode switch, it takes
> one DisplayPort (DP) port as input and some number (possibly zero) of
> USB SuperSpeed ports (bundles of USB SS lanes) as input, and muxes those
> lanes into USB type-c SuperSpeed lanes suitable for the SSTRX1/2 pins on
> a usb-c-connector. When this device is an orientation switch, it
> redirects the DP lanes to the proper USB type-c SSTRX lanes.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Prashant Malani <pmalani@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: <chrome-platform@lists.linux.dev>
> Cc: Pin-yen Lin <treapking@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../chrome/google,cros-ec-typec-switch.yaml   | 365 ++++++++++++++++++
>  .../bindings/mfd/google,cros-ec.yaml          |   5 +
>  2 files changed, 370 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-ec-typec-switch.yaml
> 
> diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec-switch.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec-switch.yaml
> new file mode 100644
> index 000000000000..17a0ba928f5d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec-switch.yaml
> @@ -0,0 +1,365 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/chrome/google,cros-ec-typec-switch.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Google Chrome OS EC(Embedded Controller) USB Type C Switch
> +
> +maintainers:
> +  - Benson Leung <bleung@chromium.org>
> +  - Prashant Malani <pmalani@chromium.org>
> +  - Stephen Boyd <swboyd@chromium.org>
> +
> +description:
> +  Chrome OS devices have an Embedded Controller(EC) which has access to USB
> +  Type C switching. This node is intended to allow the OS to control Type C
> +  signal muxing for USB-C orientation and alternate modes. The node for this
> +  device should be under a cros-ec node like google,cros-ec-spi.
> +

If this is USB Type C switch, then you miss reference to
usb-switch.yaml, but then ports look a bit different.

> +properties:
> +  compatible:
> +    const: google,cros-ec-typec-switch
> +
> +  mode-switch:
> +    description: Indicates this device controls altmode switching
> +    type: boolean
> +
> +  orientation-switch:
> +    description: Indicates this device controls orientation switching
> +    type: boolean
> +
> +  mux-gpios:
> +    description: GPIOs indicating which way the DP mux is steered

missing maxItems

> +
> +  no-hpd:
> +    description: Indicates this device doesn't signal HPD for DisplayPort
> +    type: boolean
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        description: Input port to receive DisplayPort (DP) data
> +        unevaluatedProperties: false
> +
> +        properties:
> +          endpoint@0:
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +            description: DisplayPort data
> +            unevaluatedProperties: false
> +            properties:
> +              data-lanes:
> +                $ref: /schemas/types.yaml#/definitions/uint32-array
> +                description: |
> +                  An array of physical DP data lane indexes
> +                  - 0 is DP ML0 lane
> +                  - 1 is DP ML1 lane
> +                  - 2 is DP ML2 lane
> +                  - 3 is DP ML3 lane
> +                oneOf:
> +                  - items:
> +                      - const: 0
> +                      - const: 1
> +                  - items:
> +                      - const: 0
> +                      - const: 1
> +                      - const: 2
> +                      - const: 3
> +
> +        required:
> +          - endpoint@0
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Input port to receive USB SuperSpeed (SS) data
> +        properties:
> +          endpoint@0:
> +            $ref: /schemas/graph.yaml#/properties/endpoint
> +            description: USB SS data
> +
> +          endpoint@1:
> +            $ref: /schemas/graph.yaml#/properties/endpoint
> +            description: USB SS data
> +
> +        anyOf:
> +          - required:
> +              - endpoint@0
> +          - required:
> +              - endpoint@1
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Output port for USB-C data
> +        properties:
> +          endpoint@0:
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +            description: USB-C data
> +            unevaluatedProperties: false
> +            properties:
> +              data-lanes:
> +                $ref: /schemas/types.yaml#/definitions/uint32-array
> +                description: |
> +                  An array of physical USB-C data lane indexes.
> +                  - 0 is SSRX1 lane
> +                  - 1 is SSTX1 lane
> +                  - 2 is SSTX2 lane
> +                  - 3 is SSRX2 lane
> +                minItems: 4
> +                maxItems: 4
> +                items:
> +                  maximum: 3
> +
> +          endpoint@1:
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +            description: USB-C data for EC's 1st type-c port
> +            unevaluatedProperties: false
> +            properties:
> +              data-lanes:
> +                $ref: /schemas/types.yaml#/definitions/uint32-array
> +                description: |
> +                  An array of physical USB-C data lane indexes.
> +                  - 0 is SSRX1 lane
> +                  - 1 is SSTX1 lane
> +                  - 2 is SSTX2 lane
> +                  - 3 is SSRX2 lane
> +                minItems: 4
> +                maxItems: 4
> +                items:
> +                  maximum: 3
> +
> +          endpoint@2:
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +            description: USB-C data for EC's 2nd type-c port
> +            unevaluatedProperties: false
> +            properties:
> +              data-lanes:
> +                $ref: /schemas/types.yaml#/definitions/uint32-array
> +                description: |
> +                  An array of physical USB-C data lane indexes.
> +                  - 0 is SSRX1 lane
> +                  - 1 is SSTX1 lane
> +                  - 2 is SSTX2 lane
> +                  - 3 is SSRX2 lane
> +                minItems: 4
> +                maxItems: 4
> +                items:
> +                  maximum: 3
> +
> +          endpoint@3:
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +            description: USB-C data for EC's 3rd type-c port
> +            unevaluatedProperties: false
> +            properties:
> +              data-lanes:
> +                $ref: /schemas/types.yaml#/definitions/uint32-array
> +                description: |
> +                  An array of physical USB-C data lane indexes.
> +                  - 0 is SSRX1 lane
> +                  - 1 is SSTX1 lane
> +                  - 2 is SSTX2 lane
> +                  - 3 is SSRX2 lane
> +                minItems: 4
> +                maxItems: 4
> +                items:
> +                  maximum: 3
> +
> +          endpoint@4:
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +            description: USB-C data for EC's 4th type-c port
> +            unevaluatedProperties: false
> +            properties:
> +              data-lanes:
> +                $ref: /schemas/types.yaml#/definitions/uint32-array
> +                description: |
> +                  An array of physical USB-C data lane indexes.
> +                  - 0 is SSRX1 lane
> +                  - 1 is SSTX1 lane
> +                  - 2 is SSTX2 lane
> +                  - 3 is SSRX2 lane
> +                minItems: 4
> +                maxItems: 4
> +                items:
> +                  maximum: 3
> +
> +          endpoint@5:
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +            description: USB-C data for EC's 5th type-c port
> +            unevaluatedProperties: false
> +            properties:
> +              data-lanes:
> +                $ref: /schemas/types.yaml#/definitions/uint32-array
> +                description: |
> +                  An array of physical USB-C data lane indexes.
> +                  - 0 is SSRX1 lane
> +                  - 1 is SSTX1 lane
> +                  - 2 is SSTX2 lane
> +                  - 3 is SSRX2 lane
> +                minItems: 4
> +                maxItems: 4
> +                items:
> +                  maximum: 3
> +
> +          endpoint@6:
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +            description: USB-C data for EC's 6th type-c port
> +            unevaluatedProperties: false
> +            properties:
> +              data-lanes:
> +                $ref: /schemas/types.yaml#/definitions/uint32-array
> +                description: |
> +                  An array of physical USB-C data lane indexes.
> +                  - 0 is SSRX1 lane
> +                  - 1 is SSTX1 lane
> +                  - 2 is SSTX2 lane
> +                  - 3 is SSRX2 lane
> +                minItems: 4
> +                maxItems: 4
> +                items:
> +                  maximum: 3
> +
> +          endpoint@7:
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +            description: USB-C data for EC's 7th type-c port
> +            unevaluatedProperties: false
> +            properties:
> +              data-lanes:
> +                $ref: /schemas/types.yaml#/definitions/uint32-array
> +                description: |
> +                  An array of physical USB-C data lane indexes.
> +                  - 0 is SSRX1 lane
> +                  - 1 is SSTX1 lane
> +                  - 2 is SSTX2 lane
> +                  - 3 is SSRX2 lane
> +                minItems: 4
> +                maxItems: 4
> +                items:
> +                  maximum: 3
> +
> +        anyOf:
> +          - required:
> +              - endpoint@0

I don't get what you want to say here. This anyOf should have no effect.

> +          - required:
> +              - endpoint@1
> +          - required:
> +              - endpoint@2
> +          - required:
> +              - endpoint@3
> +          - required:
> +              - endpoint@4
> +          - required:
> +              - endpoint@5
> +          - required:
> +              - endpoint@6
> +          - required:
> +              - endpoint@7
> +
> +    required:
> +      - port@2
> +    anyOf:
> +      - required:
> +          - port@0
> +      - required:
> +          - port@1

Same problem here

> +
> +required:
> +  - compatible
> +  - ports
> +
> +allOf:
> +  - if:
> +      properties:
> +        no-hpd: true

I don't understand this either. What is it for? Where did you see such
syntax?


> +      required:
> +        - no-hpd> +    then:
> +      properties:
> +        ports:
> +          required:
> +            - port@0
> +  - if:
> +      properties:
> +        mode-switch: true
> +      required:
> +        - mode-switch
> +    then:
> +      properties:
> +        ports:
> +          required:
> +            - port@0
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      cros_ec: ec@0 {
> +        compatible = "google,cros-ec-spi";
> +        reg = <0>;
> +        interrupts = <35 0>;

Same concerns about interrupts.

> +
> +        typec-switch {
> +          compatible = "google,cros-ec-typec-switch";
> +          mode-switch;
> +          orientation-switch;
> +
> +          ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +              reg = <0>;
> +              #address-cells = <1>;
> +              #size-cells = <0>;
> +              dp_in: endpoint@0 {
> +                reg = <0>;
> +                remote-endpoint = <&dp_phy>;
> +                data-lanes = <0 1>;
> +              };
> +            };
> +
> +            port@1 {
> +              reg = <1>;
> +              #address-cells = <1>;
> +              #size-cells = <0>;
> +
> +              usb_in_0: endpoint@0 {
> +                reg = <0>;
> +                remote-endpoint = <&usb_ss_0_out>;
> +              };
> +
> +              usb_in_1: endpoint@1 {
> +                reg = <1>;
> +                remote-endpoint = <&usb_ss_1_out>;
> +              };
> +            };
> +
> +            port@2 {
> +              reg = <2>;
> +              #address-cells = <1>;
> +              #size-cells = <0>;
> +
> +              cros_typec_c0_ss: endpoint@0 {
> +                reg = <0>;
> +                remote-endpoint = <&usb_c0_ss>;
> +              };
> +
> +              cros_typec_c1_ss: endpoint@1 {
> +                reg = <1>;
> +                remote-endpoint = <&usb_c1_ss>;
> +              };
> +            };
> +          };
> +        };
> +      };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> index ded396b28fba..563c51a4a39c 100644
> --- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> @@ -164,6 +164,10 @@ patternProperties:
>      type: object
>      $ref: /schemas/extcon/extcon-usbc-cros-ec.yaml#
>  
> +  "^typec-switch[0-9]*$":

Missing - after typec-switch (e.g. typec-switch-1)

> +    type: object
> +    $ref: /schemas/chrome/google,cros-ec-typec-switch.yaml#


Best regards,
Krzysztof


