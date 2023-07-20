Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DE775AC0E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 12:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjGTKcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 06:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjGTKb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:31:56 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7331726;
        Thu, 20 Jul 2023 03:31:49 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 530693809;
        Thu, 20 Jul 2023 12:30:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689849049;
        bh=BnpBVZYY+/GA3ZmNzw9v9ygUo60Pbgode19CRNRPRs0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ti9StKN/4g2CywLOTcOwwZvLuq5X93caF52kjjVcu9f0wTJ3NUHaKSB4/mjUNT4oc
         mimXgvQJbbJuSjKdo9DzgKKiw6R4GCpPvEpq3TikPJbWNv8NPsldFZT1ahBlKAnRZC
         i7aq46ob6LjgGLMszVxoIv/fKyajHJ3ahP/s2+7U=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Thu, 20 Jul 2023 13:30:39 +0300
Subject: [PATCH v2 8/8] media: i2c: ds90ub960: Rename
 RXPORT_MODE_CSI2_ASYNC to RXPORT_MODE_CSI2_NONSYNC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-fpdlink-additions-v2-8-b91b1eca2ad3@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3438;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=BnpBVZYY+/GA3ZmNzw9v9ygUo60Pbgode19CRNRPRs0=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkuQ0HPIOE/bsugJhJge9C5M30jkHGJVYVewFg6
 LClJf5MKiSJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZLkNBwAKCRD6PaqMvJYe
 9XjWD/9Jlpj1Kf468RDQ4MDKE+dX5gJTkcj384jqFJlPxnjlyX2et0g+PHE3NjKG7/HIBk0i5JP
 N0+ndA0hX7SDjyKsCmVtqNFN4mILbXN75QLxWwSiGd1O7ITtNN0E/sbkSGUXe6a5rjtZGdSGB0o
 fJDI57eU4tTaiIWbgscEUd8YUA4p+hzPo5FLye8Qd3aDJyR3WGIzKwWaqhfeMsopV3aXKvuZLMR
 DZyy4IH50xGTrxrHDl4vGfYaWEABhbm8VS5rQotXoHhvWkD3xHui1l0nYWu4XvAP+mDGwXIxzyo
 eDd5vgX+bue9GVrozgMMFMvo4tAyiCPG5w7Y837qjImE50IN7XhHQIW5N30pTK4sT6rYS+CHzxx
 3i7hvt5Y+dg8qVzqjGPROjsqNskC6ndLWhzxoIquUCMRvXmmDSc6sygviUlKWtywEbNvidPXr8U
 6kKN5cHorkI9x21kAA8VVRXf3SVyO2TMNTBglXq11H4Y8BdBe27mSWfZCXL08gcLOvPe5Ku/am+
 LnYga/IeDPQiXstGTeovpdMmHvrZkWnRxSTML0NUdLvRzUNfb3lID1OQGxFd0kIOzE2s7Hs+f0h
 DSHZW/DTwep6quF1r7jj98u0q8dq8fN3eMjvb26xaSEvbbxGU3u3LlKJAlzE326CkasdULWSGHH
 oiDrsBBVX19Ww1w==
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

FPD-Link has an operating mode that used to be called "asynchronous" in
the hardware documentation, but that has been changed to non-synchronous
already quite a while back. The ub960 driver still had one instance of
the old naming, so let's rename it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/i2c/ds90ub960.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/media/i2c/ds90ub960.c b/drivers/media/i2c/ds90ub960.c
index ea819fb6e99b..2ed4d4763a02 100644
--- a/drivers/media/i2c/ds90ub960.c
+++ b/drivers/media/i2c/ds90ub960.c
@@ -415,8 +415,8 @@ enum ub960_rxport_mode {
 	RXPORT_MODE_RAW12_HF = 1,
 	RXPORT_MODE_RAW12_LF = 2,
 	RXPORT_MODE_CSI2_SYNC = 3,
-	RXPORT_MODE_CSI2_ASYNC = 4,
-	RXPORT_MODE_LAST = RXPORT_MODE_CSI2_ASYNC,
+	RXPORT_MODE_CSI2_NONSYNC = 4,
+	RXPORT_MODE_LAST = RXPORT_MODE_CSI2_NONSYNC,
 };
 
 enum ub960_rxport_cdr {
@@ -1609,7 +1609,7 @@ static unsigned long ub960_calc_bc_clk_rate_ub960(struct ub960_data *priv,
 		div = 1;
 		break;
 
-	case RXPORT_MODE_CSI2_ASYNC:
+	case RXPORT_MODE_CSI2_NONSYNC:
 		mult = 2;
 		div = 5;
 		break;
@@ -1633,7 +1633,7 @@ static unsigned long ub960_calc_bc_clk_rate_ub9702(struct ub960_data *priv,
 	case RXPORT_MODE_CSI2_SYNC:
 		return 47187500;
 
-	case RXPORT_MODE_CSI2_ASYNC:
+	case RXPORT_MODE_CSI2_NONSYNC:
 		return 9437500;
 
 	default:
@@ -1840,7 +1840,7 @@ static void ub960_init_rx_port_ub960(struct ub960_data *priv,
 		bc_freq_val = 0;
 		break;
 
-	case RXPORT_MODE_CSI2_ASYNC:
+	case RXPORT_MODE_CSI2_NONSYNC:
 		bc_freq_val = 2;
 		break;
 
@@ -1878,7 +1878,7 @@ static void ub960_init_rx_port_ub960(struct ub960_data *priv,
 		return;
 
 	case RXPORT_MODE_CSI2_SYNC:
-	case RXPORT_MODE_CSI2_ASYNC:
+	case RXPORT_MODE_CSI2_NONSYNC:
 		/* CSI-2 Mode (DS90UB953-Q1 compatible) */
 		ub960_rxport_update_bits(priv, nport, UB960_RR_PORT_CONFIG, 0x3,
 					 0x0);
@@ -1938,7 +1938,7 @@ static void ub960_init_rx_port_ub9702_fpd3(struct ub960_data *priv,
 		fpd_func_mode = 2;
 		break;
 
-	case RXPORT_MODE_CSI2_ASYNC:
+	case RXPORT_MODE_CSI2_NONSYNC:
 		bc_freq_val = 2;
 		fpd_func_mode = 2;
 		break;
@@ -2032,7 +2032,7 @@ static void ub960_init_rx_port_ub9702_fpd4(struct ub960_data *priv,
 		bc_freq_val = 6;
 		break;
 
-	case RXPORT_MODE_CSI2_ASYNC:
+	case RXPORT_MODE_CSI2_NONSYNC:
 		bc_freq_val = 2;
 		break;
 
@@ -2098,7 +2098,7 @@ static void ub960_init_rx_port_ub9702(struct ub960_data *priv,
 		return;
 
 	case RXPORT_MODE_CSI2_SYNC:
-	case RXPORT_MODE_CSI2_ASYNC:
+	case RXPORT_MODE_CSI2_NONSYNC:
 
 		break;
 	}
@@ -2444,7 +2444,7 @@ static int ub960_configure_ports_for_streaming(struct ub960_data *priv,
 
 		/* For the rest, we are only interested in parallel busses */
 		if (rxport->rx_mode == RXPORT_MODE_CSI2_SYNC ||
-		    rxport->rx_mode == RXPORT_MODE_CSI2_ASYNC)
+		    rxport->rx_mode == RXPORT_MODE_CSI2_NONSYNC)
 			continue;
 
 		if (rx_data[nport].num_streams > 2)
@@ -2508,7 +2508,7 @@ static int ub960_configure_ports_for_streaming(struct ub960_data *priv,
 			break;
 
 		case RXPORT_MODE_CSI2_SYNC:
-		case RXPORT_MODE_CSI2_ASYNC:
+		case RXPORT_MODE_CSI2_NONSYNC:
 			if (!priv->hw_data->is_ub9702) {
 				/* Map all VCs from this port to the same VC */
 				ub960_rxport_write(priv, nport, UB960_RR_CSI_VC_MAP,

-- 
2.34.1

