Return-Path: <linux-kernel+bounces-30758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565E08323FD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5A3EB22274
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 04:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1786FB8;
	Fri, 19 Jan 2024 04:07:38 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08651C15;
	Fri, 19 Jan 2024 04:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705637257; cv=none; b=qaoidY0soZQtN/OY7MF/4j/WnbTfOemktz1m15mdXp2MaZezXFdypPZges+3XpHMOZ2B2EAsLwVB9dxNYAJ1rI7kEODT8qtlTSzByYlB6yZKs3DOgMVT3GfOcP+Fvok4wZzw5jFOArHmSCHeKXWOhiraJRTPRVQV+EiCIsKxg5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705637257; c=relaxed/simple;
	bh=AOy4v0CB7AxenOdzrzI/1u6KpR6P+kRay885wVReU9U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6e1Hr3onm4wrXG3REfhLXnojFYsRog+NfR1/IRnzFP/U3dQTDc8aCrjjEdqBoh003VNWICTwsLN1FiC4U2AAdDReX0CoPYMG+nZz6pi6WfOK6X5jssPYZGmSekqwMACtQF4P1iEKOz4WAIswkMdHA23A+K+De1HemR7kFbgTcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TGR010Yr9zGpqH;
	Fri, 19 Jan 2024 12:07:13 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id ACEFC1402DE;
	Fri, 19 Jan 2024 12:07:33 +0800 (CST)
Received: from ubuntu2204.huawei.com (10.67.174.22) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 12:07:33 +0800
From: Yang Jihong <yangjihong1@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <yangjihong1@huawei.com>
Subject: [PATCH 3/3] perf data: Minor code style alignment cleanup
Date: Fri, 19 Jan 2024 04:03:04 +0000
Message-ID: <20240119040304.3708522-4-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119040304.3708522-1-yangjihong1@huawei.com>
References: <20240119040304.3708522-1-yangjihong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)

Minor code style alignment cleanup for perf_data__switch() and
perf_data__write().

No functional change.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-record.c | 7 ++++---
 tools/perf/util/data.c      | 8 ++++----
 tools/perf/util/data.h      | 6 +++---
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 5e3ea5cf1429..0b6f29fa0064 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1853,16 +1853,17 @@ record__switch_output(struct record *rec, bool at_exit)
 	}
 
 	fd = perf_data__switch(data, timestamp,
-				    rec->session->header.data_offset,
-				    at_exit, &new_filename);
+			       rec->session->header.data_offset,
+			       at_exit, &new_filename);
 	if (fd >= 0 && !at_exit) {
 		rec->bytes_written = 0;
 		rec->session->header.data_size = 0;
 	}
 
-	if (!quiet)
+	if (!quiet) {
 		fprintf(stderr, "[ perf record: Dump %s.%s ]\n",
 			data->path, timestamp);
+	}
 
 	if (rec->switch_output.num_files) {
 		int n = rec->switch_output.cur_file + 1;
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 550675ce0b78..08c4bfbd817f 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -413,7 +413,7 @@ ssize_t perf_data_file__write(struct perf_data_file *file,
 }
 
 ssize_t perf_data__write(struct perf_data *data,
-			      void *buf, size_t size)
+			 void *buf, size_t size)
 {
 	if (data->use_stdio) {
 		if (fwrite(buf, size, 1, data->file.fptr) == 1)
@@ -424,9 +424,9 @@ ssize_t perf_data__write(struct perf_data *data,
 }
 
 int perf_data__switch(struct perf_data *data,
-			   const char *postfix,
-			   size_t pos, bool at_exit,
-			   char **new_filepath)
+		      const char *postfix,
+		      size_t pos, bool at_exit,
+		      char **new_filepath)
 {
 	int ret;
 
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index effcc195d7e9..110f3ebde30f 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -80,7 +80,7 @@ int perf_data__open(struct perf_data *data);
 void perf_data__close(struct perf_data *data);
 ssize_t perf_data__read(struct perf_data *data, void *buf, size_t size);
 ssize_t perf_data__write(struct perf_data *data,
-			      void *buf, size_t size);
+			 void *buf, size_t size);
 ssize_t perf_data_file__write(struct perf_data_file *file,
 			      void *buf, size_t size);
 /*
@@ -91,8 +91,8 @@ ssize_t perf_data_file__write(struct perf_data_file *file,
  * Return value is fd of new output.
  */
 int perf_data__switch(struct perf_data *data,
-			   const char *postfix,
-			   size_t pos, bool at_exit, char **new_filepath);
+		      const char *postfix,
+		      size_t pos, bool at_exit, char **new_filepath);
 
 int perf_data__create_dir(struct perf_data *data, int nr);
 int perf_data__open_dir(struct perf_data *data);
-- 
2.34.1


