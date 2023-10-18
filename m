Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628647CD89F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjJRJxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJRJxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:53:10 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FCDFA;
        Wed, 18 Oct 2023 02:53:07 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id ED4638043;
        Wed, 18 Oct 2023 17:52:59 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 18 Oct
 2023 17:53:00 +0800
Received: from [192.168.1.218] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 18 Oct
 2023 17:52:59 +0800
Message-ID: <6f5da0fa-9c01-dab2-647e-2a3c0a50b316@starfivetech.com>
Date:   Wed, 18 Oct 2023 17:52:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v10 0/8] Add StarFive Camera Subsystem driver
Content-Language: en-US
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        <bryan.odonoghue@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        <changhuang.liang@starfivetech.com>
References: <20231008085154.6757-1-jack.zhu@starfivetech.com>
 <98297bfc-ab81-4bb5-acc3-619fdf879276@xs4all.nl>
 <bb5b776c-f1dd-f53e-079c-8048af2e73f1@starfivetech.com>
 <4a74a40c-ee3c-4563-87d1-27e859eb6982@xs4all.nl>
 <687a4c58-3666-1c7b-fcfd-d586c28dea35@starfivetech.com>
 <56a09e21-5f43-4d0d-b603-777bbfd1885f@xs4all.nl>
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <56a09e21-5f43-4d0d-b603-777bbfd1885f@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/18 17:31, Hans Verkuil wrote:
> On 18/10/2023 11:25, Jack Zhu wrote:
>> 
>> 
>> On 2023/10/18 16:50, Hans Verkuil wrote:
>>> Hi Jack,
>>>
>>> On 18/10/2023 04:37, Jack Zhu wrote:
>>>
>>> <snip>
>>>
>>>>>> --------------------------------------------------------------------------------
>>>>>> Compliance test for device /dev/v4l-subdev1:
>>>>>>
>>>>>> Driver Info:
>>>>>> 	Driver version   : 6.6.0
>>>>>> 	Capabilities     : 0x00000000
>>>>>
>>>>> But this does not appear for v4l-subdev1.
>>>>>
>>>>> I can't really tell why it doesn't show that. Can you debug a little bit?
>>>>> The code is in v4l2-compliance.cpp, line 1086:
>>>>>
>>>>> ent_id = mi_media_info_for_fd(media_fd, node.g_fd(), &is_invalid, &node.function);
>>>>>
>>>>> The mi_media_info_for_fd() function calls ioctl(media_fd, MEDIA_IOC_DEVICE_INFO, &mdinfo),
>>>>> and that fails for some reason. It could be that media_fd is invalid (would be weird).
>>>>>
>>>>> This could well be a v4l2-compliance bug that you hit with this driver.
>>>>>
>>>>
>>>> On the test board, /dev/v4l-subdev1 is imx219, and the corresponding directory is
>>>> /sys/dev/char/81:3/device. Media0 does not exist in this directory. Therefore, the media_fd
>>>> obtained through mi_get_media_fd(node.g_fd(), node.bus_info) is invalid.
>>>>
>>>> I don't know why media0 does not exist in /sys/dev/char/81:3/device?
>>>>
>>>
>>> Can you try again with this v4l2-compliance patch?
>>>
>>> I need to dig a bit deeper as to why media0 is missing, but for now try this.
>>>
>>> Regards,
>>>
>>> 	Hans
>>>
>>> diff --git a/utils/v4l2-compliance/v4l2-compliance.cpp b/utils/v4l2-compliance/v4l2-compliance.cpp
>>> index 7169eefe..29475d6b 100644
>>> --- a/utils/v4l2-compliance/v4l2-compliance.cpp
>>> +++ b/utils/v4l2-compliance/v4l2-compliance.cpp
>>> @@ -968,7 +968,7 @@ err:
>>>  }
>>>
>>>  void testNode(struct node &node, struct node &node_m2m_cap, struct node &expbuf_node, media_type type,
>>> -	      unsigned frame_count, unsigned all_fmt_frame_count)
>>> +	      unsigned frame_count, unsigned all_fmt_frame_count, int parent_media_fd)
>>>  {
>>>  	struct node node2;
>>>  	struct v4l2_capability vcap = {};
>>> @@ -997,8 +997,12 @@ void testNode(struct node &node, struct node &node_m2m_cap, struct node &expbuf_
>>>  		memset(&vcap, 0, sizeof(vcap));
>>>  	}
>>>
>>> -	if (!node.is_media())
>>> -		media_fd = mi_get_media_fd(node.g_fd(), node.bus_info);
>>> +	if (!node.is_media()) {
>>> +		if (parent_media_fd >= 0)
>>> +			media_fd = parent_media_fd;
>>> +		else
>>> +			media_fd = mi_get_media_fd(node.g_fd(), node.bus_info);
>>> +	}
>>>
>>>  	int fd = node.is_media() ? node.g_fd() : media_fd;
>>>  	if (fd >= 0) {
>>> diff --git a/utils/v4l2-compliance/v4l2-compliance.h b/utils/v4l2-compliance/v4l2-compliance.h
>>> index 7caf254b..c47f25f5 100644
>>> --- a/utils/v4l2-compliance/v4l2-compliance.h
>>> +++ b/utils/v4l2-compliance/v4l2-compliance.h
>>> @@ -308,7 +308,7 @@ int check_ustring(const __u8 *s, int len);
>>>  int check_0(const void *p, int len);
>>>  int restoreFormat(struct node *node);
>>>  void testNode(struct node &node, struct node &node_m2m_cap, struct node &expbuf_node, media_type type,
>>> -	      unsigned frame_count, unsigned all_fmt_frame_count);
>>> +	      unsigned frame_count, unsigned all_fmt_frame_count, int parent_media_fd = -1);
>>>  std::string stream_from(const std::string &pixelformat, bool &use_hdr);
>>>
>>>  // Media Controller ioctl tests
>>>
>> 
>> From the log, there is no change.
> 
> Oops, my mistake. Also apply this change:
> 
> diff --git a/utils/v4l2-compliance/v4l2-test-media.cpp b/utils/v4l2-compliance/v4l2-test-media.cpp
> index 0195ac58..52ab7fb8 100644
> --- a/utils/v4l2-compliance/v4l2-test-media.cpp
> +++ b/utils/v4l2-compliance/v4l2-test-media.cpp
> @@ -612,7 +612,7 @@ void walkTopology(struct node &node, struct node &expbuf_node,
>  		}
> 
>  		testNode(test_node, test_node, expbuf_node, type,
> -			 frame_count, all_fmt_frame_count);
> +			 frame_count, all_fmt_frame_count, node.g_fd());
>  		test_node.close();
>  	}
>  }
> 

Can see relevant Info in the log.

test log:
--------------------------------------------------------------------------------
Compliance test for starfive-camss device /dev/v4l-subdev1:

Driver Info:
	Driver version   : 6.6.0
	Capabilities     : 0x00000000
Media Driver Info:
	Driver name      : starfive-camss
	Model            : Starfive Camera Subsystem
	Serial           : 
	Bus info         : platform:19840000.camss
	Media version    : 6.6.0
	Hardware revision: 0x00000000 (0)
	Driver version   : 6.6.0
Interface Info:
	ID               : 0x0300001e
	Type             : V4L Sub-Device
Entity Info:
	ID               : 0x00000018 (24)
	Name             : imx219 6-0010
	Function         : Camera Sensor
	Pad 0x01000019   : 0: Source
	  Link 0x0200001a: to remote pad 0x100000f of entity 'cdns_csi2rx.19800000.csi-bridge' (Video Interface Bridge): Data, Enabled, Immutable

Required ioctls:
	test MC information (see 'Media Driver Info' above): OK
	test VIDIOC_SUDBEV_QUERYCAP: OK
	test invalid ioctls: OK

Allow for multiple opens:
	test second /dev/v4l-subdev1 open: OK
	test VIDIOC_SUBDEV_QUERYCAP: OK
	test for unlimited opens: OK

Debug ioctls:
	test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
	test VIDIOC_ENUMAUDIO: OK (Not Supported)
	test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
	test VIDIOC_G/S_AUDIO: OK (Not Supported)
	Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
	Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
	test VIDIOC_G/S_EDID: OK (Not Supported)

Sub-Device ioctls (Source Pad 0):
	Try Stream 0
	test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
	test Try VIDIOC_SUBDEV_G/S_FMT: OK
		warn: ../utils/v4l2-compliance/v4l2-test-subdevs.cpp(541): VIDIOC_SUBDEV_G_SELECTION is supported for target 0 but not VIDIOC_SUBDEV_S_SELECTION
	test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK
	Active Stream 0
	test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
	test Active VIDIOC_SUBDEV_G/S_FMT: OK
		warn: ../utils/v4l2-compliance/v4l2-test-subdevs.cpp(541): VIDIOC_SUBDEV_G_SELECTION is supported for target 0 but not VIDIOC_SUBDEV_S_SELECTION
	test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK
	test VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Control ioctls:
	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
	test VIDIOC_QUERYCTRL: OK
	test VIDIOC_G/S_CTRL: OK
	test VIDIOC_G/S/TRY_EXT_CTRLS: OK
	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
	Standard Controls: 20 Private Controls: 0

Format ioctls:
	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK (Not Supported)
	test VIDIOC_G/S_PARM: OK (Not Supported)
	test VIDIOC_G_FBUF: OK (Not Supported)
	test VIDIOC_G_FMT: OK (Not Supported)
	test VIDIOC_TRY_FMT: OK (Not Supported)
	test VIDIOC_S_FMT: OK (Not Supported)
	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
	test Cropping: OK (Not Supported)
	test Composing: OK (Not Supported)
	test Scaling: OK (Not Supported)

Codec ioctls:
	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
	test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls:
	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK (Not Supported)
	test VIDIOC_EXPBUF: OK (Not Supported)
	test Requests: OK (Not Supported)

Total for starfive-camss device /dev/v4l-subdev1: 51, Succeeded: 51, Failed: 0, Warnings: 2

Grand Total for starfive-camss device /dev/media0: 209, Succeeded: 209, Failed: 0, Warnings: 2
# 

-- 
Regards,

Jack Zhu
