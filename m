Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929877C4C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345428AbjJKHn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345207AbjJKHnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:43:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628ED98
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697010198; x=1728546198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E9vyqZZRO4KCr59vRQPP+qM4Gc9TK0+9Rd+hqA/TTCs=;
  b=aSfA9+8yu+ZFiTvLwYqO+ZPggdpfG5+2bXpMod1+yVqXnu3NDSVI16wW
   JUw1zdRceKaN9QEi0Or9a9LYK7Zv0YdAOYraTxQNcE5IydXfnBmD4wMfa
   iNyoX2sHPZ329UWUo6LbS5mFReSe4fRMXLUOpEWciLayckJ/vIxA299cn
   dRIw+DVD6DT2QY5JfptS76C3SFpVVRhdYAPfajio5IZGKG8QVrYsUa0yY
   JGI2KVH+aspqQXWRXPIToiy5qwQe7ybpeGN+DWuKyoUZpFtSOfv3OC6cP
   74YXFtRK199hOaG95E4HI1USEBIr2bDaSTDVVGdeR3oP7vYToHtZn3Vh4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="363960756"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="363960756"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 00:43:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="703627099"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="703627099"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 00:43:16 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 2/3] mei: docs: add missing entries to kdoc in struct mei_cfg_idx
Date:   Wed, 11 Oct 2023 10:43:00 +0300
Message-ID: <20231011074301.223879-3-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011074301.223879-1-tomas.winkler@intel.com>
References: <20231011074301.223879-1-tomas.winkler@intel.com>
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

Document all entries in struct mei_cfg_idx.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw-me.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/mei/hw-me.h b/drivers/misc/mei/hw-me.h
index 95cf830b7c7b63e1cf555048..204b92af6c4785beb23f0212 100644
--- a/drivers/misc/mei/hw-me.h
+++ b/drivers/misc/mei/hw-me.h
@@ -102,10 +102,14 @@ static inline bool mei_me_hw_use_polling(const struct mei_me_hw *hw)
  * @MEI_ME_PCH12_SPS_CFG:  Platform Controller Hub Gen12 5.0 and newer
  *                         servers platforms with quirk for
  *                         SPS firmware exclusion.
+ * @MEI_ME_PCH12_SPS_ITOUCH_CFG: Platform Controller Hub Gen12
+ *                         client platforms (iTouch)
  * @MEI_ME_PCH15_CFG:      Platform Controller Hub Gen15 and newer
  * @MEI_ME_PCH15_SPS_CFG:  Platform Controller Hub Gen15 and newer
  *                         servers platforms with quirk for
  *                         SPS firmware exclusion.
+ * @MEI_ME_GSC_CFG:        Graphics System Controller
+ * @MEI_ME_GSCFI_CFG:      Graphics System Controller Firmware Interface
  * @MEI_ME_NUM_CFG:        Upper Sentinel.
  */
 enum mei_cfg_idx {
-- 
2.41.0

