Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FC07692F8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjGaKTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbjGaKTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:19:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4414E3;
        Mon, 31 Jul 2023 03:19:34 -0700 (PDT)
Date:   Mon, 31 Jul 2023 10:19:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690798773;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QtZ7vrOzleA1jH5xqUUEqT7/hR/D37tRRzsPaFZuHjo=;
        b=xHNh8lRAt9vtZ+peq0ZMwiq2DMNvJk/lWe9gHJtPpU/pOFiqKoucB2hENoZltznvplcNyK
        jBm+fPawxP88+FHKU1+9d9g0RtLl1GtJAkZx1NltbWwGs7NZk7y+2JQ/eAUeaCHXcOdE7G
        cMx2QxHSpHxuNzyk1DqqHKBMB2C/4blLoWPXXMPm3OLLgX9J/TTCfllP2uhwDeASdGxjy2
        2eHaI6TQW2TkYJxWYsnzLOsJzv+lQDTdzVMKkgDoedoSgCecWFM9fgtnzojRRAi4HXg3L8
        A2vBl27BnLaGorabmzbTXz7EwtRVNTGQQMIBxKayoECBk3bbCOvCnd7H3vGfjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690798773;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QtZ7vrOzleA1jH5xqUUEqT7/hR/D37tRRzsPaFZuHjo=;
        b=OWqdyLGEEIguOyrZnNTYsnUT+VsAH82KIpuYRh11RNNRlyZCRp4D2DrOs6PIwDhugT+Eo+
        Gy3dTPDQvLWuT6DQ==
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/mem: Add PERF_MEM_LVLNUM_NA to PERF_MEM_NA
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230725150206.184-3-ravi.bangoria@amd.com>
References: <20230725150206.184-3-ravi.bangoria@amd.com>
MIME-Version: 1.0
Message-ID: <169079877280.28540.13719757807883841280.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     5c6e623f1b8ebca39eeefba4b18d574eb5acf0bd
Gitweb:        https://git.kernel.org/tip/5c6e623f1b8ebca39eeefba4b18d574eb5acf0bd
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Tue, 25 Jul 2023 20:32:05 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Jul 2023 12:28:45 +02:00

perf/mem: Add PERF_MEM_LVLNUM_NA to PERF_MEM_NA

Add PERF_MEM_LVLNUM_NA wherever PERF_MEM_NA is used to set default values.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230725150206.184-3-ravi.bangoria@amd.com
---
 include/linux/perf_event.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2166a69..dd92b4f 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1194,7 +1194,8 @@ struct perf_sample_data {
 		    PERF_MEM_S(LVL, NA)   |\
 		    PERF_MEM_S(SNOOP, NA) |\
 		    PERF_MEM_S(LOCK, NA)  |\
-		    PERF_MEM_S(TLB, NA))
+		    PERF_MEM_S(TLB, NA)   |\
+		    PERF_MEM_S(LVLNUM, NA))
 
 static inline void perf_sample_data_init(struct perf_sample_data *data,
 					 u64 addr, u64 period)
