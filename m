Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D0677BF93
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjHNSK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjHNSKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:10:31 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B65E65;
        Mon, 14 Aug 2023 11:10:30 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-63fc1574063so22616086d6.3;
        Mon, 14 Aug 2023 11:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692036629; x=1692641429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZAwoBn5pifhNx5RgWzrNuRam7cWmCqER/NGLdzLzsLw=;
        b=J8klID+n4CLFwcwW7OgB0PElSA5nxeeqvAQQc+HJvD0Tjrm2i47cJ9i24g+dKIsshm
         07cTZKRB8xKQl+uvpQ35d+KfUpB9hX1erP7Fhoa2douEsbQV051UPACsQb4O4ic457d6
         h8Q7I+MZcXZE/eRdzHaMmL6xlv6FpEXOBIxuO1LmqXfQ0a83ZMNVkMTH3b9Jc4TZ18qs
         4KzW5Wvp0aVu7E0JOzZBctlnb8UIl9b9c1SQqCRgpEK/rQYP3ACRETE5MUGXmSQeTBY7
         GiQ++XuDGggREbcxyV90W5lEmmxC8nsqYMQJhExQmyVMRfIqbvVXBehpRw+mm7vsYguu
         ZB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692036629; x=1692641429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAwoBn5pifhNx5RgWzrNuRam7cWmCqER/NGLdzLzsLw=;
        b=Edc62VXbCZ5xrruTdjJiB+cVWCGUL6ApkvCbPCtMdRY/Jlk4dd3xeKgQ1+teXczD28
         gJiPHxvkXSdQVIfr04QllWoJMiS71pV7OcMtToMeLIihguZLfdm5cDgkpZFDtquuJKdy
         q/PQAmpoQMR1xBTc4+L0CM8eBsxoCWY0YGLyT6vWx6K2bh8kVgpDLEMMFdF5o27PaLdr
         DEfU/z96V6PNRaPOBOCcL392xkANCfop2JPnVWyb8aB9N7CiO+5II0gr5f2AXEeUbbR7
         b6N2Y0EFtHKFqpOHehoU1kor5joS1v5e1bm5Zi00KJjOWjS54SBdPJLTPgsoCkVu7Czg
         MqpQ==
X-Gm-Message-State: AOJu0Yz/iM+jJTkRWNMKwlJv6K+DPnDe7pe0sXAXwBaCwKnh49ZureGM
        JQE12hiXF0J8j59sI8aQbuI=
X-Google-Smtp-Source: AGHT+IH7GjmutfFAbrl21ap7cKv8K4QcuaLBnpVCyaQV1DA2i11Zprfu9p7lXElZYb5/kkYVkEQ/dw==
X-Received: by 2002:a0c:e453:0:b0:647:122f:84ee with SMTP id d19-20020a0ce453000000b00647122f84eemr6434721qvm.56.1692036629523;
        Mon, 14 Aug 2023 11:10:29 -0700 (PDT)
Received: from [10.69.49.209] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l14-20020a0ce08e000000b006300e1db3ecsm2144317qvk.141.2023.08.14.11.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 11:10:28 -0700 (PDT)
Message-ID: <5d4757d4-6143-8179-9df9-2de56a716773@gmail.com>
Date:   Mon, 14 Aug 2023 11:09:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] serial: 8250_bcm7271: improve bcm7271 8250 port
To:     Justin Chen <justin.chen@broadcom.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
        "open list:TTY LAYER" <linux-kernel@vger.kernel.org>
References: <1691792050-25042-1-git-send-email-justin.chen@broadcom.com>
 <2023081221-truth-footsie-b5ab@gregkh>
 <CALSSxFZyQCCupuXC7=z3yoO7xhVY3Grw_zFsdWKrE+txk9-S1Q@mail.gmail.com>
 <ZNpEe+nmXGAkEbAb@smile.fi.intel.com>
 <533b62f7-a6c2-b360-13e0-b873a1a54251@broadcom.com>
Content-Language: en-US
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <533b62f7-a6c2-b360-13e0-b873a1a54251@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/2023 9:28 AM, Justin Chen wrote:
> 
> 
> On 8/14/23 8:12 AM, Andy Shevchenko wrote:
>> On Sat, Aug 12, 2023 at 09:24:21PM -0700, Justin Chen wrote:
>>> On Sat, Aug 12, 2023 at 3:50 AM Greg Kroah-Hartman
>>> <gregkh@linuxfoundation.org> wrote:
>>>> On Fri, Aug 11, 2023 at 03:14:01PM -0700, Justin Chen wrote:
>>
>>>>> +     [PORT_BCM7271] = {
>>>>> +             .name           = "bcm7271_uart",
>>
>> This is badly named port type.
>>
This may be true, but it does mirror the PORT_BCM63XX naming and I do 
value consistency so it is acceptable to me. However, I will happily 
yield to a better name if one can be determined by popular consensus.

> 
> Would "Brcmstb 7271 UART" suffice?
> 
Perhaps, "Broadcom BCM7271 UART" but it seems excessively "chatty" to 
me, so as I said I am OK with the original submission.

>>>>> +             .fifo_size      = 32,
>>>>> +             .tx_loadsz      = 32,
>>>>> +             .fcr            = UART_FCR_ENABLE_FIFO | 
>>>>> UART_FCR_R_TRIG_01,
>>>>> +             .rxtrig_bytes   = {1, 8, 16, 30},
>>>>> +             .flags          = UART_CAP_FIFO | UART_CAP_AFE
>>>>> +     },
>>>>>   };
>>
>> This is almost a dup of PORT_ALTR_16550_F32. Use it if you wish.
>> You can always rename it if it feels the right thing to do.
>>
> 
> There is some other PORT_ALTR logic that I would like to avoid. I would 
> also like to avoid future changes to PORT_ALTR that wouldn't be 
> applicable to us.
I too am reluctant to introduce yet another port type, but Justin is 
correct in pointing out that the PORT_ALTR_16550_* port types include Tx 
FIFO threshold programming that is incompatible with the BCM7271 UART 
hardware. This port type does appear necessary to address fundamental 
differences in the hardware unless we are willing to scrap the 
uart_config[] array and have the individual drivers manage these 
differences (which I would also be OK with, but I am just a tail on this 
dog).

The BCM7271 UART IP does support programmable Tx FIFO thresholds in a 
different way, so if I (or someone else) decided to enable support for 
that it would appear that this new port type would be necessary at that 
time as well.

> 
>> But why 8 and not 16 is the default rxtrig?
>>
> 
> We were seeing some latency issues on our chips where 16 would cause 
> overflows. Trying to kill 2 birds with one stone. If creating another 
> port type is avoidable then alternatively I can change the default in 
> userspace.
> 
> Thanks,
> Justin

Regards,
     Doug
