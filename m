Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26027684D6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 12:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjG3KjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 06:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjG3KjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 06:39:22 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46B019B2;
        Sun, 30 Jul 2023 03:39:20 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1bb69c0070dso2679385fac.1;
        Sun, 30 Jul 2023 03:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690713560; x=1691318360;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ixXrYInOwbnust1iCQWifpopRByO26tK6/cFi3PNE8=;
        b=AKUb7wgIXyA0TNRAdEMW2f8kFSzB2FlM8WDluURO8vkvKTLOJ91nru6IhZYyW7laBl
         wkVJccvGMq+TcbJyeK3kqtXg8vdqrghhP6s//acEEFIG2e+7zhT6SftpCdFU63cgM+0z
         +TnrXXnllB/o2rUxoc+Ewgo3I4urwHcz0sSKX95j3FS0rqjrYaR582pH9JQABQ2Z64wF
         OTIVJ5LzmayqdYpiYT1vztu/F+dCY3eKlw5B9mpBSPvxeOwb/HEDFX02aJYmZa4D7pua
         xJAyC6cSHvm5SvsUgdrhLxX04YrEvVXhx4uymFD5QPnyc/eLo+tWXNqnw95OXpIMU0bS
         VEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690713560; x=1691318360;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ixXrYInOwbnust1iCQWifpopRByO26tK6/cFi3PNE8=;
        b=AqQKlo5s47etGjkELMcDEFhhgevVmk8DO8q1am4Q+xOEuo1aOetFXjrgm8RN+fcKsH
         lKHbwbYZdKRKnQElL25/4jIEJAi7rauy7UieZxGwHbWiRcL8vyAcmsarKH20XZouNDeq
         qd3cJduFsN0BBW9+R947pK8tC+1HWDASyipYpN3jVEQnFKwCiiIMeMbzyw2VBmPNJXqK
         RIzokOSRer3R59S6uwDQjDMFVFKFTnmrDxaHRTZQY8HeGSmBNLmXK/d8qS06UpsWsvZi
         tkSiIbZ7AatIFjYcDK3Usfd/z56AdCBuaVETKvbpQjPncnYu4hIb3WUGNRDbayH0chX0
         zNeQ==
X-Gm-Message-State: ABy/qLY8SjoBfOlkvCHxnWDWJRYiQ8wcRIrwUFrlQsUuIVtxwqSnWVJW
        FX7Qd0C3RaPc/mcTt4cga1I=
X-Google-Smtp-Source: APBJJlFHnrvAY2Ua4RExfk45o99/eIP1aQr34Cd41Oh2UpiZhWfcdqjF0jzXlPz6zxCygiNxkP3lAQ==
X-Received: by 2002:a05:6870:4182:b0:1ad:4c06:15c with SMTP id y2-20020a056870418200b001ad4c06015cmr7584392oac.18.1690713559720;
        Sun, 30 Jul 2023 03:39:19 -0700 (PDT)
Received: from yoga ([2400:1f00:13:582a:756:65ff:1368:3d28])
        by smtp.gmail.com with ESMTPSA id x25-20020a62fb19000000b00679fef56287sm5876915pfm.147.2023.07.30.03.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 03:39:19 -0700 (PDT)
Date:   Sun, 30 Jul 2023 16:09:11 +0530
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
Subject: [PATCH] perf scripts python: launch the profiler UI on the default
 browser with the appropriate URL
Message-ID: <ZMY9z36d2FFXxLXD@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All required libraries have been imported and make sure that
none of them are external dependencies. To achieve this, created
a virt env and verified.

Modified usage information and added combined command.

Modified the main() function to read the --save-only command-line
option and set the output_file variable accordingly.

Modified the trace_end() function to check for the output_file variable.
If it is set, the profiler data is saved to a local file in Gecko
Profile format, or the profiler.firefox.com is opened on the default browser.

Included trace_begin() to initialize the Firefox Profiler and launch
the default browser to display the profiler.firefox.com.

Added a new function launchFirefox() to start a local server and launch the
profiler UI on the default browser with the appropriate URL.

Created the "CORSRequestHandler" class to enable Cross-Origin Resource Sharing.

Summary:
This integration now includes a exiting feature to conveniently host the
Gecko Profile data on a local server and open it directly in the default
web browser. This means that users can now effortlessly visualize and
analyze the profiler results with just a single click. The addition of the
--save-only command-line option allows users to save the profiler output
to a local file in Gecko Profile format, but the real highlight lies
in the capability to seamlessly launch a local server, making the data
accessible to Firefox Profiler via a web browser. In addition, it's
important to highlight that all data are hosted locally, eliminating
any concerns about data privacy rules and regulations.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 tools/perf/scripts/python/gecko.py | 70 +++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 7 deletions(-)

diff --git a/tools/perf/scripts/python/gecko.py b/tools/perf/scripts/python/gecko.py
index 278c3aed282a..bc5a72f94bfa 100644
--- a/tools/perf/scripts/python/gecko.py
+++ b/tools/perf/scripts/python/gecko.py
@@ -1,4 +1,4 @@
-# firefox-gecko-converter.py - Convert perf record output to Firefox's gecko profile format
+# gecko.py - Convert perf record output to Firefox's gecko profile format
 # SPDX-License-Identifier: GPL-2.0
 #
 # The script converts perf.data to Gecko Profile Format,
@@ -7,14 +7,26 @@
 # Usage:
 #
 #     perf record -a -g -F 99 sleep 60
-#     perf script report gecko > output.json
+#     perf script report gecko
+#
+# Combined:
+#
+#     perf script gecko -F 99 -a sleep 60
 
 import os
 import sys
+import time
 import json
+import string
+import random
 import argparse
+import threading
+import webbrowser
+import urllib.parse
+from os import system
 from functools import reduce
 from dataclasses import dataclass, field
+from http.server import HTTPServer, SimpleHTTPRequestHandler, test
 from typing import List, Dict, Optional, NamedTuple, Set, Tuple, Any
 
 # Add the Perf-Trace-Util library to the Python path
@@ -40,9 +52,15 @@ CATEGORIES = None
 # The product name is used by the profiler UI to show the Operating system and Processor.
 PRODUCT = os.popen('uname -op').read().strip()
 
+# store the output file
+output_file = None
+
 # Here key = tid, value = Thread
 tid_to_thread = dict()
 
+# The HTTP server is used to serve the profile to the profiler UI.
+http_server_thread = None
+
 # The category index is used by the profiler UI to show the color of the flame graph.
 USER_CATEGORY_INDEX = 0
 KERNEL_CATEGORY_INDEX = 1
@@ -278,9 +296,19 @@ def process_event(param_dict: Dict) -> None:
 		tid_to_thread[tid] = thread
 	thread._add_sample(comm=comm, stack=stack, time_ms=time_stamp)
 
+def trace_begin() -> None:
+	global output_file
+	if (output_file is None):
+		print("Staring Firefox Profiler on your default browser...")
+		global http_server_thread
+		http_server_thread = threading.Thread(target=test, args=(CORSRequestHandler, HTTPServer,))
+		http_server_thread.daemon = True
+		http_server_thread.start()
+
 # Trace_end runs at the end and will be used to aggregate
 # the data into the final json object and print it out to stdout.
 def trace_end() -> None:
+	global output_file
 	threads = [thread._to_json_dict() for thread in tid_to_thread.values()]
 
 	# Schema: https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L305
@@ -305,22 +333,50 @@ def trace_end() -> None:
 		"processes": [],
 		"pausedRanges": [],
 	}
-	json.dump(gecko_profile_with_meta, sys.stdout, indent=2)
+	# launch the profiler on local host if not specified --save-only args, otherwise print to file
+	if (output_file is None):
+		output_file = 'gecko_profile.json'
+		with open(output_file, 'w') as f:
+			json.dump(gecko_profile_with_meta, f, indent=2)
+		launchFirefox(output_file)
+		time.sleep(1)
+		print(f'[ perf gecko: Captured and wrote into {output_file} ]')
+	else:
+		print(f'[ perf gecko: Captured and wrote into {output_file} ]')
+		with open(output_file, 'w') as f:
+			json.dump(gecko_profile_with_meta, f, indent=2)
+
+# Used to enable Cross-Origin Resource Sharing (CORS) for requests coming from 'https://profiler.firefox.com', allowing it to access resources from this server.
+class CORSRequestHandler(SimpleHTTPRequestHandler):
+	def end_headers (self):
+		self.send_header('Access-Control-Allow-Origin', 'https://profiler.firefox.com')
+		SimpleHTTPRequestHandler.end_headers(self)
+
+# start a local server to serve the gecko_profile.json file to the profiler.firefox.com
+def launchFirefox(file):
+	safe_string = urllib.parse.quote_plus(f'http://localhost:8000/{file}')
+	url = 'https://profiler.firefox.com/from-url/' + safe_string
+	webbrowser.open(f'{url}')
 
 def main() -> None:
+	global output_file
 	global CATEGORIES
-	parser = argparse.ArgumentParser(description="Convert perf.data to Firefox\'s Gecko Profile format")
+	parser = argparse.ArgumentParser(description="Convert perf.data to Firefox\'s Gecko Profile format which can be uploaded to profiler.firefox.com for visualization")
 
 	# Add the command-line options
 	# Colors must be defined according to this:
 	# https://github.com/firefox-devtools/profiler/blob/50124adbfa488adba6e2674a8f2618cf34b59cd2/res/css/categories.css
-	parser.add_argument('--user-color', default='yellow', help='Color for the User category')
-	parser.add_argument('--kernel-color', default='orange', help='Color for the Kernel category')
+	parser.add_argument('--user-color', default='yellow', help='Color for the User category', choices=['yellow', 'blue', 'purple', 'green', 'orange', 'red', 'grey', 'magenta'])
+	parser.add_argument('--kernel-color', default='orange', help='Color for the Kernel category', choices=['yellow', 'blue', 'purple', 'green', 'orange', 'red', 'grey', 'magenta'])
+	# If --save-only is specified, the output will be saved to a file instead of opening Firefox's profiler directly.
+	parser.add_argument('--save-only', help='Save the output to a file instead of opening Firefox\'s profiler')
+
 	# Parse the command-line arguments
 	args = parser.parse_args()
 	# Access the values provided by the user
 	user_color = args.user_color
 	kernel_color = args.kernel_color
+	output_file = args.save_only
 
 	CATEGORIES = [
 		{
@@ -336,4 +392,4 @@ def main() -> None:
 	]
 
 if __name__ == '__main__':
-    main()
+	main()
-- 
2.34.1

