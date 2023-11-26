Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708B37F9098
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 02:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjKZBAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 20:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKZBAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 20:00:35 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AA911D;
        Sat, 25 Nov 2023 17:00:41 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7788ebea620so163424085a.3;
        Sat, 25 Nov 2023 17:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700960441; x=1701565241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OPmqfVyZpnYiTiJ+2/oFOK4Ay4l7x7Il+va2uiOCXqE=;
        b=nY3QZKmF4DWZwX+0WU+UeXuh2IdI18axTZ//oshuJtqusfeJiUZHQYw2LHZrwq6scv
         0j/Tf/VVCzvHsdv0WPpC3EtmGq5y3jh4hnniOz1HP9p08FVDGm4hKpsPo5lA5woJ/+BH
         OIQf2dOYasp8d9wioXebyO0F4EPOHn3+Ahw/OLim1/wC0IKEQqNJRzuddC4ayhtB11ff
         ieUMYMGO3hr/VeLaE3DJzbqeMo88i35iP1MI0W/VjsuG59YQaWlkAsJjbpd2Db/h3pd4
         2eLB+VfKfDwhECekintv9K4nIRLlVaqb6eGPQ4C+0nrtyo0nOjFSyMswl4XWJ83e2jrW
         GH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700960441; x=1701565241;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPmqfVyZpnYiTiJ+2/oFOK4Ay4l7x7Il+va2uiOCXqE=;
        b=fXGhlAQSEsI/cw7ETCLQSQTP2txnPAXNAOzXT2Q3US9qbJ5ibiRkgSoppMr8IQUvmg
         /dgmDpJoRiLbc4dtl2HeP6dbo2Q3YeTgMT6+/CeU1U61sSvAPtC1ExmBNVhxh5UxxTFb
         Gys4iZ/9VEhnuXPjH5bm/Csz9ZuHkvaCVBQlMeYQRmsM5HBWuSSX7Cp+H1rqUIX3i+Ip
         LiVamAlTyop+iatRDVuyBykywYZk4IOlSKdHr7zO932NSEj3kFXmop0jyg4I1T5UguAC
         /5A5UiY4n++H4fNgDyuvnCQrOi5BB38SSiUHEo8rYS+QyHEOdQkXhfGsRDRwQz9SEp+n
         Ia/w==
X-Gm-Message-State: AOJu0YwWez1TdVTwcNHQE7+HnHDVEw/vKenD0WRy0E6jlu0kA77QbOf+
        TrmytskdVBHgQ96V1rCneJo=
X-Google-Smtp-Source: AGHT+IH0pN9hS7ur3rx7S0tEuP4Psblq+3Q2D3zxdg6BE/5aWdiw2tpzHvtyEp8F7ibO4zQDkSjqQA==
X-Received: by 2002:a05:620a:2707:b0:77d:a0ee:f196 with SMTP id b7-20020a05620a270700b0077da0eef196mr591328qkp.5.1700960440953;
        Sat, 25 Nov 2023 17:00:40 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id z7-20020a05620a08c700b0077a02cf7949sm2583161qkz.32.2023.11.25.17.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 17:00:40 -0800 (PST)
Message-ID: <a986069c-3dd0-4054-bbae-06187694dc79@gmail.com>
Date:   Sat, 25 Nov 2023 17:00:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 3/3] net: phy: add support for PHY package MMD
 read/write
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Harini Katakam <harini.katakam@amd.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231126003748.9600-1-ansuelsmth@gmail.com>
 <20231126003748.9600-3-ansuelsmth@gmail.com>
 <637891aa-19fa-4f13-9ed2-f2e14a4b1ee2@gmail.com>
 <6562974e.df0a0220.242f6.337e@mx.google.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <6562974e.df0a0220.242f6.337e@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/25/2023 4:54 PM, Christian Marangi wrote:
> On Sat, Nov 25, 2023 at 04:52:19PM -0800, Florian Fainelli wrote:
>>
>>
>> On 11/25/2023 4:37 PM, Christian Marangi wrote:
>>> Some PHY in PHY package may require to read/write MMD regs to correctly
>>> configure the PHY package.
>>>
>>> Add support for these additional required function in both lock and no
>>> lock variant.
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>> ---
>>>    include/linux/phy.h | 74 +++++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 74 insertions(+)
>>>
>>> diff --git a/include/linux/phy.h b/include/linux/phy.h
>>> index 984bca9a82f4..1799133c8387 100644
>>> --- a/include/linux/phy.h
>>> +++ b/include/linux/phy.h
>>> @@ -2067,6 +2067,80 @@ static inline int __phy_package_write(struct phy_device *phydev,
>>>    	return __mdiobus_write(phydev->mdio.bus, addr, regnum, val);
>>>    }
>>> +static inline int phy_package_read_mmd(struct phy_device *phydev,
>>> +				       unsigned int addr_offset, int devad,
>>> +				       u32 regnum)
>>> +{
>>> +	struct phy_package_shared *shared = phydev->shared;
>>> +	struct mii_bus *bus = phydev->mdio.bus;
>>> +	int addr, val;
>>> +
>>> +	if (!shared || shared->base_addr + addr_offset > PHY_MAX_ADDR)
>>> +		return -EIO;
>>
>> You might be off by one here, should not that >= PHY_MAX_ADDR here and
>> below?
> 
> Thanks for the review. Yes PHY_MAX_ADDR is 32 so I should use >=.
> 
> (interesting choice to use 32 instead of 31 as MAX, guess an old mistake)

It has historically been used as an iterator upper bound, hence the 32.
-- 
Florian
