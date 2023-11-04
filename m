Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BF57E109B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 19:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjKDS3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 14:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjKDS3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 14:29:04 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ECAD49;
        Sat,  4 Nov 2023 11:29:00 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cc37fb1310so23357155ad.1;
        Sat, 04 Nov 2023 11:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699122539; x=1699727339; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zEsQZuc9nVoHcGHnqs5gt4VkGlRSbFN1RbqfZLuRias=;
        b=jr0k/ZkskQ1sp2DrrFv57FaMrpZjFDQhv2Q6pTvYJJMaGOtxhKJQ+rR2kiGR+1wShO
         e1VSySGTaXOdJN3S0vD5LezC1GSdjjXMz4qGfikXJXhLxrCyxoiflVzKDb8F2bjPOYwc
         VIjxn1RegU9PVe1/WYiy0XP1d5da2IAHpGfbAuBJeDhPHRg6MzM8wyYt7POZaLcA66xe
         /J2c3WrJt9bt4K9YMR29fRuqb/uKk/2hqX76XrKoGN9kIx79Ft66yyxP2S3E4AEKd69e
         zMo5hcTg7sIXPjNAxOuM0FrAvuAQChgN08mOrOCyKGc0dUOUOZ9wmftrkJEfB4Hbn73P
         7ghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699122539; x=1699727339;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zEsQZuc9nVoHcGHnqs5gt4VkGlRSbFN1RbqfZLuRias=;
        b=DdSqR/cWe0WdqVt6V6tEGXqwffQnSt5Dl6/c3ITTpJeulRgNzhOaVn07Cbbnw3pkyC
         I1wv+uzXX2AfA2gm3XRYShzG5VpNtBlDZRYsMIpQoK5AdxA9ueum04iuEroKgHkK1i7T
         p8zqz+v+1JQ6OSF20rao1ZJcEmX5sEkFn04zFNWjWwkrN4XB4O5bHF4aFQUcL4gbUXNe
         vwkIu4o8NNXYz2xX4TwnC6W/2hyhcCQ2ZpMGj94WKmVy5LE3M8tUIS1CN5t4A6Un3xTb
         QF3GcxUi6Ri7OgxLMkKrnnisGfOeMJ+UaEP1vSroNZ9oQcNBICkD7+UMioJyfZN/ovHb
         4Hzg==
X-Gm-Message-State: AOJu0YxwaHyb3XCwiyYD1MsFxkDtgjeyeUDdPZqLx6wkVVJ8nL6UTnJA
        CVK97GWrx5hxYmCgK2zWYNo=
X-Google-Smtp-Source: AGHT+IGDFKvQJCquC226rvqzjML6kGalqiP7rqm6T+svy7T8tdtIEcNkvwe+UXZ+Cj6KKNE+NFWfaA==
X-Received: by 2002:a17:902:7fcf:b0:1cc:1efb:1bab with SMTP id t15-20020a1709027fcf00b001cc1efb1babmr19323709plb.38.1699122539384;
        Sat, 04 Nov 2023 11:28:59 -0700 (PDT)
Received: from yoga ([106.51.129.253])
        by smtp.gmail.com with ESMTPSA id o14-20020a170902d4ce00b001cc2ebd2c2csm3234347plg.256.2023.11.04.11.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 11:28:58 -0700 (PDT)
Date:   Sat, 4 Nov 2023 23:58:50 +0530
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
Subject: [PATCH v3] perf test: Add support for testing gecko script
Message-ID: <ZUaNYuFEgIFMkokU@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

changes in v3:
    - Utilizes the --save-only flag to prevent the browser from launching.

To run this script:
./test_gecko.sh
or
bash test_gecko.sh

Expected output:

Testing Gecko Command
PASS: "Gecko Command"
PASS: "The file contains valid JSON format"
PASS: "test_meta"
PASS: "test_threads"
PASS: "test_samples"
PASS: "test_frametable"
PASS: "test_stacktable"
PASS: "test_stringtable"
PASS: "test_pauseranges"
---
 tools/perf/tests/shell/test_gecko.sh | 141 +++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_gecko.sh

diff --git a/tools/perf/tests/shell/test_gecko.sh b/tools/perf/tests/shell/test_gecko.sh
new file mode 100755
index 000000000000..9f9df2fcf199
--- /dev/null
+++ b/tools/perf/tests/shell/test_gecko.sh
@@ -0,0 +1,141 @@
+#!/bin/bash
+# perf script gecko test
+# SPDX-License-Identifier: GPL-2.0
+
+err=0
+
+cleanup() {
+	rm -f gecko_test.json
+	rm -f perf.data
+	rm -f perf.data.old
+	trap - exit term int
+}
+
+trap_cleanup() {
+	cleanup
+	exit 1
+}
+trap trap_cleanup exit term int
+
+report() {
+	if [ "$1" = 0 ]; then
+		echo "PASS: \"$2\""
+	else
+		echo "FAIL: \"$2\" Error message: \"$3\""
+		err=1
+	fi
+}
+
+find_str_or_fail() {
+	grep -q "$1" <<< "$2"
+	if [ "$?" != 0 ]; then
+		report 1 "$3" "Failed to find required string:'${1}'."
+	else
+		report 0 "$3"
+	fi
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
+prepare_perf_data() {
+	perf record -F 99 -g -- perf test -w noploop > /dev/null 2>&1
+	# check if perf data file got created in above step.
+	if [ ! -e "perf.data" ]; then
+		printf "FAIL: perf record failed to create \"perf.data\" \n"
+		return 1
+	fi
+}
+
+# Check execution of perf script gecko command
+test_gecko_command() {
+    echo "Testing Gecko Command"
+    perf script report gecko --save-only=gecko_test.json > /dev/null 2>&1
+	# Check if the Gecko script throws any error, and if so, consider it a failure
+	if [ "$?" != 0 ]; then
+		echo "FAIL: \"Gecko Command\""
+		err=2
+		exit
+	else
+		echo "PASS: \"Gecko Command\""
+	fi
+    # Store the content of the file in the 'result' variable
+    result=$(< "gecko_test.json")
+}
+
+# with the help of python json libary validate the json output
+if [ "$PYTHON_NOT_AVAILABLE" != "0" ]; then
+	validate_json_format()
+	{
+		if [ "$result" ] ; then
+			if [ "$PYTHON -c import json; json.load($result)" ]; then
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
+	find_str_or_fail "meta" "$result" "${FUNCNAME[0]}"
+}
+
+# validate output for the presence of "threads".
+test_threads() {
+	find_str_or_fail "threads" "$result" "${FUNCNAME[0]}"
+}
+
+# validate output for the presence of "samples".
+test_samples() {
+	find_str_or_fail "samples" "$result" "${FUNCNAME[0]}"
+}
+
+# validate output for the presence of "frameTable".
+test_frametable() {
+	find_str_or_fail "frameTable" "$result" "${FUNCNAME[0]}"
+}
+
+# validate output for the presence of "stackTable".
+test_stacktable() {
+	find_str_or_fail "stackTable" "$result" "${FUNCNAME[0]}"
+}
+
+# validate output for the presence of "stringTable"
+test_stringtable() {
+	find_str_or_fail "stringTable" "$result" "${FUNCNAME[0]}"
+}
+
+# validate output for the presence of "pausedRanges".
+test_pauseranges(){
+	find_str_or_fail "pausedRanges" "$result" "${FUNCNAME[0]}"
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

