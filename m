Return-Path: <linux-kernel+bounces-7424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEB481A7C6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC701F23694
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55971DFE0;
	Wed, 20 Dec 2023 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="3cVGcW8C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732131DFEA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 20:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dbd4a10735eso104773276.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 12:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1703105485; x=1703710285; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yh1iokeAoJGf7SShCv/rtfv7tmFNASxukYYh4fXA6ko=;
        b=3cVGcW8CIxh0sma0u0YZRvDyC+b9qUe7s2pD6yV+cqpPh+7a2hd4J94m5CIJRk5Ntx
         psmuN8GhsUr/nhQVRveetkewP6QupVnVaON+cx9Vln3CoutFUiIi+tSbgpKawwBilPEi
         KWj28iEqrM4xIe6jXJ6MFsn11h7SVpUPPczPnajCH9Z16AM8IrWD6Vbq2drsm1EacRcv
         vm0jHNA1lTubtQMkAEHabBwG5Jx3yY9embSs3GtrREF+wn2leabGYVHuZX0VHaITdd7Q
         y7EqaFnTaiJNsQvQPoLAh/w7i1ybKMu4yVu61edlFj9A55x7dfxxZYVvFcyDq/tdVz8f
         No0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703105485; x=1703710285;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yh1iokeAoJGf7SShCv/rtfv7tmFNASxukYYh4fXA6ko=;
        b=hAtZduDfIjVd2SR3J2EBVJIvfG1pJRtH1xQv0hTPw3tsM3aOUk1l7CNSbcizwQbjYZ
         86sWtFjfC89jZddFVkUUBPW/4+v9ZLqXezbIW1tw6ImP4NDOwm50JZ+qnq2ZbO1FaI+v
         BFJmCflUqp5TN/k5bntR0pIS82cQWJRNH5TO0sPZ0z95R6MlKzMl3rX4Pt6l2F2gP3CV
         TmDzMTNW0IOZkvyv/Uqg+/KCiiyrYzrpPDf5WoH2mL/3riQYscOx8CeTyS/ysIiXjYWX
         U5xwwkDoNWMJl6wytG7SRO1GdDj2JvSozzZEgZycYjZJ/MWlaZJ+HLFqyO5QA8YMo7TL
         FGHA==
X-Gm-Message-State: AOJu0YyoJ/jf2Wfd2aN7uuHPDfMfCWZ1MRNDZ3CSB20KrjSqgOv1QfO1
	kh+EEVYbpa3sQWxXev15njXMSg==
X-Google-Smtp-Source: AGHT+IFE5J0YVKHihmhF7YNgvrrrD6j3bVlBHcCtfROYHK37m9AOG500mZiaxWw0oXlsmECabIRHMA==
X-Received: by 2002:a25:81cd:0:b0:dbd:b90d:48ef with SMTP id n13-20020a2581cd000000b00dbdb90d48efmr295219ybm.101.1703105485199;
        Wed, 20 Dec 2023 12:51:25 -0800 (PST)
Received: from nicolas-tpx395.localdomain ([2606:6d00:11:9202::7a9])
        by smtp.gmail.com with ESMTPSA id fc16-20020a05622a489000b0042389b32e97sm199608qtb.53.2023.12.20.12.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 12:51:24 -0800 (PST)
Message-ID: <36aff9475dd4beb5a5f080e6980fa8f0f10a0151.camel@ndufresne.ca>
Subject: Re: [PATCH v2 00/34] Qualcomm video encoder and decoder driver
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 linux-media@vger.kernel.org,  linux-kernel@vger.kernel.org,
 stanimir.k.varbanov@gmail.com,  quic_vgarodia@quicinc.com,
 agross@kernel.org, andersson@kernel.org,  konrad.dybcio@linaro.org,
 mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com
Date: Wed, 20 Dec 2023 15:51:23 -0500
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Le lundi 18 d=C3=A9cembre 2023 =C3=A0 17:01 +0530, Dikshita Agarwal a =C3=
=A9crit=C2=A0:
> This patch series introduces support for Qualcomm new video acceleration
> hardware architecture, used for video stream decoding/encoding. This driv=
er
> is based on new communication protocol between video hardware and applica=
tion
> processor.
> This driver comes with below capabilities:
> - V4L2 complaint video driver with M2M and STREAMING capability.
> - Supports H264, H265, VP9 decoders.
> - Supports H264, H265 encoders.
> This driver comes with below features:
> - Centralized resource and memory management.
> - Centralized management of core and instance states.
> - Defines platform specific capabilities and features. As a results, it p=
rovides
>   a single point of control to enable/disable a given feature depending o=
n=20
>   specific platform capabilities.
> - Handles hardware interdependent configurations. For a given configurati=
on from
>   client, the driver checks for hardware dependent configuration/s and up=
dates
>   the same.
> - Handles multiple complex video scenarios involving state transitions - =
DRC,
>   Drain, Seek, back to back DRC, DRC during Drain sequence, DRC during Se=
ek
>   sequence.
> - Introduces a flexible way for driver to subscribe for any property with
>   hardware. Hardware would inform driver with those subscribed property w=
ith any
>   change in value.
> - Introduces performance (clock and bus) model based on new hardware
>   architecture.
> - Introduces multi thread safe design to handle communication between cli=
ent and
>   hardware.
> - Adapts encoder quality improvements available in new hardware architect=
ure.
> - Implements asynchronous communication with hardware to achieve better
>   experience in low latency usecases.
> - Supports multi stage hardware architecture for encode/decode.
> - Output and capture planes are controlled independently. Thereby providi=
ng a
>   way to reconfigure individual plane.
> - Hardware packetization layer supports synchronization between configura=
tion
>   packet and data packet.
> - Introduces a flexibility to receive a hardware response for a given com=
mand
>   packet.
> - Native hardware support of LAST flag which is mandatory to align with p=
ort
>   reconfiguration and DRAIN sequence as per V4L guidelines.
> - Native hardware support for drain sequence.
>=20
> Changes done since v1[1]:
> - Patches are created as logical split instead of file by file.
> - Extracted common functionality between venus and iris driver and placed=
 them
>   under common folder vcodec.
> - Flattened directory structure.
> - Restructured the code in a simplified layer architecture.
> - Implemented runtime PM, and dropped explicit power collapse thread in d=
river.
> - Moved to standard kernel log print api.
> - Simplified the bus and clock calculation logic.
> - Removed debug features like dma tracker, frame stats, debugfs.
> - Merged v4l2 and vidc layer as vidc in driver.
> - Removed separate probe for context bank.
> - Use of_device_get_match_data to get platform data.
> - Replaced complex macros with inline functions.
> - Migrated venus to iris names.
> - Addressed many other comments received on [1].
>=20
> [1]: https://patchwork.kernel.org/project/linux-media/list/?series=3D7705=
81=20
>=20
> Patch 1, adds dt binding for iris driver.
>=20
> Patches 2-4, are introducing vcodec folder and moving common APIs like fw
> load/unload, buffer size calcualtions, read/write to shared queues to com=
mon
> files which are being used by both venus and iris drivers.
> This also moves the venus driver folder to vcodec folder.
>=20
> Patch 5, adds the maintainers for iris driver.
>=20
> Patch 6-29, adds core iris driver and enable decoder.
>=20
> Patch 30-34, enable encoder functionality in iris driver.
>=20
> Static tools like checkpatch, smatch, dt_binding_check, sparse and Coccin=
elle=20
> run successfully with this driver.=20
>=20
>  The output of v4l2-compliance test looks like:=20
>=20
> v4l2-compliance SHA: not available, 64 bits
> =20
> Cannot open device /dev/vido0, exiting.
> root@qemuarm64:/usr/bin# ./v4l2-compliance -d /dev/video0
> v4l2-compliance SHA: not available, 64 bits
> =20
> Compliance test for iris_driver device /dev/video0:
> =20
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
> =20
> Required ioctls:
>         test VIDIOC_QUERYCAP: OK
> =20
> Allow for multiple opens:
>         test second /dev/video0 open: OK
>         test VIDIOC_QUERYCAP: OK
>         test VIDIOC_G/S_PRIORITY: OK
>                 fail: ../../../v4l-utils-1.18.1/utils/v4l2-compliance/v4l=
2-compliance.cpp(724): !ok
>         test for unlimited opens: FAIL

The test says:
        /*
         * There should *not* be an artificial limit to the number
         * of open()s you can do on a V4L2 device node. So test whether
         * you can open a device node at least 100 times.
         *
         * And please don't start rejecting opens in your driver at 101!
         * There really shouldn't be a limit in the driver.
         *
         * If there are resource limits, then check against those limits
         * where they are actually needed.
         */  =20

So might have been acceptable for old venus, but not for iris since its a n=
ew
driver. Discussion and solution is needed. This is, I suppose, limiting the
number of decode sessions ? I personally find that method easier for usersp=
ace
then let say failing at streamon or something, but clearly a discussion nee=
d to
take place here as this is failing the compliance.

> =20
> Debug ioctls:
>         test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
>         test VIDIOC_LOG_STATUS: OK (Not Supported)
> =20
> Input ioctls:
>         test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>         test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
>         test VIDIOC_ENUMAUDIO: OK (Not Supported)
>         test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
>         test VIDIOC_G/S_AUDIO: OK (Not Supported)
>         Inputs: 0 Audio Inputs: 0 Tuners: 0
> =20
> Output ioctls:
>         test VIDIOC_G/S_MODULATOR: OK (Not Supported)
>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>         test VIDIOC_ENUMAUDOUT: OK (Not Supported)
>         test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
>         test VIDIOC_G/S_AUDOUT: OK (Not Supported)
>         Outputs: 0 Audio Outputs: 0 Modulators: 0
> =20
> Input/Output configuration ioctls:
>         test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
>         test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
>         test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
>         test VIDIOC_G/S_EDID: OK (Not Supported)
> =20
> Control ioctls:
>         test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
>         test VIDIOC_QUERYCTRL: OK
>         test VIDIOC_G/S_CTRL: OK
>         test VIDIOC_G/S/TRY_EXT_CTRLS: OK
>         test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
>         test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
>         Standard Controls: 48 Private Controls: 0
> =20
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
> =20
> Codec ioctls:
>         test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
>         test VIDIOC_G_ENC_INDEX: OK (Not Supported)
>         test VIDIOC_(TRY_)DECODER_CMD: OK
> =20
> Buffer ioctls:
>         testVIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
>         test VIDIOC_EXPBUF: OK (Not Supported)
>         test Requests: OK (Not Supported)
> =20
> Total for iris_driver device /dev/video0: 44, Succeeded: 43, Failed: 1, W=
arnings: 0
> =20
> Compliance test for iris_driver device /dev/video1:
> =20
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
> =20
> Required ioctls:
>         test VIDIOC_QUERYCAP: OK
> =20
> Allow for multiple opens:
>         test second /dev/video1 open: OK
>         test VIDIOC_QUERYCAP: OK
>         test VIDIOC_G/S_PRIORITY: OK
>                 fail: ../../../v4l-utils-1.18.1/utils/v4l2-compliance/v4l=
2-compliance.cpp(724): !ok
>         test for unlimited opens: FAIL
> =20
> Debug ioctls:
>         test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
>         test VIDIOC_LOG_STATUS: OK (Not Supported)
> =20
> Input ioctls:
>         test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>         test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
>         test VIDIOC_ENUMAUDIO: OK (Not Supported)
>         test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
>         test VIDIOC_G/S_AUDIO: OK (Not Supported)
>         Inputs: 0 Audio Inputs: 0 Tuners: 0
> =20
> Output ioctls:
>         test VIDIOC_G/S_MODULATOR: OK (Not Supported)
>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>         test VIDIOC_ENUMAUDOUT: OK (Not Supported)
>         test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
>         test VIDIOC_G/S_AUDOUT: OK (Not Supported)
>         Outputs: 0 Audio Outputs: 0 Modulators: 0
> =20
> Input/Output configuration ioctls:
>         test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
>         test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
>         test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
>         test VIDIOC_G/S_EDID: OK (Not Supported)
> =20
> Control ioctls:
>         test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
>         test VIDIOC_QUERYCTRL: OK
>         test VIDIOC_G/S_CTRL: OK
>         test VIDIOC_G/S/TRY_EXT_CTRLS: OK
>         test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
>         test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
>         Standard Controls: 48 Private Controls: 0
> =20
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
> =20
> Codec ioctls:
>         test VIDIOC_(TRY_)ENCODER_CMD: OK
>         test VIDIOC_G_ENC_INDEX: OK (Not Supported)
>         test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
> =20
> Buffer ioctls:
>         test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
>         test VIDIOC_EXPBUF: OK (Not Supported)
>         test Requests: OK (Not Supported)
> =20
> Total for iris_driver device /dev/video1: 44, Succeeded: 43, Failed: 1, W=
arnings: 0
>=20
> Dikshita Agarwal (27):
>   media: introduce common helpers for video firmware handling
>   media: introduce common helpers for queues handling
>   media: introduce common helpers for buffer size calculation

These helper make it possible to introduce regressions, did you run complia=
nce
tests against a venus  based system to make sure ?

On top of this, initial submission and core modification to CODEC drivers a=
re
now expected to be accompanied with fluster [0] results. This will help lat=
er
with integration testing enablement into KernelCI and will show that you ma=
de
sure the new driver is performing fairly well and is comparable to venus
(results available in Kernel CI, let me know if you have a hard time findin=
g the
results).

[0] https://github.com/fluendo/fluster kernel CI uses GStreamer decoder, bu=
t
ffmpeg support is also available in the test runner.


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
>=20
> Vikash Garodia (7):
>   media: iris: implement iris v4l2 file ops
>   media: iris: introduce and implement iris vb2 mem ops
>   media: iris: implement iris v4l2 ioctl ops supported by decoder
>   media: iris: subscribe input and output properties to firmware
>   media: iris: subscribe src change and handle firmware responses
>   media: iris: add instance sub states and implement DRC and Drain
>     sequence
>   media: iris: implement power management
>=20
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
>  .../media/platform/qcom/vcodec/iris/iris_ctrls.c   | 1782 ++++++++++++++=
++++++
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
>  .../media/platform/qcom/vcodec/iris/iris_vidc.c    | 1419 ++++++++++++++=
++
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
>  .../platform/qcom/vcodec/iris/vpu_iris3_buffer.h   | 1469 ++++++++++++++=
++
>  .../platform/qcom/vcodec/iris/vpu_iris3_power.c    |  148 ++
>  .../platform/qcom/vcodec/iris/vpu_iris3_power.h    |   13 +
>  .../media/platform/qcom/{ =3D> vcodec}/venus/Kconfig |    0
>  .../platform/qcom/{ =3D> vcodec}/venus/Makefile      |    5 +-
>  .../media/platform/qcom/{ =3D> vcodec}/venus/core.c  |  102 +-
>  .../media/platform/qcom/{ =3D> vcodec}/venus/core.h  |    0
>  .../media/platform/qcom/{ =3D> vcodec}/venus/dbgfs.c |    0
>  .../media/platform/qcom/{ =3D> vcodec}/venus/dbgfs.h |    0
>  .../platform/qcom/vcodec/venus/firmware_no_tz.c    |  194 +++
>  .../platform/qcom/vcodec/venus/firmware_no_tz.h    |   19 +
>  .../platform/qcom/{ =3D> vcodec}/venus/helpers.c     |  172 +-
>  .../platform/qcom/{ =3D> vcodec}/venus/helpers.h     |    2 +-
>  .../media/platform/qcom/{ =3D> vcodec}/venus/hfi.c   |    0
>  .../media/platform/qcom/{ =3D> vcodec}/venus/hfi.h   |    0
>  .../platform/qcom/{ =3D> vcodec}/venus/hfi_cmds.c    |    0
>  .../platform/qcom/{ =3D> vcodec}/venus/hfi_cmds.h    |    0
>  .../platform/qcom/{ =3D> vcodec}/venus/hfi_helper.h  |    0
>  .../platform/qcom/{ =3D> vcodec}/venus/hfi_msgs.c    |    0
>  .../platform/qcom/{ =3D> vcodec}/venus/hfi_msgs.h    |    0
>  .../platform/qcom/{ =3D> vcodec}/venus/hfi_parser.c  |    0
>  .../platform/qcom/{ =3D> vcodec}/venus/hfi_parser.h  |    0
>  .../qcom/{ =3D> vcodec}/venus/hfi_plat_bufs.h        |    4 +-
>  .../qcom/{ =3D> vcodec}/venus/hfi_plat_bufs_v6.c     |   10 +-
>  .../qcom/{ =3D> vcodec}/venus/hfi_platform.c         |    0
>  .../qcom/{ =3D> vcodec}/venus/hfi_platform.h         |    0
>  .../qcom/{ =3D> vcodec}/venus/hfi_platform_v4.c      |    0
>  .../qcom/{ =3D> vcodec}/venus/hfi_platform_v6.c      |    0
>  .../platform/qcom/{ =3D> vcodec}/venus/hfi_venus.c   |  521 +-----
>  .../platform/qcom/{ =3D> vcodec}/venus/hfi_venus.h   |    0
>  .../qcom/{ =3D> vcodec}/venus/hfi_venus_io.h         |    0
>  .../platform/qcom/{ =3D> vcodec}/venus/pm_helpers.c  |    0
>  .../platform/qcom/{ =3D> vcodec}/venus/pm_helpers.h  |    0
>  .../media/platform/qcom/{ =3D> vcodec}/venus/vdec.c  |    5 +-
>  .../media/platform/qcom/{ =3D> vcodec}/venus/vdec.h  |    0
>  .../platform/qcom/{ =3D> vcodec}/venus/vdec_ctrls.c  |    0
>  .../media/platform/qcom/{ =3D> vcodec}/venus/venc.c  |    0
>  .../media/platform/qcom/{ =3D> vcodec}/venus/venc.h  |    0
>  .../platform/qcom/{ =3D> vcodec}/venus/venc_ctrls.c  |    0
>  drivers/media/platform/qcom/venus/firmware.c       |  363 ----
>  drivers/media/platform/qcom/venus/firmware.h       |   26 -
>  93 files changed, 19175 insertions(+), 989 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/qcom,sm8550-i=
ris.yaml
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
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_helpers.=
c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_helpers.=
h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_hfi_pack=
et.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_hfi_pack=
et.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_hfi_resp=
onse.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_hfi_resp=
onse.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_instance=
.h
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
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/platform_comm=
on.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/platform_comm=
on.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/platform_sm85=
50.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/resources.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/resources.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_common.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_common.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_iris3.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_iris3.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_iris3_buf=
fer.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_iris3_buf=
fer.h
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_iris3_pow=
er.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_iris3_pow=
er.h
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/Kconfig (100%)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/Makefile (75%)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/core.c (91%)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/core.h (100%)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/dbgfs.c (100%)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/dbgfs.h (100%)
>  create mode 100644 drivers/media/platform/qcom/vcodec/venus/firmware_no_=
tz.c
>  create mode 100644 drivers/media/platform/qcom/vcodec/venus/firmware_no_=
tz.h
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/helpers.c (90%)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/helpers.h (98%)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/hfi.c (100%)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/hfi.h (100%)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/hfi_cmds.c (100%=
)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/hfi_cmds.h (100%=
)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/hfi_helper.h (10=
0%)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/hfi_msgs.c (100%=
)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/hfi_msgs.h (100%=
)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/hfi_parser.c (10=
0%)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/hfi_parser.h (10=
0%)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/hfi_plat_bufs.h =
(94%)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/hfi_plat_bufs_v6=
.c (99%)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/hfi_platform.c (=
100%)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/hfi_platform.h (=
100%)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/hfi_platform_v4.=
c (100%)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/hfi_platform_v6.=
c (100%)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/hfi_venus.c (73%=
)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/hfi_venus.h (100=
%)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/hfi_venus_io.h (=
100%)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/pm_helpers.c (10=
0%)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/pm_helpers.h (10=
0%)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/vdec.c (99%)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/vdec.h (100%)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/vdec_ctrls.c (10=
0%)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/venc.c (100%)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/venc.h (100%)
>  rename drivers/media/platform/qcom/{ =3D> vcodec}/venus/venc_ctrls.c (10=
0%)
>  delete mode 100644 drivers/media/platform/qcom/venus/firmware.c
>  delete mode 100644 drivers/media/platform/qcom/venus/firmware.h
>=20


