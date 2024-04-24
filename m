Return-Path: <linux-kernel+bounces-157089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 982228B0CB2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6E91C233B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3005115E809;
	Wed, 24 Apr 2024 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOSLujcL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183A315EFCA;
	Wed, 24 Apr 2024 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969430; cv=none; b=Hs+vOc04G32XpcAd9Bjm6hivOAmx/U9zL1oebJ2ghgcQpHFESPZsxOEpQ7ZH211mFdHjClTkvO8ONB+78DSxNlh9Q5RIXl7hbtG9fshyrHPL3jK/edVM8vrwk0tuXJaZawBrvjJ3umtnr7cEkRqujZg1BwIRUsGTkb6bcdY84Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969430; c=relaxed/simple;
	bh=Y0PLM7xKWAYdtTO7V/Lt4sk7BQtoBLnoOXwBy12pTJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJovcW29XZxBOjaHCHKOG2kMbppULirzdC4XG85RioiT68H/pd68DW9sxTrMLFJDa+arg9c7ndPQYdfhZ+eMxp4N5iU7f60F36+HkVaTrwyFmoVKUS+CP5hynuiS8Dq3AD2n3WxtEIi5+YEMVeiIMw++e/FkqBf9rsBA2FrnuCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOSLujcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBF6C32782;
	Wed, 24 Apr 2024 14:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713969429;
	bh=Y0PLM7xKWAYdtTO7V/Lt4sk7BQtoBLnoOXwBy12pTJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hOSLujcLJgDonPQZE05jo62+gQLVWW7rVFbG0iNColA6YWkgBCYE4ULYzCrb0rPCj
	 ILqO89ck/k9GS1BVHLUCeGwyS3BICo6tWmuYQd7DVdi5wLW4EOln915UNuHKGUf4cR
	 bBRuBP97p7uAAm0kx8fcg5vfe9I6nXs6gAdecxzZQ1m3BVqXS1qvc/7Z1nS+oTB9TY
	 NH9WXKQeA0e2TXE4QaY8RBB36v8c3aSiFI1rg/KTtXAn4oLc5D0HW0bpHihg3bl4H7
	 WGzYyXocincuCda2JVmX/CEj/GqO6c8F5zQwrTI/AHhJFYgO+FsR6E+Q/XTl+86e+0
	 oku/EZFMH7D2g==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/8] rtla/auto-analysis: Replace \t with spaces
Date: Wed, 24 Apr 2024 16:36:51 +0200
Message-ID: <ec7ed2b2809c22ab0dfc8eb7c805ab9cddc4254a.1713968967.git.bristot@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713968967.git.bristot@kernel.org>
References: <cover.1713968967.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When copying timerlat auto-analysis from a terminal to some web pages or
chats, the \t are being replaced with a single ' ' or '    ', breaking
the output.

For example:
  ## CPU 3 hit stop tracing, analyzing it ##
    IRQ handler delay:                        1.30 us (0.11 %)
    IRQ latency:           1.90 us
    Timerlat IRQ duration:         3.00 us (0.24 %)
    Blocking thread:       1223.16 us (99.00 %)
                     insync:4048         1223.16 us
    IRQ interference          4.93 us (0.40 %)
                local_timer:236        4.93 us
  ------------------------------------------------------------------------
     Thread latency:       1235.47 us (100%)

Replace \t with spaces to avoid this problem.

Cc: stable@vger.kernel.org
Fixes: 27e348b221f6 ("rtla/timerlat: Add auto-analysis core")
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/timerlat_aa.c | 109 ++++++++++++++++-----------
 1 file changed, 63 insertions(+), 46 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_aa.c b/tools/tracing/rtla/src/timerlat_aa.c
index 7093fd5333be..7bd80ee2a5b4 100644
--- a/tools/tracing/rtla/src/timerlat_aa.c
+++ b/tools/tracing/rtla/src/timerlat_aa.c
@@ -16,6 +16,9 @@ enum timelat_state {
 	TIMERLAT_WAITING_THREAD,
 };
 
+/* Used to fill spaces in the output */
+static const char *spaces  = "                                                         ";
+
 #define MAX_COMM		24
 
 /*
@@ -274,14 +277,17 @@ static int timerlat_aa_nmi_handler(struct trace_seq *s, struct tep_record *recor
 		taa_data->prev_irq_timstamp = start;
 
 		trace_seq_reset(taa_data->prev_irqs_seq);
-		trace_seq_printf(taa_data->prev_irqs_seq, "\t%24s	\t\t\t%9.2f us\n",
-			 "nmi", ns_to_usf(duration));
+		trace_seq_printf(taa_data->prev_irqs_seq, "  %24s %.*s %9.2f us\n",
+				 "nmi",
+				 24, spaces,
+				 ns_to_usf(duration));
 		return 0;
 	}
 
 	taa_data->thread_nmi_sum += duration;
-	trace_seq_printf(taa_data->nmi_seq, "	%24s	\t\t\t%9.2f us\n",
-		 "nmi", ns_to_usf(duration));
+	trace_seq_printf(taa_data->nmi_seq, "  %24s %.*s %9.2f us\n",
+			 "nmi",
+			 24, spaces, ns_to_usf(duration));
 
 	return 0;
 }
@@ -323,8 +329,10 @@ static int timerlat_aa_irq_handler(struct trace_seq *s, struct tep_record *recor
 		taa_data->prev_irq_timstamp = start;
 
 		trace_seq_reset(taa_data->prev_irqs_seq);
-		trace_seq_printf(taa_data->prev_irqs_seq, "\t%24s:%-3llu	\t\t%9.2f us\n",
-				 desc, vector, ns_to_usf(duration));
+		trace_seq_printf(taa_data->prev_irqs_seq, "  %24s:%-3llu %.*s %9.2f us\n",
+				 desc, vector,
+				 15, spaces,
+				 ns_to_usf(duration));
 		return 0;
 	}
 
@@ -372,8 +380,10 @@ static int timerlat_aa_irq_handler(struct trace_seq *s, struct tep_record *recor
 	 * IRQ interference.
 	 */
 	taa_data->thread_irq_sum += duration;
-	trace_seq_printf(taa_data->irqs_seq, "	%24s:%-3llu	\t	%9.2f us\n",
-			 desc, vector, ns_to_usf(duration));
+	trace_seq_printf(taa_data->irqs_seq, "  %24s:%-3llu %.*s %9.2f us\n",
+			 desc, vector,
+			 24, spaces,
+			 ns_to_usf(duration));
 
 	return 0;
 }
@@ -408,8 +418,10 @@ static int timerlat_aa_softirq_handler(struct trace_seq *s, struct tep_record *r
 
 	taa_data->thread_softirq_sum += duration;
 
-	trace_seq_printf(taa_data->softirqs_seq, "\t%24s:%-3llu	\t	%9.2f us\n",
-			 softirq_name[vector], vector, ns_to_usf(duration));
+	trace_seq_printf(taa_data->softirqs_seq, "  %24s:%-3llu %.*s %9.2f us\n",
+			 softirq_name[vector], vector,
+			 24, spaces,
+			 ns_to_usf(duration));
 	return 0;
 }
 
@@ -452,8 +464,10 @@ static int timerlat_aa_thread_handler(struct trace_seq *s, struct tep_record *re
 	} else {
 		taa_data->thread_thread_sum += duration;
 
-		trace_seq_printf(taa_data->threads_seq, "\t%24s:%-3llu	\t\t%9.2f us\n",
-			 comm, pid, ns_to_usf(duration));
+		trace_seq_printf(taa_data->threads_seq, "  %24s:%-12llu %.*s %9.2f us\n",
+				 comm, pid,
+				 15, spaces,
+				 ns_to_usf(duration));
 	}
 
 	return 0;
@@ -482,7 +496,8 @@ static int timerlat_aa_stack_handler(struct trace_seq *s, struct tep_record *rec
 			function = tep_find_function(taa_ctx->tool->trace.tep, caller[i]);
 			if (!function)
 				break;
-			trace_seq_printf(taa_data->stack_seq, "\t\t-> %s\n", function);
+			trace_seq_printf(taa_data->stack_seq, " %.*s -> %s\n",
+					 14, spaces, function);
 		}
 	}
 	return 0;
@@ -568,23 +583,24 @@ static void timerlat_thread_analysis(struct timerlat_aa_data *taa_data, int cpu,
 	exp_irq_ts = taa_data->timer_irq_start_time - taa_data->timer_irq_start_delay;
 	if (exp_irq_ts < taa_data->prev_irq_timstamp + taa_data->prev_irq_duration) {
 		if (taa_data->prev_irq_timstamp < taa_data->timer_irq_start_time)
-			printf("  Previous IRQ interference:	\t\t up to  %9.2f us\n",
-				ns_to_usf(taa_data->prev_irq_duration));
+			printf("  Previous IRQ interference: %.*s up to  %9.2f us\n",
+			       16, spaces,
+			       ns_to_usf(taa_data->prev_irq_duration));
 	}
 
 	/*
 	 * The delay that the IRQ suffered before starting.
 	 */
-	printf("  IRQ handler delay:		%16s	%9.2f us (%.2f %%)\n",
-		(ns_to_usf(taa_data->timer_exit_from_idle) > 10) ? "(exit from idle)" : "",
-		ns_to_usf(taa_data->timer_irq_start_delay),
-		ns_to_per(total, taa_data->timer_irq_start_delay));
+	printf("  IRQ handler delay: %.*s %16s  %9.2f us (%.2f %%)\n", 16, spaces,
+	       (ns_to_usf(taa_data->timer_exit_from_idle) > 10) ? "(exit from idle)" : "",
+	       ns_to_usf(taa_data->timer_irq_start_delay),
+	       ns_to_per(total, taa_data->timer_irq_start_delay));
 
 	/*
 	 * Timerlat IRQ.
 	 */
-	printf("  IRQ latency:	\t\t\t\t	%9.2f us\n",
-		ns_to_usf(taa_data->tlat_irq_latency));
+	printf("  IRQ latency: %.*s %9.2f us\n", 40, spaces,
+	       ns_to_usf(taa_data->tlat_irq_latency));
 
 	if (irq) {
 		/*
@@ -595,15 +611,16 @@ static void timerlat_thread_analysis(struct timerlat_aa_data *taa_data, int cpu,
 		 * so it will be displayed, it is the key.
 		 */
 		printf("  Blocking thread:\n");
-		printf("	%24s:%-9llu\n",
-			taa_data->run_thread_comm, taa_data->run_thread_pid);
+		printf(" %.*s %24s:%-9llu\n", 6, spaces, taa_data->run_thread_comm,
+		       taa_data->run_thread_pid);
 	} else  {
 		/*
 		 * The duration of the IRQ handler that handled the timerlat IRQ.
 		 */
-		printf("  Timerlat IRQ duration:	\t\t	%9.2f us (%.2f %%)\n",
-			ns_to_usf(taa_data->timer_irq_duration),
-			ns_to_per(total, taa_data->timer_irq_duration));
+		printf("  Timerlat IRQ duration: %.*s %9.2f us (%.2f %%)\n",
+		       30, spaces,
+		       ns_to_usf(taa_data->timer_irq_duration),
+		       ns_to_per(total, taa_data->timer_irq_duration));
 
 		/*
 		 * The amount of time that the current thread postponed the scheduler.
@@ -611,13 +628,13 @@ static void timerlat_thread_analysis(struct timerlat_aa_data *taa_data, int cpu,
 		 * Recalling that it is net from NMI/IRQ/Softirq interference, so there
 		 * is no need to compute values here.
 		 */
-		printf("  Blocking thread:	\t\t\t	%9.2f us (%.2f %%)\n",
-			ns_to_usf(taa_data->thread_blocking_duration),
-			ns_to_per(total, taa_data->thread_blocking_duration));
+		printf("  Blocking thread: %.*s %9.2f us (%.2f %%)\n", 36, spaces,
+		       ns_to_usf(taa_data->thread_blocking_duration),
+		       ns_to_per(total, taa_data->thread_blocking_duration));
 
-		printf("	%24s:%-9llu		%9.2f us\n",
-			taa_data->run_thread_comm, taa_data->run_thread_pid,
-			ns_to_usf(taa_data->thread_blocking_duration));
+		printf(" %.*s %24s:%-9llu %.*s %9.2f us\n", 6, spaces,
+		       taa_data->run_thread_comm, taa_data->run_thread_pid,
+		       12, spaces, ns_to_usf(taa_data->thread_blocking_duration));
 	}
 
 	/*
@@ -629,9 +646,9 @@ static void timerlat_thread_analysis(struct timerlat_aa_data *taa_data, int cpu,
 	 * NMIs can happen during the IRQ, so they are always possible.
 	 */
 	if (taa_data->thread_nmi_sum)
-		printf("  NMI interference	\t\t\t	%9.2f us (%.2f %%)\n",
-			ns_to_usf(taa_data->thread_nmi_sum),
-			ns_to_per(total, taa_data->thread_nmi_sum));
+		printf("  NMI interference %.*s %9.2f us (%.2f %%)\n", 36, spaces,
+		       ns_to_usf(taa_data->thread_nmi_sum),
+		       ns_to_per(total, taa_data->thread_nmi_sum));
 
 	/*
 	 * If it is an IRQ latency, the other factors can be skipped.
@@ -643,9 +660,9 @@ static void timerlat_thread_analysis(struct timerlat_aa_data *taa_data, int cpu,
 	 * Prints the interference caused by IRQs to the thread latency.
 	 */
 	if (taa_data->thread_irq_sum) {
-		printf("  IRQ interference	\t\t\t	%9.2f us (%.2f %%)\n",
-			ns_to_usf(taa_data->thread_irq_sum),
-			ns_to_per(total, taa_data->thread_irq_sum));
+		printf("  IRQ interference %.*s %9.2f us (%.2f %%)\n", 36, spaces,
+		       ns_to_usf(taa_data->thread_irq_sum),
+		       ns_to_per(total, taa_data->thread_irq_sum));
 
 		trace_seq_do_printf(taa_data->irqs_seq);
 	}
@@ -654,9 +671,9 @@ static void timerlat_thread_analysis(struct timerlat_aa_data *taa_data, int cpu,
 	 * Prints the interference caused by Softirqs to the thread latency.
 	 */
 	if (taa_data->thread_softirq_sum) {
-		printf("  Softirq interference	\t\t\t	%9.2f us (%.2f %%)\n",
-			ns_to_usf(taa_data->thread_softirq_sum),
-			ns_to_per(total, taa_data->thread_softirq_sum));
+		printf("  Softirq interference %.*s %9.2f us (%.2f %%)\n", 32, spaces,
+		       ns_to_usf(taa_data->thread_softirq_sum),
+		       ns_to_per(total, taa_data->thread_softirq_sum));
 
 		trace_seq_do_printf(taa_data->softirqs_seq);
 	}
@@ -670,9 +687,9 @@ static void timerlat_thread_analysis(struct timerlat_aa_data *taa_data, int cpu,
 	 * timer handling latency.
 	 */
 	if (taa_data->thread_thread_sum) {
-		printf("  Thread interference	\t\t\t	%9.2f us (%.2f %%)\n",
-			ns_to_usf(taa_data->thread_thread_sum),
-			ns_to_per(total, taa_data->thread_thread_sum));
+		printf("  Thread interference %.*s %9.2f us (%.2f %%)\n", 33, spaces,
+		       ns_to_usf(taa_data->thread_thread_sum),
+		       ns_to_per(total, taa_data->thread_thread_sum));
 
 		trace_seq_do_printf(taa_data->threads_seq);
 	}
@@ -682,8 +699,8 @@ static void timerlat_thread_analysis(struct timerlat_aa_data *taa_data, int cpu,
 	 */
 print_total:
 	printf("------------------------------------------------------------------------\n");
-	printf("  %s latency:	\t\t\t	%9.2f us (100%%)\n", irq ? "IRQ" : "Thread",
-		ns_to_usf(total));
+	printf("  %s latency: %.*s %9.2f us (100%%)\n", irq ? "   IRQ" : "Thread",
+	       37, spaces, ns_to_usf(total));
 }
 
 static int timerlat_auto_analysis_collect_trace(struct timerlat_aa_context *taa_ctx)
-- 
2.44.0


