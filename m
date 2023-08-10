Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC67C7778C5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbjHJMpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjHJMpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:45:04 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Aug 2023 05:45:03 PDT
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B874BEA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 05:45:03 -0700 (PDT)
X-KPN-MessageId: 6b3f9ae7-377b-11ee-8e3d-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 6b3f9ae7-377b-11ee-8e3d-005056aba152;
        Thu, 10 Aug 2023 14:42:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=HowLJ8+Ng82Di2D1aJp/zvZPQ8vhxRE7UzfB9IN8W6k=;
        b=VivkQx45Bq+M30CfboL07h2XIRwmI37I3au0JemKTXpp0gi/YJLCARPdxwPwE3IKSqb/0S7nOWXiK
         NGOJLyZ0D+MpOvWKuVMvx7Rq0E/MDREHwklM7coMzBtml2yLSkIk3GX5yHDrgbqc5lIwaH9kd2MIwo
         HS5IODzVowlwJ1sC+RY6b0KFYKa+rk7nRrx2biP9BxwcVUohnvMUvmTYLzvM2HHC4/GNPFiYbHfj1T
         bkqjaEAmd+8BX/e4YqQKFEaFJB1J4ZQ6IQM98S00Jyf/EjjEHQ3oGBXjnPD3iZU6gy8oh4yUYWrwC4
         zwkSMVpqLRBhABVFaEr7nvXZjzYZD3Q==
X-KPN-MID: 33|HCUVSATiQpstskS/nP/GIwp+i9WZv7cayXdp3eq6SZz8xLVDuuU+uy2iSvLVNVk
 E/z8a+xwhwqJ+Gq8znewIIARRsMQZSY8H4KwkNnmIhjs=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|cjKmQZmMDO6xR0VAwoflzoqX7uNQIH618fMMmhu0T55a5MxnpM3WA5migWX4I3z
 0776CXvvdJEMYoGtUiI01CA==
X-Originating-IP: 173.38.220.44
Received: from [10.47.77.214] (unknown [173.38.220.44])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 939a1405-377b-11ee-bd18-005056ab7447;
        Thu, 10 Aug 2023 14:43:59 +0200 (CEST)
Message-ID: <f30f6521-6854-02ce-3365-c18241e16c05@xs4all.nl>
Date:   Thu, 10 Aug 2023 14:43:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v8 2/2] Added Digiteq Automotive MGB4 driver documentation
Content-Language: en-US
To:     =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Martin_T=c5=afma?= <martin.tuma@digiteqautomotive.com>
References: <20230704131339.2177-1-tumic@gpxsee.org>
 <20230704131339.2177-3-tumic@gpxsee.org>
 <bf859616-601e-1dc3-2696-803a8edbd8ab@xs4all.nl>
 <067ddd6c-8dc0-91bb-9991-e975c53a1947@gpxsee.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <067ddd6c-8dc0-91bb-9991-e975c53a1947@gpxsee.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/23 13:54, Martin Tůma wrote:
> On 26. 07. 23 12:40, Hans Verkuil wrote:
>> On 04/07/2023 15:13, tumic@gpxsee.org wrote:
>>> From: Martin Tůma <martin.tuma@digiteqautomotive.com>
>>>
>>> The "admin-guide" documentation for the Digiteq Automotive MGB4 driver.
>>>
>>> Signed-off-by: Martin Tůma <martin.tuma@digiteqautomotive.com>
>>> ---
>>>   Documentation/admin-guide/media/mgb4.rst      | 369 ++++++++++++++++++
>>>   .../admin-guide/media/pci-cardlist.rst        |   1 +
>>>   .../admin-guide/media/v4l-drivers.rst         |   1 +
>>>   3 files changed, 371 insertions(+)
>>>   create mode 100644 Documentation/admin-guide/media/mgb4.rst
>>>
>>> diff --git a/Documentation/admin-guide/media/mgb4.rst b/Documentation/admin-guide/media/mgb4.rst
>>> new file mode 100644
>>> index 000000000000..e1bb708a2265
>>> --- /dev/null
>>> +++ b/Documentation/admin-guide/media/mgb4.rst
>>> @@ -0,0 +1,369 @@
>>> +.. SPDX-License-Identifier: GPL-2.0
>>> +
>>> +====================
>>> +mgb4 sysfs interface
>>> +====================
>>> +
>>> +The mgb4 driver provides a sysfs interface, that is used to configure video
>>> +stream related parameters (some of them must be set properly before the v4l2
>>> +device can be opened) and obtain the video device/stream status.
>>> +
>>> +There are two types of parameters - global / PCI card related, found under
>>> +``/sys/class/video4linux/videoX/device`` and module specific found under
>>> +``/sys/class/video4linux/videoX``.
>>> +
>>> +
>>> +Global (PCI card) parameters
>>> +============================
>>> +
>>> +**module_type** (R):
>>> +    Module type.
>>> +
>>> +    | 0 - No module present
>>> +    | 1 - FPDL3
>>> +    | 2 - GMSL
>>> +
>>> +**module_version** (R):
>>> +    Module version number. Zero in case of a missing module.
>>> +
>>> +**fw_type** (R):
>>> +    Firmware type.
>>> +
>>> +    | 1 - FPDL3
>>> +    | 2 - GMSL
>>> +
>>> +**fw_version** (R):
>>> +    Firmware version number.
>>> +
>>> +**serial_number** (R):
>>> +    Card serial number. The format is::
>>> +
>>> +        PRODUCT-REVISION-SERIES-SERIAL
>>> +
>>> +    where each component is a 8b number.
>>> +
>>> +
>>> +Common FPDL3/GMSL input parameters
>>> +==================================
>>> +
>>> +**input_id** (R):
>>> +    Input number ID, zero based.
>>> +
>>> +**oldi_lane_width** (RW):
>>> +    Number of deserializer output lanes.
>>> +
>>> +    | 0 - single
>>> +    | 1 - dual
>>> +
>>> +**color_mapping** (RW):
>>> +    Mapping of the incoming bits in the signal to the colour bits of the pixels.
>>> +
>>> +    | 0 - OLDI/JEIDA
>>> +    | 1 - SPWG/VESA
>>> +
>>> +**link_status** (R):
>>> +    Video link status. If the link is locked, chips are properly connected and
>>> +    communicating at the same speed and protocol. The link can be locked without
>>> +    an active video stream.
>>> +
>>> +    A value of 0 is equivalent to the V4L2_IN_ST_NO_SYNC flag of the V4L2
>>> +    VIDIOC_ENUMINPUT status bits.
>>> +
>>> +    | 0 - unlocked
>>> +    | 1 - locked
>>> +
>>> +**stream_status** (R):
>>> +    Video stream status. A stream is detected if the link is locked, the input
>>> +    pixel clock is running and the DE signal is moving.
>>> +
>>> +    A value of 0 is equivalent to the V4L2_IN_ST_NO_SIGNAL flag of the V4L2
>>> +    VIDIOC_ENUMINPUT status bits.
>>> +
>>> +    | 0 - not detected
>>> +    | 1 - detected
>>> +
>>> +**video_width** (R):
>>> +    Video stream width. This is the actual width as detected by the HW.
>>> +
>>> +    The value is identical to what VIDIOC_QUERY_DV_TIMINGS returns in the width
>>> +    field of the v4l2_bt_timings struct.
>>> +
>>> +**video_height** (R):
>>> +    Video stream height. This is the actual height as detected by the HW.
>>> +
>>> +    The value is identical to what VIDIOC_QUERY_DV_TIMINGS returns in the height
>>> +    field of the v4l2_bt_timings struct.
>>> +
>>> +**vsync_status** (R):
>>> +    The type of VSYNC pulses as detected by the video format detector.
>>> +
>>> +    The value is equivalent to the flags returned by VIDIOC_QUERY_DV_TIMINGS in
>>> +    the polarities field of the v4l2_bt_timings struct.
>>> +
>>> +    | 0 - active low
>>> +    | 1 - active high
>>> +    | 2 - not available
>>> +
>>> +**hsync_status** (R):
>>> +    The type of HSYNC pulses as detected by the video format detector.
>>> +
>>> +    The value is equivalent to the flags returned by VIDIOC_QUERY_DV_TIMINGS in
>>> +    the polarities field of the v4l2_bt_timings struct.
>>> +
>>> +    | 0 - active low
>>> +    | 1 - active high
>>> +    | 2 - not available
>>> +
>>> +**vsync_gap_length** (RW):
>>> +    If the incoming video signal does not contain synchronization VSYNC and
>>> +    HSYNC pulses, these must be generated internally in the FPGA to achieve
>>> +    the correct frame ordering. This value indicates, how many "empty" pixels
>>
>> Pixels or lines? This is vsync, so lines would be more logical.
>>
>> Even if the hardware wants pixels, perhaps the driver should use lines and
>> translate it to pixels. It's much easier for userspace to work with lines.
>>
> 
> According to our HW engineers, this is properly documented. I do not 
> have the full insight to the "signal parameters" topic, so my answers 
> here will be just some kind of "free" translation of what I got. The 
> justification here was, that the vsync gap length (in our case/HW) 
> represents something slightly different than you may think.
> 
>>> +    (pixels with deasserted Data Enable signal) are necessary to generate the
>>> +    internal VSYNC pulse.
>>> +
>>> +**hsync_gap_length** (RW):
>>> +    If the incoming video signal does not contain synchronization VSYNC and
>>> +    HSYNC pulses, these must be generated internally in the FPGA to achieve
>>> +    the correct frame ordering. This value indicates, how many "empty" pixels
>>> +    (pixels with deasserted Data Enable signal) are necessary to generate the
>>> +    internal HSYNC pulse. The value must be greater than 1 and smaller than
>>> +    vsync_gap_length.
>>
>> Does this make sense? vsync_gap_length can be many video lines, which makes
>> not sense for hsync_gap_length.
>>
>> I wonder if it isn't easier to just change this to v/hsync_blanking_length
>> (lines for vsync, pixels for hsync) to indicate the length of the blanking
>> periods, and then let the driver pick a suitable hsync/vsync position.
>>
> 
> Dtto.

So the problem here is that if I don't understand what is meant here, how will
a user of this driver be able to understand it?

I think it would be better to give one or two examples of devices and their
configuration. Or refer to freely available documentation, if that is available.

Also note that v9 doesn't mentioned default values for these two properties.

Regards,

	Hans
