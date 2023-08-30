Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE75278DE19
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbjH3S5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241532AbjH3G4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 02:56:51 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE32194
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 23:56:45 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-500b66f8b27so5206059e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 23:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693378604; x=1693983404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FKNC/Ecmczb+pprJRVI/jNOGGup4YFMq8hyWzf6I3EM=;
        b=WIZ3OTUSveMvOL3e8mB9fiGf40833DgAgSns8ITCk1NuhavzY113ObI2EtVdVLKZwW
         KJ5Znhbc5YhmbaPQsbM/ynXrLP4jiU68w5mmnJuogg4XdlnIdfzlbMcCVGJuOQG7qEu9
         f8UPlpchyx5p2pIb2bK7YuqloVQTuj+tQ1UGGjygSDq6UYPOUIZkY+rNH1pXgH0NJO2C
         d8AySKR2JOXlWe45qmqmspOXqE1USwlKd341A85AcqnSvrbnVu774/ToRcW6/yrhGzmP
         VZVm5EgHhKNCDBrNoQh0gACbhxSEHNv4U3FSQc1ToeabwFOQLK6UELU7XoL2y5DESWa2
         unrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693378604; x=1693983404;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FKNC/Ecmczb+pprJRVI/jNOGGup4YFMq8hyWzf6I3EM=;
        b=RIDC5cv7DicCw6sltwBQuQIgMi4IhlF0uEMe9tX4WZ3V5Hka3UjrPKa00PB1zD+Zz3
         AAnM0GOJpsVcQv9gos7vZwpXh47XD5by3TIoaDOOLLJpoPsrVrnIeh4CErwdWIjUh4xX
         Hqr1EUGwZQjD4NwKrlfSoksdIA32JRtfK81yiwnn9qrNB/x9tnED603x+SXiFey2p2Rs
         5giCYoxkE4GeP78a4q/G4Yp1Q1of3LfbVhB662q3ins0h//oBGoJ0ZBNgK1Arl5nylmi
         sI1GwtRypnzF+F3+FfIYMnOvcYsMBv9qAYwVnGLHGObhrU7+D+Dgl0QF7QtTQVoKAxTk
         7iWQ==
X-Gm-Message-State: AOJu0Yw6C7tRCnHvPfpGAhKI8VPM8IPYnGRpMfuUnB8z0vsyHX2yq8Xc
        WM2ItfSHPc5+M6KOLxJz+LVaDQ==
X-Google-Smtp-Source: AGHT+IEkicIQuRpUPzDVnA0JHWBk+8C+LPUAUHJor3ONxVqWsbLcrf8WjtNGb6UOKF8JDaWBm8ZWqA==
X-Received: by 2002:a2e:8619:0:b0:2bd:10d3:214 with SMTP id a25-20020a2e8619000000b002bd10d30214mr1105105lji.11.1693378603617;
        Tue, 29 Aug 2023 23:56:43 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id fx19-20020a1709069e9300b0098e0a937a6asm6796450ejc.69.2023.08.29.23.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 23:56:43 -0700 (PDT)
Message-ID: <03729949-1994-6ce1-253b-886a254ac0af@linaro.org>
Date:   Wed, 30 Aug 2023 08:56:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/1] ARM: dts: aspeed: Minerva: Add Facebook Minerva
 (AST2600) BMC
Content-Language: en-US
To:     peteryin <peteryin.openbmc@gmail.com>, patrick@stwcx.xyz,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     cosmo.chou@quantatw.com, potin.lai@quantatw.com,
        daniel-hsu@quantatw.com
References: <20230830025133.3756506-1-peteryin.openbmc@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230830025133.3756506-1-peteryin.openbmc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2023 04:51, peteryin wrote:
> Add linux device tree entry related to
> Minerva specific devices connected to BMC SoC.
> 
> Signed-off-by: peteryin <peteryin.openbmc@gmail.com>
> ---
> v1 link : https://lore.kernel.org/all/fb09f5e6-8381-312f-2f1e-f2b471cec68a@linaro.org/
> v2 link : https://lore.kernel.org/lkml/9f499fe5-db59-f4c8-6a50-93725b7287fd@linaro.org/
> 
> Change log:
> 
> v3:
>     1.Fixed commit description.
>     2.Add sgpio line name to sgpioP.
>     3.Add ipmb debug card bus.
> 
> v2:
>     1.Add facebook,minerva-bmc in aspeed.yaml
>     2.Use stdout-path
>     3.Add Makefile
> 
> v1:
>     1. Create minerva dts file.
> 
> ---
>  .../bindings/arm/aspeed/aspeed.yaml           |   1 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/aspeed-bmc-facebook-minerva.dts  | 384 ++++++++++++++++++
>  3 files changed, 386 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-minerva.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index fb4ce5df2fa0..9d1b26e7ca6b 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -79,6 +79,7 @@ properties:
>                - facebook,elbert-bmc
>                - facebook,fuji-bmc
>                - facebook,greatlakes-bmc
> +              - facebook,minerva-bmc
>                - ibm,everest-bmc
>                - ibm,rainier-bmc
>                - ibm,tacoma-bmc

Nothing improved here. Checkpatch still complains. Bindings are always
separate patches.

Also, this patch does not apply to any tree.

Best regards,
Krzysztof

