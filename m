Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7EB7DA33B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 00:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346738AbjJ0WL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 18:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346685AbjJ0WLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 18:11:49 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F40010CB;
        Fri, 27 Oct 2023 15:11:30 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 043923200917;
        Fri, 27 Oct 2023 18:11:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 27 Oct 2023 18:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1698444688; x=
        1698531088; bh=GQtOu2SP23PEZmWtQVCsoCbcovZ67XlhJHkFJBQ+htw=; b=d
        PUABwfkYjJ8KyexOxaDKxq6pLkPvSXI30MC8tsKixqPCMFpBqmfzsY8dbopgfqbP
        HPgeKeeXL+nCzC5E/JsjaP73LEbauuqPxyWEou9PQe0ZuOjG7xMAJ0FAgwNJ0V4g
        6iBPV8jCPwhqXfa/NtQy+BLHwgq8m+nSeV0A0jqqYn1mDMdCzEGn7bYWZTRYBu9b
        amflf48Cxp7PIpR1fnKoIVT0Nyl6O+shMLg6qyOBzFJg3tadK79Ia6wf9pt3T+X2
        oW2kOjjkbJEbYKkxUxOZxShD1UC39U4fqdJqWnYRT/m/5fkYswQSRwr+20+tFKvw
        H4tVA4Q54JUv/M0C97zJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698444688; x=
        1698531088; bh=GQtOu2SP23PEZmWtQVCsoCbcovZ67XlhJHkFJBQ+htw=; b=t
        XtfXF8aRtxStrvk6+Ycyb5bEKE5893VEyJUcYWCfNSTIR3pT3eSAzeK4SEOwcLYX
        0CdOvEAhGyc/T9tnwh9J3b8NFkHphDBO3VJy70EzVI+L7YHZI/odEpzwbNsDc6tv
        067fwzX6/9m2BUF4j9bu+l2ajSgxT0WHb9xOm7XoRk2jP2RvN+eBgzW1+Ta26yO0
        WMoGE/Hz6pWHu7IFwVRVeaI1V5A/zP0gugUsVOyKWBKZxLJ7qN3zA1+rZ1+g5j/O
        p6biZ3vqctJeq84e0hIWddAkGM/ApZrFZlnyjtJ9oG5A5a1k3hGnl/otMi2Ket8I
        G/O7HDnNjIgg7vEWNmq9A==
X-ME-Sender: <xms:kDU8ZQSk_2sGNL9K167Tn7fdu9pqSg4MZpPcguZuQqk29_RtHBRVUA>
    <xme:kDU8ZdyJ2py_1pUSyi1pfCswmQnJQeYUKAXMUMX7nP43scTMtLIeCrKnwRTpLoLgg
    dc53eL4gprKBBCs9Is>
X-ME-Received: <xmr:kDU8Zd2yGPfWQaXzquZAn6hDlv_ud_ARchAEMOyfdHriY6p-59xex7F-Dj0HjQq8gVY_5GyvuYY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleehgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeefledufeehgedvuedvvd
    egkefgvddttedtleeiiefhgeetudegkefhvdfhjeeftdenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihgh
    horghtrdgtohhm
X-ME-Proxy: <xmx:kDU8ZUAi1jRGtUBsYw4vhHlDfP8Dild4seoeLKI2T7xNstFdAmoeBw>
    <xmx:kDU8ZZjZNTGo-wybZDOw1oMz_FYFrpkJdGtKcqjbCpaHDxxNe_7rIw>
    <xmx:kDU8ZQrScj77abc4rokVCXQGOzo4fl6zwYqdkYoC27jASdA-YVCXmQ>
    <xmx:kDU8ZZc7aK1tdhCA5GbrUOcFHSbHE4iuM5zo-epmV9NtOlL0J-PtQg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 18:11:27 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        gregory.clement@bootlin.com, vladimir.kondratiev@intel.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 07/10] MIPS: traps: Handle CPU with non standard vint offset
Date:   Fri, 27 Oct 2023 23:11:03 +0100
Message-Id: <20231027221106.405666-8-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027221106.405666-1-jiaxun.yang@flygoat.com>
References: <20231027221106.405666-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some BMIPS cpus has none standard start offset for vector interrupts.

Handle those CPUs in vector size calculation and handler setup process.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/kernel/traps.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index ea59d321f713..651c9ec6265a 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -74,7 +74,6 @@
 
 #include "access-helper.h"
 
-#define MAX(a, b) ((a) >= (b) ? (a) : (b))
 
 extern void check_wait(void);
 extern asmlinkage void rollback_handle_int(void);
@@ -2005,6 +2004,7 @@ void __noreturn nmi_exception_handler(struct pt_regs *regs)
 unsigned long ebase;
 EXPORT_SYMBOL_GPL(ebase);
 unsigned long exception_handlers[32];
+static unsigned long vi_vecbase;
 unsigned long vi_handlers[64];
 
 void reserve_exception_space(phys_addr_t addr, unsigned long size)
@@ -2074,7 +2074,7 @@ static void *set_vi_srs_handler(int n, vi_handler_t addr, int srs)
 		handler = (unsigned long) addr;
 	vi_handlers[n] = handler;
 
-	b = (unsigned char *)(ebase + 0x200 + n*VECTORSPACING);
+	b = (unsigned char *)(vi_vecbase + n*VECTORSPACING);
 
 	if (srs >= srssets)
 		panic("Shadow register set %d not supported", srs);
@@ -2370,20 +2370,33 @@ void __init trap_init(void)
 	extern char except_vec3_generic;
 	extern char except_vec4;
 	extern char except_vec3_r4000;
-	unsigned long i, vec_size;
+	unsigned long i, vec_size, vi_vec_offset;
 	phys_addr_t ebase_pa;
 
 	check_wait();
 
+	if (cpu_has_veic || cpu_has_vint) {
+		switch (current_cpu_type()) {
+		case CPU_BMIPS3300:
+		case CPU_BMIPS4380:
+			vi_vec_offset = 0x400;
+			break;
+		case CPU_BMIPS5000:
+			vi_vec_offset = 0x1000;
+			break;
+		default:
+			vi_vec_offset = 0x200;
+			break;
+		}
+		vec_size = vi_vec_offset + VECTORSPACING*64;
+	} else {
+		vec_size = 0x400;
+	}
+
 	if (!cpu_has_mips_r2_r6) {
 		ebase = CAC_BASE;
-		vec_size = 0x400;
 	} else {
-		if (cpu_has_veic || cpu_has_vint)
-			vec_size = 0x200 + VECTORSPACING*64;
-		else
-			vec_size = PAGE_SIZE;
-
+		vec_size = max(vec_size, PAGE_SIZE);
 		ebase_pa = memblock_phys_alloc(vec_size, 1 << fls(vec_size));
 		if (!ebase_pa)
 			panic("%s: Failed to allocate %lu bytes align=0x%x\n",
@@ -2450,6 +2463,7 @@ void __init trap_init(void)
 	 * Initialise interrupt handlers
 	 */
 	if (cpu_has_veic || cpu_has_vint) {
+		vi_vecbase = ebase + vi_vec_offset;
 		int nvec = cpu_has_veic ? 64 : 8;
 		for (i = 0; i < nvec; i++)
 			set_vi_handler(i, NULL);
-- 
2.34.1

