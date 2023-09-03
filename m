Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8432A790C25
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 15:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238081AbjICNhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 09:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238032AbjICNhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 09:37:38 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEA7FB;
        Sun,  3 Sep 2023 06:37:35 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 248D41866A1A;
        Sun,  3 Sep 2023 16:37:32 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id QQ9uYetXdeN2; Sun,  3 Sep 2023 16:37:31 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id C17561866B52;
        Sun,  3 Sep 2023 16:37:31 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id K58ZH9uiW7iq; Sun,  3 Sep 2023 16:37:31 +0300 (MSK)
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.232.241])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 5E6201866A1A;
        Sun,  3 Sep 2023 16:37:30 +0300 (MSK)
From:   Alexandra Diupina <adiupina@astralinux.ru>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Alexandra Diupina <adiupina@astralinux.ru>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] drm/rcar-du: fix comment to rcar_du_group_get()
Date:   Sun,  3 Sep 2023 16:37:09 +0300
Message-Id: <20230903133709.8049-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rcar_du_group_get() never returns a negative
error code (always returns 0), so change
the comment about returned value

Fixes: cb2025d2509f ("drm/rcar-du: Introduce CRTCs groups")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
 drivers/gpu/drm/renesas/rcar-du/rcar_du_group.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_group.c b/drivers/gp=
u/drm/renesas/rcar-du/rcar_du_group.c
index 2ccd2581f544..499d4e56c32d 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_group.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_group.c
@@ -200,7 +200,7 @@ static void rcar_du_group_setup(struct rcar_du_group =
*rgrp)
  *
  * This function must be called with the DRM mode_config lock held.
  *
- * Return 0 in case of success or a negative error code otherwise.
+ * Always return 0.
  */
 int rcar_du_group_get(struct rcar_du_group *rgrp)
 {
--=20
2.30.2

