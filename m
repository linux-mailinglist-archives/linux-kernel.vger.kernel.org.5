Return-Path: <linux-kernel+bounces-14273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C061821AA3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8141F2275F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B44DF63;
	Tue,  2 Jan 2024 11:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="HiXTEiNk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33CEDDA6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 11:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3366ddd1eddso9026962f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 03:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1704193337; x=1704798137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbfHeUli9qVZSeK5qz1KYXw4fdMH2IEIwbM+g++TvkU=;
        b=HiXTEiNkquiYiLHA9KyUjlEbhGqbsQ7fujrjKcE6FimO7MGej/7K3enaNf2tE7rPxv
         YIDSmuSW83jfZhVufab1CoFt++RXE5BbmZAfD4VJ20d/otvpy6WoIyZJi1MUO1dzc01E
         a1bE3kjvRyhFLyHaXPuHW+3xPMwzV55d6xFKRXSB4qZCpEmWyDZRWA2ZVjLQq6lB4K3U
         BtrAqz+JJdGUB5JDsJ+p9ySmKkLsVcEbg5wIVu6J2V3NHsrd8XRNWOpt7cKlVcHvA6nq
         TPKHA38Joe5JjfoJZ45XHYbvx4joucnhlGQUZU8UotaDuSZ+We/hs9+PVmhP7p+HPfGL
         uVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704193337; x=1704798137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbfHeUli9qVZSeK5qz1KYXw4fdMH2IEIwbM+g++TvkU=;
        b=da/8EaUeUS28iT7HjHqJfqfuAkOPh5r4F+uak8jrvq5ARdY/TvrrZdKqGttl0MtofM
         2A7aYSp1x6jIBHQZYJxtLg0qhygvHAOJ2SF4TTaYFTnoFoGYpuRhG1m9fngyo6+WG33a
         bx6jcbSYi3/wPCHeNliFkUwXdeFOMuP5tiBKyzrhwluVjLz2SRYiCwDTbpmsC2ONwedj
         vw/hWJAFnf8ebDXG4ALXDhv1XvcNht1QVqDUx//twfF2/zZsyDfJXhBfTKesPA+b4ZJf
         39GP2rrWDMQ8GXrGj+gTghdyAlI/4M/jeYEjG7XYOXZ0cJyWmY/ClRaDqQKhNiseoS4s
         wqQQ==
X-Gm-Message-State: AOJu0YxTIS/UVkTVPXEstveQ19ZO+2EKp6wOl4RP4MxeTn1DoDUArbpb
	1nJAZo89TOhFHumX9RbWa2+yXpoC4jbzXQ==
X-Google-Smtp-Source: AGHT+IHE9JEwHWy/m6dZV/qC47KHMcm/LgVBhlOY3XjCtL4OnH+q997HZPOe+b8yF824UFIACJ64+Q==
X-Received: by 2002:a5d:5244:0:b0:336:7ff6:af9 with SMTP id k4-20020a5d5244000000b003367ff60af9mr4305358wrc.212.1704193337064;
        Tue, 02 Jan 2024 03:02:17 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.5])
        by smtp.gmail.com with ESMTPSA id l4-20020a5d6744000000b00336710ddea0sm28174229wrw.59.2024.01.02.03.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 03:02:16 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mitsuhiro.kimura.kc@renesas.com,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net v3 1/1] net: ravb: Wait for operating mode to be applied
Date: Tue,  2 Jan 2024 13:01:16 +0200
Message-Id: <20240102110116.4005187-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240102110116.4005187-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240102110116.4005187-1-claudiu.beznea.uj@bp.renesas.com>
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
setting the operating mode (set CCC.OPC (and CCC.GAC, CCC.CSEL, if any) and
wait for CSR.OPS) and call it where needed. This should comply with all the
HW manuals requirements as different manual variants specify that different
modes need to be checked in CSR.OPS when setting CCC.OPC.

In case of platforms with GAC, if GAC needs to be enabled, the CCC.GAC and
CCC.CSEL needs to be configured along with CCC.OPC. For this,
ravb_set_opmode() allows passing GAC and CSEL as part of opmode and the
function updates accordingly CCC register.

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 61 +++++++++++++++---------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 664eda4b5a11..9835d18a7adf 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -66,16 +66,23 @@ int ravb_wait(struct net_device *ndev, enum ravb_reg reg, u32 mask, u32 value)
 	return -ETIMEDOUT;
 }
 
-static int ravb_config(struct net_device *ndev)
+static int ravb_set_opmode(struct net_device *ndev, u32 opmode)
 {
+	u32 csr_ops = 1U << (opmode & CCC_OPC);
+	u32 ccc_mask = CCC_OPC;
 	int error;
 
-	/* Set config mode */
-	ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG);
-	/* Check if the operating mode is changed to the config mode */
-	error = ravb_wait(ndev, CSR, CSR_OPS, CSR_OPS_CONFIG);
-	if (error)
-		netdev_err(ndev, "failed to switch device to config mode\n");
+	if (opmode & CCC_GAC)
+		ccc_mask |= CCC_GAC | CCC_CSEL;
+
+	/* Set operating mode */
+	ravb_modify(ndev, CCC, ccc_mask, opmode);
+	/* Check if the operating mode is changed to the requested one */
+	error = ravb_wait(ndev, CSR, CSR_OPS, csr_ops);
+	if (error) {
+		netdev_err(ndev, "failed to switch device to requested mode (%u)\n",
+			   opmode & CCC_OPC);
+	}
 
 	return error;
 }
@@ -673,7 +680,7 @@ static int ravb_dmac_init(struct net_device *ndev)
 	int error;
 
 	/* Set CONFIG mode */
-	error = ravb_config(ndev);
+	error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
 	if (error)
 		return error;
 
@@ -682,9 +689,7 @@ static int ravb_dmac_init(struct net_device *ndev)
 		return error;
 
 	/* Setting the control will start the AVB-DMAC process. */
-	ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_OPERATION);
-
-	return 0;
+	return ravb_set_opmode(ndev, CCC_OPC_OPERATION);
 }
 
 static void ravb_get_tx_tstamp(struct net_device *ndev)
@@ -1046,7 +1051,7 @@ static int ravb_stop_dma(struct net_device *ndev)
 		return error;
 
 	/* Stop AVB-DMAC process */
-	return ravb_config(ndev);
+	return ravb_set_opmode(ndev, CCC_OPC_CONFIG);
 }
 
 /* E-MAC interrupt handler */
@@ -2560,21 +2565,25 @@ static int ravb_set_gti(struct net_device *ndev)
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
+		if (error)
+			return error;
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
@@ -2794,7 +2803,9 @@ static int ravb_probe(struct platform_device *pdev)
 	ndev->ethtool_ops = &ravb_ethtool_ops;
 
 	/* Set AVB config mode */
-	ravb_set_config_mode(ndev);
+	error = ravb_set_config_mode(ndev);
+	if (error)
+		goto out_disable_gptp_clk;
 
 	if (info->gptp || info->ccc_gac) {
 		/* Set GTI value */
@@ -2917,8 +2928,7 @@ static void ravb_remove(struct platform_device *pdev)
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
 
-	/* Set reset mode */
-	ravb_write(ndev, CCC_OPC_RESET, CCC);
+	ravb_set_opmode(ndev, CCC_OPC_RESET);
 
 	clk_disable_unprepare(priv->gptp_clk);
 	clk_disable_unprepare(priv->refclk);
@@ -3000,8 +3010,11 @@ static int __maybe_unused ravb_resume(struct device *dev)
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
@@ -3009,7 +3022,9 @@ static int __maybe_unused ravb_resume(struct device *dev)
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


