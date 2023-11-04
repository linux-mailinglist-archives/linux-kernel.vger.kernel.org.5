Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B152C7E0E63
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 09:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjKDIfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 04:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjKDIfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 04:35:19 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCC61BD
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 01:35:16 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id zC7cqEzJb8IN3zC7cqc9pn; Sat, 04 Nov 2023 09:35:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1699086914;
        bh=iizMqJ8oz7FLaa8uGRDiRCCs5ootGPJzd3jk97tV/1Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=IuiZ53PV05ZLqhqQxasa7wAPc1vFjl6sXrwjac8Zu1RQmHvjYfeme3h6hV6zzfY8O
         aG8Zi2ghZyBltTnTL/GqYrgqfWXpm9KYlJVNZUqBjFpqwM1PvMYUnjZt2qu4L8zHl4
         RLZjTNRS9tw+vZdAUGNBfmKpdF8YN6wy7G4jnf1Ja6767lg+FwN/hB4jqOmVqNznZj
         IjS1XiiK2la9DHSeCqyRKWl8+KawTg9cyKWhBEcz/ejD0FCAt3s5yoZyVIJ5ZMiCI8
         0ugQDb+TftQsdiWhV6LHNJrmSQz9djHMxZi5Fl+2u1BGd8N8ACilFwUqzWmBwNkkYR
         I/jCGuqzdu/lw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 04 Nov 2023 09:35:14 +0100
X-ME-IP: 86.243.2.178
Message-ID: <7ad737c4-1f61-488a-a8f9-32e80ad8f817@wanadoo.fr>
Date:   Sat, 4 Nov 2023 09:35:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RE: RE: [PATCH v6 1/2] usb: dwc3: add Realtek DHC RTD SoC dwc3
 glue layer driver
To:     =?UTF-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
Cc:     "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
References: <20230826031028.1892-1-stanley_chang@realtek.com>
 <202310301424.39UEOShlC2187546@rtits1.realtek.com.tw>
 <bc33c01db5b048899dce5467e7efec74@realtek.com>
 <202311011453.3A1ErwKI3829148@rtits1.realtek.com.tw>
 <da4c75ba87c3476694361ee3bc333401@realtek.com>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <da4c75ba87c3476694361ee3bc333401@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 03/11/2023 à 11:54, Stanley Chang[昌育德] a écrit :
> Hi Christophe,
> 
>> Le 01/11/2023 à 07:27, Stanley Chang[昌育德] a écrit :
>>> Hi CJ,
>>>
>>> I think these functions are not needed in remove function.
>>>
>>> In dwc3_rtk_probe_dwc3_core,
>>> I have used
>>> dwc3_node = of_get_compatible_child(node, "snps,dwc3"); and dwc3_pdev
>>> = of_find_device_by_node(dwc3_node);
>>>
>>> So, I call these put functions.
>>> platform_device_put(dwc3_pdev);
>>> of_node_put(dwc3_node);
>>
>> Yes, but you call it only in the error handling path of the function.
>>
>> I wonder if they should also be called in the remove function in order to
>> decrement the ref-counted reference.
>>
>>
>> Same in __get_dwc3_maximum_speed(), the reference taken by:
>>      dwc3_np = of_get_compatible_child(np, "snps,dwc3"); is never released.
>>
>>
>> See the comment at [1] to see what I mean.
>>
>>
>> [1]: https://elixir.bootlin.com/linux/v6.6/source/drivers/of/base.c#L681
> 
> You are right!
> For dwc3_pdev, dwc3_np or dwc3_node, I should add of_node_put to release them when the function exits.
> https://elixir.bootlin.com/linux/v6.5.10/source/drivers/usb/dwc3/dwc3-meson-g12a.c#L567
> 
> I will add a patch to fix this.
> 
> For example,
> diff --git a/drivers/usb/dwc3/dwc3-rtk.c b/drivers/usb/dwc3/dwc3-rtk.c
> index 590028e8fdcb..9d6f2a8bd6ce 100644
> --- a/drivers/usb/dwc3/dwc3-rtk.c
> +++ b/drivers/usb/dwc3/dwc3-rtk.c
> @@ -187,6 +187,7 @@ static enum usb_device_speed __get_dwc3_maximum_speed(struct device_node *np)
> 
>          ret = match_string(speed_names, ARRAY_SIZE(speed_names), maximum_speed);
> 
> +       of_node_put(dwc3_np);
>          return (ret < 0) ? USB_SPEED_UNKNOWN : ret;
>   }
> 
> @@ -339,6 +340,8 @@ static int dwc3_rtk_probe_dwc3_core(struct dwc3_rtk *rtk)
> 
>          switch_usb2_role(rtk, rtk->cur_role);
> 
> +       platform_device_put(dwc3_pdev);
> +       of_node_put(dwc3_node);
>          return 0;
> 
>   err_pdev_put:
> 

LGTM.

CJ

> 
> Thanks,
> Stanley
> 
>> CJ
>>>
>>> Thanks,
>>> Stanley
>>>
>>>> Hi,
>>>>
>>>> Is something like
>>>>           platform_device_put(dwc3_pdev);
>>>>           of_node_put(dwc3_node);
>>>> needed in the remove function?
>>>>
>>>> (as done in the error handling path of dwc3_rtk_probe_dwc3_core())
>>>>
>>>> Or should it be added at the end of dwc3_rtk_probe_dwc3_core() if the
>>>> reference are nor needed anymore when we leave the function?
>>>>
>>>> CJ
>>>>
>>>>> +     of_platform_depopulate(rtk->dev); }
>>>>> +
>>>>
>>>> ...
>>>
> 

