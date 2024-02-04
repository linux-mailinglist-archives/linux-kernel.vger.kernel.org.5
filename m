Return-Path: <linux-kernel+bounces-51426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9E4848B13
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 05:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8576B2565C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353A57465;
	Sun,  4 Feb 2024 04:46:36 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38666FB9
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 04:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707021995; cv=none; b=cE9ePIX5R2r1gwwPOyIXK2ZSuYELslPETMLIXHCzW487ILj4oFeno7Vr7OLGRt5RQHdTP/P0GZcVUvckIxzLtEtvvdtwZXlzUHfHJ9kteLe7VJz+264/hBIz7/+kKsUMJCJdLnwl5He9tpxS+kDCL2y8wS3aNPOTdGaqtW8GNs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707021995; c=relaxed/simple;
	bh=pYurAIAdDs3zqLyccEjZYVhP849U5nz3V7/2Uz0E/kE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PAPd2m8516eyY+/bT40CpXZ19WsBO8M1tf/sjLkbKvodJ9IUs5wN1oeglv6VUeWgQJy9FDpflPVIo6Zr7TtpRObN76a6UCm53kq39BqrLOAfrII+cENpcXCmfVvANjV4gUEKNddhFjnbmeKtwfjiBxDDP1l8aGQZwv7ceSydh7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42bf29aff0dso24196371cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 20:46:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707021992; x=1707626792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=geUmMcTX8p4NRKeidELidreXuEDuXbffq2eplBFLGBM=;
        b=BiO41MWF7dyB+h9XyIgEurt4eQqZhtW3X0LIVoAy9NMTp/JGFhj4G3PG0AMYMTa0OD
         XQL5HodVE25kAEX3V1N0N47z61n3JV1RrDubTYWOw4Ntu712Oab3mll/jX6MtHq2hVEr
         3HOQtnuXmZcAty5WE7dr0OOyMqUqn+352rAsY5DBq1oHpiUwuR0fa6rKlbaLNVXRjPWq
         rfT9w5N3Gr9a/ylNO5vDX7fLYD/8Hg5Qmv/zeQk69Pcd+20/eD22HYcTaPneEigvZPI8
         CJTEVWOKQc1j/Shg2g480sb7mX+DTdhxOcFb6VnVqem09amh1YdROGBwssPmI/thijvD
         b90w==
X-Gm-Message-State: AOJu0YydcbgClOMfEhl5G+LGRWtDV3GTDnlfQoiWxSpbdZkspS3JxJvl
	ga87jzNYp6LLc5nFdg2Pq8jy8yP3B2Qq9Qhh912noOYXDCISM8RhximYGd681q0=
X-Google-Smtp-Source: AGHT+IECA3hDqjyWiTbm6pF4WjZmsJ+loipk3IJd2n85QmBlqNfQ/YyTbxwPJEdO+9GW0IHFrm4fdg==
X-Received: by 2002:ac8:4582:0:b0:42b:ef49:5e07 with SMTP id l2-20020ac84582000000b0042bef495e07mr2933315qtn.46.1707021992461;
        Sat, 03 Feb 2024 20:46:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVdDn8OaVbbUDCJRc/x2ofrtYIWuuJr0iQtTx3w4xPSKMjXMv84Ii7mM75I3UKeAl345Ogw52ElOxpzateVykYX6VvVRAjPEVEyX7LuxbxTr5r7m3b0Xq66GVGt1ouX48sPM1gMOAuQEbw9jJeADWwsp+SOItbuDFMrxIFZxuho2ISewWA6YItWy9Dmf+RAO+QYDKDgNRg31JcIxnRmMngrSla9RNs/GoEDp1khQlJK0PBedTso+bkan/A7ze5Drv8+YnGZL9WJ5vcOiIQ2lYo4xaWYQOaUaQ5Drk6O1csfO3iHFbpaIAp4xgHm4jtNJpSW9RBopyNHCeczVrIkcSaEXx/2E5HaI8uArQ==
Received: from localhost (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id fx12-20020a05622a4acc00b0042a6e6792basm2409321qtb.69.2024.02.03.20.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 20:46:32 -0800 (PST)
From: David Vernet <void@manifault.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	kernel-team@meta.com
Subject: [PATCH v2 0/3] sched/fair: Simplify and optimize update_sd_pick_busiest()
Date: Sat,  3 Feb 2024 22:46:15 -0600
Message-ID: <20240204044618.46100-1-void@manifault.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

update_sd_pick_busiest() (and its caller) has some room for small
optimizations, and some improvements in readability.


- In update_sd_lb_stats(), we're using a goto to skip a single if check.
  Let's remove the goto and just add another condition to the if.

- In update_sd_pick_busiest(), only update a group_misfit_task group to
  be the busiest if it has strictly more load than the current busiest
  task, rather than >= the load.

- When comparing the current struct sched_group with the yet-busiest
  domain in update_sd_pick_busiest(), if the two groups have the same
  group type, we're currently doing a bit of unnecessary work for any
  group >= group_misfit_task. We're comparing the two groups, and then
  returning only if false (the group in question is not the busiest).
  Othewise, we break, do an extra unnecessary conditional check that's
  vacuously false for any group type > group_fully_busy, and then always
  return true. This patch series has us instead simply return directly
  in the switch statement, saving some bytes in load_balance().

---

v1: https://lore.kernel.org/lkml/20240202070216.2238392-1-void@manifault.com/

v1 -> v2 changes:

- Split the patch series into separate patches (Valentin)
- Update the group_misfit_task busiest check to use strict inequality


David Vernet (3):
  sched/fair: Remove unnecessary goto in update_sd_lb_stats()
  sched/fair: Do strict inequality check for busiest misfit task group
  sched/fair: Simplify some logic in update_sd_pick_busiest()

 kernel/sched/fair.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

-- 
2.43.0


