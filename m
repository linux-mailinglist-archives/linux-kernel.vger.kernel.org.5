Return-Path: <linux-kernel+bounces-48729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32ACC84605C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6BF283FB7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8936B85623;
	Thu,  1 Feb 2024 18:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUjBQOEK"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2106F84FD6;
	Thu,  1 Feb 2024 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706813362; cv=none; b=uuxWn8d/r5gd6zYNo0qHUhKrEmDkvQMHVOaOKIrkeQgzUPXJUMzKOskTN8PJGZKS7PjfVzsAqCPzTRG+Z7A+UuE3Rmfi0I6WU0t1kae7L7kkQwlki5m16buHob8K7BfnvzHt6Tv2MK1B+aC2aplONjI/8XFw+H93Zk7Unp3mJWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706813362; c=relaxed/simple;
	bh=KFMTPvcO3d03ibcr31FFDVSDK7z2iX7xYkrIIVGimFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TOx3y+LSqp3Wn2EQ1Pmmeq+jprcI9g/cr2hFN4dPgmy9Ph93rhkvHh0HiAxDTQfBwM/pvm8Xq+Wx0VHuR5cgasl7VJWzJyk5T3hpqYtzKR9AkUYPlt9+2ptdfZmso5finTWfhhYa4/rRQpA6hwXm0gQIT8tA/81TidvjSLOp0Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUjBQOEK; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55f15762840so1539948a12.0;
        Thu, 01 Feb 2024 10:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706813359; x=1707418159; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CP10ASwjzq21gj6cHPQz3XuKiRelwR6OnJvv0UFbQiI=;
        b=AUjBQOEK0JqM7M3mTXNMxFIHSq+kvDUiG6FNNek33B0M97O0oKWJ0SNUXDEEAhGJW+
         cOnIM4iXZzDMIUyZ66phdfkKnoTOZ2am+eIRLscee2yY9YuwigLnvK8DSvequ2fwi4/G
         00jD9a9EiXY/SxliyTO7btVD6S3k0yFpNDDKi6OgegeRz2Xo2e8xZbRistKov9ZkrAeX
         lVdKxas848vcFoLsk+nh9aDwTreTnsO/wISM9TZZMmdevYErO+2qvk7qolfZVRNQFapu
         IEZmFwnfstN137hwl/ct7jsdB34nbPrfCj7Kpak1fToeCcOA5DCV/PcsLGlfNRfVfdPd
         gnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706813359; x=1707418159;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CP10ASwjzq21gj6cHPQz3XuKiRelwR6OnJvv0UFbQiI=;
        b=w+ht8HAcwsZQhNq5j9w63Jd1Xe6PRi7TrY/CgjZlz6w6ffTDCF3nkPDcMnxIhwn64X
         eMsCBAD5asUJhQarxMKPXyQBVSSuULK6bESnRVnOLNE+kT4mtEbBiNI2g4maTjd1Flp2
         MJhSt8Nkt/guKk+FkaWO0A7OQGAsDKyqc9xcoivreHmi2Px7/FA0GdMGdVWx8BBgPdq4
         QUiCKGH2o49RCBxfQtZuawcJH+peS3zaxJsSKODb8yryJ0R9Ih8E897MevecA4kjQrFt
         LS5PdYsgouqpwkPjDHrlBNSb/X0744u7jHf91P1AQsC7JPNyj0Z0051DQiXLS6UnBWSL
         z1ZQ==
X-Gm-Message-State: AOJu0YxYYk7oznPEFhfYmO1zEgEvEjQwayWei47oB2Oq0LsD/hAzOQr1
	iNc+P3UBImfT9jRsRsyfuSsZFBJRIYl6S7W/g6DyVyJIJ+raaqsZ
X-Google-Smtp-Source: AGHT+IFKlOu8htL+VeocZQsCqcN2H5lOEv7UpM8fH+qAO6/+jfphQEQwjVFyg6IbQ9oupKKzRN2jWw==
X-Received: by 2002:aa7:d70b:0:b0:55f:caa3:f7c6 with SMTP id t11-20020aa7d70b000000b0055fcaa3f7c6mr1331654edq.31.1706813359117;
        Thu, 01 Feb 2024 10:49:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXbOS/rwccwJDrMvw00+Ow/75KWAzVeEtF8qq2WRWPm6ayDE121p8dbC3RHPHu9tOWrBYelgUWK4aTwC7J1FAzb9+KSW+tHWj6wtsbPG5QpiGXFAVp9gu0NItSxirPMXd+wWZK2owMbKeG8lbel2uXljcp7iziPhebh6QeBA9+P4HrdChU0ZKZNVIHTmcaAsulFx9dQlOW1KoJCEDLoZ9wZUcpZHWH46zoXisLtVBelrQMeGZzPsEmXoVzS7SeOBu02xZuvjc3AnA6xLOh1o3f+NSZ+wGiK1qWIoKM5qaTsO/5PO2LMpGplTh45gaqd/4cquHQ/sTWJjE2cfatRGAiP7QWontk2rXqDxJ9ZTBcI3I57X84iMHE8+QSvxIVVwizyfajFO5eSqy8ED//VogzugA==
Received: from localhost (p200300e41f147f00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f14:7f00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id g23-20020a50ee17000000b0055971af7a23sm75332eds.95.2024.02.01.10.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 10:49:18 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 01 Feb 2024 19:49:07 +0100
Subject: [PATCH net-next 3/3] net: stmmac: Configure AXI on Tegra234 MGBE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-stmmac-axi-config-v1-3-822e97b2d26e@nvidia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1341; i=treding@nvidia.com;
 h=from:subject:message-id; bh=NJ6QmQ9rSuyu2yILzTMeD+XilmAw5wEYJDPvDZo2/VA=;
 b=owEBbQKS/ZANAwAIAd0jrNd/PrOhAcsmYgBlu+ep1zJWpEM8HRzktM8KpsERNnutRk7N84dvz
 K2El6DKvMuJAjMEAAEIAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCZbvnqQAKCRDdI6zXfz6z
 ofTjD/9vqkLXf0KsRrAGJFdVsvmQwB4UULEK0xMOneRYgY1j7/xcxTaqvOZfJ81Z9hxI/U7CDRx
 XvwAIYUqbi66duOyf/viRcLGYwAWCsFdn8zvMgsM004MjLki6BhICcLabpaXoYQSwC9QtKWV4Qp
 JIHve3g6rlXez1V4SLhClwwXJRsw7iyHTeiVc9SYVEapCIaZmEJpgLNZqgQxgP/uxME4k6wwNS3
 6Zkon2xpBLVxxdw5dRRUVdWdw56JT1Xh229MaoLARsWUtaJmjpC0HSK1EBfHLzsV3fN9O58Dq9u
 0xVzUsOkHlvhUVPvqbJEgpzrjHaL3w4mfkpFxoDfP7qUnJKYZbFwKwl7sko4NgeYz/SQ+fiNXh1
 dIPA1FXHrHq6NyeO9/3MwKkuTiTWS1vpDhUbTXQUFzeCyFmakx9uk63lrM7fe2v3zSxmNGCBtyx
 TW3atIO720/GQc7okk8LM0MXlpg+UPEJYtQp7/G+6SludKy6yLf7v1gz8ovrQdfc0aeu8YaYahh
 +Uq35mjGpOTsDo7sYM+eONXk5zGkCaoNZCvleBvCaLJIkQvm+g1/3wJ8LeBjXNidPSGfBMsyxM+
 B7ePsc1guQNfMU1CjQITNzqu4fV/Hj5fepo+1mQmnsYmAjK/0ZA2hASSBW9cQ0GPsyxNSr6zXNX
 kCD605YF4Kg+Uig==
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
2.43.0


