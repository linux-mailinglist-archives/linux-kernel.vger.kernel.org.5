Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F697F5EB9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345216AbjKWMGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345196AbjKWMGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:06:17 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1798A98
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 04:06:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 434A91042;
        Thu, 23 Nov 2023 04:07:10 -0800 (PST)
Received: from e127643.arm.com (unknown [10.57.3.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 37A673F7A6;
        Thu, 23 Nov 2023 04:06:22 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, suzuki.poulose@arm.com
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 0/4] coresight: Make current W=1 warnings default
Date:   Thu, 23 Nov 2023 12:04:55 +0000
Message-Id: <20231123120459.287578-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:

  * Split code and Makefile changes
  * Add a fix for a comment warning in etm3x
  * Add some sparse checker fixes in coresight-cfg-afdo.c
  * Fix the 0 instead of NULL warnings reported by kernel test robot

James Clark (4):
  coresight: Fix uninitialized struct warnings
  coresight: etm3x: Fix build warning
  coresight: Fix undeclared variable warnings from sparse checker
  coresight: Make current W=1 warnings default

 drivers/hwtracing/coresight/Makefile          | 20 +++++++++++++++++++
 .../hwtracing/coresight/coresight-cfg-afdo.c  |  1 +
 .../hwtracing/coresight/coresight-cti-core.c  |  2 +-
 drivers/hwtracing/coresight/coresight-etb10.c |  2 +-
 .../coresight/coresight-etm3x-core.c          |  4 ++--
 .../coresight/coresight-etm4x-core.c          |  2 +-
 .../hwtracing/coresight/coresight-funnel.c    |  4 ++--
 .../coresight/coresight-replicator.c          |  2 +-
 drivers/hwtracing/coresight/coresight-stm.c   |  2 +-
 .../hwtracing/coresight/coresight-tmc-core.c  |  2 +-
 drivers/hwtracing/coresight/coresight-tpda.c  |  2 +-
 drivers/hwtracing/coresight/coresight-tpdm.c  |  2 +-
 drivers/hwtracing/coresight/coresight-tpiu.c  |  2 +-
 drivers/hwtracing/coresight/ultrasoc-smb.c    |  2 +-
 14 files changed, 35 insertions(+), 14 deletions(-)

-- 
2.34.1

