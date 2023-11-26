Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2DB7F9206
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 10:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjKZJnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 04:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZJnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 04:43:20 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC4D85;
        Sun, 26 Nov 2023 01:43:26 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54acdd65c88so2922151a12.2;
        Sun, 26 Nov 2023 01:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700991805; x=1701596605; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4Wr5w0BU6Nxj+T7K1dCzyqq4zRAETI3BGm2U/8N1jKw=;
        b=GloAkL1vILeWPMPYv5IfoBLRW5T6qpsNmlMJxSqaDshN1nJnzTGvd63eP1KwdSXhJq
         lIMwKaaE7nrslxXDlJAXlJdesjtfGyrakTr/yiYiZCj1ksGwmi65jW24uV+BIr02u+N3
         4SE5JAPH+JBo4+/Ruy0E8rCRa512QEIB9XlaudT3NCbPkrF0qXvhPdo2BgY/sPXD4x+L
         +jU1eimt60KAHs2lK3Q1nS3prmGIiVVfpLs/zDNyS1QcJD8zGvcPNTmrbBMK1w7cvJLN
         6xRZW62iBsBBMrJJlqkVK7Z76foTTL+hb5CEfkMTxwxCBGODr54Kp/tsanvsH/D/uzhz
         X2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700991805; x=1701596605;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Wr5w0BU6Nxj+T7K1dCzyqq4zRAETI3BGm2U/8N1jKw=;
        b=AQ6pRV+ZO4Q/66oW3G/llfObne4Gjb9o9OQeUtfUxKpPHoI8SsfhuR740Fl3XyE83l
         92Mb/CSOo/nsVu0k8WCMB76s1bsYS+MknyBolGp/BH6/M1XU2ElVwTjpbcId/i2rrMCC
         VdgGxwNPAP3C/ZE1Nr5Or67vQEcinsAwlL1DVJlCa4vAd+jP3POWZw3DMs6bj7iVKqpR
         byXa8My1gg2yA+EekfBW1eG4kdo2r6lw65h6DYNwJDVMrwE9/wZ5Ux3gAQa3q2Jk80Gg
         H6SlbC0o/6QTQrRYpBvPQAPkIa0SGicr7f8ptG8NzIRq6awM4dv27hn0GPUn9fSPngDb
         SfDg==
X-Gm-Message-State: AOJu0Yzf6CRMjblNzK1G6v2SnhopovdF6d2KdTtb/S9yXK4mgkGZBzou
        fmPG7XZZc8Ge73DHBVUx9h4=
X-Google-Smtp-Source: AGHT+IEHl1D2BVkv/ZgdOZvn1cSJozLIyR+UjGFxMwvhHViijRmBOt1NAFH80yTdSlDCtwziIeYNgg==
X-Received: by 2002:a50:cc95:0:b0:54a:8fa5:807f with SMTP id q21-20020a50cc95000000b0054a8fa5807fmr6535751edi.34.1700991804876;
        Sun, 26 Nov 2023 01:43:24 -0800 (PST)
Received: from gmail.com (1F2EF15C.nat.pool.telekom.hu. [31.46.241.92])
        by smtp.gmail.com with ESMTPSA id s29-20020a50ab1d000000b0054b2393312dsm1697388edc.6.2023.11.26.01.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 01:43:23 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 26 Nov 2023 10:43:21 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf events fix
Message-ID: <ZWMTOVr/81MoNEEH@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-11-26

   # HEAD: e8df9d9f4209c04161321d8c12640ae560f65939 perf/x86/intel: Correct incorrect 'or' operation for PMU capabilities

Fix a bug in the Intel hybrid CPUs hardware-capabilities enumeration
code resulting in non-working events on those platforms.

 Thanks,

	Ingo

------------------>
Dapeng Mi (1):
      perf/x86/intel: Correct incorrect 'or' operation for PMU capabilities


 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a08f794a0e79..ce1c777227b4 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4660,7 +4660,7 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
 	if (pmu->intel_cap.pebs_output_pt_available)
 		pmu->pmu.capabilities |= PERF_PMU_CAP_AUX_OUTPUT;
 	else
-		pmu->pmu.capabilities |= ~PERF_PMU_CAP_AUX_OUTPUT;
+		pmu->pmu.capabilities &= ~PERF_PMU_CAP_AUX_OUTPUT;
 
 	intel_pmu_check_event_constraints(pmu->event_constraints,
 					  pmu->num_counters,
