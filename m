Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F0A7D2BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbjJWHw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjJWHwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:52:24 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E55DB;
        Mon, 23 Oct 2023 00:52:21 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9b6559cbd74so448543066b.1;
        Mon, 23 Oct 2023 00:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698047539; x=1698652339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g6Cypa6bu6TTcvPFXIDJ6BPmvosK1akmEJBTHk/FsCg=;
        b=m+Vm+KF8x49WhnH5d+oa2CzX/w0ZxW5LwX4uqCcSLVKFaP84kSjxYoQs62TeKTCins
         mrv3Ujd4cDmeCuqSqLhb410vrei6SU9sOzXvi7g+0wzv6WCV65rL2MNlj6dQFsp/h9Yt
         Yd6Inw7cgCaopkgwe3S/w9f8RPdO+2/WcETztpio6n+dUkauuRywo0FAon3w3JEoY0XM
         P7eEveSANsgijMCSojvMmNpXblF0+jAZGdrt8oBosxKCMKkWIg828DjhHpZW2XG4Zcyd
         Z9vqiqcDwjyxl2p2pWWVrOVp3TaTwKqjpInlz23AUgGLF76gDe0gVwakuQLwUL9mvLVs
         TzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698047539; x=1698652339;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6Cypa6bu6TTcvPFXIDJ6BPmvosK1akmEJBTHk/FsCg=;
        b=UEXxpCyQFKojputI+SAtKK3hItkuOB/rysLddM1JHjyY8Saz7a7mvU1hbNyriHLphp
         pqom6UC5DXGqrwPJ1oPwbYM8El8pjxM7qIfLCoImPILiCt/lg5Sl5dy+hfhYSHRAiWIF
         by22cQTDldipKIjq2YIMbwgAFnz8hmK72OMuHZxWW3RPo606sl69XK1lDxqtG9iE3XMo
         aWv7FqYYRcnLnLHIKNLPajHyks5PLuIdQmZMep05u2S5ToZaVwVawIpP/ZeTxIWGRTvW
         GC+lHUhi8xtLzVjucdoBvif6pvlb/8YgACgHkkCugkW6fHdeD5GD2xolNU+CzArmIel/
         Hskw==
X-Gm-Message-State: AOJu0Yw7X2FsN7amvA1AEJL9zSzQDQGzZAQ4kALXob1kfRYf5jgpUkPM
        8sAHSiOkwRBqhHKhanhxcyqMZRUqook=
X-Google-Smtp-Source: AGHT+IHtJAuSOzmNO28rkIoisDaxfCdKDIe8ch7u6DIB7vkf9LnEipLpYTowRfcWAs2+gYvejnGBAA==
X-Received: by 2002:a17:907:a089:b0:9ad:7d5c:3d4b with SMTP id hu9-20020a170907a08900b009ad7d5c3d4bmr7508046ejc.35.1698047539089;
        Mon, 23 Oct 2023 00:52:19 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c1ff:8700:54bd:2e8b:2e0a:b78d? (dynamic-2a01-0c23-c1ff-8700-54bd-2e8b-2e0a-b78d.c23.pool.telefonica.de. [2a01:c23:c1ff:8700:54bd:2e8b:2e0a:b78d])
        by smtp.googlemail.com with ESMTPSA id hb13-20020a170906b88d00b009c46445fcc7sm6258738ejb.33.2023.10.23.00.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 00:52:18 -0700 (PDT)
Message-ID: <c23dcdb0-f493-453d-82b9-b498f4d3c88b@gmail.com>
Date:   Mon, 23 Oct 2023 09:52:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: phy: fixed link 1000 or 100 set with autoneg off
To:     "Jia, Fang" <fang.jia@windriver.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <d7aa45f8-adf8-ff9a-b2c4-04b0f2cc3c06@windriver.com>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <d7aa45f8-adf8-ff9a-b2c4-04b0f2cc3c06@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.10.2023 09:01, Jia, Fang wrote:
> Hi Experts,
> 
> We use NXP LS1046 board and face an issue about the eth interface speed.
> 
> 1) Scenario
> 
> we set fixed link 1000Mb/s in device tree.
> 
> However, after we set the auto-neg off, then the eth1's speed changed to 10M and Duplex changed to Half.
> The value of /sys/class/net/eth1/speed is 10 and /sys/class/net/eth1/duplex is half
> 
Why do you set aneg to off? Leave aneg on, that's the only supported
mode in swphy. 1000Mbps requires aneg anyway per standard.

> 2) Log is as following.
> 
> # ifconfig eth1 up
> # ethtool eth1
> Settings for eth1:
>         Supported ports: [ MII ]
>         Supported link modes:   1000baseT/Full
>         Supported pause frame use: Symmetric Receive-only
>         Supports auto-negotiation: Yes
> 
>         Supported FEC modes: Not reported
> 
>         Advertised link modes:  1000baseT/Full
>         Advertised pause frame use: Symmetric Receive-only
> 
>         Advertised auto-negotiation: Yes
>         Advertised FEC modes: Not reported
>         Speed: 1000Mb/s
>         Duplex: Full
>         Port: MII
>         PHYAD: 1
>         Transceiver: internal
>         Auto-negotiation: on
>         Supports Wake-on: d
>         Wake-on: d
>         Current message level: 0xffffffff (-1)
>                                drv probe link timer ifdown ifup rx_err tx_err tx_queued intr tx_done rx_status pktdata hw wol 0xffff8000
>         Link detected: yes
> 
> # ethtool -s eth1 autoneg off
> # ethtool eth1
> Settings for eth1:
>         Supported ports: [ MII ]
>         Supported link modes:   1000baseT/Full
>         Supported pause frame use: Symmetric Receive-only
>         Supports auto-negotiation: Yes
>         Supported FEC modes: Not reported
>         Advertised link modes:  1000baseT/Full
>         Advertised pause frame use: Symmetric Receive-only
>         Advertised auto-negotiation: No
>         Advertised FEC modes: Not reported
>         Speed: 10Mb/s
>         Duplex: Half
>         Port: MII
>         PHYAD: 1
>         Transceiver: internal
>         Auto-negotiation: off
>         Supports Wake-on: d
>         Wake-on: d
>         Current message level: 0xffffffff (-1)
>                                drv probe link timer ifdown ifup rx_err tx_err tx_queued intr tx_done rx_status pktdata hw wol 0xffff8000
>         Link detected: yes
> 
> 3) After code tracing, we found that:
> 
> phy_state_machine()
>     state PHY_RUNNING: phy_check_link_status()
>         phy_read_status()
>             genphy_read_status()
>                 genphy_read_status_fixed()
> 
> In genphy_read_status_fixed(), the speed and duplex changed.
> It seems like the bmcr value is always 0x1000 from swphy_read_reg().
> 
> After revert the commit 726097d6d6d(net: phy: improve auto-neg emulation in swphy), then the Speed and Duplex shown comes back to 1000M and Full.
> 
> Could you please take a look it ? Can we revert this commit, is there any side impact ?
> 
> Best Regards,
> Fang

