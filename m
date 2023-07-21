Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F81275D166
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 20:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjGUSad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 14:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjGUSab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 14:30:31 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477BCEB;
        Fri, 21 Jul 2023 11:30:30 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6b9defb366eso1835332a34.2;
        Fri, 21 Jul 2023 11:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689964229; x=1690569029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eviz6yxXmXIVKJhsg2hoJNymFdQ/TGbAHjXtVl32Jqs=;
        b=PodVOpwOkAv0DSopSVIIH5cqvaxq6n0DVqg1eiPTJGzOOiZHPa+TSvlvd2gB0RK1dU
         H1Q9xwCv90GYCv8jNPADP5qx+kBtPaCkW8wQp+hNS0Zck9kR6vQuJ31hqZ8+zZggu8WT
         GlxuOUx7OjXPwBYvJsgZYI2mpqFl+LZN5I+kYlTpWd0cKgXrIdSFOMIkScbpVz7HjpxB
         K1WZ2T0hwE+aF4qLHB+HoQEQV+aarsOtip4ES5KmzrKaGO0IuIS9I3Vbeg5j6PRlVDax
         nSeOYtcLipmu0EW3NzeIdRPgq0NB0Cz2ZTOIOMCZStKVHMCMdD0z258gKlf/+yfFcQFr
         YOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689964229; x=1690569029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eviz6yxXmXIVKJhsg2hoJNymFdQ/TGbAHjXtVl32Jqs=;
        b=T2AB+dfqbdVEVqJdgeX8Pl4ejHgOy0HT0Fw5QumUKElqM09csVbk28ZnT7qs/fmjHn
         ytb4dDNGsOGj73XFKr8cRgV10fy4w/G3MzE1xA8OOZvGJqpaNhaYjeYaTwTJSTk2cBop
         9pOKObuuPI7xPlDTQIRUZrGNALyveWBaKkKRLyHywDNqNRhT4Bu+pUQYYafILI7pcbZu
         ZN/0+HJMZY8jBdw3eCKQT4PU9kJet9gtgpZNLSislDlsd35OfZ0hr0zfSkxCRU6Wm5+r
         Zh96tRaer3zqAF9Uqw94KSZXFr2oZMXx/24Pt/WoJQskedMGzI/IELrClnq5iO7yRWeL
         Ynyg==
X-Gm-Message-State: ABy/qLacnxujCBqoyOly/HvdAwaSPOnatKCdZelKKfZekfIA5oINoVjs
        83A+VB6r1S9lVz743xUJl60=
X-Google-Smtp-Source: APBJJlHWsrh1hhWFKdHoC6mqeEAXpCOgMAHt4sJYmBnqezH21dBtFgC7El7Ri6icEIS7GO+9IF64gw==
X-Received: by 2002:a05:6808:d54:b0:3a3:6364:2b73 with SMTP id w20-20020a0568080d5400b003a363642b73mr3654443oik.52.1689964229220;
        Fri, 21 Jul 2023 11:30:29 -0700 (PDT)
Received: from yoga ([2400:1f00:13:cde2:d588:8109:e86b:839c])
        by smtp.gmail.com with ESMTPSA id p11-20020a17090a748b00b002676e95cd3bsm4401164pjk.0.2023.07.21.11.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 11:30:28 -0700 (PDT)
Date:   Sat, 22 Jul 2023 00:00:21 +0530
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
Subject: [PATCH v5 8/8] perf test: Add support for testing perf gecko script
Message-ID: <e18ac2e37858ccf484d3ac16504f0cf898ad59cb.1689964167.git.anupnewsmail@gmail.com>
References: <cover.1689964167.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689964167.git.anupnewsmail@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit add support for testing perf-gecko script.
This test checks for the presence of required sections such as "meta,"
"threads," "samples," "frameTable," "stackTable," "stringTable,"
and "pausedRanges" which are few essential parameter to be present
in output file. It also tests for user-defined color changes using
the --user-color flag, and verifies the validity of the JSON format
using Python's JSON library if available.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 tools/perf/tests/shell/test_perf_gecko.sh | 188 ++++++++++++++++++++++
 1 file changed, 188 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_perf_gecko.sh

diff --git a/tools/perf/tests/shell/test_perf_gecko.sh b/tools/perf/tests/shell/test_perf_gecko.sh
new file mode 100755
index 000000000000..5c5f61438579
--- /dev/null
+++ b/tools/perf/tests/shell/test_perf_gecko.sh
@@ -0,0 +1,188 @@
+#!/bin/bash
+# perf script perf-gecko test
+# SPDX-License-Identifier: GPL-2.0
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
+tmpdir=$(mktemp -d /tmp/perf-script-perf-gecko-XXXXX)
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
+test_perf_gecko_command()
+{
+	echo "Testing Perf Gecko Command"
+	out="$tmpdir/perf.out"
+	perf script report perf-gecko > "$out"
+	check_exec_0 "perf script report perf-gecko"
+	if [ $(cat "${out}" | wc -l) -gt "0" ] ; then
+		echo "PASS: \"Perf Gecko Command\""
+	else
+		echo "FAIL: \"Perf Gecko Command\""
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
+	perf script report perf-gecko > "$out"
+	check_exec_0 "perf script report perf-gecko"
+	find_str_or_fail "meta" "$out" "${FUNCNAME[0]}"
+}
+
+# validate output for the presence of "threads".
+test_threads() {
+	out="$tmpdir/perf.out"
+	perf script report perf-gecko > "$out"
+	check_exec_0 "perf script report perf-gecko"
+	find_str_or_fail "threads" "$out" "${FUNCNAME[0]}"
+}
+
+# validate output for the presence of "samples".
+test_samples() {
+	out="$tmpdir/perf.out"
+	perf script report perf-gecko > "$out"
+	check_exec_0 "perf script report perf-gecko"
+	find_str_or_fail "samples" "$out" "${FUNCNAME[0]}"
+}
+
+# validate output for the presence of "frameTable".
+test_frametable() {
+	out="$tmpdir/perf.out"
+	perf script report perf-gecko > "$out"
+	check_exec_0 "perf script report perf-gecko"
+	find_str_or_fail "frameTable" "$out" "${FUNCNAME[0]}"
+}
+
+# validate output for the presence of "stackTable".
+test_stacktable() {
+	out="$tmpdir/perf.out"
+	perf script report perf-gecko > "$out"
+	check_exec_0 "perf script report perf-gecko"
+	find_str_or_fail "stackTable" "$out" "${FUNCNAME[0]}"
+}
+
+# validate output for the presence of "stringTable"
+test_stringtable() {
+	out="$tmpdir/perf.out"
+	perf script report perf-gecko > "$out"
+	check_exec_0 "perf script report perf-gecko"
+	find_str_or_fail "stringTable" "$out" "${FUNCNAME[0]}"
+}
+
+# validate output for the presence of "pausedRanges".
+test_pauseranges(){
+	out="$tmpdir/perf.out"
+	perf script report perf-gecko > "$out"
+	check_exec_0 "perf script report perf-gecko"
+	find_str_or_fail "pausedRanges" "$out" "${FUNCNAME[0]}"
+}
+
+# validate user-defined color presence in output "green"
+test_categorycolorchange(){
+	out="$tmpdir/perf.out"
+	perf script report perf-gecko --user-color="green"> "$out"
+	check_exec_0 "perf script report perf-gecko --user-color"
+	find_str_or_fail "green" "$out" "${FUNCNAME[0]}"
+}
+
+prepare_perf_data
+test_perf_gecko_command
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

