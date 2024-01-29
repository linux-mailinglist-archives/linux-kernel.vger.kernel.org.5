Return-Path: <linux-kernel+bounces-43649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBDE841731
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A821C22C59
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5D515959E;
	Mon, 29 Jan 2024 23:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjNaZfyk"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1267B152DE5;
	Mon, 29 Jan 2024 23:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706572678; cv=none; b=CBnnxYeZlV3vUbsrxJj9PBO61ixf6ROB7m3qSPC6t2Lv9p4mKQmF58whuoGAMq62EFItdi8myEjbNiAYg2vi5Csne5vNs1rAiIknwpdcQMp41XLem2rFgJc8oo6QbucrmSADuuQ8q9YnJFwegf+MmcKek7lYigRAU5qKgVJnhHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706572678; c=relaxed/simple;
	bh=729O94EoCREx3FZ9Z1vQ84ULvsbGf6rHZJbzo7snSIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qV+ugdFrGGfuauNBsmcGRFo2F0JpOd6q+lSWil33Q3hKqOvV8TxyQo116QckQIfg6mlXRYBC3eQwr3s/lB4YJQb11RyIhh1HIxNBv0EJKOxANd+tC0xvVwaALcI/Kodhw+pJa5ZiwdZiGT34AfHCm0Pgd85XcC9eXyamgb9wQcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjNaZfyk; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-781753f52afso283406485a.2;
        Mon, 29 Jan 2024 15:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706572676; x=1707177476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fT86kh/TbRUN/0ULbFYKGCXq2c0HprpskOGj7i+dxyE=;
        b=JjNaZfyk3W/b1dAOBqovorX1/VaXXO4IjvG5W3/jwRKhqK0yfiAx5V/NKRkFqH4YSZ
         FTCyY8rzqlkLEsr4kEyYtOqD2T4kRgOuN14gyEYeP6s0aqW2ji0WOj3lvSk95cR+bIkg
         ZkqNz4meX+zIybVjfbinVHxCYeNOHEDeaOmMiJJiyG0Mt8MAn+8ejbc16+SlikW+YYPn
         bmoWPuoVa8i+Xol8SgRq7iRq4ascGSue8sr/1ivTJHPNJ7DvYYJtpBeO/l7oPCFiXbF/
         LkRHsbLxQTM6Zvv/WhcxjPbppq2vtrhz74aJVY45H4zreGTQ0yB1kkTvct0qGcpyRekm
         hDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706572676; x=1707177476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fT86kh/TbRUN/0ULbFYKGCXq2c0HprpskOGj7i+dxyE=;
        b=gmYlRtnNLh+mApM7E8XC997ro3UXPk/+/lNzxqNziUlkv3RrOeQ29iap0jz7JwKXNx
         sErhxLPbJbdHwQBMfLPokfaP1DRRmeUH8cdePw4qvKuncLbMZ/+qC2vuEr8CjG/8VhgN
         OGkuOYjmKpopKIahyLjpLkZZFEzhS9GtcZRj5sHau7ytUZk9VxaAeMlYWtSl6awy5kWL
         BMPdR4QgioS8SupdPXWNrPv7IIpTW/LBj/66v+Js2OVlfqVPGkdSEIBbmtg9+70mV9JD
         /og3sNFikwfwIgnIViWzf4arKLC2YBWmzX7TkgmpXb0iD4yTN2cu2crVfj4EWNicX6Gl
         S0dw==
X-Gm-Message-State: AOJu0YxtPIB5X5UWW+GNSrHu0ge4edYjauLdHOzRg0k2l9dORKxxbtKR
	fye4ZOVJw40zBg/tG0qruQXGbRwMDpZ3nl+GEfkzPiUcH8uUEf3/nqkSEepc
X-Google-Smtp-Source: AGHT+IGJz/Rq4NlJ/IdK4N4g9Fd8Vz7QNxgfWOxmrnIEJOx01Xrw6XMoL0Dw1kPX5UPxhz0FZxIBPw==
X-Received: by 2002:a05:6214:174b:b0:68c:3ad7:517f with SMTP id dc11-20020a056214174b00b0068c3ad7517fmr5291035qvb.30.1706572675853;
        Mon, 29 Jan 2024 15:57:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU71LJ8pAwVCRMD652qgpsLr+ijpMZYquK1a0W9XPwacdxp4RvF10kZ3VgUR9W3+J1JhkprpAeM8IeBEoYKlZXAC3Xk+rrwFR2/dggSJGeJ6eA8oL+BwjfuZjOLuD7v03H1xCesiodNNXBuNw==
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id ma8-20020a0562145b0800b0068c38dd9ca4sm3259266qvb.8.2024.01.29.15.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 15:57:55 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 44AF91200043;
	Mon, 29 Jan 2024 18:57:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 29 Jan 2024 18:57:55 -0500
X-ME-Sender: <xms:gju4ZaD14glIUHYCbGU_yDvgU2HdteCXQ1u3_Kp5s8fRgS-LOjFiIQ>
    <xme:gju4ZUhxxpWDDMDbUEGWH6B1Gvi3cFS8QTxYsrvd8IIoFZ1qLYeWUj35jGXKKfXAG
    g1yPS7OEM5vRsEwCQ>
X-ME-Received: <xmr:gju4ZdlDBeWuaHR1ZB2qmQHDSRuzaO8DofkginU-Thi28TqbBYofp07269oSKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedthedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:gju4ZYxFIj1aWa0Ag-r9048e6xo-juiyixbiD1FQEHawPl-h6w3f5w>
    <xmx:gju4ZfQoZ5N_bRrF4AFiGgUNNq-Fdl8gSQUZjLLuGN2eAc13_66kpg>
    <xmx:gju4ZTZEjktGwMRiiQzDheEo4ENR8Yp_X_UTcp5SNvFBbOm9fcR0OQ>
    <xmx:gzu4ZdO7nEQo4Wv95bc4p-kufhhR0d7PECKO6a8nPlgdOguG2AFQUYkR1dU>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 18:57:53 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 3/8] hrtimer: Report offline hrtimer enqueue
Date: Mon, 29 Jan 2024 15:56:36 -0800
Message-ID: <20240129235646.3171983-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129235646.3171983-1-boqun.feng@gmail.com>
References: <20240129235646.3171983-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

The hrtimers migration on CPU-down hotplug process has been moved
earlier, before the CPU actually goes to die. This leaves a small window
of opportunity to queue an hrtimer in a blind spot, leaving it ignored.

For example a practical case has been reported with RCU waking up a
SCHED_FIFO task right before the CPUHP_AP_IDLE_DEAD stage, queuing that
way a sched/rt timer to the local offline CPU.

Make sure such situations never go unnoticed and warn when that happens.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Fixes: 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/hrtimer.h | 3 ++-
 kernel/time/hrtimer.c   | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 87e3bedf8eb0..4f2cf7309486 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -179,7 +179,8 @@ struct hrtimer_cpu_base {
 	unsigned int			hres_active		: 1,
 					in_hrtirq		: 1,
 					hang_detected		: 1,
-					softirq_activated       : 1;
+					softirq_activated       : 1,
+					online			: 1;
 #ifdef CONFIG_HIGH_RES_TIMERS
 	unsigned int			nr_events;
 	unsigned short			nr_retries;
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 760793998cdd..edb0f821dcea 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1085,6 +1085,7 @@ static int enqueue_hrtimer(struct hrtimer *timer,
 			   enum hrtimer_mode mode)
 {
 	debug_activate(timer, mode);
+	WARN_ON_ONCE(!base->cpu_base->online);
 
 	base->cpu_base->active_bases |= 1 << base->index;
 
@@ -2183,6 +2184,7 @@ int hrtimers_prepare_cpu(unsigned int cpu)
 	cpu_base->softirq_next_timer = NULL;
 	cpu_base->expires_next = KTIME_MAX;
 	cpu_base->softirq_expires_next = KTIME_MAX;
+	cpu_base->online = 1;
 	hrtimer_cpu_base_init_expiry_lock(cpu_base);
 	return 0;
 }
@@ -2250,6 +2252,7 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
 	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
 
 	raw_spin_unlock(&new_base->lock);
+	old_base->online = 0;
 	raw_spin_unlock(&old_base->lock);
 
 	return 0;
-- 
2.43.0


