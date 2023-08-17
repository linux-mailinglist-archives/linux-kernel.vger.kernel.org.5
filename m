Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A823877F985
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352231AbjHQOpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352225AbjHQOpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:45:03 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A27BF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:45:01 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:d85a:258d:2c59:b44])
        by albert.telenet-ops.be with bizsmtp
        id aeky2A00h4QHFyo06eky8H; Thu, 17 Aug 2023 16:44:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWeF1-000u8d-5u;
        Thu, 17 Aug 2023 16:44:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWeF8-007SBM-MH;
        Thu, 17 Aug 2023 16:44:58 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/6] m68k: math-emu: Fix incorrect file reference in fp_log.c
Date:   Thu, 17 Aug 2023 16:44:48 +0200
Message-Id: <faf2244c3c80a4d70da5a18dd2a170a15b3ebd88.1692283195.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1692283195.git.geert@linux-m68k.org>
References: <cover.1692283195.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file comment header refers to the wrong file.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/math-emu/fp_log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/math-emu/fp_log.c b/arch/m68k/math-emu/fp_log.c
index 0663067870f2a916..a8eac8c81757d22e 100644
--- a/arch/m68k/math-emu/fp_log.c
+++ b/arch/m68k/math-emu/fp_log.c
@@ -1,6 +1,6 @@
 /*
 
-  fp_trig.c: floating-point math routines for the Linux-m68k
+  fp_log.c: floating-point math routines for the Linux-m68k
   floating point emulator.
 
   Copyright (c) 1998-1999 David Huggins-Daines / Roman Zippel.
-- 
2.34.1

