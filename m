Return-Path: <linux-kernel+bounces-163090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1A98B6554
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7771F226C4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8D3190697;
	Mon, 29 Apr 2024 22:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/X/DKRk"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3654917798F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 22:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714428645; cv=none; b=dPdFychQu2ISX/X3nHJzRBUyHY5W/50sKuxXiyJ8uKXUUdbuQ+3CciHRUHKQ3b1M7W79a9LWvUxRbSf0X0q1cn5b5fkgH6sQVE82LXwdbm9CA345gwfTF7P/sCcoCcF87fd6eCJC8gBh4hyMOYbjF/HPee1b3nlkAst8a2LHOTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714428645; c=relaxed/simple;
	bh=p6gukMxZDntCqADMyEuUTYHm6UthqrT9QCj3+/JbR5c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l0YvXcrIwHo6ebBx9K4F3gJTHlUdaHipWQRFnTU6suvm6tvGjgeEnfG2th6GUv1jtWHnOOeoT5Mh0nJkhYbZSYr8gwmX5oG7JOGR9GmgY464nmL6pmou6QTpDD0vOQLrqjbFzt/pDSSwcKeV29mAG0YziOndXGVh/uvnQlaBNW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/X/DKRk; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso4213950a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714428643; x=1715033443; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/WdJAlLlsoz3LuH9C0ELWJKBveFBAT8xLGCI8cyDMAE=;
        b=Z/X/DKRk2mg3gjXqr6OAWWhDSkZn+SYGGJ81Iy3abJFZ6d017WHBsHLEZmMkrR4HKJ
         DrdSFc8ZAwJ9lLbFRPJpX/qYdRbU+eCgblZp8KF2DrFQwPd7D0KJWKjIWBukrWOKKr+m
         UAUKGR9PjIZCkCAbCO/OwwjF4dbSPHoiNumAmqNQ3nU/dx31NxsdadLDFqhR+82DAwuR
         rP7bjkQWZjxJs6gYGWrhmTXgMUMuRjYqEWIs10ufj35oZq0PSEIfA2pX9pcQvIwjK7hj
         rBnvAh6aq0IZlytNo9HX0nOGmC5G178f0FNx2p3x6Q1aSw2KSm+IClpfXxz9kce+YrqW
         2kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714428643; x=1715033443;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/WdJAlLlsoz3LuH9C0ELWJKBveFBAT8xLGCI8cyDMAE=;
        b=GJnPziivFZzEZnGKcDjDAAZTaQG/y8vvkIVyfqAK14PQbXa7GvzxAjWi5C6c++k6ow
         8+pYoYXP85VUqhB9kBZYYBlHMBi2GZYavnmd06UlYVcJrAVaXWk1P1Y1O9aOWeLmA2xx
         rrucS+S/QTftyJIUl/hy8OM7kT+RVLgRnI2qLepJrDx8RqDYJhD9+SStN7bemtrRVTZK
         VWLkPoFMzIIix4PCs6JP7wmMbnseExyPv29d3Zh0Gi8m2yrknfcGxk7wk3hvFzN8TTLz
         b9tRIxKg2a8HWY6R1immRS4fqwp0eBQUZG40IeszGORGDPjl9j1TtBIlDajDuYu9tTp/
         gnfw==
X-Gm-Message-State: AOJu0Yzb1JtiKEto9oEFnbyiAShWR/bIKydsTXwN1qrZ5gAPNm4tPgL1
	z/HpMDIfjlz2QRSxaoMc/1V6n87I5dcX3cimCgkBAGDcusAD8XnI
X-Google-Smtp-Source: AGHT+IFMzkT49MI5b7YtiJedpxRllklPZjsqJ+206xLsCQChR8hev7yHiJ3gCDnJUkp4P+2Jh7ddWw==
X-Received: by 2002:a05:6a20:431d:b0:1ac:e379:52fd with SMTP id h29-20020a056a20431d00b001ace37952fdmr15694494pzk.14.1714428643351;
        Mon, 29 Apr 2024 15:10:43 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902ecc400b001eac9aa55edsm8180437plh.250.2024.04.29.15.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 15:10:43 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 29 Apr 2024 12:10:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue: Fixes for v6.9-rc6
Message-ID: <ZjAa4eL2plDnP-tD@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit b1e6ec0a0fd0252af046e542f91234cd6c30b2cb:

  Merge tag 'docs-6.9-fixes' of git://git.lwn.net/linux (2024-04-02 12:44:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.9-rc6-fixes

for you to fetch changes up to 91f098704c25106d88706fc9f8bcfce01fdb97df:

  workqueue: Fix divide error in wq_update_node_max_active() (2024-04-24 07:23:06 -1000)

----------------------------------------------------------------
workqueue: Fixes for v6.9-rc6

Two doc update patches and the following three fixes:

- On single node systems, the default pool is used but the node_nr_active
  for the default pool was set to min_active. This effectively limited the
  max concurrency of unbound pools on single node systems to 8 causing
  performance regressions on some workloads. Fixed by setting the default
  pool's node_nr_active to max_active.

- wq_update_node_max_active() could trigger divide-by-zero if the
  intersection between the allowed CPUs for an unbound workqueue and online
  CPUs becomes empty.

- When kick_pool() was trying to repatriate a worker to a CPU in its pod by
  setting task->wake_cpu, it didn't consider whether the CPU being selected
  is online or not which obviously can lead to subobtimal behaviors. On
  s390, this triggered a crash in arch code. The workqueue patch removes the
  gross misbehavior but doesn't fix the crash completely as there's a race
  window in which CPUs can go down after wake_cpu is set. Need to decide
  whether the fix should be on the core or arch side.

----------------------------------------------------------------
Audra Mitchell (1):
      Documentation/core-api: Update events_freezable_power references.

Lai Jiangshan (1):
      workqueue: Fix divide error in wq_update_node_max_active()

Sven Schnelle (1):
      workqueue: Fix selection of wake_cpu in kick_pool()

Tejun Heo (1):
      workqueue: The default node_nr_active should have its max set to max_active

Xingyou Chen (1):
      docs/zh_CN: core-api: Update translation of workqueue.rst to 6.9-rc1

 Documentation/core-api/workqueue.rst               |   6 +-
 .../translations/zh_CN/core-api/workqueue.rst      | 398 +++++++++++++++++++--
 kernel/workqueue.c                                 |  19 +-
 3 files changed, 390 insertions(+), 33 deletions(-)

