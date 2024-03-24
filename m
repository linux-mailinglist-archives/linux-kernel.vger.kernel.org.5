Return-Path: <linux-kernel+bounces-113699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D201A888E4C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0C91C2AFFA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631B6146D60;
	Sun, 24 Mar 2024 22:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0Wx3fBT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199DA1DA15E;
	Sun, 24 Mar 2024 22:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320678; cv=none; b=HKUdGgiu8KdPw3LCN6xXW4XjN60CoqcWbQo35mUZr1yKaq0I2fYMBUsn6+l1v7qVJ0lJIqf0NlHT1j3wCM5VHMKbj5cYJAZPGOXp+CNfwwuf/VzJ6gcaj63Fan4j41l+ulJZ0FUXSTOg9P5S6d93qfg4RO+2y/JWREcX2Llb4NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320678; c=relaxed/simple;
	bh=dX+p9aq8ZTnlef2Gmg+V8hnuIMD3+xTYM25f1+TPgKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVrDVtnUmMRx4Fr9V4p3Z9/yRxl6gfO/ZBEeKck/UFia/YMoH+VC7KYRhCilrBQz9WuLmw5ZNHybrkLiCAjfAw7UPfZe0YFNw5z3eM2ERgkFMKRzaGV004J5hvKAJTzbhP11L4dTi+K+FIB2bhDEWZmR9OcUxnbA8i/00IH+5KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0Wx3fBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44449C433F1;
	Sun, 24 Mar 2024 22:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320677;
	bh=dX+p9aq8ZTnlef2Gmg+V8hnuIMD3+xTYM25f1+TPgKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i0Wx3fBTubs4l3w6cbaS8FLb15ItrD5wZJ6wL4tYcaRU3nrRKJL6aWoQ3varAHBkn
	 mddtYmS/ZGdx8EX072nQ+k1H0Gh8Mny7mlHy/5eS4LmCK4Nobs9AWXZRVbvHuBL4QB
	 Jt+GWKyjzSWKEa7qPoLISmUDtPVMNwMKkkKFXF1WdBX9RHGet6tv5JE7brHtIMzE1I
	 knnv9psJUjcPsq1HROfQ1UzMJ7UTYO4gBKER92JuYSGT1hSEtmtTQE25oHVFhnhpF6
	 HwSmE3lE6kuIlEW73KgBQU7aeVUbJuSCUi0eSq3GUpFXUwMNHjYPEeykOUtkpuDXKe
	 WFIbi0+AFRSWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 239/713] arm64: dts: mediatek: mt7986: fix SPI bus width properties
Date: Sun, 24 Mar 2024 18:39:25 -0400
Message-ID: <20240324224720.1345309-240-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

[ Upstream commit 4e7dc18a753cec130b06f1ddbae10ea9dcfb1723 ]

This fixes SPI setup and resolves following validation errors:
arch/arm64/boot/dts/mediatek/mt7986a-rfb.dtb: spi_nand@0: Unevaluated properties are not allowed ('spi-rx-buswidth', 'spi-tx-buswidth' were unexpected)
        from schema $id: http://devicetree.org/schemas/mtd/spi-nand.yaml#
arch/arm64/boot/dts/mediatek/mt7986b-rfb.dtb: spi_nand@0: Unevaluated properties are not allowed ('spi-rx-buswidth', 'spi-tx-buswidth' were unexpected)
        from schema $id: http://devicetree.org/schemas/mtd/spi-nand.yaml#

Fixes: 885e153ed7c1 ("arm64: dts: mt7986: add spi related device nodes")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20231116130952.5099-1-zajec5@gmail.com
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 4 ++--
 arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
index 3ef371ca254e8..bcb3ebb85d708 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
@@ -241,8 +241,8 @@ spi_nand: spi_nand@0 {
 		compatible = "spi-nand";
 		reg = <0>;
 		spi-max-frequency = <10000000>;
-		spi-tx-buswidth = <4>;
-		spi-rx-buswidth = <4>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
index dde190442e386..48fe50e671779 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
@@ -156,8 +156,8 @@ spi_nand: spi_nand@0 {
 		compatible = "spi-nand";
 		reg = <0>;
 		spi-max-frequency = <10000000>;
-		spi-tx-buswidth = <4>;
-		spi-rx-buswidth = <4>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
 	};
 };
 
-- 
2.43.0


