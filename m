Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC39D781EA3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 17:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjHTPZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 11:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjHTPZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 11:25:44 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DECB3A9A
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 08:21:51 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fee600dce6so9736105e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 08:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692544910; x=1693149710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t1WFhLLujM0Chr+SFgokCgNMU6zRltqI69DEFgLDAHM=;
        b=FMj8AIFOKHOUOs579dCdiNT8N9nIRUXe7vWEEWi+4Ym7tht9mCp4KrM4gNByXZBOQS
         liHslt2h7iNO+t9RjBUVr6zhUuLjZrbr6SlXX69mcq40hax5tGHdWVypHuDiDKxDGa66
         6KDlvXoSmrIhW8xUf1WNaYiqN0C/LW+Vv10l6/Hf5tIiFYVnWaVUvTnNKieks6eia793
         JJH67O2xM8d+UKQyFjTUvOvh2eKW9GyZ6OchggLkde6n86jE0iyaPRBzCC0dZlMBLibs
         orLYy7XlIYntl9+EgUSbotcn9c0JET16VFwoS11Cn59mceRqjM8iLfjqeol16WJmBl0y
         xVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692544910; x=1693149710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t1WFhLLujM0Chr+SFgokCgNMU6zRltqI69DEFgLDAHM=;
        b=HazRa7irqNh5Mp2LHegXxN0fycfyp9Xfa6CtFMOt/WvUYo0OwkJqbJtejEi+VzhlVg
         tryb+C/WxjDv1YyOUtsXyumQG6mGGu+5Kt40dVnZDpYAdtkyqUUghRRJ8opu7P689u02
         bvW0e7+QOM8fh+j0Rj9Mx350oNUnV7p1wRlJmlZQMQbEvuvnMvv4F9e4LeWUUtqgVYMR
         Ft8kJkejz7QMQ2tflkE7bJA3OHtF/rCeLISwf0sW0fuFpzqsaYdzVlCp1gvb/8DauBtq
         Gy5Hcl7NBNDJjlY78C3vN4NvmddKbLuSLPebE8Ve712eOvyJwWncrquZOwA4ZrMiNDA7
         IPhg==
X-Gm-Message-State: AOJu0YypzuSZ/k5/6oZoz/sJcPnLKBYtqVHRUl7jsYuyc8JqcVBbGpYI
        0a3+OSY+b3KP7vTpqvrfRv8Q/4AcofhK5RWS5k0=
X-Google-Smtp-Source: AGHT+IEfgSETFCpZ8ZM9J6X/uBMjWpzJMTJX6/BAw7lW2wKlwYwVtHw6y2wx7TO+NakNYRnOgkbhTw==
X-Received: by 2002:a7b:cbcd:0:b0:3fe:25b3:951d with SMTP id n13-20020a7bcbcd000000b003fe25b3951dmr3262262wmi.5.1692544909882;
        Sun, 20 Aug 2023 08:21:49 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c510b00b003fe3674bb39sm9762497wms.2.2023.08.20.08.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 08:21:49 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     stable@vger.kernel.org
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Hao Luo <haoluo@google.com>,
        John Stultz <jstultz@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 0/6] Backport rework of deadline bandwidth restoration for 5.10.y
Date:   Sun, 20 Aug 2023 16:21:38 +0100
Message-Id: <20230820152144.517461-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a backport of the series that fixes the way deadline bandwidth
restoration is done which is causing noticeable delay on resume path. It also
converts the cpuset lock back into a mutex which some users on Android too.
I lack the details but AFAIU the read/write semaphore was slower on high
contention.

Compile tested against some randconfig for different archs and tested against
android13-5.10 GKI kernel.

My testing is limited to resume path only; and general phone usage to make sure
nothing falls apart. Would be good to have some deadline specific testing done
too.

Based on v5.10.191

Original series:

	https://lore.kernel.org/lkml/20230508075854.17215-1-juri.lelli@redhat.com/

Thanks!

--
Qais Yousef

Dietmar Eggemann (2):
  sched/deadline: Create DL BW alloc, free & check overflow interface
  cgroup/cpuset: Free DL BW in case can_attach() fails

Juri Lelli (4):
  cgroup/cpuset: Rename functions dealing with DEADLINE accounting
  sched/cpuset: Bring back cpuset_mutex
  sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets
  cgroup/cpuset: Iterate only if DEADLINE tasks are present

 include/linux/cpuset.h  |  12 ++-
 include/linux/sched.h   |   4 +-
 kernel/cgroup/cgroup.c  |   4 +
 kernel/cgroup/cpuset.c  | 161 ++++++++++++++++++++++++++++------------
 kernel/sched/core.c     |  41 +++++-----
 kernel/sched/deadline.c |  66 ++++++++++++----
 kernel/sched/sched.h    |   2 +-
 7 files changed, 202 insertions(+), 88 deletions(-)

-- 
2.34.1

