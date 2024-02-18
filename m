Return-Path: <linux-kernel+bounces-70519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 670158598CD
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF361C21023
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510F5763F0;
	Sun, 18 Feb 2024 18:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NvT0XLwH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x2/uK7ua"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC39B745C5;
	Sun, 18 Feb 2024 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282680; cv=none; b=cg5yrMfKClgdurSo4WFQTfcirGT3AQiGDLONqxSOq23DY4mientcKtVdD/4EAX3CT1hcZWcG93J0NipwSgha8NC94mojwLs01mq16OF8odxNRinVkkGN3tVnZjgKU/9u7OaanBwOvXeGmtyGua6OvWTF4ZTFUeo4a4M1J2j9PLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282680; c=relaxed/simple;
	bh=OqtVB7F0XU7K6r/XkEXRYuJkg6/1ejUUWR2/2NldzE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DUx7BLSjnbQTproe28tJ6wVRqI/B5GCY9pbQ531R28jJF/SVNgTcyYkJIPweF4Cz/OYTLOKo6ejcTr8JN5t7VcajPfnBFdl3KXwpFs+ZZYzVmESXish6/uskqh542ASHDegfgjMw/g0J5kX7bXAOBRVVBgK7WXSUwWXYYdhJiiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NvT0XLwH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x2/uK7ua; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708282677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ou6pqnQIQ61CFk5TWsTCxvXU+rgsnFekoY9DjGSMLxI=;
	b=NvT0XLwHYOh9+AxQfVwE3XtEQHME+T7jeyFjb+mH0NRGGQKCbh5EmRxPxr3TogqegumTxl
	DDyXyi39jg6SLdi/ZLLl2VJ++kV4V4Lz/rHgAjGEip9fKs7uqjgCN6IvPD+SAu54hjehKE
	/CVFyAJfTYhPJxBXicT0qE+9Cyw4/gJjnqsIh5QHCjZIARUcGp4Q1rminYa7+rRP9eMt8h
	JuZeaQCUDPY+POfG/+INo0985kWx6JRQpeJPA6LR8sIWTp0IY+ey6lprOPEmSZXBzWY0Y1
	KnQoaFyYnphPLhcxg2bAOsdfSkm+OMMq40yl4e8g9g/OthkEZ/0mjKZWOZlSzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708282677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ou6pqnQIQ61CFk5TWsTCxvXU+rgsnFekoY9DjGSMLxI=;
	b=x2/uK7uacN1qu3ts3Df1coB1t8Xae85UpjQ3ZkPOYdrYjk/NQ0AEn05N8/xeRAvDI8AjVt
	OKnGkqYsCYaKYSDg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu@vger.kernel.org
Subject: [PATCH printk v2 25/26] rcu: Mark emergency section in rcu stalls
Date: Sun, 18 Feb 2024 20:03:25 +0106
Message-Id: <20240218185726.1994771-26-john.ogness@linutronix.de>
In-Reply-To: <20240218185726.1994771-1-john.ogness@linutronix.de>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark an emergency section within print_other_cpu_stall(), where
RCU stall information is printed. In this section, the CPU will
not perform console output for the printk() calls. Instead, a
flushing of the console output is triggered when exiting the
emergency section.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/rcu/tree_stall.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index ac8e86babe44..efb2be8939a2 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -9,6 +9,7 @@
 
 #include <linux/kvm_para.h>
 #include <linux/rcu_notifier.h>
+#include <linux/console.h>
 
 //////////////////////////////////////////////////////////////////////////////
 //
@@ -604,6 +605,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	if (rcu_stall_is_suppressed())
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	/*
 	 * OK, time to rat on our buddy...
 	 * See Documentation/RCU/stallwarn.rst for info on how to debug
@@ -658,6 +661,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	panic_on_rcu_stall();
 
 	rcu_force_quiescent_state();  /* Kick them all. */
+
+	nbcon_cpu_emergency_exit();
 }
 
 static void print_cpu_stall(unsigned long gps)
-- 
2.39.2


