Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309DD7F6EE2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345231AbjKXItQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjKXIsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:48:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DE7172D;
        Fri, 24 Nov 2023 00:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700815732; x=1732351732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3vtdvE3QnntLHyxMXQ0tiVPrz7diOVGb+IPBdmkCkGQ=;
  b=hg+mOEjYHdXM+rYuniWLvybL+Zpa2socPyGdw8LjUdKAuyyjkhWTTjyZ
   /Z7vz10i/npzDmbVR9jBHMUteOamARr7CEnOo56o+jgJS5Wybjm+CIjr4
   fcm9eLoi8aVZUB6oap+n13Uon+ZVFfDblZp6a/adxvY212B6z4UVJmvqx
   nAcAr0I9F2tL67g0ABgdhmBFRR8kDnGduy2AEWkRbJKMIv1+sTBSMSJxU
   8GaxrwB0+PIhZqMRy2siIF3KOodBviJPBFrGqqpQOvBYg22yDjQbBgx57
   Oosozw8jzV3O1We2xySsZq92p2yy7dQ+qXzG0FCwpRFtatOrtGcTFggbU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="456728959"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="456728959"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 00:48:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="760900546"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="760900546"
Received: from mvlasov-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.220.89])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 00:48:48 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "John W. Linville" <linville@tuxdriver.com>,
        Kalle Valo <kvalo@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 09/10] wifi: rtlwifi: Remove unused PCI related defines and struct
Date:   Fri, 24 Nov 2023 10:47:24 +0200
Message-Id: <20231124084725.12738-10-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231124084725.12738-1-ilpo.jarvinen@linux.intel.com>
References: <20231124084725.12738-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rtlwifi driver comes with a number of PCI related defines that are
unused and many would be provided by PCI core anyway if they'd be
needed again.

Similarly, the struct rtl_pci_capabilities_header is unused and no
driver should come up their own way to access PCI Capabilities anyway.

Remove the unused/duplicated PCI related defines and struct.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/net/wireless/realtek/rtlwifi/pci.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.h b/drivers/net/wireless/realtek/rtlwifi/pci.h
index d6307197dfea..8bb35506ab1e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.h
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.h
@@ -44,18 +44,6 @@
 #define ATI_DEVICE_ID				0x7914
 #define AMD_VENDOR_ID				0x1022
 
-#define PCI_MAX_BRIDGE_NUMBER			255
-#define PCI_MAX_DEVICES				32
-#define PCI_MAX_FUNCTION			8
-
-#define PCI_CONF_ADDRESS	0x0CF8	/*PCI Configuration Space Address */
-#define PCI_CONF_DATA		0x0CFC	/*PCI Configuration Space Data */
-
-#define PCI_CLASS_BRIDGE_DEV		0x06
-#define PCI_SUBCLASS_BR_PCI_TO_PCI	0x04
-#define PCI_CAPABILITY_ID_PCI_EXPRESS	0x10
-#define PCI_CAP_ID_EXP			0x10
-
 #define U1DONTCARE			0xFF
 #define U2DONTCARE			0xFFFF
 #define U4DONTCARE			0xFFFFFFFF
@@ -113,11 +101,6 @@ enum pci_bridge_vendor {
 	PCI_BRIDGE_VENDOR_MAX,
 };
 
-struct rtl_pci_capabilities_header {
-	u8 capability_id;
-	u8 next;
-};
-
 /* In new TRX flow, Buffer_desc is new concept
  * But TX wifi info == TX descriptor in old flow
  * RX wifi info == RX descriptor in old flow
-- 
2.30.2

