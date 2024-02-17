Return-Path: <linux-kernel+bounces-69791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0932D858E9E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BFF31F22242
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D50D1D53C;
	Sat, 17 Feb 2024 10:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LYVDpNsA"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD491DDDB
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708164881; cv=none; b=AzYEhMhqMEynEHbHqlqZPA/OEeLeX2aM8LRHztl1O9jPzwS8nsEJ+sFugs5ACGbTrd/n/l3kKl+HIbNGHEOAWGRWl48a4Pcl7dxBoAR5wJ9iu+LWAmJLzwk8me48EoF6zNCBm6BwZtvtBBwIjzOVhI7QJhVg9RcsXh1MnhmvKr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708164881; c=relaxed/simple;
	bh=mGSOKd55U2HlX3t5UxUA1g68CZ8NU61xKE0MghXJTV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UscCoQq/BCg4Di7lrn9cmW0CAYFssMOZf92m30uJ7xlTj0KvGBz99UnPZ57cRoIClrZ1VctKr4V4P2NNWQeUchDF6/CmmIkv7LYR6iA470agl6pp2R0fl4zV9KFKRWOFHZSRZ1mPXxIjIrDjk4ilzg2qq+unu+zUbb0jLDFxky4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LYVDpNsA; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so4198213a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 02:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708164877; x=1708769677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TmX3c956Tt9oKUJJoVHfcBlcjeQLXpG1CQfmSUgQxYI=;
        b=LYVDpNsAhJNFE468RxO17B91QM0v6KXL6FXSIhduH9kxDCqIpA69Oxbqy+MblHX3gV
         91vWahwlvuh8WLYl0pfKcW9Z56y/hbd/nOxWBpOKB/cAvZgYKR5CNHGtPYDphQ0LPjFK
         4pG6txSG0TTDB9TeGxS8xPsXpa+o/VO3SwGD7PTdn5M1YRuMwpKJGzLcdebZBT3Qszxg
         pqy33iDpXPX5xjecGMNbMVIdYjlUV9Hs8zJ86kvTN/WRbOpaSaHtduK1C7leFieSyh3D
         R5LrMoKhlyqGVQVuLkg91ru8iAJ9sSIM6pE2p78NDUdtzFXoMrC9S8XF7a5PblP/rFVm
         WoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708164877; x=1708769677;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TmX3c956Tt9oKUJJoVHfcBlcjeQLXpG1CQfmSUgQxYI=;
        b=RP+PdcIcM5iHP8BurXiFdHMFcp8+M8B+x2WJptvy1N1cztmMQMyyjVGeHWEh21sua7
         nIPs2evYsFdBmKUpqE4mL/C4quFqrX+4/DjKU3hGJry8iolR+N036fO1Kwls2V/+4bJW
         LQhcWdvEZXdg2A/lCyd7pVD778Ornl+yIkeDYsJGTd7QRSjgy5jXxOFr0UMkC5UZc2Hp
         +FR9O6LmM8xVTC64j92+M0TysKDZCLTAmCZTMsZHvEpIRErca/BWqzOWm6dkMr94SR8/
         tAsJhByprZ76uOh9rJSBx+8dEzEuJQ55c66/ZeetnkkvkRTQZ6tILZOtBLyeaYYoN4jl
         CYyA==
X-Forwarded-Encrypted: i=1; AJvYcCXeLkGnW7hz4FJwIpfR/lx9olL+g5vshUerwO8BkSfDJGLYfkjdL36Opl0YUEaGuRDHIxfLZWB+N6Vg+TG9OwAu6AxDlEvukMNGczLL
X-Gm-Message-State: AOJu0YwWUVfG57tJBLSNP1jt/bidj0Ek4TqyGDgVtuy/98RgSUzlPreG
	gylBq9DS52mec1OI0lPPXjsIzCIRiMzMgYD5HI3G0fp9qzRXvwBzRIh7efHTx2U=
X-Google-Smtp-Source: AGHT+IGgN5iuJwUgNnlb59aZEIB6wFEx4gj/jgjcfdo0uE/3UyBiDlOaJ8FFaZgGUQsX4ZMBCrSNWQ==
X-Received: by 2002:a17:906:d8db:b0:a3e:3d13:5b76 with SMTP id re27-20020a170906d8db00b00a3e3d135b76mr277257ejb.73.1708164877117;
        Sat, 17 Feb 2024 02:14:37 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id tl23-20020a170907c31700b00a3da5bf34absm846758ejc.207.2024.02.17.02.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 02:14:36 -0800 (PST)
Message-ID: <63b3eff6-49eb-46f3-a6d9-878eddf6de53@linaro.org>
Date: Sat, 17 Feb 2024 11:14:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/4] dt-binding: phy: hisi-inno-usb2: convert to YAML
Content-Language: en-US
To: forbidden405@outlook.com, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>,
 Pengcheng Li <lpc.li@hisilicon.com>, Shawn Guo <shawn.guo@linaro.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
 David Yang <mmyangfl@gmail.com>
References: <20240216-inno-phy-v1-0-1ab912f0533f@outlook.com>
 <20240216-inno-phy-v1-1-1ab912f0533f@outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240216-inno-phy-v1-1-1ab912f0533f@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/02/2024 16:21, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> Also rename to hisilicon,inno-usb2-phy.yaml and add this name to
> compatible lists.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  .../bindings/phy/hisilicon,inno-usb2-phy.yaml      | 115 +++++++++++++++++++++
>  .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt |  71 -------------
>  2 files changed, 115 insertions(+), 71 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
> new file mode 100644
> index 000000000000..73256eee10f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
> @@ -0,0 +1,115 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/hisilicon,inno-usb2-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HiSilicon HiSTB SoCs INNO USB2 PHY device
> +
> +maintainers:
> +  - Yang Xiwen <forbidden405@outlook.com>
> +
> +properties:
> +  compatible:
> +    minItems: 1

No, why? Compatibles must be fixed/constrained.

> +    items:
> +      - enum:
> +          - hisilicon,hi3798cv200-usb2-phy
> +          - hisilicon,hi3798mv100-usb2-phy

This wasn't here before. Not explained in commit msg.

> +      - const: hisilicon,inno-usb2-phy
> +
> +  reg:
> +    maxItems: 1
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      Should be the address space for PHY configuration register in peripheral
> +      controller, e.g. PERI_USB0 for USB 2.0 PHY01 on Hi3798CV200 SoC.
> +      Or direct MMIO address space.
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  clocks:
> +    maxItems: 1
> +    description: reference clock
> +
> +  resets:
> +    maxItems: 1
> +
> +patternProperties:
> +  'phy@[0-9a-f]+':
> +    type: object
> +    additionalProperties: false
> +    description: individual ports provided by INNO PHY
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      '#phy-cells':
> +        const: 0
> +
> +      resets:
> +        maxItems: 1
> +
> +    required: [reg, '#phy-cells', resets]

One item per line. Look at other bindings or example-schema.

> +
> +required:
> +  - compatible
> +  - clocks
> +  - reg
> +  - '#address-cells'
> +  - '#size-cells'
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/histb-clock.h>
> +
> +    peripheral-controller@8a20000 {
> +        compatible = "hisilicon,hi3798cv200-perictrl", "syscon", "simple-mfd";
> +        reg = <0x8a20000 0x1000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0x0 0x8a20000 0x1000>;

Drop the node, not related to this binding. If this binding is supposed
to be part of other device in case of MFD devices or some tightly
coupled ones, then could be included in the example there.

> +
> +        usb2-phy@120 {
> +            compatible = "hisilicon,hi3798cv200-usb2-phy";
> +            reg = <0x120 0x4>;
> +            clocks = <&crg HISTB_USB2_PHY1_REF_CLK>;
> +            resets = <&crg 0xbc 4>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            phy@0 {
> +                reg = <0>;
> +                #phy-cells = <0>;
> +                resets = <&crg 0xbc 8>;
> +            };
> +
> +            phy@1 {
> +                reg = <1>;
> +                #phy-cells = <0>;
> +                resets = <&crg 0xbc 9>;
> +            };
> +        };
> +
> +        usb2-phy@124 {
> +            compatible = "hisilicon,hi3798cv200-usb2-phy";

You can keep only one example, because they are basically the same.


Best regards,
Krzysztof


