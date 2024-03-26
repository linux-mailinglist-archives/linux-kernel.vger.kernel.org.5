Return-Path: <linux-kernel+bounces-118456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD8888BB2F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76A1FB22AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CF7130ACD;
	Tue, 26 Mar 2024 07:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ffUg/+24"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25505130A65
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 07:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711438019; cv=none; b=Y+UKwMa2bYhBJL2vTSJim9K0q6TU+7/vMzRGkIhnQIdUFdQkqSt9r6aWeuq65VFbAABvQS8wNseC2WNqV2+hiqYg5l9jhGko5q6KI48mJj/vteywTYM2w5VKKaZbAKSuHhuXNxpkGItcbT1nC6aNpl+KFXgx7OTrCRS/nk+uqCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711438019; c=relaxed/simple;
	bh=fqZqBjupNkcz7ksn1wgwWbB5zT1rnnmFiojaxsMKakI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EV8SBvsqD4fGGowmB2WY0Pmu3Ehm3RM+TTMYUx2JftU32BGwBP4hzMtaMj79nm170FXjOVSestbbkUi3dg0nO2BFNUCQQL3OkSOWZt1HfIS2vvnrdIsAcVv4Nn3RrXFzyBHSH15CvdB/SaK5EonQeBYjhw3I7xDrUiKJYfwR0hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ffUg/+24; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a450bedffdfso593315266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 00:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711438016; x=1712042816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l8X0sS0ioRZhZHSyCp+sZdAvsMYJwJjOGU3wxVcqyyg=;
        b=ffUg/+24fnm53ckJ9Tr8DUwxtl6Xzhjo8iez1h3hLJa5PzQUOICxpJgl2x27uMitIt
         magiCWiDzJjppTycOR+pDMI2Xf8lgXWBEyrRree3b+xl9QDwEDavO4fmeogg33MmOVs/
         PkJ6K8225OU73+tqygbP9BzDIV/PzwhlVqMmNVfWhNLaDbHUfjk4Z/rbnslquIuTc8QH
         LMSvkHQvZlnmhP55XzAAXhuo1FDxXYJDnWiHLhO9bNyjTiOfh9NKYDXNiOvIpAsCf56a
         +F8+oQmZ2SH8OyI9hbmRjSLWsceYY7mR/fPon/m3dWI38T6kpJi7svOiItV6kB32D3N9
         ezVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711438016; x=1712042816;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8X0sS0ioRZhZHSyCp+sZdAvsMYJwJjOGU3wxVcqyyg=;
        b=mxVZrVZpHP27aNqv5+Le34AquhxHm7jB1mtBR/VkKNujTIdCxFyE0mAa5BAxryvy/A
         LNL47ADRw2WnXjd8uBaIK8YWkKCJG6TBxh9d0jWBTn7XQLSj6yyCXpAZB9d9/gjJ+623
         UXcE1IdwfIhnkZschL+FUFiOWZNLtW2ABAOwsmOEYHzXEGAowj5BXN+OHhKDR1e2n6nm
         N2PCp0tNAY3hGfySTQB6kgbidc6To32iBeneEg1Ajl3qktF9moqVobWLCCj6C8a8xLDT
         UiltdeuuDClFEzAAdCYVQ423P/keVpsqPUDraOYe6bwshuyEamJmRyQmnx+4zmD+V9vl
         lS7g==
X-Forwarded-Encrypted: i=1; AJvYcCX+3Ah37rpzVXGV318hOwU6iJZa/zeE8mnbETJOHg6bOKUZpRQBCUr0vCvQlWdIMBRu7TFic6DcPim1k42kixAvZ5lgpoGn2PhsSMho
X-Gm-Message-State: AOJu0Yyia2UKaEy7Xk6waFZbUS7J+TjMIhTemdqThfd8vZWdfa9Ec+bA
	M7KH4ttTVbuBe7WlkzYnKqEpV/Er3CPKvfbCwCblx9L/YefnjfVxYxQppPVbZs8=
X-Google-Smtp-Source: AGHT+IFJA1GydDkGZE8FU8PnHdXbkqJxy0HtKbTrJpe9g/gXDmcqulXKFzm72AHidqlt3XfGy2GOVg==
X-Received: by 2002:a17:906:40c9:b0:a4d:f27c:bc3 with SMTP id a9-20020a17090640c900b00a4df27c0bc3mr267095ejk.8.1711438016411;
        Tue, 26 Mar 2024 00:26:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id hg1-20020a1709072cc100b00a46caa13e63sm3888459ejc.199.2024.03.26.00.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 00:26:55 -0700 (PDT)
Message-ID: <8cd3158b-ed51-4a1f-a626-fa58c85d4aeb@linaro.org>
Date: Tue, 26 Mar 2024 08:26:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dt-bindings: hsi: omap-ssi: convert to YAML
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240325-hsi-dt-binding-v1-0-88e8e97c3aae@collabora.com>
 <20240325-hsi-dt-binding-v1-3-88e8e97c3aae@collabora.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240325-hsi-dt-binding-v1-3-88e8e97c3aae@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/03/2024 22:45, Sebastian Reichel wrote:
> Convert the legacy txt binding to modern YAML.
> No semantic change.

You deprecated a property: ti,hwmods. Also will be one more change:
ti,ssi-cawake-gpio->gpios

> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  Documentation/devicetree/bindings/hsi/omap-ssi.txt | 102 -----------
>  .../devicetree/bindings/hsi/ti,omap-ssi.yaml       | 196 +++++++++++++++++++++
>  2 files changed, 196 insertions(+), 102 deletions(-)
> 

..

> diff --git a/Documentation/devicetree/bindings/hsi/ti,omap-ssi.yaml b/Documentation/devicetree/bindings/hsi/ti,omap-ssi.yaml
> new file mode 100644
> index 000000000000..eb82f85c25b6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hsi/ti,omap-ssi.yaml
> @@ -0,0 +1,196 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hsi/ti,omap-ssi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SSI Controller on OMAP SoCs
> +
> +description:
> +  OMAP3's Synchronous Serial Interface (SSI) controller implements a
> +  legacy variant of MIPI's High Speed Synchronous Serial Interface (HSI),
> +  while the controller found inside OMAP4 is supposed to be fully compliant
> +  with the HSI standard.
> +
> +maintainers:
> +  - Sebastian Reichel <sre@kernel.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,omap3-ssi
> +      - ti,omap4-hsi
> +
> +  reg:
> +    items:
> +      - description: registers for sys
> +      - description: registers for gdd
> +
> +  reg-names:
> +    items:
> +      - const: sys
> +      - const: gdd
> +
> +  ranges: true
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 3
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 3
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    const: gdd_mpu
> +
> +  ti,hwmods:
> +    const: ssi
> +    deprecated: true
> +
> +patternProperties:
> +  "[hs]si-port@[0-9a-f]+":

Does anything actually depends on the name? Can these be "port@[0-9a-f]+"?

> +    type: object
> +

Drop blank line.

> +    additionalProperties: false
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - ti,omap3-ssi-port
> +          - ti,omap4-hsi-port
> +
> +      reg:
> +        items:
> +          - description: TX registers
> +          - description: RX registers
> +
> +      reg-names:
> +        items:
> +          - const: tx
> +          - const: rx
> +
> +      interrupts:
> +        items:
> +          - description: MPU interrupt 0
> +          - description: MPU interrupt 1
> +        minItems: 1
> +
> +      ti,ssi-cawake-gpio:

ti,ssi-cawake-gpios

> +        description: GPIO signifying CAWAKE events
> +        maxItems: 1
> +
> +      hsi-client:
> +        type: object

On this level, should be explicit: additionalProperties: true

> +        $ref: /schemas/hsi/hsi-client.yaml#
> +
> +    required:
> +      - compatible
> +      - reg
> +      - reg-names
> +      - interrupts
> +
> +    allOf:
> +      - if:
> +          properties:
> +            compatible:
> +              contains:
> +                const: ti,omap3-ssi-port
> +        then:
> +          properties:
> +            $nodename:
> +              pattern: "^ssi-port@(.*)?$"
> +            interrupts:
> +              minItems: 2
> +        else:
> +          properties:
> +            $nodename:
> +              pattern: "^hsi-port@(.*)?$"
> +            interrupts:
> +              maxItems: 1
> +
> +additionalProperties: false

This goes after allOf: block

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - ranges
> +  - "#address-cells"
> +  - "#size-cells"
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - interrupt-names
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,omap3-ssi
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 3
> +        clock-names:
> +          items:
> +            - const: ssi_ssr_fck
> +            - const: ssi_sst_fck
> +            - const: ssi_ick
> +    else:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +        clock-names:
> +          items:
> +            - const: hsi_fck
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    ssi-controller@48058000 {
> +        compatible = "ti,omap3-ssi";
> +        reg = <0x48058000 0x1000>,
> +              <0x48059000 0x1000>;
> +        reg-names = "sys", "gdd";
> +        ranges;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        clocks = <&ssi_ssr_fck>,
> +                 <&ssi_sst_fck>,
> +                 <&ssi_ick>;
> +        clock-names = "ssi_ssr_fck",
> +                      "ssi_sst_fck",
> +                      "ssi_ick";
> +        interrupts = <55>;
> +        interrupt-names = "gdd_mpu";
> +
> +        ssi-port@4805a000 {
> +                compatible = "ti,omap3-ssi-port";

Use 4 spaces for example indentation.

> +                reg = <0x4805a000 0x800>,


Best regards,
Krzysztof


