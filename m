Return-Path: <linux-kernel+bounces-114130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 000B188889D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94909B22E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91804240890;
	Sun, 24 Mar 2024 23:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2ozOJYT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EE3202BA2;
	Sun, 24 Mar 2024 23:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321439; cv=none; b=oC1wWJK0Yjq7ML5a+CYNo1JWn3YqobYQta0Zs+mtKTcaLILDSiCAtMC++JQrtIqdb0PBDddDWaYxsT46kZJxQD1j+oFZEQPStKZo99Ny8zvxAcV1X9pHCnKhpllXZxuMRRyYJHdFxs/FgUWznWFRgevTnreV4A6SgN+qFV15tRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321439; c=relaxed/simple;
	bh=aMDo02VAK1zjVAZyROahyTo3LEtSa9UVeeqPFxBRTII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVbVQwZI8p72TDvnkoT6bqIfXHdAwiMsI3BZyF4qIrq6gecZlCPAkHv86LcTiPnYKfN5eYWdbbFWI7UTudXtOG0YLybHnYanPMRPtehuWXJ0XnVnVHx970kFkomDQtt61izGCYvfixkppDfxwxjUBrEgPVyL5Oa35qdWuq4p7ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2ozOJYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A515C43399;
	Sun, 24 Mar 2024 23:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321438;
	bh=aMDo02VAK1zjVAZyROahyTo3LEtSa9UVeeqPFxBRTII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O2ozOJYTxmnVJiX/aCYDuYkL7J1ACnXzolPs8VUScMiJjI5WYeQTbytUUA4sUqgg7
	 l8IMnAuSXNa4/PNTzPnGSd4v57xZVfqP5nQ8akevBVXLM9iUYjtbPr6Bf7t/TLRwXm
	 rOwVeocxt9QY1OyPIPVtK2mc/1QEy3UedEavEJAsepSZZY2J5lKelvF375xsBVwCEt
	 Rmg+HzEQSJkxsz6gRhIzZzZFLY2XVGmbMDjIOSinFySX0inQhQ7XBpPSzjGRsmPJcl
	 cGgRwDrg2gK+OZAkiQ+43aiFCKmuRJc3FyVUgcQ+PQNTn93bQtY61n9u8kBXxLbwvG
	 mwZkCTAq99GVA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 162/638] arm64: dts: imx8mm-kontron: Fix interrupt for RTC on OSM-S i.MX8MM module
Date: Sun, 24 Mar 2024 18:53:19 -0400
Message-ID: <20240324230116.1348576-163-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Frieder Schrempf <frieder.schrempf@kontron.de>

[ Upstream commit 8d0f39b7d04d864e89b84063b124fd10aa4b8809 ]

The level of the interrupt signal is active low instead. Fix this.

Fixes: de9618e84f76 ("arm64: dts: Add support for Kontron SL/BL i.MX8MM OSM-S")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
index 3e7db968f7e64..60abcb636cedf 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
@@ -210,7 +210,7 @@ rv3028: rtc@52 {
 		reg = <0x52>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_rtc>;
-		interrupts-extended = <&gpio4 1 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts-extended = <&gpio4 1 IRQ_TYPE_LEVEL_LOW>;
 		trickle-diode-disable;
 	};
 };
-- 
2.43.0


