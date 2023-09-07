Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCCB796E22
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 02:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244759AbjIGAnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 20:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236942AbjIGAnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 20:43:19 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7DE173B;
        Wed,  6 Sep 2023 17:43:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VrV7FnU_1694047390;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VrV7FnU_1694047390)
          by smtp.aliyun-inc.com;
          Thu, 07 Sep 2023 08:43:12 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        james.clark@arm.com, leo.yan@linaro.org
Cc:     mingo@redhat.com, baolin.wang@linux.alibaba.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, bpf@vger.kernel.org
Subject: [PATCH v5 0/2] perf/core: Bail out early if the request AUX area is out of bound
Date:   Thu,  7 Sep 2023 08:43:06 +0800
Message-Id: <20230907004308.25874-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes since v4 (per Leo):
- refine comments as Leo asked
- correct aux limitation in doc by adding a formula

changes since v3 (per James):
- change to return with existing value -ENOMEM
- split doc part to a separate patch since they are going to be merged through
  separate trees.

changes since v2:
- remove unnecessary overflow check (per Peter)

changes since v1:
- drop out patch2 because it has been fixed on upstream (Thanks James for reminding)
- move sanity check into rb_alloc_aux (per Leo)
- add overflow check (per James)

Shuai Xue (2):
  perf/core: Bail out early if the request AUX area is out of bound
  perf record: Update docs regarding the maximum limitation of AUX area

 kernel/events/ring_buffer.c              |  6 ++++++
 tools/perf/Documentation/perf-record.txt | 11 +++++++++++
 2 files changed, 17 insertions(+)

-- 
2.39.3

