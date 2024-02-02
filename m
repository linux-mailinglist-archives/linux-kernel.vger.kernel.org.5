Return-Path: <linux-kernel+bounces-50184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8E2847571
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF18282457
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C885214A4DE;
	Fri,  2 Feb 2024 16:55:47 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72CD1482F9;
	Fri,  2 Feb 2024 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892946; cv=none; b=guLzmureDRzSAcxWAsrgOC18fi10WZdIAFrqPW8A+zqUE1bESRu3wlPMWV8sZLNxyguntWVS9h8uEG6iONFl1oEh4et+v7qeuvZ9qdMYOrw50mLiUDocvECqLFjPZBWGGJxLd8gLSUVUf/ccKBJwTtFK85olzRLOwqd+cB/dUkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892946; c=relaxed/simple;
	bh=JlCUJJrlNMwpfAyPTAHfmtZ32zOXQju1rAABkKeDyPw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hw8UcujIjem568jML2+osPw5FBWUawXEEm/lbRsDwu5k+HbC6HSeBPasYorclTH9dsHsCSUePkCTpjNEIZl5GX+ZvVd6OCTlAvhk9MLOOx5gTA74jLWoGzjS3eDoOHzu2pfTUhjSQTiEdh4hqH4UWxuQnpd6WnhQwACRbypJayI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55f0b2c79cdso2974799a12.3;
        Fri, 02 Feb 2024 08:55:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706892939; x=1707497739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9kBA6RYll1yHORqHcUWb3KGp4YpRu6qlbwxwz32MBXc=;
        b=gljk2R02mNM+MVq1PTP4eXpFnkO4M5T1qj3WNT1VFtpTKn/27GsXsfr+TAEAIvGVic
         N2INND0IHb48FNXeryHkZnUvSU5DJrKnAQooThVZFUxl0JzCLq+cnREEvG2fA5Kc1Z23
         aIXhvp6HzPDjhnbh84evGhi6G5sXIUmrCCZMLg4bN9TbLA4NWOemkpXhc0auFtvVYBqT
         Bb9HIDTP8dqK2XGOOxERHueIP1wi77vSorjN4/t77H9SRVSTzgOWbP7w/uK6YeetmDE5
         b0pcXex2S4LV09nptQE9H1Oq/EkAKocNjau70YqjZq63anZHpLUSdHoo41TTf6iP92gr
         /Aeg==
X-Gm-Message-State: AOJu0Yx1xRe6ZxZu5ZHbKaNqkRPMHHsfKi0Iw/IVhrVhxDW0ubV4gpTT
	uEvQhJ199jScZoArBHpr5W953FJnJwGbjTRL5qGd8kU2mzKtryJ5
X-Google-Smtp-Source: AGHT+IGEVPCJ/cDjUziNPRLJ2nMzwOzV4WtBKListJ1uJjtHmuDHyBygBPpGR1jzq2CBgoqH+GYVJg==
X-Received: by 2002:a05:6402:1857:b0:560:b91:5cac with SMTP id v23-20020a056402185700b005600b915cacmr140743edy.28.1706892938791;
        Fri, 02 Feb 2024 08:55:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV06j+DpSWpn5sdSMeJ2C0OI7OJESfvvar57vkPj/sq3ZHkslPpN9QM26bcSq9L3iqfqhOKIeUaBIIIJ/RUsDnCt6/3b+Y3/pqADpLWjRt9r9E2Dy/AW6OFB2jBQb1ncwxascmHyjaWm7dP+cHlmwegmBdxxo0tQpjd4GKtmCSHbC3ccj56bJ3We6cum8fSOMF5OqA/ScIQxU3CPKR5s+JhGD4DeDbrhWZaRU4+aPySme2KHwz2K+ni1b51Uxf8K0bA5Ez3NvKpaGwDnb3pyjkLr+zL7aG1wVmUTF0sr65oE8sGuRSRHwsAWNNl6Yi4XJ/3owMfwfs2n2nQJVaBIP0F8EjCBWhiP5lE3YLh2Btd8KckUCtQDwIipyX7D/9eOe2Oo8jIVoo6gihX3UwTefKc4IcL5RqXtjL9vu08ex8AfGWoceAdrfmCAcqywlnOruycAQY65vrCCJhQVLKoaovJMgxr3Emhzoe8T5egRAEP4Ep3OkZKph5JLOpJ6DczuOg1DNts2m0vSdUn19ZuGdY7fBdEdW+74BEZybLB8eK+5jhw54A0aUc=
Received: from localhost (fwdproxy-cln-024.fbsv.net. [2a03:2880:31ff:18::face:b00c])
        by smtp.gmail.com with ESMTPSA id n16-20020a05640205d000b0055ff1749b15sm695342edx.66.2024.02.02.08.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 08:55:38 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Johannes Berg <johannes.berg@intel.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: [PATCH net-next v3] net: dqs: add NIC stall detector based on BQL
Date: Fri,  2 Feb 2024 08:53:06 -0800
Message-Id: <20240202165315.2506384-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
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
Changelog:

v1:
  * https://lore.kernel.org/netdev/202306172057.jx7YhLiu-lkp@intel.com/T/

v2:
  * Fix the documentation file in patch 0001, since patch 0002 will
    touch it later.
  * Fix the kernel test robot issues, marking functions as statics.
  * Use #include <linux/bitops.h> instead of <asm/bitops.h>.
  * Added some new comments around, mainly around barriers.
  * Format struct `netdev_queue_attribute` assignments to make
    checkpatch happy.
  * Updated and fixed the path in sysfs-class-net-queues
    documentation.

v3:
  * Sending patch 0002 against net-next.
	- The first patch was accepted against 'net'

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


