Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B276F787861
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 21:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243035AbjHXTJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 15:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjHXTJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 15:09:25 -0400
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CB3E6B;
        Thu, 24 Aug 2023 12:09:22 -0700 (PDT)
Received: from xmz-huawei.. (unknown [111.197.209.91])
        by APP-03 (Coremail) with SMTP id rQCowAAXHmbGqudkwlMABQ--.63174S2;
        Fri, 25 Aug 2023 03:08:55 +0800 (CST)
From:   Mingzheng Xing <xingmingzheng@iscas.ac.cn>
To:     Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     Bin Meng <bmeng@tinylab.org>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, stable@vger.kernel.org,
        Mingzheng Xing <xingmingzheng@iscas.ac.cn>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH] riscv: Fix build errors using binutils2.37 toolchains
Date:   Fri, 25 Aug 2023 03:08:52 +0800
Message-Id: <20230824190852.45470-1-xingmingzheng@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAXHmbGqudkwlMABQ--.63174S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw15uF48Cw4ftFy5ZF1rXrb_yoW5Cw4fp3
        4fCFn8Kr1rWF1xJr10yr18W3WYgrZ5J39Igr4kXr4Uuws5ZrZrJ34vkr129rsFvrs7trZ5
        Zr4F9a1rWF1DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
        4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
        DUUUUU=
X-Originating-IP: [111.197.209.91]
X-CM-SenderInfo: 50lqwzhlqj6xxhqjqxpvfd2hldfou0/1tbiCgUNCmTnYiSHfgAAs0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building the kernel with binutils 2.37 and GCC-11.1.0/GCC-11.2.0,
the following error occurs:

  Assembler messages:
  Error: cannot find default versions of the ISA extension `zicsr'
  Error: cannot find default versions of the ISA extension `zifencei'

The above error originated from this commit of binutils[0], which has been
resolved and backported by GCC-12.1.0[1] and GCC-11.3.0[2].

So fix this by change the GCC version in
CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC to GCC-11.3.0.

Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=f0bae2552db1dd4f1995608fbf6648fcee4e9e0c [0]
Link: https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=ca2bbb88f999f4d3cc40e89bc1aba712505dd598 [1]
Link: https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=d29f5d6ab513c52fd872f532c492e35ae9fd6671 [2]
Fixes: ca09f772ccca ("riscv: Handle zicsr/zifencei issue between gcc and binutils")
Reported-by: Conor Dooley <conor.dooley@microchip.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
---

Then below are my test results after this fix:

gcc        binutils

10.5.0     2.35            ok
10.5.0     2.36            ok
10.5.0     2.37            ok
10.5.0     2.38            ok

11.1.0     2.35            ok
11.1.0     2.36            ok
11.1.0     2.37            ok
11.1.0     2.38            ok

11.2.0     2.35            ok
11.2.0     2.36            ok
11.2.0     2.37            ok
11.2.0     2.38            ok

11.3.0     2.35            ok
11.3.0     2.36            ok
11.3.0     2.37            ok
11.3.0     2.38            ok

11.4.0     2.35            ok
11.4.0     2.36            ok
11.4.0     2.37            ok
11.4.0     2.38            ok

12.1.0     2.35            ok
12.1.0     2.36            ok
12.1.0     2.37            ok
12.1.0     2.38            ok

12.2.0     2.35            ok
12.2.0     2.36            ok
12.2.0     2.37            ok
12.2.0     2.38            ok 

 arch/riscv/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 10e7a7ad175a..bea7b73e895d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -580,15 +580,15 @@ config TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
 	  and Zifencei are supported in binutils from version 2.36 onwards.
 	  To make life easier, and avoid forcing toolchains that default to a
 	  newer ISA spec to version 2.2, relax the check to binutils >= 2.36.
-	  For clang < 17 or GCC < 11.1.0, for which this is not possible, this is
-	  dealt with in CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC.
+	  For clang < 17 or GCC < 11.3.0, for which this is not possible or need
+	  special treatment, this is dealt with in TOOLCHAIN_NEEDS_OLD_ISA_SPEC.
 
 config TOOLCHAIN_NEEDS_OLD_ISA_SPEC
 	def_bool y
 	depends on TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
 	# https://github.com/llvm/llvm-project/commit/22e199e6afb1263c943c0c0d4498694e15bf8a16
-	# https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=b03be74bad08c382da47e048007a78fa3fb4ef49
-	depends on (CC_IS_CLANG && CLANG_VERSION < 170000) || (CC_IS_GCC && GCC_VERSION < 110100)
+	# https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=d29f5d6ab513c52fd872f532c492e35ae9fd6671
+	depends on (CC_IS_CLANG && CLANG_VERSION < 170000) || (CC_IS_GCC && GCC_VERSION < 110300)
 	help
 	  Certain versions of clang and GCC do not support zicsr and zifencei via
 	  -march. This option causes an older ISA spec compatible with these older
-- 
2.34.1

