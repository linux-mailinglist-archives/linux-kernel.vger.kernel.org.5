Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AAD797A05
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239127AbjIGR2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243590AbjIGR2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:28:20 -0400
Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [IPv6:2a02:1800:110:4::f00:11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0477B170E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:27:52 -0700 (PDT)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4RhL6D011Mz4x1MH
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:43:00 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:c214:2eac:128d:f67e])
        by albert.telenet-ops.be with bizsmtp
        id j1hy2A00F2mGBSJ061hyaM; Thu, 07 Sep 2023 15:41:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGQ-002m9Y-Ni;
        Thu, 07 Sep 2023 15:41:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGf-00CMhK-WA;
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
Subject: [PATCH 29/52] m68k: mac: Remove unused sine_data[]
Date:   Thu,  7 Sep 2023 15:41:30 +0200
Message-Id: <0bbdc6f8e1164b5fc5965002cd8a88e0c008c930.1694093327.git.geert@linux-m68k.org>
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

    arch/m68k/mac/macboing.c:29:26: warning: ‘sine_data’ defined but not used [-Wunused-const-variable=]
       29 | static const signed char sine_data[] = {
	  |                          ^~~~~~~~~

The predefined sine table was superseded by a table calculated at
run-time in v2.2.0.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/mac/macboing.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/m68k/mac/macboing.c b/arch/m68k/mac/macboing.c
index 4de6229c7bfdebce..76431241347682fc 100644
--- a/arch/m68k/mac/macboing.c
+++ b/arch/m68k/mac/macboing.c
@@ -22,15 +22,6 @@ static int mac_asc_inited;
  */
 static __u8 mac_asc_wave_tab[ 0x800 ];
 
-/*
- * Alan's original sine table; needs interpolating to 0x800
- * (hint: interpolate or hardwire [0 -> Pi/2[, it's symmetric)
- */
-static const signed char sine_data[] = {
-	0,  39,  75,  103,  121,  127,  121,  103,  75,  39,
-	0, -39, -75, -103, -121, -127, -121, -103, -75, -39
-};
-
 /*
  * where the ASC hides ...
  */
-- 
2.34.1

