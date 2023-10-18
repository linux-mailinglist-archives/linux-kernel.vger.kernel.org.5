Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD087CD54C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344635AbjJRHK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjJRHKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:10:38 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F46B6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:10:36 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qt0h1-0007Yr-S8; Wed, 18 Oct 2023 09:10:11 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qt0gz-002V9Z-3P; Wed, 18 Oct 2023 09:10:09 +0200
Received: from localhost ([::1] helo=dude03.red.stw.pengutronix.de)
        by dude03.red.stw.pengutronix.de with esmtp (Exim 4.96)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qt0gz-003JoA-00;
        Wed, 18 Oct 2023 09:10:09 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
Date:   Wed, 18 Oct 2023 09:09:53 +0200
Subject: [PATCH net-next v2 1/5] net: stmmac: simplify debug message on
 stmmac_enable()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231010-stmmac_fix_auxiliary_event_capture-v2-1-51d5f56542d7@pengutronix.de>
References: <20231010-stmmac_fix_auxiliary_event_capture-v2-0-51d5f56542d7@pengutronix.de>
In-Reply-To: <20231010-stmmac_fix_auxiliary_event_capture-v2-0-51d5f56542d7@pengutronix.de>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Kurt Kanzenbach <kurt@linutronix.de>
Cc:     patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, vee.khee.wong@linux.intel.com,
        tee.min.tan@intel.com, rmk+kernel@armlinux.org.uk,
        bartosz.golaszewski@linaro.org, ahalaney@redhat.com,
        horms@kernel.org, Johannes Zink <j.zink@pengutronix.de>
X-Mailer: b4 0.12.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the netdev_dbg() call in stmmac_enable() in order to reduce code
duplication. No functional change.

Signed-off-by: Johannes Zink <j.zink@pengutronix.de>

---

Changelog:

v1 -> v2: no changes
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 1be06b96c35f..f110b91af9bd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -203,14 +203,10 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 			/* Enable External snapshot trigger */
 			acr_value |= priv->plat->ext_snapshot_num;
 			acr_value |= PTP_ACR_ATSFC;
-			netdev_dbg(priv->dev, "Auxiliary Snapshot %d enabled.\n",
-				   priv->plat->ext_snapshot_num >>
-				   PTP_ACR_ATSEN_SHIFT);
-		} else {
-			netdev_dbg(priv->dev, "Auxiliary Snapshot %d disabled.\n",
-				   priv->plat->ext_snapshot_num >>
-				   PTP_ACR_ATSEN_SHIFT);
 		}
+		netdev_dbg(priv->dev, "Auxiliary Snapshot %d %s.\n",
+			   priv->plat->ext_snapshot_num >> PTP_ACR_ATSEN_SHIFT,
+			   on ? "enabled" : "disabled");
 		writel(acr_value, ptpaddr + PTP_ACR);
 		mutex_unlock(&priv->aux_ts_lock);
 		/* wait for auxts fifo clear to finish */

-- 
2.39.2

