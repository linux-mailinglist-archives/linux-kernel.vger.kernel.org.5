Return-Path: <linux-kernel+bounces-16916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A276F824616
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABFBFB2439D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA3624B5D;
	Thu,  4 Jan 2024 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMd58W7J"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C440924B49;
	Thu,  4 Jan 2024 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e67e37661so811781e87.0;
        Thu, 04 Jan 2024 08:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704385514; x=1704990314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpThbVK+EHg0y73bO5YQ7HaoVEC/GNzVDKQvQ4+QTxY=;
        b=FMd58W7J/i+rc38UXDQsnDOFNandgto3z85/HTBFlrD71y64boid/LkPV8TSHmrGhV
         w8ksaXPguwnpSU8uj6j9NqAqp8ducSqTO/+Ta5fGCTTxn381sRlVpC2QFhaF8MTOLZdX
         BLIv1Zo+34NfQ1CxM/nXKAHPCxcXBF52Ck1qxIX0eqU1mp98p27KUlKbqoCVRM2K51QH
         HdZ04iHkH2GzM91MXmRBzeZnXx0wdN4JDEZS+lxHu72LzlO3T+d8/9bMmkFKPF3esbwv
         FblM2oQ2440cE6Neq6zDUrCIr3NiIsZjIODxcAfJs9kbGo7jnwNeInlsqKx9E089d3sw
         yeqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704385514; x=1704990314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZpThbVK+EHg0y73bO5YQ7HaoVEC/GNzVDKQvQ4+QTxY=;
        b=T6cirv2pD6PddUiwSPnv5RYsWa/pVQUaJTHEykZ85LJLchQZt79ax4pZoLzEd0HKMY
         gs6STp+MKWwGbTs+CGQFDo7yM4ha3tHXsCJbdwv34KUP9OLX1ML/JMxwpwb0kIV8NKH8
         oiVf8kEhfw/uDYYakzp4z89gLP2TNfmBgjgX19RDXDxyXDILQStiohdIwiOboZ89Fm2U
         LPloPAd3MY9ildqC2H32x/15NGxWWN+O6Zzov7CMJLtiX092atxmVHvb2+/sYEai76UD
         8DRWVwqXKQ7Ls8d7veQ9FLN+Gkmlx/wIcieZ+vpK/DwM5ePFwHGp/ApsQHVke43/ExMy
         P/3g==
X-Gm-Message-State: AOJu0YwRiX5uP0MB1w7DrM8nx6xxdyo3vSM3Q2ZCll5CQyri/KD0M3EM
	v5MUkOFrFPDPTGTtk6mOrSg=
X-Google-Smtp-Source: AGHT+IHlCXsK7xHZInnuuMHqfaautsarvfIaV9qShCgrOsFhsN1fsjCXghJ1x2DStzgGLib6zeBBMA==
X-Received: by 2002:a05:6512:400d:b0:50e:7b5e:b650 with SMTP id br13-20020a056512400d00b0050e7b5eb650mr533131lfb.31.1704385513501;
        Thu, 04 Jan 2024 08:25:13 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id i5-20020a0565123e0500b0050e80d1e142sm2789252lfv.170.2024.01.04.08.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 08:25:13 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v4 0/4] Reduce synchronize_rcu() latency(v4)
Date: Thu,  4 Jan 2024 17:25:06 +0100
Message-Id: <20240104162510.72773-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a v4 that tends to improve synchronize_rcu() call. To be more
specific it is about reducing a waiting time(especially worst cases)
of caller that blocks until a grace period is elapsed. 

In general, this series separates synchronize_rcu() callers from other
callbacks. We keep a dedicated an independent queue, thus the processing
of it starts as soon as grace period is over, so there is no need to wait
until other callbacks are processed one by one. Please note, a number of
callbacks can be 10K, 20K, 60K and so on. That is why this series maintain
a separate track for this call that blocks a context.

v3 -> v4:
 - Squash patches;
 - Add more description;
 - Fix comments based on v3 feedback.

v3: https://lore.kernel.org/lkml/cd45b0b5-f86b-43fb-a5f3-47d340cd4f9f@paulmck-laptop/T/
v2: https://lore.kernel.org/all/20231030131254.488186-1-urezki@gmail.com/T/
v1: https://lore.kernel.org/lkml/20231025140915.590390-1-urezki@gmail.com/T/

Neeraj Upadhyay (1):
  rcu: Improve handling of synchronize_rcu() users

Uladzislau Rezki (Sony) (3):
  rcu: Reduce synchronize_rcu() latency
  rcu: Add a trace event for synchronize_rcu_normal()
  rcu: Support direct wake-up of synchronize_rcu() users

 .../admin-guide/kernel-parameters.txt         |  14 +
 include/trace/events/rcu.h                    |  27 ++
 kernel/rcu/Kconfig.debug                      |  12 +
 kernel/rcu/tree.c                             | 361 +++++++++++++++++-
 kernel/rcu/tree.h                             |  19 +
 kernel/rcu/tree_exp.h                         |   2 +-
 6 files changed, 433 insertions(+), 2 deletions(-)

-- 
2.39.2


