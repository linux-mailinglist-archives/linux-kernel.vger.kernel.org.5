Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DA37CA76F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjJPMBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjJPMBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:01:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8AC18F;
        Mon, 16 Oct 2023 04:54:55 -0700 (PDT)
Date:   Mon, 16 Oct 2023 11:54:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697457294;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XHVesqXaxohiYRrNpUQZ4HWFsNQ+2Xf+xlrKQBGONto=;
        b=Ye4vv+xDCsDLAD0XEjFzyD8wC015h/OLrmCi/fram6Gjf5OG0JMgBavI6zRPmWrYlk0AXY
        FJ+5Xof1ZhKK5fF/juMUbsW5Tp8bVS2ZwU/zGpdHgc6Yk7brgJShEp4ydiQ+y3PxayzSp7
        zPHAImr+QAGjMaYZl8N5p/hpdmaNPY65lZolt7/KsOBsTlOXJHlorWmAHSrPIuaEXGmfc3
        yOyWJTbY9W+FgjIlsQPb+PmR0UUpllsHRFj33OORtAlcnKynpugSgSnaAkRUrPhrNVMifr
        +oANxe0uZ1duh3+B0lsZ7PJ0u7ySj67MbN9g0R1JDtsGvb066LMqJUexsRV++g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697457294;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XHVesqXaxohiYRrNpUQZ4HWFsNQ+2Xf+xlrKQBGONto=;
        b=gtzIq0dA9GIJWeyeJqgcpcVfzSr5NB99ElCg++m0xpyFXTDacGzeskCd28TK/YpKwkrMsz
        PrDfztAWkmKI//Bw==
From:   "tip-bot2 for Hou Wenlong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/head/64: Mark 'startup_gdt[]' and
 'startup_gdt_descr' as __initdata
Cc:     Hou Wenlong <houwenlong.hwl@antgroup.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cc85903a7cfad37d14a7e5a4df9fc7119a3669fb3=2E16891?=
 =?utf-8?q?30310=2Egit=2Ehouwenlong=2Ehwl=40antgroup=2Ecom=3E?=
References: =?utf-8?q?=3Cc85903a7cfad37d14a7e5a4df9fc7119a3669fb3=2E168913?=
 =?utf-8?q?0310=2Egit=2Ehouwenlong=2Ehwl=40antgroup=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <169745729358.3135.16557655752010416228.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     dc6283009016acd5a8c6a6c073506d82bbc55529
Gitweb:        https://git.kernel.org/tip/dc6283009016acd5a8c6a6c073506d82bbc55529
Author:        Hou Wenlong <houwenlong.hwl@antgroup.com>
AuthorDate:    Wed, 12 Jul 2023 11:30:05 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 16 Oct 2023 13:38:24 +02:00

x86/head/64: Mark 'startup_gdt[]' and 'startup_gdt_descr' as __initdata

As 'startup_gdt[]' and 'startup_gdt_descr' are only used in booting,
mark them as __initdata to allow them to be freed after boot.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/c85903a7cfad37d14a7e5a4df9fc7119a3669fb3.1689130310.git.houwenlong.hwl@antgroup.com
---
 arch/x86/kernel/head64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index d6ca9c5..f41625d 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -69,7 +69,7 @@ EXPORT_SYMBOL(vmemmap_base);
 /*
  * GDT used on the boot CPU before switching to virtual addresses.
  */
-static struct desc_struct startup_gdt[GDT_ENTRIES] = {
+static struct desc_struct startup_gdt[GDT_ENTRIES] __initdata = {
 	[GDT_ENTRY_KERNEL32_CS]         = GDT_ENTRY_INIT(0xc09b, 0, 0xfffff),
 	[GDT_ENTRY_KERNEL_CS]           = GDT_ENTRY_INIT(0xa09b, 0, 0xfffff),
 	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(0xc093, 0, 0xfffff),
@@ -79,7 +79,7 @@ static struct desc_struct startup_gdt[GDT_ENTRIES] = {
  * Address needs to be set at runtime because it references the startup_gdt
  * while the kernel still uses a direct mapping.
  */
-static struct desc_ptr startup_gdt_descr = {
+static struct desc_ptr startup_gdt_descr __initdata = {
 	.size = sizeof(startup_gdt)-1,
 	.address = 0,
 };
