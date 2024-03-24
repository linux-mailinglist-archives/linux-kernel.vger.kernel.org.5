Return-Path: <linux-kernel+bounces-112534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A359887B3E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 01:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655E21C216E7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 00:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4C76ABF;
	Sun, 24 Mar 2024 00:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="TkDJjbB7"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F01110F7
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 00:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711241181; cv=none; b=Z6mDONR5NfSvARz+UOlbaF9SH8dmwo6iJfJNdXOPbUvNEfPb+tSmJ6lsxsjZKB4WeaXkiC8H9jsssGF0auXAPzId/OY3INIY2m4jejQrFuydYz1xSokpjCmwmLeXOlU7BwPpVnnk4wi5/eg78fxSj+HRZOP7kQaQ9+ld7BFBwdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711241181; c=relaxed/simple;
	bh=vUXbbl8Gs+LBXu8bh5D8UeeeidKdQZUSJAtT8+qGjLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HC3agNH8/7S9dOlTkH/f5bqoshSUCcdF/XnqfUg5/zDk+LZC4NBPHjhm5nZCiG4kKz6A3ZnnEFPO6wcy7nFwgRGEwP4wel5Hzt6zXvKOotLW7P/N4/qzxet8asloI4VmKv9Brcz52duUYHEqqqatzBOoVTD+FRWrzJT0VBrcnPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=TkDJjbB7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-414811d8241so3896105e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 17:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1711241178; x=1711845978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fgqiNts6+Cbc6tMllJTEWHDx0DYaBorRTxJ4SzU6S4=;
        b=TkDJjbB7tJoly+89mTTFXvxXmTqPTmoCOL+bZSNTUvtaEe+mfXzxeCVvkF+ZQajP6V
         vaMZPXUFH34QbE3aU4fa6QO6jYO6lvWvOjF7vTxVeAbTniWruysTnmvxzBIq3q8HRQIe
         lSHKEBcAej+WYnO8SjD0K35OTEtul3+wcDRbP6lDtAuvEkKCSaTYENSXqVUtLMH+oJwN
         PixioLrQuxL3ij0S9Vp+kd5g5UkY7hukP9ZdtLbWCYZm++IOQi1iAq6UqcdGPryISQ/L
         vH3me5nREPOF3rkY4tXlTDyEtz7DLnGrjrwvM2fgKpJ/Sl1pxxbAhuU8xwYE8yOYGULO
         0Aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711241178; x=1711845978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fgqiNts6+Cbc6tMllJTEWHDx0DYaBorRTxJ4SzU6S4=;
        b=kAMh+Lldkw24hSBKahtRKiHOasXmei+owuz2E0LG0iKvhbr3dvGQOz4w+FUVRinWHl
         Pb+8YrlvwQ7P9C5ECOT9jFs7voVeFRWP2rpJ6z1cKDb+LZmnWxWtfi5BYPO7sZTah3qY
         c6YsYdUEEvb6g+2RYjnzpMG+e0L9tLq7HienFRHdC0+ykRVzguHy+vx0NWzTlCcJWpri
         jhvtd6xc26BMid9BMrjVwCSIzhhF4xPIYSbCqcIJt57HXcHxZa0LzpUmgZTRjmWw5xc3
         Gb5bcnzvxLox5NvdgY7+jCWa3Li7M/UDS0GLdjy2+EP5SslrUwOubVCp8VEAnOxUYJZv
         yJgA==
X-Gm-Message-State: AOJu0YzYbm130ZCs+wJjOaRVcZEu7y38GzgLF5pB5l5dCAha2uYMLLFs
	SVgCDBYL3ozdoapnCDtujTsOis3rP8f14gB60TtZKhSpVo2NB4ORZGC6jQ1/j+c=
X-Google-Smtp-Source: AGHT+IGUfW60lgVTsTKE1PBsEQ5OHEGDLD8qcl3Z2wM+u1m2H1+SFTIWIdFFfx4nyQnfbjnbw7Tuhg==
X-Received: by 2002:a05:600c:20d4:b0:413:f75f:98b6 with SMTP id y20-20020a05600c20d400b00413f75f98b6mr2491841wmm.26.1711241178542;
        Sat, 23 Mar 2024 17:46:18 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c354600b00414674a1a40sm3778179wmq.45.2024.03.23.17.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 17:46:18 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	"Pierre Gondois" <Pierre.Gondois@arm.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v8 4/4] sched/fair: Don't double balance_interval for migrate_misfit
Date: Sun, 24 Mar 2024 00:45:52 +0000
Message-Id: <20240324004552.999936-5-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240324004552.999936-1-qyousef@layalina.io>
References: <20240324004552.999936-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is not necessarily an indication of the system being busy and
requires a backoff of the load balancer activities. But pushing it high
could mean generally delaying other misfit activities or other type of
imbalances.

Also don't pollute nr_balance_failed because of misfit failures. The
value is used for enabling cache hot migration and in migrate_util/load
types. None of which should be impacted (skewed) by misfit failures.

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/fair.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3b88cf58fb45..18da54da48a5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11443,8 +11443,12 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 		 * We do not want newidle balance, which can be very
 		 * frequent, pollute the failure counter causing
 		 * excessive cache_hot migrations and active balances.
+		 *
+		 * Similarly for migration_misfit which is not related to
+		 * load/util migration, don't pollute nr_balance_failed.
 		 */
-		if (idle != CPU_NEWLY_IDLE)
+		if (idle != CPU_NEWLY_IDLE &&
+		    env.migration_type != migrate_misfit)
 			sd->nr_balance_failed++;
 
 		if (need_active_balance(&env)) {
@@ -11527,8 +11531,13 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 	 * repeatedly reach this code, which would lead to balance_interval
 	 * skyrocketing in a short amount of time. Skip the balance_interval
 	 * increase logic to avoid that.
+	 *
+	 * Similarly misfit migration which is not necessarily an indication of
+	 * the system being busy and requires lb to backoff to let it settle
+	 * down.
 	 */
-	if (env.idle == CPU_NEWLY_IDLE)
+	if (env.idle == CPU_NEWLY_IDLE ||
+	    env.migration_type == migrate_misfit)
 		goto out;
 
 	/* tune up the balancing interval */
-- 
2.34.1


