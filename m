Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C40B76FB34
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 09:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbjHDHca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 03:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbjHDHcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 03:32:03 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCC14EE0;
        Fri,  4 Aug 2023 00:31:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0Vp.c2KL_1691134195;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vp.c2KL_1691134195)
          by smtp.aliyun-inc.com;
          Fri, 04 Aug 2023 15:29:56 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        james.clark@arm.com, leo.yan@linaro.org
Cc:     mingo@redhat.com, baolin.wang@linux.alibaba.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, bpf@vger.kernel.org
Subject: [PATCH v4 2/2] perf record: Update docs regarding the maximum limitation of AUX area
Date:   Fri,  4 Aug 2023 15:29:45 +0800
Message-Id: <20230804072945.85731-3-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804072945.85731-1-xueshuai@linux.alibaba.com>
References: <20230804072945.85731-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maximum AUX area is limited by the page size of the system. Update
the documentation to reflect this.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 tools/perf/Documentation/perf-record.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 680396c56bd1..b0ee7b63da0e 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -292,6 +292,9 @@ OPTIONS
 	Also, by adding a comma, the number of mmap pages for AUX
 	area tracing can be specified.
 
+	The maximum AUX area is limited by the page size of the system. For
+	example with 4K pages configured, the maximum is 2GiB.
+
 -g::
 	Enables call-graph (stack chain/backtrace) recording for both
 	kernel space and user space.
-- 
2.39.3

