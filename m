Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8057A98DD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjIURyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjIURxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:53:47 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECA6E0B1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=k1; bh=GwO52d2vHsQuQT
        4wL7WfqPFyqFblzEe1Yqp8jz2tu34=; b=kO/2lh4yvRSIWhUjLSFBGu3e8wq+Gp
        TTRvSCfwNUeB17SKt6VBF+ufjqhYfb9XSzwGLnlqhgvZ8eIe69NPkwXX+RdSthC8
        xLxd9rmRWntb0iydI0MQSHqv7xrSTAyp+fgpsfE9gkDJR64QjY1qaU08ZMQlCKke
        5GwWNDOsP2BxyqjeN5WM1tiLBspudPzsWdD722sklenaBZxTkH+J9zHOi3UOrxjg
        3ZhY6iuhc/Kjjyu4R4IYGLc/+w4T2ZZbKCY5ipZp8v0XZjMtBJe71vw4v+yPl2LW
        F9wUU3VyxBU9rZ9OPvVycoFDdlSIxt8bHvVrC+At2MBbEUuzXArLmRBg==
Received: (qmail 963055 invoked from network); 21 Sep 2023 15:28:25 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Sep 2023 15:28:25 +0200
X-UD-Smtp-Session: l3s3148p1@Ivd1d94FfiQuciJ+
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm: renesas: rcar-du: use proper naming for R-Car
Date:   Thu, 21 Sep 2023 15:28:22 +0200
Message-Id: <20230921132823.5723-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not RCAR, but R-Car.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---

Changes since v1:
* rebased to 6.6-rc2
* added tag from Kieran (Thanks!)

 drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.h b/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.h
index f9893d7d6dfc..e9e59c5e70d5 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.h
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.h
@@ -16,7 +16,7 @@ struct rcar_du_format_info;
 struct rcar_du_group;
 
 /*
- * The RCAR DU has 8 hardware planes, shared between primary and overlay planes.
+ * The R-Car DU has 8 hardware planes, shared between primary and overlay planes.
  * As using overlay planes requires at least one of the CRTCs being enabled, no
  * more than 7 overlay planes can be available. We thus create 1 primary plane
  * per CRTC and 7 overlay planes, for a total of up to 9 KMS planes.
-- 
2.35.1

