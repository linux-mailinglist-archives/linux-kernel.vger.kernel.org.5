Return-Path: <linux-kernel+bounces-3547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19009816DAD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66F2284C0C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113894E638;
	Mon, 18 Dec 2023 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cIHOXOrO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7EB59B53;
	Mon, 18 Dec 2023 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIAsAN6013994;
	Mon, 18 Dec 2023 12:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=YNHZbggYM1kxWxhJ5NiTVKj+VuHq75rdtXe13V5X9LE=; b=cI
	HOXOrOvfjwKNgQJQTD3uI4HDqbCE/zUNhq+hyBUwGhM5yySNI3MAFBggEx+12RJ6
	o59LgHGuS3ezvu4CkIxumfnqYbxkzmQC7iuxMOeN5f3mrbRjvv77Mbrz7fktxr47
	30iIyqdQkcHm8/Ypiir/HkCMQLXgWRiyshxmp9zXGLa/2UG/ZPzpfhg6icyybFHX
	fTFeD+mqHKuQqQLuCkXbYDbP8Ts8aD1uz3m5QbzjMpAWMlTR+A4s8191AWhwNW5G
	AJi9sX4vvRH5PNdGWfrs4MV4CPLYt1721RH47SkSe7lYjhwfj7ZMgTEe1u2L3pcY
	YwFIlJvHJ72hPsi4iUsA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2jx0gduk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 12:09:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BIC9nY1001077
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 12:09:49 GMT
Received: from [10.216.62.193] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Dec
 2023 04:09:45 -0800
Message-ID: <b2b3cff9-f7ea-fade-7e0b-23ba500c4b02@quicinc.com>
Date: Mon, 18 Dec 2023 17:39:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 00/34] Qualcomm video encoder and decoder driver
To: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stanimir.k.varbanov@gmail.com>, <quic_vgarodia@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mchehab@kernel.org>,
        <bryan.odonoghue@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <quic_abhinavk@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
Content-Language: en-US
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _Ma2LGzh2zkSZxU09D_Bs_Uf40f9qwAT
X-Proofpoint-GUID: _Ma2LGzh2zkSZxU09D_Bs_Uf40f9qwAT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180087



On 12/18/2023 5:01 PM, Dikshita Agarwal wrote:
> This patch series introduces support for Qualcomm new video acceleration
> hardware architecture, used for video stream decoding/encoding. This driver
> is based on new communication protocol between video hardware and application
> processor.
> This driver comes with below capabilities:
> - V4L2 complaint video driver with M2M and STREAMING capability.
> - Supports H264, H265, VP9 decoders.
> - Supports H264, H265 encoders.
> This driver comes with below features:
> - Centralized resource and memory management.
> - Centralized management of core and instance states.
> - Defines platform specific capabilities and features. As a results, it provides
>   a single point of control to enable/disable a given feature depending on 
>   specific platform capabilities.
> - Handles hardware interdependent configurations. For a given configuration from
>   client, the driver checks for hardware dependent configuration/s and updates
>   the same.
> - Handles multiple complex video scenarios involving state transitions - DRC,
>   Drain, Seek, back to back DRC, DRC during Drain sequence, DRC during Seek
>   sequence.
> - Introduces a flexible way for driver to subscribe for any property with
>   hardware. Hardware would inform driver with those subscribed property with any
>   change in value.
> - Introduces performance (clock and bus) model based on new hardware
>   architecture.
> - Introduces multi thread safe design to handle communication between client and
>   hardware.
> - Adapts encoder quality improvements available in new hardware architecture.
> - Implements asynchronous communication with hardware to achieve better
>   experience in low latency usecases.
> - Supports multi stage hardware architecture for encode/decode.
> - Output and capture planes are controlled independently. Thereby providing a
>   way to reconfigure individual plane.
> - Hardware packetization layer supports synchronization between configuration
>   packet and data packet.
> - Introduces a flexibility to receive a hardware response for a given command
>   packet.
> - Native hardware support of LAST flag which is mandatory to align with port
>   reconfiguration and DRAIN sequence as per V4L guidelines.
> - Native hardware support for drain sequence.
> 
> Changes done since v1[1]:
> - Patches are created as logical split instead of file by file.
> - Extracted common functionality between venus and iris driver and placed them
>   under common folder vcodec.
> - Flattened directory structure.
> - Restructured the code in a simplified layer architecture.
> - Implemented runtime PM, and dropped explicit power collapse thread in driver.
> - Moved to standard kernel log print api.
> - Simplified the bus and clock calculation logic.
> - Removed debug features like dma tracker, frame stats, debugfs.
> - Merged v4l2 and vidc layer as vidc in driver.
> - Removed separate probe for context bank.
> - Use of_device_get_match_data to get platform data.
> - Replaced complex macros with inline functions.
> - Migrated venus to iris names.
> - Addressed many other comments received on [1].
> 
> [1]: https://patchwork.kernel.org/project/linux-media/list/?series=770581 
> 
> Patch 1, adds dt binding for iris driver.
> 
> Patches 2-4, are introducing vcodec folder and moving common APIs like fw
> load/unload, buffer size calcualtions, read/write to shared queues to common
> files which are being used by both venus and iris drivers.
> This also moves the venus driver folder to vcodec folder.
> 
> Patch 5, adds the maintainers for iris driver.
> 
> Patch 6-29, adds core iris driver and enable decoder.
> 
> Patch 30-34, enable encoder functionality in iris driver.
> 

Made a mistake while explaining the patches.
Please find the correct order below:

Patches 1-3, are introducing vcodec folder and moving common APIs like fw
load/unload, buffer size calcualtions, read/write to shared queues to
common files which are being used by both venus and iris drivers.
This also moves the venus driver folder to vcodec folder.

Patch 4, adds dt binding for iris driver.

Patch 5, adds the maintainers for iris driver.

Patch 6-29, adds core iris driver and enable decoder.

Patch 30-34, enable encoder functionality in iris driver.

Thanks,
Dikshita

> Static tools like checkpatch, smatch, dt_binding_check, sparse and Coccinelle 
> run successfully with this driver. 
> 
>  The output of v4l2-compliance test looks like: 
> 
> v4l2-compliance SHA: not available, 64 bits
>  
> Cannot open device /dev/vido0, exiting.
> root@qemuarm64:/usr/bin# ./v4l2-compliance -d /dev/video0
> v4l2-compliance SHA: not available, 64 bits
>  
> Compliance test for iris_driver device /dev/video0:
>  
> Driver Info:
>         Driver name      : iris_driver
>         Card type        : iris_decoder
>         Bus info         : platform:iris_bus
>         Driver version   : 6.6.0
>         Capabilities     : 0x84204000
>                 Video Memory-to-Memory Multiplanar
>                 Streaming
>                 Extended Pix Format
>                 Device Capabilities
>         Device Caps      : 0x04204000
>                 Video Memory-to-Memory Multiplanar
>                 Streaming
>                 Extended Pix Format
>  
> Required ioctls:
>         test VIDIOC_QUERYCAP: OK
>  
> Allow for multiple opens:
>         test second /dev/video0 open: OK
>         test VIDIOC_QUERYCAP: OK
>         test VIDIOC_G/S_PRIORITY: OK
>                 fail: ../../../v4l-utils-1.18.1/utils/v4l2-compliance/v4l2-compliance.cpp(724): !ok
>         test for unlimited opens: FAIL
>  
> Debug ioctls:
>         test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
>         test VIDIOC_LOG_STATUS: OK (Not Supported)
>  
> Input ioctls:
>         test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>         test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
>         test VIDIOC_ENUMAUDIO: OK (Not Supported)
>         test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
>         test VIDIOC_G/S_AUDIO: OK (Not Supported)
>         Inputs: 0 Audio Inputs: 0 Tuners: 0
>  
> Output ioctls:
>         test VIDIOC_G/S_MODULATOR: OK (Not Supported)
>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>         test VIDIOC_ENUMAUDOUT: OK (Not Supported)
>         test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
>         test VIDIOC_G/S_AUDOUT: OK (Not Supported)
>         Outputs: 0 Audio Outputs: 0 Modulators: 0
>  
> Input/Output configuration ioctls:
>         test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
>         test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
>         test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
>         test VIDIOC_G/S_EDID: OK (Not Supported)
>  
> Control ioctls:
>         test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
>         test VIDIOC_QUERYCTRL: OK
>         test VIDIOC_G/S_CTRL: OK
>         test VIDIOC_G/S/TRY_EXT_CTRLS: OK
>         test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
>         test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
>         Standard Controls: 48 Private Controls: 0
>  
> Format ioctls:
>         test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
>         test VIDIOC_G/S_PARM: OK (Not Supported)
>         test VIDIOC_G_FBUF: OK (Not Supported)
>         test VIDIOC_G_FMT: OK
>         test VIDIOC_TRY_FMT: OK
>         test VIDIOC_S_FMT: OK
>         test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
>         test Cropping: OK
>         test Composing: OK
>         test Scaling: OK
>  
> Codec ioctls:
>         test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
>         test VIDIOC_G_ENC_INDEX: OK (Not Supported)
>         test VIDIOC_(TRY_)DECODER_CMD: OK
>  
> Buffer ioctls:
>         testVIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
>         test VIDIOC_EXPBUF: OK (Not Supported)
>         test Requests: OK (Not Supported)
>  
> Total for iris_driver device /dev/video0: 44, Succeeded: 43, Failed: 1, Warnings: 0
>  
> Compliance test for iris_driver device /dev/video1:
>  
> Driver Info:
>         Driver name      : iris_driver
>         Card type        : iris_encoder
>         Bus info         : platform:iris_bus
>         Driver version   : 6.6.0
>         Capabilities     : 0x84204000
>                 Video Memory-to-Memory Multiplanar
>                 Streaming
>                 Extended Pix Format
>                 Device Capabilities
>         Device Caps      : 0x04204000
>                 Video Memory-to-Memory Multiplanar
>                 Streaming
>                 Extended Pix Format
>  
> Required ioctls:
>         test VIDIOC_QUERYCAP: OK
>  
> Allow for multiple opens:
>         test second /dev/video1 open: OK
>         test VIDIOC_QUERYCAP: OK
>         test VIDIOC_G/S_PRIORITY: OK
>                 fail: ../../../v4l-utils-1.18.1/utils/v4l2-compliance/v4l2-compliance.cpp(724): !ok
>         test for unlimited opens: FAIL
>  
> Debug ioctls:
>         test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
>         test VIDIOC_LOG_STATUS: OK (Not Supported)
>  
> Input ioctls:
>         test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>         test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
>         test VIDIOC_ENUMAUDIO: OK (Not Supported)
>         test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
>         test VIDIOC_G/S_AUDIO: OK (Not Supported)
>         Inputs: 0 Audio Inputs: 0 Tuners: 0
>  
> Output ioctls:
>         test VIDIOC_G/S_MODULATOR: OK (Not Supported)
>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>         test VIDIOC_ENUMAUDOUT: OK (Not Supported)
>         test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
>         test VIDIOC_G/S_AUDOUT: OK (Not Supported)
>         Outputs: 0 Audio Outputs: 0 Modulators: 0
>  
> Input/Output configuration ioctls:
>         test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
>         test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
>         test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
>         test VIDIOC_G/S_EDID: OK (Not Supported)
>  
> Control ioctls:
>         test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
>         test VIDIOC_QUERYCTRL: OK
>         test VIDIOC_G/S_CTRL: OK
>         test VIDIOC_G/S/TRY_EXT_CTRLS: OK
>         test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
>         test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
>         Standard Controls: 48 Private Controls: 0
>  
> Format ioctls:
>         test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
>         test VIDIOC_G/S_PARM: OK
>         test VIDIOC_G_FBUF: OK (Not Supported)
>         test VIDIOC_G_FMT: OK
>         test VIDIOC_TRY_FMT: OK
>         test VIDIOC_S_FMT: OK
>         test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
>         test Cropping: OK
>         test Composing: OK
>         test Scaling: OK (Not Supported)
>  
> Codec ioctls:
>         test VIDIOC_(TRY_)ENCODER_CMD: OK
>         test VIDIOC_G_ENC_INDEX: OK (Not Supported)
>         test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
>  
> Buffer ioctls:
>         test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
>         test VIDIOC_EXPBUF: OK (Not Supported)
>         test Requests: OK (Not Supported)
>  
> Total for iris_driver device /dev/video1: 44, Succeeded: 43, Failed: 1, Warnings: 0
> 
> Dikshita Agarwal (27):
>   media: introduce common helpers for video firmware handling
>   media: introduce common helpers for queues handling
>   media: introduce common helpers for buffer size calculation
>   dt-bindings: media: Add sm8550 dt schema
>   media: MAINTAINERS: Add Qualcomm Iris video accelerator driver
>   media: iris: register video device to platform driver
>   media: iris: initialize power resources
>   media: iris: introduce state machine for iris core
>   media: iris: initialize shared queues for host and firmware
>     communication
>   media: iris: add PIL functionality for video firmware
>   media: iris: introduce packetization layer for creating HFI packets
>   media: iris: add video processing unit(VPU) specific register handling
>   media: iris: introduce platform specific capabilities for core and
>     instance
>   media: iris: add handling for interrupt service routine(ISR) invoked
>     by hardware
>   media: iris: implement iris v4l2_ctrl_ops and prepare capabilities
>   media: iris: implement vb2_ops queue setup
>   media: iris: implement HFI to queue and release buffers
>   media: iris: add video hardware internal buffer count and size
>     calculation
>   media: iris: implement internal buffer management
>   media: iris: introduce instance states
>   media: iris: implement vb2 streaming ops on capture and output planes
>   media: iris: implement vb2 ops for buf_queue and firmware response
>   media: iris: register video encoder device to platform driver
>   media: iris: add platform specific instance capabilities for encoder
>   media: iris: implement iris v4l2 ioctl ops supported by encoder
>   media: iris: add vb2 streaming and buffer ops for encoder
>   media: iris: add power management for encoder
> 
> Vikash Garodia (7):
>   media: iris: implement iris v4l2 file ops
>   media: iris: introduce and implement iris vb2 mem ops
>   media: iris: implement iris v4l2 ioctl ops supported by decoder
>   media: iris: subscribe input and output properties to firmware
>   media: iris: subscribe src change and handle firmware responses
>   media: iris: add instance sub states and implement DRC and Drain
>     sequence
>   media: iris: implement power management
> 
>  .../bindings/media/qcom,sm8550-iris.yaml           |  177 ++
>  MAINTAINERS                                        |   11 +
>  drivers/media/platform/qcom/Kconfig                |    3 +-
>  drivers/media/platform/qcom/Makefile               |    3 +-
>  drivers/media/platform/qcom/vcodec/buffers.c       |  103 ++
>  drivers/media/platform/qcom/vcodec/buffers.h       |   15 +
>  drivers/media/platform/qcom/vcodec/firmware.c      |  147 ++
>  drivers/media/platform/qcom/vcodec/firmware.h      |   21 +
>  drivers/media/platform/qcom/vcodec/hfi_queue.c     |  258 +++
>  drivers/media/platform/qcom/vcodec/hfi_queue.h     |  129 ++
>  drivers/media/platform/qcom/vcodec/iris/Kconfig    |   13 +
>  drivers/media/platform/qcom/vcodec/iris/Makefile   |   26 +
>  .../media/platform/qcom/vcodec/iris/hfi_defines.h  |  386 +++++
>  .../media/platform/qcom/vcodec/iris/iris_buffer.c  |  833 +++++++++
>  .../media/platform/qcom/vcodec/iris/iris_buffer.h  |   65 +
>  .../media/platform/qcom/vcodec/iris/iris_common.h  |  147 ++
>  .../media/platform/qcom/vcodec/iris/iris_core.c    |  110 ++
>  .../media/platform/qcom/vcodec/iris/iris_core.h    |  121 ++
>  .../media/platform/qcom/vcodec/iris/iris_ctrls.c   | 1782 ++++++++++++++++++++
>  .../media/platform/qcom/vcodec/iris/iris_ctrls.h   |   71 +
>  .../media/platform/qcom/vcodec/iris/iris_helpers.c | 1099 ++++++++++++
>  .../media/platform/qcom/vcodec/iris/iris_helpers.h |   68 +
>  drivers/media/platform/qcom/vcodec/iris/iris_hfi.c |  917 ++++++++++
>  drivers/media/platform/qcom/vcodec/iris/iris_hfi.h |   47 +
>  .../platform/qcom/vcodec/iris/iris_hfi_packet.c    |  729 ++++++++
>  .../platform/qcom/vcodec/iris/iris_hfi_packet.h    |  118 ++
>  .../platform/qcom/vcodec/iris/iris_hfi_response.c  | 1097 ++++++++++++
>  .../platform/qcom/vcodec/iris/iris_hfi_response.h  |   20 +
>  .../platform/qcom/vcodec/iris/iris_instance.h      |  106 ++
>  .../media/platform/qcom/vcodec/iris/iris_power.c   |  178 ++
>  .../media/platform/qcom/vcodec/iris/iris_power.h   |   15 +
>  .../media/platform/qcom/vcodec/iris/iris_probe.c   |  357 ++++
>  .../media/platform/qcom/vcodec/iris/iris_state.c   |  453 +++++
>  .../media/platform/qcom/vcodec/iris/iris_state.h   |   78 +
>  drivers/media/platform/qcom/vcodec/iris/iris_vb2.c |  457 +++++
>  drivers/media/platform/qcom/vcodec/iris/iris_vb2.h |   28 +
>  .../media/platform/qcom/vcodec/iris/iris_vdec.c    | 1211 +++++++++++++
>  .../media/platform/qcom/vcodec/iris/iris_vdec.h    |   25 +
>  .../media/platform/qcom/vcodec/iris/iris_venc.c    |  948 +++++++++++
>  .../media/platform/qcom/vcodec/iris/iris_venc.h    |   27 +
>  .../media/platform/qcom/vcodec/iris/iris_vidc.c    | 1419 ++++++++++++++++
>  .../media/platform/qcom/vcodec/iris/iris_vidc.h    |   15 +
>  .../platform/qcom/vcodec/iris/platform_common.c    |   29 +
>  .../platform/qcom/vcodec/iris/platform_common.h    |  323 ++++
>  .../platform/qcom/vcodec/iris/platform_sm8550.c    | 1190 +++++++++++++
>  .../media/platform/qcom/vcodec/iris/resources.c    |  506 ++++++
>  .../media/platform/qcom/vcodec/iris/resources.h    |   44 +
>  .../media/platform/qcom/vcodec/iris/vpu_common.c   |  158 ++
>  .../media/platform/qcom/vcodec/iris/vpu_common.h   |   52 +
>  .../media/platform/qcom/vcodec/iris/vpu_iris3.c    |  568 +++++++
>  .../media/platform/qcom/vcodec/iris/vpu_iris3.h    |   13 +
>  .../platform/qcom/vcodec/iris/vpu_iris3_buffer.c   |  395 +++++
>  .../platform/qcom/vcodec/iris/vpu_iris3_buffer.h   | 1469 ++++++++++++++++
>  .../platform/qcom/vcodec/iris/vpu_iris3_power.c    |  148 ++
>  .../platform/qcom/vcodec/iris/vpu_iris3_power.h    |   13 +
>  .../media/platform/qcom/{ => vcodec}/venus/Kconfig |    0
>  .../platform/qcom/{ => vcodec}/venus/Makefile      |    5 +-
>  .../media/platform/qcom/{ => vcodec}/venus/core.c  |  102 +-
>  .../media/platform/qcom/{ => vcodec}/venus/core.h  |    0
>  .../media/platform/qcom/{ => vcodec}/venus/dbgfs.c |    0
>  .../media/platform/qcom/{ => vcodec}/venus/dbgfs.h |    0
>  .../platform/qcom/vcodec/venus/firmware_no_tz.c    |  194 +++
>  .../platform/qcom/vcodec/venus/firmware_no_tz.h    |   19 +
>  .../platform/qcom/{ => vcodec}/venus/helpers.c     |  172 +-
>  .../platform/qcom/{ => vcodec}/venus/helpers.h     |    2 +-
>  .../media/platform/qcom/{ => vcodec}/venus/hfi.c   |    0
>  .../media/platform/qcom/{ => vcodec}/venus/hfi.h   |    0
>  .../platform/qcom/{ => vcodec}/venus/hfi_cmds.c    |    0
>  .../platform/qcom/{ => vcodec}/venus/hfi_cmds.h    |    0
>  .../platform/qcom/{ => vcodec}/venus/hfi_helper.h  |    0
>  .../platform/qcom/{ => vcodec}/venus/hfi_msgs.c    |    0
>  .../platform/qcom/{ => vcodec}/venus/hfi_msgs.h    |    0
>  .../platform/qcom/{ => vcodec}/venus/hfi_parser.c  |    0
>  .../platform/qcom/{ => vcodec}/venus/hfi_parser.h  |    0
>  .../qcom/{ => vcodec}/venus/hfi_plat_bufs.h        |    4 +-
>  .../qcom/{ => vcodec}/venus/hfi_plat_bufs_v6.c     |   10 +-
>  .../qcom/{ => vcodec}/venus/hfi_platform.c         |    0
>  .../qcom/{ => vcodec}/venus/hfi_platform.h         |    0
>  .../qcom/{ => vcodec}/venus/hfi_platform_v4.c      |    0
>  .../qcom/{ => vcodec}/venus/hfi_platform_v6.c      |    0
>  .../platform/qcom/{ => vcodec}/venus/hfi_venus.c   |  521 +-----
>  .../platform/qcom/{ => vcodec}/venus/hfi_venus.h   |    0
>  .../qcom/{ => vcodec}/venus/hfi_venus_io.h         |    0
>  .../platform/qcom/{ => vcodec}/venus/pm_helpers.c  |    0
>  .../platform/qcom/{ => vcodec}/venus/pm_helpers.h  |    0
>  .../media/platform/qcom/{ => vcodec}/venus/vdec.c  |    5 +-
>  .../media/platform/qcom/{ => vcodec}/venus/vdec.h  |    0
>  .../platform/qcom/{ => vcodec}/venus/vdec_ctrls.c  |    0
>  .../media/platform/qcom/{ => vcodec}/venus/venc.c  |    0
>  .../media/platform/qcom/{ => vcodec}/venus/venc.h  |    0
>  .../platform/qcom/{ => vcodec}/venus/venc_ctrls.c  |    0
>  drivers/media/platform/qcom/venus/firmware.c       |  363 ----
>  drivers/media/platform/qcom/venus/firmware.h       |   26 -
>  93 files changed, 19175 insertions(+), 989 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
>  create mode 100644 drivers/media/platform/qcom/vcodec/buffers.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/buffers.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/firmware.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/firmware.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/hfi_queue.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/hfi_queue.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/Kconfig
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/Makefile
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_buffer.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_buffer.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_common.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_core.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_core.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_ctrls.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_instance.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_power.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_power.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_probe.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_state.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_state.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_vb2.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_vb2.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_vdec.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_venc.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_venc.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_vidc.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/platform_common.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/platform_common.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/resources.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/resources.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_common.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_common.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_iris3.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_iris3.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_iris3_buffer.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_iris3_buffer.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_iris3_power.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_iris3_power.h
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/Kconfig (100%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/Makefile (75%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/core.c (91%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/core.h (100%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/dbgfs.c (100%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/dbgfs.h (100%)
>  create mode 100644 drivers/media/platform/qcom/vcodec/venus/firmware_no_tz.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/venus/firmware_no_tz.h
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/helpers.c (90%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/helpers.h (98%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi.c (100%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi.h (100%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_cmds.c (100%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_cmds.h (100%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_helper.h (100%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_msgs.c (100%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_msgs.h (100%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_parser.c (100%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_parser.h (100%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_plat_bufs.h (94%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_plat_bufs_v6.c (99%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_platform.c (100%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_platform.h (100%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_platform_v4.c (100%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_platform_v6.c (100%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_venus.c (73%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_venus.h (100%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_venus_io.h (100%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/pm_helpers.c (100%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/pm_helpers.h (100%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/vdec.c (99%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/vdec.h (100%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/vdec_ctrls.c (100%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/venc.c (100%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/venc.h (100%)
>  rename drivers/media/platform/qcom/{ => vcodec}/venus/venc_ctrls.c (100%)
>  delete mode 100644 drivers/media/platform/qcom/venus/firmware.c
>  delete mode 100644 drivers/media/platform/qcom/venus/firmware.h
> 

