Return-Path: <linux-kernel+bounces-97396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AE28769F9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B59E283B60
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9D856B7F;
	Fri,  8 Mar 2024 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZ/O0FuU"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B6C3FBB9;
	Fri,  8 Mar 2024 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919259; cv=none; b=qrpkgO7qEoQzqmV/aT3EWyU0wkbY+dU5b97fiKEVei0RTTJQ/Sefbl5QPKZ8qdnIMKm0Eu8CCvqslV8dRJPyb20VKsyQ9lrmBYCgTHEjI9s5QrZ5GoTsDFYPwIStS4vh6oE+VFWnvOQoqtFfMgoNCkdLNkDsWvbzo1QPZ71gIRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919259; c=relaxed/simple;
	bh=i9xh4PFq53VVHMU9LfrMaittt3a26iMVfWpygIZ7oew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q9LgwEuwlX0+/ZSzc7niKoHxkYr4HZz60ate8TNToHvesrV3GQ86vHuJZuT/w16XcayphvZs2nODrUeGPllbt3O6e9oQWCLTqq97IJUSn4J7VDJkbKE79ROq2FYsDhrolU6mUFThpJ0maOAewS/GqZeYRo2VfDvkNzBrjMMbOo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZ/O0FuU; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5132181d54bso3164987e87.3;
        Fri, 08 Mar 2024 09:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709919255; x=1710524055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/cUkmoDb/vMEZdBp6an+/laLEoOrf8mMtp4dQwMC1s=;
        b=FZ/O0FuU5oAzAxwhsFj6aiuBMmWC8dV75plF0OetUMKVUnZELCKbxHshZmuCwQ5hyZ
         YNKYme20UMEAy3mp0OWna9jd5yhqj1P7KhEQouRHd+na21yAo6Wp+KO1Y//dhEGTArL+
         2QNwkMCgPhFAloSSoG1GLp59iFmv5GryeFpBPbV/wLekOpNmI4k1V/RhxLBE5co0AtkK
         IzLPmKTCfSMfPFwy7kU0+JXv4SubhhGuY3iwq+oEgH14AIwv2Uoyu2wqr5JawNhn0FC4
         i7h+FaeSWgBiEU4Jvz8R04a258n2JHqWQA8e/hq4Kkfb4Ul/NTSgsSc8KUlZP9EPuT3M
         WJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709919255; x=1710524055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/cUkmoDb/vMEZdBp6an+/laLEoOrf8mMtp4dQwMC1s=;
        b=pFOkKG5d5XB/8ytb0iTlW2gTOWDzwsnwuxizWegdp2ndOmCp6CPKOOdySkiyKZVenL
         Rr36xBn8q6JB6pU/aYFXoThNb+8ZQZW2i9fgo7Lg+QOHB9+idhT1+ubBetsRHPkgKvXR
         +jBSVii7qrPmMEKBuMwOeUpqpUs+OHzO7d14MC5+hQSm82sD8zQHYimPCYZPYQUpTXZJ
         fEMfUzTG4Rd7qTiFh8TWVTWf9rE6wMZRDtlTnG06BE4+HwNaNcU3SA1++B17n6f8+bj/
         lUQTDWa8p3dj6f+iRyOKh8lM+XUSpH79z6XAfL1jfj8wjPCbdS07RBVLPLFkqHgU6w6M
         +x2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXyiFxtSesl8Fkpkj0lFcq5HMPieKPYYtv2dks0R7cR7npgjDjRZQScWePytgocReftWrdcID5zUpt2UN6BdmGZqgfpkTvxBe40Sdqa
X-Gm-Message-State: AOJu0YwXKLRFqRaxjSZwh9LRLW606kjvpGDMJCUwx5Y1VO2/deJ7CWz6
	ByFLagLKC3byo23hOzGNtYvUTiTw95ZIkAk7co2bxIycflssi617
X-Google-Smtp-Source: AGHT+IHsyDLgEOxeS/q3et3wykWVMvudFD9nQnMwi9PEaLRJ7xOrTOkUhTZ/eH2T/UqD6XoP2nTnvw==
X-Received: by 2002:a19:c20c:0:b0:512:bb47:967c with SMTP id l12-20020a19c20c000000b00512bb47967cmr3382421lfc.19.1709919255167;
        Fri, 08 Mar 2024 09:34:15 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id a23-20020a195f57000000b0051333e2f55dsm3150504lfj.159.2024.03.08.09.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 09:34:14 -0800 (PST)
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
Subject: [PATCH v6 3/6] rcu: Add a trace event for synchronize_rcu_normal()
Date: Fri,  8 Mar 2024 18:34:06 +0100
Message-Id: <20240308173409.335345-4-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240308173409.335345-1-urezki@gmail.com>
References: <20240308173409.335345-1-urezki@gmail.com>
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
index 42a31d4d279b..dcc1764e8fad 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3887,9 +3887,11 @@ static void synchronize_rcu_normal(void)
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
@@ -3910,6 +3912,9 @@ static void synchronize_rcu_normal(void)
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


