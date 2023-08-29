Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BBF78BE6A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjH2G2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjH2G2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:28:12 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0732218F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:28:08 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Bxd+j3j+1kDKwcAA--.22583S3;
        Tue, 29 Aug 2023 14:28:07 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxPCP1j+1kCD9mAA--.32175S2;
        Tue, 29 Aug 2023 14:28:07 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH] LoongArch: Define the symbol fault as a local label in fpu.S
Date:   Tue, 29 Aug 2023 14:28:05 +0800
Message-Id: <1693290485-3516-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8DxPCP1j+1kCD9mAA--.32175S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AF1UtF1rGr48Gw13XrWDAwc_yoW8Aw17pr
        y7Zr4kWr4rWFnIya9xAwn5WrW5GanrGF47W3ZrA34xCrWjqF1DZa18JrykXF1jqw47JF4F
        qF1rXrWYq3WDA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
        14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial aim is to silence the following objtool warnings:

  arch/loongarch/kernel/fpu.o: warning: objtool: _save_fp_context() falls through to next function fault()
  arch/loongarch/kernel/fpu.o: warning: objtool: _restore_fp_context() falls through to next function fault()
  arch/loongarch/kernel/fpu.o: warning: objtool: _save_lsx_context() falls through to next function fault()
  arch/loongarch/kernel/fpu.o: warning: objtool: _restore_lsx_context() falls through to next function fault()
  arch/loongarch/kernel/fpu.o: warning: objtool: _save_lasx_context() falls through to next function fault()
  arch/loongarch/kernel/fpu.o: warning: objtool: _restore_lasx_context() falls through to next function fault()

Obviously, the symbol fault is not a function, it is just a local label,
so use SYM_CODE_START_LOCAL and SYM_CODE_END to define the symbol fault.

Before:

$ readelf -s arch/loongarch/kernel/fpu.o | awk -F: /fault/'{print $2}'
 000000000000053c     8 FUNC    GLOBAL DEFAULT    1 fault

After:

$ readelf -s arch/loongarch/kernel/fpu.o | awk -F: /fault/'{print $2}'
 000000000000053c     8 NOTYPE  LOCAL  DEFAULT    1 fault

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/kernel/fpu.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/fpu.S b/arch/loongarch/kernel/fpu.S
index b4032de..7defe50 100644
--- a/arch/loongarch/kernel/fpu.S
+++ b/arch/loongarch/kernel/fpu.S
@@ -521,7 +521,7 @@ SYM_FUNC_START(_restore_lasx_context)
 	jr	ra
 SYM_FUNC_END(_restore_lasx_context)
 
-SYM_FUNC_START(fault)
+SYM_CODE_START_LOCAL(fault)
 	li.w	a0, -EFAULT				# failure
 	jr	ra
-SYM_FUNC_END(fault)
+SYM_CODE_END(fault)
-- 
2.1.0

