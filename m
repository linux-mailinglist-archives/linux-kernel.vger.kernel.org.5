Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6D67763FC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbjHIPgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjHIPgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:36:38 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DD635AE;
        Wed,  9 Aug 2023 08:36:06 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686efa1804eso5078445b3a.3;
        Wed, 09 Aug 2023 08:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691595329; x=1692200129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IvGzFVP5SQwSC9rGu9WLVcEiDDZIn4yvZiZN1ERf4Ug=;
        b=FoHqy7RkWcAoLCzcl9xmRGPvWfsrJK8FWyXmnpbSA53y4WapOColhNjTmv+rbtvMYD
         paTn3K3IFBktLPu4XQy9OzoqtXn6ucYa0+m2wOBo76GlfecgmYBlZMs4oGJ47e5Qo15z
         +2yAiXkpjecu0sQzZwJgQSLtYrAbYtk9RVNT61WdS2lmQTGx1OcsQJIWMWH72bz0mtwe
         J2VcJTNLvE50pwL4UIbQ1QlMqP9xPzSgPl66rC9k8CSgV2KBB+LxeR20Ms3TwG63JToA
         NLeMgBbouWrr7RoT1zKv7e0/6/uXdpM/s62fm+/P2hyJxpKSR55DbLehjqrLv/J6K6E2
         F8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691595329; x=1692200129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvGzFVP5SQwSC9rGu9WLVcEiDDZIn4yvZiZN1ERf4Ug=;
        b=K5vLgQnHl2qdex8H72R6lNIA5k2Y8S6IvE0Qy3ftv+5dZ0oExnUo56MN9BM6bAeOVb
         4XU2XTCu53Taki01AlV4R2rNIbr+CVuAHGI9/4n/+VbXDvk6qqK2JVkXGYjR5oNqq7EF
         mT5wQHBNSHFSldQ2o8Y7QXEWCmmN4musdJ27eSvgxYI9Hk2RwDsFH5JkjNcWlQZML0yT
         r6CfrT/KUpwGDW+LlOrhtOQ9o6nZSPBI7fCOeRuJ0tyxSiQOZKaA5utTDoclidthtOuL
         lJX0r2V9WxUw84qBFrDz9GA8dPKrVo5eJ8hsjr8sggMLw9CxYXI/HVzG6SSFSQqB7Or4
         Xphg==
X-Gm-Message-State: AOJu0YwfmMtehxKQwQsvRqXtTVXdjz6UK6B6/OR+9IkzaYzP0PyPZKiU
        J5Y3Da7rz3vh4pQvkaUND2Q=
X-Google-Smtp-Source: AGHT+IETM3lKazpfiLZKLqnU7PJtHu54GpTMBDuhpz3YmKRR/s6WiFe8fxlNhSRNxlufq+NiQSO3tw==
X-Received: by 2002:a17:903:1cd:b0:1b8:41d4:89f with SMTP id e13-20020a17090301cd00b001b841d4089fmr2943008plh.4.1691595329075;
        Wed, 09 Aug 2023 08:35:29 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:4a48:3c29:7d43:1531:9375? ([2600:8802:b00:4a48:3c29:7d43:1531:9375])
        by smtp.gmail.com with ESMTPSA id v3-20020a170902d68300b001b86dd825e7sm11370829ply.108.2023.08.09.08.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 08:35:28 -0700 (PDT)
Message-ID: <50f0b253-8eae-a4bd-0c5d-d23b020ce8df@gmail.com>
Date:   Wed, 9 Aug 2023 08:35:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] net: phy: Don't disable irqs on shutdown if WoL is
 enabled
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Ioana Ciornei <ciorneiioana@gmail.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
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
References: <20230809135702.4dencx4ikij7d33y@skbuf>
Content-Language: en-US
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230809135702.4dencx4ikij7d33y@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/2023 6:58 AM, Vladimir Oltean wrote:
> Hi Uwe,
> 
> (I hope the threading won't be broken)
> 
> On Fri, Aug 04, 2023 at 09:17:57AM +0200, Uwe Kleine-König wrote:
>> Most PHYs signal WoL using an interrupt. So disabling interrupts breaks
>> WoL at least on PHYs covered by the marvell driver. So skip disabling
>> irqs on shutdown if WoL is enabled.
>>
>> While at it also explain the motivation that irqs are disabled at all.
>>
>> Fixes: e2f016cf7751 ("net: phy: add a shutdown procedure")
>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> ---
>> Hello,
>>
>> while I'm not sure that disabling interrupts is a good idea in general,
>> this change at least should fix the WoL case. Note that this change is
>> only compile tested as next doesn't boot on my test machine (because of
>> https://git.kernel.org/linus/b3574f579ece24439c90e9a179742c61205fbcfa)
>> and 6.1 (which is the other kernel I have running) doesn't know about
>> .wol_enabled. I don't want to delay this fix until I bisected this new
>> issue.
>>
>> Assuming this patch is eligible for backporting to stable, maybe point
>> out that it depends on v6.5-rc1~163^2~286^2~2 ("net: phy: Allow drivers
>> to always call into ->suspend()"). Didn't try to backport that.
>>
>> Best regards
>> Uwe
>>
>>   drivers/net/phy/phy_device.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
>> index 61921d4dbb13..6d1526bdd1d7 100644
>> --- a/drivers/net/phy/phy_device.c
>> +++ b/drivers/net/phy/phy_device.c
>> @@ -3340,6 +3340,15 @@ static void phy_shutdown(struct device *dev)
>>   	if (phydev->state == PHY_READY || !phydev->attached_dev)
>>   		return;
>>   
>> +	/* Most phys signal WoL via the irq line. So for these irqs shouldn't be
>> +	 * disabled.
>> +	 */
>> +	if (phydev->wol_enabled)
>> +		return;
>> +
>> +	/* On shutdown disable irqs to prevent an irq storm on systems where the
>> +	 * irq line is shared by several devices.
>> +	 */
>>   	phy_disable_interrupts(phydev);
>>   }
>>   
>> -- 
>> 2.40.1
>>
>>
> 
> I think the idea is not bad and something along these lines might be the
> way to go, but I don't think it works (as currently implemented, and
> tested by me, prints below).
> 
> Upon a quick search, phydev->wol_enabled is only set from phy_suspend(),
> and phy_suspend() isn't invoked from the ethnl_set_wol() call stack.

You are right, this was an ill advised suggestion from my side here. In 
principle however we need to have something like this in the shutdown 
routine to have this patch work:

        struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
        struct net_device *netdev = phydev->attached_dev;
        int ret;

        phy_ethtool_get_wol(phydev, &wol);
        phydev->wol_enabled = wol.wolopts || (netdev && 
netdev->wol_enabled);

	if (!phydev->wol_enabled)
		return;

this does make me wonder whether Uwe tested with a prior system 
suspend/resume cycle before shutting down?
-- 
Florian
