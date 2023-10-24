Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70E07D5A83
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344142AbjJXSac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343920AbjJXSaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:30:30 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F54DA2;
        Tue, 24 Oct 2023 11:30:27 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4083cd39188so37585715e9.2;
        Tue, 24 Oct 2023 11:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698172226; x=1698777026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4S6ZmkT9NoJ2QB74d4iDZQ/Asjhb+835EobMM6vz70A=;
        b=QPCBdl11SlbpzpmmftlPSL69VU0cmNloW7kSM3T6jFrpYmEp9vnu2ptME2aLMZXrCz
         AK5aemFJnK8G/OQ5elxjpmkC5kZnfP9+vnWkyewHtZtZJmuiGYqhL+KjQVOQbo/9ISjt
         QKw20JI2p9pP/hXFm/xiFV8giKUKWDAzVSQmmz+z9daGGddzEdl3+Je1IWojYB7901/L
         4y5ReO78vtKDGsIw1ZLnzHveWgq9NLFfcsyQYoyxgoGvtJutPaN2H9DDUFgp4jsWRKQC
         FsOGiwAl3l3fTuR41NZp4tj1pdCteswdugX5vSfIcGRyrWeidR3OtkanBb0LylBEM0MN
         AFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698172226; x=1698777026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4S6ZmkT9NoJ2QB74d4iDZQ/Asjhb+835EobMM6vz70A=;
        b=uF45ZYCEOQdBy40y8oCtFnIKS8mzBS8429m4B+AR6I58c06MnfELRVnj/jF6U5+hwE
         JOmyhA9zMB7DcGZbR1q6r3gfETT3H1/zcTDnZmBLbNNv31ZmI61S1b4jG71M2r1bLePf
         TUdJqwUHcBbaPlZHz/ikWjwp3+TUlUvAIfyNGcAdXh46Ode0PGEpyjm7rpAGuXzreO12
         7RiM4WVFkQOe6liBWQAoN45+cEqJpIXKCmJgLujOfE366Elme5vsO/8lUF87vnr05G9O
         kiFPKlSiTblSQmIV8pAmqJVYAmjweWw6nr1Qb5TIIJrMutjhuRly6vilnI3Enzypqq1j
         z4VQ==
X-Gm-Message-State: AOJu0Yw0Cz5fNOi3+Be8JjeHFcuz6BnKQkoFq0JMiwdhLayvAQPmcI/k
        LLmBTvibyrDY4GRA+fsUZR8=
X-Google-Smtp-Source: AGHT+IEMMi72Bl8CnZl20LHGwMFkkwwKrdy3vQNdcOgeNrsDv6kfW+l/YbQgi1/opRjM4AdinTS2cw==
X-Received: by 2002:a05:600c:3585:b0:406:177e:5de8 with SMTP id p5-20020a05600c358500b00406177e5de8mr10655780wmq.35.1698172225667;
        Tue, 24 Oct 2023 11:30:25 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id l22-20020a05600c4f1600b003fef5e76f2csm1150398wmq.0.2023.10.24.11.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 11:30:25 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: [PATCH 1/3] cpufreq: fix broken buffer overflow detection in trans_stats
Date:   Tue, 24 Oct 2023 20:30:14 +0200
Message-Id: <20231024183016.14648-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3c0897c180c6 ("cpufreq: Use scnprintf() for avoiding potential
buffer overflow") switched from snprintf to the more secure scnprintf
but never updated the exit condition for PAGE_SIZE.

As the commit say and as scnprintf document, what scnprintf returns what
is actually written not counting the '\0' end char. This results in the
case of len exceeding the size, len set to PAGE_SIZE - 1, as it can be
written at max PAGESIZE - 1 (as '\0' is not counted)

Because of len is never set to PAGE_SIZE, the function never break early,
never print the warning and never return -EFBIG.

Fix this by fixing the condition to PAGE_SIZE -1 to correctly trigger
the error condition.

Cc: stable@vger.kernel.org
Fixes: 3c0897c180c6 ("cpufreq: Use scnprintf() for avoiding potential buffer overflow")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/cpufreq/cpufreq_stats.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index a33df3c66c88..40a9ff18da06 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -131,23 +131,23 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 	len += sysfs_emit_at(buf, len, "   From  :    To\n");
 	len += sysfs_emit_at(buf, len, "         : ");
 	for (i = 0; i < stats->state_num; i++) {
-		if (len >= PAGE_SIZE)
+		if (len >= PAGE_SIZE - 1)
 			break;
 		len += sysfs_emit_at(buf, len, "%9u ", stats->freq_table[i]);
 	}
-	if (len >= PAGE_SIZE)
-		return PAGE_SIZE;
+	if (len >= PAGE_SIZE - 1)
+		return PAGE_SIZE - 1;
 
 	len += sysfs_emit_at(buf, len, "\n");
 
 	for (i = 0; i < stats->state_num; i++) {
-		if (len >= PAGE_SIZE)
+		if (len >= PAGE_SIZE - 1)
 			break;
 
 		len += sysfs_emit_at(buf, len, "%9u: ", stats->freq_table[i]);
 
 		for (j = 0; j < stats->state_num; j++) {
-			if (len >= PAGE_SIZE)
+			if (len >= PAGE_SIZE - 1)
 				break;
 
 			if (pending)
@@ -157,12 +157,12 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 
 			len += sysfs_emit_at(buf, len, "%9u ", count);
 		}
-		if (len >= PAGE_SIZE)
+		if (len >= PAGE_SIZE - 1)
 			break;
 		len += sysfs_emit_at(buf, len, "\n");
 	}
 
-	if (len >= PAGE_SIZE) {
+	if (len >= PAGE_SIZE - 1) {
 		pr_warn_once("cpufreq transition table exceeds PAGE_SIZE. Disabling\n");
 		return -EFBIG;
 	}
-- 
2.40.1

