Return-Path: <linux-kernel+bounces-75211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5413085E4C8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09760286936
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C88F84037;
	Wed, 21 Feb 2024 17:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XadmKiXD"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C570D83CCC
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537422; cv=none; b=mDFGyX4EVuvlMzb2sTA+AhIzhFai6lyGHQ5/HlR1e3XRrUztUl1kFKnKla2hht+kBA82Oh694BS7x4Od72euOJElUNTgJHZ+nmdsK+pPwt/SEMWncSbORwAhzSO+UR8kkIMN0Rt2Gu2jXdhfFNd0VFBaiDHQBy75j5WVykpquic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537422; c=relaxed/simple;
	bh=h4TV+vSm+vO44bK+izphICuXWjrpSUg01OF+ubEXDq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QuFH4P3m5sp9rcOSwfR+O6l/bg/lUDtetGKE2ztDSTe32ciBhL2wGahNgwwjXSb1ju7waqGlrFBW13DE8m7gdxKiBB9y7EJ7+zNpOxk7437sODs8uUjwBVFCVDB1xIbD5qENwyrs75xyNloAFuGqIaM8GidXsAbQMZAnvlRbUig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XadmKiXD; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e457fab0e2so17236b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708537420; x=1709142220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4+m9nZwigtJ5qD1+/C5QT7dF01tkI50gys1vvJtCZQM=;
        b=XadmKiXDNfO5s+vvof4ockH+Fn26kP2g3mvqYse0A/0ppdWrkmMo4I6cYFEOsALLbZ
         PwOl8g5H8DMAwc4vita6HcnPS7BPT0biH3k/ali8sVHNN8RvG0OgS8264XRNALAFfbWw
         MI5MTINKTb5pR+CtFHqv8DdY4NO2a3t15iTj4pT+jBOYQWaOkk6SP6w0bXnalUY0g1sh
         uZHJ/nQSDUA/TerzXQxaK4DrGhCb6cIDIYk25FvHDrsGlDvNdyb6gN1vooqdHqv6CSzu
         BdRMvD3ScTS/rE+u1FMmQRrK+nClVriYzv/49dTJGfUVn5kDUwN2hXAYranF0uncWRMt
         8xLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708537420; x=1709142220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+m9nZwigtJ5qD1+/C5QT7dF01tkI50gys1vvJtCZQM=;
        b=Ur41JzCQkl8VYHKOgUlxSA1Wjxqsd+TqJm6J+y2MKePCmcc0H6MpEs4jaVbomUjW8t
         VtL+6f/4kXbFU6emRV0RvQXJ7n0ouPheAN/DzDaNvy7afqGTQ4bKfxVxWtzGtnyCN77B
         jlBqmUtoxKnnwds2wqze+40529FM6LwKKUtOy0A9goRlH/mYQyjLPUSbdduE7e95z4K3
         BzcCvCax6kUJ4axPWCoTwM9CqKeq+tCOZUn65v6vnFmMI8M+Q3JBMyxsIrAeb1gouE5F
         yCOKkT2pmbnYnSelUcJvPrgVKnvNEVo614ZmKNl3CeLyGeXSFgDdYIhthhAsC07Ng0yp
         kKBg==
X-Forwarded-Encrypted: i=1; AJvYcCW0fmcbkfPvZl4yHzDa8Lq0HzCHHZuPgnrwbsAhxs4qq4XBghldKTTWRGVpvFMKWM5mDGnsALesk7WidyTffRofMzz0RFoE4cvciWmG
X-Gm-Message-State: AOJu0Yx1yHieqbCuZHMQMvfM/UXm3LEDZTNvCib90/KFOdKg8DSXEun+
	91ecTNcfT+FqYzpLVFX15uLUFofZrlwllakFoVWMFCE1sN97sq+T
X-Google-Smtp-Source: AGHT+IFZQ6oDcOsFKxp/3L5hUqt+OyoJv4RTjtk+/AU+5k0d4Mc+C6tQRH4EhqA042Pc8PB6wJkJqw==
X-Received: by 2002:aa7:8dc4:0:b0:6e4:8c1d:7f0b with SMTP id j4-20020aa78dc4000000b006e48c1d7f0bmr213600pfr.6.1708537419835;
        Wed, 21 Feb 2024 09:43:39 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id v2-20020aa799c2000000b006e43b99a6c6sm7162506pfi.118.2024.02.21.09.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 09:43:39 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com
Subject: [PATCHSET v2 wq/6.10] workqueue: Implement disable/enable_work()
Date: Wed, 21 Feb 2024 07:42:58 -1000
Message-ID: <20240221174333.700197-1-tj@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Changes since v1 (http://lkml.kernel.org/20240216180559.208276-1-tj@kernel.org):

- Added missing disabled checks to queue_work_node() and
  mod_delayed_work_on(). (Lai)

- __flush_work() was derefing RCU protected pool pointer outside
  rcu_read_lock() section. Deref and test inside and remember the result.
  (Lai)

- queue_rcu_work() doesn't need a disabled check as rcu_work doesn't support
  canceling and disabling; however, in case users reach into rcu_work and
  invoke disable on the embedded work item, add disabled check to
  queue_rcu_work() and trigger warning if disabled. (Lai)

- The first ten cleanup patches have been applied to wq/for-6.9 and dropped
  from this series.

4cb1ef64609f ("workqueue: Implement BH workqueues to eventually replace
tasklets") implemented workqueues that execute work items in the BH context
with the goal of eventually replacing tasklet.

While the existing workqueue API covers the basic queueing and canceling
operations, tasklet also has tasklet_disable*() which blocks the execution
of the tasklet until it's re-enabled with tasklet_enable(). The interface if
fairly widely used and workqueue currently doesn't have a counterpart.

This patchset implements disable/enable_work() and the delayed_work
counterparts to address the gap. The ability to block future executions is
something which some users asked for in the past, and, while not essential
as the caller can and often has to shutdown the queuer anyway, it's a nice
convenience to have. Also, timer grew a similar feature recently with
timer_shutdown().

- tasklet_disable() keeps disable depth so that a tasklet can be disabled
  and re-enabled by multiple parties at the same time. Workqueue is updated
  to carry 16bit disable count in work->data while the work item is not
  queued. When non-zero, attempts to queue the work item fail.

- The cancel_work_sync() path used WORK_OFFQ_CANCELING to synchronize
  multiple cancel_sync attempts. This added a completely separate wait
  mechanism which wasn't very congruent with the rest of workqueue. This was
  because the canceling state was carried in a way which couldn't
  accommodate multiple concurrent uses. This mechanism is replaced by
  disable - cancel_sync now simply disables the work item, flushes and
  re-enables it.

- There is a wart in how tasklet_disable/enable() works. When a tasklet is
  disabled, if the tasklet is queued, it keeps the softirq constantly raised
  until the tasklet is re-enabled and executed. This makes disabling
  unnecessarily expensive and brittle. The only busy looping workqueue's
  implementation does is on the party that's trying to cancel_sync or
  disable_sync to wait for the completion of the currently executing
  instance, which should be safe as long as it's from process and BH
  contexts.

- A disabled tasklet remembers whether it was queued while disabled and
  starts executing when re-enabled. It turns out doing this with work items
  is challenging as there are a lot more to remember and the synchronization
  becomes more complicated too. Looking at the use cases and given the
  continuity from how cancel_work_sync() works, it seems better to just
  ignore queueings which happen while a work item is disabled and require
  the users to explicitly queue the work item after re-enabling as
  necessary. Most users should be able to re-enqueue unconditionally after
  enabling.

This patchset contains the following 7 patches:

 0001-workqueue-Preserve-OFFQ-bits-in-cancel-_sync-paths.patch
 0002-workqueue-Implement-disable-enable-for-delayed-work-.patch
 0003-workqueue-Remove-WORK_OFFQ_CANCELING.patch
 0004-workqueue-Remember-whether-a-work-item-was-on-a-BH-w.patch
 0005-workqueue-Update-how-start_flush_work-is-called.patch
 0006-workqueue-Allow-cancel_work_sync-and-disable_work-fr.patch
 0007-r8152-Convert-from-tasklet-to-BH-workqueue.patch

Given how many invasive workqueue changes are already queued for v6.9 and
the subtle nature of these patches, I think it'd be best to defer this
patchset to v6.10 so that we can use v6.9 as an intermediate verification
point.

0001-0002 implement disable_work() and enable_work(). At this stage, all
disable[_sync]_work and enable_work operations might_sleep(). disable_work()
and enable_work() due to CANCELING synchronization described above.
disable_work_sync() also needs to wait for the in-flight work item to finish
which requires blocking.

0003 replaces CANCELING with internal use of disble/enable. This removes one
ugliness from workqueue code and allows disable_work() and enable_work() to
be used from atomic contexts.

0004-0006 implement busy-wait for BH work items when they're being canceled
thus allowing cancel_work_sync() and disable_work_sync() to be called from
atomic contexts for them. This makes workqueue interface a superset of
tasklet and also makes BH workqueues easier to live with.

0007 converts drivers/net/r8152.c from tasklet to BH workqueue as a
demonstration. It seems to work fine.

The patchset is on top of wq/for-6.9 (bccdc1faafaf ("workqueue: Make @flags
handling consistent across set_work_data() and friends")) and also available
in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git disable_work-v2

diffstat follows. Thanks.

 drivers/net/usb/r8152.c   |   44 +++----
 include/linux/workqueue.h |   23 ++-
 kernel/workqueue.c        |  409 +++++++++++++++++++++++++++++++++++++++++++-------------------------
 3 files changed, 302 insertions(+), 174 deletions(-)

--
tejun

