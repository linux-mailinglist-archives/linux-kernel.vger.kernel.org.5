Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5777F7901F7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 20:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350541AbjIASVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 14:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347827AbjIASVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 14:21:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B28E72
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 11:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693592467; x=1725128467;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ielWKvW2WTPc3ZESd7s3KQPjA5J0+kUTOO7KVSHO2yM=;
  b=TSr7rI4oGWFPkbD78QnkTkor7ulMJ9cO9ZLDTcQu7ZtJD/CvU7FcxJ8+
   hxdmOVAsfPO9jLb3mg9C9ZCNDMzpBwr50BhkmKB8e92mGwVPs6Uv9Dk+M
   rdNbmywzgLvZMIh7TzEXQd15IUzEZARLx26xgnZmLX6BxQGmlNesVoU7F
   y4wrFfPmHQxVu4egmgGmuxb2oxGj8g9RIkop30fRupp4Ewo6eQkz7dz9C
   N7JLQsdhjksjhcDET+yNvT3kj0kLSFlA/ptLEaDnILRMfIy71A9h1aSxD
   lJspMTFRxOcGxVYHzy+HQf8CmRQ/g5y1UTJQumOqZbjunraHB3gJvgdzH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="462643171"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="462643171"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 11:21:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="1070826998"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="1070826998"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by fmsmga005.fm.intel.com with ESMTP; 01 Sep 2023 11:21:06 -0700
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/urgent for 6.6-rc1
Date:   Fri,  1 Sep 2023 11:20:54 -0700
Message-Id: <20230901182054.110950-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull some x86/urgent changes for 6.6-rc1.

The most important fix here adds a missing CPU model to the recent
Gather Data Sampling (GDS) mitigation list to ensure that mitigations
are available on that CPU.

There are also a pair of warning fixes, and closure of a covert
channel that pops up when protection keys are disabled.

--

The following changes since commit 2c66ca3949dc701da7f4c9407f2140ae425683a5:

  x86/fpu: Set X86_FEATURE_OSXSAVE feature after enabling OSXSAVE in CR4 (2023-08-24 11:01:45 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86-urgent-2023-09-01

for you to fetch changes up to 18032b47adf1db7b7f5fb2d1344e65aafe6417df:

  x86/fpu/xstate: Fix PKRU covert channel (2023-08-31 23:29:49 +0200)

----------------------------------------------------------------
 * Mark all Skylake CPUs as vulnerable to GDS
 * Fix PKRU covert channel
 * Fix -Wmissing-variable-declarations warning for ia32_xyz_class
 * Fix kernel-doc annotation warning

----------------------------------------------------------------
Dave Hansen (1):
      x86/speculation: Mark all Skylake CPUs as vulnerable to GDS

Jim Mattson (1):
      x86/fpu/xstate: Fix PKRU covert channel

Justin Stitt (1):
      x86/audit: Fix -Wmissing-variable-declarations warning for ia32_xyz_class

Vincenzo Palazzo (1):
      x86/irq/i8259: Fix kernel-doc annotation warning

 arch/x86/include/asm/audit.h | 7 +++++++
 arch/x86/kernel/audit_64.c   | 5 -----
 arch/x86/kernel/cpu/common.c | 8 ++++----
 arch/x86/kernel/fpu/xstate.c | 2 +-
 arch/x86/kernel/i8259.c      | 4 +---
 5 files changed, 13 insertions(+), 13 deletions(-)
