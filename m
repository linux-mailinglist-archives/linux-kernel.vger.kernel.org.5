Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931F17BA3B6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238109AbjJEP6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbjJEP4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:56:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AEB4EEA
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:52:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842C8C4AF7C;
        Thu,  5 Oct 2023 13:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696513590;
        bh=Vxu7IYRcRA3at04zzkrUOH/h71VC6MDIlrfNN/mUCfM=;
        h=Date:From:To:Cc:Subject:From;
        b=O1ZaV9SYvnrbjSGzWTKxmLNRNBaBQZuQME1HGQJkya6AjnB6lsfOKqayss1fVsZZH
         sTMdb/rgggQN3IbYjLZ0dkOmCqc451rnsXk8P+WUO+eBf26OKIaFmpVhv+eFvfcXUW
         eVYj5bVCnd95dFn0uvtX2935jyYfSt+8EGKnk1LacIuQx98scrHHoH6E0dRZR+ct6g
         u5R84/GDFxEnGFaY/dMsgDGeevJlrJbcm7GxvfyeAyYKoHdYMQiBSdSzWeVLqPj9j3
         kagXnFldPXej/15J+i4S/LGYlyi13cYE38xQs/3JTzSM3B93HjE6PzQ/QlsAMAMPld
         3BxHdj7+7DQsA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D115F40508; Thu,  5 Oct 2023 10:46:26 -0300 (-03)
Date:   Thu, 5 Oct 2023 10:46:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf build: Add missing comment about NO_LIBTRACEEVENT=1
Message-ID: <ZR6+MhXtLnv6ow6E@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

By default perf will fail the build if the development files for
libtraceevent are not available.

To build perf without libtraceevent support, disabling several features
such as 'perf trace', one needs to add NO_LIBTRACEVENT=1 to the make
command line.

Add the missing comments about that to the tools/perf/Makefile.perf
file, just like all the other such command line toggles.

Fixes: 378ef0f5d9d7f465 ("perf build: Use libtraceevent from the system")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 98604e396ac33643..456872ac410df4c0 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -69,6 +69,10 @@ include ../scripts/utilities.mak
 # Define NO_LIBDW_DWARF_UNWIND if you do not want libdw support
 # for dwarf backtrace post unwind.
 #
+# Define NO_LIBTRACEEVENT=1 if you don't want libtraceevent to be linked,
+# this will remove multiple features and tools, such as 'perf trace',
+# that need it to read tracefs event format files, etc.
+#
 # Define NO_PERF_READ_VDSO32 if you do not want to build perf-read-vdso32
 # for reading the 32-bit compatibility VDSO in 64-bit mode
 #
-- 
2.41.0

-- 
