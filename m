Return-Path: <linux-kernel+bounces-4249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BF48179D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE78284A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFD41E533;
	Mon, 18 Dec 2023 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Td4x0LFW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5211D12F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e239c49d0so3201299e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702924681; x=1703529481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cVV8Yso9ulcK6cSiDWYUSPxFHZkIAYrUPE6BqAqLq00=;
        b=Td4x0LFWckF7HvgWk6LSPyyYASNkkCvXCOJ+Qkp1qXGwT2hEFXiI0yWv1VuaCPqzry
         jMzxoeoaZM0I8/islwq764zLEh2n/0xk9uWmBi4Fo4MS7staCcofgY3/kOQDNq9Jvpo6
         ebQpeVZlWOO7wn9Ckhx0Ghp0dtdCzSFffNNxJWAToPjBubCaMV5Ay5O+lfoZaL2+ycY+
         XqBaDr8vEEwz9fVoCJCayf0yLeLD3pefBP6fjODNpp9uctpnwUbSqfJjLyXBIHbG3///
         PahSYF6NgG9TqvOTSmECxnYDdKidP5l0nVBcajol5Mg+mKnDWNXCqvnCwLZGKxJTusUg
         oqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702924681; x=1703529481;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cVV8Yso9ulcK6cSiDWYUSPxFHZkIAYrUPE6BqAqLq00=;
        b=HgwbbKoQfmGtWqhzruAmKLN3OX6NcKoWEZbQiIjHc85SwGATVTEzjMrWSaKNa8TM8p
         2ECHNmK/GNCpC2F/X6yIi8XPhcq9WmmA9Zv6sljDqDNHDzv/XyDgBxwFhIi2iXxUqyOf
         GXYl5+zWZO3RrwL36X6AhpXC2z2e+3s+8l62rvAme2qdy9M1TsIebUUKSKqqX4DbEtSZ
         Gbnv18TgXEAijheEGAY/tYiFxxEOG+7hWlYlET9LZdxC8U3u0GzhSi3LrLpHGjs6Bhay
         2qymLNLzgDETA5HJaCzmaDhcXs+4jgLJKqGY6KZryPaDTavPP+IIQ8kdOdRvAVHMeb3d
         +oEg==
X-Gm-Message-State: AOJu0YxPTLAsds3n8Vgyn8qCZBwyiOYMa1ac0efa6PG5ayc1w8eHjtVR
	Zc7IeF9KbQTbm5oRiIWeV0Vq5FsY67/omK71DyI=
X-Google-Smtp-Source: AGHT+IGuS7xe4Q3hlnto11Xw477IA2yaiXpd14w1q9C0+2pITLHD6U3yWY4h/fklRGMswOwtyaJxqA==
X-Received: by 2002:a05:6512:b14:b0:50e:c7e:4bf2 with SMTP id w20-20020a0565120b1400b0050e0c7e4bf2mr7122215lfu.133.1702924681554;
        Mon, 18 Dec 2023 10:38:01 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::227? (dzdqv0yyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::227])
        by smtp.gmail.com with ESMTPSA id f8-20020a19ae08000000b0050e378689f5sm415841lfc.236.2023.12.18.10.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 10:38:01 -0800 (PST)
Message-ID: <a033dfc5-dcf1-4969-ad4d-1836ff9ff0a3@linaro.org>
Date: Mon, 18 Dec 2023 20:38:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/34] Qualcomm video encoder and decoder driver
Content-Language: en-GB
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
 bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/12/2023 13:31, Dikshita Agarwal wrote:
> This patch series introduces support for Qualcomm new video acceleration
> hardware architecture, used for video stream decoding/encoding. This driver
> is based on new communication protocol between video hardware and application
> processor.

This doesn't answer one important point, you have been asked for v1. 
What is the actual change point between Venus and Iris? What has been 
changed so much that it demands a separate driver. This is the main 
question for the cover letter, which has not been answered so far.

 From what I see from you bindings, the hardware is pretty close to what 
we see in the latest venus generations. I asssme that there was a change 
in the vcodec inteface to the firmware and other similar changes. Could 
you please point out, which parts of Venus driver do no longer work or 
are not applicable for sm8550?

> This driver comes with below capabilities:
> - V4L2 complaint video driver with M2M and STREAMING capability.
> - Supports H264, H265, VP9 decoders.
> - Supports H264, H265 encoders.
> This driver comes with below features:
> - Centralized resource and memory management.
> - Centralized management of core and instance states.
> - Defines platform specific capabilities and features. As a results, it provides
>    a single point of control to enable/disable a given feature depending on
>    specific platform capabilities.
> - Handles hardware interdependent configurations. For a given configuration from
>    client, the driver checks for hardware dependent configuration/s and updates
>    the same.
> - Handles multiple complex video scenarios involving state transitions - DRC,
>    Drain, Seek, back to back DRC, DRC during Drain sequence, DRC during Seek
>    sequence.
> - Introduces a flexible way for driver to subscribe for any property with
>    hardware. Hardware would inform driver with those subscribed property with any
>    change in value.
> - Introduces performance (clock and bus) model based on new hardware
>    architecture.
> - Introduces multi thread safe design to handle communication between client and
>    hardware.
> - Adapts encoder quality improvements available in new hardware architecture.
> - Implements asynchronous communication with hardware to achieve better
>    experience in low latency usecases.
> - Supports multi stage hardware architecture for encode/decode.
> - Output and capture planes are controlled independently. Thereby providing a
>    way to reconfigure individual plane.
> - Hardware packetization layer supports synchronization between configuration
>    packet and data packet.
> - Introduces a flexibility to receive a hardware response for a given command
>    packet.
> - Native hardware support of LAST flag which is mandatory to align with port
>    reconfiguration and DRAIN sequence as per V4L guidelines.
> - Native hardware support for drain sequence.
> 
> Changes done since v1[1]:
> - Patches are created as logical split instead of file by file.
> - Extracted common functionality between venus and iris driver and placed them
>    under common folder vcodec.
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
> Static tools like checkpatch, smatch, dt_binding_check, sparse and Coccinelle
> run successfully with this driver.
> 
>   The output of v4l2-compliance test looks like:
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
>          Driver name      : iris_driver
>          Card type        : iris_decoder
>          Bus info         : platform:iris_bus
>          Driver version   : 6.6.0
>          Capabilities     : 0x84204000
>                  Video Memory-to-Memory Multiplanar
>                  Streaming
>                  Extended Pix Format
>                  Device Capabilities
>          Device Caps      : 0x04204000
>                  Video Memory-to-Memory Multiplanar
>                  Streaming
>                  Extended Pix Format
>   
> Required ioctls:
>          test VIDIOC_QUERYCAP: OK
>   
> Allow for multiple opens:
>          test second /dev/video0 open: OK
>          test VIDIOC_QUERYCAP: OK
>          test VIDIOC_G/S_PRIORITY: OK
>                  fail: ../../../v4l-utils-1.18.1/utils/v4l2-compliance/v4l2-compliance.cpp(724): !ok
>          test for unlimited opens: FAIL
>   
> Debug ioctls:
>          test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
>          test VIDIOC_LOG_STATUS: OK (Not Supported)
>   
> Input ioctls:
>          test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
>          test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>          test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
>          test VIDIOC_ENUMAUDIO: OK (Not Supported)
>          test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
>          test VIDIOC_G/S_AUDIO: OK (Not Supported)
>          Inputs: 0 Audio Inputs: 0 Tuners: 0
>   
> Output ioctls:
>          test VIDIOC_G/S_MODULATOR: OK (Not Supported)
>          test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>          test VIDIOC_ENUMAUDOUT: OK (Not Supported)
>          test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
>          test VIDIOC_G/S_AUDOUT: OK (Not Supported)
>          Outputs: 0 Audio Outputs: 0 Modulators: 0
>   
> Input/Output configuration ioctls:
>          test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
>          test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
>          test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
>          test VIDIOC_G/S_EDID: OK (Not Supported)
>   
> Control ioctls:
>          test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
>          test VIDIOC_QUERYCTRL: OK
>          test VIDIOC_G/S_CTRL: OK
>          test VIDIOC_G/S/TRY_EXT_CTRLS: OK
>          test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
>          test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
>          Standard Controls: 48 Private Controls: 0
>   
> Format ioctls:
>          test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
>          test VIDIOC_G/S_PARM: OK (Not Supported)
>          test VIDIOC_G_FBUF: OK (Not Supported)
>          test VIDIOC_G_FMT: OK
>          test VIDIOC_TRY_FMT: OK
>          test VIDIOC_S_FMT: OK
>          test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
>          test Cropping: OK
>          test Composing: OK
>          test Scaling: OK
>   
> Codec ioctls:
>          test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
>          test VIDIOC_G_ENC_INDEX: OK (Not Supported)
>          test VIDIOC_(TRY_)DECODER_CMD: OK
>   
> Buffer ioctls:
>          testVIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
>          test VIDIOC_EXPBUF: OK (Not Supported)
>          test Requests: OK (Not Supported)
>   
> Total for iris_driver device /dev/video0: 44, Succeeded: 43, Failed: 1, Warnings: 0
>   
> Compliance test for iris_driver device /dev/video1:
>   
> Driver Info:
>          Driver name      : iris_driver
>          Card type        : iris_encoder
>          Bus info         : platform:iris_bus
>          Driver version   : 6.6.0
>          Capabilities     : 0x84204000
>                  Video Memory-to-Memory Multiplanar
>                  Streaming
>                  Extended Pix Format
>                  Device Capabilities
>          Device Caps      : 0x04204000
>                  Video Memory-to-Memory Multiplanar
>                  Streaming
>                  Extended Pix Format
>   
> Required ioctls:
>          test VIDIOC_QUERYCAP: OK
>   
> Allow for multiple opens:
>          test second /dev/video1 open: OK
>          test VIDIOC_QUERYCAP: OK
>          test VIDIOC_G/S_PRIORITY: OK
>                  fail: ../../../v4l-utils-1.18.1/utils/v4l2-compliance/v4l2-compliance.cpp(724): !ok
>          test for unlimited opens: FAIL
>   
> Debug ioctls:
>          test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
>          test VIDIOC_LOG_STATUS: OK (Not Supported)
>   
> Input ioctls:
>          test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
>          test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>          test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
>          test VIDIOC_ENUMAUDIO: OK (Not Supported)
>          test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
>          test VIDIOC_G/S_AUDIO: OK (Not Supported)
>          Inputs: 0 Audio Inputs: 0 Tuners: 0
>   
> Output ioctls:
>          test VIDIOC_G/S_MODULATOR: OK (Not Supported)
>          test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>          test VIDIOC_ENUMAUDOUT: OK (Not Supported)
>          test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
>          test VIDIOC_G/S_AUDOUT: OK (Not Supported)
>          Outputs: 0 Audio Outputs: 0 Modulators: 0
>   
> Input/Output configuration ioctls:
>          test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
>          test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
>          test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
>          test VIDIOC_G/S_EDID: OK (Not Supported)
>   
> Control ioctls:
>          test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
>          test VIDIOC_QUERYCTRL: OK
>          test VIDIOC_G/S_CTRL: OK
>          test VIDIOC_G/S/TRY_EXT_CTRLS: OK
>          test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
>          test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
>          Standard Controls: 48 Private Controls: 0
>   
> Format ioctls:
>          test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
>          test VIDIOC_G/S_PARM: OK
>          test VIDIOC_G_FBUF: OK (Not Supported)
>          test VIDIOC_G_FMT: OK
>          test VIDIOC_TRY_FMT: OK
>          test VIDIOC_S_FMT: OK
>          test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
>          test Cropping: OK
>          test Composing: OK
>          test Scaling: OK (Not Supported)
>   
> Codec ioctls:
>          test VIDIOC_(TRY_)ENCODER_CMD: OK
>          test VIDIOC_G_ENC_INDEX: OK (Not Supported)
>          test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
>   
> Buffer ioctls:
>          test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
>          test VIDIOC_EXPBUF: OK (Not Supported)
>          test Requests: OK (Not Supported)
>   
> Total for iris_driver device /dev/video1: 44, Succeeded: 43, Failed: 1, Warnings: 0
> 
> Dikshita Agarwal (27):
>    media: introduce common helpers for video firmware handling
>    media: introduce common helpers for queues handling
>    media: introduce common helpers for buffer size calculation
>    dt-bindings: media: Add sm8550 dt schema
>    media: MAINTAINERS: Add Qualcomm Iris video accelerator driver
>    media: iris: register video device to platform driver
>    media: iris: initialize power resources
>    media: iris: introduce state machine for iris core
>    media: iris: initialize shared queues for host and firmware
>      communication
>    media: iris: add PIL functionality for video firmware
>    media: iris: introduce packetization layer for creating HFI packets
>    media: iris: add video processing unit(VPU) specific register handling
>    media: iris: introduce platform specific capabilities for core and
>      instance
>    media: iris: add handling for interrupt service routine(ISR) invoked
>      by hardware
>    media: iris: implement iris v4l2_ctrl_ops and prepare capabilities
>    media: iris: implement vb2_ops queue setup
>    media: iris: implement HFI to queue and release buffers
>    media: iris: add video hardware internal buffer count and size
>      calculation
>    media: iris: implement internal buffer management
>    media: iris: introduce instance states
>    media: iris: implement vb2 streaming ops on capture and output planes
>    media: iris: implement vb2 ops for buf_queue and firmware response
>    media: iris: register video encoder device to platform driver
>    media: iris: add platform specific instance capabilities for encoder
>    media: iris: implement iris v4l2 ioctl ops supported by encoder
>    media: iris: add vb2 streaming and buffer ops for encoder
>    media: iris: add power management for encoder
> 
> Vikash Garodia (7):
>    media: iris: implement iris v4l2 file ops
>    media: iris: introduce and implement iris vb2 mem ops
>    media: iris: implement iris v4l2 ioctl ops supported by decoder
>    media: iris: subscribe input and output properties to firmware
>    media: iris: subscribe src change and handle firmware responses
>    media: iris: add instance sub states and implement DRC and Drain
>      sequence
>    media: iris: implement power management
> 
>   .../bindings/media/qcom,sm8550-iris.yaml           |  177 ++
>   MAINTAINERS                                        |   11 +
>   drivers/media/platform/qcom/Kconfig                |    3 +-
>   drivers/media/platform/qcom/Makefile               |    3 +-
>   drivers/media/platform/qcom/vcodec/buffers.c       |  103 ++
>   drivers/media/platform/qcom/vcodec/buffers.h       |   15 +
>   drivers/media/platform/qcom/vcodec/firmware.c      |  147 ++
>   drivers/media/platform/qcom/vcodec/firmware.h      |   21 +
>   drivers/media/platform/qcom/vcodec/hfi_queue.c     |  258 +++
>   drivers/media/platform/qcom/vcodec/hfi_queue.h     |  129 ++
>   drivers/media/platform/qcom/vcodec/iris/Kconfig    |   13 +
>   drivers/media/platform/qcom/vcodec/iris/Makefile   |   26 +
>   .../media/platform/qcom/vcodec/iris/hfi_defines.h  |  386 +++++
>   .../media/platform/qcom/vcodec/iris/iris_buffer.c  |  833 +++++++++
>   .../media/platform/qcom/vcodec/iris/iris_buffer.h  |   65 +
>   .../media/platform/qcom/vcodec/iris/iris_common.h  |  147 ++
>   .../media/platform/qcom/vcodec/iris/iris_core.c    |  110 ++
>   .../media/platform/qcom/vcodec/iris/iris_core.h    |  121 ++
>   .../media/platform/qcom/vcodec/iris/iris_ctrls.c   | 1782 ++++++++++++++++++++
>   .../media/platform/qcom/vcodec/iris/iris_ctrls.h   |   71 +
>   .../media/platform/qcom/vcodec/iris/iris_helpers.c | 1099 ++++++++++++
>   .../media/platform/qcom/vcodec/iris/iris_helpers.h |   68 +
>   drivers/media/platform/qcom/vcodec/iris/iris_hfi.c |  917 ++++++++++
>   drivers/media/platform/qcom/vcodec/iris/iris_hfi.h |   47 +
>   .../platform/qcom/vcodec/iris/iris_hfi_packet.c    |  729 ++++++++
>   .../platform/qcom/vcodec/iris/iris_hfi_packet.h    |  118 ++
>   .../platform/qcom/vcodec/iris/iris_hfi_response.c  | 1097 ++++++++++++
>   .../platform/qcom/vcodec/iris/iris_hfi_response.h  |   20 +
>   .../platform/qcom/vcodec/iris/iris_instance.h      |  106 ++
>   .../media/platform/qcom/vcodec/iris/iris_power.c   |  178 ++
>   .../media/platform/qcom/vcodec/iris/iris_power.h   |   15 +
>   .../media/platform/qcom/vcodec/iris/iris_probe.c   |  357 ++++
>   .../media/platform/qcom/vcodec/iris/iris_state.c   |  453 +++++
>   .../media/platform/qcom/vcodec/iris/iris_state.h   |   78 +
>   drivers/media/platform/qcom/vcodec/iris/iris_vb2.c |  457 +++++
>   drivers/media/platform/qcom/vcodec/iris/iris_vb2.h |   28 +
>   .../media/platform/qcom/vcodec/iris/iris_vdec.c    | 1211 +++++++++++++
>   .../media/platform/qcom/vcodec/iris/iris_vdec.h    |   25 +
>   .../media/platform/qcom/vcodec/iris/iris_venc.c    |  948 +++++++++++
>   .../media/platform/qcom/vcodec/iris/iris_venc.h    |   27 +
>   .../media/platform/qcom/vcodec/iris/iris_vidc.c    | 1419 ++++++++++++++++
>   .../media/platform/qcom/vcodec/iris/iris_vidc.h    |   15 +
>   .../platform/qcom/vcodec/iris/platform_common.c    |   29 +
>   .../platform/qcom/vcodec/iris/platform_common.h    |  323 ++++
>   .../platform/qcom/vcodec/iris/platform_sm8550.c    | 1190 +++++++++++++
>   .../media/platform/qcom/vcodec/iris/resources.c    |  506 ++++++
>   .../media/platform/qcom/vcodec/iris/resources.h    |   44 +
>   .../media/platform/qcom/vcodec/iris/vpu_common.c   |  158 ++
>   .../media/platform/qcom/vcodec/iris/vpu_common.h   |   52 +
>   .../media/platform/qcom/vcodec/iris/vpu_iris3.c    |  568 +++++++
>   .../media/platform/qcom/vcodec/iris/vpu_iris3.h    |   13 +
>   .../platform/qcom/vcodec/iris/vpu_iris3_buffer.c   |  395 +++++
>   .../platform/qcom/vcodec/iris/vpu_iris3_buffer.h   | 1469 ++++++++++++++++
>   .../platform/qcom/vcodec/iris/vpu_iris3_power.c    |  148 ++
>   .../platform/qcom/vcodec/iris/vpu_iris3_power.h    |   13 +
>   .../media/platform/qcom/{ => vcodec}/venus/Kconfig |    0
>   .../platform/qcom/{ => vcodec}/venus/Makefile      |    5 +-
>   .../media/platform/qcom/{ => vcodec}/venus/core.c  |  102 +-
>   .../media/platform/qcom/{ => vcodec}/venus/core.h  |    0
>   .../media/platform/qcom/{ => vcodec}/venus/dbgfs.c |    0
>   .../media/platform/qcom/{ => vcodec}/venus/dbgfs.h |    0
>   .../platform/qcom/vcodec/venus/firmware_no_tz.c    |  194 +++
>   .../platform/qcom/vcodec/venus/firmware_no_tz.h    |   19 +
>   .../platform/qcom/{ => vcodec}/venus/helpers.c     |  172 +-
>   .../platform/qcom/{ => vcodec}/venus/helpers.h     |    2 +-
>   .../media/platform/qcom/{ => vcodec}/venus/hfi.c   |    0
>   .../media/platform/qcom/{ => vcodec}/venus/hfi.h   |    0
>   .../platform/qcom/{ => vcodec}/venus/hfi_cmds.c    |    0
>   .../platform/qcom/{ => vcodec}/venus/hfi_cmds.h    |    0
>   .../platform/qcom/{ => vcodec}/venus/hfi_helper.h  |    0
>   .../platform/qcom/{ => vcodec}/venus/hfi_msgs.c    |    0
>   .../platform/qcom/{ => vcodec}/venus/hfi_msgs.h    |    0
>   .../platform/qcom/{ => vcodec}/venus/hfi_parser.c  |    0
>   .../platform/qcom/{ => vcodec}/venus/hfi_parser.h  |    0
>   .../qcom/{ => vcodec}/venus/hfi_plat_bufs.h        |    4 +-
>   .../qcom/{ => vcodec}/venus/hfi_plat_bufs_v6.c     |   10 +-
>   .../qcom/{ => vcodec}/venus/hfi_platform.c         |    0
>   .../qcom/{ => vcodec}/venus/hfi_platform.h         |    0
>   .../qcom/{ => vcodec}/venus/hfi_platform_v4.c      |    0
>   .../qcom/{ => vcodec}/venus/hfi_platform_v6.c      |    0
>   .../platform/qcom/{ => vcodec}/venus/hfi_venus.c   |  521 +-----
>   .../platform/qcom/{ => vcodec}/venus/hfi_venus.h   |    0
>   .../qcom/{ => vcodec}/venus/hfi_venus_io.h         |    0
>   .../platform/qcom/{ => vcodec}/venus/pm_helpers.c  |    0
>   .../platform/qcom/{ => vcodec}/venus/pm_helpers.h  |    0
>   .../media/platform/qcom/{ => vcodec}/venus/vdec.c  |    5 +-
>   .../media/platform/qcom/{ => vcodec}/venus/vdec.h  |    0
>   .../platform/qcom/{ => vcodec}/venus/vdec_ctrls.c  |    0
>   .../media/platform/qcom/{ => vcodec}/venus/venc.c  |    0
>   .../media/platform/qcom/{ => vcodec}/venus/venc.h  |    0
>   .../platform/qcom/{ => vcodec}/venus/venc_ctrls.c  |    0
>   drivers/media/platform/qcom/venus/firmware.c       |  363 ----
>   drivers/media/platform/qcom/venus/firmware.h       |   26 -
>   93 files changed, 19175 insertions(+), 989 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
>   create mode 100644 drivers/media/platform/qcom/vcodec/buffers.c
>   create mode 100644 drivers/media/platform/qcom/vcodec/buffers.h
>   create mode 100644 drivers/media/platform/qcom/vcodec/firmware.c
>   create mode 100644 drivers/media/platform/qcom/vcodec/firmware.h
>   create mode 100644 drivers/media/platform/qcom/vcodec/hfi_queue.c
>   create mode 100644 drivers/media/platform/qcom/vcodec/hfi_queue.h
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/Kconfig
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/Makefile
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_buffer.c
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_buffer.h
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_common.h
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_core.c
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_core.h
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_ctrls.h
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.h
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_instance.h
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_power.c
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_power.h
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_probe.c
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_state.c
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_state.h
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_vb2.c
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_vb2.h
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_vdec.h
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_venc.c
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_venc.h
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_vidc.h
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/platform_common.c
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/platform_common.h
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/resources.c
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/resources.h
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_common.c
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_common.h
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_iris3.c
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_iris3.h
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_iris3_buffer.c
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_iris3_buffer.h
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_iris3_power.c
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_iris3_power.h
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/Kconfig (100%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/Makefile (75%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/core.c (91%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/core.h (100%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/dbgfs.c (100%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/dbgfs.h (100%)
>   create mode 100644 drivers/media/platform/qcom/vcodec/venus/firmware_no_tz.c
>   create mode 100644 drivers/media/platform/qcom/vcodec/venus/firmware_no_tz.h
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/helpers.c (90%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/helpers.h (98%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi.c (100%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi.h (100%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_cmds.c (100%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_cmds.h (100%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_helper.h (100%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_msgs.c (100%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_msgs.h (100%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_parser.c (100%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_parser.h (100%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_plat_bufs.h (94%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_plat_bufs_v6.c (99%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_platform.c (100%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_platform.h (100%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_platform_v4.c (100%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_platform_v6.c (100%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_venus.c (73%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_venus.h (100%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_venus_io.h (100%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/pm_helpers.c (100%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/pm_helpers.h (100%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/vdec.c (99%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/vdec.h (100%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/vdec_ctrls.c (100%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/venc.c (100%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/venc.h (100%)
>   rename drivers/media/platform/qcom/{ => vcodec}/venus/venc_ctrls.c (100%)
>   delete mode 100644 drivers/media/platform/qcom/venus/firmware.c
>   delete mode 100644 drivers/media/platform/qcom/venus/firmware.h
> 

-- 
With best wishes
Dmitry


