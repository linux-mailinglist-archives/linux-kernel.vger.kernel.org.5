Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BB375CC96
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjGUPv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjGUPu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:50:59 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E564D4203;
        Fri, 21 Jul 2023 08:50:36 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A1C6D1BF204;
        Fri, 21 Jul 2023 15:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689954631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nd2PpfLMysaXbfB2DPXdI9pjC+FwaFKuBLOK0AXd8P0=;
        b=hSPu3ZzHCSOZl/DI4VE2RXJVCqsYza+wE5yLDjBufT8Y3CQqMlEymRpm/4lKvwSPcX3q5J
        WdJ7lbuay1ubEKb2UFvixMFYueYUIPoZvvruFikvcm9ucjEpPDsIyEgNrNLsFRibbIXguE
        Qzn1bkfMvD04W6oh3n+VxLb119Kv0NrLnGlGJbBBw7b/eO8oU3ba9VmEDJXqpK8/JrOsJw
        XKNKTZ6DqvLcQAp7+DM1kBauNiYQEi+DXa/GHeuJ7S/ioTrCAtR0rErvoYVdwxDhEx3LeK
        EzhHZUUFRZd+a+oA/lJRS4H9id2SPsREyd5pwCBgB0Si3ueptiQIKz36+Evong==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH] media: doc: dev-encoder: Fixup type for ENUM_FRAMEINTERVALS
Date:   Fri, 21 Jul 2023 17:50:19 +0200
Message-ID: <20230721155019.112985-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The doc mistakently mentions v4l2_frmsizeenum as the struct type passed
to VIDIOC_ENUM_FRAMEINTERVALS, while it's actually v4l2_frmivalenum that
should be used.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 Documentation/userspace-api/media/v4l/dev-encoder.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/dev-encoder.rst b/Documentation/userspace-api/media/v4l/dev-encoder.rst
index 15ca234459bb..6c523c69bdce 100644
--- a/Documentation/userspace-api/media/v4l/dev-encoder.rst
+++ b/Documentation/userspace-api/media/v4l/dev-encoder.rst
@@ -115,8 +115,8 @@ Querying Capabilities
 
 4. The client may use :c:func:`VIDIOC_ENUM_FRAMEINTERVALS` to detect supported
    frame intervals for a given format and resolution, passing the desired pixel
-   format in :c:type:`v4l2_frmsizeenum` ``pixel_format`` and the resolution
-   in :c:type:`v4l2_frmsizeenum` ``width`` and :c:type:`v4l2_frmsizeenum`
+   format in :c:type:`v4l2_frmivalenum` ``pixel_format`` and the resolution
+   in :c:type:`v4l2_frmivalenum` ``width`` and :c:type:`v4l2_frmivalenum`
    ``height``.
 
    * Values returned by :c:func:`VIDIOC_ENUM_FRAMEINTERVALS` for a coded pixel
-- 
2.41.0

