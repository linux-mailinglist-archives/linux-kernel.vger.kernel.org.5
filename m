Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C13D75E3F0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 18:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjGWQwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 12:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGWQw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 12:52:28 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84131BB
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 09:52:25 -0700 (PDT)
X-QQ-mid: bizesmtp78t1690131137t3ohio40
Received: from tanyuan-Surface-Book-2.localdom ( [119.123.130.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 24 Jul 2023 00:52:16 +0800 (CST)
X-QQ-SSF: 01200000000000401000000A0000000
X-QQ-FEAT: u/EYRCx6PxjGw6hYLRS8Y/NdZapWdbaVk1WqQz1RguVgXBn9GhjiJ9B5Wah2u
        OTJuFVaklpQTepL4Nibk2lfVgFHJHEeyiev+EZWMswmMaAAV0OLJKvgjgtpzHp+C6GvGkVF
        UDnazHy/c8InD+kjOLM3UnumybOH7fAH35ciB3rNSib2At2pD9fl+Ut5ndBn7OlBAo8twbY
        dNccTLm6iw39r6i0DSnH9dUzOHV0vuZaQGjI8NHrq1ja5ZXf73vvFrR4FpTdun/vlYA7Uqy
        FcI884c46o9T/Ohp8EVI6JsKkkaU8QhPoQGS4J8G3Eo35ebnxJaDf+CMvBDurYyqEA3fCrl
        7IIH9FpasXCZAGySVpPYBUP+PdIrA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8709871826437540113
From:   Yuan Tan <tanyuan@tinylab.org>
To:     palmer@dabbelt.com, vincent.chen@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        falcon@tinylab.org, Yuan Tan <tanyuan@tinylab.org>
Subject: [PATCH] riscv: alternatives: fix a typo in comment
Date:   Mon, 24 Jul 2023 00:51:55 +0800
Message-Id: <20230723165155.4896-1-tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the usage of ALTERNATIVE, "always" is misspelled as "alwyas".

Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
---
 arch/riscv/include/asm/alternative-macros.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
index b8c55fb3ab2c..721ec275ce57 100644
--- a/arch/riscv/include/asm/alternative-macros.h
+++ b/arch/riscv/include/asm/alternative-macros.h
@@ -146,7 +146,7 @@
  * vendor_id: The CPU vendor ID.
  * patch_id: The patch ID (erratum ID or cpufeature ID).
  * CONFIG_k: The Kconfig of this patch ID. When Kconfig is disabled, the old
- *	     content will alwyas be executed.
+ *	     content will always be executed.
  */
 #define ALTERNATIVE(old_content, new_content, vendor_id, patch_id, CONFIG_k) \
 	_ALTERNATIVE_CFG(old_content, new_content, vendor_id, patch_id, CONFIG_k)
-- 
2.34.1

