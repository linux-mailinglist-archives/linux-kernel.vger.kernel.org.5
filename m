Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468DC7AA8FA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 08:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjIVGZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 02:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjIVGYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 02:24:46 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EB719D;
        Thu, 21 Sep 2023 23:24:37 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2746ab05409so1262264a91.0;
        Thu, 21 Sep 2023 23:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695363876; x=1695968676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tctOiThLj6Q9+Dvszb1ohC6zJEOPoGelrBq8oKS8xvw=;
        b=TiAc4EWhF/lfQ5EMtevE42GUFBzil+bhtw6eBCCu+LT++MaAiRZ+XKCpyjdCgPNGmR
         1EQcOhY80ayaFRFcRquIVeq7mgfvH7khegiaASkhqcofuCb0TshYe8bxm0sjeRzt0rx6
         hSAjb5mdVHHKW1NwLIkN8/h1m9O7ZvhxvQg8jtk6bqNz65J1c4edE9U9lzedvRNpt5QC
         2vMEn+RxXdUGLv1z/kSXzVvd0Jeiw62CGlFS950mzaCrx4PXKM3X0dgWkUNoJ1haai1u
         PnF4HsvSD6IkDB2tPOLe9v14SvC3fZzoX7nNtkpQGAWwwurPQNnQ6OMDSE0PaOZtIwga
         TJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695363876; x=1695968676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tctOiThLj6Q9+Dvszb1ohC6zJEOPoGelrBq8oKS8xvw=;
        b=iQVsxg+ChuSq1zgxBdqAGgsoLxM4BKs7Kw0NmhEmCyQTN7VaEc4USoaB33CTY0zF8l
         w3Qe7TM250dbrIt6l0laDzMkZP0+L74dc5tNwmQiB0M0jOrrJFjArW6b08xDNVJFSjLW
         Akb8R2CxgYpKfKufVPxZ75phc3HVhsSZbRARkIPuPPW/LGbkJc3JV+qvJgcPhAhpf5ly
         jjAKeWOUvqBCPAz89EiV1ZY4FTSNxlmJvAsKlpBmmp0eAfLbYJ8BniZ8gz0ahJ1nzRzj
         j+rKQz5sjC9zZUBix2Py3QWBPSsnFq8GGj8RW7kpfs0/+PeM5yiPzLaxi9QHHPv9STBQ
         MDnA==
X-Gm-Message-State: AOJu0YyugVi97AtZDZxwZwMjNgUYxXekEUtC1qHQEbBhFkkVIEI8tB8N
        leFJ2N6Kmt6GBLAvegWOUMU=
X-Google-Smtp-Source: AGHT+IFCPTZGUy5kR8kbSbQWeD+vH20fcvsIHdEnEFjaX74lvSxqYp1lyV2kL+daKMqVGltssbOqDg==
X-Received: by 2002:a17:90a:b901:b0:274:8be8:f767 with SMTP id p1-20020a17090ab90100b002748be8f767mr7220563pjr.15.1695363876543;
        Thu, 21 Sep 2023 23:24:36 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090ade0b00b00274de7c8aacsm4157417pjv.45.2023.09.21.23.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 23:24:36 -0700 (PDT)
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
Subject: [PATCH v16 6/7] media: uapi: Add controls for NPCM video driver
Date:   Fri, 22 Sep 2023 14:24:04 +0800
Message-Id: <20230922062405.2571850-7-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922062405.2571850-1-milkfafa@gmail.com>
References: <20230922062405.2571850-1-milkfafa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
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

