Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FE6797C20
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344226AbjIGSlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242616AbjIGSlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:41:50 -0400
Received: from riemann.telenet-ops.be (riemann.telenet-ops.be [IPv6:2a02:1800:110:4::f00:10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A10180
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:41:45 -0700 (PDT)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by riemann.telenet-ops.be (Postfix) with ESMTPS id 4RhL6D04mpz4x1nk
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:43:00 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:c214:2eac:128d:f67e])
        by xavier.telenet-ops.be with bizsmtp
        id j1hx2A00G2mGBSJ011hxwo; Thu, 07 Sep 2023 15:41:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGQ-002m8w-G8;
        Thu, 07 Sep 2023 15:41:57 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGf-00CMgX-NW;
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
Subject: [PATCH 19/52] m68k: atari: Make ikbd_reset() static
Date:   Thu,  7 Sep 2023 15:41:20 +0200
Message-Id: <5a3c56d3dc8f23b1b2fec61a6553e5f301a80497.1694093327.git.geert@linux-m68k.org>
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

    arch/m68k/atari/atakeyb.c:335:6: warning: no previous prototype for ‘ikbd_reset’ [-Wmissing-prototypes]
      335 | void ikbd_reset(void)
	  |      ^~~~~~~~~~

Fix this by making ikbd_reset() static.
There was never a user outside arch/m68k/atari/atakey.c.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/atari/atakeyb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/atari/atakeyb.c b/arch/m68k/atari/atakeyb.c
index 5e0e682f9c61a60e..49a9a459bdf4ccbd 100644
--- a/arch/m68k/atari/atakeyb.c
+++ b/arch/m68k/atari/atakeyb.c
@@ -332,7 +332,7 @@ void ikbd_write(const char *str, int len)
 }
 
 /* Reset (without touching the clock) */
-void ikbd_reset(void)
+static void ikbd_reset(void)
 {
 	static const char cmd[2] = { 0x80, 0x01 };
 
-- 
2.34.1

