Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD05C7661C3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 04:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjG1CZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 22:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjG1CZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 22:25:03 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6D630D7;
        Thu, 27 Jul 2023 19:24:54 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2680eee423aso966997a91.2;
        Thu, 27 Jul 2023 19:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690511094; x=1691115894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gkA9T81dJeHltp+yU+ufIxNEM6ta13sa3gzDpx7fjW0=;
        b=HI66uQEDmixeLcinjB+jPqbc9qCoNsIcmxIzFAIQKnzlmEmgkcaHNi6kb+ZpeAL/U0
         uIiOYzYTFZBYIUVJSGqbWgYbpvbdizazBAdIxrSmUOWtCnLt6rfVOmmhRsoGbYfvPEa6
         QRF/a4Mlxj3ygUrn3Um8CMsyW/XX5yUW4mj3fvreODdLh47/NrtBKEJcT/ExB/V/8TZM
         H5dsrB9ryMODykPl6VM4xRXLOogW4ufkHkF/WMKKRTcDZY0JkKbJm6v4s970lIGImruE
         ffhgWTJCk/TDacZ/t8TuDfKscKe+OjgpsZVFOCj8070VcD/3v8tBa9bTBLN3YrXoy57a
         oebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690511094; x=1691115894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkA9T81dJeHltp+yU+ufIxNEM6ta13sa3gzDpx7fjW0=;
        b=BJjsemPdCO2u+5nap7qVlx1YviLXxWZpF+qTpWdk+Y4BeK2opRhLFE8R1jGTLf/DnH
         I8S2XS4zm/YGKfH/CnqjoyMuKH8YlNX4jFyIkK8KenpFrItZMaszXF3tlGQgE+MLzuiJ
         REaqioAL0+2UGtR016n1A3wv8naQ9UCtiW4sQZUidEH/RKWrqWZYREcXswijKDcNShDN
         JFX9XFF6bJylk94Uvr678cTfACyvo/YvsEJNusYzzqnN/f0Ghc4gPM26UZebDrea+41n
         Oxxodv3M5YYQWGVu4Ph366VkuAmuKtJkGSwz04v0Z8QFb3XyMmFLOmnPwxxOlHru7185
         b/cQ==
X-Gm-Message-State: ABy/qLafXa23jVKz0aP3ulFM4/JU3wdKhsjckFfnZn30mIcfhxFteC8l
        8c4b+nti+OwXIFBDh5523VA=
X-Google-Smtp-Source: APBJJlEwJhPWJKZsZQeGFPwTxNQmninTZZ0E6thOjeJZTpghZnTqpWvomE+R8nH/+SNAU7Gfp6il1Q==
X-Received: by 2002:a17:90b:1910:b0:268:18d2:3e98 with SMTP id mp16-20020a17090b191000b0026818d23e98mr305495pjb.43.1690511093787;
        Thu, 27 Jul 2023 19:24:53 -0700 (PDT)
Received: from bangji.roam.corp.google.com ([101.235.25.38])
        by smtp.gmail.com with ESMTPSA id gz24-20020a17090b0ed800b002677739860fsm1696204pjb.34.2023.07.27.19.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 19:24:53 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Anup Sharma <anupnewsmail@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v2 1/2] perf build: Update build rule for generated files
Date:   Thu, 27 Jul 2023 19:24:46 -0700
Message-ID: <20230728022447.1323563-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bison and flex generate C files from the source (.y and .l)
files.  When O= option is used, they are saved in a separate directory
but the default build rule assumes the .C files are in the source
directory.  So it might read invalid file if there are generated files
from an old version.  The same is true for the pmu-events files.

For example, the following command would cause a build failure:

  $ git checkout v6.3
  $ make -C tools/perf  # build in the same directory

  $ git checkout v6.5-rc2
  $ mkdir build  # create a build directory
  $ make -C tools/perf O=build  # build in a different directory but it
                                # refers files in the source directory

Let's update the build rule to specify those cases explicitly to depend
on the files in the output directory.

Note that it's not a complete fix and it needs the next patch for the
include path too.

Fixes: 80eeb67fe577 ("perf jevents: Program to convert JSON file")
Cc: stable@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/build/Makefile.build  | 10 ++++++++++
 tools/perf/pmu-events/Build |  6 ++++++
 2 files changed, 16 insertions(+)

diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
index 89430338a3d9..fac42486a8cf 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -117,6 +117,16 @@ $(OUTPUT)%.s: %.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_s_c)
 
+# bison and flex files are generated in the OUTPUT directory
+# so it needs a separate rule to depend on them properly
+$(OUTPUT)%-bison.o: $(OUTPUT)%-bison.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,$(host)cc_o_c)
+
+$(OUTPUT)%-flex.o: $(OUTPUT)%-flex.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,$(host)cc_o_c)
+
 # Gather build data:
 #   obj-y        - list of build objects
 #   subdir-y     - list of directories to nest
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 150765f2baee..1d18bb89402e 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -35,3 +35,9 @@ $(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_L
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) pmu-events/arch $@
 endif
+
+# pmu-events.c file is generated in the OUTPUT directory so it needs a
+# separate rule to depend on it properly
+$(OUTPUT)pmu-events/pmu-events.o: $(PMU_EVENTS_C)
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
-- 
2.41.0.487.g6d72f3e995-goog

