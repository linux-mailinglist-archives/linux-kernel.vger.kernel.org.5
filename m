Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6F978E276
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344096AbjH3Wkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344042AbjH3Wk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:40:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC7AE42;
        Wed, 30 Aug 2023 15:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693435208; x=1724971208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GK/Q/uf/haO+6KNrJ6HUIfr5l3xBXK8Be8e4LfgWE10=;
  b=D8333CrQoeiNG/kKC0iuidkjVCh2y9qYaPO5BwLdo2VyapJBRpEjGFzc
   SrD1pHHct+QN2RKEZ7gkb6BpZgLF5weJIuAG3aLOrRAtmoZkqGIPTsVAN
   194dpMIfgh8CpO6V6R8OMzGu42RMpgMXD9TXNnsOqLxkjeKOfZpXljvyp
   aE7W3Bll5xdnGzlm6xabG8Kmb88xcCzRubRUgygFQpGqNRM9h9PnFLMQw
   hODjmZExliSxuqmCoBttcRVMr7rQIBoQu8z6lP7OIjVOuyGnP1uyBTUQI
   6sRSI/zrAhbIP5NI79MfZfxR7vP+PepFZORy98+Jby2OEDAAU8dLpeX8c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="374677353"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="374677353"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 15:39:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="774259658"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="774259658"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.97])
  by orsmga001.jf.intel.com with ESMTP; 30 Aug 2023 15:39:46 -0700
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        chrome-platform@lists.linux.dev
Cc:     andriy.shevchenko@linux.intel.com, bleung@chromium.org,
        Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v2 5/5] usb: typec: intel_pmc_mux: Configure Displayport Alternate mode 2.1
Date:   Wed, 30 Aug 2023 15:39:50 -0700
Message-Id: <20230830223950.1360865-6-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230830223950.1360865-1-utkarsh.h.patel@intel.com>
References: <20230830223950.1360865-1-utkarsh.h.patel@intel.com>
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

Mux agent driver can configure cable details such as cable type and
cable speed received as a part of displayport configuration to support
Displayport Alternate mode 2.1.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
---
Changes in v2:
- No change.

 drivers/usb/typec/mux/intel_pmc_mux.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 60ed1f809130..233958084b43 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -191,6 +191,12 @@ static int hsl_orientation(struct pmc_usb_port *port)
 	return port->orientation - 1;
 }
 
+static bool is_pmc_mux_tbt(struct acpi_device *adev)
+{
+	return acpi_dev_hid_uid_match(adev, "INTC1072", NULL) ||
+	       acpi_dev_hid_uid_match(adev, "INTC1079", NULL);
+}
+
 static int pmc_usb_send_command(struct intel_scu_ipc_dev *ipc, u8 *msg, u32 len)
 {
 	u8 response[4];
@@ -293,6 +299,24 @@ pmc_usb_mux_dp(struct pmc_usb_port *port, struct typec_mux_state *state)
 	req.mode_data |= (state->mode - TYPEC_STATE_MODAL) <<
 			 PMC_USB_ALTMODE_DP_MODE_SHIFT;
 
+	if (!is_pmc_mux_tbt(port->pmc->iom_adev)) {
+		u8 cable_speed = (data->conf & DP_CONF_SIGNALLING_MASK) >>
+				  DP_CONF_SIGNALLING_SHIFT;
+
+		u8 cable_type = (data->conf & DP_CONF_CABLE_TYPE_MASK) >>
+				 DP_CONF_CABLE_TYPE_SHIFT;
+
+		req.mode_data |= PMC_USB_ALTMODE_CABLE_SPD(cable_speed);
+
+		if (cable_type == DP_CONF_CABLE_TYPE_OPTICAL)
+			req.mode_data |= PMC_USB_ALTMODE_CABLE_TYPE;
+		else if (cable_type == DP_CONF_CABLE_TYPE_RE_TIMER)
+			req.mode_data |= PMC_USB_ALTMODE_ACTIVE_CABLE |
+					 PMC_USB_ALTMODE_RETIMER_CABLE;
+		else if (cable_type == DP_CONF_CABLE_TYPE_RE_DRIVER)
+			req.mode_data |= PMC_USB_ALTMODE_ACTIVE_CABLE;
+	}
+
 	ret = pmc_usb_command(port, (void *)&req, sizeof(req));
 	if (ret)
 		return ret;
-- 
2.25.1

