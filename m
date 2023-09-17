Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33377A34E7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 11:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbjIQJZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 05:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbjIQJZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 05:25:13 -0400
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 17 Sep 2023 02:25:03 PDT
Received: from mail.sf-mail.de (mail.sf-mail.de [IPv6:2a01:4f8:1c17:6fae:616d:6c69:616d:6c69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2688718B
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 02:25:03 -0700 (PDT)
Received: (qmail 7778 invoked from network); 17 Sep 2023 09:18:49 -0000
Received: from unknown ([2001:9e8:6dcb::76d4:35ff:feb7:be92]:52778 HELO eto.sf-tec.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.39dev) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPSA
        for <geert@linux-m68k.org>; Sun, 17 Sep 2023 11:18:49 +0200
From:   Rolf Eike Beer <eike-kernel@sf-tec.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH] m68k: add missing types to asm/irq.h
Date:   Sun, 17 Sep 2023 11:18:20 +0200
Message-ID: <5971770.lOV4Wx5bFT@eto.sf-tec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported in f8b648bf6628 ("net: sunhme: move asm includes to below linux
includes") when including this <asm/*> header before the needed <linux/*>
headers the compilation will fail because of missing types.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
---
 arch/m68k/include/asm/irq.h | 3 +++
 1 file changed, 3 insertions(+)

The patch is entirely untested.

diff --git a/arch/m68k/include/asm/irq.h b/arch/m68k/include/asm/irq.h
index 7829e955ca04..4b182bad0526 100644
--- a/arch/m68k/include/asm/irq.h
+++ b/arch/m68k/include/asm/irq.h
@@ -2,6 +2,8 @@
 #ifndef _M68K_IRQ_H_
 #define _M68K_IRQ_H_
 
+#include <linux/types.h>
+
 /*
  * This should be the same as the max(NUM_X_SOURCES) for all the
  * different m68k hosts compiled into the kernel.
@@ -59,6 +61,7 @@
 struct irq_data;
 struct irq_chip;
 struct irq_desc;
+struct pt_regs;
 extern unsigned int m68k_irq_startup(struct irq_data *data);
 extern unsigned int m68k_irq_startup_irq(unsigned int irq);
 extern void m68k_irq_shutdown(struct irq_data *data);
-- 
2.35.3




