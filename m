Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9B87E9013
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 14:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjKLNYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 08:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjKLNX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 08:23:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771BD4680;
        Sun, 12 Nov 2023 05:23:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65642C433C7;
        Sun, 12 Nov 2023 13:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699795431;
        bh=r9vioJ01QA9BiHAwoQAdQxI7LgT23Kod7wINoZ1yZFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q4tNNCluMyWRAbG9R1KHOT3U/QAx+tYNfhVwtVzRFcrj98+XHUbLHR7WACMzYO4Uw
         IsYsQBhsR1njxF8YugYE7TsffrqcB5TBfyXnZTiOYUS1akHsnHttex2+W45kGTM2bg
         J/fyBNV5EltcVThLbNxT0VTp8MBwSIQddEifKiG+jIJ1FImkEZ2wB2p4K4KO0sSs+D
         kkvSmoFfHOt4Ky2CxUh1jSNIQMSyjz257euUNC6G+slbAxsvfDOE8u7CKORZoieTid
         phFDjBXWW1MKqLtZJ6GKbg4K6iDThU2Z6z6MLSn7XGQ43aKXwbIpJOPaizjiGctSaA
         m1Sn0Saebblug==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@kernel.org>,
        Sasha Levin <sashal@kernel.org>, jdelvare@suse.com,
        linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 2/7] i2c: i801: Add support for Intel Birch Stream SoC
Date:   Sun, 12 Nov 2023 08:23:34 -0500
Message-ID: <20231112132347.174334-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231112132347.174334-1-sashal@kernel.org>
References: <20231112132347.174334-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.11
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

[ Upstream commit 8c56f9ef25a33e51f09a448d25cf863b61c9658d ]

Add SMBus PCI ID on Intel Birch Stream SoC.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/i2c/busses/i2c-i801.rst | 1 +
 drivers/i2c/busses/Kconfig            | 1 +
 drivers/i2c/busses/i2c-i801.c         | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/Documentation/i2c/busses/i2c-i801.rst b/Documentation/i2c/busses/i2c-i801.rst
index e76e68ccf7182..10eced6c2e462 100644
--- a/Documentation/i2c/busses/i2c-i801.rst
+++ b/Documentation/i2c/busses/i2c-i801.rst
@@ -47,6 +47,7 @@ Supported adapters:
   * Intel Alder Lake (PCH)
   * Intel Raptor Lake (PCH)
   * Intel Meteor Lake (SOC and PCH)
+  * Intel Birch Stream (SOC)
 
    Datasheets: Publicly available at the Intel website
 
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 9cfe8fc509d7d..c91d4ea35c9b8 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -158,6 +158,7 @@ config I2C_I801
 	    Alder Lake (PCH)
 	    Raptor Lake (PCH)
 	    Meteor Lake (SOC and PCH)
+	    Birch Stream (SOC)
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i801.
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 2a3215ac01b3a..db4d73456f255 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -79,6 +79,7 @@
  * Meteor Lake-P (SOC)		0x7e22	32	hard	yes	yes	yes
  * Meteor Lake SoC-S (SOC)	0xae22	32	hard	yes	yes	yes
  * Meteor Lake PCH-S (PCH)	0x7f23	32	hard	yes	yes	yes
+ * Birch Stream (SOC)		0x5796	32	hard	yes	yes	yes
  *
  * Features supported by this driver:
  * Software PEC				no
@@ -231,6 +232,7 @@
 #define PCI_DEVICE_ID_INTEL_JASPER_LAKE_SMBUS		0x4da3
 #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_P_SMBUS		0x51a3
 #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_M_SMBUS		0x54a3
+#define PCI_DEVICE_ID_INTEL_BIRCH_STREAM_SMBUS		0x5796
 #define PCI_DEVICE_ID_INTEL_BROXTON_SMBUS		0x5ad4
 #define PCI_DEVICE_ID_INTEL_RAPTOR_LAKE_S_SMBUS		0x7a23
 #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_S_SMBUS		0x7aa3
@@ -1044,6 +1046,7 @@ static const struct pci_device_id i801_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, METEOR_LAKE_P_SMBUS,		FEATURES_ICH5 | FEATURE_TCO_CNL) },
 	{ PCI_DEVICE_DATA(INTEL, METEOR_LAKE_SOC_S_SMBUS,	FEATURES_ICH5 | FEATURE_TCO_CNL) },
 	{ PCI_DEVICE_DATA(INTEL, METEOR_LAKE_PCH_S_SMBUS,	FEATURES_ICH5 | FEATURE_TCO_CNL) },
+	{ PCI_DEVICE_DATA(INTEL, BIRCH_STREAM_SMBUS,		FEATURES_ICH5 | FEATURE_TCO_CNL) },
 	{ 0, }
 };
 
-- 
2.42.0

