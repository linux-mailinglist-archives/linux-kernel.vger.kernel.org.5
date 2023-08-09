Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADE577660A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjHIREj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjHIREi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:04:38 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD52E1FEF;
        Wed,  9 Aug 2023 10:04:37 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40fee14093dso38662321cf.1;
        Wed, 09 Aug 2023 10:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691600677; x=1692205477;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n3UWBOsGLjI41oeY0NYoiaxrTVRQ6EjTLgyJWihJ3T8=;
        b=mW/SxvXyACkMxyAJE2RTpm/hGd8MnuayDfhD2QjX6HHFx+RqU7oaIFZaUe9W+DBR+y
         VGskiRsO+tzcEeILVlVgRM58uIDNE2NXmAIzmT/4tM0djVEBTYdlklkazc7ogfuSTFDF
         NCslOinalTDH464Oxr4DM2skba8I5fpqqZIaeBQ4B27vcy02PS3p2Qp8kn4qTM19tTcx
         kPYNt7T8apBwjvXnwbxov2IoO/7kKjc05yHpn6e1nQgCKFus2L/Sf/iCdsWOkd2e2feK
         tboSPkK4TDKb6qRgOd6Fpn7hVBmuU25K0/Sg22U3nI7UriIiIoiS2PNrMBH3xJfLDA2Z
         /xBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691600677; x=1692205477;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n3UWBOsGLjI41oeY0NYoiaxrTVRQ6EjTLgyJWihJ3T8=;
        b=LJ5oeeQQgiH3hNZo35np7aiKI9moldnbC5CmrOHf6tw/vC8lLmyZe0eLkr021sBJur
         rvAMCj6/EP5BupLMDQk23BfnPro3nJsNDgyoOyUfpwXz4h/jSouRXyZK/xLiIY+RSMiu
         4gTELMFzwv42kNJeyhsvkbwvbxLR4btbO8hcd7qhMsJNsc7S/sFeU9XyLGqY/QhPCzEg
         nl5fnZZyhe2MvjhP+/Fxuczi9xTrZqIH9lNGv26ppRxfL46vdt7qOZur7s9gN2gcZitj
         rQModvA5kyGabSPc4RnImJ+n6pi9+mFLnhVIhXu0OEghAVnSRl8BYY1Sp8EpMa1Xycpj
         tHNg==
X-Gm-Message-State: AOJu0YwhNypoX1AhBA8W3OkXuktPBL/WpvJ4A6sAm4Kv5azs+lgFjFjS
        6U8efteDKaMmeX/J1GB7eZwS4eWlHrxTtg==
X-Google-Smtp-Source: AGHT+IGAeXb4ZgkK7l+R6nu4sgacHQYZZae+nIrQPIs23AiK8H4wMKvqbe8cxUkP0BHB0GV2U1hZ3g==
X-Received: by 2002:a05:622a:d2:b0:403:ecfe:2452 with SMTP id p18-20020a05622a00d200b00403ecfe2452mr3765299qtw.54.1691600676663;
        Wed, 09 Aug 2023 10:04:36 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id c29-20020ac86e9d000000b003ef2db16e72sm4164552qtv.94.2023.08.09.10.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 10:04:35 -0700 (PDT)
Message-ID: <6b738510-bda4-1517-20aa-135566bb98be@gmail.com>
Date:   Wed, 9 Aug 2023 10:04:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] net: phy: Don't disable irqs on shutdown if WoL is
 enabled
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Ioana Ciornei <ioana.ciornei@nxp.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        =?UTF-8?B?VXdlIEtsZWluZS1L4pScw4JuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Ioana Ciornei <ciorneiioana@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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
 <1e438a02-6964-ce65-5584-e8ea57a694bb@gmail.com>
 <ZNLIOEBXNgPOnFSf@shell.armlinux.org.uk>
 <20230809142155.4dtmnmmecaycbtum@LXL00007.wbi.nxp.com>
 <ZNOivVJ+G/sRiwai@shell.armlinux.org.uk>
 <20230809154418.hjkf43ndwfzretiy@LXL00007.wbi.nxp.com>
 <ZNO4RwYzZYUTu1uk@shell.armlinux.org.uk>
 <2f717c52-0ae5-4702-ab34-7ce0bffe8c86@lunn.ch>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <2f717c52-0ae5-4702-ab34-7ce0bffe8c86@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/2023 9:21 AM, Andrew Lunn wrote:
>> Thinking about this, I wonder whether we could solve your issue by
>> disabling interrupts when the PHY is probed, rather than disabling
>> them on shutdown - something like this? (not build tested)
>>
>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
>> index 3e9909b30938..4d1a37487923 100644
>> --- a/drivers/net/phy/phy_device.c
>> +++ b/drivers/net/phy/phy_device.c
>> @@ -3216,6 +3216,8 @@ static int phy_probe(struct device *dev)
>>   			goto out;
>>   	}
>>   
>> +        phy_disable_interrupts(phydev);
>> +
>>   	/* Start out supporting everything. Eventually,
>>   	 * a controller will attach, and may modify one
>>   	 * or both of these values
> 
> At some point, the interrupt is going to be enabled again. And then
> the WoL interrupt will fire. I think some PHY drivers actually need to
> see that WoL interrupt. e.g. the marvell driver has this comment:
> 
> static int m88e1318_set_wol(struct phy_device *phydev,
>                              struct ethtool_wolinfo *wol)
> {
> ....
>                  /* If WOL event happened once, the LED[2] interrupt pin
>                   * will not be cleared unless we reading the interrupt status
>                   * register. If interrupts are in use, the normal interrupt
>                   * handling will clear the WOL event. Clear the WOL event
>                   * before enabling it if !phy_interrupt_is_valid()
>                   */
> 
> So it seems like just probing the marvell PHY is not enough to clear
> the WoL interrupt.
> 
> Can we be sure that the other PHY has reached a state it can handle
> and clear an interrupt when we come to enable the interrupt? I think
> not, especially in cases like NFS root, where the interface will be
> put into use as soon as it exists, maybe before the other interface
> has probed.

Does it really make sense to have the PHY be interrupt driven for this 
specific board configuration if this causes so much hassle?
-- 
Florian
