Return-Path: <linux-kernel+bounces-114157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E65C8888C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60AF81C27A50
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508A7204E23;
	Sun, 24 Mar 2024 23:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjJmXDkV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A407A2057C7;
	Sun, 24 Mar 2024 23:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321484; cv=none; b=qladXDbA/RYF0oXcAuiya1I+VGjCLS8iso/m7epC8kBmHMIZdC/FF13UorHYjz5wkbNXSHgLr0Ssilaj/JJjLwrhR2EXcLCeNZRdX9bSwDaOWQiIyGPfwu+h16lbs6+NHwCqRzy6ssTLN9PKRVPMc5pbQZZesFzsOj1trkCIIMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321484; c=relaxed/simple;
	bh=6IAXt7kg0mXsg5guh9sUHvOjMA33teZAxvgBy5cfGJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jGGRRegwVhqoA8vlAiQa9KPwUVbihKf3vdM/4UJDHFy9Coq5X5iJsvF9Sv8lg7FBNgnuFsiOB22I2hFP9F8slKltFoUbpD3nDF6qekQ9csyZplpZtTdmkiN/XSnlf/rh2YWKTP+/7uHyr6AyQv9dLFnbFFoMvmXPaLhOBpIwz34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjJmXDkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B21C433F1;
	Sun, 24 Mar 2024 23:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321483;
	bh=6IAXt7kg0mXsg5guh9sUHvOjMA33teZAxvgBy5cfGJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DjJmXDkVs7Qe6p41QCmrcUqxesHTYUNHXgsDIddSNKI/JqnUZJZIx4XpbQ4U68xsD
	 NJ9d+Sn1D8Nke3jugtH2fPbtJlqausuPMbcp9xa5QdISVRlJLDENkiITQ9avYB9wgZ
	 jeEHbxiOtkjq5GphGbi4G8AV/eLUtJ9hlt2POQa0zpcXyD9ecujfo2ryBNCbF0OdTZ
	 vQy2YeSYXUOT8Bsb+qlwEISAIwYcOvFodMep0w8+gQpnsh4lH1eoVd7Rd47+MsJ1dE
	 smZbIyHUwnVuDeZlIeTDFLG/UNuvT1NDjC5ATT9GI8SrQyQEMBDVaZq2XBG0DS5gXG
	 71LqQe5rZQ35g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 208/638] arm64: dts: mediatek: mt7986: fix SPI nodename
Date: Sun, 24 Mar 2024 18:54:05 -0400
Message-ID: <20240324230116.1348576-209-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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

[ Upstream commit bbe266c70e1343ee3e71ca31138141b3da265085 ]

This fixes following validation errors:
arch/arm64/boot/dts/mediatek/mt7986a-rfb.dtb: spi_nand@0: $nodename:0: 'spi_nand@0' does not match '^(flash|.*sram|nand)(@.*)?$'
        from schema $id: http://devicetree.org/schemas/mtd/spi-nand.yaml#
arch/arm64/boot/dts/mediatek/mt7986b-rfb.dtb: spi_nand@0: $nodename:0: 'spi_nand@0' does not match '^(flash|.*sram|nand)(@.*)?$'
        from schema $id: http://devicetree.org/schemas/mtd/spi-nand.yaml#

Fixes: 885e153ed7c1 ("arm64: dts: mt7986: add spi related device nodes")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20231116130952.5099-2-zajec5@gmail.com
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 3 ++-
 arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
index bcb3ebb85d708..2f884c24f1eb4 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
@@ -237,7 +237,8 @@ &spi0 {
 	pinctrl-0 = <&spi_flash_pins>;
 	cs-gpios = <0>, <0>;
 	status = "okay";
-	spi_nand: spi_nand@0 {
+
+	spi_nand: flash@0 {
 		compatible = "spi-nand";
 		reg = <0>;
 		spi-max-frequency = <10000000>;
diff --git a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
index 48fe50e671779..57dcaeef31d7f 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
@@ -152,7 +152,8 @@ &spi0 {
 	pinctrl-0 = <&spi_flash_pins>;
 	cs-gpios = <0>, <0>;
 	status = "okay";
-	spi_nand: spi_nand@0 {
+
+	spi_nand: flash@0 {
 		compatible = "spi-nand";
 		reg = <0>;
 		spi-max-frequency = <10000000>;
-- 
2.43.0


