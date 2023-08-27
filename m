Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D10789CDD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 12:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjH0KFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 06:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjH0KEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 06:04:42 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65635124;
        Sun, 27 Aug 2023 03:04:39 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-986d8332f50so291071066b.0;
        Sun, 27 Aug 2023 03:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693130678; x=1693735478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k3yLEQRh2p6qcn+rlG3lKXhYcStLscrFlLBAG5p3HJg=;
        b=Uey3a9aRoN2566QD8aQhNQQQrFnRSZveCdNiPeiMm7Zm2/vxvjw6G4g7G7xpLoWYVF
         Xpntcamiwz97i9YZBVqEHu/slkgRkRJBTG9gvTaKYbPd8ejawppuppnU39laD5qfajEo
         /nTbJ+XGoitpvKdQ0cZ/HG8R0mc/jn+Ct1rRtOHdmzaQMFEUvOgxd90MLGuEjdRqOPGm
         WIfNQgkNzMLZztijJsszb7AgcFQp35l+9aEGy434xpjQlbNLW6iYNVVb6NGKABq22qdH
         8gRpj7A1gCAYRPZYI0Zzo1w7GIFbK4MdY/3+4k9cRHdajWTk1fHnGv8kQ7OfK2786pLG
         ieuQ==
X-Gm-Message-State: AOJu0YwqKO5cEkw6vB07zkMwWDHWMuguiL5570GjcdDgL2dCFJlJKR3r
        fmTQmSiAT53lOWHXSh+bomQ=
X-Google-Smtp-Source: AGHT+IGH1Bhx1BbidsnYdjWIJhV9dyqreMXlr2EtXDJOyKYP8FbqwIp6lVVa1c9wNDavJV05rKhi6g==
X-Received: by 2002:a17:907:7635:b0:9a1:d915:d8dd with SMTP id jy21-20020a170907763500b009a1d915d8ddmr9873398ejc.10.1693130677691;
        Sun, 27 Aug 2023 03:04:37 -0700 (PDT)
Received: from [192.168.86.246] (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id ck8-20020a170906c44800b0099bd5d28dc4sm3252637ejb.195.2023.08.27.03.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 03:04:37 -0700 (PDT)
Message-ID: <09735262-1bc0-40cf-b139-22cccf70bcab@linux.com>
Date:   Sun, 27 Aug 2023 11:04:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "tty: serial: meson: Add a earlycon for the T7
 SoC"
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20230827082944.5100-1-tanure@linux.com>
 <7bf9e716-0ff2-56d5-07ab-db027901454e@linaro.org>
Content-Language: en-US
From:   Lucas Tanure <tanure@linux.com>
In-Reply-To: <7bf9e716-0ff2-56d5-07ab-db027901454e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-08-2023 10:48, Neil Armstrong wrote:
> Hi Lucas,
> 
> Le 27/08/2023 à 10:29, Lucas Tanure a écrit :
>> This reverts commit 6a4197f9763325043abf7690a21124a9facbf52e.
>> New SoC will use ttyS0 instead of ttyAML, so T7 SoC doesn't need a 
>> OF_EARLYCON_DECLARE.
>>
>> Signed-off-by: Lucas Tanure <tanure@linux.com>
>> ---
>> Since V1:
>> - add Signed-off-by:
>>
>>   drivers/tty/serial/meson_uart.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/meson_uart.c 
>> b/drivers/tty/serial/meson_uart.c
>> index c4f61d82fb727..790d910dafa5d 100644
>> --- a/drivers/tty/serial/meson_uart.c
>> +++ b/drivers/tty/serial/meson_uart.c
>> @@ -648,8 +648,6 @@ meson_serial_early_console_setup(struct 
>> earlycon_device *device, const char *opt
>>   OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
>>               meson_serial_early_console_setup);
>> -OF_EARLYCON_DECLARE(meson, "amlogic,t7-uart",
>> -            meson_serial_early_console_setup);
>>   #define MESON_SERIAL_CONSOLE_PTR(_devname) 
>> (&meson_serial_console_##_devname)
>>   #else
> 
> How do you use earlycon with this removed ?
> 
> Neil
This is my kernel cmdline:
console=ttyS0,921600 no_console_suspend earlycon=ttyS0,0xfe078000

And I can see my log:
boot 64bit kernel
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd092]
[    0.000000] Linux version 6.5.0-rc7-next-20230825+ (tanureal@ryzen) 
(aarch64-none-linux-gnu-gcc (GNU Toolchain for the A-profile 
Architecture 10.3-2021.07 (arm-10.29)) 10.3.1 20210621, GNU ld (GNU 
Toolchain fo3
[    0.000000] KASLR disabled due to lack of seed
[    0.000000] Machine model: Khadas vim4
[    0.000000] OF: reserved mem: 0x0000000005000000..0x00000000052fffff 
(3072 KiB) nomap non-reusable secmon@5000000
[    0.000000] OF: reserved mem: 0x0000000005300000..0x00000000072fffff 
(32768 KiB) nomap non-reusable secmon@5300000
...
[    0.079368] io scheduler mq-deadline registered
[    0.079374] io scheduler kyber registered
[    0.079549] io scheduler bfq registered
[    0.083373] fe078000.serial: ttyS0 at MMIO 0xfe078000 (irq = 14, 
base_baud = 1500000) is a meson_uart
[    0.083403] printk: console [ttyS0] enabled

As the log is OK, and T7 for now is binding against S4 code we should 
drop this patch and add a S4 one if needed.

But just having this log is not enough for testing earlycon?
I am assuming that by just having the log since 0.0000 is a good sign 
that earlycon is working.
Could you give further guidance?

Lucas Tanure

