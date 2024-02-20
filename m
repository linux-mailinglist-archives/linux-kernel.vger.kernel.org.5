Return-Path: <linux-kernel+bounces-73784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE65A85CB32
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4617BB22708
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC700154433;
	Tue, 20 Feb 2024 22:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="mJyJbkXJ"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BEA69D10
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708469799; cv=none; b=j2dFxC5/h42IEok3907QboGPAuUgZIcX/P0DvzierdppmVEakqYVO6mMOHjFMiBqDceLPs7g6mAmuRFbBTMFcHPu6LSigVQrMOMxJocTPd9Sgs3msocZ9KoqsXUl5KHa+Ay+HLYZFPodKdZM1ZHtwC10RULt3bsWd709KSjhshg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708469799; c=relaxed/simple;
	bh=ESIIGkAxFVmz8aZFqUtrXsIIwRpegfBax+DZH3x5Jkc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TS3wyQlQImrNHLnjc09UZdoq0QlcmiEzXuEMaOdPKIIKKK0B1KkhZUwNGGEpFTEGF2a2m+BFd/2Japlq3NO4LYUNTK2yI/2nZn+Y7cE5sMCYodKeVZxgPJ4HXjor0Ij3US8GNLBvK3wBxU+PwNTylkj5Nq0kLCakxWRKJxr1dpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=mJyJbkXJ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3e87b2de41so267798566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1708469795; x=1709074595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iHb+hTJmKe22yutOBTSZnGZN2hn9i5iDOLgqAiudVmM=;
        b=mJyJbkXJ/31vXTQEv0Kqzk6G9ZuGhNloS4qnKN4WtNo0MO8jiY4Awa5AQEiLnYyJxE
         WMfgDAKXw+YOjeag7fptpGr1T5S6hw/Lbnr6cYFAOXyQzfdvd0ocLbnmWyPaP5rI7YnI
         3+enjWItzNmOsHq/3a5Vf6I1gcHWEs4HIH7rfJETNU+/HHAtdZG3bOjQuWkt8M2XH/IY
         3yYwkEHAw7JapkOtlCxJgHjxvkfLH0bKC88pIVEWuC5MXLQ2tGoT30K0InJHB+T5WcRL
         OToHcIkKIpPHhCcZleKxIMcNVnwtcVF0RDFcY+M8bZHxt8o5dKIQPu9yBqoyI7DmENjm
         Uqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708469795; x=1709074595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iHb+hTJmKe22yutOBTSZnGZN2hn9i5iDOLgqAiudVmM=;
        b=tFF1TG7QL8BiInY3LS9AIh+pvRRuJdVJXf2Ju21p670GHDKTdDY4JHwXMIs0xhbczX
         St2R1AMEw329+8WznPvuaVbysR6j2Y8Id0LaNbbfDCIvhmX5vEzL54rr5YuffH+rhHTx
         PBFj6n/w6DbfuNK+hQgoldcx35lO5RxYHHoS7Ol/lduUo2h4aoyitsSny2ho5Tji+neM
         EcCCkWvHOAQYJThQI8eVKFEht8wKPUkIbog1KfO8iL+Qa+Ig/cTe8lRu3NYEw6KyWjWc
         M5dF6OIUrDX8U7pZI8j0e/XvEzhK9l7E0OB4UQwcs/LAvCwpIUd/xYaMIPmlgbZSj2bA
         K7Xw==
X-Gm-Message-State: AOJu0YwHoXCc7taJARooiBwkwQMt6PFNFZ7pBHsuATCKXQUgReph4EjH
	DHB0lL7vgG7IV+xQ5o2NfgbioBQXO+mJyO3ODR45GfJY03U4U1YkdmbUsyhwLis=
X-Google-Smtp-Source: AGHT+IGhyPb4ZhYVYY8PfL3YNvhOd2Zk1oDX48oXDMPBOJJMryIPWS7xpzGoYy6Ywbs15sxrN247Fw==
X-Received: by 2002:a17:906:f88a:b0:a3e:9ce3:1bb with SMTP id lg10-20020a170906f88a00b00a3e9ce301bbmr4528280ejb.3.1708469794954;
        Tue, 20 Feb 2024 14:56:34 -0800 (PST)
Received: from airbuntu.. (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id vw13-20020a170907a70d00b00a3c5d10bcdbsm4381946ejc.114.2024.02.20.14.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:56:34 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	"Pierre Gondois" <Pierre.Gondois@arm.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v6 0/4] sched: Don't trigger misfit if affinity is restricted
Date: Tue, 20 Feb 2024 22:56:18 +0000
Message-Id: <20240220225622.2626569-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v5:

	* Remove redundant check to rq->rd->max_cpu_capacity
	* Simplify check_misfit_status() further by removing unnecessary checks.
	* Add new patch to remove no longer used rd->max_cpu_capacity
	* Add new patch to prevent misfit lb from polluting balance_interval
	  and nr_balance_failed

Changes since v4:

	* Store max_allowed_capacity in task_struct and populate it when
	  affinity changes to avoid iterating through the capacities list in the
	  fast path (Vincent)
	* Use rq->rd->max_cpu_capacity which is updated after hotplug
	  operations to check biggest allowed capacity in the system.
	* Undo the change to check_misfit_status() and improve the function to
	  avoid similar confusion in the future.
	* Split the patches differently. Export the capacity list and sort it
	  is now patch 1, handling of affinity for misfit detection is patch 2.

Changes since v3:

	* Update commit message of patch 2 to be less verbose

Changes since v2:

	* Convert access of asym_cap_list to be rcu protected
	* Add new patch to sort the list in descending order
	* Move some declarations inside affinity check block
	* Remove now redundant check against max_cpu_capacity in check_misfit_status()

Changes since v1:

	* Use asym_cap_list (thanks Dietmar) to iterate instead of iterating
	  through every cpu which Vincent was concerned about.
	* Use uclamped util to compare with capacity instead of util_fits_cpu()
	  when iterating through capcities (Dietmar).
	* Update commit log with test results to better demonstrate the problem

v1 discussion: https://lore.kernel.org/lkml/20230820203429.568884-1-qyousef@layalina.io/
v2 discussion: https://lore.kernel.org/lkml/20231212154056.626978-1-qyousef@layalina.io/
v3 discussion: https://lore.kernel.org/lkml/20231231175218.510721-1-qyousef@layalina.io/
v4 discussion: https://lore.kernel.org/lkml/20240105222014.1025040-1-qyousef@layalina.io/
v5 discussion: https://lore.kernel.org/lkml/20240205021123.2225933-1-qyousef@layalina.io/

I ended up adding the patch to prevent increasing balance_interval to the
series. The other lb issues discussed in v4 are still pending more debugging.

Thanks!

--
Qais Yousef

Qais Yousef (4):
  sched/topology: Export asym_capacity_list
  sched/fair: Check a task has a fitting cpu when updating misfit
  sched/topology: Remove max_cpu_capacity from root_domain
  sched/fair: Don't double balance_interval for migrate_misfit

 include/linux/sched.h   |  1 +
 init/init_task.c        |  1 +
 kernel/sched/fair.c     | 90 ++++++++++++++++++++++++++++++++---------
 kernel/sched/sched.h    | 16 +++++++-
 kernel/sched/topology.c | 56 +++++++++++++------------
 5 files changed, 113 insertions(+), 51 deletions(-)

-- 
2.34.1


