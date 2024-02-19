Return-Path: <linux-kernel+bounces-71703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C8585A943
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4091F253AE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF45A446D1;
	Mon, 19 Feb 2024 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEyuVUvp"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C2341C83;
	Mon, 19 Feb 2024 16:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708361177; cv=none; b=LDYCVwd86XQdTIlCCVggUOVAgIanCuJQrX3zVEaQarLJgI2Zksqu7w0IvZV+gQIzS5XcmgzVD49rlt7KTCB8UL6ANURpjJ4XfoJhjPxzjJ3kbux/gsUQ8mdOI48gEZbBuEN9Ax+WrLvO6yOfihpBIzIGI7G95WpJ7TNtsLusmHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708361177; c=relaxed/simple;
	bh=OpywkGjlXr/F1fc4QFUmendfbRWwwx4aY6lDCERPsGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bEehgQ9q10JtGSd9jmQklTjQD7SnY/HzkIouEmDMLLwDPHHsaRxDGfB0EoWI4aa14u0Lt2MDKwfOdxdzjbDWLpUbY4vAqCXVekHWJk3Wdsd+uvRm+76L5pPHVmGIWnKEqRZzRE1GYp4oV749RxiVDMNfJb69g0FeXt475fZS9xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEyuVUvp; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-563b7b3e3ecso5415306a12.0;
        Mon, 19 Feb 2024 08:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708361174; x=1708965974; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RNjiIU+MnMIcoYvV35lNchbg525xkgaHmjWjHQnrgAI=;
        b=KEyuVUvpd1wGnyN2IWL7e6I5l5sibMk4mOWe3HraY2EX94/9trbBFd15aJlyz9iXiX
         N7rUfzKHF4YGqXS7RzeaZyIuucPtlGmUaw/Vz5JRM1ttUdSu6r/MXdTjAYlNSDy9CI6+
         +tuV2cn5GNOvN7BBcBw5k5OG3ho1DOfvphbnjsA7SIXOlu9S4TxRzAxBzq5QXWoG3cMS
         21NvFUxNFgADIDR4BUyfpRfTuo+S/bsDn/OdAACgUhRN8IcOCrHUmyAuucs51kGdgKdW
         UM8pVRq1gam/GKRZmeKk844m/g9UQZvCwavdkkxPyQTzgVj9Vw4gZjKrd6fmdJ4ZD3PJ
         zEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708361174; x=1708965974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNjiIU+MnMIcoYvV35lNchbg525xkgaHmjWjHQnrgAI=;
        b=AvEooShGgEeYHb+TOqx9lJleuskIr260qni3mKumESLRzJiYQFAsXUhO+pFLzsL3w3
         XZ8EIDUW+USqngNQwbNoj0/0XZiom12Obd2u8EgJ+LUhsO02VAZV6+jMEjtNmAWI2Edw
         IIsuXRUGq/Ry4GuUL3rzKdpA2Iqyq9W8qF3nDNWdAfTjOovX8bp331MQ5A61SUhg9W4Q
         t8t3Ovix8Fr+7Jve35b3ob0GRJJfMnPZQG6Ik9Gk9cktOEitq33KvgMeHeyo4+GnlpEz
         uxoPqE7H+N4L6tZaXt1GSOYAy5FrHPXvEiy4M1kijQ3pTiQS7P6qOVDU+LbFJT7tBhri
         T8wA==
X-Forwarded-Encrypted: i=1; AJvYcCXfFYLn/hCXtqAZHq0HLYY8+B/YUK8Se08Ym7gxX1kt+Dx+SzlFZS6+LHlc9PkSek0VHOO7v+OV7Vdgu5hHRfx7PV299rWQ9PeKBR6bb8lZFEtxty/1PiPztNFMttek9Bj79h7Yli0VbrnZQaBQSR6CSSdNBEcGfdWSjHiYACGidbA=
X-Gm-Message-State: AOJu0YxrMueonpo8ymn6DakC+hNXesCt2SnecBRbLbRadjLJoKzatv9V
	RvBPUcNWeHxGM2zJwnbIFT4Kmzfq/j61FrAFRMm74iXQ54uhzunj
X-Google-Smtp-Source: AGHT+IFeILrgwOmdxu67ncHUZUE4nXhvuhlNOkspzkSZnFXnnQtvp7fWPgo27EPTD8QyCHtOOaECPw==
X-Received: by 2002:a05:6402:2696:b0:564:15b:9f57 with SMTP id w22-20020a056402269600b00564015b9f57mr5925624edd.11.1708361173701;
        Mon, 19 Feb 2024 08:46:13 -0800 (PST)
Received: from localhost (p200300e41f2d4600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f2d:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id fd11-20020a056402388b00b0056104738371sm2837765edb.65.2024.02.19.08.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 08:46:13 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 19 Feb 2024 17:46:06 +0100
Subject: [PATCH net-next v3 3/3] net: stmmac: Configure AXI on Tegra234
 MGBE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-stmmac-axi-config-v3-3-fca7f046e6ee@nvidia.com>
References: <20240219-stmmac-axi-config-v3-0-fca7f046e6ee@nvidia.com>
In-Reply-To: <20240219-stmmac-axi-config-v3-0-fca7f046e6ee@nvidia.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Serge Semit <fancer.lancer@gmail.com>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1341; i=treding@nvidia.com;
 h=from:subject:message-id; bh=FahNwLbVWpd8t2eBaIzLF59MdYIoMLjB5FhApvU3UBw=;
 b=owEBbQKS/ZANAwAIAd0jrNd/PrOhAcsmYgBl04XQ/0uAEXnL2R0DFCkdbK7AgOwWu4oUXANiH
 26R0FoU+QeJAjMEAAEIAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCZdOF0AAKCRDdI6zXfz6z
 obeRD/0WpBZm0htLrSxWNAacexNdC3abLvhbs3ndyfACIDGwCU53kDkEqlMbz0gv3HT04VBGnie
 9cn8oWrdmfouSWku3KZy0B13uPUOlZigCDOixje6BB+14wxnEDra8af9OGSLO+v0VjlG5rFs5Nk
 0vMV2SH9hkJ0ArDHFp+9H3KSKRaBMIgkGn1ANcMDot8V44Lz03euWWGvbtcIyyxXo7vGSF8IObM
 tklx3v3obPjVPA1jyof873G2DD59ijCxSklfDDdBDvpev1lxeodCgDHV/kDZKDrCFrmiFIJTbJ0
 TVG7qT/3/xoO1yC0ANtVm5Id8GxUD08oZggVpGmqC4yTWnGC05uzRdvugwgD1AX+zG4GNrx7YMD
 5w0KO0faOnQxjv3H8zUDIKh1r4HlpDgSgTea8auvPSKMRhTJTbk9iNxO+jhumrSAQ4NctSnRFOV
 B89KrwJXZN/qxNYQCudhwmbGzzPg3w1Ii+CK/a6H1ZX3SEVjy0aaPFkiPkbMtHZNbOF6us+FDpD
 6orf236g/m4kNRitVuG9Ss0pwjprbjcQL3NgzVnZP1TTVF4fFFIV6PvHAIMBPlxj/WdJZYPFzh+
 gUgPfQeYNAH0UQrm3bWbEDlvjgskdXTPftihd8CBZUjkl3GvE0J2/678V9IpD/iQplM6l9LP6y0
 kZKxN/nhE4NHGTg==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

Allow the device to use bursts and increase the maximum number of
outstanding requests to improve performance. Measurements show an
increase in throughput of around 5x on a 1 Gbps link.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
index bab57d1675df..b6bfa48f279d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
@@ -199,6 +199,12 @@ static void mgbe_uphy_lane_bringup_serdes_down(struct net_device *ndev, void *mg
 	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
 }
 
+static const struct stmmac_axi tegra234_mgbe_axi = {
+	.axi_wr_osr_lmt = 63,
+	.axi_rd_osr_lmt = 63,
+	.axi_blen = { 256, },
+};
+
 static int tegra_mgbe_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat;
@@ -284,6 +290,9 @@ static int tegra_mgbe_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto disable_clks;
 
+	/* setup default AXI configuration */
+	res.axi = &tegra234_mgbe_axi;
+
 	plat = devm_stmmac_probe_config_dt(pdev, &res);
 	if (IS_ERR(plat)) {
 		err = PTR_ERR(plat);

-- 
2.43.2


