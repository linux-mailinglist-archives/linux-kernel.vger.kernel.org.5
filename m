Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00F07A9913
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjIUSLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjIUSKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:10:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083C584F0E;
        Thu, 21 Sep 2023 10:37:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D77AC4AF6C;
        Thu, 21 Sep 2023 10:49:47 +0000 (UTC)
Message-ID: <b4fc7e06-d9d4-482c-b83d-ab2de29f34f3@xs4all.nl>
Date:   Thu, 21 Sep 2023 12:49:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/2] Added Digiteq Automotive MGB4 driver
Content-Language: en-US, nl
To:     =?UTF-8?Q?Martin_T=C5=AFma?= <tumic@gpxsee.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Martin_T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
References: <20230919165923.2509-1-tumic@gpxsee.org>
 <20230919165923.2509-2-tumic@gpxsee.org>
 <84ecbf4e-79eb-4ab4-851d-cdd998201534@xs4all.nl>
 <91d2eb26-f4de-4b83-816e-d7b8ada5a225@gpxsee.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <91d2eb26-f4de-4b83-816e-d7b8ada5a225@gpxsee.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2023 12:43, Martin Tůma wrote:
> On 21. 09. 23 9:28, Hans Verkuil wrote:
>> On 19/09/2023 18:59, tumic@gpxsee.org wrote:
>>> From: Martin Tůma <martin.tuma@digiteqautomotive.com>
>>>
>>> Digiteq Automotive MGB4 is a modular frame grabber PCIe card for automotive
>>> video interfaces. As for now, two modules - FPD-Link and GMSL - are
>>> available and supported by the driver. The card has two inputs and two
>>> outputs (FPD-Link only).
>>>
>>> In addition to the video interfaces it also provides a trigger signal
>>> interface and a MTD interface for FPGA firmware upload.
>>>
>>> Signed-off-by: Martin Tůma <martin.tuma@digiteqautomotive.com>
>>> ---
>>>   MAINTAINERS                             |   7 +
>>>   drivers/media/pci/Kconfig               |   1 +
>>>   drivers/media/pci/Makefile              |   1 +
>>>   drivers/media/pci/mgb4/Kconfig          |  17 +
>>>   drivers/media/pci/mgb4/Makefile         |   6 +
>>>   drivers/media/pci/mgb4/mgb4_cmt.c       | 244 +++++++
>>>   drivers/media/pci/mgb4/mgb4_cmt.h       |  17 +
>>>   drivers/media/pci/mgb4/mgb4_core.c      | 686 +++++++++++++++++
>>>   drivers/media/pci/mgb4/mgb4_core.h      |  74 ++
>>>   drivers/media/pci/mgb4/mgb4_dma.c       | 123 ++++
>>>   drivers/media/pci/mgb4/mgb4_dma.h       |  18 +
>>>   drivers/media/pci/mgb4/mgb4_i2c.c       | 140 ++++
>>>   drivers/media/pci/mgb4/mgb4_i2c.h       |  35 +
>>>   drivers/media/pci/mgb4/mgb4_io.h        |  33 +
>>>   drivers/media/pci/mgb4/mgb4_regs.c      |  30 +
>>>   drivers/media/pci/mgb4/mgb4_regs.h      |  35 +
>>>   drivers/media/pci/mgb4/mgb4_sysfs.h     |  18 +
>>>   drivers/media/pci/mgb4/mgb4_sysfs_in.c  | 744 +++++++++++++++++++
>>>   drivers/media/pci/mgb4/mgb4_sysfs_out.c | 681 +++++++++++++++++
>>>   drivers/media/pci/mgb4/mgb4_sysfs_pci.c |  71 ++
>>>   drivers/media/pci/mgb4/mgb4_trigger.c   | 208 ++++++
>>>   drivers/media/pci/mgb4/mgb4_trigger.h   |   8 +
>>>   drivers/media/pci/mgb4/mgb4_vin.c       | 934 ++++++++++++++++++++++++
>>>   drivers/media/pci/mgb4/mgb4_vin.h       |  69 ++
>>>   drivers/media/pci/mgb4/mgb4_vout.c      | 597 +++++++++++++++
>>>   drivers/media/pci/mgb4/mgb4_vout.h      |  65 ++
>>>   26 files changed, 4862 insertions(+)
>>>   create mode 100644 drivers/media/pci/mgb4/Kconfig
>>>   create mode 100644 drivers/media/pci/mgb4/Makefile
>>>   create mode 100644 drivers/media/pci/mgb4/mgb4_cmt.c
>>>   create mode 100644 drivers/media/pci/mgb4/mgb4_cmt.h
>>>   create mode 100644 drivers/media/pci/mgb4/mgb4_core.c
>>>   create mode 100644 drivers/media/pci/mgb4/mgb4_core.h
>>>   create mode 100644 drivers/media/pci/mgb4/mgb4_dma.c
>>>   create mode 100644 drivers/media/pci/mgb4/mgb4_dma.h
>>>   create mode 100644 drivers/media/pci/mgb4/mgb4_i2c.c
>>>   create mode 100644 drivers/media/pci/mgb4/mgb4_i2c.h
>>>   create mode 100644 drivers/media/pci/mgb4/mgb4_io.h
>>>   create mode 100644 drivers/media/pci/mgb4/mgb4_regs.c
>>>   create mode 100644 drivers/media/pci/mgb4/mgb4_regs.h
>>>   create mode 100644 drivers/media/pci/mgb4/mgb4_sysfs.h
>>>   create mode 100644 drivers/media/pci/mgb4/mgb4_sysfs_in.c
>>>   create mode 100644 drivers/media/pci/mgb4/mgb4_sysfs_out.c
>>>   create mode 100644 drivers/media/pci/mgb4/mgb4_sysfs_pci.c
>>>   create mode 100644 drivers/media/pci/mgb4/mgb4_trigger.c
>>>   create mode 100644 drivers/media/pci/mgb4/mgb4_trigger.h
>>>   create mode 100644 drivers/media/pci/mgb4/mgb4_vin.c
>>>   create mode 100644 drivers/media/pci/mgb4/mgb4_vin.h
>>>   create mode 100644 drivers/media/pci/mgb4/mgb4_vout.c
>>>   create mode 100644 drivers/media/pci/mgb4/mgb4_vout.h
>>>
>>
>> <snip>
>>
>>> diff --git a/drivers/media/pci/mgb4/mgb4_sysfs_in.c b/drivers/media/pci/mgb4/mgb4_sysfs_in.c
>>> new file mode 100644
>>> index 000000000000..61b1ee969ed0
>>> --- /dev/null
>>> +++ b/drivers/media/pci/mgb4/mgb4_sysfs_in.c
>>> @@ -0,0 +1,744 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * Copyright (C) 2021-2023 Digiteq Automotive
>>> + *     author: Martin Tuma <martin.tuma@digiteqautomotive.com>
>>> + *
>>> + * This module handles all the sysfs info/configuration that is related to the
>>> + * v4l2 input devices.
>>> + */
>>> +
>>> +#include <linux/device.h>
>>> +#include "mgb4_core.h"
>>> +#include "mgb4_i2c.h"
>>> +#include "mgb4_vin.h"
>>> +#include "mgb4_cmt.h"
>>> +#include "mgb4_sysfs.h"
>>> +
>>> +/* Common for both FPDL3 and GMSL */
>>> +
>>> +static ssize_t input_id_show(struct device *dev,
>>> +                 struct device_attribute *attr, char *buf)
>>> +{
>>> +    struct video_device *vdev = to_video_device(dev);
>>> +    struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
>>> +
>>> +    return sprintf(buf, "%d\n", vindev->config->id);
>>> +}
>>> +
>>> +static ssize_t oldi_lane_width_show(struct device *dev,
>>> +                    struct device_attribute *attr, char *buf)
>>> +{
>>> +    struct video_device *vdev = to_video_device(dev);
>>> +    struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
>>> +    struct mgb4_dev *mgbdev = vindev->mgbdev;
>>> +    u16 i2c_reg;
>>> +    u8 i2c_mask, i2c_single_val, i2c_dual_val;
>>> +    u32 config;
>>> +    int ret;
>>> +
>>> +    i2c_reg = MGB4_IS_GMSL(mgbdev) ? 0x1CE : 0x49;
>>> +    i2c_mask = MGB4_IS_GMSL(mgbdev) ? 0x0E : 0x03;
>>> +    i2c_single_val = MGB4_IS_GMSL(mgbdev) ? 0x00 : 0x02;
>>> +    i2c_dual_val = MGB4_IS_GMSL(mgbdev) ? 0x0E : 0x00;
>>> +
>>> +    mutex_lock(&mgbdev->i2c_lock);
>>> +    ret = mgb4_i2c_read_byte(&vindev->deser, i2c_reg);
>>> +    mutex_unlock(&mgbdev->i2c_lock);
>>> +    if (ret < 0)
>>> +        return -EIO;
>>> +
>>> +    config = mgb4_read_reg(&mgbdev->video, vindev->config->regs.config);
>>> +
>>> +    if (((config & (1U << 9)) && ((ret & i2c_mask) != i2c_dual_val)) ||
>>> +        (!(config & (1U << 9)) && ((ret & i2c_mask) != i2c_single_val))) {
>>> +        dev_err(dev, "I2C/FPGA register value mismatch\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    return sprintf(buf, "%s\n", config & (1U << 9) ? "1" : "0");
>>> +}
>>> +
>>> +static ssize_t oldi_lane_width_store(struct device *dev,
>>> +                     struct device_attribute *attr,
>>> +                     const char *buf, size_t count)
>>> +{
>>> +    struct video_device *vdev = to_video_device(dev);
>>> +    struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
>>> +    struct mgb4_dev *mgbdev = vindev->mgbdev;
>>> +    u32 fpga_data;
>>> +    u16 i2c_reg;
>>> +    u8 i2c_mask, i2c_data;
>>> +    unsigned long val;
>>> +    int ret;
>>> +
>>> +    ret = kstrtoul(buf, 10, &val);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    switch (val) {
>>> +    case 0: /* single */
>>> +        fpga_data = 0;
>>> +        i2c_data = MGB4_IS_GMSL(mgbdev) ? 0x00 : 0x02;
>>> +        break;
>>> +    case 1: /* dual */
>>> +        fpga_data = 1U << 9;
>>> +        i2c_data = MGB4_IS_GMSL(mgbdev) ? 0x0E : 0x00;
>>> +        break;
>>> +    default:
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    i2c_reg = MGB4_IS_GMSL(mgbdev) ? 0x1CE : 0x49;
>>> +    i2c_mask = MGB4_IS_GMSL(mgbdev) ? 0x0E : 0x03;
>>
>> Isn't this sequence needed as well?
>>
>>     mutex_lock(vindev->vdev.lock);
>>     if (vb2_is_busy(vindev->vdev.queue)) {
>>         mutex_unlock(vindev->vdev.lock);
>>         return -EBUSY;
>>     }
>>
>> I would expect this to be present in almost all store functions.
>> You don't want to change a setting like this when the queue is busy.
>>
>> If a store function doesn't need the lock, then perhaps add a comment
>> like: 'This can be changed at any time, even if vb2_is_busy() is true.'
>>
>> Can you go through all the store functions and verify this?
>>
>> Basically any store function that changes timings/video source/buffer size
>> needs this check.
>>
>> Similar to VIDIOC_S_FMT and VIDIOC_S_DV_TIMINGS ioctls: you can't change
>> those while buffers are allocated.
>>
> 
> Any store function, that could change the video source/size and thus would require new buffers is guarded by this check. In the admin guide documentation, all those functions have the "This parameter
> can not be changed while the output v4l2 device is open." note.
> 
> Functions that change the signal "on the wire" like oldi_lane_width_store() do however not have this guard as for me it seems that those can not break anything in v4l2 - the queue remains the same.
> Also when practically tested, nothing seemed to break. But I can of course add those checks to some more functions if you think they are necessary. Not having this restrictions makes it possible to
> fiddle with the parameters on live streams to set the correct parameters. For example in this case (oldi_lane_width) the image switches between "two images in one" and "the correct image" if you
> switch it during playback, but the queue (buffer size) is the same. The FPGA is also designed to be capable of changing those parameters "live".

Ah, OK. Then this should be documented in the source code. Basically you want
to see in the code that it is intentional that no locking takes place and that
it is safe to do so.

Most devices are not able to handle this, at minimum you will see video glitches.

With that change I should be able to merge v11.

Regards,

	Hans

> 
>>> +
>>> +    mutex_lock(&mgbdev->i2c_lock);
>>> +    ret = mgb4_i2c_mask_byte(&vindev->deser, i2c_reg, i2c_mask, i2c_data);
>>> +    mutex_unlock(&mgbdev->i2c_lock);
>>> +    if (ret < 0)
>>> +        return -EIO;
>>> +    mgb4_mask_reg(&mgbdev->video, vindev->config->regs.config, 1U << 9,
>>> +              fpga_data);
>>> +    if (MGB4_IS_GMSL(mgbdev)) {
>>> +        /* reset input link */
>>> +        mutex_lock(&mgbdev->i2c_lock);
>>> +        ret = mgb4_i2c_mask_byte(&vindev->deser, 0x10, 1U << 5, 1U << 5);
>>> +        mutex_unlock(&mgbdev->i2c_lock);
>>> +        if (ret < 0)
>>> +            return -EIO;
>>> +    }
>>> +
>>> +    return count;
>>> +}
>>> +
>>> +static ssize_t color_mapping_show(struct device *dev,
>>> +                  struct device_attribute *attr, char *buf)
>>> +{
>>> +    struct video_device *vdev = to_video_device(dev);
>>> +    struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
>>> +    u32 config = mgb4_read_reg(&vindev->mgbdev->video,
>>> +      vindev->config->regs.config);
>>> +
>>> +    return sprintf(buf, "%s\n", config & (1U << 8) ? "0" : "1");
>>> +}
>>> +
>>> +static ssize_t color_mapping_store(struct device *dev,
>>> +                   struct device_attribute *attr,
>>> +                   const char *buf, size_t count)
>>> +{
>>> +    struct video_device *vdev = to_video_device(dev);
>>> +    struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
>>> +    u32 fpga_data;
>>> +    unsigned long val;
>>> +    int ret;
>>> +
>>> +    ret = kstrtoul(buf, 10, &val);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    switch (val) {
>>> +    case 0: /* OLDI/JEIDA */
>>> +        fpga_data = (1U << 8);
>>> +        break;
>>> +    case 1: /* SPWG/VESA */
>>> +        fpga_data = 0;
>>> +        break;
>>> +    default:
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    mgb4_mask_reg(&vindev->mgbdev->video, vindev->config->regs.config,
>>> +              1U << 8, fpga_data);
>>
>> This is likely a store function that can be called at any time as this
>> doesn't interrupt video streaming or changes buffer sizes.
>>
> 
> Yes, this parameter definitely does not break anything else than the color scheme of the image and is without doubt safe to do on running streams. But the others should be as well.
> 
>>> +
>>> +    return count;
>>> +}
>>> +
>>
>> Regards,
>>
>>     Hans
> 

