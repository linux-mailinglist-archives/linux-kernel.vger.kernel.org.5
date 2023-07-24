Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E4375FADD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjGXPfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjGXPfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:35:18 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B05B7;
        Mon, 24 Jul 2023 08:35:17 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666e6541c98so4256006b3a.2;
        Mon, 24 Jul 2023 08:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690212917; x=1690817717;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SL6yND5mG8rB1Q/PAlTBUsUBz7nYVLDoCOtcQa0d2jY=;
        b=ekVFd7GOf7pP7rOcuuayFRfZVoFWBPofzsTOC5EMRT6p8gLVF579AphjizhEuH/i+k
         Y1Bv6oFFz5F+ZPgJQfqQFUt9Dtt2g0F5ie8EClZC4MIP+gkwC/DslZP3Dzy4Ic9zUsf+
         +smD6Ryfyg+eNVemPeMQyvyaUJjFumnSZtypYuQFX7dm+2386CMYv5MJW/odi8ox6I3d
         s+GGTrr3Z0ShpIDh9qhMe0M4FQrVCUe0ei7WnBmfhZDDZDDZXPdn0ZIdRZrNq3KEPdNn
         e5k3pXLn4o0tRckpfNVTCut4+yUWzfG77p/toQHlBlvOZzyX8nsjRHO8dMmuemRPv1A9
         I7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690212917; x=1690817717;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SL6yND5mG8rB1Q/PAlTBUsUBz7nYVLDoCOtcQa0d2jY=;
        b=X4ZkxnLHOMI5y2+OxjvdYpiHlKWvECcW27H3thdLuWyl+PGwNOrnYyPqF3agvXVRvh
         GwPkF6U55Mu8IXoxGq7QAdcUKzmQjPImW7RRvvcK70/0QpIYfgwlGBZAmxQO//IUwOWQ
         o7asyKbRwpLq6Arbuc3jWHDi7CWFR+ZVztbFzgSul0L3mb4y/ngNMF/KSAV7eZc6UmoG
         pfsWlJa95+5B/I86f2unkOP78p/WoYr9J1cg94Foln+t5+1/Kzw9YSThckrxwRszh8dt
         ls870Oupnt0tRyk9Ir2QeoCFFacWClOS5NAxtE16D/03NZusKm016rL6bR2P1Ul7KoMG
         YrEA==
X-Gm-Message-State: ABy/qLYRgkw8OXyUEPpBCHxFUO3RDf0LsMxGRS3HZIRREzHvmPaG3bCk
        GBU6FBl1QIX7FIqvpHwfesc=
X-Google-Smtp-Source: APBJJlF+Mbf05zfWSsQ6Xtgd5LvdTBqC+q5t1f4aBvSCxFAonHhBNwdvgq7jO166eA3y6LApHwKqLw==
X-Received: by 2002:a05:6a20:734c:b0:122:c6c4:36b1 with SMTP id v12-20020a056a20734c00b00122c6c436b1mr12757046pzc.4.1690212916664;
        Mon, 24 Jul 2023 08:35:16 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:4a48:acad:6c64:8815:b48d? ([2600:8802:b00:4a48:acad:6c64:8815:b48d])
        by smtp.gmail.com with ESMTPSA id v1-20020aa78501000000b00682704663fcsm7851102pfn.191.2023.07.24.08.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 08:35:15 -0700 (PDT)
Message-ID: <cf089185-4696-40ce-42c9-df2eea336d05@gmail.com>
Date:   Mon, 24 Jul 2023 08:35:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 net-next] net: phy: smsc: add WoL support to
 LAN8740/LAN8742 PHYs
Content-Language: en-US
To:     Tristram.Ha@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1689900053-13118-1-git-send-email-Tristram.Ha@microchip.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <1689900053-13118-1-git-send-email-Tristram.Ha@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/2023 5:40 PM, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <Tristram.Ha@microchip.com>
> 
> Microchip LAN8740/LAN8742 PHYs support basic unicast, broadcast, and
> Magic Packet WoL.  They have one pattern filter matching up to 128 bytes
> of frame data, which can be used to implement ARP or multicast WoL.
> 
> ARP WoL matches any ARP frame with broadcast address.
> 
> Multicast WoL matches any multicast frame.
> 
> Signed-off-by: Tristram Ha <Tristram.Ha@microchip.com>

This looks good to me, just one suggestion but which you can implement 
later, it would be nice to have a pm_wakeup_event(&phydev->mdio.dev, 0) 
in order to have the PHY device accounted for any wake-up event. You can 
do that when you do the initial acknowledgement of any wake-up 
interrupts in your .config_init callback.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
