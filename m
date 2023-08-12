Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A33779DDB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 09:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjHLHQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 03:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjHLHQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 03:16:11 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7760930D2;
        Sat, 12 Aug 2023 00:16:09 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a751d2e6ecso2486239b6e.0;
        Sat, 12 Aug 2023 00:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691824569; x=1692429369;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G3nK7YhZ8w3kbU9L38M5csnpEym15crPRiVg5uZbmE8=;
        b=KSdwSvE4TKOd28eoSF4LgAELLkr+ctyUy5W/wEf3kagFiu7TFBKk3sgoMFiZ+Hw+aG
         XWuNgi/TNO1dzhX7PfX5QVFr/XQ7HXGkd4kUd1h/F0qxLfABl9NcCBWJDY+Ig23JTPnp
         svXd7BEWbn4loJcxLEX0dzXglsyNIVK0g+eoXfitdjq0tcYdr19YaqOEVMQMcAYC/2IX
         ZIstkijfH0BhfIZgXuge71zJtV+11qTWHDyNQp9l8NswnuWhGMk6zBYITPjpFW94dAKB
         Q1cjSF/SNpAT53+e1VYV/SKS+Vm1qu0kUpDi8FqvLFsaxjW/70ZuAFBH6EdO0dJFSP88
         JMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691824569; x=1692429369;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G3nK7YhZ8w3kbU9L38M5csnpEym15crPRiVg5uZbmE8=;
        b=WAZZ0bhP02E5dlWpcrO/gpgvHZS6QRRnSpfbGsQi6XHxo7G0s+Y7DNBoFYbDQi7C0U
         bDOkv2qVMsKWiRjcq4vc4K4QHB/GNJ7IHpsgzNdGbdrdbfpBl+8Yclq1BSDgiVUJfscj
         loAdcbR3qzH/WHtwHvCy4Jz+ZadHxAhAtBZ7Xg3xSD4w6ziA/s4lzDIk0T/xQbrziB86
         DYY3gxVvYk2COjWRKKaGtLm+sX5Llz1c7Jf7ye1biU+FSAcfDmzOQiqKqd5veWa6kYgU
         wxvFYTUy0v30R7AjTmS9ElF2Qjo1zL+IqEZa6rw0IhLI1CfG0RZBe0bt3tniRyJCJck4
         QvIg==
X-Gm-Message-State: AOJu0Yxron7Tzh/w9hkDI4agoY2uq7lfbxo0n0XT3D894v0Ho78uOMUi
        91AFO5VWV3I0udJTgY4Shq/BDjAFOPPYFaS5
X-Google-Smtp-Source: AGHT+IE3Qpz2UnJ+oOLhaZ4KR5OfJWT6FQcYQ1RlFNrhaAvI7xqI6ELYyg1yWTz2z5ID9IEOMXm/3Q==
X-Received: by 2002:a05:6808:a86:b0:3a7:e6fb:c8a9 with SMTP id q6-20020a0568080a8600b003a7e6fbc8a9mr3855703oij.8.1691824568545;
        Sat, 12 Aug 2023 00:16:08 -0700 (PDT)
Received: from yoga ([2400:1f00:13:4c5a:a27d:4f06:b4f2:cdbb])
        by smtp.gmail.com with ESMTPSA id p26-20020a63b81a000000b0055387ffef10sm4370325pge.24.2023.08.12.00.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 00:16:08 -0700 (PDT)
Date:   Sat, 12 Aug 2023 12:46:00 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        =?utf-8?B?wqA=?= Adrian Hunter <adrian.hunter@intel.com>,
        Anup Sharma <anupnewsmail@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] perf test: Add support for testing gecko script
Message-ID: <ZNcxsN4Pvn5YPWsI@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit add support for testing gecko script. The test checks
for the presence of required sections such as "meta," "threads,"
"samples," "frameTable," "stackTable," "stringTable," and
"pausedRanges" which are few essential parameter to be present
in output file. Also it verifies the validity of the JSON format
using Python's JSON library if available.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>

---
Patch needed for testing:
    https://lore.kernel.org/linux-perf-users/ZNOS0vo58DnVLpD8@yoga/T/#u

changes in v2:
    - Removed uncessary prepare_perf_data.
    - provided patch which is required for testing this patch.
---
 tools/perf/tests/shell/test_gecko.sh | 130 +++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_gecko.sh

diff --git a/tools/perf/tests/shell/test_gecko.sh b/tools/perf/tests/shell/test_gecko.sh
new file mode 100755
index 000000000000..44160eff87fd
--- /dev/null
+++ b/tools/perf/tests/shell/test_gecko.sh
@@ -0,0 +1,130 @@
+#!/bin/bash
+# perf script gecko test
+# SPDX-License-Identifier: GPL-2.0
+
+err=0
+
+cleanup() {
+  rm -rf gecko_profile.json
+  trap - exit term int
+}
+
+trap_cleanup() {
+  cleanup
+  exit 1
+}
+trap trap_cleanup exit term int
+
+report() {
+    if [ "$1" = 0 ]; then
+        echo "PASS: \"$2\""
+    else
+        echo "FAIL: \"$2\" Error message: \"$3\""
+        err=1
+    fi
+}
+
+find_str_or_fail() {
+    grep -q "$1" <<< "$2"
+    if [ "$?" != 0 ]; then
+        report 1 "$3" "Failed to find required string:'${1}'."
+    else
+        report 0 "$3"
+    fi
+}
+
+# To validate the json format, check if python is installed
+if [ "$PYTHON" = "" ] ; then
+	if which python3 > /dev/null ; then
+		PYTHON=python3
+	elif which python > /dev/null ; then
+		PYTHON=python
+	else
+		echo Skipping JSON format check, python not detected please set environment variable PYTHON.
+		PYTHON_NOT_AVAILABLE=1
+	fi
+fi
+
+# Check execution of perf script gecko command
+test_gecko_command() {
+    echo "Testing Gecko Command"
+    perf script gecko -a sleep 0.5
+    # Store the content of the file in the 'out' variable
+    out=$(< "gecko_profile.json")
+    # Get the length of the gecko_profile.json output in 'out'
+	length=${#out}
+	if [ "$length" -gt 0 ]; then
+        echo "PASS: \"Gecko Command\""
+    else
+        echo "FAIL: \"Gecko Command\""
+        err=1
+        exit
+    fi
+}
+
+# with the help of python json libary validate the json output
+if [ "$PYTHON_NOT_AVAILABLE" != "0" ]; then
+	validate_json_format()
+	{
+		if [ "$out" ] ; then
+			if [ "$PYTHON -c import json; json.load($out)" ]; then
+				echo "PASS: \"The file contains valid JSON format\""
+			else
+				echo "FAIL: \"The file does not contain valid JSON format\""
+				err=1
+				exit
+			fi
+		else
+			echo "FAIL: \"File not found\""
+			err=2
+			exit
+		fi
+	}
+fi
+
+# validate output for the presence of "meta".
+test_meta() {
+    find_str_or_fail "meta" "$out" "${FUNCNAME[0]}"
+}
+
+# validate output for the presence of "threads".
+test_threads() {
+	find_str_or_fail "threads" "$out" "${FUNCNAME[0]}"
+}
+
+# validate output for the presence of "samples".
+test_samples() {
+	find_str_or_fail "samples" "$out" "${FUNCNAME[0]}"
+}
+
+# validate output for the presence of "frameTable".
+test_frametable() {
+	find_str_or_fail "frameTable" "$out" "${FUNCNAME[0]}"
+}
+
+# validate output for the presence of "stackTable".
+test_stacktable() {
+	find_str_or_fail "stackTable" "$out" "${FUNCNAME[0]}"
+}
+
+# validate output for the presence of "stringTable"
+test_stringtable() {
+	find_str_or_fail "stringTable" "$out" "${FUNCNAME[0]}"
+}
+
+# validate output for the presence of "pausedRanges".
+test_pauseranges(){
+	find_str_or_fail "pausedRanges" "$out" "${FUNCNAME[0]}"
+}
+
+test_gecko_command
+validate_json_format
+test_meta
+test_threads
+test_samples
+test_frametable
+test_stacktable
+test_stringtable
+test_pauseranges
+cleanup
+exit $err
-- 
2.34.1

