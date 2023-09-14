Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBD07A0893
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240752AbjINPHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240748AbjINPHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:07:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9131C1FDC;
        Thu, 14 Sep 2023 08:07:41 -0700 (PDT)
Received: from whitebuilder.lan (unknown [IPv6:2606:6d00:15:bae9::c73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 86F33660734A;
        Thu, 14 Sep 2023 16:07:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694704060;
        bh=BPugKkNBgf1YBf9yRnKNsGKQzDLc0irbpk9bgkgeaHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aYvz0UsyRSgAzXnKQNmj8etXWDX28i+xdHMyhlv77lQBOuYgt1QJtiJ47HBEtBluU
         /revLxhv5nzbUlK3JCmor28S6M63lPwrschrn2LoxjF6Bh/AR04g/tGrvX5VDHbtQG
         8BorSdRlj7+t0sppDo7z9A812PVdTIHCSxxDIH/AEpyzBKsA4/6Oqo8OFSglNO/m9X
         4cXthznYHQ14Bhvi3wNZTmL4QFT8qzOPk49jFf2k3YdT2QyJamgjE/V2qOPj7wmh6c
         ObTRNqGr6yMaztL+lEpOGOsgrmG8IUMkdLzigHBLVxoGV/EkXoTmVcg81R8W+PooRs
         waquA3//hmcgQ==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] docs: uapi: media: Move NV12_10BE_8L128 to NV15 section
Date:   Thu, 14 Sep 2023 11:06:48 -0400
Message-Id: <20230914150651.3114134-3-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914150651.3114134-1-nicolas.dufresne@collabora.com>
References: <20230914150651.3114134-1-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a 15 bits per pixel (or packed 10 bit format), so move it
into the relevant section.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
---
 .../media/v4l/pixfmt-yuv-planar.rst           | 36 ++++++++++---------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
index fb826923ff1d6..1d43532095c07 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
@@ -295,8 +295,6 @@ of the luma plane.
 .. _V4L2-PIX-FMT-NV12-32L32:
 .. _V4L2-PIX-FMT-NV12M-8L128:
 .. _V4L2-PIX-FMT-NV12-8L128:
-.. _V4L2-PIX-FMT-NV12M-10BE-8L128:
-.. _V4L2-PIX-FMT-NV12-10BE-8L128:
 .. _V4L2-PIX-FMT-MM21:
 
 Tiled NV12
@@ -361,6 +359,25 @@ The layouts of the luma and chroma planes are identical.
 ``V4L2_PIX_FMT_NV12_8L128`` is similar to ``V4L2_PIX_FMT_NV12M_8L128`` but stores
 two planes in one memory.
 
+``V4L2_PIX_FMT_MM21`` store luma pixel in 16x32 tiles, and chroma pixels
+in 16x16 tiles. The line stride must be aligned to a multiple of 16 and the
+image height must be aligned to a multiple of 32. The number of luma and chroma
+tiles are identical, even though the tile size differ. The image is formed of
+two non-contiguous planes.
+
+
+.. _V4L2-PIX-FMT-NV15-4L4:
+.. _V4L2-PIX-FMT-NV12M-10BE-8L128:
+.. _V4L2-PIX-FMT-NV12-10BE-8L128:
+
+Tiled NV15
+----------
+
+``V4L2_PIX_FMT_NV15_4L4`` Semi-planar 10-bit YUV 4:2:0 formats, using 4x4 tiling.
+All components are packed without any padding between each other.
+As a side-effect, each group of 4 components are stored over 5 bytes
+(YYYY or UVUV = 4 * 10 bits = 40 bits = 5 bytes).
+
 ``V4L2_PIX_FMT_NV12M_10BE_8L128`` is similar to ``V4L2_PIX_FMT_NV12M`` but stores
 10 bits pixels in 2D 8x128 tiles, and stores tiles linearly in memory.
 the data is arranged in big endian order.
@@ -379,21 +396,6 @@ byte 4: Y3(bits 7-0)
 ``V4L2_PIX_FMT_NV12_10BE_8L128`` is similar to ``V4L2_PIX_FMT_NV12M_10BE_8L128`` but stores
 two planes in one memory.
 
-``V4L2_PIX_FMT_MM21`` store luma pixel in 16x32 tiles, and chroma pixels
-in 16x16 tiles. The line stride must be aligned to a multiple of 16 and the
-image height must be aligned to a multiple of 32. The number of luma and chroma
-tiles are identical, even though the tile size differ. The image is formed of
-two non-contiguous planes.
-
-.. _V4L2-PIX-FMT-NV15-4L4:
-
-Tiled NV15
-----------
-
-Semi-planar 10-bit YUV 4:2:0 formats, using 4x4 tiling.
-All components are packed without any padding between each other.
-As a side-effect, each group of 4 components are stored over 5 bytes
-(YYYY or UVUV = 4 * 10 bits = 40 bits = 5 bytes).
 
 .. _V4L2-PIX-FMT-NV16:
 .. _V4L2-PIX-FMT-NV61:
-- 
2.40.1

