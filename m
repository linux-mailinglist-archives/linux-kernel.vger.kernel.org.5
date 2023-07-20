Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF6975B12C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjGTOZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjGTOZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:25:02 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B33A2137;
        Thu, 20 Jul 2023 07:25:01 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-668711086f4so610772b3a.1;
        Thu, 20 Jul 2023 07:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689863101; x=1690467901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L4y9ZuelBDfhc/Z9jVOloH9vaZiYPNgHHQLzZ9s4yJM=;
        b=BcVCANS7GPhquWck9X1J75g1o4IQ1lduc89vAgleCksT49Q1zsCmZ6xhpGoyZ3Ev5M
         m0GaFUGaY+Fa0ri5lhodXmcaai1RNt7+5rVtkDpbTQECG9oJvULC/ZY8UMtcEUduoy/E
         W3hFfjBnrQkM/WTtzgLwycuqxaykqz4x9u9o/jb5cA39RnJforLmvYWzCtPII61pwWvz
         igs2QlK8fxKueGtGorxwvP2F5FsmWIB3PukXgrr13oBfwN6xVIq6ZINrQW2DLvB95lJ/
         yhCp/toRCy3e6zt8JmrWoGdobQ4UMzi8dqLtYcBKWAyHaEFnQ/AHQrA/hp/8s9vqfSiF
         ygPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689863101; x=1690467901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4y9ZuelBDfhc/Z9jVOloH9vaZiYPNgHHQLzZ9s4yJM=;
        b=XMDMJZtiFgjyY02MNCnNfVbLOGj5rGzvGwgZGtwgd9A21F7g7kaAJzzZfdo9Fa/PxE
         DSvK7pKN3VU+Wk1nfKetZjWdh/WW2KR+YOS6/ozWZ0LJJXMEwprAxTSDN1ZYgZlRGGo/
         QmGFgKaoqJJymmPQkhm2nU8Aeo1sU90W5ekdkNqPoQAaQ0wYqMKskI3HtB+P105e3dEH
         8MDYkuEw6jy+K0WgCl9w6iGiIzDtJGnuWGx/mjwmF8uq2/ghhuOqqIhZo/SKNxe0e9FI
         MYvq8MCM3R9o3Ctbkh27cOwNjx+DqIuL/6+5B2Z28lGZi0qJS+U6PNkHnDiiX8uGw86o
         Qf3Q==
X-Gm-Message-State: ABy/qLZHO6JO8tpTh9sAnffjAkk39O+JKungF1wE1AAHqNqWbsLazy+l
        fakczVwGi9DcoPdtkBxyaRo=
X-Google-Smtp-Source: APBJJlEaiFiqTnmaMbyIaMjtgpAFKNehiSOQbKFmC0kJG0Jk4jVdjeR6WBT0MbJTF+t5cp2uP8d2KA==
X-Received: by 2002:a05:6a00:1f96:b0:682:93ce:4825 with SMTP id bg22-20020a056a001f9600b0068293ce4825mr6157683pfb.3.1689863100668;
        Thu, 20 Jul 2023 07:25:00 -0700 (PDT)
Received: from yoga ([2400:1f00:13:4928:ca70:2ef7:845e:1b9e])
        by smtp.gmail.com with ESMTPSA id x23-20020aa79197000000b0064fa2fdfa9esm1241820pfa.81.2023.07.20.07.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:25:00 -0700 (PDT)
Date:   Thu, 20 Jul 2023 19:54:53 +0530
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
Subject: [PATCH 2/2] perf test: Add support for testing firefox gecko
 converter script
Message-ID: <d89a4469444b4106e6a681632adcd4710a3eaa7e.1689862609.git.anupnewsmail@gmail.com>
References: <cover.1689862609.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689862609.git.anupnewsmail@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit add support for testing firefox-gecko-converter script.
This test checks for the presence of required sections such as "meta,"
"threads," "samples," "frameTable," "stackTable," "stringTable,"
and "pausedRanges" which are few essential parameter to be present
in output file. It also tests for user-defined color changes using
the --user-color flag, and verifies the validity of the JSON format
using Python's JSON library if available.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 .../shell/test_firefox-gecko-converter.sh     | 190 ++++++++++++++++++
 1 file changed, 190 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_firefox-gecko-converter.sh

diff --git a/tools/perf/tests/shell/test_firefox-gecko-converter.sh b/tools/perf/tests/shell/test_firefox-gecko-converter.sh
new file mode 100755
index 000000000000..7c30191efb91
--- /dev/null
+++ b/tools/perf/tests/shell/test_firefox-gecko-converter.sh
@@ -0,0 +1,190 @@
+#!/bin/bash
+# perf script firefox-gecko-converter tests
+# SPDX-License-Identifier: GPL-2.0
+
+#set -x
+
+err=0
+
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
+# set PERF_EXEC_PATH to find scripts in the source directory
+perfdir=$(dirname "$0")/../..
+if [ -e "$perfdir/scripts/python/Perf-Trace-Util" ]; then
+  export PERF_EXEC_PATH=$perfdir
+fi
+
+tmpdir=$(mktemp -d /tmp/perf-script-firefox-gecko-converter-XXXXX)
+
+cleanup() {
+  rm -f perf.data
+  rm -f perf.data.old
+  rm -rf "$tmpdir"
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
+	if [ "$1" = 0 ]; then
+		echo "PASS: \"$2\""
+	else
+		echo "FAIL: \"$2\" Error message: \"$3\""
+		err=1
+	fi
+}
+
+check_exec_0() {
+	if [ $? != 0 ]; then
+		report 1 "invocation of $1 command failed"
+	fi
+}
+
+find_str_or_fail() {
+	#echo "\"$1"\"
+	#echo "\"$2"\"
+	grep -q "$1" "$2"
+	if [ "$?" != 0 ]; then
+		report 1 "$3" "Failed to find required string:'${1}'."
+	else
+		report 0 "$3"
+	fi
+}
+
+prepare_perf_data() {
+	# 3s should be sufficient to catch few samples
+	perf record -g -- sleep 3 > /dev/null 2>&1
+	# check if perf data file got created in above step.
+	if [ ! -e "perf.data" ]; then
+		printf "FAIL: perf record failed to create \"perf.data\" \n"
+		return 1
+	fi
+}
+
+# check execution of command
+test_firefox-gecko_converter_command()
+{
+	echo "Testing Firefox Gecko Converter Command"
+	out="$tmpdir/perf.out"
+	perf script report firefox-gecko-converter > "$out"
+	check_exec_0 "perf script report firefox-gecko-converter"
+	if [ $(cat "${out}" | wc -l) -gt "0" ] ; then
+		echo "PASS: \"Firefox Gecko Converter Command\""
+	else
+		echo "FAIL: \"Firefox Gecko Converter Command\""
+		err=1
+		exit
+	fi
+}
+
+# with the help of python json libary validate the json output
+if [ "$PYTHON_NOT_AVAILABLE" != "0" ]; then
+	validate_json_format()
+	{
+		out="$tmpdir/perf.out"
+		if [ -f "$out" ] ; then
+			if $PYTHON -c  "import json; json.load(open('$out'))" >/dev/null 2>&1 ; then
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
+	out="$tmpdir/perf.out"
+	perf script report firefox-gecko-converter > "$out"
+	check_exec_0 "perf script report firefox-gecko-converter"
+	find_str_or_fail "meta" "$out" "${FUNCNAME[0]}"
+}
+
+# validate output for the presence of "threads".
+test_threads() {
+	out="$tmpdir/perf.out"
+	perf script report firefox-gecko-converter > "$out"
+	check_exec_0 "perf script report firefox-gecko-converter"
+	find_str_or_fail "threads" "$out" "${FUNCNAME[0]}"
+}
+
+# validate output for the presence of "samples".
+test_samples() {
+	out="$tmpdir/perf.out"
+	perf script report firefox-gecko-converter > "$out"
+	check_exec_0 "perf script report firefox-gecko-converter"
+	find_str_or_fail "samples" "$out" "${FUNCNAME[0]}"
+}
+
+# validate output for the presence of "frameTable".
+test_frametable() {
+	out="$tmpdir/perf.out"
+	perf script report firefox-gecko-converter > "$out"
+	check_exec_0 "perf script report firefox-gecko-converter"
+	find_str_or_fail "frameTable" "$out" "${FUNCNAME[0]}"
+}
+
+# validate output for the presence of "stackTable".
+test_stacktable() {
+	out="$tmpdir/perf.out"
+	perf script report firefox-gecko-converter > "$out"
+	check_exec_0 "perf script report firefox-gecko-converter"
+	find_str_or_fail "stackTable" "$out" "${FUNCNAME[0]}"
+}
+
+# validate output for the presence of "stringTable"
+test_stringtable() {
+	out="$tmpdir/perf.out"
+	perf script report firefox-gecko-converter > "$out"
+	check_exec_0 "perf script report firefox-gecko-converter"
+	find_str_or_fail "stringTable" "$out" "${FUNCNAME[0]}"
+}
+
+# validate output for the presence of "pausedRanges".
+test_pauseranges(){
+	out="$tmpdir/perf.out"
+	perf script report firefox-gecko-converter > "$out"
+	check_exec_0 "perf script report firefox-gecko-converter"
+	find_str_or_fail "pausedRanges" "$out" "${FUNCNAME[0]}"
+}
+
+# validate user-defined color presence in output "green"
+test_categorycolorchange(){
+	out="$tmpdir/perf.out"
+	perf script report firefox-gecko-converter --user-color="green"> "$out"
+	check_exec_0 "perf script report firefox-gecko-converter --user-color"
+	find_str_or_fail "green" "$out" "${FUNCNAME[0]}"
+}
+
+prepare_perf_data
+test_firefox-gecko_converter_command
+validate_json_format
+test_meta
+test_threads
+test_samples
+test_frametable
+test_stacktable
+test_stringtable
+test_pauseranges
+test_categorycolorchange
+cleanup
+exit $err
-- 
2.34.1

