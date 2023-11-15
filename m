Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C790A7EC383
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343938AbjKONV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343884AbjKONV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:21:56 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 346AE11D;
        Wed, 15 Nov 2023 05:21:51 -0800 (PST)
Received: from loongson.cn (unknown [112.22.233.25])
        by gateway (Coremail) with SMTP id _____8BxbOrtxVRlyEY6AA--.21729S3;
        Wed, 15 Nov 2023 21:21:49 +0800 (CST)
Received: from localhost.localdomain (unknown [112.22.233.25])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axzy_pxVRlXQNDAA--.16352S2;
        Wed, 15 Nov 2023 21:21:48 +0800 (CST)
From:   WANG Rui <wangrui@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, Xi Ruoyao <xry111@xry111.site>,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn, WANG Rui <wangrui@loongson.cn>
Subject: [PATCH] LoongArch: Explicitly set -fdirect-access-external-data for vmlinux
Date:   Wed, 15 Nov 2023 21:21:37 +0800
Message-ID: <20231115132137.178523-1-wangrui@loongson.cn>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axzy_pxVRlXQNDAA--.16352S2
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7JrWUtr47Ww47Zr4rGryrZrc_yoW8Jrykpa
        97ur48Gws5ArWIqF9FqFWfXw4qyr4DJr4fZa47Krn8ZFyDZryfZw45Ar4qg3W2y34kAryx
        Wa1xGFy2qFW5JwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After this llvm commit [1], The -fno-pic does not imply direct access
external data. Explicitly set -fdirect-access-external-data for vmlinux
that can avoids GOT entries.

Link: https://github.com/llvm/llvm-project/commit/47eeee297775347cbdb7624d6a766c2a3eec4a59
Suggested-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: WANG Rui <wangrui@loongson.cn>
---
 arch/loongarch/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index c31a62521e6b..1f0d74403419 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -68,6 +68,7 @@ LDFLAGS_vmlinux			+= -static -n -nostdlib
 ifdef CONFIG_AS_HAS_EXPLICIT_RELOCS
 cflags-y			+= $(call cc-option,-mexplicit-relocs)
 KBUILD_CFLAGS_KERNEL		+= $(call cc-option,-mdirect-extern-access)
+KBUILD_CFLAGS_KERNEL		+= $(call cc-option,-fdirect-access-external-data)
 KBUILD_AFLAGS_MODULE		+= $(call cc-option,-fno-direct-access-external-data)
 KBUILD_CFLAGS_MODULE		+= $(call cc-option,-fno-direct-access-external-data)
 KBUILD_AFLAGS_MODULE		+= $(call cc-option,-mno-relax) $(call cc-option,-Wa$(comma)-mno-relax)
-- 
2.42.1

