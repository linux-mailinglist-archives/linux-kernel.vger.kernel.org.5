Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8643B7F206B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjKTWdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjKTWdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:33:08 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2C7AA;
        Mon, 20 Nov 2023 14:33:04 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5c2139492d9so1620878a12.0;
        Mon, 20 Nov 2023 14:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700519584; x=1701124384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gwUXyg7MBmR4xeoVYVivfJ5Bm/G7s4W1J7Z6JZoWHTc=;
        b=D5FSm8Ec+P9QK18MgaEK6Ua3hbx6eGzyxSvsGa0lioMTkWpEudlAQhDA7MfEQKrayL
         WzeiQ5cnZuDkCuWxr3WDr56BuDZ05SnQWQ+i6XugProUXbY7uVUfbGQ/1DBgnhjHED0x
         hMXfW6rAmb0TirMH2btDtmY+4I1JCspDoCgDuA0JfHFds61SwOPQpwfZ9bZ2UA/xdFOB
         HAX+HpARlAv4PzigYQ1oy7Je9TtYZk2eMHbz/m6bXq042v0/EhzBko1i8wRrAqb+WVv5
         lRB8sy59CREuwtl+IUvdPaZ/+pKtCFKi+dakOSKJpnG6hXw6pyoA1nbf5HwuOfdRXbJM
         aozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700519584; x=1701124384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gwUXyg7MBmR4xeoVYVivfJ5Bm/G7s4W1J7Z6JZoWHTc=;
        b=rOME1N/+G98BaaLE2FKU7pIO5pVygKQe/Ho7FN/f1504ZCvjEDihN0j+PMv6jJ2dg0
         aUoUzo8NNVBMi02mmdk39KZAlZ8xmOJP1t+S99joSH5Thx0Ro/R8HUK5lldzNuPVbcsv
         yMdoZ1KC+SyEnIxJvdpJTaWA0rNV6STsls7buzlAN4LQKQfcikwv89MVB0wDbqSzbnAO
         cm+/vyK6k8uV/rJdObbFUEpW71w3tHxo6tOxcaRkkGl1hXeuvT9QHMj+7gaXPP9y8AIS
         QKmjnEhw59I3VX6rQmNvo1br4f8AezE0uYutRqwzn/45i22YbJQdjjPUM4pbsbYDNWSj
         ywEQ==
X-Gm-Message-State: AOJu0Yy5bjhE6r0I7+32ODE4fS6Kdfe8yoXCrDJZwMyIr+15yrND1kbF
        wrP/L0AXS9azd+qfU7dAntQ=
X-Google-Smtp-Source: AGHT+IF8aM7kBXwdxWcd5QRBWOgY83+8colpgzLEa0t5kFMKqb+LSLgcbvB3DrS/MP2lq41NucbcnQ==
X-Received: by 2002:a17:90b:4d0d:b0:27d:c36:e12d with SMTP id mw13-20020a17090b4d0d00b0027d0c36e12dmr6759637pjb.6.1700519583993;
        Mon, 20 Nov 2023 14:33:03 -0800 (PST)
Received: from DESKTOP-NK4TH6S.localdomain ([220.72.86.144])
        by smtp.gmail.com with ESMTPSA id k8-20020a17090a658800b00283a0b0fd39sm4917352pjj.53.2023.11.20.14.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 14:33:03 -0800 (PST)
From:   Paran Lee <p4ranlee@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Li Dong <lidong@vivo.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        shjy180909@gmail.com, austindh.kim@gmail.com, honggyu.kp@gmail.com,
        Paran Lee <p4ranlee@gmail.com>
Subject: [PATCH V3 RESEND] perf script python: Fail check on dynamic allocation
Date:   Tue, 21 Nov 2023 07:32:19 +0900
Message-Id: <20231120223218.9036-1-p4ranlee@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PyList_New() Fail check in get_field_numeric_entry()
function and dynamic allocation checking for
set_regs_in_dict(), python_start_script().

Signed-off-by: Paran Lee <p4ranlee@gmail.com>
Reviewed-by: MichelleJin <shjy180909@gmail.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../util/scripting-engines/trace-event-python.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 94312741443a..860e1837ba96 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -353,6 +353,8 @@ static PyObject *get_field_numeric_entry(struct tep_event *event,
 
 	if (is_array) {
 		list = PyList_New(field->arraylen);
+		if (!list)
+			Py_FatalError("couldn't create Python list");
 		item_size = field->size / field->arraylen;
 		n_items = field->arraylen;
 	} else {
@@ -754,7 +756,7 @@ static void regs_map(struct regs_dump *regs, uint64_t mask, const char *arch, ch
 	}
 }
 
-static void set_regs_in_dict(PyObject *dict,
+static int set_regs_in_dict(PyObject *dict,
 			     struct perf_sample *sample,
 			     struct evsel *evsel)
 {
@@ -770,6 +772,8 @@ static void set_regs_in_dict(PyObject *dict,
 	 */
 	int size = __sw_hweight64(attr->sample_regs_intr) * 28;
 	char *bf = malloc(size);
+	if (!bf)
+		return -1;
 
 	regs_map(&sample->intr_regs, attr->sample_regs_intr, arch, bf, size);
 
@@ -781,6 +785,8 @@ static void set_regs_in_dict(PyObject *dict,
 	pydict_set_item_string_decref(dict, "uregs",
 			_PyUnicode_FromString(bf));
 	free(bf);
+
+	return 0;
 }
 
 static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
@@ -920,7 +926,8 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 			PyLong_FromUnsignedLongLong(sample->cyc_cnt));
 	}
 
-	set_regs_in_dict(dict, sample, evsel);
+	if (set_regs_in_dict(dict, sample, evsel))
+		Py_FatalError("Failed to setting regs in dict");
 
 	return dict;
 }
@@ -1918,12 +1925,18 @@ static int python_start_script(const char *script, int argc, const char **argv,
 	scripting_context->session = session;
 #if PY_MAJOR_VERSION < 3
 	command_line = malloc((argc + 1) * sizeof(const char *));
+	if (!command_line)
+		return -1;
+
 	command_line[0] = script;
 	for (i = 1; i < argc + 1; i++)
 		command_line[i] = argv[i - 1];
 	PyImport_AppendInittab(name, initperf_trace_context);
 #else
 	command_line = malloc((argc + 1) * sizeof(wchar_t *));
+	if (!command_line)
+		return -1;
+
 	command_line[0] = Py_DecodeLocale(script, NULL);
 	for (i = 1; i < argc + 1; i++)
 		command_line[i] = Py_DecodeLocale(argv[i - 1], NULL);
-- 
2.25.1

