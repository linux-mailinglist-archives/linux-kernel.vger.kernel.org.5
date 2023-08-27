Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060F3789CFE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 12:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjH0Kb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 06:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjH0Kbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 06:31:42 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58610C4;
        Sun, 27 Aug 2023 03:31:39 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2bd0d135ca3so2172421fa.3;
        Sun, 27 Aug 2023 03:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693132297; x=1693737097;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GaXyjQEp7FW2di7qvcSh0sewqS6uwk22ADyLcsKMcVQ=;
        b=fUZ95phY2HGI7XfC5pp4bB8P7u/HsolPngM7IDmyvGW5FuROMTC3/RJfJx3j/BKqyX
         Xc5BCMv754O3qLgX2gIKiuaVqylsu1wM3vu0wobx2d4MLnKGrIPIjep1S0bsQvjj3Bow
         uligLRbAsvZTe3Hs7fzoGy4STttkakuFHPAvgf08Qi4lMx86AmBuH/Qh8j+5hNXx4XwV
         kpY38/YUTnuc2I/2S4ihMIeb1wMZK35ijkeM2+bLarLaq7LE/2vycKqgzmYDkidF6Ogd
         zTq9L0sY2O1oUQZDQ9RtQvgs0HW9LcHY/vW3ZBDPPtArFsf0ejgJy1mK5xVNENeqVbjY
         PqPA==
X-Gm-Message-State: AOJu0YzOE2VylA6oUsz/JyJvVhxxw65vwbWAwe82FXZOse8CkxZBMFr9
        kBixULvNSKPvW0nFvQOxczY=
X-Google-Smtp-Source: AGHT+IHrJOOCzXE7LYnGGiWSxRYULxLS6F8XSzng5zQCK0L8y1HQksH+9slGqmqNczi+1hh14Bho8w==
X-Received: by 2002:a2e:9699:0:b0:2bc:bb02:fdba with SMTP id q25-20020a2e9699000000b002bcbb02fdbamr13642133lji.40.1693132296676;
        Sun, 27 Aug 2023 03:31:36 -0700 (PDT)
Received: from [192.168.86.246] (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id a20-20020a1709064a5400b00992b50fbbe9sm3285195ejv.90.2023.08.27.03.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 03:31:36 -0700 (PDT)
Message-ID: <8d2ba0d3-55eb-45cf-b88a-bafef35e96b9@linux.com>
Date:   Sun, 27 Aug 2023 11:31:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "tty: serial: meson: Add a earlycon for the T7
 SoC"
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20230827082944.5100-1-tanure@linux.com>
 <7bf9e716-0ff2-56d5-07ab-db027901454e@linaro.org>
 <09735262-1bc0-40cf-b139-22cccf70bcab@linux.com>
 <e73260c9-04f8-eb1e-bb5b-c3bd2219625e@linaro.org>
From:   Lucas Tanure <tanure@linux.com>
In-Reply-To: <e73260c9-04f8-eb1e-bb5b-c3bd2219625e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-08-2023 11:23, Neil Armstrong wrote:
> Hi Lucas,
> 
> Le 27/08/2023 à 12:04, Lucas Tanure a écrit :
>> On 27-08-2023 10:48, Neil Armstrong wrote:
>>> Hi Lucas,
>>>
>>> Le 27/08/2023 à 10:29, Lucas Tanure a écrit :
>>>> This reverts commit 6a4197f9763325043abf7690a21124a9facbf52e.
>>>> New SoC will use ttyS0 instead of ttyAML, so T7 SoC doesn't need a 
>>>> OF_EARLYCON_DECLARE.
>>>>
>>>> Signed-off-by: Lucas Tanure <tanure@linux.com>
>>>> ---
>>>> Since V1:
>>>> - add Signed-off-by:
>>>>
>>>>   drivers/tty/serial/meson_uart.c | 2 --
>>>>   1 file changed, 2 deletions(-)
>>>>
>>>> diff --git a/drivers/tty/serial/meson_uart.c 
>>>> b/drivers/tty/serial/meson_uart.c
>>>> index c4f61d82fb727..790d910dafa5d 100644
>>>> --- a/drivers/tty/serial/meson_uart.c
>>>> +++ b/drivers/tty/serial/meson_uart.c
>>>> @@ -648,8 +648,6 @@ meson_serial_early_console_setup(struct 
>>>> earlycon_device *device, const char *opt
>>>>   OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
>>>>               meson_serial_early_console_setup);
>>>> -OF_EARLYCON_DECLARE(meson, "amlogic,t7-uart",
>>>> -            meson_serial_early_console_setup);
>>>>   #define MESON_SERIAL_CONSOLE_PTR(_devname) 
>>>> (&meson_serial_console_##_devname)
>>>>   #else
>>>
>>> How do you use earlycon with this removed ?
>>>
>>> Neil
>> This is my kernel cmdline:
>> console=ttyS0,921600 no_console_suspend earlycon=ttyS0,0xfe078000
>>
>> And I can see my log:
>> boot 64bit kernel
>> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd092]
>> [    0.000000] Linux version 6.5.0-rc7-next-20230825+ (tanureal@ryzen) 
>> (aarch64-none-linux-gnu-gcc (GNU Toolchain for the A-profile 
>> Architecture 10.3-2021.07 (arm-10.29)) 10.3.1 20210621, GNU ld (GNU 
>> Toolchain fo3
>> [    0.000000] KASLR disabled due to lack of seed
>> [    0.000000] Machine model: Khadas vim4
>> [    0.000000] OF: reserved mem: 
>> 0x0000000005000000..0x00000000052fffff (3072 KiB) nomap non-reusable 
>> secmon@5000000
>> [    0.000000] OF: reserved mem: 
>> 0x0000000005300000..0x00000000072fffff (32768 KiB) nomap non-reusable 
>> secmon@5300000
>> ...
>> [    0.079368] io scheduler mq-deadline registered
>> [    0.079374] io scheduler kyber registered
>> [    0.079549] io scheduler bfq registered
>> [    0.083373] fe078000.serial: ttyS0 at MMIO 0xfe078000 (irq = 14, 
>> base_baud = 1500000) is a meson_uart
>> [    0.083403] printk: console [ttyS0] enabled
>>
>> As the log is OK, and T7 for now is binding against S4 code we should 
>> drop this patch and add a S4 one if needed.
>>
>> But just having this log is not enough for testing earlycon?
>> I am assuming that by just having the log since 0.0000 is a good sign 
>> that earlycon is working.
>> Could you give further guidance?
> 
> First the kernel argument is simply "earlycon" with no other options,
> the earlycon code will fetch the first uart using the DT 
> /chosen/stdout-path property.
> 
> Then you should see something like right after "Machine model":
> [    0.000000] earlycon: meson0 at MMIO 0x00000000ff803000 (options 
> '115200n8')
> 
> The boot log you share doesn't use earlycon, it waits until all 
> depedency of the UART
> has been probed before probing the UART driver and prints the whole boot 
> log.
> 
> Earlycon is a mechanism to use the UART HW as configured by the 
> bootloader in
> a minimal way very early in the boot in order to detect very early lockups.
> 
> Keeping OF_EARLYCON_DECLARE for t7 would enable this.
> 
> Neil
> 
>>
>> Lucas Tanure
>>
> 
But then we would need to add Earlycon for S4 too.
How can we add one Earlycon for all future SoCs, like S4 and T7?

