Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3394B80C989
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343643AbjLKMVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbjLKMUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:20:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0A3F1;
        Mon, 11 Dec 2023 04:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702297256; x=1733833256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G69brIMT77l0LXy/mP+PFF5+8Ttay9gu0oXWiXQqBF4=;
  b=RpuQZiC1JM36HTO534SJj4HgqKhS1j8Xmd81Qv2+GhBClI1NerxOLQ4x
   p3oyvYaEtDtS8a3Nqe3sWiASi4lyxwZrQSc+TlxyEZXRphA9cNcXqbApQ
   f4czsl9uPL9jC9aT1yNk2L1wKtcBoaDLx+6wmF8/8sDyVCjecEhCarbtp
   7iEUyFHTM9vdd2SUNgNi77HHrgaOFql+nzq9QNkuumWZ1ikMLwKcShLN6
   eTQ7M9HrCtHJWTCicbXHOe2zPts1j+LyOLSMM7DoP0hrzWJJLsQBPiLzO
   G+MO1VJbxRO8Xn6E6wdP5Yy6YtWmOCntTTmI+3arAEzv1yDdfHf8ruAaa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="425765882"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="425765882"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:20:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="14426993"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.50.188])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:20:52 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 15/29] selftests/resctrl: Consolidate naming of perf event related things
Date:   Mon, 11 Dec 2023 14:18:12 +0200
Message-Id: <20231211121826.14392-16-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Naming for perf event related functions, types, and variables is
inconsistent.

Make struct read_format and all functions related to perf events start
with "perf_". Adjust variable names towards the same direction but use
shorter names for variables where appropriate (pe prefix).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---

v3:
- removed "currently" from changelog
---
 tools/testing/selftests/resctrl/cache.c | 42 ++++++++++++-------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 4f846a2e5e26..7f45c4957f81 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -3,7 +3,7 @@
 #include <stdint.h>
 #include "resctrl.h"
 
-struct read_format {
+struct perf_event_read {
 	__u64 nr;			/* The number of events */
 	struct {
 		__u64 value;		/* The value of the event */
@@ -11,11 +11,11 @@ struct read_format {
 };
 
 static struct perf_event_attr pea_llc_miss;
-static struct read_format rf_cqm;
-static int fd_lm;
+static struct perf_event_read pe_read;
+static int pe_fd;
 char llc_occup_path[1024];
 
-static void initialize_perf_event_attr(void)
+static void perf_event_attr_initialize(void)
 {
 	pea_llc_miss.type = PERF_TYPE_HARDWARE;
 	pea_llc_miss.size = sizeof(struct perf_event_attr);
@@ -30,34 +30,34 @@ static void initialize_perf_event_attr(void)
 }
 
 /* Start counters to log values */
-static void ioctl_perf_event_ioc_reset_enable(void)
+static void perf_event_reset_enable(void)
 {
-	ioctl(fd_lm, PERF_EVENT_IOC_RESET, 0);
-	ioctl(fd_lm, PERF_EVENT_IOC_ENABLE, 0);
+	ioctl(pe_fd, PERF_EVENT_IOC_RESET, 0);
+	ioctl(pe_fd, PERF_EVENT_IOC_ENABLE, 0);
 }
 
-static void initialize_llc_perf(void)
+static void perf_event_initialize(void)
 {
 	memset(&pea_llc_miss, 0, sizeof(struct perf_event_attr));
-	memset(&rf_cqm, 0, sizeof(struct read_format));
+	memset(&pe_read, 0, sizeof(struct perf_event_read));
 
 	/* Initialize perf_event_attr structures for HW_CACHE_MISSES */
-	initialize_perf_event_attr();
+	perf_event_attr_initialize();
 
 	pea_llc_miss.config = PERF_COUNT_HW_CACHE_MISSES;
 
-	rf_cqm.nr = 1;
+	pe_read.nr = 1;
 }
 
-static int reset_enable_llc_perf(pid_t pid, int cpu_no)
+static int perf_open(pid_t pid, int cpu_no)
 {
-	fd_lm = perf_event_open(&pea_llc_miss, pid, cpu_no, -1, PERF_FLAG_FD_CLOEXEC);
-	if (fd_lm == -1) {
+	pe_fd = perf_event_open(&pea_llc_miss, pid, cpu_no, -1, PERF_FLAG_FD_CLOEXEC);
+	if (pe_fd == -1) {
 		ksft_perror("Error opening leader");
 		return -1;
 	}
 
-	ioctl_perf_event_ioc_reset_enable();
+	perf_event_reset_enable();
 
 	return 0;
 }
@@ -141,15 +141,15 @@ static int perf_event_measure(const char *filename, int bm_pid)
 	int ret;
 
 	/* Stop counters after one span to get miss rate */
-	ioctl(fd_lm, PERF_EVENT_IOC_DISABLE, 0);
+	ioctl(pe_fd, PERF_EVENT_IOC_DISABLE, 0);
 
-	ret = read(fd_lm, &rf_cqm, sizeof(struct read_format));
+	ret = read(pe_fd, &pe_read, sizeof(struct perf_event_read));
 	if (ret == -1) {
 		ksft_perror("Could not get perf value");
 		return -1;
 	}
 
-	return print_results_cache(filename, bm_pid, rf_cqm.values[0].value);
+	return print_results_cache(filename, bm_pid, pe_read.values[0].value);
 }
 
 /*
@@ -204,7 +204,7 @@ int cat_val(struct resctrl_val_param *param, size_t span)
 	if (ret)
 		return ret;
 
-	initialize_llc_perf();
+	perf_event_initialize();
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
@@ -215,7 +215,7 @@ int cat_val(struct resctrl_val_param *param, size_t span)
 		}
 		if (ret < 0)
 			break;
-		ret = reset_enable_llc_perf(bm_pid, param->cpu_no);
+		ret = perf_open(bm_pid, param->cpu_no);
 		if (ret)
 			break;
 
@@ -234,7 +234,7 @@ int cat_val(struct resctrl_val_param *param, size_t span)
 	return ret;
 
 pe_close:
-	close(fd_lm);
+	close(pe_fd);
 	return ret;
 }
 
-- 
2.30.2

