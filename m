Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511247A089B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240842AbjINPIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240773AbjINPH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:07:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E43A1FC2;
        Thu, 14 Sep 2023 08:07:47 -0700 (PDT)
Received: from whitebuilder.lan (unknown [IPv6:2606:6d00:15:bae9::c73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 91CFF6607346;
        Thu, 14 Sep 2023 16:07:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694704066;
        bh=BJuuCTccNm1wBpGqGQgbWiAbPnhCietftX460WOqvPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cnsYCWbf3pb1Gpp1Vxj5TDJOdfpaZC4yAUDTBm740nba91i/CYena1dpS4uYjA+mn
         MZceFljVTGR0RLT+94d7ruPsQaiF/q08r6kP8FX2XkVr9DlB7bM0fMtg2OSLef+z7i
         IGPlwgVXg0WOFot/QduWvs9TvhDKKjleZmo1XG8r2pjHNEg1h6u+j1buBYFaRQP520
         bapyYSfKYFOpioCV660wApIcB9qcuFKQSgKWgRSv3Z/TCt7Dv+GD093kL6TvtfSmnB
         v3qw7k7KlYzQzsYNtZLhI+bI2cGbqHTrfvjNLxaKKA4zBW5zWHlLw13dtUvqUXnO76
         TQycxNNBvnvYQ==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] docs: uapi: media: Document Mediatek 10bit tiled formats
Date:   Thu, 14 Sep 2023 11:06:51 -0400
Message-Id: <20230914150651.3114134-6-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914150651.3114134-1-nicolas.dufresne@collabora.com>
References: <20230914150651.3114134-1-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document V4L2_PIX_FMT_MT2110T and V4L2_PIX_FMT_MT2110R. These two
formats are nearly identical, reusing MM21 format and expending it
by inserting chunk of 16 bytes of lower 2 bit pixel data after each
chunk of 64 bytes higher 8 bit of data.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 .../media/v4l/pixfmt-reserved.rst             |  13 --
 .../media/v4l/pixfmt-yuv-planar.rst           | 129 ++++++++++++++++++
 2 files changed, 129 insertions(+), 13 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
index 296ad2025e8d3..58f6ae25b2e7d 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
@@ -275,19 +275,6 @@ please make a proposal on the linux-media mailing list.
 
         Decoder's implementation can be found here,
         `aspeed_codec <https://github.com/AspeedTech-BMC/aspeed_codec/>`__
-    * .. _V4L2-PIX-FMT-MT2110T:
-
-      - ``V4L2_PIX_FMT_MT2110T``
-      - 'MT2110T'
-      - This format is two-planar 10-Bit tile mode and having similitude with
-        ``V4L2_PIX_FMT_MM21`` in term of alignment and tiling. Used for VP9, AV1
-        and HEVC.
-    * .. _V4L2-PIX-FMT-MT2110R:
-
-      - ``V4L2_PIX_FMT_MT2110R``
-      - 'MT2110R'
-      - This format is two-planar 10-Bit raster mode and having similitude with
-        ``V4L2_PIX_FMT_MM21`` in term of alignment and tiling. Used for AVC.
 .. raw:: latex
 
     \normalsize
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
index 2f0e0c97870b2..e37fe1d6cf166 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
@@ -144,6 +144,20 @@ All components are stored with the same number of bits per component.
       - Cb, Cr
       - Yes
       - 4x4 tiles
+    * - V4L2_PIX_FMT_MT2110T
+      - 'MT2T'
+      - 15
+      - 4:2:0
+      - Cb, Cr
+      - No
+      - 16x32 / 16x16 tiles tiled low bits
+    * - V4L2_PIX_FMT_MT2110R
+      - 'MT2R'
+      - 15
+      - 4:2:0
+      - Cb, Cr
+      - No
+      - 16x32 / 16x16 tiles raster low bits
     * - V4L2_PIX_FMT_NV16
       - 'NV16'
       - 8
@@ -369,6 +383,8 @@ two non-contiguous planes.
 .. _V4L2-PIX-FMT-NV15-4L4:
 .. _V4L2-PIX-FMT-NV12M-10BE-8L128:
 .. _V4L2-PIX-FMT-NV12-10BE-8L128:
+.. _V4L2-PIX-FMT-MT2110T:
+.. _V4L2-PIX-FMT-MT2110R:
 
 Tiled NV15
 ----------
@@ -514,6 +530,119 @@ be in different tiles.
 ``V4L2_PIX_FMT_NV12_10BE_8L128`` is similar to ``V4L2_PIX_FMT_NV12M_10BE_8L128`` but stores
 two planes in one memory.
 
+``V4L2_PIX_FMT_MT2110T`` is one of Mediatek packed 10bit YUV 4:2:0 formats.
+It is fully packed 10bit 4:2:0 format like NV15 (15 bits per pixel), except
+that the lower two bits data is stored in separate partitions. The format is
+composed of 16x32 luma tiles, and 16x16 chroma tiles. Each tiles is 640 bytes
+long, divided into 8 partitions of 80 bytes.  The first 16 bytes of the
+partition represent the 2 least significant bits of pixel data. The remaining
+64 bytes represent the 8 most significant bits of pixel data.
+
+.. kernel-figure:: mt2110t.svg
+    :alt:    mt2110t.svg
+    :align:  center
+
+    Layout of MT2110T Chroma Tile
+
+Filtering out the upper part of each partitions results in a valid
+``V4L2_PIX_FMT_MM21`` frame. A partition is a sub-tile of size 16 x 4. The
+lower two bits is said to be tiled since each bytes contains the lower two
+bits of the column of for pixel matching the same index. The chroma tiles
+only have 4 partitions.
+
+.. flat-table:: MT2110T LSB bits layout
+    :header-rows:  1
+    :stub-columns: 1
+
+    * -
+      - start + 0:
+      - start + 1:
+      - . . .
+      - start\ +\ 15:
+    * - Bits 1:0
+      - Y'\ :sub:`0:0`
+      - Y'\ :sub:`0:1`
+      - . . .
+      - Y'\ :sub:`0:15`
+    * - Bit 3:2
+      - Y'\ :sub:`1:0`
+      - Y'\ :sub:`1:1`
+      - . . .
+      - Y'\ :sub:`1:15`
+    * - Bits 5:4
+      - Y'\ :sub:`2:0`
+      - Y'\ :sub:`2:1`
+      - . . .
+      - Y'\ :sub:`2:15`
+    * - Bits 7:6
+      - Y'\ :sub:`3:0`
+      - Y'\ :sub:`3:1`
+      - . . .
+      - Y'\ :sub:`3:15`
+
+``V4L2_PIX_FMT_MT2110R`` is identical to ``V4L2_PIX_FMT_MT2110T`` except that
+the least significant two bits layout is in raster order. This means the first byte
+contains 4 pixels of the first row, with 4 bytes per line.
+
+.. flat-table:: MT2110R LSB bits layout
+    :header-rows:  2
+    :stub-columns: 1
+
+    * -
+      - :cspan:`3` Byte 0
+      - ...
+      - :cspan:`3` Byte 3
+    * -
+      - 7:6
+      - 5:4
+      - 3:2
+      - 1:0
+      - ...
+      - 7:6
+      - 5:4
+      - 3:2
+      - 1:0
+    * - start + 0:
+      - Y'\ :sub:`0:3`
+      - Y'\ :sub:`0:2`
+      - Y'\ :sub:`0:1`
+      - Y'\ :sub:`0:0`
+      - ...
+      - Y'\ :sub:`0:15`
+      - Y'\ :sub:`0:14`
+      - Y'\ :sub:`0:13`
+      - Y'\ :sub:`0:12`
+    * - start + 4:
+      - Y'\ :sub:`1:3`
+      - Y'\ :sub:`1:2`
+      - Y'\ :sub:`1:1`
+      - Y'\ :sub:`1:0`
+      - ...
+      - Y'\ :sub:`1:15`
+      - Y'\ :sub:`1:14`
+      - Y'\ :sub:`1:13`
+      - Y'\ :sub:`1:12`
+    * - start + 8:
+      - Y'\ :sub:`2:3`
+      - Y'\ :sub:`2:2`
+      - Y'\ :sub:`2:1`
+      - Y'\ :sub:`2:0`
+      - ...
+      - Y'\ :sub:`2:15`
+      - Y'\ :sub:`2:14`
+      - Y'\ :sub:`2:13`
+      - Y'\ :sub:`2:12`
+    * - start\ +\ 12:
+      - Y'\ :sub:`3:3`
+      - Y'\ :sub:`3:2`
+      - Y'\ :sub:`3:1`
+      - Y'\ :sub:`3:0`
+      - ...
+      - Y'\ :sub:`3:15`
+      - Y'\ :sub:`3:14`
+      - Y'\ :sub:`3:13`
+      - Y'\ :sub:`3:12`
+
 
 .. _V4L2-PIX-FMT-NV16:
 .. _V4L2-PIX-FMT-NV61:
-- 
2.40.1

