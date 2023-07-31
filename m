Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37497692F5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjGaKTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjGaKTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:19:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61058B3;
        Mon, 31 Jul 2023 03:19:32 -0700 (PDT)
Date:   Mon, 31 Jul 2023 10:19:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690798771;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EKeb39vgzdhyS40xyxQQrpUF2A3Pl/1GUNNbiF2XXIg=;
        b=OQOJ7F6yn2nsUpWTKO7Xvx/agcOW2rfUa29HtBq8nFEgILlYHlFviBxolEt8DOX2N2ryz1
        jvAv5NQRQQm9jywsxim6fzdRfyDXM2TcgevWa8NZt54PZt3MCqa2O3ygGug67z8H46UzMi
        LZQ7JfLNv1BxV7wEtZBojAXbW1JyPeUUVnae+w5G2oj8+BTGta9xYB79lYYfbT3f3W3VV2
        zCqH+ye+9FdH5OfcIOWMMcdd4qGhAFqcjLsinXkxCU3jO+mzpeKQpnqImDFBNS4KtUZB0S
        NApWt+mtJbWh4qaftMjc3be54fWLCizWGfauc+h7eLPRuAGA7vQ70HjN0HJDaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690798771;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EKeb39vgzdhyS40xyxQQrpUF2A3Pl/1GUNNbiF2XXIg=;
        b=E0/1bPetgg8MQye830EUhwK0PGg9K/H/JzTqd0Cg8X+0UPnYa8xMIwS+H+5OBUAVaBa/93
        EkMYSiEHo46z2yDQ==
From:   "tip-bot2 for James Clark" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Remove unused PERF_PMU_CAP_HETEROGENEOUS_CPUS
 capability
Cc:     James Clark <james.clark@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ian Rogers <irogers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230724134500.970496-5-james.clark@arm.com>
References: <20230724134500.970496-5-james.clark@arm.com>
MIME-Version: 1.0
Message-ID: <169079877042.28540.9012324637381086320.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0cb52ad7bbb27bc6700412b055c743d5ae501b29
Gitweb:        https://git.kernel.org/tip/0cb52ad7bbb27bc6700412b055c743d5ae501b29
Author:        James Clark <james.clark@arm.com>
AuthorDate:    Mon, 24 Jul 2023 14:44:59 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Jul 2023 12:28:47 +02:00

perf: Remove unused PERF_PMU_CAP_HETEROGENEOUS_CPUS capability

Since commit bd2756811766 ("perf: Rewrite core context handling") the
relationship between perf_event_context and PMUs has changed so that
the error scenario that PERF_PMU_CAP_HETEROGENEOUS_CPUS originally
silenced no longer exists.

Remove the capability to avoid confusion that it actually influences
any perf core behavior and shift down the following capability bits to
fill in the unused space. This change should be a no-op.

Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Acked-by: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/r/20230724134500.970496-5-james.clark@arm.com
---
 include/linux/perf_event.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index dd92b4f..9b1cf3c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -288,10 +288,9 @@ struct perf_event_pmu_context;
 #define PERF_PMU_CAP_EXTENDED_REGS		0x0008
 #define PERF_PMU_CAP_EXCLUSIVE			0x0010
 #define PERF_PMU_CAP_ITRACE			0x0020
-#define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x0040
-#define PERF_PMU_CAP_NO_EXCLUDE			0x0080
-#define PERF_PMU_CAP_AUX_OUTPUT			0x0100
-#define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0200
+#define PERF_PMU_CAP_NO_EXCLUDE			0x0040
+#define PERF_PMU_CAP_AUX_OUTPUT			0x0080
+#define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
 
 struct perf_output_handle;
 
