Return-Path: <linux-kernel+bounces-113157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630828881EB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3437B23B95
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13A2172BC1;
	Sun, 24 Mar 2024 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgLLEx3x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1572C172BA0;
	Sun, 24 Mar 2024 22:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319960; cv=none; b=mI075z/Jq2dJOnMAD+6A5Y7XycshMQ8h1Lecr8bVSLwwbn/NSADrrtpowkiEPUiKKGc7D4hdc0k6BqRzF5LUEbCcBfzFsOqxZyCKnvrYMYaBA78hH+nvLeE/5BSv4ge4pkqobOqwgcNM73o5UO+hZ4IzGBN/8mcs9bUNLJNNlLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319960; c=relaxed/simple;
	bh=+I604YvrVbmBP/fR3nTzqZgyNQVHXkAtJ9TyLm1Qv1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JaSG1GM9j/GRNBb5xjGkL+JpxfnewdDxuQeSun60J2GVBuuxQdwVva6U3Wxun6lOgsoXNQwBGeFDFWxnPjVLG2ef8qQkDX3l29SIw74uxPejXv/Hm/pTYPTz5CbMyAes/l4NMPisZBtR1OteLl2XYK2ep7KGxxK4PKJbq3dd6fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgLLEx3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC79C433F1;
	Sun, 24 Mar 2024 22:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319959;
	bh=+I604YvrVbmBP/fR3nTzqZgyNQVHXkAtJ9TyLm1Qv1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rgLLEx3x+fIsFzjvQHaxeVNVAsVIbli3vRIQ06zyled5OH10upNjeUCKB6bc1z2Z8
	 7FjmCA2ExFzgIu6LP1YYIVjfxtvJfjfuJufCI3GYV91HK69qQ+oJqYsVBHWmnvU4pz
	 O4z5ODMBhfqBZ8RkJj6Q/JyRLDOs9dbwkM+R5BFQDUvoOmVbAFIvD7b+WZ6j6W65Wk
	 Ppzo69wFjAoBL+mgugPTAX1kqIuhppHx4n3f4c3yu/dEqsvW23XQoHRgLorJIg5BeE
	 /j7sOw6dlIIuGW3p2stbgfsnvpzGJvBLHMb6crNyLVTczFjTYnxu+gsfrMztiJpvCn
	 rSQScU5pL/SZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 266/715] arm64: dts: imx8mp: Set SPI NOR to max 40 MHz on Data Modul i.MX8M Plus eDM SBC
Date: Sun, 24 Mar 2024 18:27:25 -0400
Message-ID: <20240324223455.1342824-267-sashal@kernel.org>
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

From: Marek Vasut <marex@denx.de>

[ Upstream commit 13ab6f174a6b577bd7d09124b47ec8ace2682e42 ]

The SPI NOR bus routing on this board cannot go above 50 MHz,
set the clock frequency to maximum of 40 MHz to be within a
safe margin. Remove the comment as well.

Fixes: 562d222f23f0 ("arm64: dts: imx8mp: Add support for Data Modul i.MX8M Plus eDM SBC")
Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts b/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
index 5828c9d7821de..b5ce7b14b5434 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
@@ -121,7 +121,7 @@ &ecspi1 {
 	flash@0 {	/* W25Q128JVEI */
 		compatible = "jedec,spi-nor";
 		reg = <0>;
-		spi-max-frequency = <100000000>;	/* Up to 133 MHz */
+		spi-max-frequency = <40000000>;
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <1>;
 	};
-- 
2.43.0


