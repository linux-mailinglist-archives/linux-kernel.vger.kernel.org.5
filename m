Return-Path: <linux-kernel+bounces-34944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD123838991
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7061C20F20
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F26457894;
	Tue, 23 Jan 2024 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDaQTB+K"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3C92B9CD;
	Tue, 23 Jan 2024 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705999850; cv=none; b=Nq/Foybri0O27qXNqb1j3I1SvB6Kn1dXbLz4vZmnoPhbbcQCCkSdHwFJ/j2UOKniSCj6HZ3tElW7lq1ZfKFC/xjFccy6fSMIwpyJWH2FQ1HrPcWv6VLAKqRk3sX362EaCGzBJk2D1jlaIayK/YcAJ+qKXUaMFCso6lK7R+JGAlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705999850; c=relaxed/simple;
	bh=wLPog+0OdPWTf/vpChuci+4P8FjJPM6rI/8KZQ+nq7w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hfNB3gMX3gvEWJbEXSxQsEWaVAHJRTWr71z6GNCc9y5sTvznaCkLYu8sEwXIAi0LqYdpeUdtq8AbRXbAL2GiIhue/nCaDDPPFUMuP0OvOd/U42cgXO8lUZnGA/mnIqE1UiiiJRcwfNS9kQrv9JylL6W6Lq2GmdgRGhaXk1uT8Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDaQTB+K; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6de83f5a004so2792387a34.1;
        Tue, 23 Jan 2024 00:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705999848; x=1706604648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FNB6nZlr/06kPBlEqaF8a61wrkKCAoA4BnsL6cXaDrQ=;
        b=hDaQTB+KL5dQHp1OiEXldk3WKg0d1jvkbCh+eaWcP3c2JAF2k7v3wk0CR5SdISx3aB
         bzNmKzDSIgLwt5Ik2ka6zd/PnFZS2ugclv2VTbPJUYvQ4R7JWi7awivTSwE+uM396zuN
         jaZz9W+5E8X4eDgvk3MVqvUwwGK3m9NXp2GDMmx+0fE5RbVFI86lPuRuykKjQa/h4yah
         CYGE2++fxbpBgQmk8vAjieRVj96k2Zki3STreNGDUGY0gW0fBPiR8XXp7wGbB7fmHrXW
         lqbEsSDvt/XSwvexyldaF3ArhHx5nJjTtQyeizajiWhQ+thYB1T3c+RCGAgFKwU+JjpU
         M8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705999848; x=1706604648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNB6nZlr/06kPBlEqaF8a61wrkKCAoA4BnsL6cXaDrQ=;
        b=NLOpQnSkQ/A92wUQqWGUv7EvRnGQ5q99xuLTMLnsYuWkOnJ/k1/JGLYW+WLb9yvTcX
         5bHco7quLyktKwS0W1iD8dGnQFmkG4FibD01qrELLLh4rAjIw5gjAv9D2FeL2RdZYZeW
         MHhqwPDb+TfNvsCU1dSQ32dLgT3tMlDtc3LGF242cJ7GANrEIxOe2SlGIp6YUvm8bZZ6
         7a/Wo9TXlw5TPtoEGsd9QehIp0/PZITxKkXuzYo192YNo0L804mLrc6QKXt3wBZ11QDs
         ZOq/OFnhjR+XwAenkl0Ejq+eghzT/0R0wvf2tUFI7hBHE4ppQpivSznTmg2lUE50Ipvm
         GVUg==
X-Gm-Message-State: AOJu0YxKf3TfD0nmT9Oj5kgBpHByUkrvjDpEtuzjXOoNObUcTtWtfVMr
	BjXtwvS1u8Fi/tmddQtn62stxLBrsC72WGmzh7SsLiaEimDNYr3Z
X-Google-Smtp-Source: AGHT+IHRKZzHqJsuxlpfoRfWi87C1N58CDPLVDywt+3AVD3QL8TKT2ebBbKukW0im0MhyVmjRuztlw==
X-Received: by 2002:a05:6830:1e2d:b0:6dc:8dfb:3a86 with SMTP id t13-20020a0568301e2d00b006dc8dfb3a86mr5969046otr.15.1705999847791;
        Tue, 23 Jan 2024 00:50:47 -0800 (PST)
Received: from localhost.localdomain ([112.65.140.130])
        by smtp.googlemail.com with ESMTPSA id w70-20020a638249000000b005cf88b016cesm9626322pgd.72.2024.01.23.00.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 00:50:47 -0800 (PST)
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
Subject: [PATCH net] net: stmmac: xgmac: fix safety error descriptions
Date: Tue, 23 Jan 2024 16:50:37 +0800
Message-Id: <20240123085037.939471-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 56e58d6c8a56 ("net: stmmac: Implement Safety Features in
XGMAC core") prints safety error descriptions when safety error assert,
but missed some special errors, and mixed correctable errors and
uncorrectable errors together.
This patch complete the error code list and print the type of errors.

Fixes: 56e58d6c8a56 ("net: stmmac: Implement Safety Features in XGMAC core")
Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index eb48211d9b0e..ad812484059e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -748,29 +748,29 @@ static void dwxgmac3_handle_mac_err(struct net_device *ndev,
 }
 
 static const struct dwxgmac3_error_desc dwxgmac3_mtl_errors[32]= {
-	{ true, "TXCES", "MTL TX Memory Error" },
+	{ true, "TXCES", "MTL TX Memory Correctable Error" },
 	{ true, "TXAMS", "MTL TX Memory Address Mismatch Error" },
-	{ true, "TXUES", "MTL TX Memory Error" },
+	{ true, "TXUES", "MTL TX Memory Uncorrectable Error" },
 	{ false, "UNKNOWN", "Unknown Error" }, /* 3 */
-	{ true, "RXCES", "MTL RX Memory Error" },
+	{ true, "RXCES", "MTL RX Memory Correctable Error" },
 	{ true, "RXAMS", "MTL RX Memory Address Mismatch Error" },
-	{ true, "RXUES", "MTL RX Memory Error" },
+	{ true, "RXUES", "MTL RX Memory Uncorrectable Error" },
 	{ false, "UNKNOWN", "Unknown Error" }, /* 7 */
-	{ true, "ECES", "MTL EST Memory Error" },
+	{ true, "ECES", "MTL EST Memory Correctable Error" },
 	{ true, "EAMS", "MTL EST Memory Address Mismatch Error" },
-	{ true, "EUES", "MTL EST Memory Error" },
+	{ true, "EUES", "MTL EST Memory Uncorrectable Error" },
 	{ false, "UNKNOWN", "Unknown Error" }, /* 11 */
-	{ true, "RPCES", "MTL RX Parser Memory Error" },
+	{ true, "RPCES", "MTL RX Parser Memory Correctable Error" },
 	{ true, "RPAMS", "MTL RX Parser Memory Address Mismatch Error" },
-	{ true, "RPUES", "MTL RX Parser Memory Error" },
+	{ true, "RPUES", "MTL RX Parser Memory Uncorrectable Error" },
 	{ false, "UNKNOWN", "Unknown Error" }, /* 15 */
-	{ false, "UNKNOWN", "Unknown Error" }, /* 16 */
-	{ false, "UNKNOWN", "Unknown Error" }, /* 17 */
-	{ false, "UNKNOWN", "Unknown Error" }, /* 18 */
+	{ true, "SCES", "MTL SGF GCL Memory Correctable Error" },
+	{ true, "SAMS", "MTL SGF GCL Memory Address Mismatch Error" },
+	{ true, "SUES", "MTL SGF GCL Memory Uncorrectable Error" },
 	{ false, "UNKNOWN", "Unknown Error" }, /* 19 */
-	{ false, "UNKNOWN", "Unknown Error" }, /* 20 */
-	{ false, "UNKNOWN", "Unknown Error" }, /* 21 */
-	{ false, "UNKNOWN", "Unknown Error" }, /* 22 */
+	{ true, "RXFCES", "MTL RXF Memory Correctable Error" },
+	{ true, "RXFAMS", "MTL RXF Memory Address Mismatch Error" },
+	{ true, "RXFUES", "MTL RXF Memory Uncorrectable Error" },
 	{ false, "UNKNOWN", "Unknown Error" }, /* 23 */
 	{ false, "UNKNOWN", "Unknown Error" }, /* 24 */
 	{ false, "UNKNOWN", "Unknown Error" }, /* 25 */
@@ -796,13 +796,13 @@ static void dwxgmac3_handle_mtl_err(struct net_device *ndev,
 }
 
 static const struct dwxgmac3_error_desc dwxgmac3_dma_errors[32]= {
-	{ true, "TCES", "DMA TSO Memory Error" },
+	{ true, "TCES", "DMA TSO Memory Correctable Error" },
 	{ true, "TAMS", "DMA TSO Memory Address Mismatch Error" },
-	{ true, "TUES", "DMA TSO Memory Error" },
+	{ true, "TUES", "DMA TSO Memory Uncorrectable Error" },
 	{ false, "UNKNOWN", "Unknown Error" }, /* 3 */
-	{ true, "DCES", "DMA DCACHE Memory Error" },
+	{ true, "DCES", "DMA DCACHE Memory Correctable Error" },
 	{ true, "DAMS", "DMA DCACHE Address Mismatch Error" },
-	{ true, "DUES", "DMA DCACHE Memory Error" },
+	{ true, "DUES", "DMA DCACHE Memory Uncorrectable Error" },
 	{ false, "UNKNOWN", "Unknown Error" }, /* 7 */
 	{ false, "UNKNOWN", "Unknown Error" }, /* 8 */
 	{ false, "UNKNOWN", "Unknown Error" }, /* 9 */
-- 
2.34.1


