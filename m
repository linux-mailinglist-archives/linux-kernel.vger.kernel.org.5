Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5042275752D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjGRHUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjGRHUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:20:12 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D222DBB;
        Tue, 18 Jul 2023 00:20:10 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb761efa7aso8515030e87.0;
        Tue, 18 Jul 2023 00:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689664809; x=1692256809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y1QDj1E+S2bjPPGCPFdmDsT3gCqQuKHXgAf2a6PrB3E=;
        b=XLpqkx/8N+f9aL66iAO4XAc89p9osxV7uu0ZqsyeRuMT4WOEnOlfUxj8GbFX4gEcY7
         cmQ5fYgkyqNDpwovIzaJAE3TYH7aSiAY5VG0meewNNzbaAUu5EaM8jadqiG9ZIxt8WkH
         Dz5Wa+qEBe6jQD09zPibdBeoGRnE/sTNzbn42rGQJ9PVOh1x5LzTEO4yedoXofgo5eFQ
         KuGIkdKxeINxScrJFBi22nrBsED9IknOsqSFxrCgMqZxiUdu7WgZs1LJuL63IoOJJuPq
         aH9XK5MpDV2L2h3Zd29U/vHUUcmr0Nb7ZNRI8TEZ+HH+Eak4QSPvsUrRq9Bx6pIjVCtR
         di/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689664809; x=1692256809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1QDj1E+S2bjPPGCPFdmDsT3gCqQuKHXgAf2a6PrB3E=;
        b=dCl9al/wqIJgMMLQmf/G4ZShB3EhMh5460HKo70/z9vooS+AmMMSj3bOEplbAKUXdA
         rJ3TXL4ClrRnA38yT1Sw2qmg5xxFm5BkODjE3kyG0kU+R4yjeC8TIUs4C7tUZeessv7V
         DCGktq6a0AF9ysLBVMzikS2sf+pfCgOYjxPMkqNSQHCJOn+zZi4jJvmLWCxW9DE+cTPM
         /hbZh0BtgeL8JNiVqf5NYc28YLm5rk1Fdaxtyqey/ib9DQ+qs8fC9I8MAYBngbb9TeqV
         fa3naM09x3klaJr8lyvjCrfZyUq0jHuA/ORZ6o/Ub0b6OnEgd9uG9MJU6oCPPu2lgpOk
         JmoA==
X-Gm-Message-State: ABy/qLbm+6DFjD9fBw8wFkgo541Wkz1mBvYWCOFGx+BDQvFhJS6Ed+v3
        gASzkwggWeapzUYx1FaPjZ8=
X-Google-Smtp-Source: APBJJlH+TWJF5L0ovMggt0/CS2enPlkz+KJw4saqvvcdbjYHJU4i8zA1AJzt6j7rP+36JcEKeZhfYg==
X-Received: by 2002:a05:6512:3a88:b0:4fb:925f:8be1 with SMTP id q8-20020a0565123a8800b004fb925f8be1mr11403669lfu.45.1689664808795;
        Tue, 18 Jul 2023 00:20:08 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id 22-20020ac24856000000b004fbb3e91a3fsm299048lfy.114.2023.07.18.00.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 00:20:08 -0700 (PDT)
Message-ID: <b5124f4a-6a7a-3fd9-32d6-e0690a45c7e8@gmail.com>
Date:   Tue, 18 Jul 2023 09:20:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V4] nvmem: add explicit config option to read old syntax
 fixed OF cells
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-rtc@vger.kernel.org,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20230403225540.1931-1-zajec5@gmail.com>
Content-Language: en-US
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20230403225540.1931-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4.04.2023 00:55, Rafał Miłecki wrote:
> Binding for fixed NVMEM cells defined directly as NVMEM device subnodes
> has been deprecated. It has been replaced by the "fixed-layout" NVMEM
> layout binding.
> 
> New syntax is meant to be clearer and should help avoiding imprecise
> bindings.
> 
> NVMEM subsystem already supports the new binding. It should be a good
> idea to limit support for old syntax to existing drivers that actually
> support & use it (we can't break backward compatibility!). That way we
> additionally encourage new bindings & drivers to ignore deprecated
> binding.
> 
> It wasn't clear (to me) if rtc and w1 code actually uses old syntax
> fixed cells. I enabled them to don't risk any breakage.

is there any chance I can have this accepted / pushed, please?

It's a tiny optimization and it makes sure people don't use deprecated
syntax with new drivers.

I also noticed this will probably let me drop an unclear and
non-intuitive no_of_node config option.
