Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F09375AC01
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 12:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjGTKbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 06:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjGTKbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:31:40 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A9C1701;
        Thu, 20 Jul 2023 03:31:39 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 20CB12F5E;
        Thu, 20 Jul 2023 12:30:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689849042;
        bh=VvRAsOayGAFfVlRWY6mvSxhGtbu4PqRaUHHDSYQLW78=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=WjRX1Z6Gq3fbuR3hGGjZTrHyf++yYhoPnlYADQm5Swa67xruVukl1QoxeR9Y1kbfQ
         ilt731iTJOBJtVYmRjD5+WY96PRBUhHQiv5ic7g+DnPa93XeaZhLYpiOHGCr438T5F
         tRpUP9zdgz5NsLvoQJwZi8+RCSWSRgkeg8rqwSJI=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Thu, 20 Jul 2023 13:30:32 +0300
Subject: [PATCH v2 1/8] media: i2c: ds90ub960: Configure CSI-2 continuous
 clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-fpdlink-additions-v2-1-b91b1eca2ad3@ideasonboard.com>
References: <20230720-fpdlink-additions-v2-0-b91b1eca2ad3@ideasonboard.com>
In-Reply-To: <20230720-fpdlink-additions-v2-0-b91b1eca2ad3@ideasonboard.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Satish Nagireddy <satish.nagireddy@getcruise.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1537;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=VvRAsOayGAFfVlRWY6mvSxhGtbu4PqRaUHHDSYQLW78=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkuQ0EHUKJmhQkd21aXtcFt+ry9DJ3f/tcBaYhG
 P9RW2UCFsGJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZLkNBAAKCRD6PaqMvJYe
 9fVyD/9UmdT0BwBvEErjuszB92Cw0kEX7l60TrqwbVeyil4kJVOuz5lUUJYRfJvMTaYkXS+VzzS
 EBROVv72P0bHP6Ve9NOBdXHOh12m0mE0OIKxrFfuSOwEfAq5IYmVExM73WcXme2R+cZpP7hYoWF
 fR1JXnsUKzLx1zaGq1BBUvmCQm49V1T9YV/HTUwKKcbm0NiNOwGlRQKgU3MvjKrGIPjHK3FvgJF
 tdTyNFtu/padgoGqaNSlIbJzqMYvpDTxVxHpX2k6x67ydHB36RiFk47Xw97a6PpgTsIcwN6F2wL
 2o9CWQRpTiRDltAf2Cpfy2C7IOpI2+HKbnpobC6O37NL+Px4oQQs0oW5AU4hSjP2NbkvbSvXI34
 49/GcGekmr8PV930Eg40tbfgrX9qN0j1e3W+/OERIuuYpWwAchfzt45PgLKb84+xqTzkPbCUELZ
 bKKc+sy+jhWtrJVBaloplWLfyKXu8s5Cu3ZVZAWqkBSvL8ypP1vmWi+MRWFPPKFZ3x1EgfRszx/
 Rl0O4Dqdc7OnFfDhgazXJLy+4pWi6wxXz5cUT9SMQQB0nxoRZwoT70LScXf4zwzL12C9JudqEpl
 E1+/O81u8uWPsPZnA6LWUulHjbq156MmAV4uB3PWFPzrpxnD8L6I8UrHeYQ0RHavwpVWM6leZSW
 ymLoWMHFRNVbIHw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 'clock-noncontinuous' from DT to configure the
continuous/non-continuous clock setting for the TX ports.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/i2c/ds90ub960.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/i2c/ds90ub960.c b/drivers/media/i2c/ds90ub960.c
index b9a1ef63629b..a83091f47140 100644
--- a/drivers/media/i2c/ds90ub960.c
+++ b/drivers/media/i2c/ds90ub960.c
@@ -149,6 +149,7 @@
 
 #define UB960_TR_CSI_CTL			0x33
 #define UB960_TR_CSI_CTL_CSI_CAL_EN		BIT(6)
+#define UB960_TR_CSI_CTL_CSI_CONTS_CLOCK	BIT(1)
 #define UB960_TR_CSI_CTL_CSI_ENABLE		BIT(0)
 
 #define UB960_TR_CSI_CTL2			0x34
@@ -485,6 +486,7 @@ struct ub960_txport {
 	u8                      nport;	/* TX port number, and index in priv->txport[] */
 
 	u32 num_data_lanes;
+	bool non_continous_clk;
 };
 
 struct ub960_data {
@@ -1133,6 +1135,9 @@ static int ub960_parse_dt_txport(struct ub960_data *priv,
 		goto err_free_txport;
 	}
 
+	txport->non_continous_clk = vep.bus.mipi_csi2.flags &
+				    V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK;
+
 	txport->num_data_lanes = vep.bus.mipi_csi2.num_data_lanes;
 
 	if (vep.nr_of_link_frequencies != 1) {
@@ -1744,6 +1749,9 @@ static void ub960_init_tx_port(struct ub960_data *priv,
 
 	csi_ctl |= (4 - txport->num_data_lanes) << 4;
 
+	if (!txport->non_continous_clk)
+		csi_ctl |= UB960_TR_CSI_CTL_CSI_CONTS_CLOCK;
+
 	ub960_txport_write(priv, nport, UB960_TR_CSI_CTL, csi_ctl);
 }
 

-- 
2.34.1

