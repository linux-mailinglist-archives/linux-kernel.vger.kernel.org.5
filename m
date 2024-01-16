Return-Path: <linux-kernel+bounces-27567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD1082F24D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865591C2334B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9A51CABF;
	Tue, 16 Jan 2024 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBFXv5r8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F41C1CABA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705422003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s4fKpZjH++WRt1yV+Gjohw4fqgWgBKev/a1YdUdJYkI=;
	b=jBFXv5r8MedtjrQPeaqHWEe9Vb/TkhenEG7x+7BodPLIPXvZQ/2MoPljCAn9rRueCrnaaM
	NNVcFc/qDJ6haExEC2tH8sJZNoQ7dzCKnrQYirMpFU/5OSTKi+gzXAcv/vLDLW3UXcYGzH
	gvCQps7e6RFTyBaBu/ukzuHEHiBfNxk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-LmG8ySuHOSyhu9_A6-SC9Q-1; Tue, 16 Jan 2024 11:19:58 -0500
X-MC-Unique: LmG8ySuHOSyhu9_A6-SC9Q-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7831bc14ae3so1385270485a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 08:19:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705421998; x=1706026798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4fKpZjH++WRt1yV+Gjohw4fqgWgBKev/a1YdUdJYkI=;
        b=Ntlcsmxq6fK2ImFMM9kNTlb9YicO0gG9746E0qftEaVDdsKUjYs3pAvSdAThtvJ0Lw
         OsXgSb9//0mpIgsfVumtHFT3Z6ZpwjtfNXhTBtJEx6jCktBJxuuDgu7Sf9SAP5OM1SLD
         peKeI5FJIOF8rtA2BoCG9yh18SGh6izz0kxZbgth2CrhjuVDTvERjVwO2aHgEzpCTKOi
         t2mx6fo7l6hTYdT0Gg4HzWSqpjSZ25GIbneISEwD9gS5mPKhfh0+n2BmyT9QP9JaVoOZ
         Oo28uHFtldJucmBkePc4a/3JYXuMX+1DToxdNM4c98AN52JUQpBhLLSPuARWi7GblSb7
         zvBw==
X-Gm-Message-State: AOJu0YzoZlLoVaUFaQlYXa/iTYiJhmDTFzu4yStDxQbQ0yUy16LuVhpR
	YDvKGX8HsZuMgmBQENivOU4Hz7a7otOc4CbAUnSHp1Eh66LuouKuCJ00UGhNbillYCYMC499Zz9
	FtJP+bCoZ6vzBj2dHnTnMLH5GXcifPns2
X-Received: by 2002:a05:620a:4799:b0:783:6831:70e3 with SMTP id dt25-20020a05620a479900b00783683170e3mr1526837qkb.142.1705421998034;
        Tue, 16 Jan 2024 08:19:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfvBnkVAtZ2Jphu3jrtv5vN7HiReIm0sHIuWvD2e6l2twauc9cYUcfmc4OQlMLPLEBZ9Z/aw==
X-Received: by 2002:a05:620a:4799:b0:783:6831:70e3 with SMTP id dt25-20020a05620a479900b00783683170e3mr1526825qkb.142.1705421997769;
        Tue, 16 Jan 2024 08:19:57 -0800 (PST)
Received: from localhost.localdomain ([151.29.130.8])
        by smtp.gmail.com with ESMTPSA id fd10-20020a05622a4d0a00b00429d3257dd6sm3809166qtb.45.2024.01.16.08.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 08:19:57 -0800 (PST)
From: Juri Lelli <juri.lelli@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/4] kernel/workqueue: Distinguish between general unbound and WQ_SYSFS cpumask changes
Date: Tue, 16 Jan 2024 17:19:28 +0100
Message-ID: <20240116161929.232885-4-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116161929.232885-1-juri.lelli@redhat.com>
References: <20240116161929.232885-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both general unbound cpumask and per-wq (WQ_SYSFS) cpumask changes end
up calling apply_wqattrs_prepare for preparing for the change, but this
doesn't work well for general unbound cpumask changes as current
implementation won't be looking at the new unbound_cpumask.

Fix the prepare phase for general unbound cpumask changes by checking
which type of attributes (general vs. WQ_SYSFS) are actually changing.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/workqueue.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 3a1d5a67bd66a..2ef6573909070 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4359,7 +4359,17 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 	 * it even if we don't use it immediately.
 	 */
 	copy_workqueue_attrs(new_attrs, attrs);
-	wqattrs_actualize_cpumask(new_attrs, unbound_cpumask);
+
+	/*
+	 * Is the user changing the general unbound_cpumask or is this a
+	 * WQ_SYSFS cpumask change?
+	 */
+	if (attrs == wq->unbound_attrs)
+		cpumask_copy(new_attrs->cpumask, unbound_cpumask);
+	else
+		wqattrs_actualize_cpumask(new_attrs, unbound_cpumask);
+
+	cpumask_and(new_attrs->cpumask, new_attrs->cpumask, cpu_possible_mask);
 	cpumask_copy(new_attrs->__pod_cpumask, new_attrs->cpumask);
 	ctx->dfl_pwq = alloc_unbound_pwq(wq, new_attrs);
 	if (!ctx->dfl_pwq)
@@ -4377,12 +4387,7 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 		}
 	}
 
-	/* save the user configured attrs and sanitize it. */
-	copy_workqueue_attrs(new_attrs, attrs);
-	cpumask_and(new_attrs->cpumask, new_attrs->cpumask, cpu_possible_mask);
-	cpumask_copy(new_attrs->__pod_cpumask, new_attrs->cpumask);
 	ctx->attrs = new_attrs;
-
 	ctx->wq = wq;
 	return ctx;
 
-- 
2.43.0


