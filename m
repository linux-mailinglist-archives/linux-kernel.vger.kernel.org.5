Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86777809F3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359049AbjHRKYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359005AbjHRKYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:24:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E07A2D65;
        Fri, 18 Aug 2023 03:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692354273; x=1723890273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lQNq0fSdnAUapEIKjaOl0KAeJ1J5RobTmYHnG//ZAd8=;
  b=NSvaNWC8FwdPi2WA4hYsRq8IDL/RE6BvNNzMvQuRMMC05sklkprunslh
   fNHW7yz25QM9VqI8azXJoVdUcACKS17txQ+i0t4YcVg/MPJdkffXVEw24
   yn/hTd1UoLmPiLeWAo8x4JmTUicuFx2Gas48YAnUuhaFf40/CGi/5fJaX
   2szoNugz3OKcZDtNPbvDVRrRzyzjAtMO1UYUhiy50WWiXQk0kQBzHg59D
   4mI9TokCsc+Lla5+YpBv6EfhwjhX2UYhcATMcmaPdDJ2GoFRUeOqX3rsd
   ibTgcGhMeKQUDfFsj3ga648JUfI+N7YXoHgtQVtljX2E1B0xoZYcSxVez
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="376829246"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="376829246"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 03:24:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="878636045"
Received: from r007s007_zp31l10c01.deacluster.intel.com (HELO fedora.deacluster.intel.com) ([10.219.171.169])
  by fmsmga001.fm.intel.com with ESMTP; 18 Aug 2023 03:24:35 -0700
From:   Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
To:     herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        andriy.shevchenko@intel.com, alx@kernel.org,
        Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 1/2] crypto: qat - refactor included headers
Date:   Fri, 18 Aug 2023 12:23:08 +0200
Message-ID: <20230818102322.142582-2-lucas.segarra.fernandez@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818102322.142582-1-lucas.segarra.fernandez@intel.com>
References: <20230818102322.142582-1-lucas.segarra.fernandez@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include missing headers for GENMASK(), kstrtobool and types.

Add forward declaration for struct adf_accel_dev. Remove unneeded
include.

This change doesn't introduce any function change.

Signed-off-by: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/crypto/intel/qat/qat_common/adf_gen4_pm.c | 3 +++
 drivers/crypto/intel/qat/qat_common/adf_gen4_pm.h | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_pm.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_pm.c
index 34c6cd8e27c0..3bde8759c2a2 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_pm.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_pm.c
@@ -2,6 +2,9 @@
 /* Copyright(c) 2022 Intel Corporation */
 #include <linux/bitfield.h>
 #include <linux/iopoll.h>
+#include <linux/kstrtox.h>
+#include <linux/types.h>
+
 #include "adf_accel_devices.h"
 #include "adf_common_drv.h"
 #include "adf_gen4_pm.h"
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_pm.h b/drivers/crypto/intel/qat/qat_common/adf_gen4_pm.h
index c2768762cca3..39d37b352b45 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_pm.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_pm.h
@@ -3,7 +3,9 @@
 #ifndef ADF_GEN4_PM_H
 #define ADF_GEN4_PM_H
 
-#include "adf_accel_devices.h"
+#include <linux/bits.h>
+
+struct adf_accel_dev;
 
 /* Power management registers */
 #define ADF_GEN4_PM_HOST_MSG (0x50A01C)
-- 
2.41.0

