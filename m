Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976017F6EE4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjKXIt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbjKXIsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:48:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DDC10F3;
        Fri, 24 Nov 2023 00:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700815740; x=1732351740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=szHP/bH/uBQ0qXbVg2RukeAFWzc2VqyRXvm/T4TFP44=;
  b=JCF+NMRhrfVTPJ0Eguibm+Fs1pFtxPEKnTminF76/6FdNYihqhz6/isF
   pbuYmAWFHiRRqrBTJGVXAaI42nut53AyHKz7B3w5zuHLu+eENjHgDzpSq
   SL6GykA3bz8bPdx4CitDjwqqbhH2iPvynrBjaqbLmvAvkpyNKOG8eIsUs
   17Mf42mtq8XwlkJrS3yWSRfrysMXGQqztGGVckgeRxnlTHjYxwdPGlji3
   OhOIsiFfbFm8W5r8n99EKStCHFOtrr2bm4pfZzuSMJv+eiNnkc1kNm5QL
   dcDbU3JscTl/m2nFPvVrF0USOfBxzc4jKgtGbcGDJxWReU5AnLQdQmQNv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="382791767"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="382791767"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 00:48:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="838026227"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="838026227"
Received: from mvlasov-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.220.89])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 00:48:56 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "John W. Linville" <linville@tuxdriver.com>,
        Kalle Valo <kvalo@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 10/10] wifi: rtlwifi: Remove bridge vendor/device ids
Date:   Fri, 24 Nov 2023 10:47:25 +0200
Message-Id: <20231124084725.12738-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231124084725.12738-1-ilpo.jarvinen@linux.intel.com>
References: <20231124084725.12738-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither vendorid nor deviceid in the struct mp_adapter is used so
remove them.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 1 -
 drivers/net/wireless/realtek/rtlwifi/pci.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index a29d7df6fff5..aa00ee971bc3 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -1969,7 +1969,6 @@ static bool _rtl_pci_find_adapter(struct pci_dev *pdev,
 	 */
 	if (bridge_pdev) {
 		/*find bridge info if available */
-		pcipriv->ndis_adapter.pcibridge_vendorid = bridge_pdev->vendor;
 		for (tmp = 0; tmp < PCI_BRIDGE_VENDOR_MAX; tmp++) {
 			if (bridge_pdev->vendor == pcibridge_vendors[tmp]) {
 				pcipriv->ndis_adapter.pcibridge_vendor = tmp;
diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.h b/drivers/net/wireless/realtek/rtlwifi/pci.h
index 8bb35506ab1e..616e5ba30d74 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.h
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.h
@@ -216,8 +216,6 @@ struct mp_adapter {
 	u8 pcibridge_funcnum;
 
 	u8 pcibridge_vendor;
-	u16 pcibridge_vendorid;
-	u16 pcibridge_deviceid;
 
 	bool amd_l1_patch;
 };
-- 
2.30.2

