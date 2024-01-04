Return-Path: <linux-kernel+bounces-16918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58056824619
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2143285F4E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC9E25108;
	Thu,  4 Jan 2024 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCQ2PdEw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BA824B54;
	Thu,  4 Jan 2024 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e4e3323a6so1567496e87.0;
        Thu, 04 Jan 2024 08:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704385515; x=1704990315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brIJ2euFOpiSQ53pXAG7v0znGgtL9iaFEsHcomev58o=;
        b=LCQ2PdEws9a5KKhcAQjH0211pS3ANlyR4YfklMLtH5ljGJq0Xl+o1jxNgwAn/qDV+F
         HfkFJ2gfUh+0sWEpf20ZGNtmeZAFgiJ3nbfTDcT7BmI0e4kIN+ktEqcOqOj9Q+qjBwUA
         wL8JaJqQsp3W2I8nLcYkPZTYneUZ4JQW/xia0Yj5wh5k1We0+S10On+NbdqUoNG0Dhel
         fU2WdTiF06K5A2P4eBkKa3I9Bcgel8XDh23UQXzLlR1Cg3+zK+9w/NGkww2LnejV4hau
         LuaYd1+JuAIs0kx0da8YryzGTvXovh/hegAoI6DqbUCFg+BcTwGggXqSt+bzr2W0V42Y
         9iZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704385515; x=1704990315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brIJ2euFOpiSQ53pXAG7v0znGgtL9iaFEsHcomev58o=;
        b=Zhwp3c9/aa5psiemoh+WDMTckoM3tSeMVskfgM0Yb24D8dKf8SNjSu2roorAF1gGs3
         ojOYZpkViYB7on32FDjG5Py9wk9sMAPeCHIvH4lBOTU1dC26AU97oR2ceU5uAkqnk73J
         gB5iGHmLWnRVlu/z/iE+aROGMfafzqjwQWQ0/o1L1Mh6RLzuDJj1Ua+TYom4ePiFQDCS
         RZT8Da0Fgue832U92DHonvSNmnnmkdnoHbMoUXU7W1fO+2Aju6oJr23LkO91Qbu7ru2H
         9hbmIDAI2s9dlK++35rFnVdWIZbv+nj0xWdufF6bOtyR78Bc01YkUR9zNw9muo6v+Df2
         PIaA==
X-Gm-Message-State: AOJu0YxAUHFt4e9RwUJFJQayo8f+vR/4kCmwJB7bkkDuWf4U6QZOhKum
	JcTOdR7UCrc8ZzAZfQPIrQI=
X-Google-Smtp-Source: AGHT+IGORlSd/iHxIKLpkj2JHoRgut4F0x9yeYd748qHzGBXlToniptd/Hk/okeIPywExK8VIs3hdQ==
X-Received: by 2002:a05:6512:20c6:b0:50e:7b9c:4d97 with SMTP id u6-20020a05651220c600b0050e7b9c4d97mr455431lfr.8.1704385515198;
        Thu, 04 Jan 2024 08:25:15 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id i5-20020a0565123e0500b0050e80d1e142sm2789252lfv.170.2024.01.04.08.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 08:25:14 -0800 (PST)
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
Subject: [PATCH v4 2/4] rcu: Add a trace event for synchronize_rcu_normal()
Date: Thu,  4 Jan 2024 17:25:08 +0100
Message-Id: <20240104162510.72773-3-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240104162510.72773-1-urezki@gmail.com>
References: <20240104162510.72773-1-urezki@gmail.com>
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
index b756c40e4960..7d2ed89efcb3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3672,9 +3672,11 @@ static void synchronize_rcu_normal(void)
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
@@ -3695,6 +3697,9 @@ static void synchronize_rcu_normal(void)
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


