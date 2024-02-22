Return-Path: <linux-kernel+bounces-76489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 585BA85F7D1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A381F22C3C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B381B58ACA;
	Thu, 22 Feb 2024 12:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VVTM6Ny8"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41C65FB81
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604082; cv=none; b=sOV7Eiiq5Rg6orZRrYGvWE49wMKBJqc40wyeXJNWIVCyfd0INQLFOdcZgFhalbF2WhgJl0z6DjSeyIS3qwQGQjLJ5bMUp2o+AqqY0QXrXq0xTbFU1RN6eDAVKrtZ1f0A4Yeldnq7TH1QIh633jTnRN+r1u0rmqZJm8WuzTHOKF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604082; c=relaxed/simple;
	bh=qcWhRY2jqc3ScFYIy46AU8daKPAfkDKvpaY+82HuTCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXAxBFXXQjby9gRzEb7/niYpBJcBamZRvlwJ2LEaJ1QSyn5Zc+5ZlTVfdCgtllIRVuYyZ4pM8LojI4cp8Xwq5dtOofk+ZMxfLxcFHEUQOQ3doTKt1OI/K6Jtv73k98ofIm4eMFF8MiyeBCYhQP4/rw0SFu67w2z3FKgEtwsqHJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VVTM6Ny8; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a26fa294e56so1217149166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 04:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708604079; x=1709208879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g/a/vUM1QhENP6XaQmwPVukskdx7fAmDV+ZfrBwwWRU=;
        b=VVTM6Ny8/9rqUBSZSHIrOgF87vJpXwJYwlzr7+Ij5eVJHvmgTjZFArdi6U0nBZhEns
         a8vdlsEt81kAVLIiiROtAimclAcAHBg1CO0Sota4GTRu6r9FWEZgyP4vGumwpkUXiGrm
         +/HgZl2GR3RSsgc9/voBpuFudjO7gYS4pJUZGq2eDLQkInppXaI1E5k5a6ZLE6pQ8HQX
         El+kDmNQQ7H+d5z5rN3IWzzDsAbbWFlDM0I+CsLY8LSVnikNoio7JzqZCIxwVbOsjBxV
         73KmnMRRNrl1jlsSaKNgTqJen7941GEK7mgjEK+WSpONHuzPizmXU4XnGpjxiSDvuUwM
         KVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708604079; x=1709208879;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/a/vUM1QhENP6XaQmwPVukskdx7fAmDV+ZfrBwwWRU=;
        b=DXojwQ26MZAAA8EPn00KPefTwR+wRHFAWIeybJmAOxpCupEj2X8O+NHTodTZ+RaC8i
         yQzLuyRS8ab3KyCNf1D/Tf/XMtwrUHjUPiju0sgKGqEVi2abEx4JBQvDLuBHNPbNghxm
         UhrdeT8/f9PROMXvyi+CycefEBr/AwG77q/omSz1bXCMXmPUV6RO+3xZZJnPFsrDfNlQ
         8n3svltbRdzYmcDATO9poCukZZXcfTi8TjjmbPXmCVIn5tdk/UfPPK+syreEJw9kVPjc
         gJrDWUM5hVgyCfccUgz5moakBOLr7boTI2ggueKP09MGsb+YvK5xopFosbnpkxuqQOlm
         beJg==
X-Forwarded-Encrypted: i=1; AJvYcCVaS9oAmH/Sxd1YwWSaiCL8927ZyBBba7+c/7/ldrTru/XIrjVM5aXUtnQLSxxioi8fhR197fsROmOszNBw0YSPZYj0C6592g/2A0vy
X-Gm-Message-State: AOJu0YwWz19Lni6f9wIa5FYNoeWfE3pZ9G0ksSBVf4okAb8aDQf3Cany
	aDa9HC0C9D35pEXPG5kQAYszWADaw4jYgbq8YsXC0ZOt4szwhgdMzhnWWmnKpKRa4rBiBpbPb/M
	tJ7s=
X-Google-Smtp-Source: AGHT+IFz5hp718KO//sscTaT0CkB9Wh1dc24BQnguVgphzjyWtX6SAJ6avMsfLt5wkRJe4v4ovv74g==
X-Received: by 2002:a17:906:4688:b0:a3f:a340:a8ba with SMTP id a8-20020a170906468800b00a3fa340a8bamr278549ejr.26.1708604079322;
        Thu, 22 Feb 2024 04:14:39 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id tb21-20020a1709078b9500b00a3e51df2280sm4938415ejc.223.2024.02.22.04.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 04:14:38 -0800 (PST)
Message-ID: <dd86117e-0196-499b-b8b3-efe4013cbc07@linaro.org>
Date: Thu, 22 Feb 2024 13:14:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] dt-bindings: spmi: Add PMIC ARB v7 schema
Content-Language: en-US
To: Abel Vesa <abel.vesa@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
References: <20240221-spmi-multi-master-support-v5-0-3255ca413a0b@linaro.org>
 <20240221-spmi-multi-master-support-v5-1-3255ca413a0b@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240221-spmi-multi-master-support-v5-1-3255ca413a0b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2024 13:52, Abel Vesa wrote:
> Add dedicated schema for PMIC ARB v7 as it allows multiple
> buses by declaring them as child nodes. These child nodes
> will follow the generic spmi bus bindings.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---


> +
> +description: |
> +  The SPMI PMIC Arbiter v7 is found on Snapdragon chipsets. It is an SPMI
> +  controller with wrapping arbitration logic to allow for multiple on-chip
> +  devices to control up to 2 SPMI separate buses.
> +
> +  The PMIC Arbiter can also act as an interrupt controller, providing interrupts
> +  to slave devices.
> +
> +properties:
> +  compatible:
> +    const: qcom,spmi-pmic-arb-v7

I dislike the versioning. Previous PMIC ARB binding said "it will cover
everything" and now it turns out that everything is not everything. I
would suggest SoC specific compatibles.

> +
> +  reg:
> +    items:
> +      - description: core registers
> +      - description: tx-channel per virtual slave regosters
> +      - description: rx-channel (called observer) per virtual slave registers
> +
> +  reg-names:
> +    items:
> +      - const: core
> +      - const: chnls
> +      - const: obsrvr
> +
> +  ranges: true
> +
> +  '#address-cells':
> +    const: 2
> +
> +  '#size-cells':
> +    const: 2
> +
> +  qcom,ee:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 5
> +    description: >
> +      indicates the active Execution Environment identifier
> +
> +  qcom,channel:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 5
> +    description: >
> +      which of the PMIC Arb provided channels to use for accesses

We should probably deprecate qcom,bus-id in qcom,spmi-pmic-arb.yaml.

> +
> +patternProperties:
> +  "spmi@[0-1]$":
> +    type: object
> +    $ref: /schemas/spmi/spmi.yaml

On this level:
unevaluatedProperties: false

> +
> +required:
> +  - compatible
> +  - reg-names
> +  - qcom,ee
> +  - qcom,channel
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    spmi: arbiter@c400000 {
> +      compatible = "qcom,spmi-pmic-arb-v7";
> +      reg = <0x0c400000 0x3000>,
> +            <0x0c500000 0x4000000>,
> +            <0x0c440000 0x80000>;
> +      reg-names = "core", "chnls", "obsrvr";
> +
> +      qcom,ee = <0>;
> +      qcom,channel = <0>;
> +
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      spmi_bus0: spmi@0 {
> +        reg = <0 0x0c42d000 0 0x4000>,
> +              <0 0x0c4c0000 0 0x10000>;
> +        reg-names = "cnfg", "intr";
> +
> +        interrupt-names = "periph_irq";
> +        interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-controller;
> +        #interrupt-cells = <4>;
> +
> +        qcom,bus-id = <0>;

Please drop. Same in second instance.


Best regards,
Krzysztof


