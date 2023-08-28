Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0874178A8B0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjH1JUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjH1JTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:19:44 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ABE113;
        Mon, 28 Aug 2023 02:19:41 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bee82fad0fso15682345ad.2;
        Mon, 28 Aug 2023 02:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693214381; x=1693819181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dW6eme5yGAxHFaV9S74jLXUWpBy1uFxHp6q0wujZVVU=;
        b=Ev7T7KHoXU/vqcymnL8EE0iGXMzCsYiibCEli6JWkWaHywcNGoPvepfYkS+Oi2MREF
         +1GTd3eAl7pxMVe1LI5IP3R5XXafExDZdLO+k7B7TuknC9tTkuFpUEP44LGKZfR55Q/H
         mkly5zYo3s8K/A1yk0kppuUPveaOTktJBu1xnzqsJy618lRWVoWnHEJiGy4MGiMFTq3Q
         3X1wu7huuFMf/H28MIDXghJXDKkvRgFebuGYey0YG/oFtHlebYgkawk2iCYbom2JNNx1
         Hjw6EACuiWGxyWiBMMzDqL2GN28YNyJfcEpPv6xQgTamzUtYpBR0A41QrDsPyD4I/LUw
         Ioyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693214381; x=1693819181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dW6eme5yGAxHFaV9S74jLXUWpBy1uFxHp6q0wujZVVU=;
        b=brRlpd1Ac2n/XKZpaZRqTNEAJ6483ON3BoiVm/GzaN5DgoS2MkBZOY3n9AP2/6+Xkf
         CZHhqAR5vBv9+zKQMrG/7IlF2gJfvBZEPmfB1fbwUJBr0n484s9pxXEKhmmcu0veUVGq
         X2Do20oh+IV81jjGLU0/hs3bV5Jzi7QNdqtoNK0tOFGnxnDT07KFWD5yidvo3HNc6tls
         wwhrQtQ5EkVCQKvGdHj1/XWpTuoFEZKjbn6+WAoSXb9gUSaZU2in1IKTny6ViU35uh0Y
         EN2Z7VSFFMdtmwSPWQeqflGDAx0tNwi4M8VpTN0+eKdqJmytrxXN/oGZ+6Rc+pdnavWt
         Yz+w==
X-Gm-Message-State: AOJu0YzohP9rtoteqNvL3eImIAb5lS1p8ZCwoppIKV7/D9XLmFZmxplC
        h6ATN+9dCYr76Bouu8mQaZlAy8Wvc9kw1w==
X-Google-Smtp-Source: AGHT+IH/A9fYBTzGIkYOgIMWfEZZviT9lt0MR1qZlT1EF1snJjdqUUuMGQghQ01fOMiwmO7okCbFyw==
X-Received: by 2002:a17:903:4283:b0:1bf:c59:c944 with SMTP id ju3-20020a170903428300b001bf0c59c944mr16814708plb.22.1693214380640;
        Mon, 28 Aug 2023 02:19:40 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902e84900b001bf8779e051sm6749403plg.289.2023.08.28.02.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 02:19:40 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v14 0/7] Support Nuvoton NPCM Video Capture/Encode Engine
Date:   Mon, 28 Aug 2023 17:18:52 +0800
Message-Id: <20230828091859.3889817-1-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add DTS node, dt-bindings document and drivers for Video
Capture/Differentiation Engine (VCD) and Encoding Compression Engine (ECE)
present on Nuvoton NPCM SoCs.

As described in the datasheet NPCM750D_DS_Rev_1.0, the VCD can capture a
frame from digital video input and compare two frames in memory, and then
the ECE can compress the frame data into HEXTILE format which is defined
in Remote Framebuffer Protocol (RFC 6143, chapter 7.7.4. Hextile Encoding).

The output of v4l2-compliance:
v4l2-compliance 1.23.0-4996, 64 bits, 64-bit time_t
v4l2-compliance SHA: 9431e4b26b48 2023-02-13 14:51:47

Compliance test for npcm-video device /dev/video0:

Driver Info:
        Driver name      : npcm-video
        Card type        : NPCM Video Engine
        Bus info         : platform:npcm-video
        Driver version   : 6.1.12
        Capabilities     : 0x84200001
                Video Capture
                Streaming
                Extended Pix Format
                Device Capabilities
        Device Caps      : 0x04200001
                Video Capture
                Streaming
                Extended Pix Format

Required ioctls:
        test VIDIOC_QUERYCAP: OK
        test invalid ioctls: OK

Allow for multiple opens:
        test second /dev/video0 open: OK
        test VIDIOC_QUERYCAP: OK
        test VIDIOC_G/S_PRIORITY: OK
        test for unlimited opens: OK

Debug ioctls:
        test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
        test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
        test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
        test VIDIOC_ENUMAUDIO: OK (Not Supported)
        test VIDIOC_G/S/ENUMINPUT: OK
        test VIDIOC_G/S_AUDIO: OK (Not Supported)
        Inputs: 1 Audio Inputs: 0 Tuners: 0

Output ioctls:
        test VIDIOC_G/S_MODULATOR: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_ENUMAUDOUT: OK (Not Supported)
        test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDOUT: OK (Not Supported)
        Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
        test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
        test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK
        test VIDIOC_DV_TIMINGS_CAP: OK
        test VIDIOC_G/S_EDID: OK (Not Supported)

Control ioctls (Input 0):
        test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
        test VIDIOC_QUERYCTRL: OK
        test VIDIOC_G/S_CTRL: OK
        test VIDIOC_G/S/TRY_EXT_CTRLS: OK
                warn: v4l2-test-controls.cpp(1139): V4L2_CID_DV_RX_POWER_PRESENT not found for input 0
        test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
        test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
        Standard Controls: 1 Private Controls: 2

Format ioctls (Input 0):
        test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
        test VIDIOC_G/S_PARM: OK (Not Supported)
        test VIDIOC_G_FBUF: OK (Not Supported)
        test VIDIOC_G_FMT: OK
        test VIDIOC_TRY_FMT: OK
        test VIDIOC_S_FMT: OK
        test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
        test Cropping: OK (Not Supported)
        test Composing: OK (Not Supported)
        test Scaling: OK (Not Supported)

Codec ioctls (Input 0):
        test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls (Input 0):
        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
        test VIDIOC_EXPBUF: OK
        test Requests: OK (Not Supported)

Total for npcm-video device /dev/video0: 45, Succeeded: 45, Failed: 0, Warnings: 1

Changes in v14:
  - Modify the flow of setting resolution and queue setup
  - Correct the control type (TYPE_MENU) of selecting between two modes.
  - Let ECE could be optional (only supports PIX_FMT_RGB565 if ECE is not
    enabled in DT).

Changes in v13:
  - Modify the flow for capturing next frame
  - Modify the behavior of resolution change interrupt
  - Move GFXI dt-bindings document to
    Documentation/devicetree/bindings/soc/nuvoton/nuvoton,gfxi.yaml

Changes in v12:
  - Modify the flow for detecting resolution change and raise
    V4L2_EVENT_SOURCE_CHANGE event.
  - Add V4L2_PIX_FMT_RGB565 format support.

Changes in v11:
  - Replace "u8/u16/u32" with "unsigned int" for generic local variables.
  - Correct subsystem prefixes, drop redundant words in commit subject, and
    add more information in commit message.

Changes in v10:
  - drivers/media/platform/nuvoton/npcm-video.c
    * Let short functions to be inline function.
    * Correct return type of some functions, and properly handle return
      value by callers.
    * Correct the timing of removing rect_list and the flow of FIFO overrun
      case in irq.
    * Adjust line breaks, indentations, and style of variable declarations.

Changes in v9:
  - Change ECE node name to "video-codec".
  - Drop redundant "bindings for" in commit subject of patch 2/7.
  - Refine the format of VCD/ECE dt-binding document.

Changes in v8:
  - Let VCD/ECE to be 2 separate nodes and update dt-binding documents.
  - Move register definitions out to a local header file.
  - Driver refinements (add error handling for memory allocation, remove
    unnecessary condition check and introduce "goto"s to handle similar
    error recovery paths).
  - Correct properties and typo in GFXI dt-binding document.

Changes in v7:
  - Add uapi documents for driver-specific controls.
  - Implement driver-specific controls for switching capture mode and
    getting the count of compressed HEXTILE rectangles.
  - Drop unnecessary "enum_framesizes" and "enum_frameintervals" functions.
  - Include the output of v4l2-compliance in cover letter.

Changes in v6:
  - Support NPCM845 and add compatible "nuvoton,npcm845-video".
  - Correct pixel format to V4L2_PIX_FMT_HEXTILE which is newly added in
    this patch series.

Changes in v5:
  - Simplify function prefix "nuvoton_" to "npcm_".
  - Increase VCD_BUSY_TIMEOUT_US and ECE_POLL_TIMEOUT_US to 300ms to
    prevent polling timeout when ECC is enabled or system is busy.

Changes in v4:
  - Fix compile warning reported by kernel test robot.

Changes in v3:
  - Add video driver entry in MAINTAINERS.
  - Change config name to CONFIG_VIDEO_NPCM_VCD_ECE.
  - Reduce the waiting time after resetting the VCD/ECE module.
  - Correct data types of some variables.

Changes in v2:
  - Add Hextile document and locate with vendor formats.

Marvin Lin (7):
  ARM: dts: nuvoton: Add node for NPCM VCD and ECE engine
  media: dt-bindings: nuvoton: Add NPCM VCD and ECE engine
  dt-bindings: soc: nuvoton: Add NPCM GFXI
  media: v4l: Add HEXTILE compressed format
  media: v4l2-ctrls: Add user control base for Nuvoton NPCM controls
  media: uapi: Add controls for NPCM video driver
  media: nuvoton: Add driver for NPCM video capture and encode engine

 .../bindings/media/nuvoton,npcm-ece.yaml      |   43 +
 .../bindings/media/nuvoton,npcm-vcd.yaml      |   72 +
 .../bindings/soc/nuvoton/nuvoton,gfxi.yaml    |   39 +
 .../userspace-api/media/drivers/index.rst     |    1 +
 .../media/drivers/npcm-video.rst              |   67 +
 .../media/v4l/pixfmt-reserved.rst             |    7 +
 MAINTAINERS                                   |   12 +
 .../dts/nuvoton/nuvoton-common-npcm7xx.dtsi   |   23 +
 drivers/media/platform/Kconfig                |    1 +
 drivers/media/platform/Makefile               |    1 +
 drivers/media/platform/nuvoton/Kconfig        |   15 +
 drivers/media/platform/nuvoton/Makefile       |    2 +
 drivers/media/platform/nuvoton/npcm-regs.h    |  152 ++
 drivers/media/platform/nuvoton/npcm-video.c   | 1840 +++++++++++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c          |    1 +
 include/uapi/linux/npcm-video.h               |   41 +
 include/uapi/linux/v4l2-controls.h            |    6 +
 include/uapi/linux/videodev2.h                |    1 +
 18 files changed, 2324 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/nuvoton,npcm-ece.yaml
 create mode 100644 Documentation/devicetree/bindings/media/nuvoton,npcm-vcd.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/nuvoton/nuvoton,gfxi.yaml
 create mode 100644 Documentation/userspace-api/media/drivers/npcm-video.rst
 create mode 100644 drivers/media/platform/nuvoton/Kconfig
 create mode 100644 drivers/media/platform/nuvoton/Makefile
 create mode 100644 drivers/media/platform/nuvoton/npcm-regs.h
 create mode 100644 drivers/media/platform/nuvoton/npcm-video.c
 create mode 100644 include/uapi/linux/npcm-video.h

-- 
2.34.1

