Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1392C7973DD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245056AbjIGPcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245097AbjIGP3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:29:14 -0400
Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [IPv6:2a02:1800:110:4::f00:11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899F2197
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:28:45 -0700 (PDT)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4RhL5L5zN4z4wxQH
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:42:14 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:c214:2eac:128d:f67e])
        by baptiste.telenet-ops.be with bizsmtp
        id j1hx2A00F2mGBSJ011hxWw; Thu, 07 Sep 2023 15:41:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGP-002m7o-WD;
        Thu, 07 Sep 2023 15:41:57 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGf-00CMfC-7k;
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
Subject: [PATCH 02/52] m68k: kernel: Include <linux/cpu.h> for trap_init()
Date:   Thu,  7 Sep 2023 15:41:03 +0200
Message-Id: <9734b933bb64673532a31ddcbc61fdbee964cb8e.1694093327.git.geert@linux-m68k.org>
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

    arch/m68k/kernel/vectors.c:74:13: warning: no previous prototype for ‘trap_init’ [-Wmissing-prototypes]
       74 | void __init trap_init (void)
	  |             ^~~~~~~~~

Fix this by including <linux/cpu.h>.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/kernel/vectors.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/m68k/kernel/vectors.c b/arch/m68k/kernel/vectors.c
index 322c977bb9ecfbee..68762fc1dc97b4e1 100644
--- a/arch/m68k/kernel/vectors.c
+++ b/arch/m68k/kernel/vectors.c
@@ -17,6 +17,7 @@
 /*
  * Sets up all exception vectors
  */
+#include <linux/cpu.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
 #include <linux/linkage.h>
-- 
2.34.1

