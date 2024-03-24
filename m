Return-Path: <linux-kernel+bounces-113700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDD888861C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6A02915B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3628E128818;
	Sun, 24 Mar 2024 22:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3hn51Qf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E758625F;
	Sun, 24 Mar 2024 22:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320679; cv=none; b=WAspMu2R2sPX89FwY0gfS73dJjVthfzINW3vgbv7KpfD6AS/aT5UWDDws/BVemhvn0ELAKvwPyKtQ8IrWEOkr2T7ESjsR1PhqhR8tZiHZq3+s9oe2VqVmgAQkHdvseTSfREbfkw4omd25VxA1IdjH8B+CrUvjKvGDZF3WHvRBbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320679; c=relaxed/simple;
	bh=6IAXt7kg0mXsg5guh9sUHvOjMA33teZAxvgBy5cfGJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bNqg2V9qfPNv5G3nD1neaxdj40R398im0UKQAfIVJIje8ucuy+BtewxM7jZ6PDzM/2tIFydsVL2UC5lPVaTj3HECEh/jiQG9V6aqy76zEOQbtSPY7zRVlBEGiUaIEMrm6WlDM0s6YfL2Gx6x5L+ob0gwDNDccvgdsJjfJ8yzUp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3hn51Qf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5C2C433C7;
	Sun, 24 Mar 2024 22:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320678;
	bh=6IAXt7kg0mXsg5guh9sUHvOjMA33teZAxvgBy5cfGJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j3hn51Qfo+yztoqJKFj2MBZgtLy9/O42hTDMJlXYvG7innPdKirZPVPVq0ScF9DRC
	 C9KRXlM0iI5u7PzL5iYfAEaXjnuMDWOEKD2S6RocXxvxAhaju72erIFLaGG8f7Jq3C
	 n2n2hyxCZMrWsqVlaXJw8Fwu6gwQWqTtSS7DIv+uKBRRCRBF9Ahc7287nbR0Su9YhS
	 WrckfKyKLl+IMPQSvpMp2jUem3FLF2OJbxgmcmWQyPrUmceY7Dp596grvuQFh94V1/
	 y7Tr17RalplBykXLVfP8hzB4TT9EXqINQ0X8TSGxRZ4114oZIDC7A9wtSi0T5el6n4
	 RMwhgseBU9yVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 240/713] arm64: dts: mediatek: mt7986: fix SPI nodename
Date: Sun, 24 Mar 2024 18:39:26 -0400
Message-ID: <20240324224720.1345309-241-sashal@kernel.org>
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


