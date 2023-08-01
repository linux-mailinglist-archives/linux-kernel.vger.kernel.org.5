Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BE776A91A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjHAGa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjHAGa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:30:57 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D1C4DB
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 23:30:55 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxRvGdpshk6uUNAA--.32938S3;
        Tue, 01 Aug 2023 14:30:53 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxPCOcpshk8pVDAA--.26385S2;
        Tue, 01 Aug 2023 14:30:52 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     loongarch@lists.linux.dev, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH] LoongArch: Error out if clang version is less than 17.0.0
Date:   Tue,  1 Aug 2023 14:30:46 +0800
Message-Id: <1690871446-23713-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8DxPCOcpshk8pVDAA--.26385S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AFykXFW8JryfCr47CFWrtFc_yoW8Cr4fpr
        1rZw1DKr4kXryFvrZ7J34DWryY9F97JryIgFyUJryUWry2qws5WrW8KrWagFZrZws7Zay0
        gryxG3WS9FyUA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
        6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
        AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
        Ja73UjIFyTuYvjxUc0eHDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On my test machine, the clang version is 16.0.4, when build kernel
with clang:

  make CC=clang loongson3_defconfig
  make CC=clang

there exist many errors such as:

  clang-16: error: argument unused during compilation: '-mabi=lp64s'
  error: unknown register name 'a0' in asm
  error: unknown register name 't0' in asm

the above issues have been fixed in the upstream llvm project recently,
it works well when update clang version to 17.0.0:

  make CC=clang loongson3_defconfig
  make CC=clang menuconfig (set CONFIG_MODULES=n and CONFIG_RELOCATABLE=n)
  make CC=clang

thus 17.0.0 is the minimal clang version to build kernel on LoongArch,
it is better to error out if clang version is less than 17.0.0, then
we can do the right thing to update clang version and avoid wasting
time to analysis kernel errors.

By the way, the clang 17.0.0 still have some issues to build kernel on
LoongArch, you need to unset CONFIG_MODULES and CONFIG_RELOCATABLE to
avoid build errors. Additionally, if you want a workable kernel, some
modules should be set as y instead of m if CONFIG_MODULES=n.

Link: https://github.com/ClangBuiltLinux/linux/issues/1787
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index b1e5db5..f07f62a 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -10,6 +10,12 @@ KBUILD_DEFCONFIG := loongson3_defconfig
 image-name-y			:= vmlinux
 image-name-$(CONFIG_EFI_ZBOOT)	:= vmlinuz
 
+ifdef CONFIG_CC_IS_CLANG
+  ifneq ($(call clang-min-version, 170000),y)
+    $(error Sorry, you need a newer clang version >= 17.0.0)
+  endif
+endif
+
 ifndef CONFIG_EFI_STUB
 KBUILD_IMAGE	:= $(boot)/vmlinux.elf
 else
-- 
2.1.0

