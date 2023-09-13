Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F94A79EAA3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241450AbjIMOKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241411AbjIMOJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:09:32 -0400
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [IPv6:2a02:1800:120:4::f00:10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5F11FEF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:08:54 -0700 (PDT)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by cantor.telenet-ops.be (Postfix) with ESMTPS id 4Rm2PG3xj9z4x5Yb
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 16:08:50 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:f674:9611:cd05:f25a])
        by albert.telenet-ops.be with bizsmtp
        id lS8p2A00R3fvA4V06S8p5B; Wed, 13 Sep 2023 16:08:50 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXe-003cta-D5;
        Wed, 13 Sep 2023 16:08:47 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXv-00FV6f-ON;
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
Subject: [PATCH v2 41/52] m68k: sun3: Add missing asmlinkage to sun3_init()
Date:   Wed, 13 Sep 2023 16:08:31 +0200
Message-Id: <9a174020de2c55e108be9bd25fcdec3e48d655c4.1694613528.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694613528.git.geert@linux-m68k.org>
References: <cover.1694613528.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sun3_init() is called from assembly code, so it should be marked
asmlinkage for documentation purposes.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by.
---
 arch/m68k/sun3/config.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/sun3/config.c b/arch/m68k/sun3/config.c
index b932250c9e7ffbae..4550cf25b6f0880a 100644
--- a/arch/m68k/sun3/config.c
+++ b/arch/m68k/sun3/config.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/memblock.h>
 #include <linux/platform_device.h>
+#include <linux/linkage.h>
 
 #include <asm/oplib.h>
 #include <asm/setup.h>
@@ -49,7 +50,7 @@ static void sun3_get_hardware_list(struct seq_file *m)
 	seq_printf(m, "PROM Revision:\t%s\n", romvec->pv_monid);
 }
 
-void __init sun3_init(void)
+asmlinkage void __init sun3_init(void)
 {
 	unsigned char enable_register;
 	int i;
-- 
2.34.1

