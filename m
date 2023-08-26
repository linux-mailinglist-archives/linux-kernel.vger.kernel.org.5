Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FDB789896
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 20:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjHZSID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 14:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjHZSHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 14:07:42 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B20710FF;
        Sat, 26 Aug 2023 11:07:22 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-986d8332f50so247576166b.0;
        Sat, 26 Aug 2023 11:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693073241; x=1693678041;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h0kZWHSaiCbSZZouMc9Cd5T9avQEho6jFDRRgwT4Ctc=;
        b=fksoKPrbbNHtCg6oY5lUjbeVhi1nmgTgUXKsBtkKjqrvMcEeQXrJwSqZEF2RzBnWg0
         eZPDkFqCjs+rha48l23S9upFm/pYClx64NbjnuhpfTAv2BBNgwEjMyExWJ9QtBMr+Sxp
         LeQkbnYMq0aeOd9O4E9H+Dvl2DH77MfZYgXfcMHlLypTPek+0UihL3/YopOfeVkgEEDy
         Dri/7ZOZKBM1+4ONptXx/fq2BOz63Fc8N3i+dQTJHIluaOT87I2pqHI4KrIiRi+iRMCf
         tb4ER2SrtvFnbB+sL4SrhGOe4WYotxaBW1Kr6vhW2X/L489JMHcC2QLS3ir9yJB7weJr
         d5og==
X-Gm-Message-State: AOJu0YzWlWFcGr+EYV9Hw8NYotS2h1FSOWEkzv2XUgPdOMLYKVX/T1Ci
        uvAu1oTvXhBZ825cPQeGfi8=
X-Google-Smtp-Source: AGHT+IHPhlD8CyM5CErLxdEnnWbiZkLGcsudwktwI2j+HEH/R4+6x8uD+fI/UJcop8wTahGB7oi24w==
X-Received: by 2002:a17:906:8462:b0:9a5:81cf:57b5 with SMTP id hx2-20020a170906846200b009a581cf57b5mr2937812ejc.2.1693073240411;
        Sat, 26 Aug 2023 11:07:20 -0700 (PDT)
Received: from [192.168.86.246] (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id vw7-20020a170907058700b0099b921de301sm2454244ejb.159.2023.08.26.11.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 11:07:19 -0700 (PDT)
Message-ID: <29cfd5ef-16ae-4960-a95e-13b58c090604@linux.com>
Date:   Sat, 26 Aug 2023 19:07:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] tty: serial: meson: Add a earlycon for the T7 SoC
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>,
        Nick <nick@khadas.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
References: <20230814080128.143613-1-tanure@linux.com>
 <20230814080128.143613-2-tanure@linux.com>
 <20230823082940.t4xjgfzwpt2hsfst@CAB-WSD-L081021>
From:   Lucas Tanure <tanure@linux.com>
In-Reply-To: <20230823082940.t4xjgfzwpt2hsfst@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-08-2023 09:29, Dmitry Rokosov wrote:
> Hello Lucas,
> 
> Thank you for the patch! Please find my small comment below.
> 
> On Mon, Aug 14, 2023 at 09:01:28AM +0100, Lucas Tanure wrote:
>> The new Amlogic T7 SoC does not have a always-on uart,
>> so add OF_EARLYCON_DECLARE for it.
>>
>> Signed-off-by: Lucas Tanure <tanure@linux.com>
>> Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>> Since v8:
>>   - Fix issues with git send-mail command line
>> Since v7:
>>   - Send to the correct maintainers
>>
>>   drivers/tty/serial/meson_uart.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
>> index 790d910dafa5..c4f61d82fb72 100644
>> --- a/drivers/tty/serial/meson_uart.c
>> +++ b/drivers/tty/serial/meson_uart.c
>> @@ -648,6 +648,8 @@ meson_serial_early_console_setup(struct earlycon_device *device, const char *opt
>>   
>>   OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
>>   		    meson_serial_early_console_setup);
>> +OF_EARLYCON_DECLARE(meson, "amlogic,t7-uart",
>> +		    meson_serial_early_console_setup);
>>   
>>   #define MESON_SERIAL_CONSOLE_PTR(_devname) (&meson_serial_console_##_devname)
>>   #else
> 
> I suppose you need to add a separate meson_t7_uart_data to switch the T7
> UART to a regular TTY devname 'ttyS'. For the new Amlogic SoCs, we have
> agreed to use 'ttyS' instead of 'ttyAML'. Please refer to the already
> applied patch series at [1] and the IRC discussion at [2].
> 
> Links:
>      [1] https://lore.kernel.org/all/20230705181833.16137-1-ddrokosov@sberdevices.ru/
>      [2] https://libera.irclog.whitequark.org/linux-amlogic/2023-07-03
> 
I asked Greg to drop this patch as is not need anymore.
T7 will use S4 TTY/UART code.
