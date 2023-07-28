Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36A67664E4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjG1HKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbjG1HJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:09:57 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CD73A8B;
        Fri, 28 Jul 2023 00:09:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VoP1ovS_1690528184;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VoP1ovS_1690528184)
          by smtp.aliyun-inc.com;
          Fri, 28 Jul 2023 15:09:45 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH v5 3/3] docs: perf: Update metric usage for Alibaba's T-Head PMU driver
Date:   Fri, 28 Jul 2023 15:09:35 +0800
Message-Id: <1690528175-2499-4-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1690528175-2499-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1690528175-2499-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alibaba's T-Head ali_drw PMU supports DDR bandwidth metrics. Update
its usage in the documentation.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
Acked-by: Ian Rogers <irogers@google.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
---
 Documentation/admin-guide/perf/alibaba_pmu.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/perf/alibaba_pmu.rst b/Documentation/admin-guide/perf/alibaba_pmu.rst
index 11de998..7d84002 100644
--- a/Documentation/admin-guide/perf/alibaba_pmu.rst
+++ b/Documentation/admin-guide/perf/alibaba_pmu.rst
@@ -88,6 +88,11 @@ data bandwidth::
     -e ali_drw_27080/hif_rmw/ \
     -e ali_drw_27080/cycle/ -- sleep 10
 
+Example usage of counting all memory read/write bandwidth by metric::
+
+  perf stat -M ddr_read_bandwidth.all -- sleep 10
+  perf stat -M ddr_write_bandwidth.all -- sleep 10
+
 The average DRAM bandwidth can be calculated as follows:
 
 - Read Bandwidth =  perf_hif_rd * DDRC_WIDTH * DDRC_Freq / DDRC_Cycle
-- 
1.8.3.1

