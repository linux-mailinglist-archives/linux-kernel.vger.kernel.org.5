Return-Path: <linux-kernel+bounces-97848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E73F877074
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 11:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C2F1F216A4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 10:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957343A1CC;
	Sat,  9 Mar 2024 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="n0+9Vyxf"
Received: from out203-205-251-82.mail.qq.com (out203-205-251-82.mail.qq.com [203.205.251.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD202125DC
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709980341; cv=none; b=OAA1P6hIAdccX/HwSY1xnkM1D6XmzZQ5EDYtEKn9N76CSbPNi9fNO9BBgk/goj4z/nOlVvZyd9HQfoQ67X/rUKJQmdYU5p0GJYwWY9Bmm10Zi2runYpmpbmaSiRYsR9RFybs2avX7/f0nXqsB/ucn+Wr4udMRbAZ01XB8u1FgvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709980341; c=relaxed/simple;
	bh=eikJ0+Tdca89OWRTtIBWpyzIM5ziWcsWf5MJCl11Qg4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=I9lO3Ao5YGT/xEn94aqf/KDWTwsqoeLjbrng/106i+8EXVZGlXkCicjaMKuvS86hgrg9nAjPzw7uRSnoXcXisnGNnDRJEPh6OgANjR1KAkslpRa99so7v+LKJdAtni5BUH4ZqwZPUCq1vgsM8DARA7mzTQa1RhSQoRsiA786EZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=n0+9Vyxf; arc=none smtp.client-ip=203.205.251.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1709980315;
	bh=0+9AqUFMG2GwHsO7ty2QOUVLIuLEI4pg+sOEo2MDrZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n0+9VyxfxgvUBuLzDW+hhFD3hsNEBVd2PbbYk9A0ZUEVzCFuZ1idSc6XfBw0RC3zl
	 vtI/Lj+brEnqC1YEONOUgjeYeTNNhvAXMkK41FAiOymVjMwVNNKTsoumoE9ZLr6cP7
	 phOa5e06QPvwYLHFO14bV6VXtNK7ln7ivvZ44lIE=
Received: from localhost.localdomain ([2409:8961:2a0b:4ad8:c972:9bc3:984f:98a9])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 7EF8DC9A; Sat, 09 Mar 2024 18:31:47 +0800
X-QQ-mid: xmsmtpt1709980311tbiwcqbjb
Message-ID: <tencent_143077FB953D8B549153BB07F54C5AA4870A@qq.com>
X-QQ-XMAILINFO: MRw/zKT/0BpPbIyJXl3L5UffaHn3EH5N/+LMgQeGCZWkAyf47ocWfOPV5el0dy
	 YkK4HXZmx03lscw0G+At2rOL4XGmMheulKOMg6M1d/ekoivDaseSvyZzFGmq1Vs6BcL46U8i/Q6N
	 uaK6fF7nZ9Q9y9Nu6yJgfOc0et/0sbU9hfQ1l3aLtE/MvcAtWTCbMP/oBDyfZUJkDFvGvRPBTnQu
	 4lsrkjKPHvY3uZZHn//29vfI+yj7QZlU+OXLrzpgPmK7ueq4xOJhXAQssAg0U59h0nlrCQbAvTtb
	 iGPxw2BOZTvyfAL9yxSt7ISrLZ9vSJHLmkwWDF3USfZq4BoyGoIqwD+OkbgXqsZj22DXA/D/fu9C
	 VIlppuZRFFDhdiBurjQ2gQxuBvrQaXCdwhmi5a8EioCP5f6VBTqejqx7RX2WDUW67kJW1+dTfRhe
	 4T52CqiNG1wpEBaDQeU/nrGnSTS1ANIu0bUwuII/+WKZKYaCDkNkPV588e8VjUdQ0qAVSDVo0dFw
	 SNKBGQJKssNcF2VfRSUcIH9zrhQF0fgh0OPquXYyjPb9LRGHiH2yTTGT7YSbsvKKLbyRIBALh136
	 dAGntGWD61cqQ86JW9mPRSd3gsDCx+t6m9zpJWi3BwqvkMUzpOoU9YWfSy4ePTZOPT6m9vFwzqbo
	 aRBY2m6pqqiCgBuCNkBbnkcO1wr732ds6yYH6QHb4kGiO6gv3/JX7VzHVZDsp5K17zU1Gt8KDxxL
	 AJKUEFadRdHe1pFgxIt3RgabnLLTshNL8wYR6kNveDfuRD0w0wxLFllAmePGrOdgZXLibpMOXbe1
	 358lN+v7kQKG6fuy6hpjqcTz0r5X9Wauoe91xOIgLoP6UYIuChhgZ0/5Cxh3hcAgK5MYSMfGA/CE
	 cLSx67db8GaRjT5TM58ZfIVK76fkMKG0JYdBNm+Vo1N3QEX6Y2lac93MeBIAmNnJSYMe1aHOkdvT
	 T78DDME5zFQTc7sG6m3exGZ0klfU3/3PMLkULXMGKBBczodKhzSov9Lzm55NpkMZ2tj3PpxZleAS
	 anWBJlDZlEJiWCGngGLwSQGFhJsuo=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: wenyang.linux@foxmail.com
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	Iurii Zaikin <yzaikin@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] sysctl: support encoding values directly in the table entry
Date: Sat,  9 Mar 2024 18:31:18 +0800
X-OQ-MSGID: <ca973ca6f1ca72c4b2da1b94ccaffe424fcc934a.1709978655.git.wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1709978655.git.wenyang.linux@foxmail.com>
References: <cover.1709978655.git.wenyang.linux@foxmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wenyang.linux@foxmail.com>

Eric points out: "by turning .extra1 and .extra2 into longs instead of
keeping them as pointers and needing constants to be pointed at somewhere
.. The only people I can see who find a significant benefit by
consolidating all of the constants into one place are people who know how
to stomp kernel memory."

This patch supports encoding values directly in table entries through the
following work:
- extra1/extra2 and min/max are placed in one union to ensure that the
  previous code is not broken, then we have time to remove unnecessary
  extra1/extra2 progressively;
- since type only has two states, use one bit to represent it;
- two bits were used to represent the information of the above union( 0:
  using extra1/extra2, 1: using min, 2: using max, 3: using both min/max);
- added some helper macros.

Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Iurii Zaikin <yzaikin@google.com>
Cc: linux-kernel@vger.kernel.org
---
 include/linux/sysctl.h | 108 ++++++++++++++++++++++++++++++++++++++---
 kernel/sysctl.c        |  61 +++++++++++++++++------
 2 files changed, 148 insertions(+), 21 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index ee7d33b89e9e..1ba980219e40 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -61,6 +61,25 @@ extern const int sysctl_vals[];
 
 extern const unsigned long sysctl_long_vals[];
 
+#define	SYSCTL_NUMERIC_NEG_ONE			((long)-1)
+#define	SYSCTL_NUMERIC_ZERO			(0L)
+#define	SYSCTL_NUMERIC_ONE			(1L)
+#define	SYSCTL_NUMERIC_TWO			(2L)
+#define	SYSCTL_NUMERIC_THREE			(3L)
+#define	SYSCTL_NUMERIC_FOUR			(4L)
+#define	SYSCTL_NUMERIC_ONE_HUNDRED		(100L)
+#define	SYSCTL_NUMERIC_TWO_HUNDRED		(200L)
+#define	SYSCTL_NUMERIC_THREE_HUNDRED		(300L)
+#define	SYSCTL_NUMERIC_FIVE_HUNDRED		(500L)
+#define	SYSCTL_NUMERIC_ONE_THOUSAND		(1000L)
+#define	SYSCTL_NUMERIC_TWO_THOUSAND		(2000L)
+#define	SYSCTL_NUMERIC_THREE_THOUSAND		(3000L)
+#define	SYSCTL_NUMERIC_16K			(16384L)
+#define	SYSCTL_NUMERIC_U8_MAX			((long)U8_MAX)
+#define	SYSCTL_NUMERIC_U16_MAX			((long)U16_MAX)
+#define	SYSCTL_NUMERIC_INT_MAX			((long)INT_MAX)
+#define	SYSCTL_NUMERIC_LONG_MAX			(LONG_MAX)
+
 typedef int proc_handler(struct ctl_table *ctl, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 
@@ -131,6 +150,18 @@ static inline void *proc_sys_poll_event(struct ctl_table_poll *poll)
 #define DEFINE_CTL_TABLE_POLL(name)					\
 	struct ctl_table_poll name = __CTL_TABLE_POLL_INITIALIZER(name)
 
+enum {
+	SYSCTL_TABLE_TYPE_DEFAULT,
+	SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY
+};
+
+enum {
+	SYSCTL_TABLE_EXTRA_PTR,
+	SYSCTL_TABLE_EXTRA_LONG_INIT_MIN,
+	SYSCTL_TABLE_EXTRA_LONG_INIT_MAX,
+	SYSCTL_TABLE_EXTRA_LONG_INIT_MINMAX
+};
+
 /* A sysctl table is an array of struct ctl_table: */
 struct ctl_table {
 	const char *procname;		/* Text ID for /proc/sys, or zero */
@@ -138,20 +169,39 @@ struct ctl_table {
 	int maxlen;
 	umode_t mode;
 	/**
-	 * enum type - Enumeration to differentiate between ctl target types
+	 * type - Indicates to differentiate between ctl target types
 	 * @SYSCTL_TABLE_TYPE_DEFAULT: ctl target with no special considerations
 	 * @SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY: Used to identify a permanently
 	 *                                       empty directory target to serve
 	 *                                       as mount point.
 	 */
-	enum {
-		SYSCTL_TABLE_TYPE_DEFAULT,
-		SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY
-	} type;
+	u8 type:1;
+
+	/**
+	 * extra_flags
+	 * @SYSCTL_TABLE_EXTRA_PTR: flag indicating that this uses extra1/extra2.
+	 * @SYSCTL_TABLE_EXTRA_LONG_INIT_MIN: flag indicating that this uses min/max
+					      and min has been initialized.
+	 * @SYSCTL_TABLE_EXTRA_LONG_INIT_MAX: flag indicating that this uses min/max
+					      and max has been initialized.
+	 * @SYSCTL_TABLE_EXTRA_LONG_INIT_MINMAX: flag indicating that this uses min/max
+						 and both have been initialized.
+	 *
+	 */
+	u8 extra_flags:2;
+	union {
+		struct {
+			void *extra1;
+			void *extra2;
+		};
+		struct {
+			long min;
+			long max;
+		};
+	};
+
 	proc_handler *proc_handler;	/* Callback for text formatting */
 	struct ctl_table_poll *poll;
-	void *extra1;
-	void *extra2;
 } __randomize_layout;
 
 struct ctl_node {
@@ -213,6 +263,50 @@ struct ctl_table_root {
 #define register_sysctl(path, table)	\
 	register_sysctl_sz(path, table, ARRAY_SIZE(table))
 
+#define CTL_TABLE_ENTRY(_name, _data, _len, _mode, _func)		      \
+	{								      \
+		.procname = _name,					      \
+		.data = _data,						      \
+		.maxlen = _len,						      \
+		.mode = _mode,						      \
+		.proc_handler = _func,					      \
+		.extra_flags = SYSCTL_TABLE_EXTRA_PTR,			      \
+	}
+
+#define CTL_TABLE_ENTRY_MIN(_name, _data, _len, _mode, _func, _min)	      \
+	{								      \
+		.procname = _name,					      \
+		.data = _data,						      \
+		.maxlen = _len,						      \
+		.mode = _mode,						      \
+		.proc_handler = _func,					      \
+		.min = _min,						      \
+		.extra_flags = SYSCTL_TABLE_EXTRA_LONG_INIT_MIN,	      \
+	}
+
+#define CTL_TABLE_ENTRY_MAX(_name, _data, _len, _mode, _func, _max)	      \
+	{								      \
+		.procname = _name,					      \
+		.data = _data,						      \
+		.maxlen = _len,						      \
+		.mode = _mode,						      \
+		.proc_handler = _func,					      \
+		.max = _max,						      \
+		.extra_flags = SYSCTL_TABLE_EXTRA_LONG_INIT_MAX,	      \
+	}
+
+#define CTL_TABLE_ENTRY_MINMAX(_name, _data, _len, _mode, _func, _min, _max)  \
+	{								      \
+		.procname = _name,					      \
+		.data = _data,						      \
+		.maxlen = _len,						      \
+		.mode = _mode,						      \
+		.proc_handler = _func,					      \
+		.min = _min,						      \
+		.max = _max,						      \
+		.extra_flags = SYSCTL_TABLE_EXTRA_LONG_INIT_MINMAX,	      \
+	}
+
 #ifdef CONFIG_SYSCTL
 
 void proc_sys_poll_notify(struct ctl_table_poll *poll);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 157f7ce2942d..144c441236ab 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -822,6 +822,20 @@ struct do_proc_dointvec_minmax_conv_param {
 	int *max;
 };
 
+static void do_int_conv_param_init(const struct ctl_table *table,
+		struct do_proc_dointvec_minmax_conv_param *param)
+{
+	if (table->extra_flags == SYSCTL_TABLE_EXTRA_PTR) {
+		param->min = table->extra1;
+		param->max = table->extra2;
+	} else {
+		param->min = (table->extra_flags & SYSCTL_TABLE_EXTRA_LONG_INIT_MIN) ?
+			(int *)&table->min : NULL;
+		param->max = (table->extra_flags & SYSCTL_TABLE_EXTRA_LONG_INIT_MAX) ?
+			(int *)&table->max : NULL;
+	}
+}
+
 static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
 					int *valp,
 					int write, void *data)
@@ -867,10 +881,9 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
 int proc_dointvec_minmax(struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct do_proc_dointvec_minmax_conv_param param = {
-		.min = (int *) table->extra1,
-		.max = (int *) table->extra2,
-	};
+	struct do_proc_dointvec_minmax_conv_param param;
+
+	do_int_conv_param_init(table, &param);
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
 				do_proc_dointvec_minmax_conv, &param);
 }
@@ -889,6 +902,20 @@ struct do_proc_douintvec_minmax_conv_param {
 	unsigned int *max;
 };
 
+static void do_uint_conv_param_init(const struct ctl_table *table,
+		struct do_proc_douintvec_minmax_conv_param *param)
+{
+	if (table->extra_flags == SYSCTL_TABLE_EXTRA_PTR) {
+		param->min = table->extra1;
+		param->max = table->extra2;
+	} else {
+		param->min = (table->extra_flags & SYSCTL_TABLE_EXTRA_LONG_INIT_MIN) ?
+			(unsigned int *)&table->min : NULL;
+		param->max = (table->extra_flags & SYSCTL_TABLE_EXTRA_LONG_INIT_MAX) ?
+			(unsigned int *)&table->max : NULL;
+	}
+}
+
 static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
 					 unsigned int *valp,
 					 int write, void *data)
@@ -936,10 +963,9 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
 int proc_douintvec_minmax(struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct do_proc_douintvec_minmax_conv_param param = {
-		.min = (unsigned int *) table->extra1,
-		.max = (unsigned int *) table->extra2,
-	};
+	struct do_proc_douintvec_minmax_conv_param param;
+
+	do_uint_conv_param_init(table, &param);
 	return do_proc_douintvec(table, write, buffer, lenp, ppos,
 				 do_proc_douintvec_minmax_conv, &param);
 }
@@ -1038,8 +1064,16 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table,
 	}
 
 	i = data;
-	min = table->extra1;
-	max = table->extra2;
+	if (table->extra_flags == SYSCTL_TABLE_EXTRA_PTR) {
+		min = table->extra1;
+		max = table->extra2;
+	} else {
+		min = (table->extra_flags & SYSCTL_TABLE_EXTRA_LONG_INIT_MIN) ?
+			&table->min : NULL;
+		max = (table->extra_flags & SYSCTL_TABLE_EXTRA_LONG_INIT_MAX) ?
+			&table->max : NULL;
+	}
+
 	vleft = table->maxlen / sizeof(unsigned long);
 	left = *lenp;
 
@@ -1274,10 +1308,9 @@ int proc_dointvec_jiffies(struct ctl_table *table, int write,
 int proc_dointvec_ms_jiffies_minmax(struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct do_proc_dointvec_minmax_conv_param param = {
-		.min = (int *) table->extra1,
-		.max = (int *) table->extra2,
-	};
+	struct do_proc_dointvec_minmax_conv_param param;
+
+	do_int_conv_param_init(table, &param);
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
 			do_proc_dointvec_ms_jiffies_minmax_conv, &param);
 }
-- 
2.25.1


