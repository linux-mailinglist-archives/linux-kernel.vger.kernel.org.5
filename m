Return-Path: <linux-kernel+bounces-54318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311CD84AD9E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 560DE1C21B99
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C257A717;
	Tue,  6 Feb 2024 04:39:30 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F8677F0D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 04:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707194370; cv=none; b=MMTGePwhn8qYmTpChAY241ttXOKMd+c9gHoSdkl3/6OSNEoJfrryipvi6XBgKQPSRpi1PopB9pJfZ02otWJA7X965TrkS4rApT0nWKmOY+b5yo1QERleKsxyeh803svAyuMUamZ05DRMkvmQh8C/hyhG8rbaVfXiOkmYeAymtdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707194370; c=relaxed/simple;
	bh=6mkJTp+YntfTBR22eAXEk5YJrTS3d/+TlyZSgog8VHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+CjIog98GyG+OJAjQZxzFEe3FpaAfc2dfoQSbXm/1pZAM+cVNlQ15fYw6NQCUvZdQpk+625NI1orArIrzlWbvViO44iK5WobT45VF6/kPlIkVMhRLt/PpplZMbxdF6AtQl8HqQP3wj6KSHGz43ED7QCwCfOprDSAPy5jQSyYmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42a31b90edcso28518721cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 20:39:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707194367; x=1707799167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwyA0iOp0hGdi4UEoMdS/esY5ki+GqxLPXq+pqSYOeM=;
        b=eEeDYCzlFvfGcDcmZ/d2lmQuC1im7AiGHSTo+6zrGu4f8Z2HtiKRB8LfAckeafmavM
         U0siuZRXIOvM9/JZlUii0/8MvLbcWygwxEDhiU4l1pSmQQ0pySZqmfU9PdhaHUg+ByfZ
         C0UyKyLq5wAeEalSixkeu19yQhR7v8S6qtvtkWj9aOF6tD1WpWmZ442EXx7qCkGxgzs6
         P34EU51h0FVEMJtRJcyCWmiW97TsbuNZ08C2ZrxUvat/6t4/JpALMGRt0OvtR+LzRd0G
         yZkQW0fZng2/9tmf7f9IhrbToTlnU9tYxGboqyly2fd3Xo5DYGLcwVjcnUjqXP2+flaH
         boyQ==
X-Gm-Message-State: AOJu0Yw0zjKcSsTOEQu2f4dQJVRv7FD8ttmmfKAjD311m5aK/Gy/Z1sv
	j+RaH8/rPzU4KS9qj+5hyDD2Mcktw+Fe3XtJYIYgMfDYPgkWdCeYFWky3Ie5Fn2OGQ==
X-Google-Smtp-Source: AGHT+IEugQDWzGlvkhd0W4cPjrhbDiarfz4oqwttbCzqSNwJqE+K/y9Pnqyj63gWLpW+jmwH7hVDng==
X-Received: by 2002:a05:622a:1a92:b0:42a:a6ed:5440 with SMTP id s18-20020a05622a1a9200b0042aa6ed5440mr1915358qtc.3.1707194367154;
        Mon, 05 Feb 2024 20:39:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUQYkQrg1jQLkKhWe1/10W7B7YSHqfVYXEEYIvRxdpvHy25dCnd14XITuhu+gFuHGAxIsgcC6ZVdscA9v7wNU3xIQ00UQYpkUvi54s4VwYrEohSnnn9HyR0pHp5lVh396m/7yALTspVKEMFVbZewwGSUhhe22ATxjHzOvBbCWhBtVUN3ZeLJ4fL/PCc1H2lwdqg50cWOZHte/fggiX/1IDcGX1dEBYY9ARdKUmCWrKj3pBnOPqH7UaSz4vp5+lBY3MivKqKJ5Ox0eMJPddv3yzfROqvZoV2WfvyO9YTwLsSqbuILXI=
Received: from localhost (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id j25-20020ac874d9000000b0042994b3c20dsm570517qtr.29.2024.02.05.20.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 20:39:26 -0800 (PST)
From: David Vernet <void@manifault.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	bristot@redhat.com,
	vschneid@redhat.com,
	kernel-team@meta.com
Subject: [PATCH v3 1/3] sched/fair: Remove unnecessary goto in update_sd_lb_stats()
Date: Mon,  5 Feb 2024 22:39:19 -0600
Message-ID: <20240206043921.850302-2-void@manifault.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206043921.850302-1-void@manifault.com>
References: <20240206043921.850302-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In update_sd_lb_stats(), when we're iterating over the sched groups that
comprise a sched domain, we're skipping the call to
update_sd_pick_busiest() for the sched group that contains the local /
destination CPU. We use a goto to skip the call, but we could just as
easily check !local_group, as there's no other logic that we need to
skip with the goto. Let's remove the goto, and check for !local_group in
the if statement instead.

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/sched/fair.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b803030c3a03..e7519ea434b1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10578,16 +10578,11 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 		update_sg_lb_stats(env, sds, sg, sgs, &sg_status);
 
-		if (local_group)
-			goto next_group;
-
-
-		if (update_sd_pick_busiest(env, sds, sg, sgs)) {
+		if (!local_group && update_sd_pick_busiest(env, sds, sg, sgs)) {
 			sds->busiest = sg;
 			sds->busiest_stat = *sgs;
 		}
 
-next_group:
 		/* Now, start updating sd_lb_stats */
 		sds->total_load += sgs->group_load;
 		sds->total_capacity += sgs->group_capacity;
-- 
2.43.0


