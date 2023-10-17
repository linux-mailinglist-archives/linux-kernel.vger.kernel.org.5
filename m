Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9589D7CCA78
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 20:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343934AbjJQSPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 14:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjJQSPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 14:15:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B9190
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 11:14:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0E9C433C7;
        Tue, 17 Oct 2023 18:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697566498;
        bh=CU3Hbht+xgnbWCMH9iiHjNgHCRgTzr4cVBHVQPdBK/I=;
        h=Date:From:To:Cc:Subject:From;
        b=oFAKJaIGSlPoSdMW7uDqldTkrShTBUR+46joxFrjetc5x3/xz6JGs6fDABA7+RgkQ
         DwEGvi4ux7yfJDP3w0Qoa/13IMCwv8D829ZQ+hhlhZPF54pRgB3NsnZvSTfABGWP19
         nWDiy2vhsQlkMsuIMhFTHqn1IAo+FvHFdOoU677zsl+6fYaD9m+96nMLtaUsCxig9G
         nXuBo8rXGuzpZ0mxZfieRwQ44rrGMSyT4g/LaceSEsSc0PCGzF5xEnHfzhMP/nAjJg
         8IEAUBK0MPRtMromZzUXP0G7xd1Lun1E2gz/+hwWJlQ7fQExerJaKh3I2o6FrrAWsP
         +960i+WEsNvog==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2A92F40016; Tue, 17 Oct 2023 15:14:56 -0300 (-03)
Date:   Tue, 17 Oct 2023 15:14:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf build: Remove stray '\' before that is warned about
 since grep 3.8
Message-ID: <ZS7PIHUZfHcrfvi4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To address this grep 3.8 warning:

  grep: warning: stray \ before #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 456872ac410df4c0..25d5ccaec22a44fe 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -361,7 +361,7 @@ python-clean := $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT
 ifeq ($(CONFIG_LIBTRACEEVENT),y)
   PYTHON_EXT_SRCS := $(shell grep -v ^\# util/python-ext-sources)
 else
-  PYTHON_EXT_SRCS := $(shell grep -v '^\#\|util/trace-event.c' util/python-ext-sources)
+  PYTHON_EXT_SRCS := $(shell grep -v '^#\|util/trace-event.c' util/python-ext-sources)
 endif
 
 PYTHON_EXT_DEPS := util/python-ext-sources util/setup.py $(LIBAPI)
-- 
2.41.0

