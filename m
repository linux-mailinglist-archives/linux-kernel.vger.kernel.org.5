Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789D9806D6F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378025AbjLFLIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377955AbjLFLIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:08:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA4AD71
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:08:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91072C433C7;
        Wed,  6 Dec 2023 11:08:44 +0000 (UTC)
Message-ID: <5595805b-8017-4bcd-bcbc-fd0a75f9c3dc@xs4all.nl>
Date:   Wed, 6 Dec 2023 12:08:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/5] media: platform: visconti: add V4L2 vendor
 specific control handlers
Content-Language: en-US, nl
To:     yuji2.ishikawa@toshiba.co.jp, laurent.pinchart@ideasonboard.com
Cc:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nobuhiro1.iwamatsu@toshiba.co.jp, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231012071329.2542003-1-yuji2.ishikawa@toshiba.co.jp>
 <20231012071329.2542003-4-yuji2.ishikawa@toshiba.co.jp>
 <6095bd3d-2580-44e2-b622-3ad31e12787f@xs4all.nl>
 <a84ce942-e6df-414e-8d0c-e7d3ef3e62f6@xs4all.nl>
 <20231114095331.GA13826@pendragon.ideasonboard.com>
 <TYAPR01MB62019C91FAC70080B967D34792BDA@TYAPR01MB6201.jpnprd01.prod.outlook.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <TYAPR01MB62019C91FAC70080B967D34792BDA@TYAPR01MB6201.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2023 01:46, yuji2.ishikawa@toshiba.co.jp wrote:
> Hello Laurent,
> 
> Thank you for your comment.
> 
>> -----Original Message-----
>> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Sent: Tuesday, November 14, 2023 6:54 PM
>> To: Hans Verkuil <hverkuil@xs4all.nl>
>> Cc: ishikawa yuji(石川 悠司 ○ＲＤＣ□ＡＩＴＣ○ＥＡ開)
>> <yuji2.ishikawa@toshiba.co.jp>; Mauro Carvalho Chehab
>> <mchehab@kernel.org>; Rob Herring <robh+dt@kernel.org>; Krzysztof
>> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
>> <conor+dt@kernel.org>; iwamatsu nobuhiro(岩松 信洋 ○ＤＩＴＣ□ＤＩＴ○
>> ＯＳＴ) <nobuhiro1.iwamatsu@toshiba.co.jp>; linux-media@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v9 3/5] media: platform: visconti: add V4L2 vendor
>> specific control handlers
>>
>> On Tue, Nov 14, 2023 at 10:10:50AM +0100, Hans Verkuil wrote:
>>> On 14/11/2023 10:02, Hans Verkuil wrote:
>>>> On 12/10/2023 09:13, Yuji Ishikawa wrote:
>>>>> Add support to Image Signal Processors of Visconti's Video Input
>> Interface.
>>>>> This patch adds vendor specific compound controls to configure the
>>>>> image signal processor.
>>>>>
>>>>> Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
>>>>> ---
>>>>> Changelog v2:
>>>>> - Resend v1 because a patch exceeds size limit.
>>>>>
>>>>> Changelog v3:
>>>>> - Adapted to media control framework
>>>>> - Introduced ISP subdevice, capture device
>>>>> - Remove private IOCTLs and add vendor specific V4L2 controls
>>>>> - Change function name avoiding camelcase and uppercase letters
>>>>>
>>>>> Changelog v4:
>>>>> - Split patches because the v3 patch exceeds size limit
>>>>> - Stop using ID number to identify driver instance:
>>>>>   - Use dynamically allocated structure to hold HW specific context,
>>>>>     instead of static one.
>>>>>   - Call HW layer functions with the context structure instead of
>>>>> ID number
>>>>>
>>>>> Changelog v5:
>>>>> - no change
>>>>>
>>>>> Changelog v6:
>>>>> - remove unused macros
>>>>> - removed hwd_ and HWD_ prefix
>>>>> - update source code documentation
>>>>> - Suggestion from Hans Verkuil
>>>>>   - pointer to userland memory is removed from uAPI arguments
>>>>>     - style of structure is now "nested" instead of "chained by pointer";
>>>>>   - use div64_u64 for 64bit division
>>>>>   - vendor specific controls support TRY_EXT_CTRLS
>>>>>   - add READ_ONLY flag to GET_CALIBRATION_STATUS control and
>> similar ones
>>>>>   - human friendry control names for vendor specific controls
>>>>>   - add initial value to each vendor specific control
>>>>>   - GET_LAST_CAPTURE_STATUS control is updated asyncnously from
>> workqueue
>>>>>   - remove EXECUTE_ON_WRITE flag of vendor specific control
>>>>>   - uAPI: return value of GET_CALIBRATION_STATUS follows common
>> rules of error codes
>>>>>   - applied v4l2-compliance
>>>>> - Suggestion from Sakari Ailus
>>>>>   - use div64_u64 for 64bit division
>>>>>   - update copyright's year
>>>>>   - remove redandunt cast
>>>>>   - use bool instead of HWD_VIIF_ENABLE/DISABLE
>>>>>   - simplify comparison to 0
>>>>>   - simplify statements with trigram operator
>>>>>   - remove redundant local variables
>>>>>   - use general integer types instead of u32/s32
>>>>> - Suggestion from Laurent Pinchart
>>>>>   - moved VIIF driver to driver/platform/toshiba/visconti
>>>>>   - change register access: struct-style to macro-style
>>>>>   - remove unused type definitions
>>>>>   - define enums instead of successive macro constants
>>>>>   - remove redundant parenthesis of macro constant
>>>>>   - embed struct hwd_res into struct viif_device
>>>>>   - use xxx_dma instead of xxx_paddr for variable names of IOVA
>>>>>   - literal value: just 0 instead of 0x0
>>>>>   - use literal 1 or 0 instead of HWD_VIIF_ENABLE, DISABLE for register
>> access
>>>>>   - use true or false instead of HWD_VIIF_ENABLE, DISABLE for function
>> calls
>>>>>   - uAPI: return value of GET_CALIBRATION_STATUS follows common
>>>>> rules of error codes
>>>>>
>>>>> Changelog v7:
>>>>> - remove unused variables
>>>>> - split long statements which have multiple logical-OR and trigram
>>>>> operators
>>>>>
>>>>> Changelog v8:
>>>>> - define constant V4L2_CTRL_TYPE_VISCONTI_ISP for datatype
>>>>>   of Visconti specific controls
>>>>> - Suggestion from Hans Verkuil
>>>>>   - remove pr_info()
>>>>>   - use pm_runtime_get_if_in_use() to get power status
>>>>>
>>>>> Changelog v9:
>>>>> - fix warning for cast between ptr and dma_addr_t
>>>>>
>>>>>  .../media/platform/toshiba/visconti/Makefile  |    2 +-
>>>>>  .../media/platform/toshiba/visconti/viif.c    |   10 +-
>>>>>  .../platform/toshiba/visconti/viif_controls.c | 3395
>> +++++++++++++++++
>>>>>  .../platform/toshiba/visconti/viif_controls.h |   18 +
>>>>>  .../platform/toshiba/visconti/viif_isp.c      |   15 +-
>>>>>  drivers/media/v4l2-core/v4l2-ctrls-core.c     |    7 +-
>>>>>  include/uapi/linux/videodev2.h                |    2 +
>>>>>  7 files changed, 3431 insertions(+), 18 deletions(-)  create mode
>>>>> 100644 drivers/media/platform/toshiba/visconti/viif_controls.c
>>>>>  create mode 100644
>>>>> drivers/media/platform/toshiba/visconti/viif_controls.h
>>>>>
>>>>
>>>> <snip>
>>>>
>>>> These core changes below should be in a separate patch, not mixed in
>>>> with the driver.
>>>>
>>>>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c
>>>>> b/drivers/media/v4l2-core/v4l2-ctrls-core.c
>>>>> index a662fb60f73f..0c4df9fffbe0 100644
>>>>> --- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
>>>>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
>>>>> @@ -367,7 +367,9 @@ void v4l2_ctrl_type_op_log(const struct v4l2_ctrl
>> *ctrl)
>>>>>  	case V4L2_CTRL_TYPE_AV1_FILM_GRAIN:
>>>>>  		pr_cont("AV1_FILM_GRAIN");
>>>>>  		break;
>>>>> -
>>>>> +	case V4L2_CTRL_TYPE_VISCONTI_ISP:
>>>>> +		pr_cont("VISCONTI_ISP");
>>>>> +		break;
>>>>>  	default:
>>>>>  		pr_cont("unknown type %d", ctrl->type);
>>>>>  		break;
>>>>> @@ -1163,6 +1165,9 @@ static int std_validate_compound(const struct
>> v4l2_ctrl *ctrl, u32 idx,
>>>>>  	case V4L2_CTRL_TYPE_AV1_FILM_GRAIN:
>>>>>  		return validate_av1_film_grain(p);
>>>>>
>>>>> +	case V4L2_CTRL_TYPE_VISCONTI_ISP:
>>>>> +		break;
>>>>> +
>>>>>  	case V4L2_CTRL_TYPE_AREA:
>>>>>  		area = p;
>>>>>  		if (!area->width || !area->height) diff --git
>>>>> a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>>>>> index c3d4e490ce7c..bbc3cd3efa65 100644
>>>>> --- a/include/uapi/linux/videodev2.h
>>>>> +++ b/include/uapi/linux/videodev2.h
>>>>> @@ -1915,6 +1915,8 @@ enum v4l2_ctrl_type {
>>>>>  	V4L2_CTRL_TYPE_AV1_TILE_GROUP_ENTRY = 0x281,
>>>>>  	V4L2_CTRL_TYPE_AV1_FRAME	    = 0x282,
>>>>>  	V4L2_CTRL_TYPE_AV1_FILM_GRAIN	    = 0x283,
>>>>> +
>>>>> +	V4L2_CTRL_TYPE_VISCONTI_ISP = 0x290,
>>>>
>>>> I see you are using the same V4L2_CTRL_TYPE_VISCONTI_ISP for all the
>>>> compound controls. But that's not allowed: the V4L2_CTRL_TYPE_
>>>> defines determine the control type, so each struct used by a control needs
>> its own type.
>>>
>>> Actually, you don't want to add such a type at all. This is all driver
>>> specific, so support like this belongs in the driver.
>>>
>>> A good example of that is
>> V4L2_CID_DW100_DEWARPING_16x16_VERTEX_MAP in
>>> drivers/media/platform/nxp/dw100/dw100.c: there all the handling is
>>> done in the driver, and it adds init/validate/log/equal ops as well.
>>
>> Actually, I think a better option is to use parameters buffers instead of controls,
>> like other ISP driver do.
>>
> 
> I'll quickly make an experimental impl of parameters buffers of the VIIF driver and check if it works well.
> I'm still not for sure passing parameter via parameters buffers satisfies the timing constraint of the HW.

This is the preferred method over using controls.

Note that the 32 bit vs 64 bit requirement still stands, so use pahole to make
sure that whatever data you exchange over the parameter buffer is the same for
both architectures.

Regards,

	Hans

> 
>>>> I also noticed looking through include/uapi/linux/visconti_viif.h
>>>> that some of the struct have holes. I really want to avoid holes in
>>>> structs used by controls, it is bad practice.
>>>>
>>>> The pahole utility is very useful for testing this. It is also
>>>> highly recommended to check for both 32 and 64 bit compilation: the
>>>> struct layout must be the same, otherwise you would run into
>>>> problems if a 32 bit application is used with a 64 bit kernel.
>>>>
>>>> Finally, Laurent and/or Sakari will also take a look at this driver,
>>>> for some reason this driver has been mostly reviewed by me, but I am
>>>> not really the expert on ISPs.
>>>>
>>>>>  };
>>>>>
>>>>>  /*  Used in the VIDIOC_QUERYCTRL ioctl for querying controls */
>>
>> --
>> Regards,
>>
>> Laurent Pinchart
> 
> 
> Regards,
> Yuji

