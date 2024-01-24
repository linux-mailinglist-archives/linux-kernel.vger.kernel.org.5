Return-Path: <linux-kernel+bounces-37845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4291183B65F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D8E2870FE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BB7136F;
	Thu, 25 Jan 2024 01:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcnyGSn3"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BCF17C2;
	Thu, 25 Jan 2024 01:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706144782; cv=none; b=kMCdUM3IHjpt4aPBrZxSN5l6F97LqkaJsg+CsCiAsuQJR1Soz2uIkyGIPvvfzsAxTobxDm1POnupL00+2MyM4EzmDjl+GYsW8cEP0a62HPVd1sXJf0ycKVpKFRdPdWnnMq5xQZz8516L+exWWDWLOSaRrSb6YzDrcHUuCpvhqf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706144782; c=relaxed/simple;
	bh=QGkpXTK0YyeELiD+mxIURwgFUQzDyoQBb1doo1frbsk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iOVZe8iqpJozV7TdLmzqIjM0eg3wE1LVXwPWhnTg07Z7IVRjqawkg7R9y4qRwuhZ5U35tHvH1ifdg3z2g6YQT8eeFwbfBSBVojLQuv+jrAWdW1usUD4NQCqY17sHkNDshPDxKgyNOJt/Ztfdic3T3SPucnX5l1BAuxagaDCkjzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcnyGSn3; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bba50cd318so5736537b6e.0;
        Wed, 24 Jan 2024 17:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706144780; x=1706749580; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pU3f4QgLLBF3NnF4D7mve2JIYRwJ7D0KVAeRwEFC/iQ=;
        b=PcnyGSn3ABTlYaxLFkAMDNPThQdu/iEUI0kYfNu3DhBZX45bBABYxXi359O5PW1YOY
         DzfWgdHrQ7VetORwNCeMYdkqjfvr6jBcW6oriYl0QN+BPgr4Dohs51NdOxA4a5No9hsq
         O5xtgngPIr7L6Xhbd6EetdSVqwQNzdXuDeZa15fMZJchWQ/psw0DKmLl4VDLblhAMXox
         iN2utAla5j+nXhwFL4oMhbaNvOtC/dZLO7y1HHNkjOYRF7vty/cWx20dD0LDDb5U+IrM
         TbumONxkrmQ2HhbOxxZIafxQFRcOL5Um1wlWcPBbL+5rG+f3A0ubI5Nc5xHTuJtCuW/G
         /2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706144780; x=1706749580;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pU3f4QgLLBF3NnF4D7mve2JIYRwJ7D0KVAeRwEFC/iQ=;
        b=BkHZFEYOp3x8S7Wvx/xgDbY/YqUM/irfW6F+5t6rkV7bDe+HUiE6n2RuBmBMExhaRc
         pTOjQyevtUPLxqg+rQVuGmvVT/dQ18OMTP5uG61UeforuFVS9X5yubPQBY+FmpSu6VhM
         u6HfYI2jOOmlP5KoLDDi/l/lWA3UMw1ZPfPzApUv6wK+q0Y2xvnqQXF/4Cg6m55i5uAG
         67huzN9zeKMuc2BUeMlSgPOonxOKbYNUpq3z9iD0lvMFTwbyTrdMoVPBdpBKcervQZDf
         /j9zfHXI4fbT/CAutljDm7w+qeDv2JnLZXDCpLe7caXZc6/+OD+TzcnsjhnUENbu8fnC
         eYzQ==
X-Gm-Message-State: AOJu0YxZjTKTV0RHrNoP/JHRzVZ5pWKzZINocd8ROU6tBs4JxoKeGQy/
	sd7LdT+ttJkapzfIN1nNhzxdmiJQf8YCFLSwk74OS4XqXz/bD+H6
X-Google-Smtp-Source: AGHT+IG2VSKyIRKwfDfha6pNK+8ZT5g+txMJWsLrFSAGKCQeQ7dpReQmvty2ibIYXCOeyhECLnzLTw==
X-Received: by 2002:a05:6808:3c8f:b0:3bd:2de0:e96e with SMTP id gs15-20020a0568083c8f00b003bd2de0e96emr173993oib.84.1706144779748;
        Wed, 24 Jan 2024 17:06:19 -0800 (PST)
Received: from neeraj.linux ([101.0.62.229])
        by smtp.gmail.com with ESMTPSA id m18-20020a635812000000b005c21943d571sm12343867pgb.55.2024.01.24.17.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 17:06:19 -0800 (PST)
Date: Thu, 25 Jan 2024 04:13:19 +0530
From: "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, paulmck@kernel.org,
	mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org,
	frederic@kernel.org, boqun.feng@gmail.com, joel@joelfernandes.org,
	neeraj.upadhyay@amd.com, urezki@gmail.com,
	qiang.zhang1211@gmail.com
Subject: [GIT PULL] RCU regression fix for v6.8
Message-ID: <20240124224319.GA36728@neeraj.linux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://github.com/neeraju/linux.git tags/urgent-rcu.2024.01.24a

for you to fetch changes up to e787644caf7628ad3269c1fbd321c3255cf51710:

  rcu: Defer RCU kthreads wakeup when CPU is dying (2024-01-24 22:46:17 +0530)

----------------------------------------------------------------
Urgent RCU pull request for v6.8

This commit fixes RCU grace period stalls, which are observed when
an outgoing CPU's quiescent state reporting results in wakeup of
one of the grace period kthreads, to complete the grace period. If
those kthreads have SCHED_FIFO policy, the wake up can indirectly
arm the RT bandwith timer to the local offline CPU. Earlier migration
of the hrtimers from the CPU introduced in commit 5c0930ccaad5
("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
results in this timer getting ignored. If the RCU grace period
kthreads are waiting for RT bandwidth to be available, they may
never be actually scheduled, resulting in RCU stall warnings.

----------------------------------------------------------------
Frederic Weisbecker (1):
      rcu: Defer RCU kthreads wakeup when CPU is dying

 kernel/rcu/tree.c     | 34 +++++++++++++++++++++++++++++++++-
 kernel/rcu/tree_exp.h |  3 +--
 2 files changed, 34 insertions(+), 3 deletions(-)

