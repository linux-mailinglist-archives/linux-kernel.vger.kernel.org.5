Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90324766BD5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbjG1LdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236217AbjG1LdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:33:03 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172683ABD
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:32:57 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fc0aecf15bso22343325e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690543975; x=1691148775;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bvt6gTVxDn+2sUGsn1CSbJgPH86R0eTVqQfCu4TXUDo=;
        b=ihYG/3HHPl5FBpQ+akutSxXPgMXuWO0DzvVRM1SksGA8Z6z6pOdw0xIixvMEZJwJcd
         4Z9oCv17ECKWSDIarWP03zMzkLYWgMwcwhoxSSaT5GUpRNxEjtRo4EY8oOokfuAmg2K3
         X3bV9VHSl8t4uwTz1mse0RuhyVeDc9KRKdziDQTXDWRDJdS8WyXvQtCDSSpsLP63bbdW
         cOiiI52GZVUebGyMsG2X5E6fYT0OIJFnxGAXUetZKDydkrF3Wl2/fb0Wxp0Z75TVQh6T
         giWorb/o+3LTFwvzrenWwbszz2vm7NxrLdr+hhPHn+acqPkmYagZ70swmgFq3rn/3E7w
         YSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690543975; x=1691148775;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bvt6gTVxDn+2sUGsn1CSbJgPH86R0eTVqQfCu4TXUDo=;
        b=KoQVHyTo8R7KA5vF8n5hj+m+W4KXySe1tcWobTrPmnWAXgQ4xPTRiwb8x5el5wjGBI
         D/5il8B1t/yKmFwFV1Rigtgul8pLKwyMCnNQxfHuW5vNQbgoQPaBFGufX1OX2ZoeDJ+9
         Qjpo89CMwEaX5rWorXfNZ6HuKF6VvngXcVbrEDvqzlg4VQ64LgXLs2iJ/fmPwoJ/w7K1
         i11+Me7E+QttBBQ+yeBcwqt3LJfrdNpJxzN4+fJIvN8M657QpuCzMaPOckw1UkftNaQZ
         hzeSADLKAqliD4Q6gnhqRRjr8BvmyKiHTx0bkFHxO5Hx/lXXGWPoVpvB+7q36weNY5h9
         POxg==
X-Gm-Message-State: ABy/qLZES55+3pfLH47hnV3UxQQOUgS2DDMNfw9YlBdSqY50/v+y+WA6
        dKBamVbJWJ422IKnv0DS2BFWKw==
X-Google-Smtp-Source: APBJJlGzFqci86oHnzgj2vDsZF3+rlLFEk6DPLtkPGOiNL5NezUh1WtcFdshRpGeLkVsg8nMnAV0bg==
X-Received: by 2002:a5d:554b:0:b0:317:6816:578c with SMTP id g11-20020a5d554b000000b003176816578cmr2003464wrw.5.1690543975603;
        Fri, 28 Jul 2023 04:32:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id y8-20020adffa48000000b003159d2dabbasm4575839wrr.94.2023.07.28.04.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 04:32:55 -0700 (PDT)
Message-ID: <75fb91cc-e505-7aa9-b90d-0b4d5c643b69@linaro.org>
Date:   Fri, 28 Jul 2023 13:32:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 00/50] Add support for sam9x7 SoC family
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org,
        andi.shyti@kernel.org, tglx@linutronix.de, maz@kernel.org,
        lee@kernel.org, ulf.hansson@linaro.org, tudor.ambarus@linaro.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linus.walleij@linaro.org, sre@kernel.org, p.zabel@pengutronix.de,
        olivia@selenic.com, a.zummo@towertech.it,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
        linux@armlinux.org.uk, durai.manickamkr@microchip.com,
        andrew@lunn.ch, jerry.ray@microchip.com, andre.przywara@arm.com,
        mani@kernel.org, alexandre.torgue@st.com,
        gregory.clement@bootlin.com, arnd@arndb.de, rientjes@google.com,
        deller@gmx.de, 42.hyeyoo@gmail.com, vbabka@suse.cz,
        mripard@kernel.org, mihai.sain@microchip.com,
        codrin.ciubotariu@microchip.com, eugen.hristev@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20230728102223.265216-1-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728102223.265216-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 12:22, Varshini Rajendran wrote:
> This patch series adds support for the new SoC family - sam9x7.
>  - The device tree, configs and drivers are added
>  - Clock driver for sam9x7 is added
>  - Support for basic peripherals is added
>  - Target board SAM9X75 Curiosity is added
> 
>  Changes in v3:
>  --------------
> 
>  - Fixed the DT documentation errors pointed out in v2.

That's too generic. What changed?

Best regards,
Krzysztof

