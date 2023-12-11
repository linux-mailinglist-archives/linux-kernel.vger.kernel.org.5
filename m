Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E8180C798
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjLKLET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjLKLES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:04:18 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324BDA1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:04:23 -0800 (PST)
X-QQ-mid: bizesmtp73t1702292622tj8j5yuu
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 11 Dec 2023 19:03:40 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: 5q30pvLz2ifwectDw5X1ejEzovDe+SdttSK6eqA0chYVCh0XUtbv4XETa4kck
        A+EYAm88lWow0SrwX5RjG0MO7M/W+Bof2DsgZM/I833wDkp+7uhSiviaquZADvf09fp4u+j
        ZRRkoE0fhwUHZVssdj2ifiAk/CdC6zKgfyhjS70urfxWRyzk0tvZvnETKoZ4w+9iu9FYtvc
        V8E/j5fHNwNKMPLDihwgCw0zxsZPtGLM5uS7rdAVMrWs5tzsHPUyIIpiKU2jcQwXNhQRojT
        i7yaNzDXWtNRxMVEHkyAlw7e2LgeHLMYRkkSnG/RL06fXCqejNUYgDtMA5Ss03oZXZ+9bRE
        gU1Yh2jIZXo3AmCcjKczIBtSrKX6lxKvf0PE8xtw8SkCn4matw=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12009462421657250734
From:   Song Shuai <songshuaishuai@tinylab.org>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, guoren@kernel.org, samitolvanen@google.com,
        conor.dooley@microchip.com, bjorn@rivosinc.com, debug@rivosinc.com,
        songshuaishuai@tinylab.org, greentime.hu@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH --fixes] riscv: Remove SHADOW_OVERFLOW_STACK_SIZE macro
Date:   Mon, 11 Dec 2023 19:03:31 +0800
Message-Id: <20231211110331.359534-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_PBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit be97d0db5f44 ("riscv: VMAP_STACK overflow
detection thread-safe") got rid of `shadow_stack`,
so SHADOW_OVERFLOW_STACK_SIZE should be removed too.

Fixes: be97d0db5f44 ("riscv: VMAP_STACK overflow detection thread-safe")
Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 arch/riscv/include/asm/thread_info.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 574779900bfb..4856697c5f25 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -28,7 +28,6 @@
 
 #define THREAD_SHIFT            (PAGE_SHIFT + THREAD_SIZE_ORDER)
 #define OVERFLOW_STACK_SIZE     SZ_4K
-#define SHADOW_OVERFLOW_STACK_SIZE (1024)
 
 #define IRQ_STACK_SIZE		THREAD_SIZE
 
-- 
2.20.1

