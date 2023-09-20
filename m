Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF197A707A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 04:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjITC31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 22:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjITC3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 22:29:15 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50A7E4;
        Tue, 19 Sep 2023 19:29:00 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-690bccb0d8aso1488587b3a.0;
        Tue, 19 Sep 2023 19:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695176940; x=1695781740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tctOiThLj6Q9+Dvszb1ohC6zJEOPoGelrBq8oKS8xvw=;
        b=MvEgV2eV/tgap1jlyny9M08wC+HuFXxiIEKaUsw6pRhQg9yfV1RXN4P1FsLgPZqHfH
         B2zt7GqJbPRImMY8AC+B7aW0Wh+CVxPFQ5goBxGEBw5ERgMDphjopP4nEBqR5TJHomRB
         438I3c/oL5bYQpvegq2G+dhfBeobVA+zd3923ihkGp2ME8o6iZB+DKrNGt9caVh6JHzj
         gD32abvUFXJRHvjaQLnHWcqGCRvBztrt9wMQQz5M4OC2OiHfMXqEPl53VN2O/jNR+6Zk
         BJHFQxlWKRXekhhl96+2VSiWw+dxqnf9IKWN1qg4FRM0EFmMU1h8+8RaXGZH0NSgPuqs
         VGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695176940; x=1695781740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tctOiThLj6Q9+Dvszb1ohC6zJEOPoGelrBq8oKS8xvw=;
        b=erfBZdT4ilJoe3USkrqcQWG1YD3Zk18g5X4m59zRUz/fK8vKkNLipDVWP7HC/kAMJZ
         0dvfnZ5PtfVinVoLzIndxv6+Y+Xo6tVu35EZTMr/HpML8LZhENwzpDVQAWY6+rZ1iYY8
         Y/EVEeQXUDiFuZuRnzB/exWUF3g5OROFcbXshBQ3jzWS0VYVUde/LmScga3Ha3O5e+HE
         G6efqFuyMKT5gmFYZCvMG1lGuFjY1bGsSfTUrprp16yrWfyLjkFYxocJiPWGVi5Lo40K
         xJ2qgna0+VpxwwO6hz59toR5G0sCNHzCA7pnEwiQW64xwzxP2jPfbgKvhiOf0UZ5qmBv
         4ftg==
X-Gm-Message-State: AOJu0Yzix9a6Fop30zknilt5VYssnleoBI/1qchXS8DYd+Nsp1lCiCwt
        f8mr+z+SqqaHAE5U1GsAVWI=
X-Google-Smtp-Source: AGHT+IFN3yYilGW0EcLDkLN9214P07XTC/7XpGK1gEYIcR6Y578f+dumcCw1h29qxsoTv60ubVfR5Q==
X-Received: by 2002:a05:6a21:4849:b0:156:6bdd:2305 with SMTP id au9-20020a056a21484900b001566bdd2305mr1245669pzc.45.1695176939990;
        Tue, 19 Sep 2023 19:28:59 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id n9-20020a170903110900b001bc930d4517sm10610009plh.42.2023.09.19.19.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 19:28:59 -0700 (PDT)
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
Subject: [PATCH v15 6/7] media: uapi: Add controls for NPCM video driver
Date:   Wed, 20 Sep 2023 10:28:11 +0800
Message-Id: <20230920022812.601800-7-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920022812.601800-1-milkfafa@gmail.com>
References: <20230920022812.601800-1-milkfafa@gmail.com>
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

Create controls for Nuvoton NPCM video driver to support setting
capture mode of Video Capture/Differentiation (VCD) engine and getting
the count of HEXTILE rectangles that is compressed by Encoding
Compression Engine (ECE).

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 .../userspace-api/media/drivers/index.rst     |  1 +
 .../media/drivers/npcm-video.rst              | 66 +++++++++++++++++++
 include/uapi/linux/npcm-video.h               | 41 ++++++++++++
 3 files changed, 108 insertions(+)
 create mode 100644 Documentation/userspace-api/media/drivers/npcm-video.rst
 create mode 100644 include/uapi/linux/npcm-video.h

diff --git a/Documentation/userspace-api/media/drivers/index.rst b/Documentation/userspace-api/media/drivers/index.rst
index 6708d649afd7..783f92f01a4c 100644
--- a/Documentation/userspace-api/media/drivers/index.rst
+++ b/Documentation/userspace-api/media/drivers/index.rst
@@ -37,6 +37,7 @@ For more details see the file COPYING in the source distribution of Linux.
 	dw100
 	imx-uapi
 	max2175
+	npcm-video
 	omap3isp-uapi
 	st-vgxy61
 	uvcvideo
diff --git a/Documentation/userspace-api/media/drivers/npcm-video.rst b/Documentation/userspace-api/media/drivers/npcm-video.rst
new file mode 100644
index 000000000000..b47771dd8b27
--- /dev/null
+++ b/Documentation/userspace-api/media/drivers/npcm-video.rst
@@ -0,0 +1,66 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: <isonum.txt>
+
+NPCM video driver
+=================
+
+This driver is used to control the Video Capture/Differentiation (VCD) engine
+and Encoding Compression Engine (ECE) present on Nuvoton NPCM SoCs. The VCD can
+capture a frame from digital video input and compare two frames in memory, and
+the ECE can compress the frame data into HEXTILE format.
+
+Driver-specific Controls
+------------------------
+
+V4L2_CID_NPCM_CAPTURE_MODE
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The VCD engine supports two modes:
+
+- COMPLETE mode:
+
+  Capture the next complete frame into memory.
+
+- DIFF mode:
+
+  Compare the incoming frame with the frame stored in memory, and updates the
+  differentiated frame in memory.
+
+Application can use ``V4L2_CID_NPCM_CAPTURE_MODE`` control to set the VCD mode
+with different control values (enum v4l2_npcm_capture_mode):
+
+- ``V4L2_NPCM_CAPTURE_MODE_COMPLETE``: will set VCD to COMPLETE mode.
+- ``V4L2_NPCM_CAPTURE_MODE_DIFF``: will set VCD to DIFF mode.
+
+V4L2_CID_NPCM_RECT_COUNT
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+If using V4L2_PIX_FMT_HEXTILE format, VCD will capture frame data and then ECE
+will compress the data into HEXTILE rectangles and store them in V4L2 video
+buffer with the layout defined in Remote Framebuffer Protocol:
+::
+
+           (RFC 6143, https://www.rfc-editor.org/rfc/rfc6143.html#section-7.6.1)
+
+           +--------------+--------------+-------------------+
+           | No. of bytes | Type [Value] | Description       |
+           +--------------+--------------+-------------------+
+           | 2            | U16          | x-position        |
+           | 2            | U16          | y-position        |
+           | 2            | U16          | width             |
+           | 2            | U16          | height            |
+           | 4            | S32          | encoding-type (5) |
+           +--------------+--------------+-------------------+
+           |             HEXTILE rectangle data              |
+           +-------------------------------------------------+
+
+Application can get the video buffer through VIDIOC_DQBUF, and followed by
+calling ``V4L2_CID_NPCM_RECT_COUNT`` control to get the number of HEXTILE
+rectangles in this buffer.
+
+References
+----------
+include/uapi/linux/npcm-video.h
+
+**Copyright** |copy| 2022 Nuvoton Technologies
diff --git a/include/uapi/linux/npcm-video.h b/include/uapi/linux/npcm-video.h
new file mode 100644
index 000000000000..1d39f6f38c96
--- /dev/null
+++ b/include/uapi/linux/npcm-video.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/*
+ * Controls header for NPCM video driver
+ *
+ * Copyright (C) 2022 Nuvoton Technologies
+ */
+
+#ifndef _UAPI_LINUX_NPCM_VIDEO_H
+#define _UAPI_LINUX_NPCM_VIDEO_H
+
+#include <linux/v4l2-controls.h>
+
+/*
+ * Check Documentation/userspace-api/media/drivers/npcm-video.rst for control
+ * details.
+ */
+
+/*
+ * This control is meant to set the mode of NPCM Video Capture/Differentiation
+ * (VCD) engine.
+ *
+ * The VCD engine supports two modes:
+ * COMPLETE - Capture the next complete frame into memory.
+ * DIFF	    - Compare the incoming frame with the frame stored in memory, and
+ *	      updates the differentiated frame in memory.
+ */
+#define V4L2_CID_NPCM_CAPTURE_MODE	(V4L2_CID_USER_NPCM_BASE + 0)
+
+enum v4l2_npcm_capture_mode {
+	V4L2_NPCM_CAPTURE_MODE_COMPLETE	= 0, /* COMPLETE mode */
+	V4L2_NPCM_CAPTURE_MODE_DIFF	= 1, /* DIFF mode */
+};
+
+/*
+ * This control is meant to get the count of compressed HEXTILE rectangles which
+ * is relevant to the number of differentiated frames if VCD is in DIFF mode.
+ * And the count will always be 1 if VCD is in COMPLETE mode.
+ */
+#define V4L2_CID_NPCM_RECT_COUNT	(V4L2_CID_USER_NPCM_BASE + 1)
+
+#endif /* _UAPI_LINUX_NPCM_VIDEO_H */
-- 
2.34.1

