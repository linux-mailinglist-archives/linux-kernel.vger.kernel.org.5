Return-Path: <linux-kernel+bounces-126333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90742893546
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285BD2878D7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EEF145B04;
	Sun, 31 Mar 2024 17:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ng/YQaJk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFE2A32;
	Sun, 31 Mar 2024 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711907087; cv=none; b=V4iCFn8zeUPeBk7C9SR7sM5bCrNZlN+txws/XLfo15vtC9gzNw7yzDoK2fWEh2ZaO6FKTqrXunBxSpRZLYzfFVk5HuvbNhFmYZGqKTVQMecpajN5cx/mMsQExHdY89stgGSZq9tIClzHjJUPwKDq9FYnIeky8P+NdyyFJdaGvtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711907087; c=relaxed/simple;
	bh=Gh8/XiSLZnVNGbva2cZCwVYIH9HmLPC2t6KRZNzEUxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iWcbDbp05xTUspL+Nrvpjt2CHHVnD1dB8krvYoHCN1q1VuHl6qfkd4iw2927wjEPPIw/6i6Q8DbSwmwSeVk7Tq6uw4Ik2JH+Z1M6eEiUp5VwVyYx/6akdAQvXUju1pINchOSdtXURgvdhB15fyaZB7R/t40BPAvfVF7CK3V0mDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ng/YQaJk; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711907085; x=1743443085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gh8/XiSLZnVNGbva2cZCwVYIH9HmLPC2t6KRZNzEUxI=;
  b=ng/YQaJkJKm91lV+qxZKRJJtOF/tLHRekmdTgJV918vkSO18O/DakrwT
   2jHwiRS3c58qn5S5m/7OkYK+w9fkZ7rZHSIWqlMJhLKoLFOTst7UmHNjm
   r0I7TVF8VbOzhCOGAJSUfPYuiB5xtYXlJLtfoAMNJjPO6FstrtMUCaqfJ
   zEe5n9vYXM976hpiuJwbPU0c5vcn8hpsjpN23HsEpAtS4KD0s0KVttQZk
   VZMaesvHW7pzg5mDMwl4ODLrn5rhOzszlUW4qmxJecOEIC8AUXQaNSb1+
   4g2LHq4eT6D2qAQUzdw8ZRodke2MEV8I2a4Dbl10esZzgJeLD2PpS5klI
   g==;
X-CSE-ConnectionGUID: +iBAMhynRhinGHDIDR5XbA==
X-CSE-MsgGUID: 9oO2i/NnQvyQJOFh4zCdJQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="7166847"
X-IronPort-AV: E=Sophos;i="6.07,170,1708416000"; 
   d="scan'208";a="7166847"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 10:44:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,170,1708416000"; 
   d="scan'208";a="21935117"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmviesa005.fm.intel.com with ESMTP; 31 Mar 2024 10:44:42 -0700
From: Haitao Huang <haitao.huang@linux.intel.com>
To: jarkko@kernel.org
Cc: anakrish@microsoft.com,
	bp@alien8.de,
	cgroups@vger.kernel.org,
	chrisyan@microsoft.com,
	dave.hansen@linux.intel.com,
	haitao.huang@linux.intel.com,
	hpa@zytor.com,
	kai.huang@intel.com,
	kristen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-sgx@vger.kernel.org,
	mikko.ylinen@linux.intel.com,
	mingo@redhat.com,
	mkoutny@suse.com,
	seanjc@google.com,
	sohil.mehta@intel.com,
	tglx@linutronix.de,
	tim.c.chen@linux.intel.com,
	tj@kernel.org,
	x86@kernel.org,
	yangjie@microsoft.com,
	zhanb@microsoft.com,
	zhiquan1.li@intel.com
Subject: [PATCH] selftests/sgx: Improve cgroup test scripts
Date: Sun, 31 Mar 2024 10:44:42 -0700
Message-Id: <20240331174442.51019-1-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <D071SWVSOJLN.2C9H7NTS4PHGI@kernel.org>
References: <D071SWVSOJLN.2C9H7NTS4PHGI@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make cgroup test scripts ash compatible.
Remove cg-tools dependency.
Add documentation for functions.

Tested with busybox on Ubuntu.

Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
 tools/testing/selftests/sgx/ash_cgexec.sh     |  58 ++++++
 .../selftests/sgx/run_epc_cg_selftests.sh     | 171 +++++++++++-------
 .../selftests/sgx/watch_misc_for_tests.sh     |  13 +-
 3 files changed, 165 insertions(+), 77 deletions(-)
 create mode 100755 tools/testing/selftests/sgx/ash_cgexec.sh

diff --git a/tools/testing/selftests/sgx/ash_cgexec.sh b/tools/testing/selftests/sgx/ash_cgexec.sh
new file mode 100755
index 000000000000..51232d6452a8
--- /dev/null
+++ b/tools/testing/selftests/sgx/ash_cgexec.sh
@@ -0,0 +1,58 @@
+#!/usr/bin/env sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2024 Intel Corporation.
+
+# Move the current shell process to the specified cgroup
+# Arguments:
+# 	$1 - The cgroup controller name, e.g., misc, memory.
+#	$2 - The path of the cgroup,
+#		relative to /sys/fs/cgroup for cgroup v2,
+#		relative to /sys/fs/cgroup/$1 for v1.
+move_to_cgroup() {
+    controllers="$1"
+    path="$2"
+
+    # Check if cgroup v2 is in use
+    if [ ! -d "/sys/fs/cgroup/misc" ]; then
+        # Cgroup v2 logic
+        cgroup_full_path="/sys/fs/cgroup/${path}"
+        echo $$ > "${cgroup_full_path}/cgroup.procs"
+    else
+        # Cgroup v1 logic
+        OLD_IFS="$IFS"
+        IFS=','
+        for controller in $controllers; do
+            cgroup_full_path="/sys/fs/cgroup/${controller}/${path}"
+            echo $$ > "${cgroup_full_path}/tasks"
+        done
+        IFS="$OLD_IFS"
+    fi
+}
+
+if [ "$#" -lt 3 ] || [ "$1" != "-g" ]; then
+    echo "Usage: $0 -g <controller1,controller2:path> [-g <controller3:path> ...] <command> [args...]"
+    exit 1
+fi
+
+while [ "$#" -gt 0 ]; do
+    case "$1" in
+        -g)
+            # Ensure that a controller:path pair is provided after -g
+            if [ -z "$2" ]; then
+                echo "Error: Missing controller:path argument after -g"
+                exit 1
+            fi
+            IFS=':' read CONTROLLERS CGROUP_PATH <<EOF
+$2
+EOF
+            move_to_cgroup "$CONTROLLERS" "$CGROUP_PATH"
+            shift 2
+            ;;
+        *)
+            # Execute the command within the cgroup
+            exec "$@"
+            ;;
+    esac
+done
+
+
diff --git a/tools/testing/selftests/sgx/run_epc_cg_selftests.sh b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
index e027bf39f005..b9c73ab784cb 100755
--- a/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
+++ b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
@@ -1,24 +1,14 @@
-#!/bin/bash
+#!/usr/bin/env sh
 # SPDX-License-Identifier: GPL-2.0
-# Copyright(c) 2023 Intel Corporation.
+# Copyright(c) 2023, 2024 Intel Corporation.
 
 TEST_ROOT_CG=selftest
-cgcreate -g misc:$TEST_ROOT_CG
-if [ $? -ne 0 ]; then
-    echo "# Please make sure cgroup-tools is installed, and misc cgroup is mounted."
-    exit 1
-fi
 TEST_CG_SUB1=$TEST_ROOT_CG/test1
 TEST_CG_SUB2=$TEST_ROOT_CG/test2
 # We will only set limit in test1 and run tests in test3
 TEST_CG_SUB3=$TEST_ROOT_CG/test1/test3
 TEST_CG_SUB4=$TEST_ROOT_CG/test4
 
-cgcreate -g misc:$TEST_CG_SUB1
-cgcreate -g misc:$TEST_CG_SUB2
-cgcreate -g misc:$TEST_CG_SUB3
-cgcreate -g misc:$TEST_CG_SUB4
-
 # Default to V2
 CG_MISC_ROOT=/sys/fs/cgroup
 CG_MEM_ROOT=/sys/fs/cgroup
@@ -31,6 +21,10 @@ else
     CG_MEM_ROOT=/sys/fs/cgroup/memory
     CG_V1=1
 fi
+mkdir -p $CG_MISC_ROOT/$TEST_CG_SUB1
+mkdir -p $CG_MISC_ROOT/$TEST_CG_SUB2
+mkdir -p $CG_MISC_ROOT/$TEST_CG_SUB3
+mkdir -p $CG_MISC_ROOT/$TEST_CG_SUB4
 
 CAPACITY=$(grep "sgx_epc" "$CG_MISC_ROOT/misc.capacity" | awk '{print $2}')
 # This is below number of VA pages needed for enclave of capacity size. So
@@ -48,34 +42,66 @@ echo "sgx_epc $SMALL" > $CG_MISC_ROOT/$TEST_CG_SUB1/misc.max
 echo "sgx_epc $LARGE" >  $CG_MISC_ROOT/$TEST_CG_SUB2/misc.max
 echo "sgx_epc $LARGER" > $CG_MISC_ROOT/$TEST_CG_SUB4/misc.max
 
+if [ $? -ne 0 ]; then
+    echo "# Failed setting up misc limits, make sure misc cgroup is mounted."
+    exit 1
+fi
+
+clean_up_misc()
+{
+rmdir $CG_MISC_ROOT/$TEST_CG_SUB2
+rmdir $CG_MISC_ROOT/$TEST_CG_SUB3
+rmdir $CG_MISC_ROOT/$TEST_CG_SUB4
+rmdir $CG_MISC_ROOT/$TEST_CG_SUB1
+rmdir $CG_MISC_ROOT/$TEST_ROOT_CG
+}
+
 timestamp=$(date +%Y%m%d_%H%M%S)
 
 test_cmd="./test_sgx -t unclobbered_vdso_oversubscribed"
 
+# Wait for a process and check for expected exit status.
+#
+# Arguments:
+#	$1 - the pid of the process to wait and check.
+#	$2 - 1 if expecting success, 0 for failure.
+#
+# Return:
+#	0 if the exit status of the process matches the expectation.
+#	1 otherwise.
 wait_check_process_status() {
-    local pid=$1
-    local check_for_success=$2  # If 1, check for success;
-                                # If 0, check for failure
+    pid=$1
+    check_for_success=$2  # If 1, check for success;
+                          # If 0, check for failure
     wait "$pid"
-    local status=$?
+    status=$?
 
-    if [[ $check_for_success -eq 1 && $status -eq 0 ]]; then
+    if [ $check_for_success -eq 1 ] && [ $status -eq 0 ]; then
         echo "# Process $pid succeeded."
         return 0
-    elif [[ $check_for_success -eq 0 && $status -ne 0 ]]; then
+    elif [ $check_for_success -eq 0 ] && [ $status -ne 0 ]; then
         echo "# Process $pid returned failure."
         return 0
     fi
     return 1
 }
 
+# Wait for a set of processes and check for expected exit status
+#
+# Arguments:
+#	$1 - 1 if expecting success, 0 for failure.
+#	remaining args - The pids of the processes
+#
+# Return:
+#	0 if exit status of any process matches the expectation.
+#	1 otherwise.
 wait_and_detect_for_any() {
-    local pids=("$@")
-    local check_for_success=$1  # If 1, check for success;
-                                # If 0, check for failure
-    local detected=1 # 0 for success detection
+    check_for_success=$1  # If 1, check for success;
+                          # If 0, check for failure
+    shift
+    detected=1 # 0 for success detection
 
-    for pid in "${pids[@]:1}"; do
+    for pid in $@; do
         if wait_check_process_status "$pid" "$check_for_success"; then
             detected=0
             # Wait for other processes to exit
@@ -88,10 +114,10 @@ wait_and_detect_for_any() {
 echo "# Start unclobbered_vdso_oversubscribed with SMALL limit, expecting failure..."
 # Always use leaf node of misc cgroups so it works for both v1 and v2
 # these may fail on OOM
-cgexec -g misc:$TEST_CG_SUB3 $test_cmd >cgtest_small_$timestamp.log 2>&1
-if [[ $? -eq 0 ]]; then
+./ash_cgexec.sh -g misc:$TEST_CG_SUB3 $test_cmd >cgtest_small_$timestamp.log 2>&1
+if [ $? -eq 0 ]; then
     echo "# Fail on SMALL limit, not expecting any test passes."
-    cgdelete -r -g misc:$TEST_ROOT_CG
+    clean_up_misc
     exit 1
 else
     echo "# Test failed as expected."
@@ -102,54 +128,54 @@ echo "# PASSED SMALL limit."
 echo "# Start 4 concurrent unclobbered_vdso_oversubscribed tests with LARGE limit,
         expecting at least one success...."
 
-pids=()
-for i in {1..4}; do
+pids=""
+for i in 1 2 3 4; do
     (
-        cgexec -g misc:$TEST_CG_SUB2 $test_cmd >cgtest_large_positive_$timestamp.$i.log 2>&1
+        ./ash_cgexec.sh -g misc:$TEST_CG_SUB2 $test_cmd >cgtest_large_positive_$timestamp.$i.log 2>&1
     ) &
-    pids+=($!)
+    pids="$pids $!"
 done
 
 
-if wait_and_detect_for_any 1 "${pids[@]}"; then
+if wait_and_detect_for_any 1 "$pids"; then
     echo "# PASSED LARGE limit positive testing."
 else
     echo "# Failed on LARGE limit positive testing, no test passes."
-    cgdelete -r -g misc:$TEST_ROOT_CG
+    clean_up_misc
     exit 1
 fi
 
 echo "# Start 5 concurrent unclobbered_vdso_oversubscribed tests with LARGE limit,
         expecting at least one failure...."
-pids=()
-for i in {1..5}; do
+pids=""
+for i in 1 2 3 4 5; do
     (
-        cgexec -g misc:$TEST_CG_SUB2 $test_cmd >cgtest_large_negative_$timestamp.$i.log 2>&1
+        ./ash_cgexec.sh -g misc:$TEST_CG_SUB2 $test_cmd >cgtest_large_negative_$timestamp.$i.log 2>&1
     ) &
-    pids+=($!)
+    pids="$pids $!"
 done
 
-if wait_and_detect_for_any 0 "${pids[@]}"; then
+if wait_and_detect_for_any 0 "$pids"; then
     echo "# PASSED LARGE limit negative testing."
 else
     echo "# Failed on LARGE limit negative testing, no test fails."
-    cgdelete -r -g misc:$TEST_ROOT_CG
+    clean_up_misc
     exit 1
 fi
 
 echo "# Start 8 concurrent unclobbered_vdso_oversubscribed tests with LARGER limit,
         expecting no failure...."
-pids=()
-for i in {1..8}; do
+pids=""
+for i in 1 2 3 4 5 6 7 8; do
     (
-        cgexec -g misc:$TEST_CG_SUB4 $test_cmd >cgtest_larger_$timestamp.$i.log 2>&1
+        ./ash_cgexec.sh -g misc:$TEST_CG_SUB4 $test_cmd >cgtest_larger_$timestamp.$i.log 2>&1
     ) &
-    pids+=($!)
+    pids="$pids $!"
 done
 
-if wait_and_detect_for_any 0 "${pids[@]}"; then
+if wait_and_detect_for_any 0 "$pids"; then
     echo "# Failed on LARGER limit, at least one test fails."
-    cgdelete -r -g misc:$TEST_ROOT_CG
+    clean_up_misc
     exit 1
 else
     echo "# PASSED LARGER limit tests."
@@ -157,51 +183,58 @@ fi
 
 echo "# Start 8 concurrent unclobbered_vdso_oversubscribed tests with LARGER limit,
       randomly kill one, expecting no failure...."
-pids=()
-for i in {1..8}; do
+pids=""
+for i in 1 2 3 4 5 6 7 8; do
     (
-        cgexec -g misc:$TEST_CG_SUB4 $test_cmd >cgtest_larger_kill_$timestamp.$i.log 2>&1
+        ./ash_cgexec.sh -g misc:$TEST_CG_SUB4 $test_cmd >cgtest_larger_kill_$timestamp.$i.log 2>&1
     ) &
-    pids+=($!)
+    pids="$pids $!"
 done
-
-sleep $((RANDOM % 10 + 5))
+random_number=$(awk 'BEGIN{srand();print int(rand()*10)}')
+sleep $((random_number + 5))
 
 # Randomly select a PID to kill
-RANDOM_INDEX=$((RANDOM % 8))
-PID_TO_KILL=${pids[RANDOM_INDEX]}
+RANDOM_INDEX=$(awk 'BEGIN{srand();print int(rand()*8)}')
+counter=0
+for pid in $pids; do
+    if [ "$counter" -eq "$RANDOM_INDEX" ]; then
+        PID_TO_KILL=$pid
+        break
+    fi
+    counter=$((counter + 1))
+done
 
 kill $PID_TO_KILL
 echo "# Killed process with PID: $PID_TO_KILL"
 
 any_failure=0
-for pid in "${pids[@]}"; do
+for pid in $pids; do
     wait "$pid"
     status=$?
     if [ "$pid" != "$PID_TO_KILL" ]; then
-        if [[ $status -ne 0 ]]; then
+        if [ $status -ne 0 ]; then
 	    echo "# Process $pid returned failure."
             any_failure=1
         fi
     fi
 done
 
-if [[ $any_failure -ne 0 ]]; then
+if [ $any_failure -ne 0 ]; then
     echo "# Failed on random killing, at least one test fails."
-    cgdelete -r -g misc:$TEST_ROOT_CG
+    clean_up_misc
     exit 1
 fi
 echo "# PASSED LARGER limit test with a process randomly killed."
 
-cgcreate -g memory:$TEST_CG_SUB2
+mkdir -p $CG_MEM_ROOT/$TEST_CG_SUB2
 if [ $? -ne 0 ]; then
     echo "# Failed creating memory controller."
-    cgdelete -r -g misc:$TEST_ROOT_CG
+    clean_up_misc
     exit 1
 fi
 MEM_LIMIT_TOO_SMALL=$((CAPACITY - 2 * LARGE))
 
-if [[ $CG_V1 -eq 0 ]]; then
+if [ $CG_V1 -eq 0 ]; then
     echo "$MEM_LIMIT_TOO_SMALL" > $CG_MEM_ROOT/$TEST_CG_SUB2/memory.max
 else
     echo "$MEM_LIMIT_TOO_SMALL" > $CG_MEM_ROOT/$TEST_CG_SUB2/memory.limit_in_bytes
@@ -210,20 +243,20 @@ fi
 
 echo "# Start 4 concurrent unclobbered_vdso_oversubscribed tests with LARGE EPC limit,
         and too small RAM limit, expecting all failures...."
-pids=()
-for i in {1..4}; do
+pids=""
+for i in 1 2 3 4; do
     (
-        cgexec -g memory:$TEST_CG_SUB2 -g misc:$TEST_CG_SUB2 $test_cmd \
+        ./ash_cgexec.sh -g memory:$TEST_CG_SUB2 -g misc:$TEST_CG_SUB2 $test_cmd \
                >cgtest_large_oom_$timestamp.$i.log 2>&1
     ) &
-    pids+=($!)
+    pids="$pids $!"
 done
 
-if wait_and_detect_for_any 1 "${pids[@]}"; then
+if wait_and_detect_for_any 1 "$pids"; then
     echo "# Failed on tests with memcontrol, some tests did not fail."
-    cgdelete -r -g misc:$TEST_ROOT_CG
+    clean_up_misc
     if [[ $CG_V1 -ne 0 ]]; then
-        cgdelete -r -g memory:$TEST_ROOT_CG
+        rmdir $CG_MEM_ROOT/$TEST_CG_SUB2
     fi
     exit 1
 else
@@ -239,8 +272,8 @@ else
     echo "# PASSED leakage check."
     echo "# PASSED ALL cgroup limit tests, cleanup cgroups..."
 fi
-cgdelete -r -g misc:$TEST_ROOT_CG
-if [[ $CG_V1 -ne 0 ]]; then
-     cgdelete -r -g memory:$TEST_ROOT_CG
+clean_up_misc
+if [ $CG_V1 -ne 0 ]; then
+     rmdir $CG_MEM_ROOT/$TEST_CG_SUB2
 fi
 echo "# done."
diff --git a/tools/testing/selftests/sgx/watch_misc_for_tests.sh b/tools/testing/selftests/sgx/watch_misc_for_tests.sh
index dbd38f346e7b..3b05475938d0 100755
--- a/tools/testing/selftests/sgx/watch_misc_for_tests.sh
+++ b/tools/testing/selftests/sgx/watch_misc_for_tests.sh
@@ -1,13 +1,10 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
+##!/usr/bin/env sh
+#!/bin/sh
 # Copyright(c) 2023 Intel Corporation.
 
-if [ -z "$1" ]
-  then
-    echo "No argument supplied, please provide 'max', 'current' or 'events'"
+if [ -z "$1" ]; then
+    echo "No argument supplied, please provide 'max', 'current', or 'events'"
     exit 1
 fi
 
-watch -n 1 "find /sys/fs/cgroup -wholename */test*/misc.$1 -exec sh -c \
-    'echo \"\$1:\"; cat \"\$1\"' _ {} \;"
-
+watch -n 1 'find /sys/fs/cgroup -wholename "*/test*/misc.'$1'" -exec sh -c '\''echo "$1:"; cat "$1"'\'' _ {} \;'

base-commit: 0d0d598f09a5ef12412b797fa160947febcd1777
-- 
2.25.1


