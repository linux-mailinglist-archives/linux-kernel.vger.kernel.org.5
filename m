Return-Path: <linux-kernel+bounces-124146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4896D8912FE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93FB1B2416D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2353B2BE;
	Fri, 29 Mar 2024 04:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5lkIgYX"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15F529D03;
	Fri, 29 Mar 2024 04:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711687978; cv=none; b=YymBkZPESxNTaXL7EwzpUyx4q/rMY8t0CbvtHF3AgJhb/ETnBEFJHkxWjw4Nk3fUzMN6nRH69MTxWfyGD7ShaBg6t5wnMz3boNLxIvHQ8ZYmTe4BEivXC0keey9DxTlq1+8ElAmiz78z8cVKP6RWJyJrzf04OHSEqZolPPAzGHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711687978; c=relaxed/simple;
	bh=CIcEZKqxws1zHHHiOpeJqBklDMNV6tDrjhMIohhqgg8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Dcs9b/A/oMxxlc4r2OC/eXjyWVVpv0imp6zAtkcSyHkmhk4yCIip9BSDyoq3EASM1KZZbK7X+xAeaSWrbW3N44CscVpfkbbxwqB5sgTx4opa+z+YygqcuZodUna23GoMcXVTOT51CGyb5Uf/sXTXjdGFdYjJzUcC1wI/Ok0It8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5lkIgYX; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e6c0098328so1415132b3a.3;
        Thu, 28 Mar 2024 21:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711687976; x=1712292776; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63k6imC9+OqUKfMsPLAfCGeZ4j8bSZWpIL5nn2OEqcI=;
        b=c5lkIgYXV6OQbFEgYLH20zsUhYJHmTxRhitab0n4WUn9LOjZbFANiSH+wHfl1VdzYZ
         hWqwDaO8TePKZgcEaR+22wBIdB8dVVVcDwB2Ymckio9Xk3GBt8S8iLiJuXvOziVt2+/o
         aIHUF0SzE4ZLkBo5RKYueVCzR2sZy1BaK518fCKvqKzGLsy1yrl1zAtgnadiuOC0PH9V
         eZOsrDHWxHsGarBTFj+fcTNEvTWymJC/8vFikwTXX8u8GTsYtyR8uoa0Pl6+YfZ5QUa7
         pHJA3ilqSjlc6lszv/Iy3to2rHNZ+L4Z/qq6TjtPoUIGWw3xn1l5dAB6DH3+ZuyO2TJ+
         zYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711687976; x=1712292776;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63k6imC9+OqUKfMsPLAfCGeZ4j8bSZWpIL5nn2OEqcI=;
        b=JD1+6CyYE7Vj5ptZF2Be6CTK87jk7q9j71l8ETMlpvv8FCoxrBp9uhKmQVxH3KMI3Z
         gxwUXaXXejhoBJ34gsPcI4xFCKb7Zmy8sg3UjuooipVKjLPjgvwy3Zo/ES5LM5W0wSAn
         /swAGpes1F5qzGa7rc0IIRkoKPpU17hd8QApv8qY5bvoxWDL/Gq1MJtc0Wv7dxlYRNYW
         H8lWLKYaXWyx2TFPA8NuddOvEa5d1nZ00FYcDYWjFNsvrH+bq8g74npdo+MB0AWYNf0s
         Xjxh5czYGiGxZu72wZRJi9L/IyC9KDRQi1tjh5dl388rnOsX8bHQ+OrO5wajxlKNRgMB
         TCBA==
X-Forwarded-Encrypted: i=1; AJvYcCXcCC6/F5YNWweMkQc+cKq4r6LG+Y115TQXv2GXvKEb1ZMdHgJAr2/Eh5+Vv60dNhSKXSD2sxjWxnWbpNIosnqFoLAw7AVVOLI+hxJCnAIwjRt4p9wbXzZ3YSiNDxJIAIWj
X-Gm-Message-State: AOJu0Yz1UBedfcTHNv+xZe4KXY/6ZvuBKKUKa7JgDTGwFtPCThiOwpWE
	rN0YO7PtQXgDXxz8tVsyHRTwDRLRdnWYMBDlxLe8stbdzk2QpjZA6pCQHWH8
X-Google-Smtp-Source: AGHT+IGrgUgoe2TiMFuwvCXuU9Qq+yVGB6jV/beTX9hL/NoyT4GPQ2YQtctYISKqQkPb5gEARgccLw==
X-Received: by 2002:aa7:8889:0:b0:6ea:d7b6:f4b4 with SMTP id z9-20020aa78889000000b006ead7b6f4b4mr1377115pfe.21.1711687975974;
        Thu, 28 Mar 2024 21:52:55 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([117.128.58.94])
        by smtp.gmail.com with ESMTPSA id kq10-20020a056a004b0a00b006eae3aac040sm730526pfb.31.2024.03.28.21.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:52:55 -0700 (PDT)
From: Zqiang <qiang.zhang1211@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org
Cc: qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rcutorture: Make the rcu_gp_slow_register/unregister() be used only for rcutype test
Date: Fri, 29 Mar 2024 12:52:45 +0800
Message-Id: <20240329045245.16456-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The rcu_gp_slow_register/unregister() is only valid for tests which
the torture_type is rcu, this commit therefore generates gp_slow_register
and gp_slow_unregister function pointers in rcu_torture_ops structures,
and operates only when the function pointer exists.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/rcutorture.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 8654e99bd4a3..32f1c4e932eb 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -382,6 +382,8 @@ struct rcu_torture_ops {
 	bool (*check_boost_failed)(unsigned long gp_state, int *cpup);
 	int (*stall_dur)(void);
 	void (*get_gp_data)(int *flags, unsigned long *gp_seq);
+	void (*gp_slow_register)(atomic_t *rgssp);
+	void (*gp_slow_unregister)(atomic_t *rgssp);
 	long cbflood_max;
 	int irq_capable;
 	int can_boost;
@@ -570,6 +572,8 @@ static struct rcu_torture_ops rcu_ops = {
 	.check_boost_failed	= rcu_check_boost_fail,
 	.stall_dur		= rcu_jiffies_till_stall_check,
 	.get_gp_data		= rcutorture_get_gp_data,
+	.gp_slow_register	= rcu_gp_slow_register,
+	.gp_slow_unregister	= rcu_gp_slow_unregister,
 	.irq_capable		= 1,
 	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
 	.extendables		= RCUTORTURE_MAX_EXTEND,
@@ -3343,12 +3347,12 @@ rcu_torture_cleanup(void)
 			pr_info("%s: Invoking %pS().\n", __func__, cur_ops->cb_barrier);
 			cur_ops->cb_barrier();
 		}
-		rcu_gp_slow_unregister(NULL);
+		if (cur_ops->gp_slow_unregister)
+			cur_ops->gp_slow_unregister(NULL);
 		return;
 	}
 	if (!cur_ops) {
 		torture_cleanup_end();
-		rcu_gp_slow_unregister(NULL);
 		return;
 	}
 
@@ -3447,7 +3451,8 @@ rcu_torture_cleanup(void)
 	else
 		rcu_torture_print_module_parms(cur_ops, "End of test: SUCCESS");
 	torture_cleanup_end();
-	rcu_gp_slow_unregister(&rcu_fwd_cb_nodelay);
+	if (cur_ops->gp_slow_unregister)
+		cur_ops->gp_slow_unregister(NULL);
 }
 
 #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
@@ -3929,7 +3934,8 @@ rcu_torture_init(void)
 	if (object_debug)
 		rcu_test_debug_objects();
 	torture_init_end();
-	rcu_gp_slow_register(&rcu_fwd_cb_nodelay);
+	if (cur_ops->gp_slow_register)
+		cur_ops->gp_slow_register(&rcu_fwd_cb_nodelay);
 	return 0;
 
 unwind:
-- 
2.17.1


