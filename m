Return-Path: <linux-kernel+bounces-119699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F63888CC32
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4133F1F82E58
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD632130AC3;
	Tue, 26 Mar 2024 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddFcMbqz"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E49128839
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478725; cv=none; b=ISZKDfQ5vdgI6J34IdRgsCTYeIQoEPaFL+HTaOAeeQ0PmpqA65+7HcoJBRMOErsIc5LS0jwz67TPmYNXTPxIY/kLqU/NGxoqaXhIgpuG3ZMXr+yWRMnJMMKUH3G4Kifc9E8KxsmH4ZQgKablZMqjd7MVT6Pdiz8wXPDOu2cMxwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478725; c=relaxed/simple;
	bh=UTcTbnVlp+R3j/QcQGkv7iwPOMks4xnt+av9k0W3BCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L7jESKH7m82mLnbLXOnWVioMfypsgr6hVjR21TlzVqIxulTMqhMYJwFYGI/PaNyNrkpIlbiCgDOj3Y4LQlHaubvyYfgROvLdac34bqSG0/2H8obK8eXPNvJT4M5An6sKGedUY7pslmRC3K3ClzSfIUh8cTgFWHiXSsLumoz9M6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddFcMbqz; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513edc88d3cso6498226e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711478721; x=1712083521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mh9owPDgvrpePnVPwpPSO32CUGQbXuA10ztokdq6Ehs=;
        b=ddFcMbqzzK8MTuLysC1uCsmsVVHKY+5bRsbdYfdrjJCyGsuJqNqsW+QKHNP1L6Ogoz
         9z/uXhs48g4bX9FwZQuKFCzwa5X+mPYETjcFb5SLq8ODOdr8Qx/UkrxHoYzPxMPMZwPh
         Atc1RKaVSnGNA24BNPE8FrSkQj21KD8NjhEbZxcYu7Bwu0OSERsyy6cBZD6V5hDJcl7u
         IEHQCeMd/6RXtywT3m04uh+47u97diw3mTw5zkkTJrbH8Z+bfMKzRWT0hJBL698yZcup
         2ApYQ8/LZyO4xjYrh3DJDNIV63rFLs5uXwrBANhNHT/iDr0S6e2PW23Cbkaue5/NNbft
         pPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711478721; x=1712083521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mh9owPDgvrpePnVPwpPSO32CUGQbXuA10ztokdq6Ehs=;
        b=j4MUVQdtNWUA1V4TgQIMxH75ztgGBziU5K8wT+CXKpHo9f9jHB90Z8TIaUUrGpZBBs
         tnTUZjUrIuqZY4FTKTfoXGppPLEWzFjMdIRxYwmBLKSyKQTqrimZfUcOQRt/58ehvGGa
         SQcLJG3z0XJPJQsdMZK4TaVsp/Kc2hjJQ2UMKHkhKAelK8BfqtG6cxF/RCj0/SEB35lh
         /30hACKZva6BGBvN/VjP1t0HbpBxoWKspkjpdZ/s1q0rdS5Tg6rCjJ/94OxpnqidjKvN
         Y8GnhV1DEc4RjMs8lpzk3rxKFuB16107CdGsO8rHMolm6KRYwykbx5cNsxsubwGJMQKC
         x7rQ==
X-Gm-Message-State: AOJu0YzjbPAfzQvXiQrkNvdKupjVhJQ8cDHrcMnveMsG3Wf+S4QKnx5L
	L88SzQGzuK7Xt73mJq0b1jjr6FQxYZSZWCj4qret8/G4A+gR/ZejRYBcJ11W
X-Google-Smtp-Source: AGHT+IHD/8heNbsdXaJipM0kXisQgw+5ZdCc51difvdkiqu8M9bgiE0Rojmy+5njizVI12cv1HxGRg==
X-Received: by 2002:ac2:4e84:0:b0:513:a732:4878 with SMTP id o4-20020ac24e84000000b00513a7324878mr1710436lfr.41.1711478720883;
        Tue, 26 Mar 2024 11:45:20 -0700 (PDT)
Received: from localhost.localdomain (109-252-14-191.nat.spd-mgts.ru. [109.252.14.191])
        by smtp.gmail.com with ESMTPSA id c42-20020a05651223aa00b00515ac42651dsm942595lfv.257.2024.03.26.11.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 11:45:20 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: linux-kernel@vger.kernel.org
Cc: maximmosk4@gmail.com,
	Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
Subject: [PATCH 0/8] kernel: replace seq_puts by seq_putc
Date: Tue, 26 Mar 2024 21:45:14 +0300
Message-Id: <20240326184514.8478-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using seq_putc for single characters is faster and more appropriate
than seq_puts, since only one character is passed and there is no need
to use a more powerful and less fast function.

Maxim Moskalets (8):
  bpf: replace seq_puts by seq_putc
  cgroup: replace seq_puts by seq_putc
  trace: replace seq_puts by seq_putc
  module: replace seq_puts by seq_putc
  sched: replace seq_puts by seq_putc
  locking: replace seq_puts by seq_putc
  time: replace seq_puts by seq_putc
  kernel: replace seq_puts by seq_putc

 kernel/bpf/arraymap.c            |  6 +++---
 kernel/bpf/bpf_struct_ops.c      |  2 +-
 kernel/bpf/hashtab.c             |  4 ++--
 kernel/bpf/local_storage.c       |  4 ++--
 kernel/cgroup/cgroup.c           |  2 +-
 kernel/cgroup/debug.c            |  6 +++---
 kernel/latencytop.c              |  2 +-
 kernel/locking/lockdep_proc.c    | 24 ++++++++++++------------
 kernel/module/procfs.c           |  4 ++--
 kernel/module/tracking.c         |  2 +-
 kernel/sched/cpuacct.c           |  4 ++--
 kernel/sched/debug.c             | 14 +++++++-------
 kernel/time/test_udelay.c        |  2 +-
 kernel/trace/trace_events_hist.c | 26 +++++++++++++-------------
 kernel/trace/trace_events_user.c |  8 ++++----
 kernel/trace/trace_hwlat.c       |  4 ++--
 16 files changed, 57 insertions(+), 57 deletions(-)


base-commit: 928a87efa42302a23bb9554be081a28058495f22
-- 
2.39.2


