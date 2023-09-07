Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820BA797690
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237078AbjIGQNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237849AbjIGQMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:12:42 -0400
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [IPv6:2a02:1800:120:4::f00:10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7407055AB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:09:44 -0700 (PDT)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by cantor.telenet-ops.be (Postfix) with ESMTPS id 4RhL6D02ddz4xT4y
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:43:00 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:c214:2eac:128d:f67e])
        by andre.telenet-ops.be with bizsmtp
        id j1hx2A00L2mGBSJ011hxG2; Thu, 07 Sep 2023 15:41:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGQ-002m8Q-8f;
        Thu, 07 Sep 2023 15:41:57 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGf-00CMft-GC;
        Thu, 07 Sep 2023 15:41:57 +0200
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
Subject: [PATCH 11/52] m68k: mm: Include <asm/hwtest.h> for hwreg_()
Date:   Thu,  7 Sep 2023 15:41:12 +0200
Message-Id: <de716f0e6228379d8b27b03301eb78d1dc5c8fff.1694093327.git.geert@linux-m68k.org>
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

    arch/m68k/mm/hwtest.c:29:5: warning: no previous prototype for ‘hwreg_present’ [-Wmissing-prototypes]
       29 | int hwreg_present(volatile void *regp)
	  |     ^~~~~~~~~~~~~
    arch/m68k/mm/hwtest.c:62:5: warning: no previous prototype for ‘hwreg_write’ [-Wmissing-prototypes]
       62 | int hwreg_write(volatile void *regp, unsigned short val)
	  |     ^~~~~~~~~~~

Fix this by including <asm/hwtest.h>.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/mm/hwtest.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/m68k/mm/hwtest.c b/arch/m68k/mm/hwtest.c
index fe99aa99987e9c38..8ee7a336868868bb 100644
--- a/arch/m68k/mm/hwtest.c
+++ b/arch/m68k/mm/hwtest.c
@@ -26,6 +26,8 @@
 
 #include <linux/module.h>
 
+#include <asm/hwtest.h>
+
 int hwreg_present(volatile void *regp)
 {
 	int ret = 0;
-- 
2.34.1

