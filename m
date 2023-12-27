Return-Path: <linux-kernel+bounces-12065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 074E581EF93
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B235B1F211D5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FF946B8B;
	Wed, 27 Dec 2023 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHaVO3hL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349484655F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d422c9f894so30418925ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 06:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703688602; x=1704293402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JgQdBp97fYnSauGF41qAWZ2C5akEqSt+yyiFx6LPIY=;
        b=cHaVO3hLRUlKmmjxZcKzlxdAb0fd8WomUt9kUGiEdQIZOtWsAPr9xWW10JZgjThK+V
         X7NCgikZviCJPitmvWoG50SBwP6T8jX5rjLcJnpfZ9Azp7+GxEtPIfOSh+Qy+NNjNc8L
         YHmw/YpjtTlMR8MjV2wK9BgoTBAQxhjX8lMTBFj61u8Ckwxrh0IAmO/1C6+VXDKJ1Rv6
         G/n3432z13SjnYRUz4qL7lRlpTFLx91LGJdZ/JSZK0fygafyapradebo2wSpaJxpVo7S
         uSLaIa8HVaoj7fB7CFHJyAN66w4jyVlfaHu1Hfs2QFCEGQJOnmD2myQ4PczsIsYDuU9F
         qFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703688602; x=1704293402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JgQdBp97fYnSauGF41qAWZ2C5akEqSt+yyiFx6LPIY=;
        b=RaHSQ+tu5wR3+aKzJgnLMjL54iPxfbHRE2SB1aZ+GM9xEFM7JuAS5iBIHUn1rUelj8
         HAZY62LwU8yhuCWIxW4lReuwGdJr0WTxaUS0pYq2MG6/+45Hur+u5BF+0irjd2+fMENS
         QUmbzHokcHH2eFaKRtZoF7MyHuZUDZlofvyuqhq9zXGvmSroH/lWwLVat++MFKJBdtSc
         s6rbOW+1IUMQefcweE951TjbkJs2/65KGgWlhx6vfbYAhjdXYIzaGktP8wsVvYn/GU+L
         ea373FqrxicUrwI8ZFpi9VcieL+wwNjFYT4bUbpNL/JczTQco1dkWSjgMfdsgJJRXlQR
         hTfw==
X-Gm-Message-State: AOJu0YxUFkXBOxsUwaIho7hC/q4W5MGuuRkgSxMpRlHghiAlE6mM2zBo
	Odma2oVXzkHRIfFvb+L66TNo5XbPv+s=
X-Google-Smtp-Source: AGHT+IFAV9fT4/UlYoIxvVmVvRqXhdm68xNmrtrB/CayWXP6x28lq8flOhfvb7GMHeix2K8x1fM0/A==
X-Received: by 2002:a17:902:bf42:b0:1d3:bedd:ad with SMTP id u2-20020a170902bf4200b001d3bedd00admr9265671pls.35.1703688602065;
        Wed, 27 Dec 2023 06:50:02 -0800 (PST)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id r22-20020a170902be1600b001d3aa7604c5sm9806269pls.0.2023.12.27.06.50.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2023 06:50:01 -0800 (PST)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Naohiro.Aota@wdc.com,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 5/7] workqueue: Addjust pwq's max_active when CPU online/offine
Date: Wed, 27 Dec 2023 22:51:41 +0800
Message-Id: <20231227145143.2399-6-jiangshanlai@gmail.com>
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

pwq->max_active is going to be set based on the CPU online distribution
which might be changed when CPU online/offine.

Call into wq_adjust_pwqs_max_active() to update them when needed.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index e0101b2b5fa3..d1c671597289 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5590,10 +5590,15 @@ int workqueue_online_cpu(unsigned int cpu)
 		mutex_unlock(&wq_pool_attach_mutex);
 	}
 
-	/* update pod affinity of unbound workqueues */
+	/*
+	 * Update pod affinity of unbound workqueues, and update max_active
+	 * for PWQs of all pods due to CPU online distribution changed.
+	 */
 	list_for_each_entry(wq, &workqueues, list) {
-		if (wq->unbound_attrs)
+		if (wq->unbound_attrs) {
 			wq_update_pod(wq, cpu, true);
+			wq_adjust_pwqs_max_active(wq);
+		}
 	}
 
 	mutex_unlock(&wq_pool_mutex);
@@ -5610,11 +5615,16 @@ int workqueue_offline_cpu(unsigned int cpu)
 
 	unbind_workers(cpu);
 
-	/* update pod affinity of unbound workqueues */
+	/*
+	 * Update pod affinity of unbound workqueues, and update max_active
+	 * for PWQs of all pods due to CPU online distribution changed.
+	 */
 	mutex_lock(&wq_pool_mutex);
 	list_for_each_entry(wq, &workqueues, list) {
-		if (wq->unbound_attrs)
+		if (wq->unbound_attrs) {
 			wq_update_pod(wq, cpu, false);
+			wq_adjust_pwqs_max_active(wq);
+		}
 	}
 	mutex_unlock(&wq_pool_mutex);
 
-- 
2.19.1.6.gb485710b


