Return-Path: <linux-kernel+bounces-17588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A213824FD1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93DBF2872D8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30002D05E;
	Fri,  5 Jan 2024 08:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="jqry+kZU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D002D059
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 08:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50ea8fbf261so1461682e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 00:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1704443083; x=1705047883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNkp6YbeGh31n3yPVM/nkMGFmkaualv7xNSUaNAylPY=;
        b=jqry+kZUXqb3w5Cluf74c62y5xJMYsLkJn3av5mb2LwHyQr8hlAZYyvP4sfTTawgyC
         jHJw1Is77PPgONwI9DwRn8wixauVKe1dpwZE2klqU1fdAKW0deNHCEjW0EWTln2PHtO6
         jluADGCyUuixLraVI28Cl4aMFZmt1QJc7pZD/Q5jIXBlDgqezQDOpLqirbdoL8B0oiDT
         ZvTrzY8i439OhkyxzzK+3YnNa+PubqpGI+FfmY445IGHi11iO8rs5sCxZDm1gVkg9SNW
         3clrYTXGDp6CDr88F4ADStNPocdVWRfpS4AnSng3w1+lkuEWFoQiaFprHQk7jWJWOk9F
         386Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704443083; x=1705047883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNkp6YbeGh31n3yPVM/nkMGFmkaualv7xNSUaNAylPY=;
        b=oNLdYgzdW8U4s+yKDnPjzM9ertFfRE3zu5LqlJhqJSwEuliUbxgny+YWWd7NRKpMkG
         WVScdZUa7+5NvcRHK7Og3Stz+OfiTXsCUedBVH0057p8AYtLrLSDjQKtj+tZo88ti9dt
         YEXS3XmoEf+yGnwonR8yiiVnFRvovU3qdF3tFwyhA4fROM+VZFHcnzwqzA2McRPimK4Q
         ubkm4cXdN1GX5Y7Q6nP2GcbtCSu2AyxzsvK+BnWuS8I2zDLNdni9ei9VOqhSszk57H5N
         mGxKXCPCQdCHfP5FSgEEK/bLPLaGB8kMHoqe0ZtmsVPnkV/NfH1B1awb84D12v50xXqF
         +D5w==
X-Gm-Message-State: AOJu0YwGd946Tkq1dmOQaSaUPbHIEhyRAs8+TAMJ2uMXPELJNnk4KVdC
	Qej0kg50eY9QLJp9sXpJeGxR2nHeTUx3Cw==
X-Google-Smtp-Source: AGHT+IGUysoWXBAKxxrn/BqLAiHUEOB7zyzgXpvbUh06AQxCL4ZoX3qLmRYVdNzROPCZKcwUhHBvoA==
X-Received: by 2002:a05:6512:3a8f:b0:50e:7e54:d1d4 with SMTP id q15-20020a0565123a8f00b0050e7e54d1d4mr1113999lfu.85.1704443083401;
        Fri, 05 Jan 2024 00:24:43 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.5])
        by smtp.gmail.com with ESMTPSA id j15-20020a1709064b4f00b00a28e759a447sm596198ejv.213.2024.01.05.00.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 00:24:43 -0800 (PST)
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
Subject: [PATCH net-next v3 09/19] net: ravb: Split GTI computation and set operations
Date: Fri,  5 Jan 2024 10:23:29 +0200
Message-Id: <20240105082339.1468817-10-claudiu.beznea.uj@bp.renesas.com>
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

ravb_set_gti() was computing the value of GTI based on the reference clock
rate and then applied it to register. This was done on the driver's probe
function. In order to implement runtime PM for all IP variants (as some IP
variants switches to reset mode (and thus the registers content is lost)
when module standby is configured through clock APIs) the GTI setup was
split in 2 parts: one computing the value of the GTI register (done in the
driver's probe function) and one applying the computed value to register
(done in the driver's ndo_open API).

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- fixed typos in patch description
- use u64 instead of uint64_t
- remove ravb_wait() for setting GCCR.LTI

Changes in v2:
- none; this patch is new

 drivers/net/ethernet/renesas/ravb.h      |  2 +
 drivers/net/ethernet/renesas/ravb_main.c | 96 ++++++++++++------------
 2 files changed, 52 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index e3506888cca6..268ccfafe7aa 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1102,6 +1102,8 @@ struct ravb_private {
 
 	const struct ravb_hw_info *info;
 	struct reset_control *rstc;
+
+	u32 gti_tiv;
 };
 
 static inline u32 ravb_read(struct net_device *ndev, enum ravb_reg reg)
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index ac6488ffa29a..f386a3b7effb 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1717,6 +1717,50 @@ static const struct ethtool_ops ravb_ethtool_ops = {
 	.set_wol		= ravb_set_wol,
 };
 
+static void ravb_set_gti(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
+
+	if (!(info->gptp || info->ccc_gac))
+		return;
+
+	ravb_write(ndev, priv->gti_tiv, GTI);
+
+	/* Request GTI loading */
+	ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
+}
+
+static int ravb_compute_gti(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
+	struct device *dev = ndev->dev.parent;
+	unsigned long rate;
+	u64 inc;
+
+	if (!(info->gptp || info->ccc_gac))
+		return 0;
+
+	if (info->gptp_ref_clk)
+		rate = clk_get_rate(priv->gptp_clk);
+	else
+		rate = clk_get_rate(priv->clk);
+	if (!rate)
+		return -EINVAL;
+
+	inc = div64_ul(1000000000ULL << 20, rate);
+
+	if (inc < GTI_TIV_MIN || inc > GTI_TIV_MAX) {
+		dev_err(dev, "gti.tiv increment 0x%llx is outside the range 0x%x - 0x%x\n",
+			inc, GTI_TIV_MIN, GTI_TIV_MAX);
+		return -EINVAL;
+	}
+	priv->gti_tiv = inc;
+
+	return 0;
+}
+
 /* Network device open function for Ethernet AVB */
 static int ravb_open(struct net_device *ndev)
 {
@@ -1734,6 +1778,8 @@ static int ravb_open(struct net_device *ndev)
 		goto out_napi_off;
 	ravb_emac_init(ndev);
 
+	ravb_set_gti(ndev);
+
 	/* Initialise PTP Clock driver */
 	if (info->gptp)
 		ravb_ptp_init(ndev, priv->pdev);
@@ -2425,34 +2471,6 @@ static const struct of_device_id ravb_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, ravb_match_table);
 
-static int ravb_set_gti(struct net_device *ndev)
-{
-	struct ravb_private *priv = netdev_priv(ndev);
-	const struct ravb_hw_info *info = priv->info;
-	struct device *dev = ndev->dev.parent;
-	unsigned long rate;
-	uint64_t inc;
-
-	if (info->gptp_ref_clk)
-		rate = clk_get_rate(priv->gptp_clk);
-	else
-		rate = clk_get_rate(priv->clk);
-	if (!rate)
-		return -EINVAL;
-
-	inc = div64_ul(1000000000ULL << 20, rate);
-
-	if (inc < GTI_TIV_MIN || inc > GTI_TIV_MAX) {
-		dev_err(dev, "gti.tiv increment 0x%llx is outside the range 0x%x - 0x%x\n",
-			inc, GTI_TIV_MIN, GTI_TIV_MAX);
-		return -EINVAL;
-	}
-
-	ravb_write(ndev, inc, GTI);
-
-	return 0;
-}
-
 static int ravb_set_config_mode(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -2724,15 +2742,9 @@ static int ravb_probe(struct platform_device *pdev)
 	if (error)
 		goto out_rpm_put;
 
-	if (info->gptp || info->ccc_gac) {
-		/* Set GTI value */
-		error = ravb_set_gti(ndev);
-		if (error)
-			goto out_rpm_put;
-
-		/* Request GTI loading */
-		ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
-	}
+	error = ravb_compute_gti(ndev);
+	if (error)
+		goto out_rpm_put;
 
 	if (info->internal_delay) {
 		ravb_parse_delay_mode(np, ndev);
@@ -2945,15 +2957,7 @@ static int ravb_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (info->gptp || info->ccc_gac) {
-		/* Set GTI value */
-		ret = ravb_set_gti(ndev);
-		if (ret)
-			return ret;
-
-		/* Request GTI loading */
-		ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
-	}
+	ravb_set_gti(ndev);
 
 	if (info->internal_delay)
 		ravb_set_delay_mode(ndev);
-- 
2.39.2


