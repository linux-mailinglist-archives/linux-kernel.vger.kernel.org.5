Return-Path: <linux-kernel+bounces-43653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55497841736
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09DA2285615
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9849715B0EE;
	Mon, 29 Jan 2024 23:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEDcVO7r"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83B615AAC0;
	Mon, 29 Jan 2024 23:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706572686; cv=none; b=NlSpQCRLMskL73wReGJFUIVUpwPrAZMaTlp2Y743nRICypTPrllPSfUp+6txpR7BztPwvpaQCDW3RVRFeoOWgB2kXcZXpJvMqOcFrSd5563qJs4fSQq3+BFM/IBLs6BTd34xt/ZyWrxj1x5EzwUj3O+UhkCq4hvJ/4+tLgHyC7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706572686; c=relaxed/simple;
	bh=Em2cjsDyOyyQtPmPzZIfTfBTNFyeVb8OtzieQtItHHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pp7ppHUDGGBUgQPuPzRi4qJoeTk0qbFtvTBIvaQpZFVx0/TCyvosdNcxwHZ9+lgdrt8rrv/8/vTL27PyqPOaRybo/SZEX5xT7JJ2TPY1p2oPJNnlWkqRKZjziUEO0SUw4SXQqZq92dvw8PPbY0j1oi6c+1dZwGDg9c0Z23orQug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEDcVO7r; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5ff7ec8772dso36030647b3.0;
        Mon, 29 Jan 2024 15:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706572684; x=1707177484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FvBMwQV9kwBe6aYcqyPefAaNSO13dPoA39g2ZuWvfGs=;
        b=ZEDcVO7rWI2bgZQkot06J0ZDgUWovKpO7y2yLpozD+LGr4tr0pPtVfKPrKoz+2XDtY
         1DuuJRBVcNUGoAE54xZZbmLfDZN4EOTwOKZd5pIkONZ4solZsAIwzyGgfbxH1mO+RAGn
         YtkaZevnPnK59twLedC6pMeZAUs/coIoZcjfLqPUxirAjVzmPT4JvMXQ7G3n4yhfDZoe
         3HRwvXrWZc/ixKxkFAvm6tPHJwvwDw+dbuwrGuWzvnbJTeeXKnvGIYcElv2SCZKE6uFu
         SEKvawq19UKkJQxsNeLNt4y5E7n9Bxn6mPOxElH9cG48YbBxhXshSg6oLjkuqZQFtynQ
         e5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706572684; x=1707177484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FvBMwQV9kwBe6aYcqyPefAaNSO13dPoA39g2ZuWvfGs=;
        b=vP8ZSTAocCqFsXvwPj1a5e6qRDfU9x/P3pBXPZ9R0LpMhWYIBfIQl3m2Vd21eJzedd
         4tziJcyzcAo9BNGuCT5I0VbcLeo4oXmM400J54iDuk6kfpqOssarPoMxu6f8vty3pYkb
         hzBk9OWZm2EnqZfQTPZLWFhiioDZvK49T3MhuFc2yE+SmodAJsbCQKBeObF1/BNMh/k3
         BDQe6EuDnPGrtoI8l6yXoQ4vXbV+M7XeHaLVEVcsEpDpkSzrdkCmHvEIQpbQcL8tbJT8
         7qmK88zXRGYbY2F1zwqkakQ0ZQUMOZm84OFTFjk5sYJPDSH/PmHlRPEUajVfeZvW2qaR
         gETA==
X-Gm-Message-State: AOJu0Yy8aLiAkQzNb49xQtm54XRU8Vy3z4ZH4sTazcoJsHFcs53NtdJL
	XrknVN1yDYphL5bMeVkM14bCs4Ghi0hYfl36G9BUjwZeksglhz3L
X-Google-Smtp-Source: AGHT+IHmldyB80PyjDcG5TUILKLTse81adMNiaXcTpn5NTMbzw2y6vXQgb7Ik/MpbBvpWb1u1MucLw==
X-Received: by 2002:a81:e241:0:b0:602:d1f2:3d1b with SMTP id z1-20020a81e241000000b00602d1f23d1bmr5192289ywl.3.1706572683653;
        Mon, 29 Jan 2024 15:58:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXV4dV4dN+vjMMdWgRKwpKJi4E7Jj/KVcr9gKOFuojfhDJ1EVcYRr0TGm7Q3UYYy5rRSo7W3gQn89b1koDPRKfi4K75Db4SbAMyQLcTBdLkl2CrVVahgP9A5TKe2OVPBg+pNfzGWNZajJ7gMN/6r+1j+4wLFIJaIbHP0Va6WJSI9sPf3JDrayatftEs+VF/VZ2Sk3Bn3VMo7vev5X9lPOfguy4Gok39
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id fc6-20020a05622a488600b004299f302a7csm3630433qtb.23.2024.01.29.15.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 15:58:03 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id 0690A27C0061;
	Mon, 29 Jan 2024 18:58:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 29 Jan 2024 18:58:03 -0500
X-ME-Sender: <xms:iju4ZePP5ZgQAYE2kwk77pNjkwtqkw1BTnl3EcrzFY-lp77DQznrpg>
    <xme:iju4Zc-R2VnafGu_P4cNmkVjKbkTlXprv6B0iATXQlZPPqespbqAknuvXKIGOZuS0
    dyfqHEBdYtIRShT3g>
X-ME-Received: <xmr:iju4ZVRn15676acDL9Tw0v2OFoEvRCQJVmyGkQ0Fy17gJQ9uchVQkdmK4pZF1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedthedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:iju4Zevi34aZSOHXmoUNPHBdjAld543RmXOG3Mdjer7i2yPzYR284w>
    <xmx:iju4ZWeEGsqcrUybBkTccZjJEf7rgCeG1Amj1bYInVX6b9oTiwlfKQ>
    <xmx:iju4ZS2GGcKsjo1_04W2PiWayVuGXqwpdzALTjm4OmTC7w0FukDJTw>
    <xmx:izu4Zcstlycu-B88c4v8NaYndEKeUoRH1jZLMitWNm_V6fRm_w3mnA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 18:58:02 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Jiri Wiesner <jwiesner@suse.de>,
	Feng Tang <feng.tang@intel.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 7/8] clocksource: Skip watchdog check for large watchdog intervals
Date: Mon, 29 Jan 2024 15:56:40 -0800
Message-ID: <20240129235646.3171983-8-boqun.feng@gmail.com>
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

From: Jiri Wiesner <jwiesner@suse.de>

There have been reports of the watchdog marking clocksources unstable on
machines with 8 NUMA nodes:
> clocksource: timekeeping watchdog on CPU373: Marking clocksource 'tsc' as unstable because the skew is too large:
> clocksource:   'hpet' wd_nsec: 14523447520 wd_now: 5a749706 wd_last: 45adf1e0 mask: ffffffff
> clocksource:   'tsc' cs_nsec: 14524115132 cs_now: 515ce2c5a96caa cs_last: 515cd9a9d83918 mask: ffffffffffffffff
> clocksource:   'tsc' is current clocksource.
> tsc: Marking TSC unstable due to clocksource watchdog
> TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
> sched_clock: Marking unstable (1950347883333462, 79649632569)<-(1950428279338308, -745776594)
> clocksource: Checking clocksource tsc synchronization from CPU 400 to CPUs 0,46,52,54,138,208,392,397.
> clocksource: Switched to clocksource hpet

The measured clocksource skew - the absolute difference between cs_nsec
and wd_nsec - was 668 microseconds:
> cs_nsec - wd_nsec = 14524115132 - 14523447520 = 667612

The kernel (based on 5.14.21) used 200 microseconds for the
uncertainty_margin of both the clocksource and watchdog, resulting in a
threshold of 400 microseconds (the md variable). Both the cs_nsec and the
wd_nsec value indicate that the readout interval was circa 14.5 seconds.
The observed behaviour is that watchdog checks failed for large readout
intervals on 8 NUMA node machines. This indicates that the size of the
skew was directly proportinal to the length of the readout interval on
those machines. The measured clocksource skew, 668 microseconds, was
evaluated against a threshold (the md variable) that is suited for
readout intervals of roughly WATCHDOG_INTERVAL, i.e. HZ >> 1, which is
0.5 second.

The intention of 2e27e793e280 ("clocksource: Reduce clocksource-skew
threshold") was to tighten the threshold for evaluating skew and set the
lower bound for the uncertainty_margin of clocksources to twice
WATCHDOG_MAX_SKEW. Later in c37e85c135ce ("clocksource: Loosen clocksource
watchdog constraints"), the WATCHDOG_MAX_SKEW constant was increased to
125 microseconds to fit the limit of NTP, which is able to use a
clocksource that suffers from up to 500 microseconds of skew per second.
Both the TSC and the HPET use default uncertainty_margin. When the
readout interval gets stretched the default uncertainty_margin is no
longer a suitable lower bound for evaluating skew - it imposes a limit
that is far stricter than the skew with which NTP can deal.

The root causes of the skew being directly proportinal to the length of
the readout interval are
* the inaccuracy of the shift/mult pairs of clocksources and the watchdog
* the conversion to nanoseconds is imprecise for large readout intervals

Prevent this by skipping the current watchdog check if the readout
interval exceeds 2 * WATCHDOG_INTERVAL. Considering the maximum readout
interval of 2 * WATCHDOG_INTERVAL, the current default uncertainty margin
(of the TSC and HPET) corresponds to a limit on clocksource skew of 250
ppm (microseconds of skew per second).  To keep the limit imposed by NTP
(500 microseconds of skew per second) for all possible readout intervals,
the margins would have to be scaled so that the threshold value is
proportional to the length of the actual readout interval.

As for why the readout interval may get stretched: Since the watchdog is
executed in softirq context the expiration of the watchdog timer can get
severely delayed on account of a ksoftirqd thread not getting to run in a
timely manner. Surely, a system with such belated softirq execution is not
working well and the scheduling issue should be looked into but the
clocksource watchdog should be able to deal with it accordingly.

Fixes: 2e27e793e280 ("clocksource: Reduce clocksource-skew threshold")
Suggested-by: Feng Tang <feng.tang@intel.com>
Reviewed-by: Feng Tang <feng.tang@intel.com>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Jiri Wiesner <jwiesner@suse.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/time/clocksource.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index c108ed8a9804..3052b1f1168e 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -99,6 +99,7 @@ static u64 suspend_start;
  * Interval: 0.5sec.
  */
 #define WATCHDOG_INTERVAL (HZ >> 1)
+#define WATCHDOG_INTERVAL_MAX_NS ((2 * WATCHDOG_INTERVAL) * (NSEC_PER_SEC / HZ))
 
 /*
  * Threshold: 0.0312s, when doubled: 0.0625s.
@@ -134,6 +135,7 @@ static DECLARE_WORK(watchdog_work, clocksource_watchdog_work);
 static DEFINE_SPINLOCK(watchdog_lock);
 static int watchdog_running;
 static atomic_t watchdog_reset_pending;
+static int64_t watchdog_max_interval;
 
 static inline void clocksource_watchdog_lock(unsigned long *flags)
 {
@@ -399,8 +401,8 @@ static inline void clocksource_reset_watchdog(void)
 static void clocksource_watchdog(struct timer_list *unused)
 {
 	u64 csnow, wdnow, cslast, wdlast, delta;
+	int64_t wd_nsec, cs_nsec, interval;
 	int next_cpu, reset_pending;
-	int64_t wd_nsec, cs_nsec;
 	struct clocksource *cs;
 	enum wd_read_status read_ret;
 	unsigned long extra_wait = 0;
@@ -470,6 +472,27 @@ static void clocksource_watchdog(struct timer_list *unused)
 		if (atomic_read(&watchdog_reset_pending))
 			continue;
 
+		/*
+		 * The processing of timer softirqs can get delayed (usually
+		 * on account of ksoftirqd not getting to run in a timely
+		 * manner), which causes the watchdog interval to stretch.
+		 * Skew detection may fail for longer watchdog intervals
+		 * on account of fixed margins being used.
+		 * Some clocksources, e.g. acpi_pm, cannot tolerate
+		 * watchdog intervals longer than a few seconds.
+		 */
+		interval = max(cs_nsec, wd_nsec);
+		if (unlikely(interval > WATCHDOG_INTERVAL_MAX_NS)) {
+			if (system_state > SYSTEM_SCHEDULING &&
+			    interval > 2 * watchdog_max_interval) {
+				watchdog_max_interval = interval;
+				pr_warn("Long readout interval, skipping watchdog check: cs_nsec: %lld wd_nsec: %lld\n",
+					cs_nsec, wd_nsec);
+			}
+			watchdog_timer.expires = jiffies;
+			continue;
+		}
+
 		/* Check the deviation from the watchdog clocksource. */
 		md = cs->uncertainty_margin + watchdog->uncertainty_margin;
 		if (abs(cs_nsec - wd_nsec) > md) {
-- 
2.43.0


