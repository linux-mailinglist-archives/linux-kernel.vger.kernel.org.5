Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F3F786077
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 21:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238271AbjHWTPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 15:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238282AbjHWTOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 15:14:41 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6D210DC;
        Wed, 23 Aug 2023 12:14:38 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99df11828c6so31546866b.1;
        Wed, 23 Aug 2023 12:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692818077; x=1693422877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GfGoPJfPXeL122AI/Y6i59RXbA4MoNTzdh5/a56Xn0=;
        b=QJvDLNUBheJo6Z3mPsuYD5nZRJyW2l/OZodVbzD4U6Js7o5S2sE9dGB1wsabKctn2S
         9tU+TeFm/qQCuHFmp9+YSNZFscM73NNk/0EBbZRVYyqTAlZqp4llP5sc9BvKrnVLTE4J
         ZiQmZdxoRYvkbANv806hjyyKLb20aZqCYbTPdPq7pKNf5wAclWk+vJwjgLjsyvyo6dWZ
         T2klMKPTCV0/DPK1JuLl8yOQEBFqT+8qtxTQxaPkokhC38PM/QV2mIhDHi+rlUHr5Keu
         pU+J2vBCFvlIhfOsnGyHdzCN6h3rlGbVFTKCR7qnIQBk8bLMt/LcglVDySFm/y50gqXY
         GjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692818077; x=1693422877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GfGoPJfPXeL122AI/Y6i59RXbA4MoNTzdh5/a56Xn0=;
        b=PkmcXyB9Hk7aF+LbOagZ6kP82Ovcay6mqmHhSkSa8Dl+IYeQUelz57IZnc0zXUeQrQ
         +5Eu2ex6LLK9LMXvNlQ2S5NUBQXxI1mD6knmN3Xp+RiQf4ousCEBDr9YY/Ou1nlBfYwJ
         ghDL06Iv+WWVBirsFYHWd/RyRvlM8pg2B3U6zBGlzUJEoxREL/JOHDdLYEfyKDEZr/+L
         CKwAOCQZ7LwT82G3RMH0X6jJD7qmPz5sGrMJFGDHkUAsgn1plRO90AnN/eu3nchwyqsH
         BGhPm+v5sn4+r9FrBdp577EPV0FmnHAt7yCLuiAyGejJ8f934IMuvuTRiM6zXgUX0u4h
         QJ6w==
X-Gm-Message-State: AOJu0YyXvX+aDhMJ/Ry8E3Pbrv4sBCb4KoBcOfaG5HlLrEncaKOufmU/
        Wke5fMtCgdx1r4fQVN+nFqEv8pn+bTi+Qg==
X-Google-Smtp-Source: AGHT+IEyB/ZIs6kkflGm4CaDR9JI8pIkw1oTLixQ0Y4DZJKD0Tq/QtdPvoLjd898II3fszhvDVCRmw==
X-Received: by 2002:a17:906:3051:b0:99c:5056:4e31 with SMTP id d17-20020a170906305100b0099c50564e31mr17063070ejd.15.1692818076698;
        Wed, 23 Aug 2023 12:14:36 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id ci16-20020a170906c35000b0098e34446464sm10091272ejb.25.2023.08.23.12.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 12:14:36 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-renesas-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 2/2] arm64: dts: use capital "OR" for multiple licenses in SPDX
Date:   Wed, 23 Aug 2023 21:14:34 +0200
Message-ID: <4824782.GXAFRqVoOG@jernej-laptop>
In-Reply-To: <20230823085146.113562-2-krzysztof.kozlowski@linaro.org>
References: <20230823085146.113562-1-krzysztof.kozlowski@linaro.org>
 <20230823085146.113562-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 23. avgust 2023 ob 10:51:46 CEST je Krzysztof Kozlowski napisal(a):
> Documentation/process/license-rules.rst and checkpatch expect the SPDX
> identifier syntax for multiple licenses to use capital "OR".  Correct it
> to keep consistent format and avoid copy-paste issues.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Rebased on next-20230822, so might not apply cleanly.  What does not
> apply, can be skipped and I will fix it after next RC.
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts  | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi                 | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts   | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi   | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts   | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts         | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts   | 2 +-

For Allwinner:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  arch/arm64/boot/dts/arm/corstone1000-fvp.dts                   | 2 +-
>  arch/arm64/boot/dts/arm/corstone1000-mps3.dts                  | 2 +-
>  arch/arm64/boot/dts/arm/corstone1000.dtsi                      | 2 +-
>  arch/arm64/boot/dts/broadcom/stingray/bcm958802a802x.dts       | 2 +-
>  arch/arm64/boot/dts/broadcom/stingray/stingray-board-base.dtsi | 2 +-
>  arch/arm64/boot/dts/broadcom/stingray/stingray-pcie.dtsi       | 2 +-
>  arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi        | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dts           | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtsi          | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mm-emcon.dtsi                | 2 +-
>  arch/arm64/boot/dts/renesas/r8a77980a.dtsi                     | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi           | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779f0-spider.dts                | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779f0.dtsi                      | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m0.dtsi                      | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m1-salvator-xs.dts           | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m1-ulcb-kf.dts               | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m1-ulcb.dts                  | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m1.dtsi                      | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m2.dtsi                      | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m3-salvator-xs.dts           | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m3-ulcb-kf.dts               | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m3-ulcb.dts                  | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m3.dtsi                      | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m4.dtsi                      | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m5-salvator-xs.dts           | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m5.dtsi                      | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m6.dtsi                      | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m7.dtsi                      | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779m8.dtsi                      | 2 +-
>  arch/arm64/boot/dts/renesas/r8a779mb.dtsi                      | 2 +-



