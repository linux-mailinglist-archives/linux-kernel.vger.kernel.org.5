Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D688788C71
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240850AbjHYP1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242251AbjHYP1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:27:22 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB32F2733;
        Fri, 25 Aug 2023 08:26:58 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-34bb72ffb1fso3553215ab.3;
        Fri, 25 Aug 2023 08:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692977218; x=1693582018;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KcmM3G7mPvInDI7x9n1WVGdIT7j8cD6MA5FDEXRb+aE=;
        b=s3hraC9tsUnIgyCPDaQtSu0TjbCWmspIIFEXz3RN21Lg6Q9MWewWMwhuxnx2iAu/1/
         61FgF+8fiMvfNUrayZYSy4PwVasyF4e/HssLT3a+iuXFN/dboOREr0f48Yp8sO/MbGsa
         Uf2leWp/jsVpAn7144DlcLNLPwcpiXlv0hHvv00INQOuCh0oxlTagWF4FzO6tymuS8or
         KlhFZkkq7KDO3/tZEESIzW8+b46Zd96pySgqst2qcFXz8ZLCEQFTGbhnau0R8ou62wd3
         2fLAdc1V/oACM9PTbEDG3C9683N2S+jeU2Ny3cnwn6HNj+KxEej7WPjjx5efkfURyN2U
         BuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692977218; x=1693582018;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KcmM3G7mPvInDI7x9n1WVGdIT7j8cD6MA5FDEXRb+aE=;
        b=Z4oWKGJkz87JmX2lydYIgmFKEM6GXdicsDq/8BMXW1UGfFFzI43grPKQDX/OFnfo3e
         vFv5+svn8fUf4kmfzwHoMVRMyO0COoHXh4Kcu9b9Tp38jtPxgSeFtMo29+wJZD9EluOy
         1ymSA+n5GyPT417wElgiWhAw2U/LY+EJJasS/Mle4MOcjTo82JuGMLYCxitC/XtG9njK
         goeOCwQWWbPtnmdfN/Q9egWQxkboz3mqKyGRLcvn6sr1vBRKFU2A4XVCkGmN8lW7LXwj
         Vy9EUCC8V5iOoGmE+A9bl8EQSeYuH9elFjRQzjR0h8GKp68Yb1PNuL+o0LFgdfTRJ0I/
         ganA==
X-Gm-Message-State: AOJu0YzNtoywADeZjYgZa1XeDdKOVp5Y2XIARYj4btACcFXnOWRFXJmG
        TDI/snNx8qEaYAiyaRUf2eg=
X-Google-Smtp-Source: AGHT+IFz7+5LJ1/nuYFat8UgtlwpTAtGQnchg/NH5X+DRSteprVeX+TDhddZM1cNbBJOLsO+2f4zVA==
X-Received: by 2002:a92:cd86:0:b0:349:777e:f514 with SMTP id r6-20020a92cd86000000b00349777ef514mr11240682ilb.10.1692977217952;
        Fri, 25 Aug 2023 08:26:57 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:4a48:944f:2db6:2b1a:8d59? ([2600:8802:b00:4a48:944f:2db6:2b1a:8d59])
        by smtp.gmail.com with ESMTPSA id z11-20020a63b04b000000b00565ec002d14sm1694547pgo.33.2023.08.25.08.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 08:26:56 -0700 (PDT)
Message-ID: <862e5225-2d8e-8b8f-fc6d-c9b48ac74bfc@gmail.com>
Date:   Fri, 25 Aug 2023 08:26:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] net: dsa: microchip: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Content-Language: en-US
To:     Lukasz Majewski <lukma@denx.de>, Tristram.Ha@microchip.com
Cc:     andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, Woojung.Huh@microchip.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
References: <20230824154827.166274-1-lukma@denx.de>
 <20230824154827.166274-2-lukma@denx.de>
 <BYAPR11MB35583A648E4E44944A0172A0ECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
 <20230825103911.682b3d70@wsk>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230825103911.682b3d70@wsk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/25/2023 1:39 AM, Lukasz Majewski wrote:
> Hi Tristram,
> 
>>> +static int ksz9477_errata(struct dsa_switch *ds)
>>> +{
>>> +       struct ksz_device *dev = ds->priv;
>>> +       u16 val;
>>> +       int p;
>>> +
>>> +       /* KSZ9477 Errata DS80000754C
>>> +        *
>>> +        * Module 4: Energy Efficient Ethernet (EEE) feature select
>>> must be
>>> +        * manually disabled
>>> +        *   The EEE feature is enabled by default, but it is not
>>> fully
>>> +        *   operational. It must be manually disabled through
>>> register
>>> +        *   controls. If not disabled, the PHY ports can
>>> auto-negotiate
>>> +        *   to enable EEE, and this feature can cause link drops
>>> when linked
>>> +        *   to another device supporting EEE.
>>> +        *
>>> +        *   Only PHY ports (dsa user) [0-4] need to have the EEE
>>> advertisement
>>> +        *   bits cleared.
>>> +        */
>>> +
>>> +       for (p = 0; p < ds->num_ports; p++) {
>>> +               if (!dsa_is_user_port(ds, p))
>>> +                       continue;
>>> +
>>> +               ksz9477_port_mmd_read(dev, p, MMD_DEVICE_ID_EEE_ADV,
>>> +                                     MMD_EEE_ADV, &val, 1);
>>> +
>>> +               pr_err("%s: PORT: %d val: 0x%x pc: %d\n", __func__,
>>> p, val,
>>> +                      ds->num_ports);
>>> +
>>> +               val &= ~(EEE_ADV_100MBIT | EEE_ADV_1GBIT);
>>> +               ksz9477_port_mmd_write(dev, p,
>>> MMD_DEVICE_ID_EEE_ADV,
>>> +                                      MMD_EEE_ADV, &val, 1);
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>>   int ksz9477_setup(struct dsa_switch *ds)
>>>   {
>>>          struct ksz_device *dev = ds->priv;
>>> @@ -1157,7 +1195,7 @@ int ksz9477_setup(struct dsa_switch *ds)
>>>          /* enable global MIB counter freeze function */
>>>          ksz_cfg(dev, REG_SW_MAC_CTRL_6, SW_MIB_COUNTER_FREEZE,
>>> true);
>>>
>>> -       return 0;
>>> +       return ksz9477_errata(ds);
>>>   }
>>
>> I would prefer to execute the code in ksz9477_config_cpu_port(), as at
>> the end there is already a loop to do something to each port.
> 
> Just some explanation of the taken approach:
> 
> 1. I've followed already in-mainline code for ksz8795.c
> (ksz8_handle_global_errata(ds)) which is executed in ksz8_setup
> function.
> 
> 2. I do believe, that separate "errata" function would be more
> readable, as KSZ9477 has many more erratas to be added.
> 
>> The
>> check to disable EEE or not should be dev->info->internal_phy[port],
>> as one of the user ports can be RGMII or SGMII, which does not have a
>> PHY that can be accessed inside the switch.
> 
> Yes, this would be better solution. Thanks for the suggestion.
> 
>>
>> As the EEE register value is simply 6 it should be enough to just set
>> the register to zero.  If so we do not need to add back those
>> ksz9477_port_mmd_setup functions and just use ksz_pwrite16() to write
>> to the MMD register.
>>
> 
> IMHO adding functions to MMD modification would facilitate further
> development (for example LED setup).

We already have some KSZ9477 specific initialization done in the Micrel 
PHY driver under drivers/net/phy/micrel.c, can we converge on the PHY 
driver which has a reasonable amount of infrastructure for dealing with 
workarounds, indirect or direct MMD accesses etc.?
-- 
Florian
