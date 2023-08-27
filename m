Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCDE789CF9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 12:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjH0KXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 06:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjH0KXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 06:23:16 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F93E9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 03:23:13 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fee600dce6so21722085e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 03:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693131791; x=1693736591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zcUzkPYm/VWGO+NWviGSfkAFyEHWVQGPLTp4MRmRHs0=;
        b=hKnqbWv+K2AJAuvlB8UYqTPxh1grMKhfmcbJuHAZe/o3RThDlUhW8LpxC00UlmpbSX
         tBGsbZB0vsa1JQFcyqP94PGJNew7PS/AfBc6lKqbIcoBPCvWzDgaKiRpL/g3VsHfrsWS
         KA0BzD0kG+zlFqaNmSflviMz75ysBixMtSkOVFQcQkAUtVKraeGIyyT48cMTyInb4S2P
         3t3l+W0x73CiS+IHq7NK+J85mptnazm1TRKlvIZ3M0zEe7LyE1WCqr8Cd1wXTfCCpTye
         oz0FqVmnnykespvoviNSdY6PaV4YU2EJtQRDzH+UZrLENQb3O4XNtGyMPuDSHjC1SmLi
         5jcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693131791; x=1693736591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zcUzkPYm/VWGO+NWviGSfkAFyEHWVQGPLTp4MRmRHs0=;
        b=PlCbc8qY9DYBNPGBL6bnNXkWrK0YHKY3s7Whlo8yxRHjUQxfrDvOsWyfOJNYMkbDVn
         S4OVWxGF4sdDqxB0+8hMSO3jiAHbK70fT5SMjAzNwFzagK5mUkXPPLc33CDoaK7d+BIk
         J1jJ+RYnqdBV4PHsyRADdRyK6d9cJon2ouaACQmUMYKSU4MRSUxes/znvMJJPOpuSxNJ
         aCq7WjthHIss4em0ZRykTejd8om4LumveLUhU+tPVOwaiK4YDLyFmKuk7yEz6JqWEaXd
         hcpJPYeG8UMB0ZjOuNdNAAMCdl05WQ0boehdedHwshMNSGwmPovMqHs9B1xV9lOF5Vv8
         vmrQ==
X-Gm-Message-State: AOJu0Yy2ZetwrU9MgjSOs80IFGtbVIqRAPIUo/jowVyHxxY6/TXGQDGR
        q4qU8R6AmlDLsf+d7q9Do4TjiQ==
X-Google-Smtp-Source: AGHT+IEeJEGkposikHw7kGDcSR/dP88RFy1eSUxV5jo41SYcKYAePCZYl1GXQuA3kCfhxCHWVlALBA==
X-Received: by 2002:a7b:cc8c:0:b0:401:c52c:5ed9 with SMTP id p12-20020a7bcc8c000000b00401c52c5ed9mr1704637wma.32.1693131791371;
        Sun, 27 Aug 2023 03:23:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8865:2133:756f:b886? ([2a01:e0a:982:cbb0:8865:2133:756f:b886])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600004ce00b00317f3fd21b7sm7144933wri.80.2023.08.27.03.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 03:23:10 -0700 (PDT)
Message-ID: <e73260c9-04f8-eb1e-bb5b-c3bd2219625e@linaro.org>
Date:   Sun, 27 Aug 2023 12:23:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2] Revert "tty: serial: meson: Add a earlycon for the T7
 SoC"
Content-Language: en-GB
To:     Lucas Tanure <tanure@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20230827082944.5100-1-tanure@linux.com>
 <7bf9e716-0ff2-56d5-07ab-db027901454e@linaro.org>
 <09735262-1bc0-40cf-b139-22cccf70bcab@linux.com>
From:   Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <09735262-1bc0-40cf-b139-22cccf70bcab@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

Le 27/08/2023 à 12:04, Lucas Tanure a écrit :
> On 27-08-2023 10:48, Neil Armstrong wrote:
>> Hi Lucas,
>>
>> Le 27/08/2023 à 10:29, Lucas Tanure a écrit :
>>> This reverts commit 6a4197f9763325043abf7690a21124a9facbf52e.
>>> New SoC will use ttyS0 instead of ttyAML, so T7 SoC doesn't need a OF_EARLYCON_DECLARE.
>>>
>>> Signed-off-by: Lucas Tanure <tanure@linux.com>
>>> ---
>>> Since V1:
>>> - add Signed-off-by:
>>>
>>>   drivers/tty/serial/meson_uart.c | 2 --
>>>   1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
>>> index c4f61d82fb727..790d910dafa5d 100644
>>> --- a/drivers/tty/serial/meson_uart.c
>>> +++ b/drivers/tty/serial/meson_uart.c
>>> @@ -648,8 +648,6 @@ meson_serial_early_console_setup(struct earlycon_device *device, const char *opt
>>>   OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
>>>               meson_serial_early_console_setup);
>>> -OF_EARLYCON_DECLARE(meson, "amlogic,t7-uart",
>>> -            meson_serial_early_console_setup);
>>>   #define MESON_SERIAL_CONSOLE_PTR(_devname) (&meson_serial_console_##_devname)
>>>   #else
>>
>> How do you use earlycon with this removed ?
>>
>> Neil
> This is my kernel cmdline:
> console=ttyS0,921600 no_console_suspend earlycon=ttyS0,0xfe078000
> 
> And I can see my log:
> boot 64bit kernel
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd092]
> [    0.000000] Linux version 6.5.0-rc7-next-20230825+ (tanureal@ryzen) (aarch64-none-linux-gnu-gcc (GNU Toolchain for the A-profile Architecture 10.3-2021.07 (arm-10.29)) 10.3.1 20210621, GNU ld (GNU Toolchain fo3
> [    0.000000] KASLR disabled due to lack of seed
> [    0.000000] Machine model: Khadas vim4
> [    0.000000] OF: reserved mem: 0x0000000005000000..0x00000000052fffff (3072 KiB) nomap non-reusable secmon@5000000
> [    0.000000] OF: reserved mem: 0x0000000005300000..0x00000000072fffff (32768 KiB) nomap non-reusable secmon@5300000
> ...
> [    0.079368] io scheduler mq-deadline registered
> [    0.079374] io scheduler kyber registered
> [    0.079549] io scheduler bfq registered
> [    0.083373] fe078000.serial: ttyS0 at MMIO 0xfe078000 (irq = 14, base_baud = 1500000) is a meson_uart
> [    0.083403] printk: console [ttyS0] enabled
> 
> As the log is OK, and T7 for now is binding against S4 code we should drop this patch and add a S4 one if needed.
> 
> But just having this log is not enough for testing earlycon?
> I am assuming that by just having the log since 0.0000 is a good sign that earlycon is working.
> Could you give further guidance?

First the kernel argument is simply "earlycon" with no other options,
the earlycon code will fetch the first uart using the DT /chosen/stdout-path property.

Then you should see something like right after "Machine model":
[    0.000000] earlycon: meson0 at MMIO 0x00000000ff803000 (options '115200n8')

The boot log you share doesn't use earlycon, it waits until all depedency of the UART
has been probed before probing the UART driver and prints the whole boot log.

Earlycon is a mechanism to use the UART HW as configured by the bootloader in
a minimal way very early in the boot in order to detect very early lockups.

Keeping OF_EARLYCON_DECLARE for t7 would enable this.

Neil

> 
> Lucas Tanure
> 

