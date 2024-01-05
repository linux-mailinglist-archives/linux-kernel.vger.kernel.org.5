Return-Path: <linux-kernel+bounces-17592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60910824FDD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64EA91C22C77
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3072E3F8;
	Fri,  5 Jan 2024 08:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="I661HMs9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D9E2E3E4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 08:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a28b0207c1dso106141766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 00:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1704443102; x=1705047902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1p8lcj+RRuTQmVw4HBAy21i1qLMXVcCc4/+Lo+LFvE=;
        b=I661HMs9ir4JHPD0j0RbW224P7YOwfnGM+M0o5Pl9UHpAS9291vafIC+eOW5lZC1l4
         /rCUOJxJ1pf7449k5KQOD3PlqxLzoLhSNerFs4TBvWjdDaiQUZPS8efeTW1ZXmg1Zar7
         bP36eabtdgScQhUar2L4InsagC4qva9Xr/OMlyF7pdv17s2CXBx2rHnwn5G1iuFexEMa
         Mz99D41++p8IoJONHlkZFsY4xB54yze5OkY3ec46h2y+LrlBrGEbnWmzlZPFpTmOUjEs
         EU6JpQboRAiy9/WlTnWlmCLNCndh3/E3m94gnlWg1kpKT530Jtu8PyaRyeTCNwVzmkVS
         T1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704443102; x=1705047902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1p8lcj+RRuTQmVw4HBAy21i1qLMXVcCc4/+Lo+LFvE=;
        b=VQtuyMlXELh3z0iIDNeFgevkRYEkOMND2kbfw2qCk8NZuh6Qh/dSSoMHGLD1tZjwm/
         MpLdMkuRpcgNT3Jb3UOfbwLiqcU0eiyQGNhtUObQQWZWv2CMNfZQBWQ7XLV4G/WKSK9L
         Aww4vaTx4b7yMoYMwFCPjzI/2Lzxb3qe5ltr9TVcQEZMZKr5bWVQMV1s22B68DwYABKx
         W6ZjtXOEX7ufsx2kNvBnAboiv1BNPyuBeDa0dvzyw/Cx6TAw4qLOhWNiIRKeqzqCIE1Q
         ZkOVsk2WVK8D/xtVhg3ugHijYeBnrz7hE+gDjM1/NRztvY9WwITz1bhGtdybJR+msfzm
         3GxA==
X-Gm-Message-State: AOJu0YxMfm6Efux1D8XkkftFquGkNcneR8LIZ91aqCLvdw3dRL5iGMoy
	4fiIxKWNLMypP3QoTADI5H+ahXbQ6fKUyg==
X-Google-Smtp-Source: AGHT+IEcIKMWI2SL4+UYymvcyIis6QNyBgjIeOH7nSh6v30xwNS/N+H/zF6kvAoFT8NKr5Re3A3bQw==
X-Received: by 2002:a17:907:9726:b0:a26:c376:d1dc with SMTP id jg38-20020a170907972600b00a26c376d1dcmr1454659ejc.70.1704443102210;
        Fri, 05 Jan 2024 00:25:02 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.5])
        by smtp.gmail.com with ESMTPSA id j15-20020a1709064b4f00b00a28e759a447sm596198ejv.213.2024.01.05.00.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 00:25:01 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de,
	yoshihiro.shimoda.uh@renesas.com,
	wsa+renesas@sang-engineering.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	geert+renesas@glider.be,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v3 13/19] net: ravb: Set config mode in ndo_open and reset mode in ndo_close
Date: Fri,  5 Jan 2024 10:23:33 +0200
Message-Id: <20240105082339.1468817-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

As some IP variants switch to reset mode (and thus registers content is
lost) when setting clocks (due to module standby functionality) to be able
to implement runtime PM and save more power, set the IP's operating mode to
reset at the end of the probe. Along with it, in the ndo_open API the IP
will be switched to configuration, then operation mode. In the ndo_close
API, the IP will be switched back to reset mode. This allows implementing
runtime PM and, along with it, save more power when the IP is not used.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- fixed typos in patch description
- in ravb_probe() switch the hardware to reset mode just after phy
  initialization

Changes in v2:
- none; this patch is new


 drivers/net/ethernet/renesas/ravb_main.c | 78 ++++++++++++++----------
 1 file changed, 46 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 1cc1ecd8d6a8..434b4777de5e 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1717,6 +1717,27 @@ static const struct ethtool_ops ravb_ethtool_ops = {
 	.set_wol		= ravb_set_wol,
 };
 
+static int ravb_set_config_mode(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
+	int error;
+
+	if (info->gptp) {
+		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
+		if (error)
+			return error;
+		/* Set CSEL value */
+		ravb_modify(ndev, CCC, CCC_CSEL, CCC_CSEL_HPB);
+	} else if (info->ccc_gac) {
+		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG | CCC_GAC | CCC_CSEL_HPB);
+	} else {
+		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
+	}
+
+	return error;
+}
+
 static void ravb_set_gti(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -1825,13 +1846,19 @@ static int ravb_open(struct net_device *ndev)
 	if (info->nc_queues)
 		napi_enable(&priv->napi[RAVB_NC]);
 
+	/* Set AVB config mode */
+	error = ravb_set_config_mode(ndev);
+	if (error)
+		goto out_napi_off;
+
 	ravb_set_delay_mode(ndev);
 	ravb_write(ndev, priv->desc_bat_dma, DBAT);
 
 	/* Device init */
 	error = ravb_dmac_init(ndev);
 	if (error)
-		goto out_napi_off;
+		goto out_set_reset;
+
 	ravb_emac_init(ndev);
 
 	ravb_set_gti(ndev);
@@ -1854,6 +1881,8 @@ static int ravb_open(struct net_device *ndev)
 	if (info->gptp || info->ccc_gac)
 		ravb_ptp_stop(ndev);
 	ravb_stop_dma(ndev);
+out_set_reset:
+	ravb_set_opmode(ndev, CCC_OPC_RESET);
 out_napi_off:
 	if (info->nc_queues)
 		napi_disable(&priv->napi[RAVB_NC]);
@@ -2197,7 +2226,8 @@ static int ravb_close(struct net_device *ndev)
 	if (info->nc_queues)
 		ravb_ring_free(ndev, RAVB_NC);
 
-	return 0;
+	/* Set reset mode. */
+	return ravb_set_opmode(ndev, CCC_OPC_RESET);
 }
 
 static int ravb_hwtstamp_get(struct net_device *ndev, struct ifreq *req)
@@ -2527,27 +2557,6 @@ static const struct of_device_id ravb_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, ravb_match_table);
 
-static int ravb_set_config_mode(struct net_device *ndev)
-{
-	struct ravb_private *priv = netdev_priv(ndev);
-	const struct ravb_hw_info *info = priv->info;
-	int error;
-
-	if (info->gptp) {
-		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
-		if (error)
-			return error;
-		/* Set CSEL value */
-		ravb_modify(ndev, CCC, CCC_CSEL, CCC_CSEL_HPB);
-	} else if (info->ccc_gac) {
-		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG | CCC_GAC | CCC_CSEL_HPB);
-	} else {
-		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
-	}
-
-	return error;
-}
-
 static int ravb_setup_irq(struct ravb_private *priv, const char *irq_name,
 			  const char *ch, int *irq, irq_handler_t handler)
 {
@@ -2746,11 +2755,6 @@ static int ravb_probe(struct platform_device *pdev)
 	ndev->netdev_ops = &ravb_netdev_ops;
 	ndev->ethtool_ops = &ravb_ethtool_ops;
 
-	/* Set AVB config mode */
-	error = ravb_set_config_mode(ndev);
-	if (error)
-		goto out_rpm_put;
-
 	error = ravb_compute_gti(ndev);
 	if (error)
 		goto out_rpm_put;
@@ -2785,13 +2789,23 @@ static int ravb_probe(struct platform_device *pdev)
 		eth_hw_addr_random(ndev);
 	}
 
+	/* Set config mode as this is needed for PHY initialization. */
+	error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
+	if (error)
+		goto out_rpm_put;
+
 	/* MDIO bus init */
 	error = ravb_mdio_init(priv);
 	if (error) {
 		dev_err(&pdev->dev, "failed to initialize MDIO\n");
-		goto out_dma_free;
+		goto out_reset_mode;
 	}
 
+	/* Undo previous switch to config opmode. */
+	error = ravb_set_opmode(ndev, CCC_OPC_RESET);
+	if (error)
+		goto out_mdio_release;
+
 	netif_napi_add(ndev, &priv->napi[RAVB_BE], ravb_poll);
 	if (info->nc_queues)
 		netif_napi_add(ndev, &priv->napi[RAVB_NC], ravb_poll);
@@ -2814,8 +2828,10 @@ static int ravb_probe(struct platform_device *pdev)
 		netif_napi_del(&priv->napi[RAVB_NC]);
 
 	netif_napi_del(&priv->napi[RAVB_BE]);
+out_mdio_release:
 	ravb_mdio_release(priv);
-out_dma_free:
+out_reset_mode:
+	ravb_set_opmode(ndev, CCC_OPC_RESET);
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
 out_rpm_put:
@@ -2846,8 +2862,6 @@ static void ravb_remove(struct platform_device *pdev)
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
 
-	ravb_set_opmode(ndev, CCC_OPC_RESET);
-
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	clk_unprepare(priv->refclk);
-- 
2.39.2


