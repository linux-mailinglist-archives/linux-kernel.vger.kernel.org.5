Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CD2797B17
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240527AbjIGSDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjIGSC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:02:58 -0400
Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [IPv6:2a02:1800:120:4::f00:11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240E91FE4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:02:36 -0700 (PDT)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by gauss.telenet-ops.be (Postfix) with ESMTPS id 4RhL534HMBz4x3lk
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:41:59 +0200 (CEST)
Received: from ramsan.of.borg ([84.195.187.55])
        by xavier.telenet-ops.be with bizsmtp
        id j1hy2A0071C8whw011hywp; Thu, 07 Sep 2023 15:41:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGQ-002m9p-Qm;
        Thu, 07 Sep 2023 15:41:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGg-00CMhf-2t;
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
Subject: [PATCH 33/52] m68k: mvme147: Make mvme147_init_IRQ() static
Date:   Thu,  7 Sep 2023 15:41:34 +0200
Message-Id: <ebca254f27ed507794210220f3eb6ac396946097.1694093327.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694093327.git.geert@linux-m68k.org>
References: <cover.1694093327.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1:

    arch/m68k/mvme147/config.c:76:13: warning: no previous prototype for ‘mvme147_init_IRQ’ [-Wmissing-prototypes]
       76 | void __init mvme147_init_IRQ(void)
	  |             ^~~~~~~~~~~~~~~~

Fix this by making mvme147_init_IRQ() static.
The function body was moved to arch/m68k/mvme147/config.c in v2.6.18.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/mvme147/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/mvme147/config.c b/arch/m68k/mvme147/config.c
index 4e6218115f43ce56..7dfacd0b207a9750 100644
--- a/arch/m68k/mvme147/config.c
+++ b/arch/m68k/mvme147/config.c
@@ -73,7 +73,7 @@ static void mvme147_get_model(char *model)
  * the mvme147 IRQ handling routines.
  */
 
-void __init mvme147_init_IRQ(void)
+static void __init mvme147_init_IRQ(void)
 {
 	m68k_setup_user_interrupt(VEC_USER, 192);
 }
-- 
2.34.1

