Return-Path: <linux-kernel+bounces-115399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5C68893C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69EA91F30A91
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5CF2002F8;
	Mon, 25 Mar 2024 02:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uy5fPtQJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09EC86AE7;
	Sun, 24 Mar 2024 22:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320712; cv=none; b=fKSqebyry34AM5KdgldlUCzySHJKtO3oM848PzQAqzcopwQ0w/y9+s1RecZvsZ3QS9VrmE1D4xUWLLv7ChJy6Khk+D0oaB5TbgMzlkDGaVV8lyRzVAPdG374r7YVHzBfJOwUm5pJPDj35P/PWR4dmvQZfwYKAo1Ay1uyUJiOLtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320712; c=relaxed/simple;
	bh=PbpkDc8dLHMQIvOluxNUHwM9KODFcmsFc6mIGPXsU6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqI2yGYtHrUbFIpGCxwRdtCBCmrg5dbGDddjO24ovyETuWEYwuf+FU5YqNJFB0zPNwUwOq6VKEGnTk27gh8g8hu4bQr+Vns7aoVEGDf4+Z+61TfATFBx9jN7lXjauxmdVJEi9bTXNkx4QFb0daIs7+69KK+pIeuIhhTKbrY7b0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uy5fPtQJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EFBC43394;
	Sun, 24 Mar 2024 22:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320711;
	bh=PbpkDc8dLHMQIvOluxNUHwM9KODFcmsFc6mIGPXsU6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uy5fPtQJZ9mYW4QXhIm0NyCv8uTepDew5ZaGGfWDMcUzhCMsuJBp+V0hWlMCCr6BZ
	 FPStoh05asbw5JY4XuqgFGybR84QufMMLQ3TelJsl17rQkMDakV7XnxE+UyHtLNpP3
	 TJU9taLuBBCvWq5NSRQ/twIpPlXyzidxuHuTc9ONJKbCjs4n7Y39SMYbQABtbSZi81
	 64TahnByG9JoriqGYwb1898I1SuIm0zSSeJqYx5En9lto6nykfknJGGSgEuyZT35aN
	 K4FsOJYBLmbkJ+f9tuYmlzWvjWoA2WnzBXl5AAi8DGm2HrGV/g8wj9vSO01H2F46JI
	 tDr7qMaIAzLjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Judith Mendez <jm@ti.com>,
	Wadim Egorov <w.egorov@phytec.de>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 274/713] arm64: dts: ti: k3-am64-main: Fix ITAP/OTAP values for MMC
Date: Sun, 24 Mar 2024 18:40:00 -0400
Message-ID: <20240324224720.1345309-275-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index c3300c36fdbcb..45042216e5b89 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -623,6 +623,9 @@ sdhci0: mmc@fa10000 {
 		ti,otap-del-sel-mmc-hs = <0x0>;
 		ti,otap-del-sel-ddr52 = <0x6>;
 		ti,otap-del-sel-hs200 = <0x7>;
+		ti,itap-del-sel-legacy = <0x10>;
+		ti,itap-del-sel-mmc-hs = <0xa>;
+		ti,itap-del-sel-ddr52 = <0x3>;
 		status = "disabled";
 	};
 
@@ -635,12 +638,16 @@ sdhci1: mmc@fa00000 {
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


