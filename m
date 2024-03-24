Return-Path: <linux-kernel+bounces-113093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F41888168
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C96287596
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37FF152E14;
	Sun, 24 Mar 2024 22:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7Phdmpw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E41E153BCD;
	Sun, 24 Mar 2024 22:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319901; cv=none; b=HXlluRs0JUiKE1TabZ3+EY3UCkiCEWpYK8wfnSVGzWAQySSihUp/U8opDIbHletyyK9zyd4M3nKM/WvM0U1cWLzLP6jQ2xYyCGuXgX1K91HdLCBkHGIh+/Ku3nIDcnNqtxIfQCvbfplE6AAq7lvZmmApfzoNJE49TRtMXb3DkYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319901; c=relaxed/simple;
	bh=o1pdNCELQ9oh009glihFufrf0sK75GE00e/ZC4Jg/QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cv/dvxVkBh+Bv0qLGhcpFAJnwlfeCTRcl+8AVRvsQwBpFeVQ2MeXCS/OaRGkj8LAlXB2nX2TB2vUkqDkyVTyzygE088uI7grCyiswDwxr8TPyuT+AJ2cgEtddkjrtVPya+KWgI8I1fPUObexLe9OhFLB2xetcgrh113Alyh562o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7Phdmpw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61823C43394;
	Sun, 24 Mar 2024 22:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319901;
	bh=o1pdNCELQ9oh009glihFufrf0sK75GE00e/ZC4Jg/QU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p7PhdmpwEosxNfvFWbcj5DSLcAAnhrMMLDRlVisYkvPaOZ+9mwBq0iYlSjBgkSM78
	 18SX+7xY+qZ6Lbut3V0acg6pMr+9hWn4/LxHGZnBuuubasGF7nijKRHWPS7y2KXHCP
	 MH753hoPtVtyktjkjQ+yfPXHQ1DtZOULN16PL8p8lAtvGEah7kcKppcC78TGA8PXhE
	 a2x/wrAitBRuovDF3+fsSDlNKqjgL+Rlr0Wewxi6EtfJEAm+ZFX8g3milxB+QG5hKs
	 WOCN05bSjTD/NW8JLpl0CxEHSGH9QhQtjCXg2Sr1yTUVZbkb4ia2mhSVt9mTw3DF42
	 S61iKDI3obJzQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Romain Naour <romain.naour@smile.fr>,
	Neha Malcom Francis <n-francis@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 206/715] arm64: dts: ti: k3-am69-sk: fix PMIC interrupt number
Date: Sun, 24 Mar 2024 18:26:25 -0400
Message-ID: <20240324223455.1342824-207-sashal@kernel.org>
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

From: Romain Naour <romain.naour@smile.fr>

[ Upstream commit c205595e3b708c36ef2d7609b9182c6729bb06ae ]

The tps659413 node set WKUP_GPIO0_83 (AA37) pin as input to be used as
PMIC interrupt but uses 39 (WKUP_GPIO0_39) as "interrupts" property.

Replace 39 by 83 after checking in the board schematic [1].

[1] https://www.ti.com/tool/SK-AM69

Fixes: 865a1593bf99 ("arm64: dts: ti: k3-am69-sk: Add support for TPS6594 PMIC")
Cc: Neha Malcom Francis <n-francis@ti.com>
Signed-off-by: Romain Naour <romain.naour@smile.fr>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Link: https://lore.kernel.org/r/20240209171146.307465-1-romain.naour@smile.fr
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 370980eb59b02..c8fb9dfb89723 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -646,7 +646,7 @@ tps659413: pmic@48 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pmic_irq_pins_default>;
 		interrupt-parent = <&wkup_gpio0>;
-		interrupts = <39 IRQ_TYPE_EDGE_FALLING>;
+		interrupts = <83 IRQ_TYPE_EDGE_FALLING>;
 		gpio-controller;
 		#gpio-cells = <2>;
 		ti,primary-pmic;
-- 
2.43.0


