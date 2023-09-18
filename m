Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066B67A47C6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbjIRLDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjIRLDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:03:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC0B94;
        Mon, 18 Sep 2023 04:03:07 -0700 (PDT)
Received: from [192.168.0.125] (unknown [82.76.24.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ehristev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B0D066607095;
        Mon, 18 Sep 2023 12:03:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695034986;
        bh=v0kfhus51k2k8c4hQ+BgUzlZKVruHcTbgFeT81afp2Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EQHULyuHA0LylSZe+l9E5vhmHEV0eiOEBOwd4RvOqtSXhf+ypG9pX2jt7zV2XH6i2
         H+3e5lEl4QfL+a6U+V/betDz/X/1da2OnMDdGFdOQmIoPAY8Ma7UTWF9K+ZbNUtDDI
         9JwG02rbV4zYWQlCMTNbG6xytC5i2bTH+/Uw75N/eh4wL67Js3npy+yJy8fwZ6QB2q
         NXT8/HAPBlTsVc+kUMBToqCoYqzH5ih2BpRujU8Yn9g52o5L3ulOYw3A/b80rcQheo
         fLCKsIeQb2ZoG9aMoMPTtzhXoGmDxQpLqQ788qyforyhSRDyovVULw0Dd5GJBcxrKC
         qOmq0G/1guQ/g==
Message-ID: <55e85f31-fab6-07f9-0ffe-8ebcd2a56489@collabora.com>
Date:   Mon, 18 Sep 2023 14:03:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] MAINTAINERS: mmc: take over as maintainer of MCI & SDHCI
 MICROCHIP DRIVERS
Content-Language: en-US
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        aubin.constans@microchip.com, Ludovic.Desroches@microchip.com
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hari.PrasathGE@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@tuxon.dev
References: <20230911153246.137148-1-aubin.constans@microchip.com>
 <fd02d42e-7b24-4f50-849e-b0c752d1f011@microchip.com>
 <CAPDyKFpYzgwPvrWntgDQCZo97OZr2qd2FaVXpi7OnNc7i_gYtw@mail.gmail.com>
 <c4f43487-da93-4e67-0389-e31dde550d40@microchip.com>
From:   Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <c4f43487-da93-4e67-0389-e31dde550d40@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/23 20:01, Nicolas Ferre wrote:
> On 14/09/2023 at 16:21, Ulf Hansson wrote:
>> On Tue, 12 Sept 2023 at 07:21, <Ludovic.Desroches@microchip.com> wrote:
>>>
>>> On 9/11/23 17:32, Aubin Constans wrote:
>>>> On the one hand Eugen has taken responsibilities outside Microchip,
>>>> on the other hand I have some experience with the Microchip SDMMC
>>>> SDHCI controller.
>>>> Change Eugen as reviewer and take over maintainership of the SDHCI
>>>> MICROCHIP DRIVER.
>>>> Also, take over maintainership of its predecessor, that is the MCI
>>>> MICROCHIP DRIVER.
>>>>
>>>> Cc: Eugen Hristev <eugen.hristev@collabora.com>
>>>> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
>>>> Signed-off-by: Aubin Constans <aubin.constans@microchip.com>
>>>
>>> For atmel-mci:
>>> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
>>
>> Sounds like the patch could be split up, as there is an agreement on
>> the atmel-mci part.
>>
>> Aubin, can you make a separate patch for the atmel-mci part and add
>> Ludovic's ack to it?
>>
>> In regards to the sdhci driver, I suggest you just add yourself as a
>> maintainer too, along with Eugen.
> 
> For adding more background to this patch, in fact it was created in 
> coordination with Eugen. We can wait a bit for him to catch-up with 
> emails, no hurry there as Aubin won't have access to emails for a few 
> days anyway.
> 
> If it has an interest you can add my:
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> But definitively, no problem to delay this change.

Hi,

I am fine with this change, as Nicolas has already discussed this with me.

Acked-by: Eugen Hristev <eugen.hristev@collabora.com>

P.S. I have a mailmap entry for the new e-mail so the change is not 
compulsory, you can change as you see fit.

Eugen

> 
> Thanks for your understanding. Best regards,
>    Nicolas
> 
>>>> ---
>>>>    MAINTAINERS | 5 +++--
>>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 2833e2da63e0..52beaf4f7fbb 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -14022,7 +14022,7 @@ F:    
>>>> Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
>>>>    F:  drivers/iio/adc/mcp3911.c
>>>>
>>>>    MICROCHIP MMC/SD/SDIO MCI DRIVER
>>>> -M:   Ludovic Desroches <ludovic.desroches@microchip.com>
>>>> +M:   Aubin Constans <aubin.constans@microchip.com>
>>>>    S:  Maintained
>>>>    F:  drivers/mmc/host/atmel-mci.c
>>>>
>>>> @@ -19235,7 +19235,8 @@ F:    
>>>> Documentation/devicetree/bindings/mmc/sdhci-common.yaml
>>>>    F:  drivers/mmc/host/sdhci*
>>>>
>>>>    SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) MICROCHIP DRIVER
>>>> -M:   Eugen Hristev <eugen.hristev@microchip.com>
>>>> +M:   Aubin Constans <aubin.constans@microchip.com>
>>>> +R:   Eugen Hristev <eugen.hristev@collabora.com>
>>>>    L:  linux-mmc@vger.kernel.org
>>>>    S:  Supported
>>>>    F:  drivers/mmc/host/sdhci-of-at91.c
>>>
> 

