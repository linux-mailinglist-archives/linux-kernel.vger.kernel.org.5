Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E927993D5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345712AbjIIAiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241829AbjIIAhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:37:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3AA2109;
        Fri,  8 Sep 2023 17:37:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4755C433BD;
        Sat,  9 Sep 2023 00:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219789;
        bh=cB0itskmytt+dGfeUP5WecthNkn3rtVLvAwzO09arYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YyjhJIcFVtuHX6EUhA4O3sVLNirTJnz1zUl3pMsWZ6XmObDP6tqLCVS0YCBJF2Dx2
         0hpqfwgss7oTp/IBzWxN1N2q8vbrZ/YTMM/KLp7lgMG7D8vnnhr9UFuo1S1/Yef+8E
         I1bHJdDHiGbiBylmzjJGBEeql2AoWwuPbGoa1BZDJhwLaUouJlpzIjfoq2Zuyw2too
         yhoqFwFtYwQCTuTMfc9Y+22UCDwTyQlZJucCuMBbDvbkef+nO3PbuaUc+RWgGFg+tf
         h1X2ObOnydJvaXqemWOLBY1IzXRHcwykkQDoYghOMFI2qK9A91MToJkK+G9A/vGE+X
         3BQK26oUrmFiw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Madhu M <madhu.m@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 13/28] usb: typec: intel_pmc_mux: Add new ACPI ID for Lunar Lake IOM device
Date:   Fri,  8 Sep 2023 20:35:47 -0400
Message-Id: <20230909003604.3579407-13-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909003604.3579407-1-sashal@kernel.org>
References: <20230909003604.3579407-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhu M <madhu.m@intel.com>

[ Upstream commit e032368e8cb15ab1f11b92f078caa9bae995b8fe ]

Intel Lunar Lake IOM has a different IOM port status offset and size
than Intel MTL.

Intel Lunar Lake is the first platform to extend IOM port status
from 32bit to 64bit by adding DDI port number into IOM port status.

Added IOM_PORT_STATUS_REGS macro for using platform specific IOM port
status offset and size.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Madhu M <madhu.m@intel.com>
Link: https://lore.kernel.org/r/20230704080509.14251-1-madhu.m@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/mux/intel_pmc_mux.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 5e8edf3881c0d..61a88f68b458c 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -117,6 +117,16 @@ enum {
 	  IOM_PORT_STATUS_DHPD_HPD_STATUS_SHIFT) &			\
 	 IOM_PORT_STATUS_DHPD_HPD_STATUS_ASSERT)
 
+/* IOM port status register */
+#define IOM_PORT_STATUS_REGS(_offset_, _size_)	((_offset_) | (_size_))
+#define IOM_PORT_STATUS_REGS_SZ_MASK		BIT(0)
+#define IOM_PORT_STATUS_REGS_SZ_4		0
+#define IOM_PORT_STATUS_REGS_SZ_8		1
+#define IOM_PORT_STATUS_REGS_OFFSET(_d_)				\
+	((_d_) & ~IOM_PORT_STATUS_REGS_SZ_MASK)
+#define IOM_PORT_STATUS_REGS_SIZE(_d_)					\
+	(4 << ((_d_) & IOM_PORT_STATUS_REGS_SZ_MASK))
+
 struct pmc_usb;
 
 struct pmc_usb_port {
@@ -145,6 +155,7 @@ struct pmc_usb {
 	struct acpi_device *iom_adev;
 	void __iomem *iom_base;
 	u32 iom_port_status_offset;
+	u8 iom_port_status_size;
 
 	struct dentry *dentry;
 };
@@ -160,7 +171,7 @@ static void update_port_status(struct pmc_usb_port *port)
 
 	port->iom_status = readl(port->pmc->iom_base +
 				 port->pmc->iom_port_status_offset +
-				 port_num * sizeof(u32));
+				 port_num * port->pmc->iom_port_status_size);
 }
 
 static int sbu_orientation(struct pmc_usb_port *port)
@@ -589,13 +600,16 @@ static int pmc_usb_register_port(struct pmc_usb *pmc, int index,
 /* IOM ACPI IDs and IOM_PORT_STATUS_OFFSET */
 static const struct acpi_device_id iom_acpi_ids[] = {
 	/* TigerLake */
-	{ "INTC1072", 0x560, },
+	{ "INTC1072", IOM_PORT_STATUS_REGS(0x560, IOM_PORT_STATUS_REGS_SZ_4) },
 
 	/* AlderLake */
-	{ "INTC1079", 0x160, },
+	{ "INTC1079", IOM_PORT_STATUS_REGS(0x160, IOM_PORT_STATUS_REGS_SZ_4) },
 
 	/* Meteor Lake */
-	{ "INTC107A", 0x160, },
+	{ "INTC107A", IOM_PORT_STATUS_REGS(0x160, IOM_PORT_STATUS_REGS_SZ_4) },
+
+	/* Lunar Lake */
+	{ "INTC10EA", IOM_PORT_STATUS_REGS(0x150, IOM_PORT_STATUS_REGS_SZ_8) },
 	{}
 };
 
@@ -615,7 +629,8 @@ static int pmc_usb_probe_iom(struct pmc_usb *pmc)
 	if (!adev)
 		return -ENODEV;
 
-	pmc->iom_port_status_offset = (u32)dev_id->driver_data;
+	pmc->iom_port_status_offset = IOM_PORT_STATUS_REGS_OFFSET(dev_id->driver_data);
+	pmc->iom_port_status_size = IOM_PORT_STATUS_REGS_SIZE(dev_id->driver_data);
 
 	INIT_LIST_HEAD(&resource_list);
 	ret = acpi_dev_get_memory_resources(adev, &resource_list);
-- 
2.40.1

