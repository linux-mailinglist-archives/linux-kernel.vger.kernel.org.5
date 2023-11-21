Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1717F52B5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 22:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344239AbjKVVhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 16:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjKVVhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 16:37:17 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFE091
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 13:37:12 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32d9d8284abso120567f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 13:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1700689031; x=1701293831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=um2YSmpP1zf78M1dUAJgNRPJiGEOfrPk5ZanDrjksBk=;
        b=hNc9Jj1cYKuDJEnh3U0q1ejM1W0F9i7J7L86jMMyKQ1RATiAhrJpXL//FX5MbiTiir
         jxGR4E/RHPUi51ExFYa8mOsThxiUxw1NQdFCeV7FeefbtXUyxqclsXcYfOjdkDLob6NI
         FwKNkbmcQJ2HJ585P+J1QHAqs+5+uCKc9VgiJBvA1YL3QZ9pxzrgo69xCMM1uVFn9O9r
         p+T8HP8eIqXyCr80FN6MJAutKp1E6AgRc38rMZyWjqGx6JgxwJgo/34qRgYMXJqy1oAi
         QduA54UPKR2Sw146fhknWx7LSxUTAFY07yB1x7JEskW9lh+dc4ZVOnLd4tFx+x/lfGRl
         Ct1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700689031; x=1701293831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=um2YSmpP1zf78M1dUAJgNRPJiGEOfrPk5ZanDrjksBk=;
        b=Wid3KwbjQZveYb3/4lSwoV4N1MadPW/kUvXt0GrP72jQhgY2cpCMOS3Winzuj5BpVa
         2fbDdeIL11O1uUsm7g2rZGx8MjDfu19c+zVUKMGyB2krti4ClViI9X95p8WoPMvLKeZt
         Eh7mGTUPnSHuzAmqbwu5RkX2B4J655xzgll8EuBQNx82BMpfxs3vnGapRAEuC0thH8Eq
         q+oyziNrKnAx6ejATxt/fcbVG/1uCDnDYvaRHLTE4j0AM36lmTNgshkaSA2tgHEqawI3
         BgogHFF7vALM0oV+dFbCqfW0vSdBQuR1gilsSIHnTHmqdl7yVVCMHXzQaY0BwEzRwvvb
         Rdig==
X-Gm-Message-State: AOJu0Ywd6fwUZ1CCf1GLloMJOt1gTivPPwfBE6Pnnz81oa1mDE0Begba
        0lHzVUAGIojPlEPWbwt71sasgg==
X-Google-Smtp-Source: AGHT+IF4xWcSzShEo99tJ39hkUJMNx8gsJN0VEwi/zRx6UXJos5gS2+PXErhYX+YRnR/GOWoBudsRg==
X-Received: by 2002:a05:6000:402a:b0:332:c429:138f with SMTP id cp42-20020a056000402a00b00332c429138fmr2336925wrb.0.1700689030913;
        Wed, 22 Nov 2023 13:37:10 -0800 (PST)
Received: from airbuntu.. (host109-151-228-202.range109-151.btcentralplus.com. [109.151.228.202])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c3b8500b00407752bd834sm563070wms.1.2023.11.22.13.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 13:37:10 -0800 (PST)
From:   Qais Yousef <qyousef@layalina.io>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        John Stultz <jstultz@google.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, Qais Yousef <qyousef@layalina.io>
Subject: [PATCH] rcu: Provide a boot time parameter to enable lazy RCU
Date:   Tue, 21 Nov 2023 20:53:04 +0000
Message-Id: <20231121205304.315146-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow more flexible opt-in arrangements while still provide a single
kernel for distros, provide a boot time parameter to enable lazy RCU.

Specify:

	rcutree.enable_rcu_lazy

Which also requires

	rcu_nocbs=all

at boot time to enable lazy RCU assuming CONFIG_RCU_LAZY=y. The
parameter will be ignored if CONFIG_RCU_LAZY is not set.

With this change now lazy RCU is disabled by default if the boot
parameter is not set even when CONFIG_RCU_LAZY is enabled.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---

Makes sense to remove the CONFIG_RCU_LAZY now we have a boot time param?

We can make it a static key too if it *really* matters.

Thanks to Joel for helping initially in reviewing this patch which was intended
originally for Android.

I got some requests to make this a runtime modifiable for init scripts; but
Paul suggested there shall be dragons. So RO it is.


 .../admin-guide/kernel-parameters.txt         |  5 ++++
 kernel/rcu/tree.c                             | 26 ++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 65731b060e3f..2f0386a12aa7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5021,6 +5021,11 @@
 			this kernel boot parameter, forcibly setting it
 			to zero.
 
+	rcutree.enable_rcu_lazy= [KNL]
+			To save power, batch RCU callbacks and flush after
+			delay, memory pressure or callback list growing too
+			big.
+
 	rcuscale.gp_async= [KNL]
 			Measure performance of asynchronous
 			grace-period primitives such as call_rcu().
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3ac3c846105f..e0885905b3f6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2718,7 +2718,30 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 	}
 }
 
+static bool enable_rcu_lazy;
 #ifdef CONFIG_RCU_LAZY
+/* Enable lazy rcu at boot time */
+static int param_set_rcu_lazy(const char *val, const struct kernel_param *kp)
+{
+	int ret;
+
+	/*
+	 * Make sure a grace period has passed before and after flipping the
+	 * switch.
+	 */
+	rcu_barrier();
+	ret = param_set_bool(val, kp);
+	rcu_barrier();
+
+	return ret;
+}
+static const struct kernel_param_ops rcu_lazy_ops = {
+	.flags = KERNEL_PARAM_OPS_FL_NOARG,
+	.set = param_set_rcu_lazy,
+	.get = param_get_bool,
+};
+module_param_cb(enable_rcu_lazy, &rcu_lazy_ops, &enable_rcu_lazy, 0444);
+
 /**
  * call_rcu_hurry() - Queue RCU callback for invocation after grace period, and
  * flush all lazy callbacks (including the new one) to the main ->cblist while
@@ -2792,7 +2815,8 @@ EXPORT_SYMBOL_GPL(call_rcu_hurry);
  */
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
-	__call_rcu_common(head, func, IS_ENABLED(CONFIG_RCU_LAZY));
+	__call_rcu_common(head, func, IS_ENABLED(CONFIG_RCU_LAZY) &&
+			  READ_ONCE(enable_rcu_lazy));
 }
 EXPORT_SYMBOL_GPL(call_rcu);
 
-- 
2.34.1

