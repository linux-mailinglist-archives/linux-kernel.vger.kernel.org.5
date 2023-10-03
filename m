Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE057B6E85
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240569AbjJCQcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjJCQck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:32:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BF1AF;
        Tue,  3 Oct 2023 09:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696350757; x=1727886757;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N5+XInekXK/3jlx2mlTDtiQAjBZc8FbJO7CCLm/0Lpc=;
  b=hl5qvzEPy9fiUGxMlerxvT1N+fVHr+v4795MYg6aCnxDphK5pZPlfq6m
   FbpE5OSzYi1ORfn4ox74XraURW83jQZVQDu5KeSQSeauJ6IoNzBEKqXJ8
   Hefh1YD7hhrL5rQ4X38F15CP/GeNTET5Pen7AyAnsIv+TkCo0FGTs1Apk
   6CZc1FSebUbGT+etbNmakFuSjOK2jR1G0rEZOsipqgrpzpjPf5Ta84/+/
   VlEh5cCW7CDIEILG+j80as44gOCOLaE19fa9fVrbja08aNX3c3g17TxE4
   9DN7ZB7JZLvV21RNkVt4AVqYiNCJuzkd8f777GomUZ3/u28+cSwsyXN0i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="381799116"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="381799116"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 09:32:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082069879"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="1082069879"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga005.fm.intel.com with ESMTP; 03 Oct 2023 09:32:36 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/4] Minor SST optimizations
Date:   Tue,  3 Oct 2023 09:32:30 -0700
Message-Id: <20231003163234.1856669-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Contains some minor changes to use SST for non dynamic use cases
for display purpose and remove hardcoded size for map.

v2
Update commit description, no code change
Added a new patch which was independent before

Srinivas Pandruvada (4):
  platform/x86: ISST: Use fuse enabled mask instead of allowed levels
  platform/x86: ISST: Allow level 0 to be not present
  platform/x86: intel_speed_select_if: Remove hardcoded map size
  platform/x86: intel_speed_select_if: Use devm_ioremap_resource

 .../x86/intel/speed_select_if/isst_if_mmio.c  | 21 ++++++++++++-------
 .../intel/speed_select_if/isst_tpmi_core.c    |  5 +----
 2 files changed, 14 insertions(+), 12 deletions(-)

-- 
2.41.0

