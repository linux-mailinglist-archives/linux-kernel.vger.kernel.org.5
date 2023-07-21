Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0290875CF62
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjGUQca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjGUQcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:32:11 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6788C3C29;
        Fri, 21 Jul 2023 09:30:39 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-76754b9eac0so202518885a.0;
        Fri, 21 Jul 2023 09:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689956975; x=1690561775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MCj4f/yqTqvC1Zfh8gaP5TMsrhfBrc1W+dHH5Na+xwg=;
        b=eDb8MvRcZ/ocaVOutwcjpC5W4QiIwzu61K6N4KTRKQxemrXBslXIrFHPzy9QHwUOT4
         oqEVnYiBTiOeQL3oTSP6HjI61ObacNFcuRHsBPyiY10CTMvqPTRkfNc6A1vKb7cFS4CZ
         ZWbRE/4bD5XV/Gn8TtSdUvqqlnQaRT7cDGf471jedUvmQArXrwHLbKAVxVFZHPTn284s
         A4RhG4ViLjX8n3dITdM7IX3NqvmwUOQKam3NHOHqBrqGdMxGq69SUvzrJjsCpcTiiSiZ
         7UFUkRGE3Bd2exW8+j0HbNagrf42KBAuyfTWZHdNfz9WNz6NqeTv101RvGTu4GkB6luv
         ulQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689956975; x=1690561775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MCj4f/yqTqvC1Zfh8gaP5TMsrhfBrc1W+dHH5Na+xwg=;
        b=dwPviXBmvyv9WfmFY867Js/WfRb10DXlWtEmEK0CXOGDOdYpkyls++pqoSAKdyn/BE
         xDaSjokT4joNHjELdw07zeuI75CiGupo7TRhRDRShLnmf9dRA0RQ8f84na2oLTdz3ZdL
         imbaXAcl9wxScJYb0qXfwVFYcxfn4DQ4nlerbnfl/PveybsRz+SXhuPaoFelDFt27otZ
         AjViZB0et6VWDdS/7tjEo2ONh/pk3umNfaIIu0xzeB7hi9i9I/S4TJNu9WliYGRgJCAG
         XoD2KRWfpInf8RFGeu6tuG1//uyjFh+c3pXEoK9q6lAsDb9PWXUH3H4zrpFPdzLD+6gp
         sZIQ==
X-Gm-Message-State: ABy/qLZwRIIkLdUocbvJK1ECGp0ckHJLM2Je4lJCZFcWUKvz2LSJssYb
        tw2d4jfJmnpWavGQb2FrZEY=
X-Google-Smtp-Source: APBJJlEyWH2COTt0xU4de216+mzXeZPVL+8ty6G4n2U6Ab92rUovUUNSjJ0zaAZ73WBRseqgDOAZsg==
X-Received: by 2002:a05:620a:2545:b0:769:542:b3fd with SMTP id s5-20020a05620a254500b007690542b3fdmr504663qko.8.1689956975345;
        Fri, 21 Jul 2023 09:29:35 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id i27-20020a05620a075b00b00765a7843382sm1201448qki.74.2023.07.21.09.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 09:29:34 -0700 (PDT)
Message-ID: <4dbc07fa-e446-8694-3371-fa2d0432fbc6@gmail.com>
Date:   Fri, 21 Jul 2023 09:29:30 -0700
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
 <7549a014-4f5e-cf87-f07d-c4980ab44dc1@gmail.com>
 <DM8PR11MB5751B68955275006A16E1C75C13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <DM8PR11MB5751B68955275006A16E1C75C13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/2023 9:12 AM, Ng, Boon Khai wrote:
>> -----Original Message-----
>> From: Florian Fainelli <f.fainelli@gmail.com>
>> Sent: Friday, July 21, 2023 11:59 PM
>> To: Ng, Boon Khai <boon.khai.ng@intel.com>; Krzysztof Kozlowski
>> <krzk@kernel.org>; Boon@ecsmtp.png.intel.com; Khai@ecsmtp.png.intel.com;
>> Ng, Boon Khai <boon.khai.ng@intel.com>; Giuseppe Cavallaro
>> <peppe.cavallaro@st.com>; Alexandre Torgue <alexandre.torgue@foss.st.com>;
>> Jose Abreu <joabreu@synopsys.com>; David S . Miller <davem@davemloft.net>;
>> Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
>> Paolo Abeni <pabeni@redhat.com>; Maxime Coquelin
>> <mcoquelin.stm32@gmail.com>; netdev@vger.kernel.org; linux-stm32@st-md-
>> mailman.stormreply.com; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org
>> Cc: Shevchenko, Andriy <andriy.shevchenko@intel.com>; Tham, Mun Yew
>> <mun.yew.tham@intel.com>; Swee, Leong Ching
>> <leong.ching.swee@intel.com>; G Thomas, Rohan
>> <rohan.g.thomas@intel.com>; Shevchenko Andriy
>> <andriy.shevchenko@linux.intel.com>
>> Subject: Re: [Enable Designware XGMAC VLAN Stripping Feature 2/2] net:
>> stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
>>
>>
>>
>> On 7/21/2023 8:30 AM, Ng, Boon Khai wrote:
>>>> -----Original Message-----
>>>> From: Krzysztof Kozlowski <krzk@kernel.org>
>>>> Sent: Friday, July 21, 2023 6:11 PM
>>>> To: Boon@ecsmtp.png.intel.com; Khai@ecsmtp.png.intel.com; "Ng
>>>> <boon.khai.ng"@intel.com; Giuseppe Cavallaro
>>>> <peppe.cavallaro@st.com>; Alexandre Torgue
>>>> <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@synopsys.com>;
>>>> David S . Miller <davem@davemloft.net>; Eric Dumazet
>>>> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
>>>> <pabeni@redhat.com>; Maxime Coquelin <mcoquelin.stm32@gmail.com>;
>>>> netdev@vger.kernel.org; linux-stm32@st- md-mailman.stormreply.com;
>>>> linux-arm-kernel@lists.infradead.org; linux- kernel@vger.kernel.org
>>>> Cc: Ng, Boon Khai <boon.khai.ng@intel.com>; Shevchenko, Andriy
>>>> <andriy.shevchenko@intel.com>; Tham, Mun Yew
>>>> <mun.yew.tham@intel.com>; Swee, Leong Ching
>>>> <leong.ching.swee@intel.com>; G Thomas, Rohan
>>>> <rohan.g.thomas@intel.com>; Shevchenko Andriy
>>>> <andriy.shevchenko@linux.intel.com>
>>>> Subject: Re: [Enable Designware XGMAC VLAN Stripping Feature 2/2] net:
>>>> stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
>>>>
>>>> On 21/07/2023 08:26, Boon@ecsmtp.png.intel.com wrote:
>>>>> From: Boon Khai Ng <boon.khai.ng@intel.com>
>>>>>
>>>>> Currently, VLAN tag stripping is done by software driver in
>>>>> stmmac_rx_vlan(). This patch is to Add support for VLAN tag
>>>>> stripping by the MAC hardware and MAC drivers to support it.
>>>>> This is done by adding rx_hw_vlan() and set_hw_vlan_mode() callbacks
>>>>> at stmmac_ops struct which are called from upper software layer.
>>>> ...
>>>>
>>>>>    	if (priv->dma_cap.vlhash) {
>>>>>    		ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
>>>>>    		ndev->features |= NETIF_F_HW_VLAN_STAG_FILTER; diff --
>>>> git
>>>>> a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>>>>> b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>>>>> index 23d53ea04b24..bd7f3326a44c 100644
>>>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>>>>> @@ -543,6 +543,12 @@ stmmac_probe_config_dt(struct platform_device
>>>> *pdev, u8 *mac)
>>>>>    			plat->flags |= STMMAC_FLAG_TSO_EN;
>>>>>    	}
>>>>>
>>>>> +	/* Rx VLAN HW Stripping */
>>>>> +	if (of_property_read_bool(np, "snps,rx-vlan-offload")) {
>>>>> +		dev_info(&pdev->dev, "RX VLAN HW Stripping\n");
>>>>
>>>> Why? Drop.
>>>>
>>>
>>> This is an dts option export to dts for user to choose whether or not
>>> they Want a Hardware stripping or a software stripping.
>>>
>>> May I know what is the reason to drop this?
>>
>> Because the networking stack already exposes knobs for drivers to advertise and
>> control VLAN stripping/insertion on RX/TX using ethtool and feature bits
>> (NETIF_F_HW_VLAN_CTAG_RX, NETIF_F_HW_VLAN_CTAG_TX).
>>
> 
> Hi Florian,
> 
> Understood, but how does user choose to have the default option
> either hardware strip or software strip, when the device just boot up?

You need the hardware to advertise it and decide as a maintainer of that 
driver whether it makes sense to have one or the other behavior by default.

> 
> I don’t think ethool can "remember" the setting once the device get rebooted?

If by "device" you mean a system that incorporates a XGMAC core, then I 
suppose that is true, though you could have some user-space logic that 
does remember the various ethtool options and re-applies them as soon as 
the device is made available to user-space, this would not be too far 
fetched.

> Any other suggestion of doing it other than using the dts method?

Let me ask you this question: what are you trying to solve by making 
this configurable? HW stripping should always be more efficient, should 
not it, if so, what would be the reasons for not enabling that by 
default? If not, then leave it off and let users enable it if they feel 
like they want it.
-- 
Florian
