Return-Path: <linux-kernel+bounces-128745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCEC895EE9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02E9EB27636
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2BE15E809;
	Tue,  2 Apr 2024 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jQWtmcec"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4B715E5DC;
	Tue,  2 Apr 2024 21:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712094373; cv=none; b=CzXqTpb8EVJ/ExoaxqfJlWNtxV1eOauRbrKzXuShyDya8TqXcCrk5Hs5IijhdDZt1bXEp5oIq3gKvcDXsANdEIm8EW4vowN/AuA8gx3aGMROYDCBBDYuLS03Dg8JdNco9IKz0ywRnY9lQFNCJ0t3p9lepopBwMDynFLl2vMQECA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712094373; c=relaxed/simple;
	bh=AHwir3cW6P9/pc/cDHnMSyf40GMHHmckaJSV4TyfqiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLKLaeqkXnPKreuuM8Yy2jyUWr4y+pQlqQ5MZjzQVXNKdSF5UU2F/jMUQelRutsgBQyg3HydLa/TaREAslO5TzBRLjrElxMRcow1iX72d7G/mdFmm6RzpPE2SYjeoKe3QQwtuIjDsU3daRidunsl1qQNJpnqETNJ2QLCg6CDhJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jQWtmcec; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712094371; x=1743630371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AHwir3cW6P9/pc/cDHnMSyf40GMHHmckaJSV4TyfqiE=;
  b=jQWtmcec9asmgJwjBsPlFDN0YulEQLE1F3+ySRqPdHCblhcCjPC47yrv
   sYD7pibObT5tonItt7bB88OONOKZj/mQYd4HfN4tChc58XE2b16xKSNBH
   /++/S7Qm0eina2eNe6ifmy+S1X/hndFojVMF9WkEciUpT00L5u7RZuFah
   7ornlA2Xsy6Xsnn2CO9V3xduBCqA7Wc/JMISiXYdPHL2elVBIIsivm8gM
   fU+SJRV2EWvzB/Enur5A5t3eP8j//gWVmctOmQTleLth7l0/LeUccHtJ8
   J9h1lRnjJufu+BCG7W5kL+3E2a2xhNZbQc0Iy94382PkL52DWGVZjdya1
   Q==;
X-CSE-ConnectionGUID: iLW4k12NSQGH/Pr6C6VNtQ==
X-CSE-MsgGUID: Ohehe3BIQNe8mgtGgKcnqQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="18020015"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18020015"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 14:45:05 -0700
X-CSE-ConnectionGUID: 6ugxNBLySTagRo/nY/nn7Q==
X-CSE-MsgGUID: q61O5J3eQeuePT6sCS4LuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="22849082"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa004.fm.intel.com with ESMTP; 02 Apr 2024 14:45:03 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v7 3/6] perf stat: Fork and launch perf record when perf stat needs to get retire latency value for a metric.
Date: Tue,  2 Apr 2024 17:44:33 -0400
Message-ID: <20240402214436.1409476-4-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402214436.1409476-1-weilin.wang@intel.com>
References: <20240402214436.1409476-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

When retire_latency value is used in a metric formula, perf stat would fork a
perf record process with "-e" and "-W" options. Perf record will collect
required retire_latency values in parallel while perf stat is collecting
counting values.

At the point of time that perf stat stops counting, it would send sigterm signal
to perf record process and receiving sampling data back from perf record from a
pipe. Perf stat will then process the received data to get retire latency data
and calculate metric result.

Another thread is required to synchronize between perf stat and perf record
when we pass data through pipe.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c     | 212 +++++++++++++++++++++++++++++++++-
 tools/perf/util/metricgroup.h |   8 ++
 tools/perf/util/stat.h        |   2 +
 3 files changed, 220 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 4558b9d95441..2dcc1a12f7ef 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -94,8 +94,13 @@
 #include <perf/evlist.h>
 #include <internal/threadmap.h>
 
+#include "util/sample.h"
+#include <sys/param.h>
+#include <subcmd/run-command.h>
+
 #define DEFAULT_SEPARATOR	" "
 #define FREEZE_ON_SMI_PATH	"devices/cpu/freeze_on_smi"
+#define PERF_DATA		"-"
 
 static void print_counters(struct timespec *ts, int argc, const char **argv);
 
@@ -163,6 +168,8 @@ static struct perf_stat_config stat_config = {
 	.ctl_fd_ack		= -1,
 	.iostat_run		= false,
 	.tpebs_events		= LIST_HEAD_INIT(stat_config.tpebs_events),
+	.tpebs_results		= LIST_HEAD_INIT(stat_config.tpebs_results),
+	.tpebs_pid              = -1,
 };
 
 static bool cpus_map_matched(struct evsel *a, struct evsel *b)
@@ -684,15 +691,173 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 
 	if (child_pid != -1)
 		kill(child_pid, SIGTERM);
+	if (stat_config.tpebs_pid != -1)
+		kill(stat_config.tpebs_pid, SIGTERM);
 	return COUNTER_FATAL;
 }
 
-static int __run_perf_record(void)
+static int __run_perf_record(const char **record_argv)
 {
+	int i = 0;
+	struct tpebs_event *e;
+
 	pr_debug("Prepare perf record for retire_latency\n");
+
+	record_argv[i++] = "perf";
+	record_argv[i++] = "record";
+	record_argv[i++] = "-W";
+	record_argv[i++] = "--synth=no";
+
+	if (stat_config.user_requested_cpu_list) {
+		record_argv[i++] = "-C";
+		record_argv[i++] = stat_config.user_requested_cpu_list;
+	}
+
+	if (stat_config.system_wide)
+		record_argv[i++] = "-a";
+
+	if (!stat_config.system_wide && !stat_config.user_requested_cpu_list) {
+		pr_err("Require -a or -C option to run sampling.\n");
+		return -ECANCELED;
+	}
+
+	list_for_each_entry(e, &stat_config.tpebs_events, nd) {
+		record_argv[i++] = "-e";
+		record_argv[i++] = e->name;
+	}
+
+	record_argv[i++] = "-o";
+	record_argv[i++] = PERF_DATA;
+
+	return 0;
+}
+
+static void prepare_run_command(struct child_process *cmd,
+			       const char **argv)
+{
+	memset(cmd, 0, sizeof(*cmd));
+	cmd->argv = argv;
+	cmd->out = -1;
+}
+
+static int prepare_perf_record(struct child_process *cmd)
+{
+	const char **record_argv;
+	int ret;
+
+	record_argv = calloc(10 + 2 * stat_config.tpebs_event_size, sizeof(char *));
+	if (!record_argv)
+		return -1;
+
+	ret = __run_perf_record(record_argv);
+	if (ret)
+		return ret;
+
+	prepare_run_command(cmd, record_argv);
+	return start_command(cmd);
+}
+
+struct perf_script {
+	struct perf_tool	tool;
+	struct perf_session	*session;
+};
+
+static void tpebs_event_name__delete(struct tpebs_event *e)
+{
+	zfree(&e->name);
+	zfree(&e->tpebs_name);
+}
+
+static void tpebs_event__delete(struct tpebs_event *e)
+{
+	tpebs_event_name__delete(e);
+	free(e);
+}
+
+static void tpebs_retire_lat__delete(struct tpebs_retire_lat *r)
+{
+	tpebs_event_name__delete(&r->event);
+	free(r);
+}
+
+static void tpebs_data__delete(void)
+{
+	struct tpebs_retire_lat *r, *rtmp;
+	struct tpebs_event *e, *etmp;
+
+	list_for_each_entry_safe(r, rtmp, &stat_config.tpebs_results, event.nd) {
+		list_del_init(&r->event.nd);
+		tpebs_retire_lat__delete(r);
+	}
+	list_for_each_entry_safe(e, etmp, &stat_config.tpebs_events, nd) {
+		list_del_init(&e->nd);
+		tpebs_event__delete(e);
+	}
+}
+
+static int process_sample_event(struct perf_tool *tool __maybe_unused,
+				union perf_event *event __maybe_unused,
+				struct perf_sample *sample,
+				struct evsel *evsel,
+				struct machine *machine __maybe_unused)
+{
+	int ret = 0;
+	const char *evname;
+	struct tpebs_retire_lat *t;
+
+	evname = evsel__name(evsel);
+
+	/*
+	 * Need to handle per core results? We are assuming average retire
+	 * latency value will be used. Save the number of samples and the sum of
+	 * retire latency value for each event.
+	 */
+	list_for_each_entry(t, &stat_config.tpebs_results, event.nd) {
+		if (!strcmp(evname, t->event.name)) {
+			t->count += 1;
+			t->sum += sample->retire_lat;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int process_feature_event(struct perf_session *session,
+				 union perf_event *event)
+{
+	if (event->feat.feat_id < HEADER_LAST_FEATURE)
+		return perf_event__process_feature(session, event);
 	return 0;
 }
 
+static void *__sample_reader(void *arg)
+{
+	struct child_process *cmd = arg;
+	struct perf_session *session;
+	struct perf_data data = {
+		.mode = PERF_DATA_MODE_READ,
+		.path = PERF_DATA,
+		.file.fd = cmd->out,
+	};
+	struct perf_script script = {
+		.tool = {
+		.sample		 = process_sample_event,
+		.feature	 = process_feature_event,
+		.attr		 = perf_event__process_attr,
+		},
+	};
+
+	session = perf_session__new(&data, &script.tool);
+	if (IS_ERR(session))
+		return NULL;
+	script.session = session;
+	perf_session__process_events(session);
+	perf_session__delete(session);
+
+	return NULL;
+}
+
 static int __run_perf_stat(int argc, const char **argv, int run_idx)
 {
 	int interval = stat_config.interval;
@@ -709,6 +874,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	struct affinity saved_affinity, *affinity = NULL;
 	int err;
 	bool second_pass = false;
+	struct child_process cmd;
+	pthread_t reader_thread;
 
 	/*
 	 * Prepare perf record for sampling event retire_latency before fork and
@@ -716,10 +883,35 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	 */
 	if (stat_config.tpebs_event_size > 0) {
 		int ret;
+		struct tpebs_event *e;
+
+		pr_debug("perf stat pid = %d\n", getpid());
+		list_for_each_entry(e, &stat_config.tpebs_events, nd) {
+			struct tpebs_retire_lat *new = malloc(sizeof(struct tpebs_retire_lat));
 
-		ret = __run_perf_record();
+			if (!new)
+				return -1;
+			new->event.name = strdup(e->name);
+			if (!new->event.name)
+				return -ENOMEM;
+			new->event.tpebs_name = strdup(e->tpebs_name);
+			if (!new->event.tpebs_name)
+				return -ENOMEM;
+			new->count = 0;
+			new->sum = 0;
+			list_add_tail(&new->event.nd, &stat_config.tpebs_results);
+		}
+		ret = prepare_perf_record(&cmd);
 		if (ret)
 			return ret;
+		if (pthread_create(&reader_thread, NULL, __sample_reader, &cmd)) {
+			kill(cmd.pid, SIGTERM);
+			close(cmd.out);
+			pr_err("Could not create thread to process sample data.\n");
+			return -1;
+		}
+		/* Wait for perf record initialization a little bit.*/
+		sleep(2);
 	}
 
 	if (forks) {
@@ -927,6 +1119,17 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 	t1 = rdclock();
 
+	if (stat_config.tpebs_event_size > 0) {
+		int ret;
+
+		kill(cmd.pid, SIGTERM);
+		pthread_join(reader_thread, NULL);
+		close(cmd.out);
+		ret = finish_command(&cmd);
+		if (ret != -ERR_RUN_COMMAND_WAITPID_SIGNAL)
+			return ret;
+	}
+
 	if (stat_config.walltime_run_table)
 		stat_config.walltime_run[run_idx] = t1 - t0;
 
@@ -1034,6 +1237,9 @@ static void sig_atexit(void)
 	if (child_pid != -1)
 		kill(child_pid, SIGTERM);
 
+	if (stat_config.tpebs_pid != -1)
+		kill(stat_config.tpebs_pid, SIGTERM);
+
 	sigprocmask(SIG_SETMASK, &oset, NULL);
 
 	if (signr == -1)
@@ -2974,5 +3180,7 @@ int cmd_stat(int argc, const char **argv)
 	metricgroup__rblist_exit(&stat_config.metric_events);
 	evlist__close_control(stat_config.ctl_fd, stat_config.ctl_fd_ack, &stat_config.ctl_fd_close);
 
+	tpebs_data__delete();
+
 	return status;
 }
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 7c24ed768ff3..ae788edef30f 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -68,10 +68,18 @@ struct metric_expr {
 
 struct tpebs_event {
 	struct list_head nd;
+	/* Event name */
 	const char *name;
+	/* Event name with the TPEBS modifier R */
 	const char *tpebs_name;
 };
 
+struct tpebs_retire_lat {
+	struct tpebs_event event;
+	size_t count;
+	int sum;
+};
+
 struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 					 struct evsel *evsel,
 					 bool create);
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index b987960df3c5..0726bdc06681 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -111,6 +111,8 @@ struct perf_stat_config {
 	struct rblist		 metric_events;
 	struct list_head	 tpebs_events;
 	size_t			 tpebs_event_size;
+	struct list_head	 tpebs_results;
+	pid_t			 tpebs_pid;
 	int			 ctl_fd;
 	int			 ctl_fd_ack;
 	bool			 ctl_fd_close;
-- 
2.43.0


