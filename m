Return-Path: <linux-kernel+bounces-128906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EAF8961B4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14F41F22EA8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DA2DDDF;
	Wed,  3 Apr 2024 00:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="YNvBKSbF"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A3D28FC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 00:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712105997; cv=none; b=V2BAaID/U8hcIOs3M8I0kgNNefRFQoQawCrAXBgxk4XFigGHgEpfH43WG2KNOi79d0uRb1b2ht5Wbla1httuwjCrJP6pPSvpZZJzlQsXqlTGXD9uhC4//pYXaOVK1a044F8Oh6/rSXTuLkErrITTodsLwS4FRf40qOK5LqB4fDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712105997; c=relaxed/simple;
	bh=UcWbjMKK6Mim3U5Mb4CoM92GRTgV0/HXoYZ2J9217YE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iLCeP9Mcj7/fS/I90MtxcI3cFLMcb964pOxIJNasM/ya3g55N0A68vxJAVKHKuCwIkjTY4JnK6bG5PWIsz8mgnh1gtahEzz7AdjpKAQcZNdoiyPjD05fL7fONDTU2Xsyp1KpckrmypW9W+VFc0NZoSZRnPHzqu9YlG093CBg2OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=YNvBKSbF; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33ecb04e018so4231818f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 17:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1712105994; x=1712710794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1q3vCT6Gvhp0NkYHtPBzmqjOHDP4+85pXtQLvKPNLPc=;
        b=YNvBKSbFwd85vTTIZ893FLVhXz7hJTPXvFLL53mdjo3Gendd57m33F6w/sXQwFeam1
         ItKflEeuWUOPgw8+JVo1k0dHja6g0OKFrJs68cRran4QGoBGGV39DxsE4cE+8lJbxhAm
         AYoOzsiug79fCfT+mtV/mCodlwE0O7GkPPEZz2/+rp6pHNYi+S3OUHIgMXaW14gULXwX
         kbvm+f74avT07UymneUO1nKbAtxGlDsmMonTEHfJc2r58LglKq+a6paoluP+1GiSSEY5
         GSrguPx0Mw9OeXpKlW4ldVMdY2CPKJFGcxCJ9KwBRv9SyE4h6RKYzbdvW3CpH17Qh3D1
         nOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712105994; x=1712710794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1q3vCT6Gvhp0NkYHtPBzmqjOHDP4+85pXtQLvKPNLPc=;
        b=mkXvV32bWoBYCpbeYR/sI6bGR38SL13gkt8URNw49tn6M3pGsW+k7w4c6CgMOPhOju
         g3UT8dtNKfJ/XTOejQcuzTX+FXmSdoxuu9O40Md5m60st10Yt+QRvThMlcJIv3AS6Lpy
         4VJu4WUYoInaHXWqGqPto99h/atNnYN+pQpsWRjgmbadJ319DTrj+fHXAlVrOudwTbFm
         da0SelAip7D/+kXS2RXTU8zXwWeW9U8cXKHSnorYkKp3bANDqcXpd1BZ422XcXdLz+0Z
         zKNSMNTn28m66RezM5XKUoYgwQLLzAteNLYywnFrYubxylDQf06UoUQphMMjVxog/sjq
         9v1g==
X-Forwarded-Encrypted: i=1; AJvYcCWfT7IcX5kNV5TKtTTcUcBIw264Z6Wro3Mra2TobZKsSlOURT721invm0+CHV+G/fUVhZ+7v9Uu3wDR/dbK2EfWirAlwMufGuBCY2Hk
X-Gm-Message-State: AOJu0YzSZ20PdgH8CoXqFA5PEAui8Yo5JngXxcyhzlOdQtftfyabcXhB
	wqLZ5jXb2VyOMUlw7X15rpLY+KTKsotm8o7eI/NcrOCZVnRNgo44KcwUmX5408o=
X-Google-Smtp-Source: AGHT+IEXSAFbhLolPg/zMWrEEo5PnZsPwcWlYDgFcNoV0bXkwYo8+ycR6ac9lkJ7qM4RwCbNmyDGuA==
X-Received: by 2002:adf:fe45:0:b0:343:7219:7d34 with SMTP id m5-20020adffe45000000b0034372197d34mr1910057wrs.37.1712105993549;
        Tue, 02 Apr 2024 17:59:53 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id f12-20020a056000036c00b00341ce80ea66sm15642282wrf.82.2024.04.02.17.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 17:59:53 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	John Stultz <jstultz@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>,
	Yabin Cui <yabinc@google.com>
Subject: [PATCH] sched/pi: Reweight fair_policy() tasks when inheriting prio
Date: Wed,  3 Apr 2024 01:59:30 +0100
Message-Id: <20240403005930.1587032-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For fair tasks inheriting the priority (nice) without reweighting is
a NOP as the task's share won't change.

This is visible when running with PTHREAD_PRIO_INHERIT where fair tasks
with low priority values are susceptible to starvation leading to PI
like impact on lock contention.

The logic in rt_mutex will reset these low priority fair tasks into nice
0, but without the additional reweight operation to actually update the
weights, it doesn't have the desired impact of boosting them to allow
them to run sooner/longer to release the lock.

Apply the reweight for fair_policy() tasks to achieve the desired boost
for those low nice values tasks. Note that boost here means resetting
their nice to 0; as this is what the current logic does for fair tasks.

Handling of idle_policy() requires more code refactoring and is not
handled yet. idle_policy() are treated specially and only run when the
CPU is idle and get a hardcoded low weight value. Changing weights won't
be enough without a promotion first to SCHED_OTHER.

Tested with a test program that creates three threads.

	1. main thread that spanws high prio and low prio task and busy
	   loops

	2. low priority thread that holds a pthread_mutex() with
	   PTHREAD_PRIO_INHERIT protocol. Runs at nice +10. Busy loops
	   after holding the lock.

	3. high priority thread that holds a pthread_mutex() with
	   PTHREADPTHREAD_PRIO_INHERIT, but made to start after the low
	   priority thread. Runs at nice 0. Should remain blocked by the
	   low priority thread.

All tasks are pinned to CPU0.

Without the patch I can see the low priority thread running only for
~10% of the time which is what expected without it being boosted.

With the patch the low priority thread runs for ~50% which is what
expected if it gets boosted to nice 0.

I modified the test program logic afterwards to ensure that after
releasing the lock the low priority thread goes back to running for 10%
of the time, and it does.

Reported-by: Yabin Cui <yabinc@google.com>
Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0621e4ee31de..b90a541810da 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7242,8 +7242,10 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	} else {
 		if (dl_prio(oldprio))
 			p->dl.pi_se = &p->dl;
-		if (rt_prio(oldprio))
+		else if (rt_prio(oldprio))
 			p->rt.timeout = 0;
+		else if (!task_has_idle_policy(p))
+			reweight_task(p, prio - MAX_RT_PRIO);
 	}
 
 	__setscheduler_prio(p, prio);
-- 
2.34.1


