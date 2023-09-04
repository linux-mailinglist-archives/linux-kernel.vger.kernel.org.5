Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5707915E3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351821AbjIDKvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjIDKvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:51:31 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5A3DD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 03:51:27 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bdcade7fbso190843866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 03:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693824684; x=1694429484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0k6kpnoserckYuHCVkNe+zAAW3vEA36IOzUTy2u6khE=;
        b=Q/hHd35e67dVUX4fP3YMXQerw+Fy7wT8nbm9mQ2gRaD+6hFx2ondLOKqNcQA2d4yh1
         X7shxg8VAyKNV7+DbtFVyFuQ3G8hFZthOw+MfDC4yFQBEnw/OdrnvwqYaxDrPDvsTyCB
         6kWYFZBWlXch5U7elHyLk07FN9Nb4wjBwChzepV9fOAkQRsRq8z2Vu8QI+DQESEAq40+
         AWdQyK7NzOjZ2KldDswrQ/ZZEKtf6IWuIig3QSFbdJ/taTO5r7iAwLJEkqeqUTPyW0HV
         BDcu/qGpNBrKxbNdDkXDTkqZrONHKcb9CNE9yqRVRx0RUHTmoMRwewh7H1qEWi4k/6fD
         62Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693824684; x=1694429484;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0k6kpnoserckYuHCVkNe+zAAW3vEA36IOzUTy2u6khE=;
        b=D9/RNBh4h+7s/Ai94hYeRwyrXcEAQiMaqnv1yR5thVE8h2Wf/ExPAFsRycs4IUmjxN
         iiIqT3UR0LY9Ib90bU9SS9YOVyx8hVLk7AAo35NoHTce1WWv55JrkVfXEICcW6o7RMxI
         UbgAJ5/AG5eB1aEyUge9XmPk2R7CiyEgRyKSGsIJQWPV5nx78zvMPEmQUpUciTZITOi1
         zO/lQXMq8HxOxussdabXtqP7tL04bhojMbi5b7CJCVmT6UwMd7DuJxB3bHPsiDfHiMKR
         rYrJQXKX3plLfML0LOpUC+uU++ikcTrFqI/XQUEWjzw4pAudZURw9kMSvpc/R3v/h//W
         GSJw==
X-Gm-Message-State: AOJu0Yx6YrwFdo5m7/ZvjICmnH4ffTj51A+sMt6ux0rSampuW9Xfos1/
        0jt/71Xh+MFzfA/xyV0Ds1YMiw==
X-Google-Smtp-Source: AGHT+IHLxjjFNCyTlcsS0kQD510zndajm47ZwOZ93DZLzEmRrA9Ih7FEO70vfAaqUvHv81Md1l9q9A==
X-Received: by 2002:a17:907:762e:b0:9a5:9f3c:9615 with SMTP id jy14-20020a170907762e00b009a59f3c9615mr6535057ejc.63.1693824684574;
        Mon, 04 Sep 2023 03:51:24 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
        by smtp.gmail.com with ESMTPSA id jj17-20020a170907985100b009888aa1da11sm6010410ejc.188.2023.09.04.03.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 03:51:24 -0700 (PDT)
Message-ID: <c001c34b-e20c-f32e-f247-722d34a8db3d@linaro.org>
Date:   Mon, 4 Sep 2023 12:51:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/3] kconfig: add dependencies of POWER_RESET for mips
 malta
Content-Language: en-US
To:     Yuan Tan <tanyuan@tinylab.org>, mpe@ellerman.id.au,
        christophe.leroy@csgroup.eu, tglx@linutronix.de, mingo@redhat.com,
        tsbogend@alpha.franken.de, hdegoede@redhat.com
Cc:     linux@weissschuh.net, w@1wt.eu, falcon@tinylab.org,
        linux-mips@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1693535514.git.tanyuan@tinylab.org>
 <1c17f017d6c837ef887d08bd2f85102df3fbc17c.1693535514.git.tanyuan@tinylab.org>
 <915a9e2d-36ea-4a74-7b1b-9688f215b6f1@linaro.org>
 <55C9BDEDAB4E0B76+838dbd4f-425d-4f2e-94ee-f2bc3092ae13@tinylab.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <55C9BDEDAB4E0B76+838dbd4f-425d-4f2e-94ee-f2bc3092ae13@tinylab.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/23 11:24, Yuan Tan wrote:
> Hi,
> 
> On 9/4/2023 3:40 PM, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> On 1/9/23 04:42, Yuan Tan wrote:
>>> MIPS Malta's power off depends on PCI, PCI_QUIRKS, and
>>> POWER_RESET_PIIX4_POWEROFF to work. Enable them when POWER_RESET is set
>>> for convenience.
>>>
>>> Suggested-by: Zhangjin Wu <falcon@tinylab.org>
>>> Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
>>> ---
>>>   arch/mips/Kconfig | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>>> index bc8421859006..13bacbd05125 100644
>>> --- a/arch/mips/Kconfig
>>> +++ b/arch/mips/Kconfig
>>> @@ -547,6 +547,9 @@ config MIPS_MALTA
>>>       select MIPS_L1_CACHE_SHIFT_6
>>>       select MIPS_MSC
>>>       select PCI_GT64XXX_PCI0
>>> +    select PCI if POWER_RESET
>>> +    select PCI_QUIRKS if POWER_RESET
>>> +    select POWER_RESET_PIIX4_POWEROFF if POWER_RESET
>>>       select SMP_UP if SMP
>>>       select SWAP_IO_SPACE
>>>       select SYS_HAS_CPU_MIPS32_R1
>>
>> Shouldn't we also update the _defconfig files?
>>
> Sorry, in my last email, I forgot to reply to all. So I am now resending 
> this email.
> 
> In malta_defconfig, PCI and POWER_RESET_PIIX4_POWEROFF have already been 
> set and PCI_QUIRKS is also selected by FSL_PCI [=n].
> 
> So shutdown and reboot with malta_defconfig is working and there is no 
> need to update the malta_defconfig 🙂

Since the dependency is now enforced by Kconfig, the defconfig can
be simplified:

--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -306,3 +306,2 @@ CONFIG_SERIAL_8250_CONSOLE=y
  CONFIG_POWER_RESET=y
-CONFIG_POWER_RESET_PIIX4_POWEROFF=y
  CONFIG_POWER_RESET_SYSCON=y

But maybe we don't care, I don't know.
