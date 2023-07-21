Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D471675C178
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjGUIYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjGUIYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:24:16 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF379ED
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:24:14 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3159d5e409dso1784147f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689927853; x=1690532653;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LaHO8jdtLsSXJxnJeXXdT/34khW5y/PIz8TzPnqWIbM=;
        b=npXpYotMTRo/mvTrcoTQdhz1mzs9qaFiQOBvAp6O0PpokoIkcjd2FJbWCmcjIHHKOz
         8FvInldx2g9JaqbTnUzByTCjrwLlJNNB695G7kSK1Blbr6sAUw4FI1o2rWrsHPLfWXD3
         KTQBqT8Oor102uT7hcO3FwEkyaXpnbQkcGZwOEdOMPw3ZDw02O09+wIz5vJQrIUuxfAF
         OF3EyzViSO30kbK3z64alNPGOycAPYYAWkzyrWbrZ2TyvgrJsX9retNoJNqczaAkowdQ
         ewegsbHET16QWge9BsvIhq0Et0KuiUT+g5t8wxSVqwlARhaVVXivKmzo1QORzXvbK9UK
         NVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689927853; x=1690532653;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LaHO8jdtLsSXJxnJeXXdT/34khW5y/PIz8TzPnqWIbM=;
        b=LM1LqZ7sTNQbOsgr1FT+g1PlCirMyN/DD3aGAKnzJl71oVrjK3BlcZR6kcITdmngmI
         PxAeStQ8/VVHWSJgjJQBl1ImXUsjlTqj3V9sBs0aGIy/vFFJuoKfbvTrRbEzVDABFo4C
         nRY96CrHJwmkhIG26JUTS6pDnPDv93oiKTYq/OkiDzaB5CD2Zh/KatRQ88TzhOtexUp8
         nrk6FD6Qwcss97dSOgEF5Thr9vN+rWzicn+V5BX2UhceanmiZ6JeijNtrQ3uWizovATU
         Yo5Fzt6/QDQYFJ7DaUQ7GNggNMqk1cFt5xr72xGkKpUwMTP1CdJVc/viwZBj0t5sKHWY
         /fSA==
X-Gm-Message-State: ABy/qLa7/I+bTC2hOpPHuEkV141lwW+jDs5tmYZvqrNiqW9cYDNmVD+Q
        BzHDC7EWRQG50OTC2/6L4OeXWQ==
X-Google-Smtp-Source: APBJJlFSu6l7NqWd6+AwqSli6LFJT9onkAwyAt/FrCS0S4MhF0QrCzkxzlw8Ya30HQdfw4lkwhxa4w==
X-Received: by 2002:a5d:51c8:0:b0:313:f75b:c552 with SMTP id n8-20020a5d51c8000000b00313f75bc552mr1246852wrv.15.1689927853129;
        Fri, 21 Jul 2023 01:24:13 -0700 (PDT)
Received: from [192.168.1.70] ([86.71.62.179])
        by smtp.gmail.com with ESMTPSA id m24-20020a056000181800b003143ac73fd0sm3536255wrh.1.2023.07.21.01.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 01:24:12 -0700 (PDT)
Message-ID: <d8b0f332-b8e3-59ac-741c-edc7f2f3341f@baylibre.com>
Date:   Fri, 21 Jul 2023 10:24:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] ARM: multi_v7_defconfig: Enable OMAP watchdog support
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        vigneshr@ti.com, afd@ti.com
References: <20230718-enable-omap-wd-v2-1-921f829bc0a5@baylibre.com>
 <4db1d958-7b11-40d9-3f68-3e9390539cbe@baylibre.com>
 <20230721073836.GS5194@atomide.com>
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <20230721073836.GS5194@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/23 09:38, Tony Lindgren wrote:
> * Julien Panis <jpanis@baylibre.com> [230719 10:09]:
>> On 7/18/23 16:58, Julien Panis wrote:
>>> Increase build and test coverage by enabling support for OMAP watchdog,
>>> as used on TI OMAP based boards.
>>>
>>> The watchdog timer is an upward counter capable of generating a pulse on
>>> the reset pin and an interrupt to the device system modules following an
>>> overflow condition.
>>>
>>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> Looks good to me:
>
> Reviewed-by: Tony Lindgren <tony@atomide.com>
>
>> Maybe this patch should not be applied actually. I have 2 questions:
>>
>> [Q1] Using the following cmd sequence leads to a modified 'multi_v7_defconfig' file:
>>        'make multi_v7_defconfig'
>>        'make savedefconfig'
>>        'mv defconfig arch/arm/configs/multi_v7_defconfig'
>> ...even without modifying CONFIG_OMAP_WATCHDOG flag.
>> I guess it's due to modifications in various Kconfig files (dependencies for instance).
>> And perhaps it's also due to previous modifications of 'multi_v7_defconfig' file that
>> were not done by using 'make savedefconfig' (?)
>> How should I handle that for this patch ? This v2 has been created by modifying
>> 'multi_v7_defconfig' file manually. Using 'make savedefconfig' would be cleaner,
>> but as a result many flags would be re-organized whereas the commit intends to
>> enable 1 flag only.
> After make savedefconfig you can take a look where the new option got placed
> and then throw away the changes and add the entry manually :)
>
>> [Q2] I would like to add another flag in order to enable CONFIG_RTC_DRV_OMAP.
>> Is it better grouping CONFIG_OMAP_WATCHDOG and CONFIG_RTC_DRV_OMAP in
>> a single commit ? What's recommended ?
> Adding both is fine for the defconfig change, just try to place them where
> they would end up after savedefconfig to avoid it getting more out of sync.
>
> Regards,
>
> Tony

OK, thank you for these explanations.
There will be other flags to add (much more than 2 actually !). So, it's not worth merging
this patch. I will send another patch with all the flags that must be set.

Julien
