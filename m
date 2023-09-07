Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A195797712
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241756AbjIGQVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbjIGQUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:20:31 -0400
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [IPv6:2a02:1800:120:4::f00:10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC06D270C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:16:47 -0700 (PDT)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by cantor.telenet-ops.be (Postfix) with ESMTPS id 4RhL5L5zphz4x6gM
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:42:14 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:c214:2eac:128d:f67e])
        by albert.telenet-ops.be with bizsmtp
        id j1hy2A0052mGBSJ061hyaF; Thu, 07 Sep 2023 15:41:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGQ-002m9V-NB;
        Thu, 07 Sep 2023 15:41:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGf-00CMhF-VW;
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
Subject: [PATCH 28/52] m68k: hp300: Include "time.h" for hp300_sched_init()
Date:   Thu,  7 Sep 2023 15:41:29 +0200
Message-Id: <a2f5257ed9e944f5295c7365848e6bac1e4789ee.1694093327.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694093327.git.geert@linux-m68k.org>
References: <cover.1694093327.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1:

    arch/m68k/hp300/time.c:101:13: warning: no previous prototype for ‘hp300_sched_init’ [-Wmissing-prototypes]
      101 | void __init hp300_sched_init(void)
	  |             ^~~~~~~~~~~~~~~~

Fix this by including "time.h".

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/hp300/time.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/m68k/hp300/time.c b/arch/m68k/hp300/time.c
index 1d1b7b3b5dd41583..72621fb9f3e663bd 100644
--- a/arch/m68k/hp300/time.c
+++ b/arch/m68k/hp300/time.c
@@ -20,6 +20,8 @@
 #include <asm/traps.h>
 #include <asm/blinken.h>
 
+#include "time.h"
+
 static u64 hp300_read_clk(struct clocksource *cs);
 
 static struct clocksource hp300_clk = {
-- 
2.34.1

