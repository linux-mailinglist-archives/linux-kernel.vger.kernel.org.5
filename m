Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F0D7BD8B2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345769AbjJIKd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345759AbjJIKdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:33:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D440C9C;
        Mon,  9 Oct 2023 03:33:53 -0700 (PDT)
Date:   Mon, 09 Oct 2023 10:33:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696847632;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ED3Q9EjTvFOqHf0F/fp3lKmzOsY2Fj8/fhVP6Rz/qq8=;
        b=1O76TzngN6JMYbkBMKcuu6QxC9AtzdG5Iyh43yjtaKxyYJjHhtI8vH/JIytigD+hlgVtRa
        R7tRpKBiCm0lyYPIBHxEITQsiXj/9+WylbqYSiBRIEfxnYGbqkOEAMvH3lijyhpwPQgE7b
        MSXn9Q4Zz9cp9sOQ1ciMuZpiHkSGT5REHkuXyz2+jRhg1Ko2BUPMWn36Eyq9Q0JxftY+f9
        MlIRIdGOeMmYJDyoR2cP3sebccRtlYoJe3co3J0lnPKMe1OiIjQEUiu+AMje4U6pY7gLrf
        BxHCop0u5fdr4WECYVcsKBQejpdABWONHcOmjUCq9IkFYP8n/2fofyZG1dUPhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696847632;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ED3Q9EjTvFOqHf0F/fp3lKmzOsY2Fj8/fhVP6Rz/qq8=;
        b=Zochh8pnIHQzxrmzxfltO7ruWbcxrZGQE0Mdu2vPuJ3oiLcEgDpzx30nEMb+AfQ5JfVa30
        NyV3lP+fwYK2SzDA==
From:   "tip-bot2 for Lucy Mielke" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/pt: Fix kernel-doc comments
Cc:     Lucy Mielke <lucymielke@icloud.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <ZSOjQW3e2nJR4bAo@fedora.fritz.box>
References: <ZSOjQW3e2nJR4bAo@fedora.fritz.box>
MIME-Version: 1.0
Message-ID: <169684763154.3135.4873019894270877876.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     38cd5b6a875adc877681faf8e3ad47fdbd6eceb5
Gitweb:        https://git.kernel.org/tip/38cd5b6a875adc877681faf8e3ad47fdbd6eceb5
Author:        Lucy Mielke <lucymielke@icloud.com>
AuthorDate:    Mon, 09 Oct 2023 08:54:54 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Oct 2023 12:26:22 +02:00

perf/x86/intel/pt: Fix kernel-doc comments

Some parameters or return codes were either wrong or missing,
update them.

Signed-off-by: Lucy Mielke <lucymielke@icloud.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/ZSOjQW3e2nJR4bAo@fedora.fritz.box
---
 arch/x86/events/intel/pt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 42a5579..8e2a122 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -736,6 +736,7 @@ static bool topa_table_full(struct topa *topa)
 /**
  * topa_insert_pages() - create a list of ToPA tables
  * @buf:	PT buffer being initialized.
+ * @cpu:	CPU on which to allocate.
  * @gfp:	Allocation flags.
  *
  * This initializes a list of ToPA tables with entries from
@@ -1207,8 +1208,11 @@ static void pt_buffer_fini_topa(struct pt_buffer *buf)
 /**
  * pt_buffer_init_topa() - initialize ToPA table for pt buffer
  * @buf:	PT buffer.
- * @size:	Total size of all regions within this ToPA.
+ * @cpu:	CPU on which to allocate.
+ * @nr_pages:	No. of pages to allocate.
  * @gfp:	Allocation flags.
+ *
+ * Return:	0 on success or error code.
  */
 static int pt_buffer_init_topa(struct pt_buffer *buf, int cpu,
 			       unsigned long nr_pages, gfp_t gfp)
@@ -1281,7 +1285,7 @@ out:
 
 /**
  * pt_buffer_setup_aux() - set up topa tables for a PT buffer
- * @cpu:	Cpu on which to allocate, -1 means current.
+ * @event:	Performance event
  * @pages:	Array of pointers to buffer pages passed from perf core.
  * @nr_pages:	Number of pages in the buffer.
  * @snapshot:	If this is a snapshot/overwrite counter.
