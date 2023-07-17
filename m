Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425EA7569C6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjGQRAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjGQRAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:00:23 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9FC131
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:00:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51f90f713b2so7229864a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689613220; x=1692205220;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E3p33dWnkdeh3xpTQxAQgmV3R/uRJxOJYd91gzLj00A=;
        b=m8yS9UZ+f2QdyKnO/qCfSMKXPU9QLDocZidXf4zNoBF9bsrA7Nbo4b+DIm99BE6fxJ
         KJSYWutemCNe/339E6y1MnksqO8QZvyrbI2G2PZ9gpwVI7/H12f2DuJ32v2CKHFAqS0m
         BQwxRyLMsvtfS5pcNf8bH2MfzngSW6mUoNLqW86jC7EoAHQExhbSkL3izemXZrmI4pao
         I+1DcVKwswBGsjbgh1RFA0dcUQ3hhQk8SHHFv+SDH7yHgQrM15sLB7By7cRTZziX9f8Q
         efKIzBi4/jOLgaR0bLIGZIsAM3N3Je1hm5VNHgMOHWSHifMSsyo+L0WBECO1czvku+0/
         FsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689613220; x=1692205220;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3p33dWnkdeh3xpTQxAQgmV3R/uRJxOJYd91gzLj00A=;
        b=hDjm+f3x7qpWoSrX8Nycv2+wPDiDYKs9KFKynN9YAoW38i3mCblF2/Xq+QeRAy6XI6
         Nr+ylQKdGRgHW2jywpQU5bqftB70dlZMY/B+bcPDo7aXWUSPOYCnCs++BGkarzNKfJ6O
         s6PUcY1AyIwAUNa/ma/W7HJoIlzMbEHQJVe3qF8huOJl2xSr6YENuocsjbfPpSk2fUUN
         Yhf5+j6g+9Fz3PIOEgL0ID00i5KqbKMUU5Jb2a7ip37u9gyhXZvlzpfxKVu5bCp2NFNL
         eNAKd9G0RfQe4IO2meC08L/tqxrJIgh3VoTWRRpuiFHdEYfb9VxpB8qPcSDwJp6PuML6
         4xDA==
X-Gm-Message-State: ABy/qLZMbD/0G/FIEIZ9XY2yVrHM8w619eExO/Zc8DXmhqiibyfBf6Av
        A96TNtWqx6SsNaY9batJFeeQdg==
X-Google-Smtp-Source: APBJJlHmbLwM2HYUTllhtBE/n/VE5V3pybwFFBwmW+Iivch6NTA1sYDdu+NuAGFsEAEr204hYKYVEA==
X-Received: by 2002:a05:6402:551:b0:51d:d5f2:121c with SMTP id i17-20020a056402055100b0051dd5f2121cmr397371edx.5.1689613220365;
        Mon, 17 Jul 2023 10:00:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id d18-20020aa7ce12000000b0051ddfb4385asm10250978edv.45.2023.07.17.10.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 10:00:19 -0700 (PDT)
Message-ID: <3d1a260c-bc8c-6347-17be-5558343c85a4@linaro.org>
Date:   Mon, 17 Jul 2023 19:00:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: fsl: fix DEBIX binding
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, laurent.pinchart@ideasonboard.com,
        dan.scally@ideasonboard.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230717165127.2882535-1-m.felsch@pengutronix.de>
 <20230717165127.2882535-2-m.felsch@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230717165127.2882535-2-m.felsch@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 18:51, Marco Felsch wrote:
> The current imx8mp-debix-model-a.dts uses all three compatibles. Fix the
> corresponding bindings by adding an own entry for it. Mark
> polyhex,imx8mp-debix as deprecated but keep it within the dts file since
> we already have a user for it [1].
> 
> [1] https://elixir.bootlin.com/barebox/v2023.07.1/source/arch/arm/ \
>     boards/polyhex-debix/board.c#L38
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> Changelog:
> 
> v2:
> - deprecate polyhex,imx8mp-debix
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 15d4110840654..b29974e3c30b3 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1019,8 +1019,6 @@ properties:
>                - dmo,imx8mp-data-modul-edm-sbc # i.MX8MP eDM SBC
>                - fsl,imx8mp-evk            # i.MX8MP EVK Board
>                - gateworks,imx8mp-gw74xx   # i.MX8MP Gateworks Board
> -              - polyhex,imx8mp-debix      # Polyhex Debix boards
> -              - polyhex,imx8mp-debix-model-a # Polyhex Debix Model A Board
>                - toradex,verdin-imx8mp     # Verdin iMX8M Plus Modules
>                - toradex,verdin-imx8mp-nonwifi  # Verdin iMX8M Plus Modules without Wi-Fi / BT
>                - toradex,verdin-imx8mp-wifi  # Verdin iMX8M Plus Wi-Fi / BT Modules
> @@ -1054,6 +1052,14 @@ properties:
>            - const: phytec,imx8mp-phycore-som         # phyCORE-i.MX8MP SoM
>            - const: fsl,imx8mp
>  
> +      - description: Polyhex DEBIX i.MX8MP based SBCs
> +        items:
> +          - enum:
> +              - polyhex,imx8mp-debix-model-a        # Polyhex Debix Model A Board
> +          - const: polyhex,imx8mp-debix             # Polyhex Debix boards

I cannot find patches which add new compatible to the binding and which
fix the DTS. :/

Best regards,
Krzysztof

