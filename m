Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8ABC807F66
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 05:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjLGEAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 23:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjLGEAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 23:00:15 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0907F193;
        Wed,  6 Dec 2023 20:00:20 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxBfFRQ3FlY4Y_AA--.61920S3;
        Thu, 07 Dec 2023 12:00:17 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxvi9RQ3FljSZXAA--.61641S2;
        Thu, 07 Dec 2023 12:00:17 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Puranjay Mohan <puranjay12@gmail.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] test_bpf: Rename second ALU64_SMOD_X to ALU64_SMOD_K
Date:   Thu,  7 Dec 2023 12:00:10 +0800
Message-ID: <20231207040010.18956-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxvi9RQ3FljSZXAA--.61641S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7XFyrArWfZw1rWr48trWkuFX_yoWDCFgE9a
        18AF9rAF15uFyYvw4agFWDKrs29F1jy3WxCr1DZFWDG3yUtry5Cr4kZr1Dua45WrZav3ZF
        v3Zrt3ZrGwnYkosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
        02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
        wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
        AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vApUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there are two test cases with same name
"ALU64_SMOD_X: -7 % 2 = -1", the first one is right,
the second one should be ALU64_SMOD_K because its
code is BPF_ALU64 | BPF_MOD | BPF_K.

Before:
test_bpf: #170 ALU64_SMOD_X: -7 % 2 = -1 jited:1 4 PASS
test_bpf: #171 ALU64_SMOD_X: -7 % 2 = -1 jited:1 4 PASS

After:
test_bpf: #170 ALU64_SMOD_X: -7 % 2 = -1 jited:1 4 PASS
test_bpf: #171 ALU64_SMOD_K: -7 % 2 = -1 jited:1 4 PASS

Fixes: daabb2b098e0 ("bpf/tests: add tests for cpuv4 instructions")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 lib/test_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 7916503e6a6a..3c5a1ca06219 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -6293,7 +6293,7 @@ static struct bpf_test tests[] = {
 	},
 	/* BPF_ALU64 | BPF_MOD | BPF_K off=1 (SMOD64) */
 	{
-		"ALU64_SMOD_X: -7 % 2 = -1",
+		"ALU64_SMOD_K: -7 % 2 = -1",
 		.u.insns_int = {
 			BPF_LD_IMM64(R0, -7),
 			BPF_ALU64_IMM_OFF(BPF_MOD, R0, 2, 1),
-- 
2.42.0

