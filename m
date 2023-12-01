Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95418801479
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379462AbjLAUau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjLAUar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:30:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4229F10E4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 12:30:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2304CC433C7;
        Fri,  1 Dec 2023 20:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701462653;
        bh=oYvbCsefC5KwoaF4UMSezCq8AouWW9D3M0cUHQKQjZI=;
        h=From:To:Cc:Subject:Date:From;
        b=ch12lXcNqhMroaWVCJExuQeZiV/Ju0LjE1Wb4NQv1YipJlFnDOjE6hRuBdrFBOUuL
         zozYHRK+Z0ctoILkMP3f0RDRfT5sF5qCbbU7tlfRGb1J7oxNI4dUGv8p4C/2C14vLB
         drnVuHtybSHE1LoDIR5R13JrhI7ZCXMvS3E+IeXUbeACWaAZk7WE+XiInExX+Mp9A1
         AHJvEJYgZXQQp1rQlg4puYCdT6/O/I9gjlMNdwOxabn3SEnuNRic9B212AaAwGhOGV
         db8kDoequT1mu48kA9xQ+JsAcfE5Khq80G5AMrZmHB6Yay9ZnEthNzOdQT4RyhuNN1
         MaapTknfSS07A==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 0/2] Cache the arch specific stderrno routine
Date:   Fri,  1 Dec 2023 17:30:44 -0300
Message-ID: <20231201203046.486596-1-acme@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi,

	Please take a look,

- Arnaldo

Arnaldo Carvalho de Melo (2):
  perf env: Introduce perf_env__arch_strerrno()
  perf env: Cache the arch specific strerrno function in perf_env__arch_strerrno()

 tools/perf/builtin-trace.c                  | 6 ++----
 tools/perf/trace/beauty/arch_errno_names.sh | 6 +++---
 tools/perf/trace/beauty/beauty.h            | 2 --
 tools/perf/util/env.c                       | 9 +++++++++
 tools/perf/util/env.h                       | 6 ++++++
 5 files changed, 20 insertions(+), 9 deletions(-)

-- 
2.41.0

