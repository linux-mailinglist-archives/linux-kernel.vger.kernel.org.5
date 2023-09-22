Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F317AB66E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjIVQrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjIVQrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:47:06 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6941A1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:46:59 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id jjIsq2ZPzvU2mjjIsqGgWO; Fri, 22 Sep 2023 18:46:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1695401216;
        bh=Q1oYEVgCzB2BEas6VVucG5Z6yGKKhY2zMrab8TyT8H8=;
        h=From:To:Cc:Subject:Date;
        b=X15GIoiohLjAaHucwxuvze1L032YvbXPA4L4dzmux09BBwsFP2Ih1ehfM7HnotQCS
         fZZNerdTtHIAwQmvjZrHjpRZj2B3yUn4clkKn33w9teMEeMBffD6w6EXNnkSpdP5tk
         JENDrzspr8UCGW8fAVJolqctQIqs6cpJ17ek2vYUQ/Y3WBNrfaDDEyzArF26AExsvo
         IJ3QSohNW5/XEtwqoTiCdaZtM+eyVFgikxibEdKgKs/oyqmi3YcI/KKu0LMl3/7bOn
         e+6lXYqjhEchzYgjZUMYzHOLo7dMIY+R7jA/tYJKD52g1iFq6RMw2mtBLzwNZ729y8
         xHV6Dh5CQTSGQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 22 Sep 2023 18:46:56 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] x86/kgdb: Fix a kerneldoc issue when build with W=1
Date:   Fri, 22 Sep 2023 18:46:49 +0200
Message-Id: <aad659537c1d4ebd86912a6f0be458676c8e69af.1695401178.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiled with W=1, the following warning is generated:
  arch/x86/kernel/kgdb.c:698: warning: Cannot understand  *
   on line 698 - I thought it was a doc line

Remove the corresponding empty comment line to fix the warning.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/x86/kernel/kgdb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 3a43a2dee658..9c9faa1634fb 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -695,7 +695,6 @@ void kgdb_arch_exit(void)
 }
 
 /**
- *
  *	kgdb_skipexception - Bail out of KGDB when we've been triggered.
  *	@exception: Exception vector number
  *	@regs: Current &struct pt_regs.
-- 
2.34.1

