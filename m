Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EA478E269
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343931AbjH3WkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343910AbjH3WkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:40:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE09DC9;
        Wed, 30 Aug 2023 15:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693435186; x=1724971186;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ozlbKs9/8vuWngnkgsE28HofCYoMHPiBVL2sCuWw5e4=;
  b=hixB9r78uxPiCwQOykxcvCZVHU1L36SrK1VC6USyVfq4ZsyWpRnDTPoy
   IGOTaZQ6UX3rPcihUJXfwM6e2r+9px0cR7pdbxf5TXJHOgUs2p9JVuiTI
   5ZXS+H6DVADFlfp4d4DiYx4x7agHRrmFgw/u8zjVaSGlsoqim8RWz1eEn
   bAYkwBD177P1vmnrJW+8WjnqR/Z8+fZ+YM76MShjxKw5UdRgtpqmmABoF
   OJc2rtdg5DVJSvPAdDKbgc3Uh48wr3+/bGhV6wrmhq5gdYHxvPU/43ZrJ
   lr5GnU7sPfuIB8ua1SiZHaSNDvqkyGVQ+MTKOBQbIBGxCne4/4s4sWQD2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="374677336"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="374677336"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 15:39:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="774259643"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="774259643"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.97])
  by orsmga001.jf.intel.com with ESMTP; 30 Aug 2023 15:39:46 -0700
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        chrome-platform@lists.linux.dev
Cc:     andriy.shevchenko@linux.intel.com, bleung@chromium.org,
        Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v2 0/5] Displayport Alternate Mode 2.1 Support
Date:   Wed, 30 Aug 2023 15:39:45 -0700
Message-Id: <20230830223950.1360865-1-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enabels cable identification flow required for Displayport
Alternate Mode 2.1 support.

Please add this series to usb-next. 

Changes in v2:
- Added two new patches [PATCH 2/5] and [PATCH 3/5] in to this series.
- Removed [PATCH 2/4]  platform/chrome: cros_ec: Add Displayport
  Alternatemode 2.1 feature flag
- In [PATCH 4/5] Removed feature flag and separate function for DP2.1.
- In [PATCH 4/5] used cable vdos instead of host commands to get cable
  details.

Utkarsh Patel (5):
  usb: typec: Add Displayport Alternate Mode 2.1 Support
  usb: typec: Add Active or Passive cable defination to cable discover
    mode VDO
  usb: pd: Add helper macro to get Type C cable speed
  platform/chrome: cros_ec_typec: Add Displayport Alternatemode 2.1
    Support
  usb: typec: intel_pmc_mux: Configure Displayport Alternate mode 2.1

 drivers/platform/chrome/cros_ec_typec.c  | 31 ++++++++++++++++++++++++
 drivers/usb/typec/altmodes/displayport.c |  5 +++-
 drivers/usb/typec/mux/intel_pmc_mux.c    | 24 ++++++++++++++++++
 drivers/usb/typec/ucsi/displayport.c     |  2 +-
 drivers/usb/typec/ucsi/ucsi_ccg.c        |  4 +--
 include/linux/usb/pd_vdo.h               |  1 +
 include/linux/usb/typec_dp.h             | 28 ++++++++++++++++++---
 include/linux/usb/typec_tbt.h            |  1 +
 8 files changed, 88 insertions(+), 8 deletions(-)

-- 
2.25.1

