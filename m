Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725B77A088F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240737AbjINPHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240687AbjINPHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:07:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5225A8;
        Thu, 14 Sep 2023 08:07:37 -0700 (PDT)
Received: from whitebuilder.lan (unknown [IPv6:2606:6d00:15:bae9::c73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D31A86607346;
        Thu, 14 Sep 2023 16:07:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694704056;
        bh=fY/r2diqs96P/mQNHqPsnegumIKHR6/vp+KeaEc/UlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ak5YGKItlPbrHeTfF9OJXFwSYn4rVT4A0E92UyKlbUsmPG+Nrd8m9ADYb4SK0LNoa
         RMU5QHZEX4td+ryGnWep6IloB3MJ0pOp9ARP1W5ObVKyvRQCwFZi0k52V4ZX7bclz7
         k6MC9CUnmslgqaitY6nAWTadO8jsJ+EnvZYrLtqIfvCyoQ+8ICKehdlQH/UfYkdC6r
         eMPLJ1NO7cOzvnjCqQxXP4ZSbFFOO1NqhbPDh/1UyzAt2XMGVkMc6incSfQ4QsRO7s
         Coy34QNbpzKv5UrygzoVLP/WWVnED8OQXfrkb/gSpx4LLzRLo+fVGlD0HYH2yQ3JP5
         HBbxbm2nnD1YQ==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] docs: uapi: media: Properly locate NV12MT diagram
Date:   Thu, 14 Sep 2023 11:06:47 -0400
Message-Id: <20230914150651.3114134-2-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914150651.3114134-1-nicolas.dufresne@collabora.com>
References: <20230914150651.3114134-1-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The diagram have been pushed back at the end of a list of unrelated
pixels formats. Move it back next its related pixel format.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
---
 .../media/v4l/pixfmt-yuv-planar.rst           | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
index 1840224faa412..fb826923ff1d6 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
@@ -322,6 +322,22 @@ If the vertical resolution is an odd number of tiles, the last row of
 tiles is stored in linear order. The layouts of the luma and chroma
 planes are identical.
 
+.. _nv12mt:
+
+.. kernel-figure:: nv12mt.svg
+    :alt:    nv12mt.svg
+    :align:  center
+
+    V4L2_PIX_FMT_NV12MT macroblock Z shape memory layout
+
+.. _nv12mt_ex:
+
+.. kernel-figure:: nv12mt_example.svg
+    :alt:    nv12mt_example.svg
+    :align:  center
+
+    Example V4L2_PIX_FMT_NV12MT memory layout of tiles
+
 ``V4L2_PIX_FMT_NV12_4L4`` stores pixels in 4x4 tiles, and stores
 tiles linearly in memory. The line stride and image height must be
 aligned to a multiple of 4. The layouts of the luma and chroma planes are
@@ -369,22 +385,6 @@ image height must be aligned to a multiple of 32. The number of luma and chroma
 tiles are identical, even though the tile size differ. The image is formed of
 two non-contiguous planes.
 
-.. _nv12mt:
-
-.. kernel-figure:: nv12mt.svg
-    :alt:    nv12mt.svg
-    :align:  center
-
-    V4L2_PIX_FMT_NV12MT macroblock Z shape memory layout
-
-.. _nv12mt_ex:
-
-.. kernel-figure:: nv12mt_example.svg
-    :alt:    nv12mt_example.svg
-    :align:  center
-
-    Example V4L2_PIX_FMT_NV12MT memory layout of tiles
-
 .. _V4L2-PIX-FMT-NV15-4L4:
 
 Tiled NV15
-- 
2.40.1

