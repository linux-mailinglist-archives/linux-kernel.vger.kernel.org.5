Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0034A7768C0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbjHIT1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjHIT1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:27:09 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BBF2D74;
        Wed,  9 Aug 2023 12:26:52 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso1987065ad.2;
        Wed, 09 Aug 2023 12:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691609212; x=1692214012;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mp3uEDyfXmrCSL8LBR6NSzwNML9RW1w6O8NC3O9DjI8=;
        b=F5ATueIUEMYE20nCvRE05ITMZUXkXWp+VbSKL8MXamIOd+EqVfY6MMdBS9FbvlQTt+
         sM/UezZt4XvVVmKpo2fjmFpWLYKbJdXkEqOjXebn1tfCrxMNlzOb48SEsBZqTBbkZXcP
         ZTayF2qB2e0iMTV6iRkjU0a8lhO6vwBRneHjRt81ZnChk9EbSvMO0m4KNl0TKB2JlYBo
         zpfWl5+7ieUHMj1aczUn6dvMRHHTYGOWsgHdISjTx45CnNxPrHQWDfPnVh5RabgQq0/W
         9VT0e5xgqdDxwbCn4UUeJJuxao43NQyniklBUN6AkTOcZzmtP/S18Dhq6iN1Uv+uAmPq
         OvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691609212; x=1692214012;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mp3uEDyfXmrCSL8LBR6NSzwNML9RW1w6O8NC3O9DjI8=;
        b=GOOXq2Ra/FryCyBRIsSV32ffdntuHwjeT32/NWgveNfNe+RHki5EKZBk+q+MIvsoqw
         xKkC4O42jc+lFc9uZfHk4eBkU3EBjf1IAB7jNP9Swo+DIWqIeMQCHXbPYL6jcED4dzyK
         W4JuQcFxOgCWQyE6ukzl6HXxjHvMF6WzbBarbmUnMdcf+YYSn7XVoSlwNpSY4ky6jX0c
         27Mj7KR2Yli+FFMtd3uw6TYSC7ShxmVpmm0xdlhQCpoZs1i6qHZQThEzJdbsv3pbe3eN
         smCwP/jMDKlTqT158GnwkpbfafbYUeRrwsRDZ9zz5ds2mTfCFluijNFa21mq7MoHat/5
         ohfw==
X-Gm-Message-State: AOJu0YwI1Nr6ShP+1B/oNja1xYijnU+lQP51wChV59AQSMpfFkOcEr3f
        eBNU2DTW6zWdY0OJW3A1fBo=
X-Google-Smtp-Source: AGHT+IGBSAfHB2sNFjCXbKyP5IlIzvHeVlwcfK01fXj/8trrUZW4sqd/GX3pNjA/QArr+ABEeBFWaA==
X-Received: by 2002:a17:902:a710:b0:1b8:36a8:faf9 with SMTP id w16-20020a170902a71000b001b836a8faf9mr36128plq.38.1691609211782;
        Wed, 09 Aug 2023 12:26:51 -0700 (PDT)
Received: from yoga ([202.131.132.149])
        by smtp.gmail.com with ESMTPSA id ij23-20020a170902ab5700b001b8baa83639sm11664910plb.200.2023.08.09.12.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:26:51 -0700 (PDT)
Date:   Thu, 10 Aug 2023 00:56:43 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anup Sharma <anupnewsmail@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf test: Add support for testing gecko script
Message-ID: <ZNPocw1rC6d/v5RV@yoga>
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
 tools/perf/tests/shell/test_gecko.sh | 131 +++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 tools/perf/tests/shell/test_gecko.sh

diff --git a/tools/perf/tests/shell/test_gecko.sh b/tools/perf/tests/shell/test_gecko.sh
new file mode 100644
index 000000000000..457c85474a62
--- /dev/null
+++ b/tools/perf/tests/shell/test_gecko.sh
@@ -0,0 +1,131 @@
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
+	# Store the content of the file in the 'out' variable
+    out=$(< "gecko_profile.json")
+	# Get the length of the gecko_profile.json output in 'out'
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
+prepare_perf_data
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

