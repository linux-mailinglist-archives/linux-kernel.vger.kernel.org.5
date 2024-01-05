Return-Path: <linux-kernel+bounces-17591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A09FB824FDA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E67B1C22CB3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DF22D7BD;
	Fri,  5 Jan 2024 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="PQOnPIiA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3115A2DF63
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a275b3a1167so154273666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 00:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1704443097; x=1705047897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5orQgwfDjSBIeq4ujM8DL6jz3CCIaE3k0jKXQPZpdUw=;
        b=PQOnPIiAM+K/1FD5C+58uAbe9lf+6xzCMUQPaflCfyvfDvEwLX3wzuNMnPuZRfV4Co
         V6W1Yhq13VBKOdirmUGMcX9Q2YMvsz3gHS3St4c3EDNk8XnZ8bjH9TyWWVm38gZcNo+U
         IaRVmuAafsorcwt4BHD8WjS6kjcqMzPJcS9vbXzfvqDSpn5O+iJkXrFe4GFDahtChwL0
         50KW7dYLeP5ArDVWvjbSCEfR/tKwzcNq+JUDRaWnw7YHCg9gtOpn1YrGGPHHrXW3tqfK
         QFTEtWJFae0FVWREHd0+wyze6w4sUYVWfQVtq2+VaAgBTcsz24Y3uaUzkfAFmGQOFklg
         P3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704443097; x=1705047897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5orQgwfDjSBIeq4ujM8DL6jz3CCIaE3k0jKXQPZpdUw=;
        b=uCvAZiuUuuy7gX9rKWaLuyH5EhFWQdkRgf3Ae13G1RYjLlwEkaWGPPYi6gY7i32lAE
         CQGhsSNbn7SjHS19tW3p4tWztZZXDTVbuQeCcjLGXx1MqZU7dLMLhcMjv7mQnDojF4fS
         tZTHpN9HWc9yPJHzZWlEJxMY904d+l2mR+cNMcnwym0ofmHfR/QGAWY9WFkQ9AM3PxPk
         hjeHKWgCPf2kV67iVn3mYholb3aV7TSKmR6bpTMam2+jD5ngfxxePJdz0NtgSO9GCHWp
         qhKMJ33I9u9crcNpOQ5fsDKDrh8G/DreF9/sGA8DqTbRm19HSbpVj+0BLyuThyob+rYz
         zbnA==
X-Gm-Message-State: AOJu0YxWoVWsyOJXCPLuSMrfSAhqJ0Lw4RRcy0+FdZTDE7XsZ68KHf09
	LyLkyeFwJK7atL7zmC44xdoY8G7bLxlQMQ==
X-Google-Smtp-Source: AGHT+IEkZc0Hptsn2sBcPNILgoHuJbFuO9ppIzOuuw34IWt/pWvdc1gkNwY4WHzQpAQy5J2Bx+4Bpg==
X-Received: by 2002:a17:906:474e:b0:a27:32a0:b838 with SMTP id j14-20020a170906474e00b00a2732a0b838mr986323ejs.112.1704443097504;
        Fri, 05 Jan 2024 00:24:57 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.5])
        by smtp.gmail.com with ESMTPSA id j15-20020a1709064b4f00b00a28e759a447sm596198ejv.213.2024.01.05.00.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 00:24:57 -0800 (PST)
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
Subject: [PATCH net-next v3 12/19] net: ravb: Move PTP initialization in the driver's ndo_open API for ccc_gac platorms
Date: Fri,  5 Jan 2024 10:23:32 +0200
Message-Id: <20240105082339.1468817-13-claudiu.beznea.uj@bp.renesas.com>
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

The initialization sequence for PTP is the same for platforms with ccc_gac
and gptp (according to "Figure 50.71 Flow of gPTP Initialization (Normal,
Common to All Modes)" of the R-Car Series, 3rd generation hardware
manual and "Figure 37A.53 Flow of gPTP Initialization (Normal, Common to
All Modes)" of the RZ/G Series hardware manual).

As some IP variants switch to reset mode (and thus the registers content is
lost) when setting clocks (due to module standby functionality) to be able
to implement runtime PM, move the PTP initialization to the driver's
ndo_open API.

This commit prepares the code for the addition of runtime PM.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- fixed typos in patch description
- collected tags

Changes in v2:
- none; this patch is new

 drivers/net/ethernet/renesas/ravb_main.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index dbc26c3e95ec..1cc1ecd8d6a8 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1837,7 +1837,7 @@ static int ravb_open(struct net_device *ndev)
 	ravb_set_gti(ndev);
 
 	/* Initialise PTP Clock driver */
-	if (info->gptp)
+	if (info->gptp || info->ccc_gac)
 		ravb_ptp_init(ndev, priv->pdev);
 
 	/* PHY control start */
@@ -1851,7 +1851,7 @@ static int ravb_open(struct net_device *ndev)
 
 out_ptp_stop:
 	/* Stop PTP Clock driver */
-	if (info->gptp)
+	if (info->gptp || info->ccc_gac)
 		ravb_ptp_stop(ndev);
 	ravb_stop_dma(ndev);
 out_napi_off:
@@ -2161,7 +2161,7 @@ static int ravb_close(struct net_device *ndev)
 	ravb_write(ndev, 0, TIC);
 
 	/* Stop PTP Clock driver */
-	if (info->gptp)
+	if (info->gptp || info->ccc_gac)
 		ravb_ptp_stop(ndev);
 
 	/* Set the config mode to stop the AVB-DMAC's processes */
@@ -2774,10 +2774,6 @@ static int ravb_probe(struct platform_device *pdev)
 	/* Initialise HW timestamp list */
 	INIT_LIST_HEAD(&priv->ts_skb_list);
 
-	/* Initialise PTP Clock driver */
-	if (info->ccc_gac)
-		ravb_ptp_init(ndev, pdev);
-
 	/* Debug message level */
 	priv->msg_enable = RAVB_DEF_MSG_ENABLE;
 
@@ -2822,10 +2818,6 @@ static int ravb_probe(struct platform_device *pdev)
 out_dma_free:
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
-
-	/* Stop PTP Clock driver */
-	if (info->ccc_gac)
-		ravb_ptp_stop(ndev);
 out_rpm_put:
 	pm_runtime_put(&pdev->dev);
 out_rpm_disable:
@@ -2851,10 +2843,6 @@ static void ravb_remove(struct platform_device *pdev)
 
 	ravb_mdio_release(priv);
 
-	/* Stop PTP Clock driver */
-	if (info->ccc_gac)
-		ravb_ptp_stop(ndev);
-
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
 
-- 
2.39.2


