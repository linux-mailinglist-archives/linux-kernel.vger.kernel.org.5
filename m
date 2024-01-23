Return-Path: <linux-kernel+bounces-35042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8539838AF3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468BA1F23129
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5AA5C911;
	Tue, 23 Jan 2024 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+Q/MKVU"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCCA5C90E;
	Tue, 23 Jan 2024 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003425; cv=none; b=MWoRw5BhT8cM2CQxCLYV9/UrLOKqIpj8E//Qzit2Xgq0O2wJwJJS9Aks5iI6T8sw8yyDyycrpnjCWpHZr+RCsiFVSByXywQFWuQynV1ylBncfUng4GXZVErPy64PFBCGiwUhxXINGvdUMyJ6rdHRrqzeFLzcxIeifwTZ4fhr0Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003425; c=relaxed/simple;
	bh=mgeZFk1nt8TaMRKGQpVuxzk3SGlZGmEO4300G5Tg2kw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cqgojLzk0kmZGaQqTNNyhw/6g0m1kTDrBZ10LejrJ/tSJQTjH7d0kZFdgBZ95tUyaw8CtDgdHKSP4ORTZd2D11kE4zpByPq1Lw2W7Zow4iBxX7e4thk9xv1jnLwWWrF5yjXPAtqiDlw07HvPLROwn/jkRrjgurk55yM00PRgNYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+Q/MKVU; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bba50cd318so4220087b6e.0;
        Tue, 23 Jan 2024 01:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706003421; x=1706608221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PB92u9IW1i3UPi9lwUSJ6To660URrQExv6UFr5Kbu60=;
        b=e+Q/MKVUa/3OhvDaFkl2wXv1JxLeQMYfGtLlMVyK+JTFxiaIU6VPvCYJpiVWNBjcF9
         aUywdUQ2qW9EBqE5G8j3jpdgx1xT3hjt7xFuqA6hUfi0DyWSDipf4HKp5aUIuvrGa85D
         vd30f3PArALA4fcFHKmRA17Tk2OXIFn1hIEgQ1t24M1XX9xZIVGjf8Jf0TJAGHs6dXJM
         50pgsFePzaKkfaTP33AJ0MMsF8XlZPT5rys3y1dqk/pZ3G/NAaj73V5BpEe4ay+WHMwT
         pmAkEN/e0ibcTlOd01UwDjMSH4e8+NQzIbfffUph7ubWeioE+fDjSF1RboKR7xElTEZT
         EQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706003421; x=1706608221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PB92u9IW1i3UPi9lwUSJ6To660URrQExv6UFr5Kbu60=;
        b=MutXdlFykJwzy1pWI3YhxhFIQ+pRIi/JLP/DGzsueOihIxysVAWC4m9Nuq/6+2OZgX
         rw7aWiMgXshT2BQHsoTFl69+teyFBxjI1AyYp5dAsljEzdW3GLPB+AfcYwf+0De1BBEe
         rscixxCRtNFxdPTG6Vbo22H6iZGAeUwQyGJc5wUHzA0jRyoHJduYC+R/MSv3SJd9jb8j
         kUPTd4z85k5j5QEbc8KZI0Meb4348pBZJKVwEZ/XQKD97okJzDyViQugpO/D5aRAWa3Z
         kiXt2xGyx1cY4rT8tonkKaPy0OKpy+gZRC553j0nj84BTz+qbby2L1Tr1SoIE3zpD3GZ
         N3HA==
X-Gm-Message-State: AOJu0YxjhqL94NxoFZvYXw3Wb6zNp555P4ul9+1ANyjkGTqiM1xF2SFt
	Yxq6f92N1Iwtf8eX7ht0OKcMRJEgb3LlchfnJJ+CoWY6ikJQiDun
X-Google-Smtp-Source: AGHT+IFB2J7jlF2o323XuO6+0bPEVEQ5/i7o6OTowMJfhE3eJOKff9Hrtb7aB0/Z8Z/+nyeQkppHqA==
X-Received: by 2002:a05:6808:1a17:b0:3bd:c43b:f935 with SMTP id bk23-20020a0568081a1700b003bdc43bf935mr1051159oib.9.1706003420915;
        Tue, 23 Jan 2024 01:50:20 -0800 (PST)
Received: from localhost.localdomain ([112.65.140.130])
        by smtp.googlemail.com with ESMTPSA id lp4-20020a056a003d4400b006dce766903dsm1325482pfb.90.2024.01.23.01.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 01:50:20 -0800 (PST)
From: Furong Xu <0x1207@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xfr@outlook.com,
	rock.xu@nio.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net] net: stmmac: xgmac: fix handling of DPP safety error for DMA channels
Date: Tue, 23 Jan 2024 17:50:06 +0800
Message-Id: <20240123095006.979437-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 56e58d6c8a56 ("net: stmmac: Implement Safety Features in
XGMAC core") checks and reports safety errors, but leaves the
Data Path Parity Errors for each channel in DMA unhandled at all, lead to
a storm of interrupt.
Fix it by checking and clearing the DMA_DPP_Interrupt_Status register.

Fixes: 56e58d6c8a56 ("net: stmmac: Implement Safety Features in XGMAC core")
Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h      | 1 +
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 207ff1799f2c..188e11683136 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -385,6 +385,7 @@
 #define XGMAC_DCEIE			BIT(1)
 #define XGMAC_TCEIE			BIT(0)
 #define XGMAC_DMA_ECC_INT_STATUS	0x0000306c
+#define XGMAC_DMA_DPP_INT_STATUS	0x00003074
 #define XGMAC_DMA_CH_CONTROL(x)		(0x00003100 + (0x80 * (x)))
 #define XGMAC_SPH			BIT(24)
 #define XGMAC_PBLx8			BIT(16)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index eb48211d9b0e..874e85b499e2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -745,6 +745,12 @@ static void dwxgmac3_handle_mac_err(struct net_device *ndev,
 
 	dwxgmac3_log_error(ndev, value, correctable, "MAC",
 			   dwxgmac3_mac_errors, STAT_OFF(mac_errors), stats);
+
+	value = readl(ioaddr + XGMAC_DMA_DPP_INT_STATUS);
+	writel(value, ioaddr + XGMAC_DMA_DPP_INT_STATUS);
+
+	if (value)
+		netdev_err(ndev, "Found DMA_DPP error, status: 0x%x\n", value);
 }
 
 static const struct dwxgmac3_error_desc dwxgmac3_mtl_errors[32]= {
-- 
2.34.1


