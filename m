Return-Path: <linux-kernel+bounces-48728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D577984606D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6EFFB2F0F2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2042B8527C;
	Thu,  1 Feb 2024 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRcFQwa2"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8416184FB3;
	Thu,  1 Feb 2024 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706813361; cv=none; b=MvLf2xJZ6C821iJY0qBKLcnGpVuwhGeafK/6DCD3phT5Dh7J11QVKqeefclRLcjmSXiCC90218vUE8ARGA4S4W/UnnDXffeUhy6V/+N2DlCeRi1ZdoyajW+v75E0OGsgmK9uCRhcmhJzFOekLh2NFaoUnDeyPEW3STeY8/2QMUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706813361; c=relaxed/simple;
	bh=7uE02QbwL+Ni59X0VwC1dSBZ70+psSkm+H47CAxGbCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZrcVDbusAqeOKAEVV0O9AwODMBzF12oPJWyxTaoEyNem4RkPCsMCQFKurSXL9m2O89ZXmNyGNbAn8YnGYfNbvnxGXgFIHpujuja8VY7/1bvXjbX3XbikdZlVPOmuWKu/vABOucnI3Q3Kdn7L3KEGuzVCZe9iGLTzoW5p7uEwSzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRcFQwa2; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a26fa294e56so182121466b.0;
        Thu, 01 Feb 2024 10:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706813357; x=1707418157; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AqDWY8wmk/fnuJTUL0gf+MfJA0JNC72CzhLE0DV6ueU=;
        b=RRcFQwa2bpJ4fXIcTXYGl57yedAbEWiD1JH1u3jlQtv/Rb9tbsfShaQY24EKQqbptL
         iECcZRDp5IsIlYaJ2GR5giVcKyRTtMDI7U6blnBNdzJ97wNLAxUC8pIlUVM1kP+qKmRp
         XR7hkRVQ/Su4NT6U0aT7sK7YVheK6marfq3+55HUmOuxoqeOgr/TOAGmuwFjC43d1gCG
         YO5+7fwin0+04k00Q7m61s+nIDJ7hcH0phxk2Ik2Y6w5quiFF9kcsH3nZVzHaNHVBMAk
         pXLI6u9MWJ4Yd8g58cXbOyyNfJD5MLf+MwMr56BjpLLY2ysAeMJV1a53pwfuwyZIvm7m
         6d3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706813357; x=1707418157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqDWY8wmk/fnuJTUL0gf+MfJA0JNC72CzhLE0DV6ueU=;
        b=pm8VRbbZ4a5G9ghfp9SHsoW6BHAnDm1bXDg1KARiyQ6fXgSvzsjGCP/CwbJk9Q2xqb
         NLqwmYS8YZshMBx7DmcquxhCgs+iRjUx00PMn1daZIIq7WJFX1JQrbnj172iCBuzFNeO
         +grkYNgmdOTuTipngwiDx0NNxLMtT2Yrv94nkzVoBt3SdZenp3o5gtXX83fzR059/Uig
         XxM8In4WLEUUzgqxlUrtvSgGk00WeMByA1vpV6anYR/2ZEPeQjcZq4t2b2y7l+uGPuZF
         kPNHmMMYLDV8+q1JBlxqiyKHOmm/qc7eUC3MGoK0QUnx9THr9f7dXF5Y701IPUPH+fkQ
         fNnQ==
X-Gm-Message-State: AOJu0YwRqxud3WhK+44Lhk2nqBnBZwcCOAtdQsMm5BfswS++gef4jdN1
	ydkI3F52mbs+bJNfRxxQmTTjIjLpHHxJLCJ0CZRWWyVLVPBi/taC
X-Google-Smtp-Source: AGHT+IGlCSjy95AXH4mYJjWbk+DnMRTrJeOc6/n32vxw6jslXvR6wtcmhksIMqv5Ku85ONcTVpRJIA==
X-Received: by 2002:a17:906:4f0a:b0:a35:43d8:a297 with SMTP id t10-20020a1709064f0a00b00a3543d8a297mr4200860eju.0.1706813357648;
        Thu, 01 Feb 2024 10:49:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXg0D4fOjs5HYilBzZpjxO0yJ3sjv2MuAzioOusiL3HyFcWt+sLiMfzeT8BjpFfqnacv7Yby1XXcVHHzOR/xpT+QEskLx0mC9QT+ACNiFR8yS9HHWB6kjXFIf1xkgamzvKGPTfpUs0nFT/kIie32a/YjaeOKyyLcF//DAoNDQ0g1dQBVsH9hcu+yJzPruQUZxhC7Xav6Ephswrty10jq6fjYgREh11U2HnZfz8BZnXDBs9DMt1ZR8BYLGXRKH3kgoM4waLf50/Xdb+S1apLl5R86GarCVapWXen6MCZAmT+n2cB1wva3iCIJnoIa8mFWBLUl+i6mD6AT355vz+L2dGnOZ3hbScsotx818w9xNBhAjfoI7M7GfmX0a9Zb4GxyM9etfoacWRMkVLXALUZMLlDWg==
Received: from localhost (p200300e41f147f00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f14:7f00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id va11-20020a17090711cb00b00a36894739bbsm64066ejb.88.2024.02.01.10.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 10:49:16 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 01 Feb 2024 19:49:06 +0100
Subject: [PATCH net-next 2/3] net: stmmac: Allow drivers to provide a
 default AXI configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-stmmac-axi-config-v1-2-822e97b2d26e@nvidia.com>
References: <20240201-stmmac-axi-config-v1-0-822e97b2d26e@nvidia.com>
In-Reply-To: <20240201-stmmac-axi-config-v1-0-822e97b2d26e@nvidia.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3475; i=treding@nvidia.com;
 h=from:subject:message-id; bh=w0xggOKS1PGq0kFbzfjy2DAd3e5snbUxtXdb8/CdR8M=;
 b=owEBbQKS/ZANAwAIAd0jrNd/PrOhAcsmYgBlu+eo4do/ibRD22vEaMX4s5Ja/xO0RyvXT1Cnc
 RiSCmMpHyKJAjMEAAEIAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCZbvnqAAKCRDdI6zXfz6z
 ocs5EACceS9fQZ3tL3oUiof4CHxmR+8LkFehtBa+PFf8289m6QSjXlUa+U6BmQYDYO82XRAQSWp
 sWLqVLFl+P06C9lS55li+177xc31OTwMkmTFPz6Flz/JkLkTx1IbZ7ECWXI3JObwAzAW7KAcDK2
 FFEdopjouSg8ZFMuREYFowuyHiQq8clPeHRitwdByxW7rmtfb6Y7nJ5PZ+T6+0fI40v9GV6GA+M
 Ru97tkDMOVKGYkBf1PP1NR8YhZGv0x/rusw8SxU0uTzEvIbLsBahNtM0MrJtHIJ/NM0oC3e4/se
 Z+WWE7wBuxGoMSx/rhvwS/XtHmpneR8RxdZQEZZuqTXsb2jN/wLcW1XYwCdsALuMMqnrRf7l/yj
 GVS/0N2rbCt9oQqoXxWcCnbSS5qnBuo3cc0cQKBnQRe8hsfX2YATDtGCnY753qymvwtM3XqKndx
 4Q9j5Q2ZgAeIc75t1Mozsaj5oFbjXLnNOZZKkiIjnwbnwgb215Gi7Y0bqKCoSH51v7H5LaX2Z+2
 fFdp5oBoKyfxJmy3ue0dkohWH3alIPb0JzF7/iawpgLCeQcv4r6HycHubcU3QPR5HedcNDoP5rv
 7FTWnqy4tAoriipDpD3G9VfWF747TP5EvjvkZkCeU9qmNDwMKWEeNvKZVdegLqn+BKPL5gMsKu8
 j5QK3IU/pg3yO1g==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

In many cases the AXI configuration can be derived from the compatible
string, so there's no need to add the configuration to DT. Allow drivers
to pass in the default AXI configuration so they can be properly set up
without extra data in DT.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  2 +
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 47 ++++++++++++++--------
 2 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index f155e4841c62..07706e7b3cfc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -35,6 +35,8 @@ struct stmmac_resources {
 	int sfty_ue_irq;
 	int rx_irq[MTL_MAX_RX_QUEUES];
 	int tx_irq[MTL_MAX_TX_QUEUES];
+
+	const struct stmmac_axi *axi;
 };
 
 enum stmmac_txbuf_type {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 8ec2ac28a775..0d5f2cebd6fc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -91,34 +91,49 @@ static int dwmac1000_validate_ucast_entries(struct device *dev,
  * if required, from device-tree the AXI internal register can be tuned
  * by using platform parameters.
  */
-static struct stmmac_axi *stmmac_axi_setup(struct platform_device *pdev)
+static struct stmmac_axi *stmmac_axi_setup(struct platform_device *pdev,
+					   struct stmmac_resources *res)
 {
 	struct device_node *np;
 	struct stmmac_axi *axi;
 
 	np = of_parse_phandle(pdev->dev.of_node, "snps,axi-config", 0);
-	if (!np)
+	if (!np && !res->axi)
 		return NULL;
 
 	axi = devm_kzalloc(&pdev->dev, sizeof(*axi), GFP_KERNEL);
 	if (!axi) {
-		of_node_put(np);
+		if (np)
+			of_node_put(np);
+
 		return ERR_PTR(-ENOMEM);
 	}
 
-	axi->axi_lpi_en = of_property_read_bool(np, "snps,lpi_en");
-	axi->axi_xit_frm = of_property_read_bool(np, "snps,xit_frm");
-	axi->axi_kbbe = of_property_read_bool(np, "snps,kbbe");
-	axi->axi_fb = of_property_read_bool(np, "snps,fb");
-	axi->axi_mb = of_property_read_bool(np, "snps,mb");
-	axi->axi_rb =  of_property_read_bool(np, "snps,rb");
-
-	if (of_property_read_u32(np, "snps,wr_osr_lmt", &axi->axi_wr_osr_lmt))
-		axi->axi_wr_osr_lmt = 1;
-	if (of_property_read_u32(np, "snps,rd_osr_lmt", &axi->axi_rd_osr_lmt))
-		axi->axi_rd_osr_lmt = 1;
-	of_property_read_u32_array(np, "snps,blen", axi->axi_blen, AXI_BLEN);
-	of_node_put(np);
+	if (res->axi)
+		*axi = *res->axi;
+
+	if (np) {
+		axi->axi_lpi_en = of_property_read_bool(np, "snps,lpi_en");
+		axi->axi_xit_frm = of_property_read_bool(np, "snps,xit_frm");
+		axi->axi_kbbe = of_property_read_bool(np, "snps,kbbe");
+		axi->axi_fb = of_property_read_bool(np, "snps,fb");
+		axi->axi_mb = of_property_read_bool(np, "snps,mb");
+		axi->axi_rb =  of_property_read_bool(np, "snps,rb");
+
+		if (of_property_read_u32(np, "snps,wr_osr_lmt", &axi->axi_wr_osr_lmt)) {
+			if (!res->axi)
+				axi->axi_wr_osr_lmt = 1;
+		}
+
+		if (of_property_read_u32(np, "snps,rd_osr_lmt", &axi->axi_rd_osr_lmt)) {
+			if (!res->axi)
+				axi->axi_rd_osr_lmt = 1;
+		}
+
+		of_property_read_u32_array(np, "snps,blen", axi->axi_blen, AXI_BLEN);
+
+		of_node_put(np);
+	}
 
 	return axi;
 }

-- 
2.43.0


