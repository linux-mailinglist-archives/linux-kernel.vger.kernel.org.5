Return-Path: <linux-kernel+bounces-4032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 293C38176FA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAC601F22E52
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36745BFA0;
	Mon, 18 Dec 2023 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZU7JzT8v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133735BF99;
	Mon, 18 Dec 2023 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cc7087c6c4so14265051fa.2;
        Mon, 18 Dec 2023 08:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702915648; x=1703520448; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=20Ku4vARATLk3XHYnn5Pc7ocJY6ElVgfqjAQYqXv2Rc=;
        b=ZU7JzT8vEzxpG9DHKb032Uf7GSrDfCtb2jObzFuB90bydU/reHe5rCt7wPMic1jzPc
         EehOqXIQSHGY8iuncrfBP/z6sROlbfeoh54SVwq6x0/uR4fHOdi4UBugFuBUhs3JehnP
         XO5DGPkct7SCynYbiUgRX5R1PPwNOIERp3Qo3P39jmplRh8rf3gIx42h2OlWYvjaL2VS
         bkZHcUljPLA/XAasxo2b05ppvFWjdNfzTdY7HXRtjUOGJ2X4awAlCIdtqzpsOSAF2PIy
         XeOCrDEvQUH8DWmzgx8WeHRxB7nqyp2Anpeo/NAeEiolsGUUbNfEVRUh5zR6jlxJU2Ye
         uy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702915648; x=1703520448;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20Ku4vARATLk3XHYnn5Pc7ocJY6ElVgfqjAQYqXv2Rc=;
        b=VxBCSfqtV8ZamLkvBSXqdxP7bsDA/vu3UFMITivErrS7stE2lFXt+hHzsWB3GXiFBZ
         kiP04eaAeURO9uJW4EZeKe2xLu795RNrEgve8pjEShALbRkpyIdKg2lPymPFgnmz39o9
         W5kaVqR28T416MZDImA6+/kCb6W7O8lCdFqKa0SaJhuyKo1l/Al8uluF6SvqOTucrtmT
         DScMbAx3Y85iQygtTydO3J3NSbYxB7rs3rRH6eaaMXIUwJ8Z4PyHl8+WgvOfvNneLM+T
         5V0eH8gTxOawPP2UTNYsLJAuaOX2fVwJHbScORQTrhe/R6lZk3xDXe+x7M59hDjBGY4U
         QITA==
X-Gm-Message-State: AOJu0Yy4zn8LhbsyVq1kfWwD9i3sH34pFtqryAJlCcrJGDib+RCI3fMe
	ZNj8YbqMnX760PgEXlG/Fna/cfPjMQNl9U0f5Cg=
X-Google-Smtp-Source: AGHT+IHJ+x+QyBTbV9J8pAukoZDU13vn3Tstg3dtyqgpF6Gsnqfuxjo9JqNXfK41fX6EjCdJTnhy+zz6ieFO7a0heYo=
X-Received: by 2002:a2e:9cc7:0:b0:2cc:6210:1dce with SMTP id
 g7-20020a2e9cc7000000b002cc62101dcemr1642098ljj.4.1702915642804; Mon, 18 Dec
 2023 08:07:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xilin Wu <wuxilin123@gmail.com>
Date: Tue, 19 Dec 2023 00:07:09 +0800
Message-ID: <CAEPPPKvTzfVVWzmH9EmCKDP8TGi2Mm3Y1_mRXy8B-6wJxdH8Lg@mail.gmail.com>
Subject: Re: [PATCH v2 00/34] Qualcomm video encoder and decoder driver
To: quic_dikshita@quicinc.com
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, bryan.odonoghue@linaro.org, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, mchehab@kernel.org, 
	quic_abhinavk@quicinc.com, quic_vgarodia@quicinc.com, 
	stanimir.k.varbanov@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi, I tested the patches on qcs8550 (which should be the same as
sm8550) and I seemed to get different
results with v4l2-compliance sometimes. Also, ffmpeg never seemed to work.

ffmpeg cmdline: sudo ffmpeg -loglevel debug -c:v h264_v4l2m2m -i
rickroll.mp4 -f null /dev/null
Partial output:

[h264_v4l2m2m @ 0xaaaabf7a22b0] probing device /dev/video0
[h264_v4l2m2m @ 0xaaaabf7a22b0] driver 'iris_driver' on card
'iris_decoder' in mplane mode
[h264_v4l2m2m @ 0xaaaabf7a22b0] Using device /dev/video0
[h264_v4l2m2m @ 0xaaaabf7a22b0] driver 'iris_driver' on card
'iris_decoder' in mplane mode
[h264_v4l2m2m @ 0xaaaabf7a22b0] requesting formats: output=H264/none
capture=Q08C/yuv420p
[h264_v4l2m2m @ 0xaaaabf7a22b0] output buffer[0] initialization
(Cannot allocate memory)
[h264_v4l2m2m @ 0xaaaabf7a22b0] output unmap plane (Invalid argument))
[h264_v4l2m2m @ 0xaaaabf7a22b0] no v4l2 output context's buffers
[h264_v4l2m2m @ 0xaaaabf7a22b0] can't configure decoder
[vist#0:0/h264 @ 0xaaaabf741e70] Error while opening decoder: Cannot
allocate memory
[vost#0:0/wrapped_avframe @ 0xaaaabf760570] Error initializing a
simple filtergraph
Error opening output file /dev/null.
Error opening output files: Cannot allocate memory
[AVIOContext @ 0xaaaabf742c30] Statistics: 1703936 bytes read, 44 seeks

After trying several times, it just fails:

[h264_v4l2m2m @ 0xaaaaf7f852b0] probing device /dev/video0
[h264_v4l2m2m @ 0xaaaaf7f852b0] probing device /dev/video1
[h264_v4l2m2m @ 0xaaaaf7f852b0] Could not find a valid device
[h264_v4l2m2m @ 0xaaaaf7f852b0] can't configure decoder
[vist#0:0/h264 @ 0xaaaaf7f24e70] Error while opening decoder: Invalid argument
[vost#0:0/wrapped_avframe @ 0xaaaaf7f43570] Error initializing a
simple filtergraph
Error opening output file /dev/null.
Error opening output files: Invalid argument


v4l2-compliance output:

[alarm@ayn-odin2 ~]$ sudo v4l2-compliance -d /dev/video0
v4l2-compliance 1.26.0, 64 bits, 64-bit time_t

Compliance test for iris_driver device /dev/video0:

Driver Info:
        Driver name      : iris_driver
        Card type        : iris_decoder
        Bus info         : platform:iris_bus
        Driver version   : 6.7.0
        Capabilities     : 0x84204000
                Video Memory-to-Memory Multiplanar
                Streaming
                Extended Pix Format
                Device Capabilities
        Device Caps      : 0x04204000
                Video Memory-to-Memory Multiplanar
                Streaming
                Extended Pix Format
        Detected Stateful Decoder

Required ioctls:
        test VIDIOC_QUERYCAP: OK
        test invalid ioctls: OK

Allow for multiple opens:
        test second /dev/video0 open: OK
        test VIDIOC_QUERYCAP: OK
        test VIDIOC_G/S_PRIORITY: OK
                fail: v4l2-compliance.cpp(763): !ok
        test for unlimited opens: FAIL

Debug ioctls:
        test VIDIOC_DBG_G/S_REGISTER: OK
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

Control ioctls:
        test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
        test VIDIOC_QUERYCTRL: OK
        test VIDIOC_G/S_CTRL: OK
        test VIDIOC_G/S/TRY_EXT_CTRLS: OK
        test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
        test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
        Standard Controls: 48 Private Controls: 0

Format ioctls:
        test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
        test VIDIOC_G/S_PARM: OK (Not Supported)
        test VIDIOC_G_FBUF: OK (Not Supported)
        test VIDIOC_G_FMT: OK
        test VIDIOC_TRY_FMT: OK
        test VIDIOC_S_FMT: OK
        test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
        test Cropping: OK
        test Composing: OK
        test Scaling: OK (Not Supported)

Codec ioctls:
        test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK

Buffer ioctls:
                fail: v4l2-test-buffers.cpp(553): ret != EINVAL (got 9)
        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: FAIL
        test CREATE_BUFS maximum buffers: OK
                fail: v4l2-test-buffers.cpp(814): VIDIOC_EXPBUF is
supported, but the V4L2_MEMORY_MMAP support is missing or
malfunctioning.
                fail: v4l2-test-buffers.cpp(815): VIDIOC_EXPBUF is
supported, but the V4L2_MEMORY_MMAP support is missing, probably due
to earlier failing format tests.
        test VIDIOC_EXPBUF: OK (Not Supported)
failed to stat file
                fail: v4l2-test-buffers.cpp(2140): ret != EINVAL &&
ret != EBADR && ret != ENOTTY (got 9)
        test Requests: FAIL

Total for iris_driver device /dev/video0: 46, Succeeded: 43, Failed:
3, Warnings: 0
[alarm@ayn-odin2 ~]$ sudo v4l2-compliance -d /dev/video1
v4l2-compliance 1.26.0, 64 bits, 64-bit time_t

Failed to open /dev/video1: Invalid argument
[alarm@ayn-odin2 ~]$ sudo v4l2-compliance -d /dev/video0
v4l2-compliance 1.26.0, 64 bits, 64-bit time_t

Failed to open /dev/video0: Invalid argument

