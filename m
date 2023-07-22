Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F1E75D925
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 04:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjGVChl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 22:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGVChj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 22:37:39 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F5130FF;
        Fri, 21 Jul 2023 19:37:37 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6b9ee68396fso2129726a34.1;
        Fri, 21 Jul 2023 19:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689993456; x=1690598256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9dcEJWVCqgS+MVHGAdPQOmWm7dut5Um36fuNEfmAhSg=;
        b=HvDAFVRzIqZu1dgtMYdKMQfJtoM4fBCKlg3CaXD4zWoLx839qVHXGfTQ/XO5WoM4A/
         nynKzcuKsIivgNelTKWr42v5t4/FEouVY8hyzl3ccRKzdvGKTiDjJW84QPZyrEic8TxD
         jyealdY7E4/4NkJUNPJsj+nCjNHrUAuxfdvUXDFQzWExf82yXylUlIAvPp6E+/fAGaLM
         QAJWQ+NUe6/7Q62ssTKEtpw3FdTZ7loFeBcR15sliJ+YvGugvmtAASj2iVBPfqBpIEEb
         bjakInqphb7d9o3Mx9EX9EMvvvjPUGBc4EIEXFS13ltulXHzbf0g9qU9DJelwZxk58UG
         dluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689993456; x=1690598256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9dcEJWVCqgS+MVHGAdPQOmWm7dut5Um36fuNEfmAhSg=;
        b=AILXmgVj8Kub2ZeJ+Rt+GimCwfNzEZBpY2amsOzRSsGM349lEbCtgG8QCI91SIagYJ
         zGOrjtWbF0OvgBn0Dg6h4noCwuLZHyJ5u9VNDFv14DQwBlVM1NWoI9Gtq5CWzCJh+qHL
         ogLh7YtXIWF8QZJOL/4nEcvTHr3Mm3V979TCCMhtUlAgdBpm4teKFTZJ81pewkp9EvUS
         9pkxQeLrfU3ZFGdydquv38plRHXtEt9rRhTL4UK1jVjE1xs8qh6QHDw5PRggn5bPKrtW
         u5zZtbaj2hlaVVFR+V3neO2L5+Kz2DRhmULiQh1nRxhQkReeBowZJ1WgA4HPYHD3dbx9
         gQkg==
X-Gm-Message-State: ABy/qLa/dRozf2GWAdwcZHjRa5aDR/B08MJTHDCpNEHGMy0FZyxnMR8z
        8mw3nB7N0fHyw4/Yhaw/Y9w=
X-Google-Smtp-Source: APBJJlFitGvtIXa901syi1eT9estn+A1XbRiCf1trfl/h/8UYOiAoHtY4u16HgXD9k/xZN6JOyryVw==
X-Received: by 2002:a9d:6ad1:0:b0:6b9:5577:731f with SMTP id m17-20020a9d6ad1000000b006b95577731fmr1559610otq.32.1689993456432;
        Fri, 21 Jul 2023 19:37:36 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id o11-20020a05620a110b00b00767da9b6ae9sm1563234qkk.11.2023.07.21.19.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 19:37:35 -0700 (PDT)
Message-ID: <155ff37f-43d5-5fe0-6de4-c4639909553d@gmail.com>
Date:   Fri, 21 Jul 2023 19:37:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v2 6/6] net: dsa: microchip: ksz9477: make switch
 MAC address configurable
Content-Language: en-US
To:     Vladimir Oltean <olteanv@gmail.com>, Tristram.Ha@microchip.com
Cc:     o.rempel@pengutronix.de, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com, Woojung.Huh@microchip.com,
        andrew@lunn.ch, linux@armlinux.org.uk, devicetree@vger.kernel.org,
        pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net,
        Arun.Ramadoss@microchip.com, edumazet@google.com,
        conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
References: <20230721135501.1464455-1-o.rempel@pengutronix.de>
 <20230721135501.1464455-7-o.rempel@pengutronix.de>
 <BYAPR11MB3558A296C1D1830F15AC6BEFEC3FA@BYAPR11MB3558.namprd11.prod.outlook.com>
 <20230722001910.fst7vmvi4ktob4lt@skbuf>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230722001910.fst7vmvi4ktob4lt@skbuf>
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



On 7/21/2023 5:19 PM, Vladimir Oltean wrote:
> On Fri, Jul 21, 2023 at 10:09:57PM +0000, Tristram.Ha@microchip.com wrote:
>>> The switch MAC address is used for sending pause frames and for Wake on Magic
>>> Packet. So, make use of local-mac-address property in the switch node
>>> root and configure it in the HW.
>>>
>>
>>> @@ -1211,6 +1211,14 @@ int ksz9477_setup(struct dsa_switch *ds)
>>>          if (dev->wakeup_source)
>>>                  ksz_write8(dev, REG_SW_PME_CTRL, PME_ENABLE);
>>>
>>> +       if (is_valid_ether_addr(dev->mac_addr)) {
>>> +               int i;
>>> +
>>> +               for (i = 0; i < ETH_ALEN; i++)
>>> +                       ksz_write8(dev, REG_SW_MAC_ADDR_0 + i,
>>> +                                  dev->mac_addr[i]);
>>> +       }
>>> +
>>
>>> +
>>> +               mac = of_get_property(dev->dev->of_node, "local-mac-address",
>>> +                                     NULL);
>>> +               if (mac)
>>> +                       memcpy(dev->mac_addr, mac, ETH_ALEN);
>>   
>> So the Magic Packet uses the same MAC address for all KSZ9477 switches
>> if local-mac-address is not defined.  Is that practical in real operating
>> environment?
> 
> "same address" which is 00:00:00:00:00:00 AFAIU.
> 
> Do you mean to ask "what do we do for systems without this device tree
> property, don't we want to support Magic Packet for them too?". If so,
> I agree, it is a valid concern (although we need to modify it anyway,
> to add "wakeup-source", apparently).
> 
> Additionally, "local-mac-address" would be overloaded with a secondary
> meaning compared to what ethernet-controller.yaml says:
> 
>        Specifies the MAC address that was assigned to the network device.
> 
> ...which this is not.
> 
> Since the switch hardware doesn't have a register per user port that
> could be kept in sync with the MAC address of the Linux interface, it
> means that the address for WOL and for flow control will always require
> a special way for the user to find out about it.
> 
> I'm thinking, would it be simpler to just program the hardware with the
> MAC address of the DSA master? Every DSA master has one; we can track
> changes to it; no special device tree properties are needed; it also
> kinda makes sense as a MAC SA for flow control as well; DSA user ports
> also inherit it if they don't have a local-mac-address of their own.
> If there needs to be an override for that auto-selected MAC address, a
> device tree property can be added later, in the "microchip," namespace.

Yes the MAC address of the DSA master should be used, that is what we 
would naturally want to target magic packets with.

> 
> But "how does the user find out what MAC address to use for WOL" still
> remains a concern, when it's stuffed in the device tree. Is there going
> to be a BIOS customized for the KSZ9477 which always fixes up the
> local-mac-address of the switch node with what's set there?

Agreed, I don't think we should be accepting that 'local-mac-address' be 
specified, it does not serve any good and only makes everything more 
confusing because this is not the MAC address that is set into the 
port's net_device::dev_addr at all.

> 
>> The DSA driver used to have an API to set the MAC address to the switch,
>> but it was removed because nobody used it.
>>
> 
> Which API is that? "git log -GREG_SW_MAC_ADDR_0 drivers/net/dsa/" came
> up with nothing.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=841f4f24053acad69240c6ab7427a1d24bc29491
-- 
Florian
