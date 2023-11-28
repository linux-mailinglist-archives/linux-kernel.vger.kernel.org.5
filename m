Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178257FC289
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346471AbjK1RxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345727AbjK1RxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:53:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBC793;
        Tue, 28 Nov 2023 09:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701193986; x=1732729986;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AVNjVyUanOhTTHDIFmk7Tc/GQGOGXheE7jl3n156kCE=;
  b=CM1d/s3uxXKFB5YXllQog69orGExDLLSjI5cQg01wr78IMhRct3uECKh
   y0SFfZIAbTIkV+s0yizVaLhHTIXqIImsq+tfxkWS5/Xm6HTpma3ydSSUO
   y2Dmddx4ZCWkJ2LH1nHI3S14zufTqLwwmpJk3y2KRWpfK/lI86JpJsk3b
   0CRQrh7oPOYSOvwhexxZKjDE0IvabCl83+J3X+1sD2nHzoSYvJBsWyI7v
   11en+yRKiBJAMZNaG1mJbkCTfmYxVaRdoE4JazwW3U96tZliTILLzFgAD
   t4WCmm9NTROqIMJdenmf0ad/gM7WFf6iCdwtvEhkG3+g/R21odeoFHaDH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="373160118"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="373160118"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 09:48:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="942001260"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="942001260"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 28 Nov 2023 09:48:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A98A823E; Tue, 28 Nov 2023 19:48:16 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v1 1/1] net/sched: cbs: Use units.h instead of the copy of a definition
Date:   Tue, 28 Nov 2023 19:48:13 +0200
Message-ID: <20231128174813.394462-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BYTES_PER_KBIT is defined in units.h, use that definition.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 net/sched/sch_cbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index 9a0b85190a2c..beece8e82c23 100644
--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -57,6 +57,8 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/skbuff.h>
+#include <linux/units.h>
+
 #include <net/netevent.h>
 #include <net/netlink.h>
 #include <net/sch_generic.h>
@@ -65,8 +67,6 @@
 static LIST_HEAD(cbs_list);
 static DEFINE_SPINLOCK(cbs_list_lock);
 
-#define BYTES_PER_KBIT (1000LL / 8)
-
 struct cbs_sched_data {
 	bool offload;
 	int queue;
-- 
2.43.0.rc1.1.gbec44491f096

