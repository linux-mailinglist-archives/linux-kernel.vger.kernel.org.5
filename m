Return-Path: <linux-kernel+bounces-113108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 990FB888184
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E6C1C21A62
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652A91586F2;
	Sun, 24 Mar 2024 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rcedlwfc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CB71586DB;
	Sun, 24 Mar 2024 22:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319915; cv=none; b=nyYZ7mXeKsgL3iMOAwhC37oZ5yUDJi25uYzcaXUKzcgerVxlaZ3uYnE6UB0To2G26ApZ8SpVfMRzTHVlJBuT3efen7SXs+ZacKx2BWe51y83BPvjBmeGNV2dMNwvKD/x79pVd9nBkSp9gnkPeKtcbS7KePRryZLC/kxHCR7RDgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319915; c=relaxed/simple;
	bh=hgKXfShRnwipZ+Km/9JNBJH4+qiU82rIGPcSvqOOfTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXHJyDA21WXlvhcNrG8fGvQlpCDeopVkGczlrAsCDwbfZcHfi7eD/rhxnIzxic4OZs95hnYKY54sjVW11q/pCqG55bg7nzv/HCPQUUeGFGR5L1toAaX6XtVqphC6siEMBC0qTQV//3eSA7hRtKqcpgvWtMZJHJGfN6KeLuJAMKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rcedlwfc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE79BC433C7;
	Sun, 24 Mar 2024 22:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319915;
	bh=hgKXfShRnwipZ+Km/9JNBJH4+qiU82rIGPcSvqOOfTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RcedlwfcHitWfKYyZkYc1E9pcG5ETATo58m578/bOwVNJyzM8d/+K16lr8TsKIQpm
	 INNDy4pi9QMica8SJ6XL2GSUGkQnyHzijHSAIzjPGnAoUkTBOufFGzE9C89de20AIK
	 G0and/efekhaOVBuMAjCR24IBlYncpvpn9cYXiFGo9GW8haXMQmDfGOafAejOr4pJF
	 Fg5Z5o8g1dAs3da7QFkKU5UnzQ67mvdM0f0ryAmifrMceAOQBFKkgsFrJNq3Zx7aZ4
	 6UaqR1mHwBT12Yh9JCXEsT7hdS2LDrmeM/16Xr0OpLKNjsCSUNq50OwcWHAtOkE6NC
	 iCJ/SB4JkSxwA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Judith Mendez <jm@ti.com>,
	Wadim Egorov <w.egorov@phytec.de>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 221/715] arm64: dts: ti: k3-am64-main: Fix ITAP/OTAP values for MMC
Date: Sun, 24 Mar 2024 18:26:40 -0400
Message-ID: <20240324223455.1342824-222-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Judith Mendez <jm@ti.com>

[ Upstream commit 379c7752bbd0e81654544a896dd19c19ebb6faba ]

Update MMC0/MMC1 OTAP/ITAP values according to the datasheet
[0], refer to Table 7-68 for MMC0 and Table 7-77 for MMC1.

[0] https://www.ti.com/lit/ds/symlink/am6442.pdf

Fixes: 8abae9389bdb ("arm64: dts: ti: Add support for AM642 SoC")
Signed-off-by: Judith Mendez <jm@ti.com>
Tested-by: Wadim Egorov <w.egorov@phytec.de>
Link: https://lore.kernel.org/r/20240213235701.2438513-5-jm@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index e348114f42e01..ba624ef72f5b4 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -633,6 +633,9 @@ sdhci0: mmc@fa10000 {
 		ti,otap-del-sel-mmc-hs = <0x0>;
 		ti,otap-del-sel-ddr52 = <0x6>;
 		ti,otap-del-sel-hs200 = <0x7>;
+		ti,itap-del-sel-legacy = <0x10>;
+		ti,itap-del-sel-mmc-hs = <0xa>;
+		ti,itap-del-sel-ddr52 = <0x3>;
 		status = "disabled";
 	};
 
@@ -645,12 +648,16 @@ sdhci1: mmc@fa00000 {
 		clock-names = "clk_ahb", "clk_xin";
 		ti,trm-icp = <0x2>;
 		ti,otap-del-sel-legacy = <0x0>;
-		ti,otap-del-sel-sd-hs = <0xf>;
+		ti,otap-del-sel-sd-hs = <0x0>;
 		ti,otap-del-sel-sdr12 = <0xf>;
 		ti,otap-del-sel-sdr25 = <0xf>;
 		ti,otap-del-sel-sdr50 = <0xc>;
 		ti,otap-del-sel-sdr104 = <0x6>;
 		ti,otap-del-sel-ddr50 = <0x9>;
+		ti,itap-del-sel-legacy = <0x0>;
+		ti,itap-del-sel-sd-hs = <0x0>;
+		ti,itap-del-sel-sdr12 = <0x0>;
+		ti,itap-del-sel-sdr25 = <0x0>;
 		ti,clkbuf-sel = <0x7>;
 		status = "disabled";
 	};
-- 
2.43.0


