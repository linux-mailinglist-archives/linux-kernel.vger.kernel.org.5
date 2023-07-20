Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A8475ABA5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 12:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjGTKHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 06:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjGTKHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:07:21 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9F4B7;
        Thu, 20 Jul 2023 03:07:19 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3F764E0009;
        Thu, 20 Jul 2023 10:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689847638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MfeAI5RqQVRWdSrS//JYyaBTkTxdDT5SqbV+7NPisKA=;
        b=RriP9ZzSGPv8pbwLFTRKDGx+aoCYONDtuc/vK1L9HA60ws9zpJiLoTd4h194Gax3hwuzXA
        4Gzfj3714apbJXaLGWdeTy0H8tWuc8AcSo7jtIhrHG2Rg6+dHQG05wZy1cG6uDGFbWj1XW
        jU9bGTd+SQk8algoKJQjeBz1xg++d0JfoZ5H3UGcUC3N2BBUHABrF1QzmhncLC4WoCYLEU
        8+KF+t2bU5tnQCak/BoOKkTKhZ7Roh1oaon2Bb187gGTfJ4lFALga4UacD3m1NJ8sp2UM7
        6Bj/bSqUlVVkA5AFpQhO+vPVHYInXIzGryYHpkHLfzS19a2MIgrjkpLwdeqj4g==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 2/2] media: doc: codec: Rename "Return fields" to "Returned fields" for consistency
Date:   Thu, 20 Jul 2023 12:07:02 +0200
Message-ID: <20230720100702.42803-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720100702.42803-1-paul.kocialkowski@bootlin.com>
References: <20230720100702.42803-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parts about fields that are returned typically comes after
"Required fields" so it feels more consistent to name them "Returned fields".

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../userspace-api/media/v4l/dev-decoder.rst      | 16 ++++++++--------
 .../userspace-api/media/v4l/dev-encoder.rst      | 16 ++++++++--------
 .../media/v4l/dev-stateless-decoder.rst          |  4 ++--
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/dev-decoder.rst b/Documentation/userspace-api/media/v4l/dev-decoder.rst
index 675bc2c3c6b8..ef8e8cf31f90 100644
--- a/Documentation/userspace-api/media/v4l/dev-decoder.rst
+++ b/Documentation/userspace-api/media/v4l/dev-decoder.rst
@@ -277,7 +277,7 @@ Initialization
      other fields
          follow standard semantics.
 
-   * **Return fields:**
+   * **Returned fields:**
 
      ``sizeimage``
          adjusted size of ``OUTPUT`` buffers.
@@ -311,7 +311,7 @@ Initialization
       ``memory``
           follows standard semantics.
 
-    * **Return fields:**
+    * **Returned fields:**
 
       ``count``
           the actual number of buffers allocated.
@@ -339,7 +339,7 @@ Initialization
       ``format``
           follows standard semantics.
 
-    * **Return fields:**
+    * **Returned fields:**
 
       ``count``
           adjusted to the number of allocated buffers.
@@ -410,7 +410,7 @@ Capture Setup
       ``type``
           a ``V4L2_BUF_TYPE_*`` enum appropriate for ``CAPTURE``.
 
-    * **Return fields:**
+    * **Returned fields:**
 
       ``width``, ``height``
           frame buffer resolution for the decoded frames.
@@ -443,7 +443,7 @@ Capture Setup
       ``target``
           set to ``V4L2_SEL_TGT_COMPOSE``.
 
-    * **Return fields:**
+    * **Returned fields:**
 
       ``r.left``, ``r.top``, ``r.width``, ``r.height``
           the visible rectangle; it must fit within the frame buffer resolution
@@ -552,7 +552,7 @@ Capture Setup
          frame is written; defaults to ``V4L2_SEL_TGT_COMPOSE_DEFAULT``;
          read-only on hardware without additional compose/scaling capabilities.
 
-   * **Return fields:**
+   * **Returned fields:**
 
      ``r.left``, ``r.top``, ``r.width``, ``r.height``
          the visible rectangle; it must fit within the frame buffer resolution
@@ -629,7 +629,7 @@ Capture Setup
       ``memory``
           follows standard semantics.
 
-    * **Return fields:**
+    * **Returned fields:**
 
       ``count``
           actual number of buffers allocated.
@@ -668,7 +668,7 @@ Capture Setup
           a format representing the maximum framebuffer resolution to be
           accommodated by newly allocated buffers.
 
-    * **Return fields:**
+    * **Returned fields:**
 
       ``count``
           adjusted to the number of allocated buffers.
diff --git a/Documentation/userspace-api/media/v4l/dev-encoder.rst b/Documentation/userspace-api/media/v4l/dev-encoder.rst
index c82d27689c08..15ca234459bb 100644
--- a/Documentation/userspace-api/media/v4l/dev-encoder.rst
+++ b/Documentation/userspace-api/media/v4l/dev-encoder.rst
@@ -163,7 +163,7 @@ Initialization
      other fields
          follow standard semantics.
 
-   * **Return fields:**
+   * **Returned fields:**
 
      ``sizeimage``
          adjusted size of ``CAPTURE`` buffers.
@@ -189,7 +189,7 @@ Initialization
      other fields
          follow standard semantics.
 
-   * **Return fields:**
+   * **Returned fields:**
 
      ``pixelformat``
          raw format supported for the coded format currently selected on
@@ -215,7 +215,7 @@ Initialization
      other fields
          follow standard semantics.
 
-   * **Return fields:**
+   * **Returned fields:**
 
      ``width``, ``height``
          may be adjusted to match encoder minimums, maximums and alignment
@@ -245,7 +245,7 @@ Initialization
 	 the desired frame interval; the encoder may adjust it to
 	 match hardware requirements.
 
-   * **Return fields:**
+   * **Returned fields:**
 
      ``parm.output.timeperframe``
 	 the adjusted frame interval.
@@ -296,7 +296,7 @@ Initialization
 	 the desired coded frame interval; the encoder may adjust it to
 	 match hardware requirements.
 
-   * **Return fields:**
+   * **Returned fields:**
 
      ``parm.capture.timeperframe``
 	 the adjusted frame interval.
@@ -339,7 +339,7 @@ Initialization
          rectangle and may be subject to adjustment to match codec and
          hardware constraints.
 
-   * **Return fields:**
+   * **Returned fields:**
 
      ``r.left``, ``r.top``, ``r.width``, ``r.height``
          visible rectangle adjusted by the encoder.
@@ -387,7 +387,7 @@ Initialization
      other fields
          follow standard semantics.
 
-   * **Return fields:**
+   * **Returned fields:**
 
      ``count``
           actual number of buffers allocated.
@@ -420,7 +420,7 @@ Initialization
      other fields
          follow standard semantics.
 
-   * **Return fields:**
+   * **Returned fields:**
 
      ``count``
          adjusted to the number of allocated buffers.
diff --git a/Documentation/userspace-api/media/v4l/dev-stateless-decoder.rst b/Documentation/userspace-api/media/v4l/dev-stateless-decoder.rst
index 4a26646eeec5..35ed05f2695e 100644
--- a/Documentation/userspace-api/media/v4l/dev-stateless-decoder.rst
+++ b/Documentation/userspace-api/media/v4l/dev-stateless-decoder.rst
@@ -180,7 +180,7 @@ Initialization
       ``memory``
           follows standard semantics.
 
-    * **Return fields:**
+    * **Returned fields:**
 
       ``count``
           actual number of buffers allocated.
@@ -208,7 +208,7 @@ Initialization
           follows standard semantics. ``V4L2_MEMORY_USERPTR`` is not supported
           for ``CAPTURE`` buffers.
 
-    * **Return fields:**
+    * **Returned fields:**
 
       ``count``
           adjusted to allocated number of buffers, in case the codec requires
-- 
2.41.0

