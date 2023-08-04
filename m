Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55029770906
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjHDT2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjHDT15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:27:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4E8E42;
        Fri,  4 Aug 2023 12:27:56 -0700 (PDT)
Received: from whitebuilder.lan (unknown [IPv6:2606:6d00:15:bae9::c73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7131F66071BD;
        Fri,  4 Aug 2023 20:27:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691177275;
        bh=6ekBO0zpTVZAC3DReb0ZrVE85OlDeCtyq1+I+9C3jxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZLkiIEnr9fB9++iuFu7aJZt3UaC7V7qQY2iI60VJ7wLXIIzrsYW/5lEVtyjEhCa01
         sgFurM6Dg4Tp9AUFEJBRIMFFE82VtYTw9jUdrAx/ToF5u54HqHXxAZh4CrP30h4D9b
         N7SI0YmYs8gRdwby9jhq4EfzP1pOJDQWAsJs7xgjhZTMYhCl1SmUwBMT7kd9GmGm+j
         swWkyS/2ABJpDE2d/OgRfyOE1bdSbUmEEcXL+VVLoAjZMwL7U0dbRak3trpsUPhMEE
         0WQscIcjVnq5asKEASLXKGsvIU5CkEkkTp3wxzmdgr9I3/DejNxoQDm760d3Q/wpqr
         J7KIBP18l6DnA==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] docs: uapi: media: Properly locate NV12MT diagram
Date:   Fri,  4 Aug 2023 15:27:33 -0400
Message-Id: <20230804192737.19016-2-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230804192737.19016-1-nicolas.dufresne@collabora.com>
References: <20230804192737.19016-1-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The diagram have been pushed back at the end of a list of unrelated
pixels formats. Move it back next its related pixel format.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 .../media/v4l/pixfmt-yuv-planar.rst           | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
index 1840224faa41..fb826923ff1d 100644
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

