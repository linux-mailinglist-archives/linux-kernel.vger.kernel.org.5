Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D917B4656
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbjJAIfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbjJAIft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:35:49 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49951A9;
        Sun,  1 Oct 2023 01:35:47 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9b27bc8b65eso1515540966b.0;
        Sun, 01 Oct 2023 01:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696149346; x=1696754146; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0L/mHBlIgGc4satRCNpr7UON8xxJCcVUo/QQgDPnABw=;
        b=TnCOsYqwwG3uBBt+T9SInnULUbsyJeXF88tiOCdzNA8QQmkYKY8Oq6X8fj1LA8xaR8
         Pt8eZyFrQd6Y/vwUtYJ6hKYDyyc0TW3INHk4v8wvZdELhv18MxiviWXUjsxpB6jOQvn9
         IWBUiAUY/+n7t79ptgAJSVX/lvMnCTCR7X76a2FGO3bxLeuq59H2q8BJclhx1yhIZV6Z
         MXkEdKsiZyP8yHHOnZ7vA0y9m5jnhB/3OLU+NvBBUIKQeOpAFFVcSmNbrWkTy1wLUTxQ
         TVDDU9pT0EOLvQhuPKaRAH3mtv1+0gxVOxkHLu/ozwCjbwqnWMwI4svBJsBbGHlVh3dy
         HwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696149346; x=1696754146;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0L/mHBlIgGc4satRCNpr7UON8xxJCcVUo/QQgDPnABw=;
        b=SNempHmMhfcwi3xD3tGywKBKftZbe076jpa7HdjGfx973KNFZheQDo9zZhCB2dVTTg
         mLH/wtRcAAiwTNCkk5T5bUMxNofYkQSA6yNjEEK1tm5gXWL2N6tv57radIrf5HOuj+Da
         cFe+EShihg/5QyY8+1JeUMMkLZO+7N6B+1Ijh+Vffv4m8Wo+rna+GIvb6rOiDpqeiXQV
         WrxUOL2T8ppA89A3bfgQPQZoByK9I2UsoivFdngM9Xw0+dDbBzRR3oOypCOFuSv8UOfC
         qjWOUumr1Q7A2rvPE/fK2VupbHoyw2BhEM8SBCGEyMcnSlybaLQpItKv2LTtMQmz9UaK
         7S7w==
X-Gm-Message-State: AOJu0YzhJVnKQDpyGMprzalbMBTksLRp65dQZOKZVd4Os8nvALkFbXQg
        SGdHZ0bjfLYDtzv3t6MxhEo=
X-Google-Smtp-Source: AGHT+IE3dD9qG4fwRxqaxw2CkMokYSazdpGU7egf/gKbwRO51ZOgC5oxWtzf3QMy4GrT5KQVU7m0Nw==
X-Received: by 2002:a17:906:73dc:b0:9ae:696c:2c47 with SMTP id n28-20020a17090673dc00b009ae696c2c47mr8343992ejl.28.1696149345399;
        Sun, 01 Oct 2023 01:35:45 -0700 (PDT)
Received: from gmail.com (84-236-113-123.pool.digikabel.hu. [84.236.113.123])
        by smtp.gmail.com with ESMTPSA id z15-20020a170906944f00b00993928e4d1bsm15053657ejx.24.2023.10.01.01.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 01:35:44 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 1 Oct 2023 10:35:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf events fixes
Message-ID: <ZRkvXkyEXYfoAPiA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the latest perf/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-10-01

   # HEAD: 599522d9d2e19d6240e4312577f1c5f3ffca22f6 perf/x86/amd: Do not WARN() on every IRQ

Misc fixes: work around an AMD microcode bug on certain models,
and fix kexec kernel PMI handlers on AMD systems that get loaded
on older kernels that have an unexpected register state.

 Thanks,

	Ingo

------------------>
Breno Leitao (1):
      perf/x86/amd: Do not WARN() on every IRQ

Sandipan Das (1):
      perf/x86/amd/core: Fix overflow reset on hotplug


 arch/x86/events/amd/core.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index abadd5f23425..e24976593a29 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -534,8 +534,12 @@ static void amd_pmu_cpu_reset(int cpu)
 	/* Clear enable bits i.e. PerfCntrGlobalCtl.PerfCntrEn */
 	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
 
-	/* Clear overflow bits i.e. PerfCntrGLobalStatus.PerfCntrOvfl */
-	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, amd_pmu_global_cntr_mask);
+	/*
+	 * Clear freeze and overflow bits i.e. PerfCntrGLobalStatus.LbrFreeze
+	 * and PerfCntrGLobalStatus.PerfCntrOvfl
+	 */
+	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
+	       GLOBAL_STATUS_LBRS_FROZEN | amd_pmu_global_cntr_mask);
 }
 
 static int amd_pmu_cpu_prepare(int cpu)
@@ -570,6 +574,7 @@ static void amd_pmu_cpu_starting(int cpu)
 	int i, nb_id;
 
 	cpuc->perf_ctr_virt_mask = AMD64_EVENTSEL_HOSTONLY;
+	amd_pmu_cpu_reset(cpu);
 
 	if (!x86_pmu.amd_nb_constraints)
 		return;
@@ -591,8 +596,6 @@ static void amd_pmu_cpu_starting(int cpu)
 
 	cpuc->amd_nb->nb_id = nb_id;
 	cpuc->amd_nb->refcnt++;
-
-	amd_pmu_cpu_reset(cpu);
 }
 
 static void amd_pmu_cpu_dead(int cpu)
@@ -601,6 +604,7 @@ static void amd_pmu_cpu_dead(int cpu)
 
 	kfree(cpuhw->lbr_sel);
 	cpuhw->lbr_sel = NULL;
+	amd_pmu_cpu_reset(cpu);
 
 	if (!x86_pmu.amd_nb_constraints)
 		return;
@@ -613,8 +617,6 @@ static void amd_pmu_cpu_dead(int cpu)
 
 		cpuhw->amd_nb = NULL;
 	}
-
-	amd_pmu_cpu_reset(cpu);
 }
 
 static inline void amd_pmu_set_global_ctl(u64 ctl)
@@ -884,7 +886,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 	struct hw_perf_event *hwc;
 	struct perf_event *event;
 	int handled = 0, idx;
-	u64 status, mask;
+	u64 reserved, status, mask;
 	bool pmu_enabled;
 
 	/*
@@ -909,6 +911,14 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 		status &= ~GLOBAL_STATUS_LBRS_FROZEN;
 	}
 
+	reserved = status & ~amd_pmu_global_cntr_mask;
+	if (reserved)
+		pr_warn_once("Reserved PerfCntrGlobalStatus bits are set (0x%llx), please consider updating microcode\n",
+			     reserved);
+
+	/* Clear any reserved bits set by buggy microcode */
+	status &= amd_pmu_global_cntr_mask;
+
 	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
 		if (!test_bit(idx, cpuc->active_mask))
 			continue;
