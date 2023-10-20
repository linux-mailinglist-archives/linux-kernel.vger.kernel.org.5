Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F08D7D0CD0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376887AbjJTKJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376912AbjJTKJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:09:07 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8EAD55;
        Fri, 20 Oct 2023 03:09:05 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BFE7D200895;
        Fri, 20 Oct 2023 12:09:03 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5BBC1201E84;
        Fri, 20 Oct 2023 12:09:03 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 61F1B1834898;
        Fri, 20 Oct 2023 18:09:01 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     hverkuil@xs4all.nl, sakari.ailus@iki.fi, tfiga@chromium.org,
        m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v7 10/13] media: uapi: Add V4L2_CTRL_TYPE_FIXED_POINT
Date:   Fri, 20 Oct 2023 17:30:29 +0800
Message-Id: <1697794232-2607-11-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1697794232-2607-1-git-send-email-shengjiu.wang@nxp.com>
References: <1697794232-2607-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed point controls are used by the user to configure
a fixed point value in 64bits, which Q31.32 format.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst  | 6 ++++++
 .../userspace-api/media/videodev2.h.rst.exceptions          | 1 +
 drivers/media/v4l2-core/v4l2-ctrls-api.c                    | 5 ++++-
 drivers/media/v4l2-core/v4l2-ctrls-core.c                   | 2 ++
 include/uapi/linux/videodev2.h                              | 1 +
 5 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst b/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
index 4d38acafe8e1..2e15db0779f2 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
@@ -549,6 +549,12 @@ See also the examples in :ref:`control`.
       - n/a
       - A struct :c:type:`v4l2_ctrl_av1_film_grain`, containing AV1 Film Grain
         parameters for stateless video decoders.
+    * - ``V4L2_CTRL_TYPE_FIXED_POINT``
+      - n/a
+      - n/a
+      - n/a
+      - A struct :c:type:`v4l2_ctrl_fixed_point`, containing parameter which is
+        Q31.32 format.
 
 .. raw:: latex
 
diff --git a/Documentation/userspace-api/media/videodev2.h.rst.exceptions b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
index e61152bb80d1..2faa5a2015eb 100644
--- a/Documentation/userspace-api/media/videodev2.h.rst.exceptions
+++ b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
@@ -167,6 +167,7 @@ replace symbol V4L2_CTRL_TYPE_AV1_SEQUENCE :c:type:`v4l2_ctrl_type`
 replace symbol V4L2_CTRL_TYPE_AV1_TILE_GROUP_ENTRY :c:type:`v4l2_ctrl_type`
 replace symbol V4L2_CTRL_TYPE_AV1_FRAME :c:type:`v4l2_ctrl_type`
 replace symbol V4L2_CTRL_TYPE_AV1_FILM_GRAIN :c:type:`v4l2_ctrl_type`
+replace symbol V4L2_CTRL_TYPE_FIXED_POINT :c:type:`v4l2_ctrl_type`
 
 # V4L2 capability defines
 replace define V4L2_CAP_VIDEO_CAPTURE device-capabilities
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-api.c b/drivers/media/v4l2-core/v4l2-ctrls-api.c
index 002ea6588edf..e6a0fb8d6791 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-api.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-api.c
@@ -57,6 +57,7 @@ static int ptr_to_user(struct v4l2_ext_control *c,
 		return copy_to_user(c->string, ptr.p_char, len + 1) ?
 		       -EFAULT : 0;
 	case V4L2_CTRL_TYPE_INTEGER64:
+	case V4L2_CTRL_TYPE_FIXED_POINT:
 		c->value64 = *ptr.p_s64;
 		break;
 	default:
@@ -132,6 +133,7 @@ static int user_to_new(struct v4l2_ext_control *c, struct v4l2_ctrl *ctrl)
 
 	switch (ctrl->type) {
 	case V4L2_CTRL_TYPE_INTEGER64:
+	case V4L2_CTRL_TYPE_FIXED_POINT:
 		*ctrl->p_new.p_s64 = c->value64;
 		break;
 	case V4L2_CTRL_TYPE_STRING:
@@ -540,7 +542,8 @@ static int validate_ctrls(struct v4l2_ext_controls *cs,
 		 */
 		if (ctrl->is_ptr)
 			continue;
-		if (ctrl->type == V4L2_CTRL_TYPE_INTEGER64)
+		if (ctrl->type == V4L2_CTRL_TYPE_INTEGER64 ||
+		    ctrl->type == V4L2_CTRL_TYPE_FIXED_POINT)
 			p_new.p_s64 = &cs->controls[i].value64;
 		else
 			p_new.p_s32 = &cs->controls[i].value;
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index a662fb60f73f..9d50df0d9874 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -1187,6 +1187,7 @@ static int std_validate_elem(const struct v4l2_ctrl *ctrl, u32 idx,
 	case V4L2_CTRL_TYPE_INTEGER:
 		return ROUND_TO_RANGE(ptr.p_s32[idx], u32, ctrl);
 	case V4L2_CTRL_TYPE_INTEGER64:
+	case V4L2_CTRL_TYPE_FIXED_POINT:
 		/*
 		 * We can't use the ROUND_TO_RANGE define here due to
 		 * the u64 divide that needs special care.
@@ -1779,6 +1780,7 @@ static struct v4l2_ctrl *v4l2_ctrl_new(struct v4l2_ctrl_handler *hdl,
 	/* Prefill elem_size for all types handled by std_type_ops */
 	switch ((u32)type) {
 	case V4L2_CTRL_TYPE_INTEGER64:
+	case V4L2_CTRL_TYPE_FIXED_POINT:
 		elem_size = sizeof(s64);
 		break;
 	case V4L2_CTRL_TYPE_STRING:
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 4ef08b3a9e39..ef8913d561bf 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -1903,6 +1903,7 @@ enum v4l2_ctrl_type {
 	V4L2_CTRL_TYPE_STRING        = 7,
 	V4L2_CTRL_TYPE_BITMASK       = 8,
 	V4L2_CTRL_TYPE_INTEGER_MENU  = 9,
+	V4L2_CTRL_TYPE_FIXED_POINT   = 10,
 
 	/* Compound types are >= 0x0100 */
 	V4L2_CTRL_COMPOUND_TYPES     = 0x0100,
-- 
2.34.1

