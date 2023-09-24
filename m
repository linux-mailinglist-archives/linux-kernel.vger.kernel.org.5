Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E597AC743
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 11:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjIXJHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 05:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjIXJHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 05:07:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E0B103;
        Sun, 24 Sep 2023 02:07:33 -0700 (PDT)
Date:   Sun, 24 Sep 2023 09:07:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695546452;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sbi+5DaEKaix45/OZbTt47FeIP1NUyw2jejGLC9lC/M=;
        b=G6rDXP+b9BR2w3a0RgxKoRG6cW8DpZVSTlNSVHCbZwgnYfgzopNMm1VcqPzHZJaMmfq2lK
        56jMEvjN5FWboCyWz/4X5Gy78EStZm9PRqcClKrtLSS4Igm8no7RqkFfEEF69xuVHH/tkt
        OB6WgOJdPbYQYCVQVkUyBi/t0tvtlhfJ7E4hU/2vyTTrJvh8wJOlRCddGlIUiP67weCwi2
        u8BSBX2nl//MwoBvYFd1bP0zkKs7UI0RToIA1YFjwOJtt37Gvkq+nUhC8vzv3L0cDsA+7J
        PDroLcwwVwDdkhvNCCykxKGxBomkUg8RGKqnzi4jh3noByAUBRY6krRHq8Al7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695546452;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sbi+5DaEKaix45/OZbTt47FeIP1NUyw2jejGLC9lC/M=;
        b=hlYwyhdkDKDPa/7fWuHG5SblaMIhn3THKkG3Ophua3VDGJUhOHUp939kt9r4ht4MByIBS6
        mIPQchtPRB0u66Cw==
From:   "tip-bot2 for Christophe JAILLET" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/kgdb: Fix a kerneldoc warning when build with W=1
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Caad659537c1d4ebd86912a6f0be458676c8e69af=2E16954?=
 =?utf-8?q?01178=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
References: =?utf-8?q?=3Caad659537c1d4ebd86912a6f0be458676c8e69af=2E169540?=
 =?utf-8?q?1178=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
MIME-Version: 1.0
Message-ID: <169554645129.27769.1434866698417999091.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     94adf495e733d3b7e8b826c452ba12e995eef7c7
Gitweb:        https://git.kernel.org/tip/94adf495e733d3b7e8b826c452ba12e995eef7c7
Author:        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
AuthorDate:    Fri, 22 Sep 2023 18:46:49 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 24 Sep 2023 11:00:13 +02:00

x86/kgdb: Fix a kerneldoc warning when build with W=1

When compiled with W=1, the following warning is generated:

  arch/x86/kernel/kgdb.c:698: warning: Cannot understand  *
   on line 698 - I thought it was a doc line

Remove the corresponding empty comment line to fix the warning.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/r/aad659537c1d4ebd86912a6f0be458676c8e69af.1695401178.git.christophe.jaillet@wanadoo.fr
---
 arch/x86/kernel/kgdb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 3a43a2d..9c9faa1 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -695,7 +695,6 @@ void kgdb_arch_exit(void)
 }
 
 /**
- *
  *	kgdb_skipexception - Bail out of KGDB when we've been triggered.
  *	@exception: Exception vector number
  *	@regs: Current &struct pt_regs.
