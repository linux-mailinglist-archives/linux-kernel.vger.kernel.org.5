Return-Path: <linux-kernel+bounces-9666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A14F81C93F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 755B5B24A19
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFD3182A8;
	Fri, 22 Dec 2023 11:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="gNj+mQbT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364A317756
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 11:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3368ae75082so839903f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 03:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1703244965; x=1703849765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsLRo2DIKSewvWiB6cWyV1wSBBaL30FyPbtjX4uqQKY=;
        b=gNj+mQbTDv8d8dwteG2N4qs+CeyHCVhfvADC8D3YFwuGmQ2Bqi/9ze3aXQeBe2NrgQ
         /1U8BRrDFfkcwiFAOhTVed9VY/aKqD67Gc0Sgeggzk+F22iU/Re/V2FJMe4/uKCjy0by
         7S5oem7Ng40/qOpcRY4xqB98jHzzNtskw+Ej/F2Ad1UxQzZutCfke/jSUd+CcB0CwLtL
         Md95gLewHHnctAk6/D9Z/9WFVL0ouF9PcnXJs91SWSvrN4hosyvt7yubs9sX+cfWQVGr
         HdkjViFc4uFZE7LyUpMgLeyiqXCOR/8I4EWy/ag/rseBcnqJZvzDmlGrJB774h01Quux
         QyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703244965; x=1703849765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HsLRo2DIKSewvWiB6cWyV1wSBBaL30FyPbtjX4uqQKY=;
        b=H87xItm3LDZK29iHjz6cztboql+eTISZhxV7DEpq6SK7WUzzzmSgbzUmsfN7VJJIse
         q3bT0/BfyccF/5c+dC0QjwM+Np8Td1Y6TGSfexwCvsLfRBaEZXzB7Qv2Wx3QHHhjheFa
         zO4VuNYD2v8suDmtOcw0dYv7nMBdd2rtwUlkenBDC1xmFEBolYH+h9d2MJefDRvaWfip
         KYD7Ep1Xag7l2AbbsrHHmbniTRvSEWWdIqeOuyTYeoeN44TetBpRmUKfjCJdjQWOyNVQ
         Qj7pAERHMdt6c6Gc3V7OR2MNJafF+l7BEPLYmsiN1NPf04sbWKnATBEu7KZSPYm0J9zC
         Ktdw==
X-Gm-Message-State: AOJu0YzIcyN9HbspoZmJvLgIXn/n9ft/19UYGGSBUYQWSnGy3yGplDfd
	BqFP4I639h3c+1EGv16VbiSooMgdhPMJyQ==
X-Google-Smtp-Source: AGHT+IFcFPeDA0acQZKW640OyJDex0TiliPYaarL2xbU38P0SMq4rAADkwLj6sp9yQWME4bXCha9BQ==
X-Received: by 2002:a05:600c:4683:b0:40d:427e:9b12 with SMTP id p3-20020a05600c468300b0040d427e9b12mr656598wmo.132.1703244965378;
        Fri, 22 Dec 2023 03:36:05 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id fl6-20020a05600c0b8600b0040b30be6244sm6802472wmb.24.2023.12.22.03.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 03:36:05 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yoshihiro.shimoda.uh@renesas.com,
	wsa+renesas@sang-engineering.com,
	mitsuhiro.kimura.kc@renesas.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net v2 1/1] net: ravb: Wait for operation mode to be applied
Date: Fri, 22 Dec 2023 13:35:52 +0200
Message-Id: <20231222113552.2049088-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231222113552.2049088-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231222113552.2049088-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

CSR.OPS bits specify the current operating mode and (according to
documentation) they are updated by HW when the operating mode change
request is processed. To comply with this check CSR.OPS before proceeding.

Commit introduces ravb_set_opmode() that does all the necessities for
setting the operating mode (set DMA.CCC and wait for CSR.OPS) and call it
where needed. This should comply with all the HW manuals requirements as
different manual variants specify that different modes need to be checked
in CSR.OPS when setting DMA.CCC.

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 52 ++++++++++++++----------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 664eda4b5a11..ae99d035a3b6 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -66,14 +66,15 @@ int ravb_wait(struct net_device *ndev, enum ravb_reg reg, u32 mask, u32 value)
 	return -ETIMEDOUT;
 }
 
-static int ravb_config(struct net_device *ndev)
+static int ravb_set_opmode(struct net_device *ndev, u32 opmode)
 {
+	u32 csr_opmode = 1UL << opmode;
 	int error;
 
-	/* Set config mode */
-	ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG);
-	/* Check if the operating mode is changed to the config mode */
-	error = ravb_wait(ndev, CSR, CSR_OPS, CSR_OPS_CONFIG);
+	/* Set operating mode */
+	ravb_modify(ndev, CCC, CCC_OPC, opmode);
+	/* Check if the operating mode is changed to the requested one */
+	error = ravb_wait(ndev, CSR, CSR_OPS, csr_opmode);
 	if (error)
 		netdev_err(ndev, "failed to switch device to config mode\n");
 
@@ -673,7 +674,7 @@ static int ravb_dmac_init(struct net_device *ndev)
 	int error;
 
 	/* Set CONFIG mode */
-	error = ravb_config(ndev);
+	error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
 	if (error)
 		return error;
 
@@ -682,9 +683,7 @@ static int ravb_dmac_init(struct net_device *ndev)
 		return error;
 
 	/* Setting the control will start the AVB-DMAC process. */
-	ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_OPERATION);
-
-	return 0;
+	return ravb_set_opmode(ndev, CCC_OPC_OPERATION);
 }
 
 static void ravb_get_tx_tstamp(struct net_device *ndev)
@@ -1046,7 +1045,7 @@ static int ravb_stop_dma(struct net_device *ndev)
 		return error;
 
 	/* Stop AVB-DMAC process */
-	return ravb_config(ndev);
+	return ravb_set_opmode(ndev, CCC_OPC_CONFIG);
 }
 
 /* E-MAC interrupt handler */
@@ -2560,21 +2559,23 @@ static int ravb_set_gti(struct net_device *ndev)
 	return 0;
 }
 
-static void ravb_set_config_mode(struct net_device *ndev)
+static int ravb_set_config_mode(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
+	int error;
 
 	if (info->gptp) {
-		ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG);
+		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
 		/* Set CSEL value */
 		ravb_modify(ndev, CCC, CCC_CSEL, CCC_CSEL_HPB);
 	} else if (info->ccc_gac) {
-		ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG |
-			    CCC_GAC | CCC_CSEL_HPB);
+		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG | CCC_GAC | CCC_CSEL_HPB);
 	} else {
-		ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG);
+		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
 	}
+
+	return error;
 }
 
 /* Set tx and rx clock internal delay modes */
@@ -2794,7 +2795,9 @@ static int ravb_probe(struct platform_device *pdev)
 	ndev->ethtool_ops = &ravb_ethtool_ops;
 
 	/* Set AVB config mode */
-	ravb_set_config_mode(ndev);
+	error = ravb_set_config_mode(ndev);
+	if (error)
+		goto out_disable_gptp_clk;
 
 	if (info->gptp || info->ccc_gac) {
 		/* Set GTI value */
@@ -2902,6 +2905,7 @@ static void ravb_remove(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
+	int error;
 
 	unregister_netdev(ndev);
 	if (info->nc_queues)
@@ -2917,8 +2921,9 @@ static void ravb_remove(struct platform_device *pdev)
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
 
-	/* Set reset mode */
-	ravb_write(ndev, CCC_OPC_RESET, CCC);
+	error = ravb_set_opmode(ndev, CCC_OPC_RESET);
+	if (error)
+		netdev_err(ndev, "Failed to reset ndev\n");
 
 	clk_disable_unprepare(priv->gptp_clk);
 	clk_disable_unprepare(priv->refclk);
@@ -3000,8 +3005,11 @@ static int __maybe_unused ravb_resume(struct device *dev)
 	int ret = 0;
 
 	/* If WoL is enabled set reset mode to rearm the WoL logic */
-	if (priv->wol_enabled)
-		ravb_write(ndev, CCC_OPC_RESET, CCC);
+	if (priv->wol_enabled) {
+		ret = ravb_set_opmode(ndev, CCC_OPC_RESET);
+		if (ret)
+			return ret;
+	}
 
 	/* All register have been reset to default values.
 	 * Restore all registers which where setup at probe time and
@@ -3009,7 +3017,9 @@ static int __maybe_unused ravb_resume(struct device *dev)
 	 */
 
 	/* Set AVB config mode */
-	ravb_set_config_mode(ndev);
+	ret = ravb_set_config_mode(ndev);
+	if (ret)
+		return ret;
 
 	if (info->gptp || info->ccc_gac) {
 		/* Set GTI value */
-- 
2.39.2


