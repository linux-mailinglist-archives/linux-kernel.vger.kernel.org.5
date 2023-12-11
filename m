Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20F680C967
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343521AbjLKMTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbjLKMTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:19:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB2C10A;
        Mon, 11 Dec 2023 04:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702297158; x=1733833158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E3OS8Ji8BqE/MCcvl7qGVBtVBgnW2p5uUjRJ5057fA8=;
  b=MaRKJaRRgo+Gk2IYjsfc9aiKOLyr58g5GiKYtr8EtzAuqlQwQKmKduPq
   niHdDxYENo8uROD5x361WjAusj04Fb14KMVxshWRKDj/66YG89+z4v2ic
   Tx34Fuyg46rPv50MLF1c0Hyc/oszeqLZ+5+VG2NthZ0h+w6J/f7jPUW0R
   LqqOgHorMoUcJ4Hwi6RDgcR8By20XcGnYvH/RRx/lLgUvrpzT51FTjc91
   aT23e/pLLyVBnt4bl2cmtewf/xkWgz/P5jx8boglBW/O1nFzRgJiiey4g
   HIeG/ZBfC6TU8dxLLNILg4FWFA8jwDqssQ7bxAsFW827ruRT1sa33Z8Ug
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1509494"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1509494"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:19:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="776656505"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="776656505"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.50.188])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:19:13 -0800
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
Subject: [PATCH v3 04/29] selftests/resctrl: Change function comments to say < 0 on error
Date:   Mon, 11 Dec 2023 14:18:01 +0200
Message-Id: <20231211121826.14392-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number function comments state the function return non-zero on
failure but in reality they can only return 0 on success and < 0 on
error.

Update the comments to say < 0 on error to match the behavior.

While at it, improve cat_val() comment to state that 0 means the test
was run (either pass or fail).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v3:
- New patch
---
 tools/testing/selftests/resctrl/cache.c     |  2 +-
 tools/testing/selftests/resctrl/resctrlfs.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 6d60a2f1b3aa..a9a0394b3d08 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -206,7 +206,7 @@ int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
  * @param:		parameters passed to cache_val()
  * @span:		buffer size for the benchmark
  *
- * Return:		0 on success. non-zero on failure.
+ * Return:		0 when the test was run, < 0 on error.
  */
 int cat_val(struct resctrl_val_param *param, size_t span)
 {
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index f5664392473c..c030a8a8377e 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -56,7 +56,7 @@ static int find_resctrl_mount(char *buffer)
  * Mounts resctrl FS. Fails if resctrl FS is already mounted to avoid
  * pre-existing settings interfering with the test results.
  *
- * Return: 0 on success, non-zero on failure
+ * Return: 0 on success, < 0 on error.
  */
 int mount_resctrlfs(void)
 {
@@ -276,7 +276,7 @@ int get_core_sibling(int cpu_no)
  * @bm_pid:	PID that should be binded
  * @cpu_no:	CPU number at which the PID would be binded
  *
- * Return: 0 on success, non-zero on failure
+ * Return: 0 on success, < 0 on error.
  */
 int taskset_benchmark(pid_t bm_pid, int cpu_no)
 {
@@ -300,7 +300,7 @@ int taskset_benchmark(pid_t bm_pid, int cpu_no)
  * @grp:	Full path and name of the group
  * @parent_grp:	Full path and name of the parent group
  *
- * Return: 0 on success, non-zero on failure
+ * Return: 0 on success, < 0 on error.
  */
 static int create_grp(const char *grp_name, char *grp, const char *parent_grp)
 {
@@ -376,7 +376,7 @@ static int write_pid_to_tasks(char *tasks, pid_t pid)
  * pid is not written, this means that pid is in con_mon grp and hence
  * should consult con_mon grp's mon_data directory for results.
  *
- * Return: 0 on success, non-zero on failure
+ * Return: 0 on success, < 0 on error.
  */
 int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
 			    char *resctrl_val)
@@ -435,7 +435,7 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
  * Update schemata of a con_mon grp *only* if requested resctrl feature is
  * allocation type
  *
- * Return: 0 on success, non-zero on failure
+ * Return: 0 on success, < 0 on error.
  */
 int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 {
-- 
2.30.2

