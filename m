Return-Path: <linux-kernel+bounces-12061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7350581EF8F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03003282829
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458F045976;
	Wed, 27 Dec 2023 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gc3dgyBP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0704596D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so1345090a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 06:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703688585; x=1704293385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZIdcLBe5AtoEgMrZW8B5XtJiAwQZuHkmbazdIfOtJ0=;
        b=gc3dgyBPaPukg07mXkuyXuXi/6QK3hl4RBw/D6GMUHyYjNGr7vrd4/sM0yCn9aLo9Q
         Qp9aT4IkXD88SVNGpxQuG4IsRqK8Pe4yy5j817CI6GvwwxJ5vAFviSakEzTtjIiOPEgD
         arXNIXNqY1FjtLvT2tj5Uh96TZEBXE2xcljKCqSXCunctj8iz2x2t2RnHyKCjhRqcHkp
         0DtvjNmfCJDsureKMEeIvGvIkK1Fpxsl1EphQt8G5peKLu0JU0e9B0bTY+eJJP4HutSu
         dJsFcR3XpzfHEvoxAOlG/vJcCsZxe2ZwEXlat/pZXtAg/9rvxjjkPY+hKmijTAzcw//w
         X6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703688585; x=1704293385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZIdcLBe5AtoEgMrZW8B5XtJiAwQZuHkmbazdIfOtJ0=;
        b=hR5bOFandLeNCGiSuaDdHCVkezYOHRyO7Ljplw/1aPyAU5emm451J429SJdtP14wdi
         9jFMOKd2Q700lMymTBOL28Pu/XFivTh2cSsh1jTErVuVWsa+5St/gQii4scMdnx+KGlO
         mUgooqGxzd+hRuql8m4YO39MVdYA6bmwlOD5NU5xxGOu12Vda3EZmU7qZ4BIDo2hey0t
         0Pejjt73tlTuGb2S7mDnPzhceOkl6/lil+3tgHXqGFG8MsgY08iioAE7+HnDW48SX2xI
         XlFVW4yv2YrqjaQueW5BQdVLWUSJ0bx1aSF+Cg1AcxIlEuc/T0dFSKiRU76Z/+GnBJEg
         YZ3Q==
X-Gm-Message-State: AOJu0YwCqRJ/a+P9hxBiZk6ZADubTPqOJ8y9qTJlSyF3uU9Yjto6NyFV
	7xQWw5OLcaTMrqq7VC5FDBE1l+jNp5g=
X-Google-Smtp-Source: AGHT+IG+CWEYs35r8ECOO6GjjQlw+1c1932pOSzoGAWMTMR/juLSTmGLl/LzjZEDsUxTDx2ZdxjSpw==
X-Received: by 2002:a17:90a:7e96:b0:28b:c10e:2f1e with SMTP id j22-20020a17090a7e9600b0028bc10e2f1emr2562890pjl.23.1703688585192;
        Wed, 27 Dec 2023 06:49:45 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id h12-20020a17090aea8c00b0028c89298d36sm2178718pjz.27.2023.12.27.06.49.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2023 06:49:44 -0800 (PST)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Naohiro.Aota@wdc.com,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 1/7] workqueue: Reuse the default PWQ as much as possible
Date: Wed, 27 Dec 2023 22:51:37 +0800
Message-Id: <20231227145143.2399-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20231227145143.2399-1-jiangshanlai@gmail.com>
References: <20231227145143.2399-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

If the PWQ to be allocated has the same __pod_cpumask as the
default one, just reuse the default one.

No functionality changes intend.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 2989b57e154a..e734625fc8ce 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4270,7 +4270,7 @@ static void wq_calc_pod_cpumask(struct workqueue_attrs *attrs, int cpu,
 	if (cpu_going_down >= 0)
 		cpumask_clear_cpu(cpu_going_down, attrs->__pod_cpumask);
 
-	if (cpumask_empty(attrs->__pod_cpumask)) {
+	if (attrs->ordered || cpumask_empty(attrs->__pod_cpumask)) {
 		cpumask_copy(attrs->__pod_cpumask, attrs->cpumask);
 		return;
 	}
@@ -4360,15 +4360,15 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 		goto out_free;
 
 	for_each_possible_cpu(cpu) {
-		if (new_attrs->ordered) {
+		wq_calc_pod_cpumask(new_attrs, cpu, -1);
+		if (cpumask_equal(new_attrs->cpumask, new_attrs->__pod_cpumask)) {
 			ctx->dfl_pwq->refcnt++;
 			ctx->pwq_tbl[cpu] = ctx->dfl_pwq;
-		} else {
-			wq_calc_pod_cpumask(new_attrs, cpu, -1);
-			ctx->pwq_tbl[cpu] = alloc_unbound_pwq(wq, new_attrs);
-			if (!ctx->pwq_tbl[cpu])
-				goto out_free;
+			continue;
 		}
+		ctx->pwq_tbl[cpu] = alloc_unbound_pwq(wq, new_attrs);
+		if (!ctx->pwq_tbl[cpu])
+			goto out_free;
 	}
 
 	/* save the user configured attrs and sanitize it. */
@@ -4530,6 +4530,8 @@ static void wq_update_pod(struct workqueue_struct *wq, int cpu,
 					lockdep_is_held(&wq_pool_mutex));
 	if (wqattrs_equal(target_attrs, pwq->pool->attrs))
 		return;
+	if (cpumask_equal(target_attrs->cpumask, target_attrs->__pod_cpumask))
+		goto use_dfl_pwq;
 
 	/* create a new pwq */
 	pwq = alloc_unbound_pwq(wq, target_attrs);
-- 
2.19.1.6.gb485710b


