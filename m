Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213347AE78B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjIZILP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbjIZILK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:11:10 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB9B5E4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 01:11:02 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxuOgUkhJlTZUsAA--.49546S3;
        Tue, 26 Sep 2023 16:11:00 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxni8NkhJlnnoSAA--.37906S5;
        Tue, 26 Sep 2023 16:10:59 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v1 3/3] LoongArch: Add support for 64_PCREL relocation type
Date:   Tue, 26 Sep 2023 16:10:52 +0800
Message-Id: <1695715852-15902-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1695715852-15902-1-git-send-email-yangtiezhu@loongson.cn>
References: <1695715852-15902-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8Bxni8NkhJlnnoSAA--.37906S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJr43Kryrury7ZrWDZr1xtFc_yoW8Zw43pr
        yfAwnxXa1fKFn7Xayqv3WkWw1rWaykW342ga9a9r97ArnxJFyj9w1xtryDtayjvrs5uF4r
        ZryIq3WrZanrAwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
        6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
        AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU8EeHDUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When build and update kernel with the latest upstream binutils and
loongson3_defconfig, the serial console works well with the previous
32_PCREL patch, but it can not enter the graphical interface due to
it failed to start lightdm service, there are more info like this:

  kmod: zsmalloc: Unknown relocation type 109
  kmod: fuse: Unknown relocation type 109
  kmod: fuse: Unknown relocation type 109
  kmod: radeon: Unknown relocation type 109
  kmod: nf_tables: Unknown relocation type 109
  kmod: nf_tables: Unknown relocation type 109

This is because the latest upstream binutils replaces a pair of ADD64
and SUB64 with 64_PCREL, so add support for 64_PCREL relocation type.

Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=ecb802d02eeb
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: <stable@vger.kernel.org>
---
 arch/loongarch/kernel/module.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
index 9e10c44..b13b285 100644
--- a/arch/loongarch/kernel/module.c
+++ b/arch/loongarch/kernel/module.c
@@ -376,6 +376,15 @@ static int apply_r_larch_32_pcrel(struct module *mod, u32 *location, Elf_Addr v,
 	return 0;
 }
 
+static int apply_r_larch_64_pcrel(struct module *mod, u32 *location, Elf_Addr v,
+				  s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
+{
+	ptrdiff_t offset = (void *)v - (void *)location;
+
+	*(u64 *)location = offset;
+	return 0;
+}
+
 /*
  * reloc_handlers_rela() - Apply a particular relocation to a module
  * @mod: the module to apply the reloc to
@@ -406,6 +415,7 @@ static reloc_rela_handler reloc_rela_handlers[] = {
 	[R_LARCH_ADD32 ... R_LARCH_SUB64]		     = apply_r_larch_add_sub,
 	[R_LARCH_PCALA_HI20...R_LARCH_PCALA64_HI12]	     = apply_r_larch_pcala,
 	[R_LARCH_32_PCREL]				     = apply_r_larch_32_pcrel,
+	[R_LARCH_64_PCREL]				     = apply_r_larch_64_pcrel,
 };
 
 int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
-- 
2.1.0

