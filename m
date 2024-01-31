Return-Path: <linux-kernel+bounces-46224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A55D8843C72
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E87A1F2E558
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6725269D2E;
	Wed, 31 Jan 2024 10:22:16 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B556EB62;
	Wed, 31 Jan 2024 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696535; cv=none; b=b4rknrPFr78QvXuxwb0mTd+9Gy33SrgKfiTdHanr1gH/y2GFonwf9swladjkn6NPnVMSUxw+p0ZLLpazV6PMiJIt4a7ic8beG4YVAjwxqtGiAmBPCOVa0rwiMlLA0DXnm7MLkb0Wn89Rv/UOkQYoK6Y0hFVHfjoemV+2Nr37pvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696535; c=relaxed/simple;
	bh=T1vsAmepTlqmawkNvJrOj+ngTvUlcvT0/0Ypb6ts8PA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bw2bKlDd+9RqjD+DPnMXAUDpau+YVUp7+0mM7lo1YoGaLDhMw9fxRk+S3MP6Jdll7yUKfCcGyxan8HBtIEkYLbhP3epQPeEv8EhnSQUV7gjY1VnsHUWRNS5aQM/KdmkVFW+va4nLDZppUBiJlymL+y273Neow2NK20bFELTRH4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a359446b57dso425265766b.3;
        Wed, 31 Jan 2024 02:22:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706696531; x=1707301331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdY7+JhQ+hEDO4gjPKK5Z2FJcbw7XGSXZ8KUIzLV2Pw=;
        b=moMw+PkUA9P8D22yJHKkcZR157CnEXQXlNw0dOthYDAwHVVex7mrWsVGufQVj7b2wj
         kW33hnLbWmEnR0GHEu938PjzonqANB22Atcg5AT5De3vkdli5ZPw4as6jsfpAiJOGR/0
         wOlT4glFAWs7toRJjBAZfafHiI21CLCVX/TM/0PBtReUNzj4s83W3Px44zIRZGQWuzU+
         1b2V0zow9JIPq+jYKnQT6TDaLSOIjQJhxA6HyxRxLq6R1FfRUtAlSAC+xwm80axQD/LM
         x8J8ysdOkFweswAswsxqNV+RlatIwOPXzcXvaErYLS9LVAYwTGMTtczcbSiB0bDa4soi
         llUw==
X-Gm-Message-State: AOJu0YzJmQgeWNwaP2eK+lVuL303vmI8FkOik71Q1CI5kmgMYtJ8p2+v
	XE6IG5hEexHIZ+13FwjCy/DAtpBJfUUIb1Crw/eKY+01KtWuYp6o
X-Google-Smtp-Source: AGHT+IEQKJENK97MPR0LlYN14bI5xPkRNPVXgLjUseHtmxwuu1p5RN0krfthk9iSA5ToIrKsPtPgyg==
X-Received: by 2002:a17:906:c7ce:b0:a31:818d:4927 with SMTP id dc14-20020a170906c7ce00b00a31818d4927mr798956ejb.42.1706696531364;
        Wed, 31 Jan 2024 02:22:11 -0800 (PST)
Received: from localhost (fwdproxy-cln-010.fbsv.net. [2a03:2880:31ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id ub14-20020a170907c80e00b00a3109a492d4sm5970435ejc.20.2024.01.31.02.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 02:22:11 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Johannes Berg <johannes.berg@intel.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: [PATCH net v2 2/2] net: dqs: add NIC stall detector based on BQL
Date: Wed, 31 Jan 2024 02:21:50 -0800
Message-Id: <20240131102150.728960-3-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131102150.728960-1-leitao@debian.org>
References: <20240131102150.728960-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

softnet_data->time_squeeze is sometimes used as a proxy for
host overload or indication of scheduling problems. In practice
this statistic is very noisy and has hard to grasp units -
e.g. is 10 squeezes a second to be expected, or high?

Delaying network (NAPI) processing leads to drops on NIC queues
but also RTT bloat, impacting pacing and CA decisions.
Stalls are a little hard to detect on the Rx side, because
there may simply have not been any packets received in given
period of time. Packet timestamps help a little bit, but
again we don't know if packets are stale because we're
not keeping up or because someone (*cough* cgroups)
disabled IRQs for a long time.

We can, however, use Tx as a proxy for Rx stalls. Most drivers
use combined Rx+Tx NAPIs so if Tx gets starved so will Rx.
On the Tx side we know exactly when packets get queued,
and completed, so there is no uncertainty.

This patch adds stall checks to BQL. Why BQL? Because
it's a convenient place to add such checks, already
called by most drivers, and it has copious free space
in its structures (this patch adds no extra cache
references or dirtying to the fast path).

The algorithm takes one parameter - max delay AKA stall
threshold and increments a counter whenever NAPI got delayed
for at least that amount of time. It also records the length
of the longest stall.

To be precise every time NAPI has not polled for at least
stall thrs we check if there were any Tx packets queued
between last NAPI run and now - stall_thrs/2.

Unlike the classic Tx watchdog this mechanism does not
ignore stalls caused by Tx being disabled, or loss of link.
I don't think the check is worth the complexity, and
stall is a stall, whether due to host overload, flow
control, link down... doesn't matter much to the application.

We have been running this detector in production at Meta
for 2 years, with the threshold of 8ms. It's the lowest
value where false positives become rare. There's still
a constant stream of reported stalls (especially without
the ksoftirqd deferral patches reverted), those who like
their stall metrics to be 0 may prefer higher value.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 .../ABI/testing/sysfs-class-net-queues        | 23 +++++++
 include/linux/dynamic_queue_limits.h          | 35 +++++++++++
 include/trace/events/napi.h                   | 33 ++++++++++
 lib/dynamic_queue_limits.c                    | 58 +++++++++++++++++
 net/core/net-sysfs.c                          | 62 +++++++++++++++++++
 5 files changed, 211 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-net-queues b/Documentation/ABI/testing/sysfs-class-net-queues
index 5bff64d256c2..45bab9b6e3ae 100644
--- a/Documentation/ABI/testing/sysfs-class-net-queues
+++ b/Documentation/ABI/testing/sysfs-class-net-queues
@@ -96,3 +96,26 @@ Description:
 		Indicates the absolute minimum limit of bytes allowed to be
 		queued on this network device transmit queue. Default value is
 		0.
+
+What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/stall_thrs
+Date:		Jan 2024
+KernelVersion:	6.9
+Contact:	netdev@vger.kernel.org
+Description:
+		Tx completion stall detection threshold. Kernel will guarantee
+		to detect all stalls longer than this threshold but may also
+		detect stalls longer than half of the threshold.
+
+What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/stall_cnt
+Date:		Jan 2024
+KernelVersion:	6.9
+Contact:	netdev@vger.kernel.org
+Description:
+		Number of detected Tx completion stalls.
+
+What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/stall_max
+Date:		Jan 2024
+KernelVersion:	6.9
+Contact:	netdev@vger.kernel.org
+Description:
+		Longest detected Tx completion stall. Write 0 to clear.
diff --git a/include/linux/dynamic_queue_limits.h b/include/linux/dynamic_queue_limits.h
index 407c2f281b64..288e98fe85f0 100644
--- a/include/linux/dynamic_queue_limits.h
+++ b/include/linux/dynamic_queue_limits.h
@@ -38,14 +38,21 @@
 
 #ifdef __KERNEL__
 
+#include <linux/bitops.h>
 #include <asm/bug.h>
 
+#define DQL_HIST_LEN		4
+#define DQL_HIST_ENT(dql, idx)	((dql)->history[(idx) % DQL_HIST_LEN])
+
 struct dql {
 	/* Fields accessed in enqueue path (dql_queued) */
 	unsigned int	num_queued;		/* Total ever queued */
 	unsigned int	adj_limit;		/* limit + num_completed */
 	unsigned int	last_obj_cnt;		/* Count at last queuing */
 
+	unsigned long	history_head;
+	unsigned long	history[DQL_HIST_LEN];
+
 	/* Fields accessed only by completion path (dql_completed) */
 
 	unsigned int	limit ____cacheline_aligned_in_smp; /* Current limit */
@@ -62,6 +69,11 @@ struct dql {
 	unsigned int	max_limit;		/* Max limit */
 	unsigned int	min_limit;		/* Minimum limit */
 	unsigned int	slack_hold_time;	/* Time to measure slack */
+
+	unsigned char	stall_thrs;
+	unsigned char	stall_max;
+	unsigned long	last_reap;
+	unsigned long	stall_cnt;
 };
 
 /* Set some static maximums */
@@ -74,6 +86,8 @@ struct dql {
  */
 static inline void dql_queued(struct dql *dql, unsigned int count)
 {
+	unsigned long map, now, now_hi, i;
+
 	BUG_ON(count > DQL_MAX_OBJECT);
 
 	dql->last_obj_cnt = count;
@@ -86,6 +100,27 @@ static inline void dql_queued(struct dql *dql, unsigned int count)
 	barrier();
 
 	dql->num_queued += count;
+
+	now = jiffies;
+	now_hi = now / BITS_PER_LONG;
+	if (unlikely(now_hi != dql->history_head)) {
+		/* About to reuse slots, clear them */
+		for (i = 0; i < DQL_HIST_LEN; i++) {
+			/* Multiplication masks high bits */
+			if (now_hi * BITS_PER_LONG ==
+			    (dql->history_head + i) * BITS_PER_LONG)
+				break;
+			DQL_HIST_ENT(dql, dql->history_head + i + 1) = 0;
+		}
+		/* pairs with smp_rmb() in dql_check_stall() */
+		smp_wmb();
+		WRITE_ONCE(dql->history_head, now_hi);
+	}
+
+	/* __set_bit() does not guarantee WRITE_ONCE() semantics */
+	map = DQL_HIST_ENT(dql, now_hi);
+	if (!(map & BIT_MASK(now)))
+		WRITE_ONCE(DQL_HIST_ENT(dql, now_hi), map | BIT_MASK(now));
 }
 
 /* Returns how many objects can be queued, < 0 indicates over limit. */
diff --git a/include/trace/events/napi.h b/include/trace/events/napi.h
index 6678cf8b235b..272112ddaaa8 100644
--- a/include/trace/events/napi.h
+++ b/include/trace/events/napi.h
@@ -36,6 +36,39 @@ TRACE_EVENT(napi_poll,
 		  __entry->work, __entry->budget)
 );
 
+TRACE_EVENT(dql_stall_detected,
+
+	TP_PROTO(unsigned int thrs, unsigned int len,
+		 unsigned long last_reap, unsigned long hist_head,
+		 unsigned long now, unsigned long *hist),
+
+	TP_ARGS(thrs, len, last_reap, hist_head, now, hist),
+
+	TP_STRUCT__entry(
+		__field(	unsigned int,		thrs)
+		__field(	unsigned int,		len)
+		__field(	unsigned long,		last_reap)
+		__field(	unsigned long,		hist_head)
+		__field(	unsigned long,		now)
+		__array(	unsigned long,		hist, 4)
+	),
+
+	TP_fast_assign(
+		__entry->thrs = thrs;
+		__entry->len = len;
+		__entry->last_reap = last_reap;
+		__entry->hist_head = hist_head * BITS_PER_LONG;
+		__entry->now = now;
+		memcpy(__entry->hist, hist, sizeof(entry->hist));
+	),
+
+	TP_printk("thrs %u  len %u  last_reap %lu  hist_head %lu  now %lu  hist %016lx %016lx %016lx %016lx",
+		  __entry->thrs, __entry->len,
+		  __entry->last_reap, __entry->hist_head, __entry->now,
+		  __entry->hist[0], __entry->hist[1],
+		  __entry->hist[2], __entry->hist[3])
+);
+
 #undef NO_DEV
 
 #endif /* _TRACE_NAPI_H */
diff --git a/lib/dynamic_queue_limits.c b/lib/dynamic_queue_limits.c
index fde0aa244148..162d30ae542c 100644
--- a/lib/dynamic_queue_limits.c
+++ b/lib/dynamic_queue_limits.c
@@ -10,10 +10,61 @@
 #include <linux/dynamic_queue_limits.h>
 #include <linux/compiler.h>
 #include <linux/export.h>
+#include <trace/events/napi.h>
 
 #define POSDIFF(A, B) ((int)((A) - (B)) > 0 ? (A) - (B) : 0)
 #define AFTER_EQ(A, B) ((int)((A) - (B)) >= 0)
 
+static void dql_check_stall(struct dql *dql)
+{
+	unsigned long stall_thrs, now;
+
+	/* If we detect a stall see if anything was queued */
+	stall_thrs = READ_ONCE(dql->stall_thrs);
+	if (!stall_thrs)
+		return;
+
+	now = jiffies;
+	if (time_after_eq(now, dql->last_reap + stall_thrs)) {
+		unsigned long hist_head, t, start, end;
+
+		/* We are trying to detect a period of at least @stall_thrs
+		 * jiffies without any Tx completions, but during first half
+		 * of which some Tx was posted.
+		 */
+dqs_again:
+		hist_head = READ_ONCE(dql->history_head);
+		/* pairs with smp_wmb() in dql_queued() */
+		smp_rmb();
+		/* oldest sample since last reap */
+		start = (hist_head - DQL_HIST_LEN + 1) * BITS_PER_LONG;
+		if (time_before(start, dql->last_reap + 1))
+			start = dql->last_reap + 1;
+		/* newest sample we should have already seen a completion for */
+		end = hist_head * BITS_PER_LONG + (BITS_PER_LONG - 1);
+		if (time_before(now, end + stall_thrs / 2))
+			end = now - stall_thrs / 2;
+
+		for (t = start; time_before_eq(t, end); t++)
+			if (test_bit(t % (DQL_HIST_LEN * BITS_PER_LONG),
+				     dql->history))
+				break;
+		if (!time_before_eq(t, end))
+			goto no_stall;
+		if (hist_head != READ_ONCE(dql->history_head))
+			goto dqs_again;
+
+		dql->stall_cnt++;
+		dql->stall_max = max_t(unsigned int, dql->stall_max, now - t);
+
+		trace_dql_stall_detected(dql->stall_thrs, now - t,
+					 dql->last_reap, dql->history_head,
+					 now, dql->history);
+	}
+no_stall:
+	dql->last_reap = now;
+}
+
 /* Records completed count and recalculates the queue limit */
 void dql_completed(struct dql *dql, unsigned int count)
 {
@@ -110,6 +161,8 @@ void dql_completed(struct dql *dql, unsigned int count)
 	dql->prev_last_obj_cnt = dql->last_obj_cnt;
 	dql->num_completed = completed;
 	dql->prev_num_queued = num_queued;
+
+	dql_check_stall(dql);
 }
 EXPORT_SYMBOL(dql_completed);
 
@@ -125,6 +178,10 @@ void dql_reset(struct dql *dql)
 	dql->prev_ovlimit = 0;
 	dql->lowest_slack = UINT_MAX;
 	dql->slack_start_time = jiffies;
+
+	dql->last_reap = jiffies;
+	dql->history_head = jiffies / BITS_PER_LONG;
+	memset(dql->history, 0, sizeof(dql->history));
 }
 EXPORT_SYMBOL(dql_reset);
 
@@ -133,6 +190,7 @@ void dql_init(struct dql *dql, unsigned int hold_time)
 	dql->max_limit = DQL_MAX_LIMIT;
 	dql->min_limit = 0;
 	dql->slack_hold_time = hold_time;
+	dql->stall_thrs = 0;
 	dql_reset(dql);
 }
 EXPORT_SYMBOL(dql_init);
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index a09d507c5b03..94a622b0bb55 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1409,6 +1409,65 @@ static struct netdev_queue_attribute bql_hold_time_attribute __ro_after_init
 	= __ATTR(hold_time, 0644,
 		 bql_show_hold_time, bql_set_hold_time);
 
+static ssize_t bql_show_stall_thrs(struct netdev_queue *queue, char *buf)
+{
+	struct dql *dql = &queue->dql;
+
+	return sprintf(buf, "%u\n", jiffies_to_msecs(dql->stall_thrs));
+}
+
+static ssize_t bql_set_stall_thrs(struct netdev_queue *queue,
+				  const char *buf, size_t len)
+{
+	struct dql *dql = &queue->dql;
+	unsigned int value;
+	int err;
+
+	err = kstrtouint(buf, 10, &value);
+	if (err < 0)
+		return err;
+
+	value = msecs_to_jiffies(value);
+	if (value && (value < 4 || value > 4 / 2 * BITS_PER_LONG))
+		return -ERANGE;
+
+	if (!dql->stall_thrs && value)
+		dql->last_reap = jiffies;
+	/* Force last_reap to be live */
+	smp_wmb();
+	dql->stall_thrs = value;
+
+	return len;
+}
+
+static struct netdev_queue_attribute bql_stall_thrs_attribute __ro_after_init =
+	__ATTR(stall_thrs, 0644, bql_show_stall_thrs, bql_set_stall_thrs);
+
+static ssize_t bql_show_stall_max(struct netdev_queue *queue, char *buf)
+{
+	return sprintf(buf, "%u\n", READ_ONCE(queue->dql.stall_max));
+}
+
+static ssize_t bql_set_stall_max(struct netdev_queue *queue,
+				 const char *buf, size_t len)
+{
+	WRITE_ONCE(queue->dql.stall_max, 0);
+	return len;
+}
+
+static struct netdev_queue_attribute bql_stall_max_attribute __ro_after_init =
+	__ATTR(stall_max, 0644, bql_show_stall_max, bql_set_stall_max);
+
+static ssize_t bql_show_stall_cnt(struct netdev_queue *queue, char *buf)
+{
+	struct dql *dql = &queue->dql;
+
+	return sprintf(buf, "%lu\n", dql->stall_cnt);
+}
+
+static struct netdev_queue_attribute bql_stall_cnt_attribute __ro_after_init =
+	__ATTR(stall_cnt, 0444, bql_show_stall_cnt, NULL);
+
 static ssize_t bql_show_inflight(struct netdev_queue *queue,
 				 char *buf)
 {
@@ -1447,6 +1506,9 @@ static struct attribute *dql_attrs[] __ro_after_init = {
 	&bql_limit_min_attribute.attr,
 	&bql_hold_time_attribute.attr,
 	&bql_inflight_attribute.attr,
+	&bql_stall_thrs_attribute.attr,
+	&bql_stall_cnt_attribute.attr,
+	&bql_stall_max_attribute.attr,
 	NULL
 };
 
-- 
2.34.1


