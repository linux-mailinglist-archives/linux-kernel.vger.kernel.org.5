Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB677BEC41
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378197AbjJIVEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378239AbjJIVE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:04:28 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CAC118;
        Mon,  9 Oct 2023 14:04:17 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c9b1e3a809so547235ad.2;
        Mon, 09 Oct 2023 14:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696885456; x=1697490256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GNBV7INRIgyeXhVbCD9dGMkZulR+GcLVmLyfrSfkaoA=;
        b=nCiq55DXPbJN3gs4EUUU2Ymj17VdxGVFLOVchQ1tFNw5eHGrqIfiwLrnuhvrIYW0H9
         QaCDAJTXKEcmYNtO/6Cj5NcQ3JmIBpXXltO91pGOfFhsknodDpPu4xhsHp9YQqmWDi/M
         Ic9MF0AlPfMZZPSmlPXaNiP0aCKrjYlmYEJ7P1Uwkk+g22a82q5NoY6ojCe0r17/jghE
         WUyriVXj2tOH8GHKKE+a4V77uC8vEPs4pRqAo/ncF6Sal5QLM3i5qbO1A6tYQp84rNBU
         eDAKOINuWviVDFJUwZgR/Z9mKoTG4/C1u8wja8v7R5CpKlCA0k/jY2i8meJu8nsg1MpS
         sJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696885456; x=1697490256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GNBV7INRIgyeXhVbCD9dGMkZulR+GcLVmLyfrSfkaoA=;
        b=DhhsBH3h+QxmOgpUn7DpOwOGyN7tAMquW+Ao9/BU/l8CPkns7RkBupV/FOo4DdUQbz
         REv6Lvf3IoVp6VoRL9diKH5efNftzfSIREHmvToSVwAZCN+3zRVnobzc/vCqzczmxnHn
         FyE7dzF0S+MvoMJ6U5VwORWV4mdmq4N+vczTNhfDN4mTjQKdnjWx5qa0Lcun4YbNp/+o
         zVce+vXefup66a+AUjSW5rzu1fmA0JrdtUjPcHz+F5hbvCg9Is+tXT683QBz/tq94dn+
         h2Jdq/4H9gU4lDbVK6+p1mg6kdqzzMsbW2zy6A6xpEaDPRv4zyIW2asRwkLfuSZKn3tj
         t7EA==
X-Gm-Message-State: AOJu0YwhJ43Ch1FH2q0nG030YP4i9sDXchks1ehEZ9VENyMGrvMnik6Y
        Oqh9/PTgYPdsD+HP6kxjiWw=
X-Google-Smtp-Source: AGHT+IHaP93TiFRG9ImFSB1oQ/7JMch7QSOZF4r13lzoqiI2LxHYDfc/gRmRbD1nyK47/RuC9jx4TA==
X-Received: by 2002:a17:90a:a393:b0:278:fa86:13d8 with SMTP id x19-20020a17090aa39300b00278fa8613d8mr13023890pjp.41.1696885456465;
        Mon, 09 Oct 2023 14:04:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id e2-20020a17090a630200b00277337818afsm6484585pjj.0.2023.10.09.14.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 14:04:15 -0700 (PDT)
Message-ID: <c13fd6a3-be6b-4970-9897-ed28b9a3cdeb@gmail.com>
Date:   Mon, 9 Oct 2023 14:04:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 02/16] net: phy: Remove the call to
 phy_mii_ioctl in phy_hwstamp_get/set
Content-Language: en-US
To:     =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
 <20231009155138.86458-3-kory.maincent@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231009155138.86458-3-kory.maincent@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 08:51, Köry Maincent wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 
> __phy_hwtstamp_set function were calling the phy_mii_ioctl function
> which will then use the ifreq pointer to call the hwtstamp callback.
> Now that ifreq has been removed from the hwstamp callback parameters
> it seems more logical to not go through the phy_mii_ioctl function and pass
> directly kernel_hwtstamp_config parameter to the hwtstamp callback.
> 
> Lets do the same for __phy_hwtstamp_get function and return directly
> EOPNOTSUPP as SIOCGHWTSTAMP is not supported for now for the PHYs.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

