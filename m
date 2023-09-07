Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59192797A70
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245167AbjIGRkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245316AbjIGRjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:39:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7094F1A8;
        Thu,  7 Sep 2023 10:39:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD07C43397;
        Thu,  7 Sep 2023 07:47:49 +0000 (UTC)
Message-ID: <e4700099-f644-bb6d-940e-e464aa859f60@xs4all.nl>
Date:   Thu, 7 Sep 2023 09:47:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 2/3] media: Add Google Chameleon v3 video driver
Content-Language: en-US, nl
To:     =?UTF-8?Q?Pawe=c5=82_Anikiel?= <pan@semihalf.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dinguyen@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, mchehab@kernel.org, upstream@semihalf.com,
        amstan@chromium.org, ribalda@chromium.org
References: <20230630144006.1513270-1-pan@semihalf.com>
 <20230630144006.1513270-3-pan@semihalf.com>
 <5bcdbe39-99a5-b1f8-4599-d9b042248c8c@xs4all.nl>
 <CAF9_jYSrvBBenPqmo5-qokzDMJqYk7S5_-iFTYgKwAeRyZAp8g@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <CAF9_jYSrvBBenPqmo5-qokzDMJqYk7S5_-iFTYgKwAeRyZAp8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2023 18:27, Paweł Anikiel wrote:
> On Wed, Sep 6, 2023 at 1:15 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>
>> On 30/06/2023 16:40, Paweł Anikiel wrote:
>>> Add driver for the video system present on the Chameleon v3. It
>>> consists of two Intel DisplayPort DPRX IP cores and six video
>>> interfaces (here called "framebuffers").
>>>
>>> Signed-off-by: Paweł Anikiel <pan@semihalf.com>
>>> ---
>>>  drivers/media/platform/Kconfig                |   1 +
>>>  drivers/media/platform/Makefile               |   1 +
>>>  drivers/media/platform/google/Kconfig         |   4 +
>>>  drivers/media/platform/google/Makefile        |   2 +
>>>  .../media/platform/google/chameleonv3/Kconfig |   9 +
>>>  .../platform/google/chameleonv3/Makefile      |  15 +
>>>  .../platform/google/chameleonv3/chv3-core.c   | 292 ++++++++++
>>>  .../platform/google/chameleonv3/chv3-core.h   |  17 +
>>>  .../platform/google/chameleonv3/chv3-fb.c     | 539 ++++++++++++++++++
>>>  .../platform/google/chameleonv3/chv3-fb.h     |  34 ++
>>>  .../platform/google/chameleonv3/dprx-aux.c    |  77 +++
>>>  .../platform/google/chameleonv3/dprx-dp.c     |  82 +++
>>>  .../platform/google/chameleonv3/dprx-dpcd.c   | 424 ++++++++++++++
>>>  .../platform/google/chameleonv3/dprx-dprx.c   | 262 +++++++++
>>>  .../platform/google/chameleonv3/dprx-edid.c   |  39 ++
>>>  .../platform/google/chameleonv3/dprx-i2c.c    |  41 ++
>>>  .../platform/google/chameleonv3/dprx-mt.c     | 184 ++++++
>>>  .../platform/google/chameleonv3/dprx-sbmsg.c  | 162 ++++++
>>>  .../media/platform/google/chameleonv3/dprx.h  | 128 +++++
>>>  19 files changed, 2313 insertions(+)
>>>  create mode 100644 drivers/media/platform/google/Kconfig
>>>  create mode 100644 drivers/media/platform/google/Makefile
>>>  create mode 100644 drivers/media/platform/google/chameleonv3/Kconfig
>>>  create mode 100644 drivers/media/platform/google/chameleonv3/Makefile
>>>  create mode 100644 drivers/media/platform/google/chameleonv3/chv3-core.c
>>>  create mode 100644 drivers/media/platform/google/chameleonv3/chv3-core.h
>>>  create mode 100644 drivers/media/platform/google/chameleonv3/chv3-fb.c
>>>  create mode 100644 drivers/media/platform/google/chameleonv3/chv3-fb.h
>>>  create mode 100644 drivers/media/platform/google/chameleonv3/dprx-aux.c
>>>  create mode 100644 drivers/media/platform/google/chameleonv3/dprx-dp.c
>>>  create mode 100644 drivers/media/platform/google/chameleonv3/dprx-dpcd.c
>>>  create mode 100644 drivers/media/platform/google/chameleonv3/dprx-dprx.c
>>>  create mode 100644 drivers/media/platform/google/chameleonv3/dprx-edid.c
>>>  create mode 100644 drivers/media/platform/google/chameleonv3/dprx-i2c.c
>>>  create mode 100644 drivers/media/platform/google/chameleonv3/dprx-mt.c
>>>  create mode 100644 drivers/media/platform/google/chameleonv3/dprx-sbmsg.c
>>>  create mode 100644 drivers/media/platform/google/chameleonv3/dprx.h
>>>

<snip>

>>> +#define MODULE_NAME "chv3-video"
>>
>> Hmm, that's a bit obscure. How about chameleonv3-video?
> 
> There's already a chv3-audio driver upstream. Should I change this one anyway?

Ah, I was not aware of that. In that case leave it as-is. Same for the compatible
string. Personally I think it is a bit too vague, but that ship has sailed...

<snip>

>>> +/*
>>> + * We can't control the resolution, we can only read what it currently is from
>>> + * the framebuffer. In order not to confuse the application, the resolution is
>>> + * saved in fb->fmt, and is only updated when the application calls open() and
>>> + * there are no other applications that have the file opened.
>>> + */
>>
>> Why not use the DV_TIMINGS API?
>> https://linuxtv.org/downloads/v4l-dvb-apis-new/userspace-api/v4l/dv-timings.html
>>
>> That's meant for e.g. HDMI capture where the resolution can change. It seems much
>> more appropriate for this.
> 
> I have a few questions:
> 1. Could you clarify how this API helps with resolution changes? I
> couldn't find anything in the docs about this. When looking at drivers
> using DV_TIMINGS, they send a V4L2_EVENT_SOURCE_CHANGE event when a
> resolution change happens, which is a different API if I understand
> correctly.

Perhaps I phrased it badly. The DV Timings API isn't a separate API, it is just a
set of V4L2 ioctls specifically created to handle digital video inputs (HDMI, DP,
VGA, DVI, etc.) where the video signal can go away (unplugged), and come back, and
change resolutions on the fly. It relies on the V4L2_EVENT_SOURCE_CHANGE to signal
to userspace when the resolution changes.

> 2. How should the S_DV_TIMINGS ioctls be handled if the timings can't
> be changed? In the intel DPRX IP, the timings are only available as
> read-only MSA registers:
> https://www.intel.com/content/www/us/en/docs/programmable/683273/23-1-20-0-1/sink-msa-registers.html
> 3. The G_FMT ioctl still needs to be handled. Is my approach of
> delaying the resolution change appropriate?

The basic operation is that the hardware detects the timings (and also whether there
is a video signal at all), and if the video signal/timings change it will raise the
event and (if streaming is in progress) call vb2_queue_error() to stop further streaming.

Userspace sees the event, it will stop streaming and call QUERY_DV_TIMINGS to get the new
timings (if any). When it gets the new timings it will call S_DV_TIMINGS. S_DV_TIMINGS will
also update the format, so afterwards G_FMT will return an updated format using the new
width and height.

The reason for all this is that you cannot change resolutions on the fly since there is
a whole pipeline that depends on the resolution: buffer sizes (of course), but also
how the captured frames are used in userspace, etc. So a resolution change will typically
require a complete rebuild of the video pipeline.

Whether S_DV_TIMINGS needs to change anything in the hardware depends on the hardware
itself. It will always update the current format. In the case of this driver that is likely
the only thing it needs to do.

Note that the driver should always have some initial default timings. Typically 1080p60
is chosen. The internal timings structure is just what was last set (or the initial default),
and S_DV_TIMINGS updates it. It does not need to match what the hardware detects.

Only QUERY_DV_TIMINGS reports what the hardware sees, but that ioctl will never change
the driver state, it just reports what is detected.

There are also a number of controls that relate to DV_TIMINGS API, see the V4L2_CID_DV_TX_*
controls: https://hverkuil.home.xs4all.nl/spec/userspace-api/v4l/ext-ctrls-dv.html

You will likely want to support V4L2_CID_DV_RX_POWER_PRESENT and V4L2_CID_DV_RX_RGB_RANGE,
assuming the hardware can report this.

I really need to start documenting this properly in our spec. Let me see if I can come
up with an initial patch for this.

<snip>

>>> diff --git a/drivers/media/platform/google/chameleonv3/dprx-edid.c b/drivers/media/platform/google/chameleonv3/dprx-edid.c
>>> new file mode 100644
>>> index 000000000000..19d3a6182eeb
>>> --- /dev/null
>>> +++ b/drivers/media/platform/google/chameleonv3/dprx-edid.c
>>> @@ -0,0 +1,39 @@
>>> +#include <linux/kernel.h>
>>> +
>>> +u8 default_edid[256] = {
>>> +     0x00,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0x00,
>>> +     0x34,0xA9,0x96,0xA2,0x01,0x01,0x01,0x01,
>>> +     0x00,0x17,0x01,0x03,0x80,0x80,0x48,0x78,
>>> +     0x0A,0xDA,0xFF,0xA3,0x58,0x4A,0xA2,0x29,
>>> +     0x17,0x49,0x4B,0x21,0x08,0x00,0x31,0x40,
>>> +     0x45,0x40,0x61,0x40,0x81,0x80,0x01,0x01,
>>> +     0x01,0x01,0x01,0x01,0x01,0x01,0x08,0xE8,
>>> +     0x00,0x30,0xF2,0x70,0x5A,0x80,0xB0,0x58,
>>> +     0x8A,0x00,0xBA,0x88,0x21,0x00,0x00,0x1E,
>>> +     0x02,0x3A,0x80,0x18,0x71,0x38,0x2D,0x40,
>>> +     0x58,0x2C,0x45,0x00,0xBA,0x88,0x21,0x00,
>>> +     0x00,0x1E,0x00,0x00,0x00,0xFC,0x00,0x50,
>>> +     0x61,0x6E,0x61,0x73,0x6F,0x6E,0x69,0x63,
>>> +     0x2D,0x54,0x56,0x0A,0x00,0x00,0x00,0xFD,
>>> +     0x00,0x17,0x3D,0x0F,0x88,0x3C,0x00,0x0A,
>>> +     0x20,0x20,0x20,0x20,0x20,0x20,0x01,0xA0,
>>> +
>>> +     0x02,0x03,0x4F,0xF0,0x57,0x1F,0x10,0x14,
>>> +     0x05,0x20,0x21,0x22,0x13,0x04,0x12,0x03,
>>> +     0x16,0x07,0x60,0x61,0x5D,0x5E,0x5F,0x65,
>>> +     0x66,0x62,0x63,0x64,0x23,0x09,0x07,0x01,
>>> +     0x7E,0x03,0x0C,0x00,0x40,0x00,0xB8,0x3C,
>>> +     0x2F,0xC8,0x90,0x01,0x02,0x03,0x04,0x81,
>>> +     0x41,0x01,0x9C,0x06,0x16,0x08,0x00,0x18,
>>> +     0x00,0x96,0xA6,0x98,0x00,0xA8,0x00,0x67,
>>> +     0xD8,0x5D,0xC4,0x01,0x78,0x80,0x03,0xE2,
>>> +     0x00,0x4B,0xE4,0x0F,0x00,0x60,0x0C,0x56,
>>> +     0x5E,0x00,0xA0,0xA0,0xA0,0x29,0x50,0x30,
>>> +     0x20,0x35,0x00,0xBA,0x88,0x21,0x00,0x00,
>>> +     0x1A,0x66,0x21,0x56,0xAA,0x51,0x00,0x1E,
>>> +     0x30,0x46,0x8F,0x33,0x00,0xBA,0x88,0x21,
>>> +     0x00,0x00,0x1E,0x00,0x00,0x00,0x00,0x00,
>>> +     0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x5F
>>> +};
>>
>> Running 'edid-decode -c' (git://linuxtv.org/edid-decode.git) results in a number
>> of warnings and failures:
>>
>> ----------------
>>
>> edid-decode SHA: 2d44e1b01c7e 2023-03-11 18:21:51
>>
>> Warnings:
>>
>> Block 1, CTA-861 Extension Block:
>>   Video Data Block: VIC 31 is the preferred timing, overriding the first detailed timings. Is this intended?
>>   Video Capability Data Block: Set Selectable YCbCr Quantization to avoid interop issues.
>>   Add a Colorimetry Data Block with the sRGB colorimetry bit set to avoid interop issues.
>>
>> Failures:
>>
>> Block 0, Base EDID:
>>   Detailed Timing Descriptor #1: Mismatch of image size 698x392 mm vs display size 1280x720 mm.
>>   Detailed Timing Descriptor #2: Mismatch of image size 698x392 mm vs display size 1280x720 mm.
>> Block 1, CTA-861 Extension Block:
>>   Detailed Timing Descriptor #3: Mismatch of image size 698x392 mm vs display size 1280x720 mm.
>>   Detailed Timing Descriptor #4: Mismatch of image size 698x392 mm vs display size 1280x720 mm.
>>
>> EDID conformity: FAIL
> 
> To be honest, I just put in a random EDID so that the user can start
> grabbing frames without having to set one (it was useful for testing).
> It's not significant in any way. Should I remove it?

This driver is used for a specific use-case, and it is one for which it is fine
to put in a default EDID. But, if you do so, then you should make sure you use
an EDID that passes the edid-decode checks.

It also has to match the hardware capabilities.

Regards,

	Hans

