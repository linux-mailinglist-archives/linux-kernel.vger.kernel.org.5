Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E517AA8FC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 08:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjIVGZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 02:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjIVGYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 02:24:37 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C331B1A1;
        Thu, 21 Sep 2023 23:24:30 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-692ada71d79so152539b3a.1;
        Thu, 21 Sep 2023 23:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695363870; x=1695968670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwbtYXnybBb97SoCFL69GICK++fjeLJoanazsQv4oQE=;
        b=BnM94DqYWYL6US+1UU/yEFnWFTuia6k7MTucJ//NknNK6cQMdac2OEFcaVMJMGlNo0
         UQUNlKOTywP627GGuBgQox/pCcVUtKby8KPbLUAHfQQ0HIX2qCJfcIS51R9Oj673sst4
         /8yXkHPWTIj7s17GyhcOKQyMoePxAupnr817gaoGu7Ej/Ovm45pamRKDE/z1/P2mjL9g
         zhIIBuTT4HK4QSTOBwe4Nq4VyM1Gfv9hiWiXlxYy2Tic9XpjMtIRSd/x18YetpeuUaVI
         MCmGisRmMGqY8fzYmY8WymwQlVG7vB0M2gGsJof5rLnIjA1Dgphb1DnBnrzgj8HZWFQo
         PqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695363870; x=1695968670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwbtYXnybBb97SoCFL69GICK++fjeLJoanazsQv4oQE=;
        b=YuR+xjNxyc+0GplBkxRuyTj5Ux3GqKQ+tu06aNcdPXPk/sDymqwJy3HrOqPPM2EFi0
         AcSzG6llcCz/oyB7zvywowz3Kk1KvuOnwR1be0WcJETf0+kg2RXXIg/O4Cq4p+BbnjWN
         4oXqn3TZtrv3cdxA1ws4LbmWuqSflEi4Bt0Vj11oMVdZJpIC/bE2Oid105O/P34vC69x
         h9XBgLVBlUB5Xw8LIgT21FzKQTZoj14xV/D61sNfYYM9yqC+VbQf1RTrvtwesEmd8YhC
         IZhjxUBwiNVPqrXDGtWiACq7vn/9sAyaHEkGOaGknLKtDlbjpi24Dxgg56hsWlLNyRbw
         lM2Q==
X-Gm-Message-State: AOJu0YzOw0WHhpX1Kt0ZtQvew3Pc/z54ZgieO8TVNdpQpvGUsgTa91t+
        66fHW6pVbawEm+lfvf7IjON3G+UQ0KEVbg==
X-Google-Smtp-Source: AGHT+IGjJ/lGi2ldN3E+TLfQOmoRwDd/IiBE1Wqc41iQsZNfJTLcqQg2r3SgxkTiR7gy/ipXxIbLqg==
X-Received: by 2002:a05:6a20:325a:b0:153:73dd:282c with SMTP id hm26-20020a056a20325a00b0015373dd282cmr6678561pzc.58.1695363870144;
        Thu, 21 Sep 2023 23:24:30 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090ade0b00b00274de7c8aacsm4157417pjv.45.2023.09.21.23.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 23:24:29 -0700 (PDT)
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
Subject: [PATCH v16 4/7] media: v4l: Add HEXTILE compressed format
Date:   Fri, 22 Sep 2023 14:24:02 +0800
Message-Id: <20230922062405.2571850-5-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922062405.2571850-1-milkfafa@gmail.com>
References: <20230922062405.2571850-1-milkfafa@gmail.com>
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

