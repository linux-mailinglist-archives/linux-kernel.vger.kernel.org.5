Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351A6790748
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 12:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351966AbjIBKNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 06:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbjIBKNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 06:13:51 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C05E10F5
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 03:13:47 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so26586025e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 03:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693649626; x=1694254426; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=sgrGSNGAHs6K5xZERfK7C7KKF6SjNOs/QPCt2hgBPp4=;
        b=iiB4amq/pV54GOLJDsDtxI9vc+L3piCeuZarrc/dWSeJgXNU/U8zOKvj5Qy9+Pq7U5
         gB68YfGV9HxwCmcGMy1+M2Ld5bE1ZtQMDlvev4padejfcAXPXju9wE4tv2bZVJ/94gb/
         e1zv9xAm5CHcyf9WPJDC/d+pOMNQ2xSkXCSPfborGHDZDuMSrZcOSDRkhEbnkMidIwux
         jc8xBneCYTKXvlT79m9uhU9RVcsRISn36AnoDMeyvkqFr9AppVLctEOrOWvO+0C7FUxA
         1bxhFO+K2UP/r0THWiZsgPvqPao2ZgNKvjjAatjX42GvhUvShLHSahxTCXrEIgTgcspN
         Iltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693649626; x=1694254426;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sgrGSNGAHs6K5xZERfK7C7KKF6SjNOs/QPCt2hgBPp4=;
        b=MVFifMQkpKEB+OxsajSctXG22qYmGoerf3ML34vTBs7l9kT/vEAXSviclUfKW+Uv0F
         wosRVrQ1ndLMzShN1vFqrU9AHSsVn0jjLbwllZSnys1CsQ2Z9qqwyCgJ8AnFTaU81vZz
         8T8vEXzYRxkcpntqQwPQymfMYzDg8Rx+8Xd47U9VBhueQ+Mc77E39gm8QthUnwZqB+3E
         AFG4EV0DFk8N0kOCmHX/3CegfejISZEgja2sXhYuPYuY6EQtVyNn6AJ7ojMmwqOEFsFi
         wPFX8Zg6hL60pu5m1fgtg3CnCJ7KhCKGe7TwkHrtE57jrp6GgttWXYsCkfq/LrN6ov+B
         9Snw==
X-Gm-Message-State: AOJu0Ywxy53Po5rq+hsmkRXmPibTwSUw8G//zfKCKIBBgq6m7tm5OOTK
        bn4tpaOHBaZODxulskRu/Nw=
X-Google-Smtp-Source: AGHT+IFmmbRp+/xMdRLp9gTa85UnFMdpJ7m5J0XvGAJTPCEhtW2Us7ev5Z9HXko9p1F8SjqbgBtdZg==
X-Received: by 2002:a1c:6a03:0:b0:401:b493:f7c0 with SMTP id f3-20020a1c6a03000000b00401b493f7c0mr3700242wmc.2.1693649625732;
        Sat, 02 Sep 2023 03:13:45 -0700 (PDT)
Received: from gmail.com (1F2EF6A2.nat.pool.telekom.hu. [31.46.246.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a1c6a07000000b003fe407ca05bsm10600111wmc.37.2023.09.02.03.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 03:13:44 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 2 Sep 2023 12:13:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] CPU hotplug fix
Message-ID: <ZPMK1vcdJ977n89r@gmail.com>
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

Please pull the latest smp/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-2023-09-02

   # HEAD: 2b8272ff4a70b866106ae13c36be7ecbef5d5da2 cpu/hotplug: Prevent self deadlock on CPU hot-unplug

Fix a CPU hotplug related deadlock between the task which initiates
and controls a CPU hot-unplug operation vs. the CFS bandwidth timer.

 Thanks,

	Ingo

------------------>
Thomas Gleixner (1):
      cpu/hotplug: Prevent self deadlock on CPU hot-unplug


 kernel/cpu.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index f6811c857102..6de7c6bb74ee 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1487,8 +1487,22 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 	return ret;
 }
 
+struct cpu_down_work {
+	unsigned int		cpu;
+	enum cpuhp_state	target;
+};
+
+static long __cpu_down_maps_locked(void *arg)
+{
+	struct cpu_down_work *work = arg;
+
+	return _cpu_down(work->cpu, 0, work->target);
+}
+
 static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
 {
+	struct cpu_down_work work = { .cpu = cpu, .target = target, };
+
 	/*
 	 * If the platform does not support hotplug, report it explicitly to
 	 * differentiate it from a transient offlining failure.
@@ -1497,7 +1511,15 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
 		return -EOPNOTSUPP;
 	if (cpu_hotplug_disabled)
 		return -EBUSY;
-	return _cpu_down(cpu, 0, target);
+
+	/*
+	 * Ensure that the control task does not run on the to be offlined
+	 * CPU to prevent a deadlock against cfs_b->period_timer.
+	 */
+	cpu = cpumask_any_but(cpu_online_mask, cpu);
+	if (cpu >= nr_cpu_ids)
+		return -EBUSY;
+	return work_on_cpu(cpu, __cpu_down_maps_locked, &work);
 }
 
 static int cpu_down(unsigned int cpu, enum cpuhp_state target)
