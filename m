Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F387A7072
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 04:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjITC3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 22:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjITC3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 22:29:04 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E40F7;
        Tue, 19 Sep 2023 19:28:54 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c453379020so28146955ad.1;
        Tue, 19 Sep 2023 19:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695176934; x=1695781734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwbtYXnybBb97SoCFL69GICK++fjeLJoanazsQv4oQE=;
        b=eaAHQ4vhX6kEyT4y9o4XE4qdorHZ8ESXSY9nuLqbOr4FJ2+C1p1CdhLT67QLONR6vG
         UI9VIqHoY1q9j4ukZ5iBI9N+gqfMVOHha32eIY+nPunqFKmtCDjnmjwvqf6sePvW1UNn
         g7QP9vyaPCTnubRlYULEdH8gqi5rl6XeHuCCmQpKvMD15TmpvbtwFZHvAxEEcvUg4egy
         Cs1LsuLgzdpQLMhhvR94S4Da1MTYyWDGWRAx66//A8qiYAH2TN+kkKDnsucCrIuJP7vj
         LomW86oMFpZPgd/pKDNl3FhHslnEBFT26vzNZWC3NFmeUscznVOzclF+pJ4HwNgX5xjM
         lKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695176934; x=1695781734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwbtYXnybBb97SoCFL69GICK++fjeLJoanazsQv4oQE=;
        b=ttTU5CCfMwGbhIeMXkb2wraMbrhWnIezvMJz8H8fqaN7Ic0o4PF0z+XitrBdmJPy4o
         9ubbafyjDmRVDGakbMnAmRpPyEzNwmqV+nV7YLxx8yz3TKr/spW7Qqy9LXUNquYIOVan
         7reyUG0ZNlx52feUdErOt9JtxgFKlsW/3VwhbtTSsGXmIdDLxFt7yC9icTUDRxloUixP
         kwukDgveblEnqCmldi/QIsE3Vmz4hGSsO7pL1AW2XDAwfYkHmS5PoncAtawB5ZUJT0/h
         zS60v3e63GdeIuVOPkHh2Z0DfJLgm/Jf0xoPwl+ksQuy0Cd6UYoP1u1nWhk+RG1Wls6h
         IPPw==
X-Gm-Message-State: AOJu0YwWcVvMfu2SlRjeivOU+VgsLSKmtXtMYulnjVFKnZ4wBrZKkF0p
        gTSlgMO8SBjjHVX+4r3izjM=
X-Google-Smtp-Source: AGHT+IEzh5+tcQah+SlJ9h6z0FmZq28gRgfSagly08dVU65t3hBNj2CfItm/lAY64//E+dRPiVoDmA==
X-Received: by 2002:a17:902:7585:b0:1b9:e972:134d with SMTP id j5-20020a170902758500b001b9e972134dmr1047711pll.3.1695176933784;
        Tue, 19 Sep 2023 19:28:53 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id n9-20020a170903110900b001bc930d4517sm10610009plh.42.2023.09.19.19.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 19:28:53 -0700 (PDT)
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
Subject: [PATCH v15 4/7] media: v4l: Add HEXTILE compressed format
Date:   Wed, 20 Sep 2023 10:28:09 +0800
Message-Id: <20230920022812.601800-5-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920022812.601800-1-milkfafa@gmail.com>
References: <20230920022812.601800-1-milkfafa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
index 296ad2025e8d..886ba7b08d6b 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
@@ -288,6 +288,13 @@ please make a proposal on the linux-media mailing list.
       - 'MT2110R'
       - This format is two-planar 10-Bit raster mode and having similitude with
         ``V4L2_PIX_FMT_MM21`` in term of alignment and tiling. Used for AVC.
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
index f4d9d6279094..9b1de54ce379 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1510,6 +1510,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 		case V4L2_PIX_FMT_AV1_FRAME:	descr = "AV1 Frame"; break;
 		case V4L2_PIX_FMT_MT2110T:	descr = "Mediatek 10bit Tile Mode"; break;
 		case V4L2_PIX_FMT_MT2110R:	descr = "Mediatek 10bit Raster Mode"; break;
+		case V4L2_PIX_FMT_HEXTILE:	descr = "Hextile Compressed Format"; break;
 		default:
 			if (fmt->description[0])
 				return;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 78260e5d9985..c3d4e490ce7c 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -804,6 +804,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_QC08C    v4l2_fourcc('Q', '0', '8', 'C') /* Qualcomm 8-bit compressed */
 #define V4L2_PIX_FMT_QC10C    v4l2_fourcc('Q', '1', '0', 'C') /* Qualcomm 10-bit compressed */
 #define V4L2_PIX_FMT_AJPG     v4l2_fourcc('A', 'J', 'P', 'G') /* Aspeed JPEG */
+#define V4L2_PIX_FMT_HEXTILE  v4l2_fourcc('H', 'X', 'T', 'L') /* Hextile compressed */
 
 /* 10bit raw packed, 32 bytes for every 25 pixels, last LSB 6 bits unused */
 #define V4L2_PIX_FMT_IPU3_SBGGR10	v4l2_fourcc('i', 'p', '3', 'b') /* IPU3 packed 10-bit BGGR bayer */
-- 
2.34.1

