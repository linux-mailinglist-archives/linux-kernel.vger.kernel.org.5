Return-Path: <linux-kernel+bounces-27569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBF182F24F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A057E1F246FB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8F31CD2B;
	Tue, 16 Jan 2024 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOYT6YOv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A51CA84
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705422005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MbtUeDj38iJv40DVhrJMpGto1LA7FQWBcqkGB+BZKUs=;
	b=AOYT6YOviBP7jy2mIIfB8ea/NYN4hKFi3nm14vrSBPgEROGbnJ0diDl17TLo7XsKbWxtaC
	3pt1wNq83asZsNgjEOIsM0pYysgWeUrCXWe+tG097ECmKlVVHMw3HlJTDrJi/1qdo6e09Z
	51OKKtkZmmat0VWgrr6bBPWLqR9+7Ys=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-5PMRCyo6M4SSjR1tL74EVg-1; Tue, 16 Jan 2024 11:20:03 -0500
X-MC-Unique: 5PMRCyo6M4SSjR1tL74EVg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-429a7149210so81107851cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 08:20:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705422002; x=1706026802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbtUeDj38iJv40DVhrJMpGto1LA7FQWBcqkGB+BZKUs=;
        b=FinF9XLiZDykhiViPj6zHY9xdJdUmYZd8TNOM6O04I1JiaYmyg+IVQjWXC1ptryDS5
         2+ipEnHTxPQutfx7/IF3R7iHXa+S73nXIyubKSLvDPJc0ugctVN7TtXI2rde2E+iv+Ix
         OXB8g/mF82SZxuPczpjhFoZ2I6VLIA+ihpMnWU3bsWxI6nOHdnVQQba2/s0C47LWZ4gL
         uH3i0A9s4qJSwnPpDtvua3EgtVrsaTd77naywYkEJtkuZKYP0bzfs8Sk2WuOWqPiNQt2
         djbm0TLRcf2iOba8pEY49lBaP+XZzcvGxXzwUJGarM/urRxK1RednGQA03DdFOKjXh6K
         6T9g==
X-Gm-Message-State: AOJu0YzWFj3JoFdXEbu8S1hCzsq+q60Rkcg1H8pi+USOAnpNJbMew3ta
	BO5fMnFOIjyjxyDvTuvXl1WNw3IO2NPSRAl0C3onG5PL8lC0eYnvN66AB76T8Ld2L8cL18wivWN
	LnJ0JaKK0zHnNMUzur094ysoSitCGWit8
X-Received: by 2002:a05:622a:120e:b0:429:ca1c:7fd3 with SMTP id y14-20020a05622a120e00b00429ca1c7fd3mr9264966qtx.68.1705422001906;
        Tue, 16 Jan 2024 08:20:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9R1aebixv/ciTPAg3ClvPL1gJzS0rEYYqB1UFPQV8ctoXJFXmhPVpDFtnkiOQTk9BxOtLqQ==
X-Received: by 2002:a05:622a:120e:b0:429:ca1c:7fd3 with SMTP id y14-20020a05622a120e00b00429ca1c7fd3mr9264959qtx.68.1705422001616;
        Tue, 16 Jan 2024 08:20:01 -0800 (PST)
Received: from localhost.localdomain ([151.29.130.8])
        by smtp.gmail.com with ESMTPSA id fd10-20020a05622a4d0a00b00429d3257dd6sm3809166qtb.45.2024.01.16.08.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 08:19:59 -0800 (PST)
From: Juri Lelli <juri.lelli@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/4] kernel/workqueue: Let rescuers follow unbound wq cpumask changes
Date: Tue, 16 Jan 2024 17:19:29 +0100
Message-ID: <20240116161929.232885-5-juri.lelli@redhat.com>
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

When workqueue cpumask changes are committed the associated rescuer (if
one exists) affinity is not touched and this might be a problem down the
line for isolated setups.

Make sure rescuers affinity is updated every time a workqueue cpumask
changes, so that rescuers can't break isolation.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/workqueue.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 2ef6573909070..df7f2f2bfd0c8 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4416,6 +4416,12 @@ static void apply_wqattrs_commit(struct apply_wqattrs_ctx *ctx)
 	link_pwq(ctx->dfl_pwq);
 	swap(ctx->wq->dfl_pwq, ctx->dfl_pwq);
 
+	/* rescuer needs to respect wq cpumask changes */
+	if (ctx->wq->rescuer) {
+		set_cpus_allowed_ptr(ctx->wq->rescuer->task, ctx->attrs->cpumask);
+		wake_up_process(ctx->wq->rescuer->task);
+	}
+
 	mutex_unlock(&ctx->wq->mutex);
 }
 
-- 
2.43.0


