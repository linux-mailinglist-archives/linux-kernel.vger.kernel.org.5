Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E027EF321
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345959AbjKQM6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjKQM6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:58:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9BFD55
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 04:58:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E749C433C7;
        Fri, 17 Nov 2023 12:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700225928;
        bh=OvD5lK7GMYVRYYlKjmppBf7oa0LKNZejc/ZeYibOSY4=;
        h=From:To:Cc:Subject:Date:From;
        b=CcO+7b/V7SMWBnGrhKQqxUgQPaPotUYf310+4G1KdltChT90h+lmjl6MjYPkPYkNx
         OuIUmRkShA1vBFhcQBH80P/zw/LEQGCYFsJ4v2WLAbegnn9yDQtysu618dwGFq25V/
         c2yrcrhBjSF+6je4idzCAZCMeWHUEa5ZdPhr2mo5ES5ZYmF3F0Pf9GJXFf5UZ5vBBD
         T7HE5LYxrKLOeReVAVHtRY6flWY9CYG9xyyJSteNrW4Ya0awg6otMCe346JVAFZOOh
         2SnjVpP4u0djkbR/JTUfBUxVd+mrM1C8vKqJcRKZScrSm/ShU/KCtKQ3f313y4LDzk
         nIhoju8jt807g==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] riscv: compat_vdso: align VDSOAS build log
Date:   Fri, 17 Nov 2023 21:58:43 +0900
Message-Id: <20231117125843.1058553-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one more space after "VDSOAS" for better alignment in the build log.

[Before]

  LDS     arch/riscv/kernel/compat_vdso/compat_vdso.lds
  VDSOAS arch/riscv/kernel/compat_vdso/rt_sigreturn.o
  VDSOAS arch/riscv/kernel/compat_vdso/getcpu.o
  VDSOAS arch/riscv/kernel/compat_vdso/flush_icache.o
  VDSOAS arch/riscv/kernel/compat_vdso/note.o
  VDSOLD  arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg
  VDSOSYM include/generated/compat_vdso-offsets.h

[After]

  LDS     arch/riscv/kernel/compat_vdso/compat_vdso.lds
  VDSOAS  arch/riscv/kernel/compat_vdso/rt_sigreturn.o
  VDSOAS  arch/riscv/kernel/compat_vdso/getcpu.o
  VDSOAS  arch/riscv/kernel/compat_vdso/flush_icache.o
  VDSOAS  arch/riscv/kernel/compat_vdso/note.o
  VDSOLD  arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg
  VDSOSYM include/generated/compat_vdso-offsets.h

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/riscv/kernel/compat_vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/compat_vdso/Makefile b/arch/riscv/kernel/compat_vdso/Makefile
index 62fa393b2eb2..3df4cb788c1f 100644
--- a/arch/riscv/kernel/compat_vdso/Makefile
+++ b/arch/riscv/kernel/compat_vdso/Makefile
@@ -74,5 +74,5 @@ quiet_cmd_compat_vdsold = VDSOLD  $@
                    rm $@.tmp
 
 # actual build commands
-quiet_cmd_compat_vdsoas = VDSOAS $@
+quiet_cmd_compat_vdsoas = VDSOAS  $@
       cmd_compat_vdsoas = $(COMPAT_CC) $(a_flags) $(COMPAT_CC_FLAGS) -c -o $@ $<
-- 
2.40.1

