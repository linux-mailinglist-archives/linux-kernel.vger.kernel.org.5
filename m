Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C92810B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 08:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjLMHSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 02:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbjLMHLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 02:11:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D193DAC;
        Tue, 12 Dec 2023 23:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702451481; x=1733987481;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cF3pfJnlA+5G4OWOtCtXAGT41ADIKzwDy0yN6nIsYG8=;
  b=isnW75bAuOFVs2/vQ0KSrNN29mQy1QGOenE1HgUu5bduxRZ3z9gE7mgE
   azKZoD2LXu/HCpF5vk1+W7ZmsOHLKJQRGmjzysM+TEl62Vk8xH3PJAywY
   lZ0u/YUVfuL92wCsPnK+FscWl6lye2R156Yo+bU59Dz0BPig79YUhAU3D
   3br7q2MXNzWykNs6BRQDX7qIe7mNzxoxAqrm4FgV9mz3TZ9xW/yHByvQk
   x4kjfhOVdkPWnvrnutpCGougjH+o3YHQT6HT+jYliI5rfRwiIkVQypddQ
   xKYXIdkbFvJQSBjVi0lRYkLZKpWqLnm8xrqcl/9N/evNAhmsiZiWDJ44d
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="481126085"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="481126085"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 23:11:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="767109178"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="767109178"
Received: from pglc00021.png.intel.com ([10.221.207.41])
  by orsmga007.jf.intel.com with ESMTP; 12 Dec 2023 23:11:18 -0800
From:   <deepakx.nagaraju@intel.com>
To:     joyce.ooi@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, Nagaraju DeepakX <deepakx.nagaraju@intel.com>
Subject: [PATCH 0/5] Rename functions and their prototypes and move to common files.
Date:   Wed, 13 Dec 2023 15:11:07 +0800
Message-Id: <20231213071112.18242-1-deepakx.nagaraju@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nagaraju DeepakX <deepakx.nagaraju@intel.com>

Hi,
Moving the standard DMA interface for SGDMA and MSGDMA and renaming from
tse_private to dma_private. Moving read-write function prototypes from
altera_tse.h to altera_utils.h. Commonize DMA for upcoming altera Drivers.

Patch1: Removing unneeded assignments.
Patch2: Fixing indentation warnings.
Patch3: Moving read write Function prototypes.
Patch4: Sorting headers in alphabetical order.
Patch5: Renaming function prototypes.

Nagaraju DeepakX (5):
  net: ethernet: altera: remove unneeded assignments
  net: ethernet: altera: fix indentation warnings
  net: ethernet: altera: move read write functions
  net: ethernet: altera: sorting headers in alphabetical order
  net: ethernet: altera: rename functions and their prototypes

 drivers/net/ethernet/altera/Makefile          |   5 +-
 drivers/net/ethernet/altera/altera_eth_dma.c  |  58 ++++
 drivers/net/ethernet/altera/altera_eth_dma.h  | 121 +++++++++
 drivers/net/ethernet/altera/altera_msgdma.c   |  38 +--
 drivers/net/ethernet/altera/altera_msgdma.h   |  28 +-
 drivers/net/ethernet/altera/altera_sgdma.c    | 138 +++++-----
 drivers/net/ethernet/altera/altera_sgdma.h    |  30 +--
 drivers/net/ethernet/altera/altera_tse.h      |  71 +----
 .../net/ethernet/altera/altera_tse_ethtool.c  |   2 +
 drivers/net/ethernet/altera/altera_tse_main.c | 251 +++++++-----------
 drivers/net/ethernet/altera/altera_utils.c    |   1 +
 drivers/net/ethernet/altera/altera_utils.h    |  43 +++
 12 files changed, 447 insertions(+), 339 deletions(-)
 create mode 100644 drivers/net/ethernet/altera/altera_eth_dma.c
 create mode 100644 drivers/net/ethernet/altera/altera_eth_dma.h

--
2.26.2

