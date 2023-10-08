Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE3A7BCDE0
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 12:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344663AbjJHKt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 06:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344641AbjJHKtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 06:49:49 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FDFC5
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 03:49:48 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-57b67c84999so2346700eaf.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 03:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696762188; x=1697366988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEfuhLWgVKO0bRAsmrd/J/SVgiZ3Q4uSTQ7SYs2eDEs=;
        b=h0lWoce2Kyc40d/jxonGnnHcnDt+3vzcNKg8n+wDV/ehZGBrb8SLcDF+5/Vhv2BXxH
         wv3YBb04RQKAt5vgBLUwVDH+TxxN+HTsC6G691FpYrE2nRnASFzoR3a5uSZmqLtdVpuX
         /VdqSQzhkiWoNVaAQzEz6r3XQqRsARyaYAlJlMj7Hot9Zf/aGc5ZbLnteGs324IaRXKn
         Oa2fNapCaSoqnRYlx5tKSqKsM1phcO2EbwiYTb4Qs40bubNQ2q7SPmvcsVYidLXKgAwR
         V9lTAPGlJON91z8hc39ITXwdBLL9MQawsaWbNLlTF6anbdE3DNsYlHuV48166PrEXfxH
         PbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696762188; x=1697366988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEfuhLWgVKO0bRAsmrd/J/SVgiZ3Q4uSTQ7SYs2eDEs=;
        b=LH1QxbSoV2y+2isbxEni6Y+iAsRrKXlrI4feRfJMkE+xoKaTWkAhUBT+GPaXkJ20eJ
         HKjjRAgWZ6KDu9I14mWR/WfAM6wrSbwI2OsyKBd0poV6pik1X41ko+okQX8SqaWAZQ/Q
         HY7YJQqtmh8VF/5JFwm69vJaM9+G7RrrHW+I8vFXGeO4vF1MceCV8DhbrnG8P7104pWf
         J5CVQf+dB3RmBhrPU/6jV91lwoEEtRMOmZGwyVrKdDaDRl3DQ7xUcJbTAWVyOfUb8lye
         9M/A6R3oY9TyQOVTljOFXi0KkflzpsMC6/Gp/WRqXYz2LH2YMAumIs+dKkunB+qZFAtC
         mZnA==
X-Gm-Message-State: AOJu0Yxd2/oIj49V6WyJ2UqfgRvuyHd7zYIsMrUfSzWpBLA3Z25mxgjI
        uJKAlHLPfLvoJ9VVFEIkvqNyLmb6icFgwGBh
X-Google-Smtp-Source: AGHT+IFoRp3hKwJQ4khQ3J5GSFgwZxsmttN9MqE/QhdNBpKGq3qXs5OFCPZUknb210kzO9qEf+fMhA==
X-Received: by 2002:a05:6358:441d:b0:143:8574:4311 with SMTP id z29-20020a056358441d00b0014385744311mr13573769rwc.12.1696762187761;
        Sun, 08 Oct 2023 03:49:47 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id z11-20020a17090acb0b00b002630c9d78aasm6311517pjt.5.2023.10.08.03.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 03:49:47 -0700 (PDT)
From:   "brookxu.cn" <brookxu.cn@gmail.com>
To:     bsingharora@gmail.com, juri.lelli@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] delayacct: remove delayacct_on to simplify the code
Date:   Sun,  8 Oct 2023 18:49:38 +0800
Message-Id: <399a361ec136d972991fe84e9aad00e3c302f37a.1696761522.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1696761522.git.chunguang.xu@shopee.com>
References: <cover.1696761522.git.chunguang.xu@shopee.com>
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

From: Chunguang Xu <chunguang.xu@shopee.com>

Seems delayacct_on can be removed, so try to do it
to simplify the code.

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
---
 include/linux/delayacct.h |  1 -
 kernel/delayacct.c        | 14 ++++----------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index 2f1dc6688a2f..caa7564a1a52 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -64,7 +64,6 @@ struct task_delay_info {
 
 #ifdef CONFIG_TASK_DELAY_ACCT
 DECLARE_STATIC_KEY_FALSE(delayacct_key);
-extern int delayacct_on;	/* Delay accounting turned on/off */
 extern void delayacct_init(void);
 
 extern void __delayacct_tsk_init(struct task_struct *);
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 1a6b1d3e80af..397b36adb634 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -15,22 +15,18 @@
 #include <linux/module.h>
 
 DEFINE_STATIC_KEY_FALSE(delayacct_key);
-int delayacct_on __read_mostly;	/* Delay accounting turned on/off */
 
 static void set_delayacct(bool enabled)
 {
-	if (enabled) {
+	if (enabled)
 		static_branch_enable(&delayacct_key);
-		delayacct_on = 1;
-	} else {
-		delayacct_on = 0;
+	else
 		static_branch_disable(&delayacct_key);
-	}
 }
 
 static int __init delayacct_setup_enable(char *str)
 {
-	delayacct_on = 1;
+	set_delayacct(true);
 	return 1;
 }
 __setup("delayacct", delayacct_setup_enable);
@@ -38,16 +34,14 @@ __setup("delayacct", delayacct_setup_enable);
 void delayacct_init(void)
 {
 	delayacct_tsk_init(&init_task);
-	set_delayacct(delayacct_on);
 }
 
 #ifdef CONFIG_PROC_SYSCTL
 static int sysctl_delayacct(struct ctl_table *table, int write, void *buffer,
 		     size_t *lenp, loff_t *ppos)
 {
-	int state = delayacct_on;
 	struct ctl_table t;
-	int err;
+	int err, state;
 
 	if (write && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
-- 
2.25.1

