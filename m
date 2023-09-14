Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1F779FDCF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbjINIGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjINIGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:06:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23959B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694678766; x=1726214766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OUuVgpvyi+bl7hSgliB32R/X66hb3hOtqm5qW0bf4Lw=;
  b=KNUk4K1WRynCO+4wCzKgR7OwghgSRAN4rMhrOSJpKMPLr2TYS3U6PjMr
   ma0Je+Q2mkYIE/DLzTOBeoHaGyHJ/zoRmwIUwGiyqCplseSlUTigN3f0S
   0lWhzBdzFPkZJgL450LtaNW7IilXUZl++lPZCtdCXug2JGQRm2J3cCLoh
   2F6ywbYQpaK5Si0BhKbRI8i+lXDEX4YrGjXMxafOBYTRveKjgACbWdrdC
   +GTACRwWp5tlz7Ox37FVcplak902aA5X8zhJAW+hCN6pi2ed0ZtwcIROz
   Xr93+jJLi+mv8Nf4i5gmtnnBv75qM0N61dugotHVWMgv7ghDdJUJA6k4k
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="442917356"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="442917356"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 01:06:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="887691603"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="887691603"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 01:05:31 -0700
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] drm/xe/gsc: add HECI2 register offsets
Date:   Thu, 14 Sep 2023 11:01:35 +0300
Message-Id: <20230914080138.4178295-2-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914080138.4178295-1-alexander.usyskin@intel.com>
References: <20230914080138.4178295-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Lubart <vitaly.lubart@intel.com>

Add HECI2 register offsets for DG1 and DG2 to regs/xe_regs.h

Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/gpu/drm/xe/regs/xe_regs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/xe/regs/xe_regs.h b/drivers/gpu/drm/xe/regs/xe_regs.h
index 39d7b0740bf0..4cbc3062cb9a 100644
--- a/drivers/gpu/drm/xe/regs/xe_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_regs.h
@@ -33,6 +33,10 @@
 #define XEHPC_BCS6_RING_BASE			0x3ea000
 #define XEHPC_BCS7_RING_BASE			0x3ec000
 #define XEHPC_BCS8_RING_BASE			0x3ee000
+
+#define DG1_GSC_HECI2_BASE                      0x00259000
+#define DG2_GSC_HECI2_BASE                      0x00374000
+
 #define GSCCS_RING_BASE				0x11a000
 #define   GT_WAIT_SEMAPHORE_INTERRUPT		REG_BIT(11)
 #define   GT_CONTEXT_SWITCH_INTERRUPT		REG_BIT(8)
-- 
2.34.1

