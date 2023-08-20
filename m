Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477DF78202D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 23:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjHTVZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 17:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjHTVZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 17:25:01 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354AC6E80
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 13:46:48 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68a42d06d02so157046b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 13:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1692564407; x=1693169207;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F/dNaHih8MkgoWiOx0VqHocnC3e39GM3J8kg6CYTzJg=;
        b=Qhz3ThtSkvQRjETMiGy0JmYLdJThilwsh5nCp/Y0fnrEposm2v7o2NUzaoPwOfF71H
         iHqeckU3KO8AiXhcHg+lRsPFvVoevzyc6KefcWiacvsAOhZJXUNhA3D4oFPihP8l5h1A
         r8lVdf0jfw9T2H/3mo5YkwpGnWs0RtkPUjtCdr4cvYh95H277RoNThOaVux3orkkNbls
         ApDadYbt+o4xsYQ+Z6YvqIYRUnBRX2XmzBC8h1Qo7vvlK5NcgUZ/4qv+AXxuf5mCsOkl
         rkZ8vhaWAQRw20mJcV6hODZ2+xZhFJ7EWYPh5pDefOBDkXCS6G4PWtkIVqhYXUBlDqQp
         xh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692564407; x=1693169207;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F/dNaHih8MkgoWiOx0VqHocnC3e39GM3J8kg6CYTzJg=;
        b=Z930O6e2m5SYXgD5nkErobxEkAp+/l6uWpQg7xCYNbeOrlqfIiQ95T3q9/FzeKI/JG
         /D0jp2rDIveHZ4dj5VcPg3aCYV+pPGBST3kVlaA0no6B/XzXQNXNPmjnYdAofEHz3UKR
         jDpPFvRmIV+D2sY5oTMwe4/d6ygxqSsnltgpbTqUwqxYpXOFtGaDeFGOqlNsZXYj5pUx
         fJJouGrz1gqCDQAZOvk3C0dtlumGIiTmMx8SpDqRK/sCSR1yAEstToYathLS8YuR7Bo6
         D+Vl2fICNZSsYX6KwgneJwI2vJR60evQkOykAtp/XO5GbwFk4tHS53yk3KQbKcIkq0hy
         t1+g==
X-Gm-Message-State: AOJu0YyTOH7u8dVCgDlynAfitIOL3WXUHv+kbiR7m0p1aoiDvXNfzBvS
        agh8bES4DVlRRjx1WUm3GXqeHQ==
X-Google-Smtp-Source: AGHT+IGQ+283uYuaZlga3wQTGVnIxzG56X00KW19bHPrivQYhfqxag5hGH5Q3xF0SznMlwCYq3lSfg==
X-Received: by 2002:a05:6a20:72a0:b0:140:d536:d428 with SMTP id o32-20020a056a2072a000b00140d536d428mr3911233pzk.51.1692564407567;
        Sun, 20 Aug 2023 13:46:47 -0700 (PDT)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id b19-20020a170902ed1300b001b89a6164desm5542435pld.118.2023.08.20.13.46.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Aug 2023 13:46:47 -0700 (PDT)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Len Brown'" <lenb@kernel.org>
Cc:     "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        <yang.jie@linux.intel.com>, "Doug Smythies" <dsmythies@telus.net>
Subject: [PATCH v2] cpufreq: intel_pstate: set stale CPU frequency to minimum
Date:   Sun, 20 Aug 2023 13:46:49 -0700
Message-ID: <001d01d9d3a7$71736f50$545a4df0$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdnTpujV5ZIoNhBLSi64CDMcJeQ7VQ==
Content-Language: en-ca
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intel_pstate CPU frequency scaling driver does not
use policy->cur and it is 0.
When the CPU frequency is outdated arch_freq_get_on_cpu()
will default to the nominal clock frequency when its call to
cpufreq_quick_getpolicy_cur returns the never updated 0.
Thus, the listed frequency might be outside of currently
set limits. Some users are complaining about the high
reported frequency, albeit stale, when their system is
idle and/or it is above the reduced maximum they have set.

This patch will maintain policy_cur for the intel_pstate
driver at the current minimum CPU frequency.

Reported-by: Yang Jie <yang.jie@linux.intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217597
Signed-off-by: Doug Smythies <dsmythies@telus.net>
---

v1 -> v2:
   * v1 was a completely different approach, programming around
     the issue rather than fixing it at the source.
     reference:
     https://patchwork.kernel.org/project/linux-pm/patch/006901d9be8c$f4439930$dccacb90$@telus.net/
   * v2 does not fix an issue with the intel_cpufreq CPU scaling
     driver (A.K.A. the intel_pstate driver in passive mode) and
     the schedutil CPU frequency scaling governor when HWP is enabled
     where limit changes are not reflected in the stale listed frequencies.
     A fix for that will be some future patch.

---
 drivers/cpufreq/intel_pstate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 8ca2bce4341a..08284dee583a 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2609,6 +2609,11 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
                        intel_pstate_clear_update_util_hook(policy->cpu);
                intel_pstate_hwp_set(policy->cpu);
        }
+       /* policy current is never updated with the intel_pstate driver
+        * but it is used as a stale frequency value. So, keep it within
+        * limits.
+        */
+       policy->cur = policy->min;

        mutex_unlock(&intel_pstate_limits_lock);

--
2.25.1


