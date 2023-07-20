Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C4875B406
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjGTQWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjGTQWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:22:31 -0400
X-Greylist: delayed 311 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Jul 2023 09:22:28 PDT
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA219E;
        Thu, 20 Jul 2023 09:22:28 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.68]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MLR5f-1qeKIi1A8p-00ISHx; Thu, 20 Jul 2023 18:16:59 +0200
Message-ID: <dab140d7-112d-b9c6-4a9f-43e5ddfa02b8@i2se.com>
Date:   Thu, 20 Jul 2023 18:16:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 0/5] staging: vc04_services: vchiq: Register devices
 with a custom bus_type
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, f.fainelli@gmail.com,
        athierry@redhat.com, error27@gmail.com,
        dave.stevenson@raspberrypi.com, kieran.bingham@ideasonboard.com,
        laurent.pinchart@ideasonboard.com
References: <20230719164427.1383646-1-umang.jain@ideasonboard.com>
 <fe8ed301-dda8-9038-a035-c24e84bc2c5c@ideasonboard.com>
 <546b2da6-994a-ebc7-60c1-1d1ff2202f88@i2se.com>
 <43b2929d-f6be-d382-2802-412b0928dad0@ideasonboard.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <43b2929d-f6be-d382-2802-412b0928dad0@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:d25q+yIoDtL+qvLdrxnegz7b6PY1BxEd2NqLL9mlu4SH20EjsM2
 DJjV75WDGLiMtBClmecedJ+2Sd9w1lSPr0MRgeZ+s2apaXKTjRHXtTTTAVaz8yDp7GwAGUW
 5ELxQqsG6sy1rEVxUBy7OyBkC39a2A1CQ7Unvco4XQDGF8y5fE5GrRlo2MsDPOxwWBWst3a
 yGmRRNbKuosR091F0wK9Q==
UI-OutboundReport: notjunk:1;M01:P0:9GYFPJVd4Eg=;+7OgIWigRHF5AU73nGvXU9eSRQP
 fAmnfC3oN1DKMh9kMZt9/S3XwYhh90/7WEBy7XYApPscWeGuEULv7OTqPaNRdg2PrUtNDiqqb
 e+b01/kZH4EM5qKlZtgYk350AQpN8tFuhd9B/NmbIHolYl3FeZQClVwBB0fts2cq66xS9Z1Uj
 663xI+XgjC56st4d5HWYvHKo+Bafm5SwUOLj0jjMt0wPnMRQN2g+EjSg8yQnVp5FxoMgT6nA1
 dvOiPqfHrtCR/v+HoeeCUK9oTDiifrxL3DiUVCaLkS0f9a+M7yZ0QonunH7lHj+v9ePMVSBYp
 MIfG7DeBGiTD2CEWyHmw2U0AE91BNWHQNy05yhlfKXs+UpavTaBFYfJscLOtznAuwodOVGnuE
 rJrWc+GJmBqzIMdaxTZGwEwIarJbkuoOG8Y9G7lHDsBTDnK9YADIUXphiykCTWjAsc59HaJ2d
 HZM7z/AJTYaQXw8ZIoQIQnFACIurdyv+Wuf+Ro4kcLArSTu5fddqCQkfvkMuzcGKZ1FR9B6CE
 CSDJuTDJBlnfdzHs4Z8zPoiL7MWWx8Xo59iGwQ5/UsZ3DXD7nXoK6/W/vcyZQiN+UUMBpbVSa
 0gZc/CEdXEj1CHcBfRgtTDQAHQAixGD27krqzGWup71mIyLhZfK3O2K/j3rMXw4/3n0eUNkyV
 ZRYsZUFvFLmkSFbC7tXUwhQZgl4KVPJv4KHvI3sz3Q==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Am 20.07.23 um 14:08 schrieb Umang Jain:
> Hi Stefan ,
> 
> 
> On 7/19/23 11:05 PM, Stefan Wahren wrote:
>> Hi Umang,
>>
>> Am 19.07.23 um 18:54 schrieb Umang Jain:
>>> Hi,
>>>
>>> One comment,
>>>
>>> On 7/19/23 10:14 PM, Umang Jain wrote:
>>>> The patch series added a new bus type vchiq_bus_type and registers
>>>> child devices in order to move them away from using platform
>>>> device/driver.
>>>>
>>>> Patch 1/5 and 2/5 adds a new bus_type and registers them to vchiq
>>>> interface
>>>>
>>>> Patch 3/5 and 4/5 moves the bcm2835-camera and bcm2835-audio
>>>> to the new bus respectively
>>>>
>>>> Patch 5/5 removes a platform registeration helper which is no
>>>> longer required.
>>>>
>>>> Changes in v9:
>>>> - Fix module autoloading
>>>
>>> While the autoloading of bcm2835-audio, bcm2835-camera is fixed as 
>>> part of this series, there is one WARN coming in when bcm2835-audio 
>>> is loaded regarding dma_alloc_attr
>>>
>>> dmesg output: https://paste.debian.net/plain/1286359
>>
>> is it possible that after your patch series no DMA mask like 
>> DMA_BIT_MASK(32) is provided?
> 
> I am trying to set DMA_BIT_MASK(32) via  dma_set_mask_and_coherent() but 
> it fails with -EIO

what happens if you assign DMA_BIT_MASK(32) to device->dev.dma_mask 
within vchiq_device_register()?

>>
>>>
>>> I am investigating further...
>>>> - Implement bus_type's probe() callback to load drivers
>>>> - Implement bus_type's uevent() to make sure appropriate drivers are
>>>>    loaded when device are registed from vchiq.
>>>>
>>>> Changes in v8:
>>>> - Drop dual licensing. Instead use GPL-2.0 only for patch 1/5
>>>>
>>>> Changes in v7:
>>>> (5 out of 6 patches from v6 merged)
>>>> - Split the main patch (6/6) as requested.
>>>> - Use struct vchiq_device * instead of struct device * in
>>>>    all bus functions.
>>>> - Drop additional name attribute displayed in sysfs (redundant info)
>>>> - Document vchiq_interface doesn't enumerate device discovery
>>>> - remove EXPORT_SYMBOL_GPL(vchiq_bus_type)
>>>>
>>>> Changes in v6:
>>>> - Split struct device and struct driver wrappers in vchiq_device.[ch]
>>>> - Move vchiq_bus_type definition to vchiq_device.[ch] as well
>>>> - return error on bus_register() failure
>>>> - drop dma_set_mask_and_coherent
>>>> - trivial variable name change
>>>>
>>>> Changes in v5:
>>>> - Fixup missing "staging: " in commits' subject line
>>>> - No code changes from v4
>>>>
>>>> Changes in v4:
>>>> - Introduce patches to drop include directives from Makefile
>>>>
>>>> Changes in v3:
>>>> - Rework entirely to replace platform devices/driver model
>>>>
>>>> -v2:
>>>> https://lore.kernel.org/all/20221222191500.515795-1-umang.jain@ideasonboard.com/
>>>>
>>>> -v1:
>>>> https://lore.kernel.org/all/20221220084404.19280-1-umang.jain@ideasonboard.com/
>>>>
>>>> Umang Jain (5):
>>>>    staging: vc04_services: vchiq_arm: Add new bus type and device type
>>>>    staging: vc04_services: vchiq_arm: Register vchiq_bus_type
>>>>    staging: bcm2835-camera: Register bcm2835-camera with vchiq_bus_type
>>>>    staging: bcm2835-audio: Register bcm2835-audio with vchiq_bus_type
>>>>    staging: vc04_services: vchiq_arm: Remove vchiq_register_child()
>>>>
>>>>   drivers/staging/vc04_services/Makefile        |   1 +
>>>>   .../vc04_services/bcm2835-audio/bcm2835.c     |  20 ++--
>>>>   .../bcm2835-camera/bcm2835-camera.c           |  17 +--
>>>>   .../interface/vchiq_arm/vchiq_arm.c           |  48 ++++-----
>>>>   .../interface/vchiq_arm/vchiq_device.c        | 102 
>>>> ++++++++++++++++++
>>>>   .../interface/vchiq_arm/vchiq_device.h        |  54 ++++++++++
>>>>   6 files changed, 196 insertions(+), 46 deletions(-)
>>>>   create mode 100644 
>>>> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
>>>>   create mode 100644 
>>>> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h
>>>>
>>>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
