Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597B1813033
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573045AbjLNMdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573052AbjLNMdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:33:05 -0500
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0332CA3;
        Thu, 14 Dec 2023 04:33:10 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VyUW05Z_1702557186;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0VyUW05Z_1702557186)
          by smtp.aliyun-inc.com;
          Thu, 14 Dec 2023 20:33:08 +0800
From:   Ruidong Tian <tianruidong@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     james.clark@arm.com, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        al.grant@arm.com, mathieu.poirier@linaro.org, tor@ti.com,
        acme@redhat.com, Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH 0/3] perf scripts python: arm-cs-trace-disasm.py:
Date:   Thu, 14 Dec 2023 20:33:01 +0800
Message-Id: <20231214123304.34087-1-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the instruction flow disasmed by arm-cs-trace-disasm.py is
ambiguous and uncorrect, fix them in one patch set. Please refer to
each patch for details.

Ruidong Tian (3):
  perf scripts python: arm-cs-trace-disasm.py: print dso base address
  perf scripts python: arm-cs-trace-disasm.py: set start vm addr of
    exectable file to 0
  perf scripts python: arm-cs-trace-disasm.py: do not ignore disam first
    sample

 .../scripts/python/arm-cs-trace-disasm.py     | 28 +++++++++++--------
 1 file changed, 16 insertions(+), 12 deletions(-)

-- 
2.33.1

