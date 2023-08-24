Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870F2787404
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241393AbjHXPX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242175AbjHXPX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:23:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0678B19B2;
        Thu, 24 Aug 2023 08:23:23 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OEZQuY002270;
        Thu, 24 Aug 2023 15:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fRFa1Ju/IcoSsvJ9gYhluqBnlOmg8wcmIF9mWKN5gRM=;
 b=UxGAW6abs2Pa2367ubXrknGHSXt7o5O7PKoupAVhpOVvVi/lDhoC8F0aB+ZuxPKFbb1D
 VVL+vnfIlwpY7XcEFGuRa7kPA/QaoxrHMxBYLiAGvJ8om4iKYHVVQAJSLkKql4hLPCXo
 QARnr+CK1h/orTM5Er+rwZK4+JXg28v82AuPBtIjx1lpvp6BMoOHtj7kRU+bEop12PLf
 V8lzF7WT+6tccReqQuOK/IrXrAuRgn9H3ThzUqUkfUmd+G4ElUjYGNVnBIzYYo94GWbI
 ulEF3ov6LGNyk33IsOZlgwa1ZytXQVdplKMVhMOhc/4RU0Zd57yrn89dc65i2YTfsAgt gg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3snkumty3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 15:23:17 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37OFNFeL026321
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 15:23:16 GMT
Received: from [10.50.25.183] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 24 Aug
 2023 08:23:12 -0700
Message-ID: <8c97d866-1cab-0106-4ab3-3ca070945ef7@quicinc.com>
Date:   Thu, 24 Aug 2023 20:53:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/33] Qualcomm video decoder/encoder driver
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mchehab@kernel.org>,
        <hans.verkuil@cisco.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_dikshita@quicinc.com>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <e18b951e-7f15-2c67-9099-c45ea7f67daa@linaro.org>
 <d80b5338-2eca-0223-d2a7-d6f7d39a28ba@gmail.com>
 <CAA8EJpqArfMcxvJV2zxea8_C4VHY06MsU-Jw3pPXbu5Gxw-ccg@mail.gmail.com>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <CAA8EJpqArfMcxvJV2zxea8_C4VHY06MsU-Jw3pPXbu5Gxw-ccg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pyMctkSnSgK2tBnzLn-YWKR_YqIOCGbF
X-Proofpoint-ORIG-GUID: pyMctkSnSgK2tBnzLn-YWKR_YqIOCGbF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_12,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=758
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308240129
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 8/14/2023 8:30 PM, Dmitry Baryshkov wrote:
> Hi Stan,
> 
> On Mon, 14 Aug 2023 at 15:58, Stanimir Varbanov
> <stanimir.k.varbanov@gmail.com> wrote:
>>
>> Hi Dmitry,
>>
>> On 28.07.23 г. 17:01 ч., Dmitry Baryshkov wrote:
>>> On 28/07/2023 16:23, Vikash Garodia wrote:
>>>> This patch series introduces support for Qualcomm new video acceleration
>>>> hardware architecture, used for video stream decoding/encoding. This
>>>> driver
>>>> is based on new communication protocol between video hardware and
>>>> application
>>>> processor.
>>>>
>>>> This driver comes with below capabilities:
>>>> - V4L2 complaint video driver with M2M and STREAMING capability.
>>>> - Supports H264, H265, VP9 decoders.
>>>> - Supports H264, H265 encoders.
>>>
>>> Please describe, why is it impossible to support this hardware in the
>>> venus driver. We do not usually add new drivers for the new generations
>>> of the hardware, unless it is fully incompatible with the previous
>>> generations. Let me point you to camss or drm/msm drivers. They have
>>> successfully solved the issue of supporting multiple generations of the
>>> hardware in the same driver.
>>>
>>> Unless the "iris3" is completely different from all the previous
>>> generations, I strongly suggest spending time on restructuring existing
>>> venus driver and then adding support for the new hardware there instead
>>> of dumping out something completely new.
>>
>> AFAIK the major differences are HW IP and firmware interface (by
>> firmware interface I mean a protocol, API and API behavior). The
>> firmware and its interface has been re-written to align closely with the
>> current v4l2 specs for encoders/decoders state machines [1][2]. On the
>> other side current mainline Venus driver firmware is following interface
>> similar to OpenMAX.
>>
>> There are incompatibilities between both firmware interfaces which
>> cannot easily combined in a common driver. Even if there is a
>> possibility to do that it will lead us to a unreadable driver source
>> code and maintenance burden.
> 
> Thank you for your explanation!
> 
> If the hardware is more or less the same, then the existing venus
> driver should be refactored and split into hardware driver and the
> firmware interface. Then iris3 can come up as a second driver
> implementing support for new firmware interface but utilising common
> hardware-related code.

Its not just about supporting the new firmware interface because if that was the
case, it would have been a simple change. Its also about how the new firmware
interface affects the rest of the video sub-modules and state handling.
We incrementally evaluated whether putting the pieces one by one would make
sense but it doesn’t as every layer got affected and as a whole we decided to go
with this approach.
To elaborate more, let me try to put one of sequence which can provide info on
firmware interface and its handling across different video layers.

>> Vikash, could elaborate more on firmware interface differences.

Many new interfaces are added. Explained below one such video usecase of
handling dynamic resolution change (DRC) during drain. Illustrated a pseudo code
on how this will look if we fit this in venus driver.

- Client issues a STOP command. The command goes through state-wise command
handling, which also checks for cases like back to back drain. Vidc layer, which
handles common encoder and decoder functionality, routes it to decoder stop.
Decoder and driver layer then submits the command "HFI_CMD_DRAIN" to hardware
and moves the sub state to "MSM_VIDC_DRAIN".
- Now before drain is completed, there is a resolution change in one of the
frame queued before drain. Driver receives "HFI_CMD_SETTINGS_CHANGE" in hfi
response layer. The response goes through state check if received in intended
state and if good, changes the state to "MSM_VIDC_DRC | MSM_VIDC_INPUT_PAUSE".
Any further input processing remain paused at this point. The decoder layer then
parses all the bitstream parameters which were subscribed by the driver.
V4L2_EVENT_SOURCE_CHANGE event is raised to client.
- Hardware respond with HFI_INFO_HFI_FLAG_PSC_LAST to indicate LAST frame with
old sequence. Driver substate is added with "MSM_VIDC_DRC_LAST_BUFFER |
MSM_VIDC_OUTPUT_PAUSE". At this point, driver is in state, STREAMING and
substate - MSM_VIDC_DRAIN | MSM_VIDC_DRC | MSM_VIDC_INPUT_PAUSE |
MSM_VIDC_DRC_LAST_BUFFER | MSM_VIDC_OUTPUT_PAUSE. This is when both hardware as
well as driver is paused while waiting for further instructions.
- Client issues START cmd. Vidc layer routes it to decoder layer which checks
for sub states and then allocates/queues internal buffers. At this point, DRC
sequence is completed and substates "MSM_VIDC_DRC | MSM_VIDC_DRC_LAST_BUFFER"
are cleared and both input and output planes are resumed with HFI
"HFI_CMD_RESUME". substate "MSM_VIDC_INPUT_PAUSE" and "MSM_VIDC_OUTPUT_PAUSE" is
cleared as well. So driver is in streaming state with sub state as "MSM_VIDC_DRAIN"
- Hardware issues a response to "HFI_CMD_DRAIN". As part of handling of this,
driver adds to sub state "MSM_VIDC_INPUT_PAUSE". This is done to avoid any
further input processing. Once all the frames are processed, hardware raises HFI
"HFI_INFO_HFI_FLAG_DRAIN_LAST". After doing state check, further sub states
"MSM_VIDC_DRAIN_LAST_BUFFER | MSM_VIDC_OUTPUT_PAUSE" are added. So at this
point, the sub states are MSM_VIDC_DRAIN, MSM_VIDC_DRAIN_LAST_BUFFER,
MSM_VIDC_INPUT_PAUSE and MSM_VIDC_OUTPUT_PAUSE.
- Any pair calls like VIDIOC_STREAMON()/VIDIOC_STREAMOFF() on output or capture
queue, resets the substate to stream again.

If the same needs to be added in venus driver

- Client issues a STOP cmd to initiate drain. Decoder layer for stop handling
needs to be updated something like below //pseudo code  if (old interface)
   send dummy buffer
   change state to VENUS_DEC_STATE_DRAIN
   drain_active = true
 else
   statewise validation of STOP cmd
   state check for back to back drain
   issue HFI_CMD_DRAIN to hardware
   change sub state = MSM_VIDC_DRAIN

- DRC is issued by hardware
  if (old interface) //vdec and hfi response layer
   HFI_EVENT_SESSION_SEQUENCE_CHANGED with type
HFI_EVENT_DATA_SEQUENCE_CHANGED_SUFFICIENT_BUF_RESOURCES
   changes state to VENUS_DEC_STATE_DRC
   next_buf_last = true
   flush (output)
   reconfig = true
   raise V4L2_EVENT_SOURCE_CHANGE event to client
  else
   HFI_CMD_SETTINGS_CHANGE // in hfi response layer
   state validation for intended state // in state handling layer
   sub state |= MSM_VIDC_DRC | MSM_VIDC_INPUT_PAUSE
   raise V4L2_EVENT_SOURCE_CHANGE event to client

- LAST flag handling
  if (old interface)
    No LAST flag HFI from hardware
    in qbuf_capture
      if (next_buf_last) associated LAST flag
  else
    handle HFI_INFO_HFI_FLAG_PSC_LAST //in response layer
    sub state |= MSM_VIDC_DRC_LAST_BUFFER | MSM_VIDC_OUTPUT_PAUSE

- Client issues START cmd
  if (old interface)
    does not handle VENUS_DEC_STATE_DRC state
  else
    sub state &= ~(MSM_VIDC_DRC | MSM_VIDC_DRC_LAST_BUFFER)
    allocates and queue internal buffer
    call HFI_CMD_RESUME for input and output
    sub state &= ~(MSM_VIDC_INPUT_PAUSE|MSM_VIDC_OUTPUT_PAUSE)

- Hardware response for HFI_CMD_DRAIN
  if (old interface)
    Nothing to do.
  else
    sub state |= MSM_VIDC_INPUT_PAUSE

- Handling for drain LAST flag
  if (old interface)
    receives dummy buffer with EOS
    converts to LAST and send to client
  else
    process HFI_INFO_HFI_FLAG_DRAIN_LAST
    sub state |= MSM_VIDC_DRAIN_LAST_BUFFER | MSM_VIDC_OUTPUT_PAUSE

There are many such complex sequences which would add to complexity if we try to
fit them into existing driver.

> Do we have any details on firmware versions that implement older
> (OpenMAX-like) interface vs versions implementing new (v4l2-like)
> interface?
> 
>> [1]
>> https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/dev-decoder.html
>>
>> [2]
>> https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/dev-encoder.html

Thanks,
Vikash
