Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D06479EA9A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241342AbjIMOKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241347AbjIMOJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:09:14 -0400
Received: from riemann.telenet-ops.be (riemann.telenet-ops.be [IPv6:2a02:1800:110:4::f00:10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9239F1FCE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:08:53 -0700 (PDT)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by riemann.telenet-ops.be (Postfix) with ESMTPS id 4Rm2PH2q0Sz4x20h
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 16:08:51 +0200 (CEST)
Received: from ramsan.of.borg ([84.195.187.55])
        by xavier.telenet-ops.be with bizsmtp
        id lS8q2A0021C8whw01S8q3q; Wed, 13 Sep 2023 16:08:51 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXe-003ctI-8w;
        Wed, 13 Sep 2023 16:08:47 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXv-00FV6L-Ja;
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
Subject: [PATCH v2 37/52] m68k: sun3/3x: Include <asm/config.h> for config_sun3*()
Date:   Wed, 13 Sep 2023 16:08:27 +0200
Message-Id: <b9178e864d6c5e06c177d53bc4cce6d689f94d78.1694613528.git.geert@linux-m68k.org>
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

    arch/m68k/sun3/config.c:123:13: warning: no previous prototype for ‘config_sun3’ [-Wmissing-prototypes]
      126 | void __init config_sun3(void)
	  |             ^~~~~~~~~~~
    arch/m68k/sun3x/config.c:42:13: warning: no previous prototype for ‘config_sun3x’ [-Wmissing-prototypes]
       42 | void __init config_sun3x(void)
	  |             ^~~~~~~~~~~~

Fix this by including <asm/config.h>

Fixes: 91d7b75a5888c182 ("m68k: Add asm/config.h")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by.
---
 arch/m68k/sun3/config.c  | 1 +
 arch/m68k/sun3x/config.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/m68k/sun3/config.c b/arch/m68k/sun3/config.c
index 203f428a0344a735..b932250c9e7ffbae 100644
--- a/arch/m68k/sun3/config.c
+++ b/arch/m68k/sun3/config.c
@@ -32,6 +32,7 @@
 #include <asm/irq.h>
 #include <asm/sections.h>
 #include <asm/sun3ints.h>
+#include <asm/config.h>
 
 char sun3_reserved_pmeg[SUN3_PMEGS_NUM];
 
diff --git a/arch/m68k/sun3x/config.c b/arch/m68k/sun3x/config.c
index 37121a0f12531fef..3a10cda636fc38fb 100644
--- a/arch/m68k/sun3x/config.c
+++ b/arch/m68k/sun3x/config.c
@@ -19,6 +19,7 @@
 #include <asm/sun3ints.h>
 #include <asm/setup.h>
 #include <asm/oplib.h>
+#include <asm/config.h>
 
 #include "time.h"
 
-- 
2.34.1

