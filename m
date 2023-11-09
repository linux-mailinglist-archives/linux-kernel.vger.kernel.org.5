Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07887E6E8A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343719AbjKIQWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjKIQWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:22:53 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BC035AA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 08:22:50 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507b96095abso1279408e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 08:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699546968; x=1700151768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SlrCzGct6Lpx6z7xP3//KDAUNER14xBsUIT3wpM4fpg=;
        b=WWZ7Mi9soEY9bKFbOc0hRDkFKZLWH3eHuZ8C2uxFGvbtPfppw5HqLU7d3D3atR9tvO
         yfsMhPzmx3sPg6PGdhvyCCt2CzxbYtc7xN5ysvSnFDGtBLQt7Lypte10Mh9R52rIdRHu
         I3gTBXugKlqLWoeQ9Lg8tbqsRMV1W7p7v8rr2beby04EIcaVT++KV8Bi4S/f+KW1IlPU
         AFTr3H4wy8Bc9pXt6X6fcDajduJq8LlWUGPWm8ehT46q4b8RGxD9oamyjcekfZBlSlu0
         evS/BYgvKO1br9+iQA9+6ETfvhZ/EqVou6I6KvpEFI6VTGNq6j3aK79Rg8GNlbaE02Xo
         xqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699546968; x=1700151768;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SlrCzGct6Lpx6z7xP3//KDAUNER14xBsUIT3wpM4fpg=;
        b=hDztzovmdykrgewasM5IUmPTJ9lJy3jkKFTr7KFhTR36dRsK5ZV0dHoSE99einBnat
         C062vIJxrEb9l/fHXTh2a2xHLDK2HIBlUzUWOqIY7Ut6n4QbQVtcDyforONDyul9J59H
         eiO13tXT93WSTs/tZ+2gLiK5qgufKGhk6i6vow6NsBmmaSCaRcD1/NxywW5d3l87dDY2
         HKSIrGWi9VnYaXFJQHjKZe8FToXKed8DaK5wqx7nFGA7i51hNPfP3Q9J4a97qFHhjrqx
         ckkFyR9CUgmDNxx3Ok9wzn0VcI9yHJp5I9EOG8/IF1wFcTV7Udk9zoCqy9nkhlOxhnKW
         brVw==
X-Gm-Message-State: AOJu0YynVzoon8eB7BxyMjGMAaM0ElmVIkgqtR6BOtdbQeSf+pSf6qln
        bxPWSgpSQBgNAUo0WFOPYsTJQQ==
X-Google-Smtp-Source: AGHT+IGgXqc0yMAFIHY2eRZZaHei8dFOjeflGpnumK7lKqJOvNpDKPNJ2WXN+DZgGTnpSkONhXMARg==
X-Received: by 2002:a19:505a:0:b0:509:4ab3:a8a3 with SMTP id z26-20020a19505a000000b005094ab3a8a3mr1850064lfj.22.1699546968366;
        Thu, 09 Nov 2023 08:22:48 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id j14-20020a05600c190e00b004094c5d929asm2586094wmq.10.2023.11.09.08.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 08:22:47 -0800 (PST)
Message-ID: <71ca3812-9226-4a83-a655-78401e4ed33f@linaro.org>
Date:   Thu, 9 Nov 2023 17:22:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6][4/4] dt-bindings: mmc: Add dt-bindings for realtek mmc
 driver
Content-Language: en-US
To:     Jyan Chou <jyanchou@realtek.com>, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, jh80.chung@samsung.com,
        riteshh@codeaurora.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     conor+dt@kernel.org, asutoshd@codeaurora.org,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, briannorris@chromium.org, doug@schmorgal.com,
        tonyhuang.sunplus@gmail.com, abel.vesa@linaro.org,
        william.qiu@starfivetech.com
References: <20231109082043.27147-1-jyanchou@realtek.com>
 <20231109082043.27147-5-jyanchou@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231109082043.27147-5-jyanchou@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2023 09:20, Jyan Chou wrote:
> Document the device-tree bindings for Realtek SoCs mmc driver.

Subject and commit msg - drop driver and describe hardware instead.
s/mmc/MMC/

> 
> Signed-off-by: Jyan Chou <jyanchou@realtek.com>
> 
> ---
> v5 -> v6:
> - Drop the incorrect, generic compatible and modify it to specific.
> - Drop useless properties.

Which ones?

> - Modify bindings to make DTS and driver match.
> 
> v4 -> v5:
> - Remove unused property, e.g.,cqe, resets, clock-freq-min-max.
> - Fix indentation.
> 
> v3 -> v4:
> - Describe the items to make properties and item easy to understand.
> - Fix examples' indentation and compiling error.
> - Drop useless properties.
> 
> v2 -> v3:
> - Modify dt-bindings' content and description.
> - Fix coding style.
> - Update the list of maintainers.
> 
> v1 -> v2:
> - Add dt-bindings.
> ---
>  .../bindings/mmc/realtek,rtd-dw-cqe-emmc.yaml | 162 ++++++++++++++++++
>  1 file changed, 162 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/realtek,rtd-dw-cqe-emmc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mmc/realtek,rtd-dw-cqe-emmc.yaml b/Documentation/devicetree/bindings/mmc/realtek,rtd-dw-cqe-emmc.yaml
> new file mode 100644
> index 000000000000..d7118cf457e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/realtek,rtd-dw-cqe-emmc.yaml
> @@ -0,0 +1,162 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/realtek,rtd-dw-cqe-emmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Realtek DesignWare mobile storage host controller
> +
> +description:
> +  Realtek uses the Synopsys DesignWare mobile storage host controller
> +  to interface a SoC with storage medium. This file documents the Realtek
> +  specific extensions.
> +
> +maintainers:
> +  - Jyan Chou <jyanchou@realtek.com>
> +
> +allOf:
> +  - $ref: synopsys-dw-mshc-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - realtek,rtd1325-dw-cqe-emmc
> +      - realtek,rtd1319-dw-cqe-emmc
> +      - realtek,rtd1315e-dw-cqe-emmc
> +      - realtek,rtd1619b-dw-cqe-emmc
> +
> +  reg:
> +    items:
> +      - description: emmc base address
> +      - description: cqhci base address
> +
> +  reg-names:
> +    items:
> +      - const: emmc
> +      - const: cqhci
> +
> +  realtek,m2tmx:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to m2tmx syscon register region.

There is no such stuff as "syscon register region". Syscon is Linux
term. Please write here instead the full name of the hardware block and
describe its purpose (for what is it needed for).

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 4
> +
> +  clock-names:
> +    items:
> +      - const: biu
> +      - const: ciu
> +      - const: vp0
> +      - const: vp1
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: reset

Nothing improved here.

Go back to previous versions and implement the feedback you received.

Best regards,
Krzysztof

