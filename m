Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1C27A781C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbjITJz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbjITJzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:55:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDA25AB;
        Wed, 20 Sep 2023 02:55:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4DFA1FB;
        Wed, 20 Sep 2023 02:55:45 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.59.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AD71E3F5A1;
        Wed, 20 Sep 2023 02:55:04 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 3/3] Documentation: coresight: Add cc_threshold tunable
Date:   Wed, 20 Sep 2023 15:24:43 +0530
Message-Id: <20230920095443.1126617-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230920095443.1126617-1-anshuman.khandual@arm.com>
References: <20230920095443.1126617-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This updates config option to include 'cc_threshold' tunable value.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 Documentation/trace/coresight/coresight.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/trace/coresight/coresight.rst b/Documentation/trace/coresight/coresight.rst
index 4a71ea6cb390..ce55adb80b82 100644
--- a/Documentation/trace/coresight/coresight.rst
+++ b/Documentation/trace/coresight/coresight.rst
@@ -624,6 +624,10 @@ They are also listed in the folder /sys/bus/event_source/devices/cs_etm/format/
    * - timestamp
      - Session local version of the system wide setting: :ref:`ETMv4_MODE_TIMESTAMP
        <coresight-timestamp>`
+   * - cc_threshold
+     - Cycle count threshold value. If nothing is provided here or the provided value is 0, then the
+       default value i.e 0x100 will be used. If provided value is less than minimum cycles threshold
+       value, as indicated via TRCIDR3.CCITMIN, then the minimum value will be used instead.
 
 How to use the STM module
 -------------------------
-- 
2.25.1

