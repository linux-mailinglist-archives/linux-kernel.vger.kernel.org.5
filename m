Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE00275DB4C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 11:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjGVJXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 05:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjGVJXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 05:23:13 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0F22D47
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 02:23:11 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-314313f127fso2087100f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 02:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690017790; x=1690622590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XT0YJwA5wpgSh6StJpWCXO4kO37kVk1+EeRpL2QWvQg=;
        b=Pfehy92aCJXBtpRKzQtpThMxokjeL6Ic1k6Ueq7iZYeTyvAtMWgFloMV+YjwCKqF8i
         j5sqoOIYq/BfxqdTdoq1J6lR/+EODlVlM9D7F632Xbahl43rTHNbVoYI17rT894cTwyo
         2nVNNJhX8NRJ119IGZvtIF6ZKum9mg/7MY8ig00FJu/W59avstexgBM7KiX/H6GY29UJ
         WCegQaw3u+J0rWCut9Y4/KmpSd5tbP7VNSNsWDjMK+sdwdDmA2MnsLQhQi5QYo2+Oy9m
         L0IP1t/M/Zy19wzDbkEMVoqDHq6IUeXMP4r9mH0hgkI0sX7IP22v3zmQhm3DLsQ7yy1x
         ARnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690017790; x=1690622590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XT0YJwA5wpgSh6StJpWCXO4kO37kVk1+EeRpL2QWvQg=;
        b=HjsvogAA3tkSDiuxudZb+XNvjP6ln/uwzzl/rYYBWw+PcgVps9tBuJXmTRToMbQzLW
         0Ws7KQ6F4kGlUWqCB9GvZhu7MwCq2mIBHCodnGieQZ+rdjKcB6JDamojM5hvrBWcx9k0
         nK5XjxkzqQKH2YS39tTmfK0bAi/Iso6CE6OySPUvF6Z72qVU+viWOgzBy9RKpOkdpQa5
         zy9f5dvSoFvlkJNfVHNGQm7TZ/42CexIXKRfoEhQt7D/Q5u5a/P92J1GMY27YXAxeTkc
         sFbaZ0EdQsoHBQJA/9s4lbssGairGvQAoyWketgj6BChVIDrQOvMBzahMWDBQWqtq/L6
         +W1Q==
X-Gm-Message-State: ABy/qLZ2+8schd0PHEyDPHOtlVbIYrtb6mmgr693fNJH5ADCELM+XauP
        xzveW25PJKKnCGnVItY8BL5lXg==
X-Google-Smtp-Source: APBJJlEnLE1qzuS1Tfe9PmJ2bcAEPtnmhDzQJf77UYJ0uwmIPXcyl539LotgSBUbG/F5DzqS4zABJw==
X-Received: by 2002:a05:6000:545:b0:313:f862:6e3e with SMTP id b5-20020a056000054500b00313f8626e3emr2787726wrf.40.1690017790136;
        Sat, 22 Jul 2023 02:23:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id n8-20020adfe348000000b00315af025098sm6432802wrj.46.2023.07.22.02.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jul 2023 02:23:09 -0700 (PDT)
Message-ID: <2067e0ec-0c5c-4f0f-6b1e-c084a3e433f4@linaro.org>
Date:   Sat, 22 Jul 2023 11:23:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 06/10] dt-bindings: clock: Add documentation for Marvell
 PXA1908
Content-Language: en-US
To:     =?UTF-8?Q?Duje_Mihanovi=c4=87?= <duje.mihanovic@skole.hr>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.com
References: <20230721210042.21535-1-duje.mihanovic@skole.hr>
 <20230721210042.21535-7-duje.mihanovic@skole.hr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230721210042.21535-7-duje.mihanovic@skole.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2023 22:37, Duje Mihanović wrote:
> Add dt bindings and documentation for Marvell PXA1908's clock controller
> blocks.
> 
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
> ---
>  .../bindings/clock/marvell,pxa1908.yaml       | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml b/Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml
> new file mode 100644
> index 000000000000..3fa6f00a26f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/marvell,pxa1908.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell PXA1908 Clock Controllers
> +
> +maintainers:
> +  - Duje Mihanović <duje.mihanovic@skole.hr>
> +
> +description: |
> +  The PXA1908 clock subsystem generates and supplies clock to various
> +  controllers within the PXA1908 SoC. The PXA1908 contains numerous clock
> +  controller blocks, with the ones currently supported being APBC, APBCP, MPMU
> +  and APMU roughly corresponding to internal buses.
> +
> +  Each clock is assigned an identifier and client nodes use this identifier to
> +  specify the clock which they consume.

Drop this sentence, it's obvious.

> +
> +  All these identifiers could be found in <include/dt-bindings/marvell,pxa1908.h>.

"Clock identifiers ..."

> +
> +properties:
> +  compatible:
> +    enum:
> +      - marvell,pxa1908-apbc
> +      - marvell,pxa1908-apbcp
> +      - marvell,pxa1908-mpmu
> +      - marvell,pxa1908-apmu

Blank line

> +  reg:
> +    maxItems: 1
> +    description: |
> +      Physical address of the clock controller and length of the memory mapped
> +      region.

Drop description, it is obvious.

> +
> +  '#clock-cells':
> +    const: 1

Best regards,
Krzysztof

