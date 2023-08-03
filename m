Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A3476F1C8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjHCSY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjHCSY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:24:26 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1962335B5;
        Thu,  3 Aug 2023 11:24:11 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7659cb9c42aso94650885a.3;
        Thu, 03 Aug 2023 11:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691087050; x=1691691850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gn00n1RM7gcqyxJWa9NJ2kV1Wz79G/AfHyE5VlUHAmk=;
        b=qqsyobekVpA/cX7tWNtxtm+O/XtRi/Rn7tKxaHXxL5j/qhW/ydEnUmWPx8TLk+zyAQ
         j9vX6E7uW7x4nhJMk86/tZTn9NnmwtIpkFcs53XlUvwo7qteHHprnDuyWHKM3VqAjNoW
         OfxO210OTsgCuYDOLJN5gj1jSWVOrwvMspErJJAw1KoV2VTWD74h0sn3Xy4W0wjoN1u2
         ACbponGglrHlskHjwpr+shQz44BMmeDrxBN22xnvFGMUtx/iTFIf1jkuY5CBobnaYUom
         OS2Yt99PwUlDC3jOtKTCnf0oKZwFy2c4tZ36TRTLrGEaFhiAc9zgRO2ta6PFrfpbc+jH
         lTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691087050; x=1691691850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gn00n1RM7gcqyxJWa9NJ2kV1Wz79G/AfHyE5VlUHAmk=;
        b=bUGBlXN0oi57KxUrJkMytVMV8F+BLKIBZTSdChRe0FgPFIpunAFTmAaGc68fEenLDH
         biQwdQRcWuHMBDxX8pPokfnSGuljtzD5beBL29htWJS8VFXC0zNnYKWvGKmGtcV0CbHw
         V4RfZ9RML1FyBEiL4eyKO7UxWiluF7DHFuy6LjDPIT3LbU/OpxoJIBWAvFixjlkZVohR
         RdPKBP6292CJuJ6R8LEnagJxLRH82YktBd3QA4BG+gHGHUxhOsSvWDhNUoU214qLJMJl
         TEEcFaoo+YfGcdpR4GAscIp8A3aq1s9OKEMwegHHlkyyULpWelRIOZCfjZo3dcdOT9Up
         OQLA==
X-Gm-Message-State: ABy/qLYF+JdqkQxc3qb/ATn6l+V1UL4dODDyH0CmFbcUyPJ6NasBzZEc
        0PKuurT89yukYiQG1SLbfwQ=
X-Google-Smtp-Source: APBJJlE9uoKVez1Q2a3u8ej+67xKgAGLbMqD0fRtZccCZunweKKz1ri7s3lwBTc8mXHGItXtKNnulA==
X-Received: by 2002:a37:9301:0:b0:767:2a66:b792 with SMTP id v1-20020a379301000000b007672a66b792mr17871582qkd.42.1691087050137;
        Thu, 03 Aug 2023 11:24:10 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id l7-20020a0ce507000000b0063d2ea55018sm80161qvm.125.2023.08.03.11.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 11:24:09 -0700 (PDT)
Message-ID: <7e365fa4-7a50-382c-5a99-288a417a82a7@gmail.com>
Date:   Thu, 3 Aug 2023 11:24:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v2 02/19] net: phy: add a shutdown procedure
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Ioana Ciornei <ciorneiioana@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
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
References: <20201101125114.1316879-1-ciorneiioana@gmail.com>
 <20201101125114.1316879-3-ciorneiioana@gmail.com>
 <20230803181640.yzxsk2xphwryxww4@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230803181640.yzxsk2xphwryxww4@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/23 11:16, Uwe Kleine-König wrote:
> Hello,
> 
> this patch became commit e2f016cf775129c050d6c79483073423db15c79a and is
> contained in v5.11-rc1.
> 
> It broke wake-on-lan on my NAS (an ARM machine with an Armada 370 SoC,
> armada-370-netgear-rn104.dts). The used phy driver is marvell.c. I only
> report it now as I just upgraded that machine from Debian 11 (with
> kernel 5.10.x) to Debian 12 (with kernel 6.1.x).
> 
> Commenting out phy_disable_interrupts(...) in v6.1.41's phy_shutdown()
> fixes the problem for me.
> 
> On Sun, Nov 01, 2020 at 02:50:57PM +0200, Ioana Ciornei wrote:
>> In case of a board which uses a shared IRQ we can easily end up with an
>> IRQ storm after a forced reboot.
>>
>> For example, a 'reboot -f' will trigger a call to the .shutdown()
>> callbacks of all devices. Because phylib does not implement that hook,
>> the PHY is not quiesced, thus it can very well leave its IRQ enabled.
>>
>> At the next boot, if that IRQ line is found asserted by the first PHY
>> driver that uses it, but _before_ the driver that is _actually_ keeping
>> the shared IRQ asserted is probed, the IRQ is not going to be
>> acknowledged, thus it will keep being fired preventing the boot process
>> of the kernel to continue. This is even worse when the second PHY driver
>> is a module.
>>
>> To fix this, implement the .shutdown() callback and disable the
>> interrupts if these are used.
> 
> I don't know how this should interact with wake-on-lan, but I would
> expect that there is a way to fix this without reintroducing the problem
> fixed by this change. However I cannot say if this needs fixing in the
> generic phy code or the phy driver. Any hints?

It depends upon what the PHY drivers and underlying hardware are capable 
and willing to do. Some PHY drivers will shutdown the TX path completely 
since you do not need that part to receive Wake-on-LAN packets and pass 
them up to the PHY and/or MAC Wake-on-LAN matching logic. This would 
invite us to let individual PHY drivers make a decision as to what they 
want to do in a .shutdown() routine that would then need to be added to 
each and every driver that wants to do something special. In the absence 
of said routine, you could default to calling phy_disable_interrupts() 
unless the PHY has WoL enabled?

phydev::wol_enabled reflects whether the PHY and/or the MAC has 
Wake-on-LAN enabled which could you could key off to "nullify" what the 
shutdown does.

>   
>> Note that we are still susceptible to IRQ storms if the previous kernel
>> exited with a panic or if the bootloader left the shared IRQ active, but
>> there is absolutely nothing we can do about these cases.
> 
> I'd say the bootloader could handle that, knowing that for some machines
> changing the bootloader isn't an option.

There is also the case of the boot loader not touching any 
PHY/MAC/networking and just booting as fast as possible to the kernel. 
It really becomes a problem that can be distributed against multiple SW 
agents to solve it, though clearly the kernel could do it too, so why 
not keep it there I guess.
-- 
Florian

