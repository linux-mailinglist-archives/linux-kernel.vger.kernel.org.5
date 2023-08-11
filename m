Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDF27798E7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjHKUw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjHKUwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:52:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263792D61;
        Fri, 11 Aug 2023 13:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691787132; x=1723323132;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gqzKPjp7oNV/0cygdCDtirX1YU5VFmnyUOuRfsgdWck=;
  b=fHqhzk2sWWFDF+W/G7P51O2oEv7kwo0c2NAzniTQEjyiWK6hSDF/+53x
   aViVGkWkU5Zdb4Xu8DRLV3uyvcxRugnpDndnudeHl9/blQa9cUVbUtnhU
   sheZbzWuuNh8Js9DPUSgINRHraZAIIzf7qz0x0uoo+EgYMPJnTkLkekQq
   3ClrG62tQ3VONB2xMNhvOwrciOz2BoOXf2Yds7yFpL/SxwfucnE68GlQ0
   PmulcqphqDrHc1NlW4YYiMj7pzQfyim9rB+KcfmaqNsF9iO+Y6s4TY8rx
   4dQ4jachuf5UbnWCht2IHDo/QYoe1tTRONwjpj3MtZfPKWooX2rAmN/e6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="375473034"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="375473034"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 13:52:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="762322052"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="762322052"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.223])
  by orsmga008.jf.intel.com with ESMTP; 11 Aug 2023 13:52:11 -0700
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, andriy.shevchenko@linux.intel.com,
        pmalani@chromium.org, bleung@chromium.org,
        Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH 0/4]  Displayport Alternate Mode 2.1 Support
Date:   Fri, 11 Aug 2023 14:07:31 -0700
Message-Id: <20230811210735.159529-1-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enabels cable identification flow required for Displayport
Alternate Mode 2.1 support.

In this series [PATCH 3/4] uses cros_typec_get_cable_vdo API from,
https://patchwork.kernel.org/project/linux-usb/list/?series=766752

Utkarsh Patel (4):
  usb: typec: Add Displayport Alternate Mode 2.1 Support
  platform/chrome: cros_ec: Add Displayport Alternatemode 2.1 feature
    flag
  platform/chrome: cros_ec_typec: Add Displayport Alternatemode 2.1
    Support
  usb: typec: intel_pmc_mux: Configure Displayport Alternate mode 2.1

 drivers/platform/chrome/cros_ec_typec.c       | 30 +++++++++++++++++++
 drivers/platform/chrome/cros_ec_typec.h       |  1 +
 drivers/usb/typec/altmodes/displayport.c      |  5 +++-
 drivers/usb/typec/mux/intel_pmc_mux.c         | 24 +++++++++++++++
 drivers/usb/typec/ucsi/displayport.c          |  2 +-
 drivers/usb/typec/ucsi/ucsi_ccg.c             |  4 +--
 .../linux/platform_data/cros_ec_commands.h    |  5 ++++
 include/linux/usb/typec_dp.h                  | 28 ++++++++++++++---
 8 files changed, 91 insertions(+), 8 deletions(-)

-- 
2.25.1

