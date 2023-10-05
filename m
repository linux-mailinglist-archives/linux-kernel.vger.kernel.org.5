Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862227BA65B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjJEQdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjJEQch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:32:37 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EA121D20;
        Thu,  5 Oct 2023 02:48:21 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c752caeaa6so5564995ad.1;
        Thu, 05 Oct 2023 02:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696499301; x=1697104101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QcyG87vnGIKlXKSx5LziVXN0LYxk39g/b0gLezLySXE=;
        b=PylU08CQs8icxPqED8Ff+QQ4pSWtPCGBq9g5Cb3tzv1K1vTYAPfbaqjAtGc8RprwrL
         jNaQpBO6gtXAOEbnOo8g8QKFPPEPSPBhnzLJgmgXbQXfwI3ZpKmJ37bCT+xKIWrKZPVz
         KpWhp6IuQo3bwuDvGkcVJBvWTKvdSoEo5/FFvGjYlzEjZyHssfMbD6J31t/pFqDMIvNg
         ErLMK8QXycqN3crrt82l+/SaQgT6fdzhz77qVyLBEC6WQamTWR3tNWh5DSmjoj3Ca9lg
         HvMzehZlEC+AhufJRCM+eAkcfsKPIpd5roozpuYYrKXv4hSeSg1149ga136Zlu0b0jqW
         1ICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696499301; x=1697104101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QcyG87vnGIKlXKSx5LziVXN0LYxk39g/b0gLezLySXE=;
        b=c2RZBpWRaHWGlnKZ3VnNlVz/t/jE7Ud/Fw330voyQY0qJxXR1UaCIMmyUUGpfGBmda
         goJLJPeA26dAQtq9prkqMz865d1G28JZuL3drZipj4wA91hhuqupzaI+bAe/iUGB7ifB
         +hj/ld3xQlb51yPW/Z6EITyKQpGtCnAQ7ItCRZvRK9bXphxr+Vq5bTnuSwPaEEKcK91x
         uTTGi8C4Z3e5CKgcJqhSGWfs6ejQWki4zm38CikeeBhG7wf0sMB0TvSVvaeCTctP9peF
         1tBwZ6lvjQiRs6Svg3nxL+TqqbjIZwLP/1sRAKP1tjS76cT0jsBys41/FuAjyTu8zvAu
         zgrw==
X-Gm-Message-State: AOJu0YzXBkVT+J0hoVkkkWQjh76Uf/8CG+G4tUqP+57f3iau7eNYm/W9
        TZcjfIhWYltQpxxQj8ifvJR26uRNxGSNkg==
X-Google-Smtp-Source: AGHT+IFHteCKHlFnIrAXryMfRgG8kLNi9ULfUt0La9S8bxQi1xPwievTd5m2v28x0y6Gsz7yvjUaUw==
X-Received: by 2002:a17:902:e881:b0:1c4:4c10:6ae3 with SMTP id w1-20020a170902e88100b001c44c106ae3mr6150889plg.23.1696499300891;
        Thu, 05 Oct 2023 02:48:20 -0700 (PDT)
Received: from [172.16.116.58] ([103.15.228.93])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902ecc400b001c74df14e6esm1189773plh.51.2023.10.05.02.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 02:48:20 -0700 (PDT)
Message-ID: <795ee959-abdd-02c5-40b9-b7bb0d54c2f7@gmail.com>
Date:   Thu, 5 Oct 2023 15:18:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 2/3] greybus: Add BeaglePlay Linux Driver
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, vaishnav@beagleboard.org,
        jkridner@beagleboard.org, nm@ti.com,
        krzysztof.kozlowski+dt@linaro.org, johan@kernel.org,
        elder@kernel.org
References: <20231004184639.462510-1-ayushdevel1325@gmail.com>
 <20231004184639.462510-3-ayushdevel1325@gmail.com>
 <2023100501-siesta-dictate-132e@gregkh>
From:   Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <2023100501-siesta-dictate-132e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/5/23 14:38, Greg KH wrote:
> On Thu, Oct 05, 2023 at 12:16:37AM +0530, Ayush Singh wrote:
>> Add the Greybus host driver for BeaglePlay board by BeagleBoard.org.
>>
>> The current greybus setup involves running SVC in a user-space
>> application (GBridge) and using netlink to communicate with kernel
>> space. GBridge itself uses wpanusb kernel driver, so the greybus messages
>> travel from kernel space (gb_netlink) to user-space (GBridge) and then
>> back to kernel space (wpanusb) before reaching CC1352.
>>
>> This driver directly communicates with CC1352 (running SVC Zephyr
>> application). Thus, it simplifies the complete greybus setup eliminating
>> user-space GBridge.
>>
>> This driver is responsible for the following:
>> - Start SVC (CC1352) on driver load.
>> - Send/Receive Greybus messages to/from CC1352 using HDLC over UART.
>> - Print Logs from CC1352.
>> - Stop SVC (CC1352) on driver load.
>>
>> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
>> ---
>>   MAINTAINERS                     |   1 +
>>   drivers/greybus/Kconfig         |  10 +
>>   drivers/greybus/Makefile        |   2 +
>>   drivers/greybus/gb-beagleplay.c | 501 ++++++++++++++++++++++++++++++++
>>   4 files changed, 514 insertions(+)
>>   create mode 100644 drivers/greybus/gb-beagleplay.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5467669d7963..d87e30626a6a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8974,6 +8974,7 @@ M:	Ayush Singh <ayushdevel1325@gmail.com>
>>   L:	greybus-dev@lists.linaro.org (moderated for non-subscribers)
>>   S:	Maintained
>>   F:	Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
>> +F:	drivers/greybus/gb-beagleplay.c
>>   
>>   GREYBUS SUBSYSTEM
>>   M:	Johan Hovold <johan@kernel.org>
>> diff --git a/drivers/greybus/Kconfig b/drivers/greybus/Kconfig
>> index 78ba3c3083d5..fd4f26d09c53 100644
>> --- a/drivers/greybus/Kconfig
>> +++ b/drivers/greybus/Kconfig
>> @@ -17,6 +17,16 @@ menuconfig GREYBUS
>>   
>>   if GREYBUS
>>   
>> +config GREYBUS_BEAGLEPLAY
>> +	tristate "Greybus BeaglePlay driver"
>> +	depends on TTY
> What you want to depend on here is serdev, not tty, right?  Or am I
> mis-reading the code requirements?
>
> thanks,
>
> greg k-h

Yes, it was dependent on tty in the past, but not anymore. I think it 
should be changed to `SERIAL_DEV_BUS` now?


Sincerely,

Ayush Singh

