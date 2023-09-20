Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE427A7093
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 04:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjITCde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 22:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjITCdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 22:33:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BBBCE;
        Tue, 19 Sep 2023 19:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695177197; x=1726713197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dFOE4HirFKRZgsK0uCPrJhP57Aa31MNoDRzWf7ltFDM=;
  b=EIolThKmoZVRYGF9PaaPtLdxcwA4A30XQyF3LFtv/Hn+gS48jaRb7r1x
   P54awHFfiA0y3wZKNgA1ltFxeJu0t7fbLpDg/usf/4Rb7DCFIB/6QqR0P
   gHKhsnMu2Jqj60FJDA5n7f4+n7v9UIg9xCU2bxLqHH8HdpYSqAi0XUI18
   /CNFCB7FH+9E57kVvbLrv22iR9nlRZrHn5+VHRofltN8lgEysQP9cC0Bt
   lY6fRI7jgeKUB5Dk+GU0UAQoRRAh0UmzMGHT05sMlA153AzM5sSetpmfy
   MnCy6W8RW2jJ6N70Uouk8NBHX05v9gz1qBV1Wwp5lpONMruNXC++34VRk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="466422454"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="466422454"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 19:33:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="816690732"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="816690732"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.215])
  by fmsmga004.fm.intel.com with ESMTP; 19 Sep 2023 19:33:14 -0700
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        chrome-platform@lists.linux.dev, andriy.shevchenko@linux.intel.com,
        bleung@chromium.org, Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v4 5/5] usb: typec: intel_pmc_mux: Configure Displayport Alternate mode 2.1
Date:   Tue, 19 Sep 2023 19:32:43 -0700
Message-Id: <20230920023243.2494410-6-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230920023243.2494410-1-utkarsh.h.patel@intel.com>
References: <20230920023243.2494410-1-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v4:
- No change.

Changes in v3:
- No change.

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

