Return-Path: <linux-kernel+bounces-73510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B5085C3A1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007361F247DA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E589D128828;
	Tue, 20 Feb 2024 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMKNfh1a"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E41F127B5B;
	Tue, 20 Feb 2024 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708453884; cv=none; b=YK+FSNXh7ImYg8ErfNYuFDz0ysDCKSaoNogR49L8ia5cgIrJroFoBxIxM3lJYHEzBwNioTUhg/19IIR0kJtB6ro+PJMJ2gn71E4COD0Rcd3p6jZJ4mKrDYzeVvihJ0YbqW3dExhRlAOesN6xT3yRcJiUwuoNuPAbj5uMTcg32Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708453884; c=relaxed/simple;
	bh=S2TYpCFy1JB7Zaotn5xau8POLflJ7cWtSbobA+OSmdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kyPvx85QLVAyhYa3wFfOmsVm3E3upJ3VRhjZZ/jlBzy89zFLxmfJXb1/8zpVf/9r2RI/iQ8nA1jq4Fk1kUJYPWiJQud+l+vJUvuVYxbBi9YUB/zlrqtZzd/JJErTAi3Q0elakvaVD4REU6KUlOVsjy4nxgYb2+52yqqfKj6wZNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMKNfh1a; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5120ecfd75cso9017718e87.0;
        Tue, 20 Feb 2024 10:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708453880; x=1709058680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMrZV9vvrbQZqV4fEBsa4bv16+I4Dv8VWVkuWrxr4/U=;
        b=ZMKNfh1aP6lx3SYOS37CeOUZ/7YlaVwJwphLUQV8hssM/fk6/+ij0QRziHvNuwAXIb
         Q4o0qw79zM75BkRmi3PzabRltO7C9qg8gPi7SNnjluZq450PkkCbnb0pj+7dyotSm2CV
         h9plMLxR5AkYZb4tveyRKzeAMdp+u7Jr8uMN7Do+KhLWoM4PY7nJbSyqy24/uuH7+59m
         XutzN1VPwu1fiAG/6qFhmzS/kVkx8L/j8/c3o2kD9uXeyYXyKKOSZFUxU1+l9maoZuee
         mTBYDfzTOMs2ApV9PzitoJn6axgTzB2CdjUCcS+5DYFiWM3G6SN1dVkzr89UDm/AUou9
         GwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708453880; x=1709058680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMrZV9vvrbQZqV4fEBsa4bv16+I4Dv8VWVkuWrxr4/U=;
        b=YxXhH9I8rhvQjZr1I64JOLz9tWCJWTR+oSzcbAqeVHbV6OIFZyFmIF0VFJlX1NISEb
         LU6WfTeMeN3K5eFUkOCcZUyV9dx0ZlmrYjDA9PE6SvmJiZuTX9fsApZRLTcmUWQEeh+J
         pWQN2pQo3LA+ASv0qZHkweitAmPHwi71hLy2ryvEuSHZqQZWgSpN32rl+J9ArgVtQjaF
         ynSi9mcfv20EbHM5KlXk6W+tln/1kxTXTjZZjkShr89Nq6fWQUvxWZmNok0e9HYIvAtG
         n6toXqw7kzjV0py0J4fJvkCZC5jCO23cRGs8Tsj49MBGV4vNCQNn4bokRo9iZBHd7otJ
         CxCg==
X-Forwarded-Encrypted: i=1; AJvYcCVn2RTpM5Dq76XO2zcf24OxEbVY75jj51DafgAcG1/EzW+/d6uOl7kTMjGKNvkArhN6aLcSVTb5m8S55O/a8dyhgftdOwOwGXUqSeO6
X-Gm-Message-State: AOJu0YwXAAsqZoEqI+AFc1CNgDlravCydBnnlX1GqDMDwW5YtPym+Zp+
	+KuL08/QLjrov5EzJAxfVWbHZdOcPl6Y7h2sZC7TYmn63CAbhcD4
X-Google-Smtp-Source: AGHT+IGPHOnJUnCnKoLVQOCnv+kPDLleOo6580hS+b43irm9Z/dtex0pWHTP9Mef1sB47JTC8jdIcQ==
X-Received: by 2002:ac2:4a63:0:b0:511:76f1:3bf7 with SMTP id q3-20020ac24a63000000b0051176f13bf7mr10152732lfp.51.1708453880296;
        Tue, 20 Feb 2024 10:31:20 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id b14-20020ac247ee000000b005118add498asm1365937lfp.130.2024.02.20.10.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 10:31:19 -0800 (PST)
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
Subject: [PATCH v5 3/4] rcu: Add a trace event for synchronize_rcu_normal()
Date: Tue, 20 Feb 2024 19:31:14 +0100
Message-Id: <20240220183115.74124-4-urezki@gmail.com>
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

Add an rcu_sr_normal() trace event. It takes three arguments
first one is the name of RCU flavour, second one is a user id
which triggeres synchronize_rcu_normal() and last one is an
event.

There are two traces in the synchronize_rcu_normal(). On entry,
when a new request is registered and on exit point when request
is completed.

Please note, CONFIG_RCU_TRACE=y is required to activate traces.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/trace/events/rcu.h | 27 +++++++++++++++++++++++++++
 kernel/rcu/tree.c          |  7 ++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 2ef9c719772a..31b3e0d3e65f 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -707,6 +707,33 @@ TRACE_EVENT_RCU(rcu_invoke_kfree_bulk_callback,
 		__entry->rcuname, __entry->p, __entry->nr_records)
 );
 
+/*
+ * Tracepoint for a normal synchronize_rcu() states. The first argument
+ * is the RCU flavor, the second argument is a pointer to rcu_head the
+ * last one is an event.
+ */
+TRACE_EVENT_RCU(rcu_sr_normal,
+
+	TP_PROTO(const char *rcuname, struct rcu_head *rhp, const char *srevent),
+
+	TP_ARGS(rcuname, rhp, srevent),
+
+	TP_STRUCT__entry(
+		__field(const char *, rcuname)
+		__field(void *, rhp)
+		__field(const char *, srevent)
+	),
+
+	TP_fast_assign(
+		__entry->rcuname = rcuname;
+		__entry->rhp = rhp;
+		__entry->srevent = srevent;
+	),
+
+	TP_printk("%s rhp=0x%p event=%s",
+		__entry->rcuname, __entry->rhp, __entry->srevent)
+);
+
 /*
  * Tracepoint for exiting rcu_do_batch after RCU callbacks have been
  * invoked.  The first argument is the name of the RCU flavor,
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1328da63c3cd..3bf6b3c5ef05 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3863,9 +3863,11 @@ static void synchronize_rcu_normal(void)
 {
 	struct rcu_synchronize rs;
 
+	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("request"));
+
 	if (!READ_ONCE(rcu_normal_wake_from_gp)) {
 		wait_rcu_gp(call_rcu_hurry);
-		return;
+		goto trace_complete_out;
 	}
 
 	init_rcu_head_on_stack(&rs.head);
@@ -3886,6 +3888,9 @@ static void synchronize_rcu_normal(void)
 	/* Now we can wait. */
 	wait_for_completion(&rs.completion);
 	destroy_rcu_head_on_stack(&rs.head);
+
+trace_complete_out:
+	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("complete"));
 }
 
 /**
-- 
2.39.2


