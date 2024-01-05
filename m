Return-Path: <linux-kernel+bounces-17581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 840DB824FBA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB6F1F20FD7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F16E22EEC;
	Fri,  5 Jan 2024 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="fmcXBnBJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826C9225A6
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 08:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50ea9daac4cso1492367e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 00:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1704443050; x=1705047850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Du/ZkBe5Bruy+m802sIrEfXmqTMIQWCN8WeGhFg9WDY=;
        b=fmcXBnBJ4iEYJTobJ6MYmZBd/d4pm9fQdsfZ17PlMLtc56o6wDHFWpzJPJF3YaEl1G
         x6vETBI1aCjy6R/71R/h0rMWrufTXeMEYeq/9tfY52GoZ3fzN9SLNcT1z1lsSWToIXgV
         lrgV8YLQmIvsCrIrFzz9f32VQlJsJYEvURAAkxGhyxHB082N2QNfzUzGRMDcHwIL8mWW
         Q553Yi26QyjD3Chy2tuCCciFtVSRPoqMFUhLvn9mD5l87uQ0f97u0ycoM7qFu+FCM2a/
         K5PTDrl3r9pPb26cZhKvwVolUgPi1BhOF3Vqt7zOqBQ/FHoRKQPKZXcMfGluSLMdk3BW
         NcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704443050; x=1705047850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Du/ZkBe5Bruy+m802sIrEfXmqTMIQWCN8WeGhFg9WDY=;
        b=gMJzkYbx5f10NmoxJfKR0ou0Uy2uhZ8il7vsqkppl5iikdh5pZXIgWwFB4o7DeZEyY
         dLnV9YbstfqBKRzJ4xor9mpqzU70pOtJ0Ma74adNDzV8JxHYqVXhntBLgeDhhzXaPigl
         fdEYhtI/orTZTyiH03VnaKaLf7iXqtnqsAfc42lXvRTKvnAXnQCe76X37VtjBKkI7hCt
         DZZ35kWqL/3rHQzXTXO0YKbt06RNoKzJw4yTTb991FBs0fhE+FmLmb+0dVa5poDIvivq
         o6sEZ+nF1XK1ltKBxfuN29NUIB9r5LvWFNZfzTD4ktadJtQPRROFKOA6J/9UqrSXC70r
         FzZg==
X-Gm-Message-State: AOJu0Yxc1G+2CugLfRjG1BNhkH9Nl/yycPI6/8/zlTeHRVDlYzSlTuJs
	g/R+lJWauA2xZf0SnPArt2doqmfmbSPnTA==
X-Google-Smtp-Source: AGHT+IFhboG1+P5HBJun7vogtFd3YX43LJB9DD2HeBtfLVamFsicSLYXq39z8/gLuEuLcK4z/dYHDw==
X-Received: by 2002:a19:7906:0:b0:50e:74ec:75f4 with SMTP id u6-20020a197906000000b0050e74ec75f4mr887158lfc.115.1704443050546;
        Fri, 05 Jan 2024 00:24:10 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.5])
        by smtp.gmail.com with ESMTPSA id j15-20020a1709064b4f00b00a28e759a447sm596198ejv.213.2024.01.05.00.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 00:24:10 -0800 (PST)
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
Subject: [PATCH net-next v3 02/19] net: ravb: Rely on PM domain to enable gptp_clk
Date: Fri,  5 Jan 2024 10:23:22 +0200
Message-Id: <20240105082339.1468817-3-claudiu.beznea.uj@bp.renesas.com>
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

ravb_rzv2m_hw_info::gptp_ref_clk is enabled only for RZ/V2M. RZ/V2M
is an ARM64-based device which selects power domains by default and
CONFIG_PM. The RZ/V2M Ethernet DT node has proper power-domain binding
available in device tree from the commit that added the Ethernet node.
(4872ca1f92b0 ("arm64: dts: renesas: r9a09g011: Add ethernet nodes")).

Power domain support was available in the rzg2l-cpg.c driver when the
Ethernet DT node has been enabled in RZ/V2M device tree.
(ef3c613ccd68 ("clk: renesas: Add CPG core wrapper for RZ/G2L SoC")).

Thus, remove the explicit clock enable for gptp_clk (and treat it as the
other clocks are treated) as it is not needed and removing it doesn't
break the ABI according to the above explanations.

By removing the enable/disable operation from the driver we can add
runtime PM support (which operates on clocks) w/o the need to handle
the gptp_clk in the Ethernet driver functions like ravb_runtime_nop().
PM domain does all that is needed.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none

Changes in v2:
- collected tags


 drivers/net/ethernet/renesas/ravb_main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 921f645a7218..1374dc11a7d1 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2780,7 +2780,6 @@ static int ravb_probe(struct platform_device *pdev)
 			error = PTR_ERR(priv->gptp_clk);
 			goto out_disable_refclk;
 		}
-		clk_prepare_enable(priv->gptp_clk);
 	}
 
 	ndev->max_mtu = info->rx_max_buf_size - (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
@@ -2806,7 +2805,7 @@ static int ravb_probe(struct platform_device *pdev)
 		/* Set GTI value */
 		error = ravb_set_gti(ndev);
 		if (error)
-			goto out_disable_gptp_clk;
+			goto out_disable_refclk;
 
 		/* Request GTI loading */
 		ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
@@ -2826,7 +2825,7 @@ static int ravb_probe(struct platform_device *pdev)
 			"Cannot allocate desc base address table (size %d bytes)\n",
 			priv->desc_bat_size);
 		error = -ENOMEM;
-		goto out_disable_gptp_clk;
+		goto out_disable_refclk;
 	}
 	for (q = RAVB_BE; q < DBAT_ENTRY_NUM; q++)
 		priv->desc_bat[q].die_dt = DT_EOS;
@@ -2889,8 +2888,6 @@ static int ravb_probe(struct platform_device *pdev)
 	/* Stop PTP Clock driver */
 	if (info->ccc_gac)
 		ravb_ptp_stop(ndev);
-out_disable_gptp_clk:
-	clk_disable_unprepare(priv->gptp_clk);
 out_disable_refclk:
 	clk_disable_unprepare(priv->refclk);
 out_release:
@@ -2925,7 +2922,6 @@ static void ravb_remove(struct platform_device *pdev)
 
 	ravb_set_opmode(ndev, CCC_OPC_RESET);
 
-	clk_disable_unprepare(priv->gptp_clk);
 	clk_disable_unprepare(priv->refclk);
 
 	pm_runtime_put_sync(&pdev->dev);
-- 
2.39.2


