Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A662C775140
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 05:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjHIDL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 23:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjHIDL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 23:11:26 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4088A10F7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 20:11:22 -0700 (PDT)
X-QQ-mid: bizesmtpipv601t1691550655tu60
Received: from localhost.localdomain ( [255.156.107.10])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 09 Aug 2023 11:10:46 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: w8KaQ9l6q4grTOwgxeVA4itTHPKxUqvpEz73M6tPxHUQ8KoVfsJ5neYQsaOtB
        sKqbSt0Iy2eW9k9FsiD844IrMgJ6pC+H0KApXrbpjfoxoyHhD35EO7ouoASe2znGodHCFVf
        UAwDL5dASfiiZxI5FnhQRWZ1g61ZbXpLDwsrex2j3aWka30tdkqaKs5FdfFnkjaj9wZZM22
        PCmQjIaCFnhR8mDxc0PtsInUuntMT0xezfQqv26+OppI5TpjpUZsb8KRXoplJG3em2ScNQB
        vNUpGg5wt/667B0u/ysaCSVGdKH3wQIkGve6QetD4LlfpG23M3tgbCUcPFKZzc8qHYMH9OG
        o9XfejTFv5tfMrmZQ0=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9490210224257605777
From:   Song Shuai <songshuaishuai@tinylab.org>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ajones@ventanamicro.com,
        alexghiti@rivosinc.com, anup@brainfault.org, guoren@kernel.org,
        samuel@sholland.org, rppt@kernel.org, suagrfillet@gmail.com,
        panqinglin2020@iscas.ac.cn
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: mm: Update the comment of CONFIG_PAGE_OFFSET
Date:   Wed,  9 Aug 2023 11:10:23 +0800
Message-Id: <20230809031023.3575407-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_ILLEGAL_IP,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Shuai <suagrfillet@gmail.com>

Since the commit 011f09d12052 set sv57 as default for CONFIG_64BIT,
the comment of CONFIG_PAGE_OFFSET should be updated too.

Fixes: 011f09d12052 ("riscv: mm: Set sv57 on defaultly")
Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 arch/riscv/include/asm/page.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index b55ba20903ec..53c00164c042 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -33,8 +33,8 @@
 #define PAGE_OFFSET		_AC(CONFIG_PAGE_OFFSET, UL)
 #endif
 /*
- * By default, CONFIG_PAGE_OFFSET value corresponds to SV48 address space so
- * define the PAGE_OFFSET value for SV39.
+ * By default, CONFIG_PAGE_OFFSET value corresponds to SV57 address space so
+ * define the PAGE_OFFSET value for SV48 and SV39.
  */
 #define PAGE_OFFSET_L4		_AC(0xffffaf8000000000, UL)
 #define PAGE_OFFSET_L3		_AC(0xffffffd800000000, UL)
-- 
2.20.1

