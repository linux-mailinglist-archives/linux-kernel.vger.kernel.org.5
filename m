Return-Path: <linux-kernel+bounces-143998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121678A408F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47FA1B21598
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7051C6BE;
	Sun, 14 Apr 2024 06:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G8fRLg6p"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5EE1BF35
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 06:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713075114; cv=none; b=SMc9l4cnGTUNj5I8sYAm85eYhWZKDG1elYzfhwez/MNNei3ybvOSHDewvb9BVQtiKdX8gCbSBIamTX3dVIU7mzFixIii6qwdYn2ikjV5IhT6lxW7g42lui5a80j8oWkyk1AeC6PHtkLULiiOMkHUmGNIOF2nEabJrev6c5Zeedc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713075114; c=relaxed/simple;
	bh=eFRsxOxHBmtCeLE5V4fhZdrAP+of9SqJzpq5mDZckkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V+79wNr1/BQwDbQ9/+g5SpldvxnzxtAx2azi5OZLCVJFZoaBEQaXjpdAsHBYJcLsWkVjV0qxqar+Wczwhe/3bL8mRC0KODwFDo/F6ssmDTVWEdhrimxIIbKyr73NFXWhz4uxYoCtbgbd70WN+JjLDIFRAdtXdU35upLdWeBuPrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G8fRLg6p; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2da01cb187cso38527221fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 23:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713075111; x=1713679911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cd1B/deojel3okqrmPvn65KeF4SUoVm8wG0roldbzJ8=;
        b=G8fRLg6pHXOeF5ykqXpmW44qOwsA0xdKMJP3fD4YsHS8DufTxRAXXWpSvw7AXwHrq4
         k1Al2yEb0ro9hijh8gU/RObwNSnD4/0BPmo3s99a/zDmOglcsx6q0M1kNzkoiPp7IYv8
         ZUiLIK2ISRWgfHkP4qjjyTegR5k77F2zcnpo0op2WVzDsiZBakAwckNkeWkC+ScYxruP
         QMqg8xPVtRGO/RRfHLNPx6iKYiaakeFOAZj4CLn/Y+wWMhHIfVA5wM0413z6LtDc+6L1
         GIdW6eLom7P+L7B0UzhaAwaLWXguKtF4Q0J8SaM7HjI22jsq9d7iA2AMGisJLbJEbOcn
         E/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713075111; x=1713679911;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cd1B/deojel3okqrmPvn65KeF4SUoVm8wG0roldbzJ8=;
        b=A9sUvORIHJx2+aU2F7NITsvSNX8wCPDzvnFmAsu6Ornd/wdeZjiCyY79k+QsRW3Eq2
         e0Wo8Jm/ygLyGFGbPFJXE6lXkBMwHdKbtfIeqqYRsdK46iaoaaGj7foUjHEpwool4TxG
         dYda+ZVJ+Ad7OpC7Nmakhbc3JPHQbnLmAkWTn3+OVAoDHSXeZSOfMFtj+Ly8u5x7LU8p
         LFWhsZC9nUYp57TTjgJ/EY/6iQbA+j4yccDGi0GaexGnfWvz6bXCo4p28smr+vQ3Ff4j
         QlUmFLpvbesDS3SshaZg02LR3Opby9e7QdmcZjbTzJmLmA2SFlsGSFBwesfor3Y0Yk5z
         scBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhiFWOfD9Mpf4FOeXKrEMYS/5KoIjEd+biIOe5OhSAYs8IVTDRMH79e5GRTAvYB4C0vOVfivIraYAayBK9Xq9Z1vsZhfq/AtEYt16x
X-Gm-Message-State: AOJu0YzkpLc/EDCvfgZhS11Pirn/2xhkxemhXPxNC77sVNADR/Hy/09o
	PNKNnAZaa1/Xw6BbAcJCaQf0jyB1IPzJzouxs7aHNID4vsGTr1bLYu/xienDdtM=
X-Google-Smtp-Source: AGHT+IGatFcyjx4ZoKtHo2CnivNndKMYuB3RNG73Saq12WIxXbSVKNPi4KmUQ8kkEUebJL5Z4b4fCQ==
X-Received: by 2002:a2e:8e88:0:b0:2d8:6ca7:2165 with SMTP id z8-20020a2e8e88000000b002d86ca72165mr4875055ljk.46.1713075111114;
        Sat, 13 Apr 2024 23:11:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id kf20-20020a17090776d400b00a51e9b299b9sm3805488ejc.55.2024.04.13.23.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 23:11:50 -0700 (PDT)
Message-ID: <df328b50-eec8-4a2e-ba58-666d6ce8d1c0@linaro.org>
Date: Sun, 14 Apr 2024 08:11:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] dt-bindings: mmc: Add support for BCM2712 SD host
 controller
To: Andrea della Porta <andrea.porta@suse.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Kamal Dasu
 <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, Jonathan Bell <jonathan@raspberrypi.com>,
 Phil Elwell <phil@raspberrypi.com>
References: <cover.1713036964.git.andrea.porta@suse.com>
 <ad96fff723675c2d65a5e3328da9b09f2781cbcd.1713036964.git.andrea.porta@suse.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ad96fff723675c2d65a5e3328da9b09f2781cbcd.1713036964.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/04/2024 00:14, Andrea della Porta wrote:
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

? And what is being done here and why?

> ---
>  .../bindings/mmc/brcm,sdhci-brcmstb.yaml      | 51 ++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> index cbd3d6c6c77f..6aa137d78e4f 100644
> --- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> +++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> @@ -13,6 +13,7 @@ maintainers:
>  properties:
>    compatible:
>      oneOf:
> +      - const: brcm,bcm2712-sdhci
>        - items:
>            - enum:
>                - brcm,bcm7216-sdhci
> @@ -26,12 +27,16 @@ properties:
>            - const: brcm,sdhci-brcmstb
>  
>    reg:
> -    maxItems: 2
> +    minItems: 2
> +    maxItems: 4
>  
>    reg-names:
> +    minItems: 2
>      items:
>        - const: host
>        - const: cfg
> +      - const: busisol
> +      - const: lcpll
>  
>    interrupts:
>      maxItems: 1
> @@ -60,6 +65,7 @@ properties:
>      description: Specifies that controller should use auto CMD12
>  
>  allOf:
> +  - $ref: sdhci-common.yaml
>    - $ref: mmc-controller.yaml#

Why? Anyway, this replaces mmc-controller, doesn't it?

>    - if:
>        properties:
> @@ -71,6 +77,28 @@ allOf:
>        required:
>          - clock-frequency
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: brcm,bcm2712-sdhci
> +
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 4
> +        clock-names:
> +         const: "sw_sdio"

Not tested.

> +
> +    else:
> +      properties:
> +        reg:
> +          minItems: 2
> +          maxItems: 2
> +        reg-names:
> +          minItems: 2
> +          maxItems: 2
> +
>  required:
>    - compatible
>    - reg
> @@ -114,3 +142,24 @@ examples:
>        clocks = <&scmi_clk 245>;
>        clock-names = "sw_sdio";
>      };
> +
> +  - |
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      mmc@fff000 {
> +        compatible = "brcm,bcm2712-sdhci";
> +        reg = <0x10 0x00fff000  0x0 0x260>,
> +              <0x10 0x00fff400  0x0 0x200>,
> +              <0x10 0x015040b0  0x0 0x4>,  // Bus isolation control
> +              <0x10 0x015200f0  0x0 0x24>; // LCPLL control misc0-8
> +        reg-names = "host", "cfg", "busisol", "lcpll";
> +        interrupts = <0x0 0x111 0x4>;

Use proper defines.

> +        clocks = <&clk_emmc2>;
> +        sdhci-caps-mask = <0x0000C000 0x0>;
> +        sdhci-caps = <0x0 0x0>;
> +        mmc-ddr-3_3v;
> +        clock-names = "sw_sdio";

names *always* follow property. In every DTS. Please fix youro DTS.



Best regards,
Krzysztof


