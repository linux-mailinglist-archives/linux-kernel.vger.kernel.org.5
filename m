Return-Path: <linux-kernel+bounces-73508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8709A85C3A0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04ADBB24634
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3162E127B7A;
	Tue, 20 Feb 2024 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lytMmJFk"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAA41272AD;
	Tue, 20 Feb 2024 18:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708453882; cv=none; b=KNOEsZr809n25/WJGOG4wsQp92kjN7WQR93oc2QIvQeOYcFABIVtWhiYt+hdz78wnGL7QT+tIw2FtXecurlL98pkENzTIieD/BiOAD14vx+3h1ww+jPPbTLo8pQveEsAyqlinLwO4jWABLgkum+dYZQqTFp5yTigADebIsO2+F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708453882; c=relaxed/simple;
	bh=+sM30cOyHqXSmmhxaV2sjUAEf1nC4m+PeirwUjejQqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uKsKbgkyyWYhpEgvk/TUTdHcDsuuHUtTses99sDEhtUTWdRPGoyShLKfQiL2nM+Q0gfsZ4sIuIXZ5Gks4QSjeNC3EwBgAkC3CHJfbfaTr/jpfV7QSbiRGO8yVquLFjzCHKSxljaB7lMl/A2Mq+drPR7l3YrK/eRNTJtsTTaUwuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lytMmJFk; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512ab55fde6so4139617e87.2;
        Tue, 20 Feb 2024 10:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708453879; x=1709058679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOpDJiuEMajeibzl8V5uZUX1gqeJEBwIDoQaXh828aE=;
        b=lytMmJFkzEhXGCGzjPYPaUY+u5+v9PrKjqXTG3IGC+RAZhYn8M+X/9KVfHkcNU9ibO
         CM+FJ5gG09sGRoLhn7Je2SJiT0ZlryUpdOrW0HD5GQEZYSVTxYmslEEJJndcK0raDTQ3
         cmN2j5VKVY9U5BPLmJB3M/SDgHpHYrMYAANiB8Yg3syD9nPMZLrh3OaOSfE2SUvHQ0Ou
         p7yiT+ivyWe0R/Zho/3iQPVKPjpEFClifH813D9pabpfi+VThIgb4lDDUQHgM/OS47R2
         Q6TPdmYdbNTQwrNB1p27Akncl/sy4+Y2WFnWa3tkYWfmCejkMhsXVnEsIx7UQof/Yh8T
         PwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708453879; x=1709058679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOpDJiuEMajeibzl8V5uZUX1gqeJEBwIDoQaXh828aE=;
        b=B5zMSMQCNLZ6NcQNy/EZv/1mrEiaJQZMm131YEMJ4CgE463ubJtjWWzk3KutnQatCM
         SkCjX8Drn4MO/JW+hN5q6k1SzXYsjusBhk6cOUiKHMGiYI2ARnOWLpvELYFUBnjpXfca
         ZyT6ouL9QWTNhz6sBz5NYKU6QAfoc0erIQXWhaG0lft4LWhegCBgjRjuqvWM7CClgHUa
         rmbVUAq51wI14LSwNe24gz7hBgRbk9Ou2hIs2OWfW9fQF0eifxHkb4/9k8IJWYJGwztK
         2jL2beSCCTVMLl5be2gSJiRMw7jBOEhMSBJBdUiiDHa7AYvY2qSqUc0xZCyjWFJwJr55
         mhzg==
X-Forwarded-Encrypted: i=1; AJvYcCXoWb5XFEZegHA6BjGAuc3HCzaMaUR+HAZcHtdoA4uDzqcf+r0pZLyRVr0XofkubjIpG/378P8OX0B0jE/qtk+4M1vlwgXEWXkxhefV
X-Gm-Message-State: AOJu0YxZa+jOx/vxvYU5TLwfk1FlZsi1yAm7lfcj/0Ez4agZtb4CaUTX
	5OuGs3s2vArRLQCkv4IpKlAn0ndjkCD7oxOye79KY9+RhSXa+J9LAXROOtl5
X-Google-Smtp-Source: AGHT+IFEWEH+rV+eoGOniJBjuYuCBphY4QaFey8wMvcUlAbEtVKv1haHkL7sEnZi1q8cd7e/oYyLtg==
X-Received: by 2002:a05:6512:708:b0:512:b372:4eed with SMTP id b8-20020a056512070800b00512b3724eedmr3947732lfs.8.1708453878610;
        Tue, 20 Feb 2024 10:31:18 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id b14-20020ac247ee000000b005118add498asm1365937lfp.130.2024.02.20.10.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 10:31:18 -0800 (PST)
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
Subject: [PATCH v5 1/4] rcu: Add data structures for synchronize_rcu()
Date: Tue, 20 Feb 2024 19:31:12 +0100
Message-Id: <20240220183115.74124-2-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220183115.74124-1-urezki@gmail.com>
References: <20240220183115.74124-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The synchronize_rcu() call is going to be reworked, thus
this patch adds dedicated fields into the rcu_state structure.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index df48160b3136..b942b9437438 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -315,6 +315,13 @@ do {									\
 	__set_current_state(TASK_RUNNING);				\
 } while (0)
 
+#define SR_NORMAL_GP_WAIT_HEAD_MAX 5
+
+struct sr_wait_node {
+	atomic_t inuse;
+	struct llist_node node;
+};
+
 /*
  * RCU global state, including node hierarchy.  This hierarchy is
  * represented in "heap" form in a dense array.  The root (first level)
@@ -400,6 +407,13 @@ struct rcu_state {
 						/* Synchronize offline with */
 						/*  GP pre-initialization. */
 	int nocb_is_setup;			/* nocb is setup from boot */
+
+	/* synchronize_rcu() part. */
+	struct llist_head srs_next;	/* request a GP users. */
+	struct llist_node *srs_wait_tail; /* wait for GP users. */
+	struct llist_node *srs_done_tail; /* ready for GP users. */
+	struct sr_wait_node srs_wait_nodes[SR_NORMAL_GP_WAIT_HEAD_MAX];
+	struct work_struct srs_cleanup_work;
 };
 
 /* Values for rcu_state structure's gp_flags field. */
-- 
2.39.2


