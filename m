Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3990175CCD7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjGUP7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjGUP7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:59:11 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374EB2D47;
        Fri, 21 Jul 2023 08:59:10 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8ad9eede0so15758165ad.1;
        Fri, 21 Jul 2023 08:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689955149; x=1690559949;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ouosyBPb4dn4HHlTnUJ4FSBNaoZUMLrSaPdnIDz9wuw=;
        b=Vk2fCFGEwoEdn2x2gzgjtS58Pwt9U01pViJ4ZQYCxi/eRmX4AkBspvWDAHWVmDk7xN
         n+2D8vXy2mZxQGdXrDv2lS+MrjZFIQcofY7Pwjw53TNZieLT5lObBGn5XVSRAVUv0ZTt
         Q7xAz/7IeqOMHlruhDE/8h2+agVavciZ9JWsBxClyOMn9k/1eQP+XGEXs+ux+ch4eZdL
         uubRSfULij8HcYuxURTHh3pZ5mjfXK6wVcDpXraubFagQEBcIulvXvb1ziBCjIJ60/4a
         gDW7X02wmc08mJbmEFpiGPGUqpBD0w+sUK6REF8VIs6Rq7y8Xi8guYUAK4Dg24xTGZ9X
         U2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689955149; x=1690559949;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ouosyBPb4dn4HHlTnUJ4FSBNaoZUMLrSaPdnIDz9wuw=;
        b=SaS8gCgfCM9AXyw/C5swX3zIfMiN1zDTlQ3B0D2GpE/JagxXbkUnaQEU7JDZSUkhwT
         kpLZqmFW4Vxh4J93vEUDibe9zmLVhBKi7K5+9W0d2bO6E6SulxDm75rViD7w4CUhyJka
         mhxKX4X++h+HeDcTZzWZGX/Srd3jegJsJFOo8lFXFvYljfOxUUn9hDGjxgpJKwg4CTZX
         cIyz4VbZOcCVZlgrxI5DB/7RlO7f8nskdqeM6nvD4U0rb8VRdG8RuOoA8t69frjMf21t
         ar6tB7ZnPlmpE9kHAYpQU+ec7b5bf4OaIQyPez0PC3TUNzMntyvQtB8puuCQkCTdQ9Py
         Czmw==
X-Gm-Message-State: ABy/qLY/6lLgqn8tyEJ/ncYm2SxtKF3W8j0eeH6OXSuKgcsxuRPjZTIH
        jjrEjXPMR9mPLhCQoOEx4Rc=
X-Google-Smtp-Source: APBJJlF3jZO0qcpAN4Y2IfbskrZlRgsTwwf5ilO35BnrANfcSEFNfCqrHVMg0flcOt/RvXSehhqNcg==
X-Received: by 2002:a17:903:181:b0:1b8:6cae:3570 with SMTP id z1-20020a170903018100b001b86cae3570mr2580302plg.11.1689955149561;
        Fri, 21 Jul 2023 08:59:09 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id n13-20020a170902e54d00b001b9be3b94d3sm3670309plf.140.2023.07.21.08.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 08:59:08 -0700 (PDT)
Message-ID: <7549a014-4f5e-cf87-f07d-c4980ab44dc1@gmail.com>
Date:   Fri, 21 Jul 2023 08:59:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [Enable Designware XGMAC VLAN Stripping Feature 2/2] net: stmmac:
 dwxgmac2: Add support for HW-accelerated VLAN Stripping
Content-Language: en-US
To:     "Ng, Boon Khai" <boon.khai.ng@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Boon@ecsmtp.png.intel.com" <Boon@ecsmtp.png.intel.com>,
        "Khai@ecsmtp.png.intel.com" <Khai@ecsmtp.png.intel.com>,
        boon.khai.ng@intel.com,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Tham, Mun Yew" <mun.yew.tham@intel.com>,
        "Swee, Leong Ching" <leong.ching.swee@intel.com>,
        "G Thomas, Rohan" <rohan.g.thomas@intel.com>,
        Shevchenko Andriy <andriy.shevchenko@linux.intel.com>
References: <20230721062617.9810-1-boon.khai.ng@intel.com>
 <20230721062617.9810-3-boon.khai.ng@intel.com>
 <cfba8fa4-47e5-7553-f40e-9e34b25d1405@kernel.org>
 <DM8PR11MB5751E5388AEFCFB80BCB483FC13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <DM8PR11MB5751E5388AEFCFB80BCB483FC13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/2023 8:30 AM, Ng, Boon Khai wrote:
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>> Sent: Friday, July 21, 2023 6:11 PM
>> To: Boon@ecsmtp.png.intel.com; Khai@ecsmtp.png.intel.com; "Ng
>> <boon.khai.ng"@intel.com; Giuseppe Cavallaro <peppe.cavallaro@st.com>;
>> Alexandre Torgue <alexandre.torgue@foss.st.com>; Jose Abreu
>> <joabreu@synopsys.com>; David S . Miller <davem@davemloft.net>; Eric
>> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
>> Paolo Abeni <pabeni@redhat.com>; Maxime Coquelin
>> <mcoquelin.stm32@gmail.com>; netdev@vger.kernel.org; linux-stm32@st-
>> md-mailman.stormreply.com; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org
>> Cc: Ng, Boon Khai <boon.khai.ng@intel.com>; Shevchenko, Andriy
>> <andriy.shevchenko@intel.com>; Tham, Mun Yew
>> <mun.yew.tham@intel.com>; Swee, Leong Ching
>> <leong.ching.swee@intel.com>; G Thomas, Rohan
>> <rohan.g.thomas@intel.com>; Shevchenko Andriy
>> <andriy.shevchenko@linux.intel.com>
>> Subject: Re: [Enable Designware XGMAC VLAN Stripping Feature 2/2] net:
>> stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
>>
>> On 21/07/2023 08:26, Boon@ecsmtp.png.intel.com wrote:
>>> From: Boon Khai Ng <boon.khai.ng@intel.com>
>>>
>>> Currently, VLAN tag stripping is done by software driver in
>>> stmmac_rx_vlan(). This patch is to Add support for VLAN tag stripping
>>> by the MAC hardware and MAC drivers to support it.
>>> This is done by adding rx_hw_vlan() and set_hw_vlan_mode() callbacks
>>> at stmmac_ops struct which are called from upper software layer.
>> ...
>>
>>>   	if (priv->dma_cap.vlhash) {
>>>   		ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
>>>   		ndev->features |= NETIF_F_HW_VLAN_STAG_FILTER; diff --
>> git
>>> a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>>> b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>>> index 23d53ea04b24..bd7f3326a44c 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>>> @@ -543,6 +543,12 @@ stmmac_probe_config_dt(struct platform_device
>> *pdev, u8 *mac)
>>>   			plat->flags |= STMMAC_FLAG_TSO_EN;
>>>   	}
>>>
>>> +	/* Rx VLAN HW Stripping */
>>> +	if (of_property_read_bool(np, "snps,rx-vlan-offload")) {
>>> +		dev_info(&pdev->dev, "RX VLAN HW Stripping\n");
>>
>> Why? Drop.
>>
> 
> This is an dts option export to dts for user to choose whether or not they
> Want a Hardware stripping or a software stripping.
> 
> May I know what is the reason to drop this?

Because the networking stack already exposes knobs for drivers to 
advertise and control VLAN stripping/insertion on RX/TX using ethtool 
and feature bits (NETIF_F_HW_VLAN_CTAG_RX, NETIF_F_HW_VLAN_CTAG_TX).

What you are doing here is encode a policy as a Device Tree property 
rather than describe whether the hardware supports a given feature and 
this is frowned upon.
-- 
Florian
