Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB6478A8BB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjH1JUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjH1JT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:19:56 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC67110;
        Mon, 28 Aug 2023 02:19:54 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bf092a16c9so23009195ad.0;
        Mon, 28 Aug 2023 02:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693214393; x=1693819193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25JxK3Xl6d8HFetaLXYuQVyylmEi9MfsWzral0wE1ac=;
        b=CYp1It1QFcYOd3pGISfwbwOv0imvBvMJLDZmOzgJLshOUWGvarTazgdkhVTjFbf7bD
         dc9WVKfsHnOSR/DkUyi0MAcpi3KFNatPIRDIaSN/ZTHMLw9EvlJcgMRMwgTdLNU4AvdN
         4dM49B2EAKxmEpyy/CT3/cMT00wYiq3JbIYzl02hu3L/EcNy97fuN4MR3V643LOU4DVp
         28T+GMSBf0pMdyA/1Pi11QQDmYbJSgAgoJnAmPznTdiEclhuQ8uQK9Yq0u4id16DP8EY
         cuj5o47AL0SFQamHCun9IN0ld6QuK7LS69HHhHJvvz4t5k6T7/RoeLnibyDJs2qPzvYV
         bivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693214393; x=1693819193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25JxK3Xl6d8HFetaLXYuQVyylmEi9MfsWzral0wE1ac=;
        b=JY6G/DxIQTpn4XuxeqFuCu2yF3Kk3YFMd3y19LWtX1GynO/EZa+d4RdmJ+K4NCcQGU
         rUOILDp7wm3rf279RXesJnWlNeb4ZN8BfvJFEOSOYm1s/SrH6PBG7EyCgedKdUlXQjRw
         cosFoYSlmOShZ/xhtzr4/fthCJ+GP4qFts0wLlcYebrdckcPC6nl12OcDxcDIY07Gs9L
         F9CuHpq0Z7T2QtQg/hNZlK+FQt18NZQ6LglcCriCWGbwfKYxyUTi4I9tWZ8TZ+MrsbN2
         F6AZRipA82uxFYpaLMQB4UGm6Px6CS4keFYLMtTNxD3Oqjstit/nHam0FMtZIFLM5GyE
         fg5w==
X-Gm-Message-State: AOJu0Yxpl7dL973xfCHzL3b8NNiQGshSInzbfIyf9zquQHongbNvZ/wD
        qA0K8zaNqXNv5AFjQjsppss=
X-Google-Smtp-Source: AGHT+IGzAGZX1q29uayaZnzsUvvcNNlRK2v9MsD+uDCB1gTBdKYBx7pPMAAXYvxUV9gwOt5VdexiYQ==
X-Received: by 2002:a17:902:684c:b0:1bd:c6ca:e0db with SMTP id f12-20020a170902684c00b001bdc6cae0dbmr25049757pln.37.1693214393633;
        Mon, 28 Aug 2023 02:19:53 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902e84900b001bf8779e051sm6749403plg.289.2023.08.28.02.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 02:19:53 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: [PATCH v14 4/7] media: v4l: Add HEXTILE compressed format
Date:   Mon, 28 Aug 2023 17:18:56 +0800
Message-Id: <20230828091859.3889817-5-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828091859.3889817-1-milkfafa@gmail.com>
References: <20230828091859.3889817-1-milkfafa@gmail.com>
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

Add HEXTILE compressed format which is defined in Remote Framebuffer
Protocol (RFC 6143, chapter 7.7.4 Hextile Encoding) and is used by
Encoding Compression Engine (ECE) present on Nuvoton NPCM SoCs.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 Documentation/userspace-api/media/v4l/pixfmt-reserved.rst | 7 +++++++
 drivers/media/v4l2-core/v4l2-ioctl.c                      | 1 +
 include/uapi/linux/videodev2.h                            | 1 +
 3 files changed, 9 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
index 58f6ae25b2e7..ac52485252d9 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
@@ -275,6 +275,13 @@ please make a proposal on the linux-media mailing list.
 
         Decoder's implementation can be found here,
         `aspeed_codec <https://github.com/AspeedTech-BMC/aspeed_codec/>`__
+    * .. _V4L2-PIX-FMT-HEXTILE:
+
+      - ``V4L2_PIX_FMT_HEXTILE``
+      - 'HXTL'
+      - Compressed format used by Nuvoton NPCM video driver. This format is
+        defined in Remote Framebuffer Protocol (RFC 6143, chapter 7.7.4 Hextile
+        Encoding).
 .. raw:: latex
 
     \normalsize
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 01ba27f2ef87..2197c536740d 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1508,6 +1508,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 		case V4L2_PIX_FMT_QC10C:	descr = "QCOM Compressed 10-bit Format"; break;
 		case V4L2_PIX_FMT_AJPG:		descr = "Aspeed JPEG"; break;
 		case V4L2_PIX_FMT_AV1_FRAME:	descr = "AV1 Frame"; break;
+		case V4L2_PIX_FMT_HEXTILE:	descr = "Hextile Compressed Format"; break;
 		default:
 			if (fmt->description[0])
 				return;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 3af6a82d0cad..4833addf4686 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -802,6 +802,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_QC08C    v4l2_fourcc('Q', '0', '8', 'C') /* Qualcomm 8-bit compressed */
 #define V4L2_PIX_FMT_QC10C    v4l2_fourcc('Q', '1', '0', 'C') /* Qualcomm 10-bit compressed */
 #define V4L2_PIX_FMT_AJPG     v4l2_fourcc('A', 'J', 'P', 'G') /* Aspeed JPEG */
+#define V4L2_PIX_FMT_HEXTILE  v4l2_fourcc('H', 'X', 'T', 'L') /* Hextile compressed */
 
 /* 10bit raw packed, 32 bytes for every 25 pixels, last LSB 6 bits unused */
 #define V4L2_PIX_FMT_IPU3_SBGGR10	v4l2_fourcc('i', 'p', '3', 'b') /* IPU3 packed 10-bit BGGR bayer */
-- 
2.34.1

