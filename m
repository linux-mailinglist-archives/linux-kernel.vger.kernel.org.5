Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E628379EAB1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241723AbjIMOLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241505AbjIMOKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:10:03 -0400
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5F52123
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:08:54 -0700 (PDT)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by cantor.telenet-ops.be (Postfix) with ESMTPS id 4Rm2PG4Tz4z4x7bC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 16:08:50 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:f674:9611:cd05:f25a])
        by albert.telenet-ops.be with bizsmtp
        id lS8p2A00z3fvA4V06S8p5R; Wed, 13 Sep 2023 16:08:50 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXe-003ctx-Ja;
        Wed, 13 Sep 2023 16:08:48 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXv-00FV79-Uq;
        Wed, 13 Sep 2023 16:08:47 +0200
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
Subject: [PATCH v2 47/52] m68k: sun3: Make sun3_platform_init() static
Date:   Wed, 13 Sep 2023 16:08:37 +0200
Message-Id: <f35e6376d01b11f21f677cb980093e8410d2c33b.1694613528.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694613528.git.geert@linux-m68k.org>
References: <cover.1694613528.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by.
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

