Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3ED75C929
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjGUOJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjGUOI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:08:58 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07583AAD
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 07:08:44 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fbb281eec6so3277628e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 07:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689948523; x=1690553323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QdCDvX2ENQQi+dpK3c6L7rSwh7ZxpQvyjeSTayf+l4A=;
        b=mKpa85MjZm0wM2/mDCVf9XYQEXqHnC0zrrCUULJJt2k97Ivcladhym49AqIJy7+Cl6
         M68rFARHi81TAQJXWEUS1FYzNXin0hZbhFEFSIzyz0akk/YVbt8GKI7i1JU6Wbhd2lqU
         QOxvFaJcPysmvURITXByzqQERED004zQDaoA/oKyBTElV1S52Qd2ZHxnkLx+wr7VyRv3
         Aw8GSkEJP3SExUtN/YZgkoBVcRyf5/bJ61snewbba4LU6Pe0oAAHNa6hFgRSvTV30hyz
         TujMWvjygIWFj2lESeXLXp5/tCCPHd4jXPTfUK933o8JRD3N8BQjMsDSwwNVnhYuu5Vs
         LxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689948523; x=1690553323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QdCDvX2ENQQi+dpK3c6L7rSwh7ZxpQvyjeSTayf+l4A=;
        b=Ixpfy7yhICkVlfqMomVpTxXm52gaL7lZY0mBLnFPtf5ING7QvRqbBOECicmSV+ZzbI
         s16tbMYLOcuSkd6glzMQIN2D2aTnQ5qMTnSXItFOMrQWMa2y+pQP4ZDu8lHSR3J7ljUP
         Bcb+/Y7Y3XQQQANP99CTVQV6/HWvRxCbeQ2S9tckIeJFePXrj9Ylghc3w7H/jtXlrxad
         +51OUX2l4X60Kpbw3NDhKLFCEsCEJuszx3zBCke6CNYtWdvBb4Slb4yJRWH4e342EywC
         bsGNuZ69MkD72cEO2uqAauqx5pgBolHtI28awHi4VCPjPZWWSmETGyXlRE4Oy425KvD6
         OAgQ==
X-Gm-Message-State: ABy/qLY4NHLHD/gYrPONrTm2XEvB1o0EFtYoUV1xvNRNMlpj5vgtewIi
        21+OkVBIrPqVQOQ7WdI4kkknQQ==
X-Google-Smtp-Source: APBJJlGitP6YdoZI8bIFpNGAsIBqr0u+J3Lfy5UXxN6m18CjoA/M+91KX09TKjqALw4XfrZGY2rXuA==
X-Received: by 2002:a05:6512:3054:b0:4fb:b11:c99e with SMTP id b20-20020a056512305400b004fb0b11c99emr1401012lfb.56.1689948522863;
        Fri, 21 Jul 2023 07:08:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id r1-20020adfce81000000b0031128382ed0sm4321269wrn.83.2023.07.21.07.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 07:08:41 -0700 (PDT)
Message-ID: <22521abf-db55-aec6-fb96-fdb585ef6132@linaro.org>
Date:   Fri, 21 Jul 2023 16:08:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 12/42] dt-bindings: watchdog: Add Cirrus EP93x
Content-Language: en-US
To:     nikita.shubin@maquefel.me,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lennert Buytenhek <kernel@wantstofly.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
        netdev@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-input@vger.kernel.org, alsa-devel@alsa-project.org
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
 <20230605-ep93xx-v3-12-3d63a5f1103e@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605-ep93xx-v3-12-3d63a5f1103e@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2023 13:29, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> This adds device tree bindings for the Cirrus Logic EP93xx

Every patch:

Please do not use "This commit/patch", but imperative mood. See longer
explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95


Best regards,
Krzysztof

