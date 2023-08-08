Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1429D774D8F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjHHV7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjHHV7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:59:45 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6216C10C6;
        Tue,  8 Aug 2023 14:59:45 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686fc0d3c92so4241164b3a.0;
        Tue, 08 Aug 2023 14:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691531985; x=1692136785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Owbz00M7iohX87g/2/5u/phT80tkAEnf0f7QG4IA1+Q=;
        b=I7ZVnBQ9VbFL0XpGG5/qpEui8bjlyYuPsH7pcbu+dXyu9Z9zrtbbYXJ/8yBfIIDyAZ
         LTFyZxn3bj/OdwfhWYbHswt6QB70AeUH3bZQrDUn6h70XaGsLjXP8+m8nU3PYkcbOysj
         8MagYaqFM3mOnr/QCAHAZn0mX1U/VOLKic+gSwiuLafuaKKVT3FGVRTXxR91rOzEHd1W
         g9r7vSLRAChfPIESSdXD1nlj3V6txBXJG0cediSlFTRyQP8pfcFEbn5yQhV3kG8jNQEy
         I2nnIuM9hsQjReB4gdkn3XuNPVfBQJjiJvHq/jn9u0dM5d6sr8swGtYB2cpEEpbpJjLp
         iVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691531985; x=1692136785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Owbz00M7iohX87g/2/5u/phT80tkAEnf0f7QG4IA1+Q=;
        b=hb7+58MBHN31EjLEEqH5uy+3rHmlEBaUgRhSsqcfIcfO6DzwnofODs1dnn1tbJSEKu
         wZ5rtvxP+x5Pv/sWwUvJsPydBbuBNZ5yZ0lorGk6bfrfm5h9+EKNtL+BbizmD3gGcB7n
         xSKdL+GMy87dfLD2Fo1uVyiP134V6O1fJDB/OmIzHggRQ5peH/vT7K/fSd5YreuGyWqb
         bq3sw0GzCdI5CHxJV56T9c+/wL2BX7VoaAVtkyKRUxSzCjnFEs6a1gZDoYbcR6uzd5pT
         2JPRka1FKE9XOQ+seWOYnUSJdCzwFmvvhyVG3H0nL/4Z9/XG1LxIlZj8u2o22Xuwzo2f
         skUA==
X-Gm-Message-State: AOJu0Yx74mBH3CwnTnOWpFaUG4BddNPMQefueXjj4MbRVDvho1ZQoUXc
        YjWFr92XSW8jdSZP4zS96uU=
X-Google-Smtp-Source: AGHT+IFCWeA5cJ0ieW2bjEh18QtQl5AGXERxX4enVNqI9WO93Ft02oKurtYfNmG5XGwrfF7rHunt4w==
X-Received: by 2002:a05:6a00:9a6:b0:666:b254:1c9c with SMTP id u38-20020a056a0009a600b00666b2541c9cmr900956pfg.27.1691531984757;
        Tue, 08 Aug 2023 14:59:44 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id n26-20020a62e51a000000b0068338b6667asm8514501pff.212.2023.08.08.14.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 14:59:44 -0700 (PDT)
Message-ID: <1e438a02-6964-ce65-5584-e8ea57a694bb@gmail.com>
Date:   Tue, 8 Aug 2023 14:59:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] net: phy: Don't disable irqs on shutdown if WoL is
 enabled
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Ioana Ciornei <ciorneiioana@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Andre Edich <andre.edich@microchip.com>,
        Antoine Tenart <atenart@kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Divya Koppera <Divya.Koppera@microchip.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Kresin <dev@kresin.me>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Michael Walle <michael@walle.cc>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Nisar Sayed <Nisar.Sayed@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Willy Liu <willy.liu@realtek.com>,
        Yuiko Oshino <yuiko.oshino@microchip.com>
References: <20230804071757.383971-1-u.kleine-koenig@pengutronix.de>
 <20230808145325.343c5098@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230808145325.343c5098@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/23 14:53, Jakub Kicinski wrote:
> On Fri,  4 Aug 2023 09:17:57 +0200 Uwe Kleine-König wrote:
>> Most PHYs signal WoL using an interrupt. So disabling interrupts breaks
>> WoL at least on PHYs covered by the marvell driver. So skip disabling
>> irqs on shutdown if WoL is enabled.
>>
>> While at it also explain the motivation that irqs are disabled at all.
>>
>> Fixes: e2f016cf7751 ("net: phy: add a shutdown procedure")
>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> What do we do with this one? It sounded like Russell was leaning
> towards a revert?

Yes, though I believe this will create a different kind of regression 
for what Iona was addressing initially. Then it becomes a choice of 
which regression do we consider to be the worst to handle until 
something better comes up.

Russell what are your thoughts?
-- 
Florian

