Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2809478C49B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbjH2M6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjH2M6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:58:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412DEBF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693313881; x=1724849881;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yS5NXffBK6FzzPUtmmw2b4k7yzBOa0z4VZrI3slcznU=;
  b=jHTp9adxmALs8Fs42P+PsuL/eyZyewtChHZR4KBZFXzuKOZrz3P0sAoE
   JU7jnXTCzbBZpIzeU2qOzIi0n+XHvon3KfkParJHE/msT0qoaYMLYCL7W
   lAsYKHgt59+HNvwRAh755T42pbNFcXzxa5f1Xu7ZTQcO5bmeto01KZCTj
   UAcSQzv521+zM4/H9sisv7I0s211yJQtSOwkXT2V9z958kr1XIXR9CRqZ
   yoqX9thryyrcWHQSmGuFC5zJ9wnMmxYMYEVL4nWyF+IsBFm+6J6xG1MOM
   BXXz809FWUDsd+3/lQxSzTsZgDxVWKloFG432FlSGe9uc2U2ZQCCTHoim
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="406354901"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="406354901"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 05:58:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="853272005"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="853272005"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2023 05:58:00 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     dapeng1.mi@linux.intel.com, zhenyuw@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 0/6] Cleanup Intel PMU initialization code
Date:   Tue, 29 Aug 2023 05:58:00 -0700
Message-Id: <20230829125806.3016082-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The patch set is to clean up the Intel PMU initialization code. There is
no functional change.

Kan Liang (6):
  perf/x86/intel: Use the common uarch name for the shared functions
  perf/x86/intel: Factor out the initialization code for SPR
  perf/x86/intel: Factor out the initialization code for ADL e-core
  perf/x86/intel: Apply the common initialization code for ADL
  perf/x86/intel: Cleanup the hybrid CPU type
  perf/x86/intel: Add common intel_pmu_init_hybrid

 arch/x86/events/core.c       |   6 +-
 arch/x86/events/intel/core.c | 397 ++++++++++++++++++-----------------
 arch/x86/events/intel/ds.c   |   4 +-
 arch/x86/events/perf_event.h |  37 ++--
 4 files changed, 226 insertions(+), 218 deletions(-)

-- 
2.35.1

