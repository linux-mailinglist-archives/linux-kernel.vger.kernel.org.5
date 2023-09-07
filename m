Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3A0797431
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbjIGPg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344270AbjIGPcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:32:48 -0400
Received: from riemann.telenet-ops.be (riemann.telenet-ops.be [IPv6:2a02:1800:110:4::f00:10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3AE171C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:32:24 -0700 (PDT)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by riemann.telenet-ops.be (Postfix) with ESMTPS id 4RhL536s87z4x2KG
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:41:59 +0200 (CEST)
Received: from ramsan.of.borg ([84.195.187.55])
        by laurent.telenet-ops.be with bizsmtp
        id j1hy2A00b1C8whw011hytu; Thu, 07 Sep 2023 15:41:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGR-002mAj-3v;
        Thu, 07 Sep 2023 15:41:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGg-00CMil-CG;
        Thu, 07 Sep 2023 15:41:58 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Philip Blundell <philb@gnu.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        Laurent Vivier <laurent@vivier.eu>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 47/52] m68k: sun3: Make sun3_platform_init() static
Date:   Thu,  7 Sep 2023 15:41:48 +0200
Message-Id: <a485168952c9ae65250dd35d445a1039fd95f9e3.1694093327.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694093327.git.geert@linux-m68k.org>
References: <cover.1694093327.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1:

    arch/m68k/sun3/config.c:201:12: warning: no previous prototype for ‘sun3_platform_init’ [-Wmissing-prototypes]
      202 | int __init sun3_platform_init(void)
	  |            ^~~~~~~~~~~~~~~~~~

Fix this by making sun3_platform_init() static.
There was never a user outside arch/m68k/sun3/config.c.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/sun3/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/sun3/config.c b/arch/m68k/sun3/config.c
index 6e24920e4195490b..40796c3e84400def 100644
--- a/arch/m68k/sun3/config.c
+++ b/arch/m68k/sun3/config.c
@@ -199,7 +199,7 @@ static const struct resource sun3_scsi_rsrc[] __initconst = {
 	},
 };
 
-int __init sun3_platform_init(void)
+static int __init sun3_platform_init(void)
 {
 	switch (idprom->id_machtype) {
 	case SM_SUN3 | SM_3_160:
-- 
2.34.1

