Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9553A807ACB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377316AbjLFVvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377293AbjLFVvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:51:01 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C339ED42;
        Wed,  6 Dec 2023 13:51:06 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c0a074e71so2837955e9.1;
        Wed, 06 Dec 2023 13:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701899465; x=1702504265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N+bw+tDNuJiNTA9scoos2n9st92UmYYFOHAL4nx5iZ4=;
        b=J313xbSoS1m3cM2WaV05RHtiFfUrxfrv/qVPgWc3kwXjXz0X9F6zckN9QPvykWg+U4
         adogJ9HtDeEso7OPso8EvwGpbk0lR+uVR4atPO0ekIGoDkrhfado2v/n1J9jzsEx/L19
         oWCdj5E+Kc4n0xah7bKvW+DK7f5uQDZ13UwvHTgLyheOl0ZVW/p42u5JOHTPXvH4Pqu4
         uoYEuNin6ZK8gKDVFkC1aYf9cFPZRz/aecFkRTGsLxQICbD3zrgsm/b6NoUhAHyS0ifS
         IILrYIKQ+srs+vmNwq/eCAVrHFXmv01Za8Z4yhJiEYfyiqj9m3dBBq+t3URI06+fMwne
         9M7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701899465; x=1702504265;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N+bw+tDNuJiNTA9scoos2n9st92UmYYFOHAL4nx5iZ4=;
        b=T0Ns+ScTgmQt1w/jvJaSW/zIMdbOunygEyAq42DWYkKMENIWVGYW0CHfNxfvYrOag5
         S+DzgOPwMeAkKp2S41nZ6nZS6lJxvbEsKmq+fJDZmrs0GYl9SJ+yo43tgKSzYYHCiw+p
         MgEV1Uz1sXjttxGlivqgiMlTjwH5TNKxwdugQtMBFapFBLbfbAARM9G7dZ7W92qAXTIR
         nIN3DYNMnA7/7N5U7GBEmMjrq6SxwGAZCloeQ2jDZPuP9RN10kjYoMIAiv9vr+6EJj1d
         ikldhyns297teje3P6GMwJf/f4tdH58avgkt+ap/dVbXxo4XayzHJSaj0Pd11ShZfiXm
         SSTg==
X-Gm-Message-State: AOJu0YweM4uh99MoPpVQANQPgfhJ0F0FatKWpEMu6atTxV/rCMteZmg0
        QBtoIjkVD45J9pZE1gosZQ==
X-Google-Smtp-Source: AGHT+IEJyjduAoDIjiSdjCLDQ4kqY7Z90qAE5DWZ31X/60ZKW7AEBCZ7dtzC4hGPJXDyw7i5gN2VZw==
X-Received: by 2002:a05:6000:1e86:b0:32d:14c5:643d with SMTP id dd6-20020a0560001e8600b0032d14c5643dmr1075022wrb.5.1701899464752;
        Wed, 06 Dec 2023 13:51:04 -0800 (PST)
Received: from ?IPV6:2a02:810b:f40:4300:5c34:4983:d206:9f? ([2a02:810b:f40:4300:5c34:4983:d206:9f])
        by smtp.gmail.com with ESMTPSA id o15-20020a5d408f000000b00333381c6e12sm613661wrp.40.2023.12.06.13.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 13:51:04 -0800 (PST)
Message-ID: <f0f3a0fd-8019-4950-8682-902cf985a81e@gmail.com>
Date:   Wed, 6 Dec 2023 22:51:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mwifiex: Restore USB8897 chipset support
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>
Cc:     Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231205210237.209332-1-knaerzche@gmail.com>
 <ZXDHgo5QnZjb237S@google.com> <ZXDH5S7rM32y48Fc@google.com>
From:   Alex Bee <knaerzche@gmail.com>
In-Reply-To: <ZXDH5S7rM32y48Fc@google.com>
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

Hi Brian,

Am 06.12.23 um 20:13 schrieb Brian Norris:
> (Altering CC list; sorry, I didn't notice the RESEND at first)
>
> On Wed, Dec 06, 2023 at 11:12:02AM -0800, Brian Norris wrote:
>> On Tue, Dec 05, 2023 at 10:02:37PM +0100, Alex Bee wrote:
>>> This patch restores USB8897 support which was removed with
>>> Commit 60a188a2715f ("mwifiex: remove USB8897 chipset support")
>> Did you look at the reason for that removal?
I did. And honestly I didn't understand it - in the first place.
>> "if both mwifiex_pcie and mwifiex_usb modules are enabled by user,
>> sometimes mwifiex_usb wins the race even if user wants wlan interface to
>> be on PCIe and USB for bluetooth. This patch solves the problem."
>>
>> That sounds like a legitimate problem, even if the solution isn't
>> perfect. Do you have any alternatives?
>>
>> I don't have such hardware, so I don't know its behaviors nor can I test
>> it. But it'd be nice if we could differentiate USB-only vs PCIe+USB
>> somehow.

I re-tried to decipher the commit message and re-checked everything and 
I think the patch is fine as is:

What they probably mean in the commit message is: There is an USB id 
clash for 1286:2046 with their "Marvell NFC-over-USB driver" [0]. So 
that has nothing to do with bluetooth :)
However Commit 8a81a96bd116 ("NFC: nfcmrvl: update USB device id") 
restricted the InterfaceSubClass and the InterfaceProtocol for those 
devices, so that this clash does no longer exist. This patch here takes 
the correct ones fot this wifi adapter (I checked with lsusb).

If it's not that I really don't know what they mean: Neither 1286:2045 
nor 1286:2046 usb ids are used anywhere else tree-wide.

[0] https://cateee.net/lkddb/web-lkddb/NFC_MRVL_USB.html

Fine?

Alex

>>> There are quite some devices which use this chipset with USB interface.
>>> The firmware still exits in linux upstream firmware repo and this simple
>>> patch is all what is required to support it in upstream linux (again).
>>>
>>> Signed-off-by: Alex Bee <knaerzche@gmail.com>
>>> ---
>>> Recently I upstreamed support for Geniatec XPI-3128 SBC which actually
>>> has one any of those boards soldered to the onboard USB Host controller.
>>> Geniatech has some boards [0], [1], [2] (maybe more) which have this
>>> variant soldered the same way. (optional)
>>> I've also read that "Xbox Wireless adapter for Windows" uses this chipset
>>> (unverified).
>>> I've also CC'ed Ganapathi Bhat who last updated the firmware for SDIO and
>>> PCIe variant of this chipset: It would be great if the firmware
>>> for USB variant could get an update too, as the one which we currently
>>> have is quite old - version 15.68.4.p103, while other have some 16.*
>>> firmware.
>> The old maintainers here seem to have gone AWOL, so I wouldn't hold my
>> breath on getting any support from them.
>>
>> Brian
>>
>>> [0] https://www.geniatech.com/product/xpi-3288/
>>> [1] https://www.geniatech.com/product/xpi-imx8mm/
>>> [2] https://www.geniatech.com/product/xpi-s905x/
>>>   
>>>   drivers/net/wireless/marvell/mwifiex/Kconfig |  4 ++--
>>>   drivers/net/wireless/marvell/mwifiex/usb.c   | 14 ++++++++++++++
>>>   drivers/net/wireless/marvell/mwifiex/usb.h   |  3 +++
>>>   3 files changed, 19 insertions(+), 2 deletions(-)
