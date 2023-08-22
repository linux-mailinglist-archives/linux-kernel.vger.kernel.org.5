Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63407783B0B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbjHVHhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjHVHhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:37:11 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B677A13D;
        Tue, 22 Aug 2023 00:37:09 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-26b5e737191so2218189a91.2;
        Tue, 22 Aug 2023 00:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692689829; x=1693294629;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CgjddeGwQJa4U0Oo393Y2//7tcfoJ9+Z/llPTxQolg0=;
        b=J9RtoThF7Au9NMK9qLNwGbp3Q4tSeT0VINMoSZwFFuPzmDE8tJ2Oz0tOl/JO8nMTe8
         vp/3ldJi84QOZsfMRpBUvzRATf3uuWP5to2scNpnL4OibDzA9GQ5Wghwdbb6y24E6G2B
         XJXVNeKj7h+48TWkOiCEWKUfId1v7SNWcE8Gtd42rD2jUDJw+6Krh/K+JxhZs5q84bSv
         wxQKFpXRj+qqjiPQZWj4Zdv/0Vj5YB/86VPvQ3pErps3Urgc6efCadOxhHhXMbsnCeFf
         YQ9stKW/TqsVEibyeeTy3rpZ26bDhhwsZ4J7NFjLA48ZrkfIUY5BP9CdwmnGOx3Gx2vy
         1YKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692689829; x=1693294629;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CgjddeGwQJa4U0Oo393Y2//7tcfoJ9+Z/llPTxQolg0=;
        b=Nlk4fZbGMRWswStnsZZESEq4UMfDwGBd21tuhF68UZDGHKRjWsdXvPlXs7f6yqHAT8
         03kVbslb4rvV7SdrAhw0f450BreRNSnuHPVIqpU05174uHQoLx8h/87p/W7KGkDb95oD
         f8lkfirSAXn54fRFBLjgzupwuNDDmtvonjd0zEhTmMvPpoTioKVBZgujL45Bmzc++HrV
         uz2l+2QWdMPAiaZfFgDLeYkrfHrj2F3PctVmRVBnweTAHrpuPa8z8QzfHLkuqEdiNcuJ
         mD+JYTafMvABGUqBkBtJki8jWl9HBjLR4cbUoA+lg4SWY/Q/GXD1uHAUELiQxhMSyPHo
         uebA==
X-Gm-Message-State: AOJu0YzErMqQSRWrZaDlVaNouc21OhFL5wqIlpbNQkHb88kcJMwhPPDS
        yMvPGyLs2vU0HxaqHf/d5m9nBMuil+rk/2fQNsh87C0KD3c=
X-Google-Smtp-Source: AGHT+IEo5f8lIMjnOK3meeILSBg4zCgZNvOITDPY9BTB8do/yt51c+jcGuNDFiOGme3fZPIi24XeU93KZ9+IeCqu8P4=
X-Received: by 2002:a17:90a:88:b0:26d:2086:8c96 with SMTP id
 a8-20020a17090a008800b0026d20868c96mr5855867pja.43.1692689829054; Tue, 22 Aug
 2023 00:37:09 -0700 (PDT)
MIME-Version: 1.0
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Tue, 22 Aug 2023 15:36:57 +0800
Message-ID: <CALm+0cVvHb=Fe8kseVLesjS1d=579c7Bn5hxdiqyzBp5Z7SugA@mail.gmail.com>
Subject: rcutorture: Can not Disable RT throttling
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running build-in rcutorture tests in 6.5.0-rc4-rt, and found that,
although the value of /proc/sys/kernel/sched_rt_runtime_us is -1,

cat /sys/kernel/debug/sched/debug
....
rt_rq[6]:
  .rt_nr_running                 : 4
  .rt_nr_migratory               : 0
  .rt_throttled                  : 0
  .rt_time                       : 0.000000
  .rt_runtime                    : 950.000000

but the rt_runtime still is 950.000000.
set sysctl_sched_rt_runtime in rcu_torture_disable_rt_throttle()
does not disable rt-throttling.

Currently I'm testing this way to disable rt-throttling:

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 338cd150973f..bb9fee51a476 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -22,7 +22,7 @@ unsigned int sysctl_sched_rt_period = 1000000;
  * part of the period that we allow rt tasks to run in us.
  * default: 0.95s
  */
-int sysctl_sched_rt_runtime = 950000;
+int sysctl_sched_rt_runtime = IS_BUILTIN(CONFIG_RCU_TORTURE_TEST) ?
-1 : 950000;

 #ifdef CONFIG_SYSCTL
 static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;


Is there a better way to solve it?

Thanks
Zqiang
