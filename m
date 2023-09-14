Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173A679F674
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 03:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbjINBlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 21:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbjINBk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:40:58 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AD71BD4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 18:40:53 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 38E1egwU060623;
        Thu, 14 Sep 2023 09:40:42 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Thu, 14 Sep 2023
 09:40:38 +0800
From:   Yu Chien Peter Lin <peterlin@andestech.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <david@redhat.com>,
        <akpm@linux-foundation.org>, <alexghiti@rivosinc.com>,
        <bjorn@rivosinc.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ycliang@andestech.com>,
        Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH v2 3/3] riscv: Introduce NAPOT field to PTDUMP
Date:   Thu, 14 Sep 2023 09:40:27 +0800
Message-ID: <20230914014027.273002-3-peterlin@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914014027.273002-1-peterlin@andestech.com>
References: <20230914014027.273002-1-peterlin@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 38E1egwU060623
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the NAPOT field to PTDUMP, allowing it
to display the letter "N" for pages that have the 63rd bit set.

Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
---
 arch/riscv/mm/ptdump.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index b5026fc867e8..387bed809b4f 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -136,6 +136,10 @@ struct prot_bits {
 static const struct prot_bits pte_bits[] = {
 	{
 #ifdef CONFIG_64BIT
+		.mask = _PAGE_NAPOT,
+		.set = "N",
+		.clear = ".",
+	}, {
 		.mask = _PAGE_MTMASK_SVPBMT,
 		.set = "MT(%s)",
 		.clear = "      ",
-- 
2.34.1

