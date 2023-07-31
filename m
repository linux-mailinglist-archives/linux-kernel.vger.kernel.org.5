Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131D5769789
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbjGaN0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjGaNZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:25:45 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69981986;
        Mon, 31 Jul 2023 06:25:39 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BB7A71B59;
        Mon, 31 Jul 2023 15:24:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690809869;
        bh=3+DFmCI8pb7ymXT5ii0dJSIen8bU6FQj2ceug6/EKEE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=IOHjXx6FaXAt7Uu6vbTeGGehhHkcZ9FNUTfZnQBtZKHdSWMbbcybyw9xFJS1OGwKz
         tS6hsBBEwMLEO7u9Xrt67Sh1StKlkwZ/Q48RL44Xl8h5G9JtysPp0ea2diX9YGceO0
         vY90o1EEAFE5Z/E1sdb3JYqXXtblvs+UT00Exn2s=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Mon, 31 Jul 2023 16:24:43 +0300
Subject: [PATCH v3 9/9] media: i2c: ds90ub960: Rename
 RXPORT_MODE_CSI2_ASYNC to RXPORT_MODE_CSI2_NONSYNC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-fpdlink-additions-v3-9-8acfc49c215a@ideasonboard.com>
References: <20230731-fpdlink-additions-v3-0-8acfc49c215a@ideasonboard.com>
In-Reply-To: <20230731-fpdlink-additions-v3-0-8acfc49c215a@ideasonboard.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Satish Nagireddy <satish.nagireddy@getcruise.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3571;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=3+DFmCI8pb7ymXT5ii0dJSIen8bU6FQj2ceug6/EKEE=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkx7ZB1/vsEcUF9lkKQC19r/IgwBZXBjt3id2qM
 l9q6iyPRJGJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZMe2QQAKCRD6PaqMvJYe
 9XVvD/40O1Pgk9HsoSDVurU5aSdLuJIDEZlQypyAXxADYQWEHYEXwH1cGg0wZAakHmHBs1VUNUL
 5CT4k8JjH6SjeyyP+Vl+sGOSi0nQQERhvIb61GkF3F/LfzgQ9zFt5jldkxncNZgCTmxbbRmvA/7
 H8P8ioLQLZR8K0ObhLyFLHOdH6W/LHhYJ0RToB451thZnnSoZfiB+/9io3qo8SXaPoLfcj4vXxL
 xNMejCwtYclvwjBLOwjWycD65Yl01IzdcpphOyyLZ4yRa6kepd3pjukUnTZ6L01FQu44c43Veto
 5kz4xzVbCcRUtzV5vITGN1jOGDwv+xt3VnBFTMHmTZPWoiYG9UTGN/hDDSly2fjHMSwqtwbWGYX
 Eh0K2hPL8TPPi7WuzXiP9Wszj6BSqNjsxlCjSiXL8aCjgXdTh86GycQ4kG9mqVethowZkasZ6os
 b7gC61POcDmp4WNw9m1rmAEp4lrOHr4KUDE++APqAg2EdUroVu8hEgBtzbRKbyYiszbKfxPvzeD
 F6RDHPZE0ZnQr8OH3n8amPPQYwu9PNQDpaG+S+JAAFnq8EKRgaOPeXqnszjl7R9uAkOK/WZn48y
 7+WdOHOP5MIDrZeKmXohmTRgVd307lCu4zRO8rbX+sBCg7YGUNAwaOZQKrdVyKaOHD5bJI50vzs
 +ZBHtzZoJZqQ5pg==
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
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/i2c/ds90ub960.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/media/i2c/ds90ub960.c b/drivers/media/i2c/ds90ub960.c
index c29db59e340b..f619c23e084a 100644
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

