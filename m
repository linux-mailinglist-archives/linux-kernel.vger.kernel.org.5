Return-Path: <linux-kernel+bounces-92916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B738E872815
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A7A1F299AD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8025212881F;
	Tue,  5 Mar 2024 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lcu0cWxw"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1FA86659;
	Tue,  5 Mar 2024 19:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709668647; cv=none; b=rg1ctmyPbORwsnpGmYgfhxYBwfcodoeYxRMkLAT2knamo3GBptHF+LNRAveAo5x8Tutlzge+TbmKIot0Be5XOc63ayqwc7Rvi6nxQfxnafM5DGUL6Lf9o/QESAbwKn6ulHTa+VIKioMayemc4LUin+TftpurIlrfXIJ3nXHTzWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709668647; c=relaxed/simple;
	bh=5I/d5BaVeSQ2g9PVfjPnYfj40Y9kHpOjzzVspm6XoKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h97MniHPmODOUvsQDDXioii0IiK54TZuwa0EjsamMtI6rplQF15zdnWHR5uoGJVz1HV+QXaog79hrvCSNKNwCMRayCs3KsWuKc8JOdGSQiE1g075K7zSygx8oPOlyAa5GuM5glT24xvjucGMJWrPjiHpa1bYOz5Ul5dfS99vLYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lcu0cWxw; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d28e465655so92336431fa.0;
        Tue, 05 Mar 2024 11:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709668644; x=1710273444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecJbs3cfQIwpKSeFapcXXM1jpRoq+UQXbja6pvtwKkI=;
        b=Lcu0cWxw5ARTsqCv8VfYoWkQIivQ4KBvyokQtZiXRGq1CjTprw+52K6Ox2VVfxnYeZ
         dimO2CmNuuFIUouxZKTLoZiVzqQ4gvKeRvWizgsqWoBWUhasdHihS5cUP+972XujKx4W
         yYPt3oZeFfj8gFh32H2zkgLAhEJfJrK1mkeyzSfLIpctiYJ8eN+4QSEtfAT3Ngn0HErZ
         ZAH5NUJeCnVzKjUpEHZ1i/BS3mlMAqDl4H2S8ytnMbsFjpG981Usno/CJRDp8DBmQT7z
         GiPuS/64KIAcO+qE3Vg/aqzhQTSKjUZ+EDrfH6RoNv2HjQzMq8DPniwn0Zp7Pg3WcfEQ
         DHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709668644; x=1710273444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ecJbs3cfQIwpKSeFapcXXM1jpRoq+UQXbja6pvtwKkI=;
        b=kPTVnfFYsr4s+QGfYFkl66l8qmlPs8jjHeeua4gw1W1PGfI15xwqOOYmHIfqmJ/yFe
         MKc5dEoqX20ayO3qDNLKxRP63Q7Co0/+eM/yNQx7KS35lhHbrjZbNiBi73W0D6mEBz/f
         WlQbyEEca1oscVVMxkm0KQWea+bSfEVEmO7NHzJC+diUgRCkfvK07kzeQB9vtOgsqdWE
         lnEj90c7djWThGsQHVK4ZlFOdlpapKQZBYFmMfqDpUOuyPYPK3pWp9R7zwKa4Nkg8dp5
         NaCx7A2VtVF8s8jQ9z64xzJuVy4u/4QJvMvfV3iOk+B/ylYODfu8AVqYXV/EEu0/0F5g
         38EA==
X-Forwarded-Encrypted: i=1; AJvYcCWEiGSL71DZlV+esW28KA3i1hLUEh3EV6iUVpLj1yZ8+aw+4piHAQ9K38pc+rZZNzeWr+RqYewQId8FJ238qp0LTJVYEedtkQ5D7zNQ
X-Gm-Message-State: AOJu0YyNwlkgzYTC31m5Dgfn/kxQ9q9UNsc86Q7seg3BpE+Z4X2Wqr0r
	wKMG14R9wMbcpBcfdIiEM7IRbQOQt56vUDJeJLSqpDjaAi6gK+hQ
X-Google-Smtp-Source: AGHT+IEiGOySMkAPDO/LWEu9Cpi99iq0t3jibPAVbFJc8WA9LFeiDOtwx8r2iHYIraf9C447pphhtA==
X-Received: by 2002:a05:6512:23a4:b0:512:fccc:f289 with SMTP id c36-20020a05651223a400b00512fcccf289mr2483710lfv.6.1709668643947;
        Tue, 05 Mar 2024 11:57:23 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id cf10-20020a056512280a00b005133fa4bc1asm1394437lfb.211.2024.03.05.11.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 11:57:23 -0800 (PST)
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
Subject: [PATCH 2/2] rcu: Allocate WQ with WQ_MEM_RECLAIM bit set
Date: Tue,  5 Mar 2024 20:57:20 +0100
Message-Id: <20240305195720.42687-2-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305195720.42687-1-urezki@gmail.com>
References: <20240305195720.42687-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

synchronize_rcu() users have to be processed regardless
of memory pressure so our private WQ needs to have at least
one execution context what WQ_MEM_RECLAIM flag guarantees.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 475647620b12..59881a68dd26 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1581,6 +1581,7 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
 /* Disabled by default. */
 static int rcu_normal_wake_from_gp;
 module_param(rcu_normal_wake_from_gp, int, 0644);
+static struct workqueue_struct *sync_wq;
 
 static void rcu_sr_normal_complete(struct llist_node *node)
 {
@@ -1679,7 +1680,7 @@ static void rcu_sr_normal_gp_cleanup(void)
 	 * of outstanding users(if still left) and releasing wait-heads
 	 * added by rcu_sr_normal_gp_init() call.
 	 */
-	queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
+	queue_work(sync_wq, &rcu_state.srs_cleanup_work);
 }
 
 /*
@@ -5584,6 +5585,9 @@ void __init rcu_init(void)
 	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
 	WARN_ON(!rcu_gp_wq);
 
+	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM, 0);
+	WARN_ON(!sync_wq);
+
 	/* Fill in default value for rcutree.qovld boot parameter. */
 	/* -After- the rcu_node ->lock fields are initialized! */
 	if (qovld < 0)
-- 
2.39.2


