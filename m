Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5967E793170
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239816AbjIEV6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbjIEV6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:58:41 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CC18E;
        Tue,  5 Sep 2023 14:58:38 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c35ee3b0d2so1773795ad.2;
        Tue, 05 Sep 2023 14:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693951117; x=1694555917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=glz/lbCjZt/EKCNSdZIBsRWdTkU9hS+Uh+QSz7JjNuo=;
        b=m4vWQwWD1Tk79TBCE052fONxZV5q4HVXt8nj3vhi8Pjig7xPIrrrCsWKc7VvI/VMFH
         9ule91ijn3BPrlSWD/cXHdgwiyGbcuKFodJ3T+qwcLi9pENtED+o1FEYqGG0c5SZuq45
         gfmPHp5fXxPP9aW/wXNeRGobMqNsuf8sSYdRYMDGMhzDMdl/bJx015mqhkrDzPlNoKjw
         HYpaO09/MiExKTwCDjcVfPGjpc0YQwJ0TBh2Cc7a35hD0G0o01EwTdI9VjDLM4At9R4u
         xW/J9pHfsKX6ekoKCshTcWf/032bmvkAIJJ/vi2bJ9d/XOX0T1cnTXgEGEnpihvtP7Lv
         qQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693951117; x=1694555917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=glz/lbCjZt/EKCNSdZIBsRWdTkU9hS+Uh+QSz7JjNuo=;
        b=OrY1kFWxE6xHhopoo9i9cv8d8AdkX9uAKPHcJCcuIZk37WNOf0W7RQRItpT6w5/t4d
         Wpnn5si3ggnDpmj4/fO2BpkF5wpTbWIDQjHryBQYnfVFXoqpE4jxXpFkicIkQZSvKwO5
         i/p4/PDOykyitKncZ75T4tvdIRfvhqLl0yV2a/e5U5/3F86xGnS9BtfosnePeqTm0r/y
         qyFhmJ9W0hp45yVyeZCJR34seslkBaW8OqUhwTXD1l8o0cUwcmpESMducingEfm1mQOF
         cvSZwWcoYUwujIzeqXLHp9g0OS6NqTqCgjLvp+KYIzVW2eAEFxT2e9/akGGvIZcjCQgl
         rbew==
X-Gm-Message-State: AOJu0YxIIWVPZSaG6ewF+aBwzPE5FH6qRvvNTZRK/H86SWo6djUokIbl
        H74btcUouuyoNKvVuQwgVLM=
X-Google-Smtp-Source: AGHT+IGvt93IFdDvZARvS5ILYNq/J9i3Hq9RvsyqKjTtYbwPRbnJT/mv0J9W5Ch33/5kzSINnUN7mg==
X-Received: by 2002:a17:902:ce90:b0:1c0:98fe:3677 with SMTP id f16-20020a170902ce9000b001c098fe3677mr13841751plg.56.1693951117367;
        Tue, 05 Sep 2023 14:58:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u5-20020a17090282c500b001b9df8f14d7sm9686454plz.267.2023.09.05.14.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 14:58:36 -0700 (PDT)
Message-ID: <1a651dc6-d0cc-a406-f365-03dddea3928d@gmail.com>
Date:   Tue, 5 Sep 2023 14:58:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [net v4] net: phy: Provide Module 4 KSZ9477 errata (DS80000754C)
Content-Language: en-US
To:     Lukasz Majewski <lukma@denx.de>, Tristram.Ha@microchip.com,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230905093315.784052-1-lukma@denx.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230905093315.784052-1-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/23 02:33, Lukasz Majewski wrote:
> The KSZ9477 errata points out (in 'Module 4') the link up/down problems
> when EEE (Energy Efficient Ethernet) is enabled in the device to which
> the KSZ9477 tries to auto negotiate.
> 
> The suggested workaround is to clear advertisement of EEE for PHYs in
> this chip driver.
> 
> To avoid regressions with other switch ICs the new MICREL_NO_EEE flag
> has been introduced.
> 
> Moreover, the in-register disablement of MMD_DEVICE_ID_EEE_ADV.MMD_EEE_ADV
> MMD register is removed, as this code is both; now executed too late
> (after previous rework of the PHY and DSA for KSZ switches) and not
> required as setting all members of eee_broken_modes bit field prevents
> the KSZ9477 from advertising EEE.
> 
> Fixes: 69d3b36ca045 ("net: dsa: microchip: enable EEE support") (for KSZ9477).
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Confirmed disabled EEE with oscilloscope.
> Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

