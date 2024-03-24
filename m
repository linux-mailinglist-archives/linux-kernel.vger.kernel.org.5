Return-Path: <linux-kernel+bounces-113073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E793888140
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606FB1C215C4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFBD14A4E2;
	Sun, 24 Mar 2024 22:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbf7ISbz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAE914A4C8;
	Sun, 24 Mar 2024 22:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319881; cv=none; b=CtdOm5AxFUyndLGsM4fMpmndZCmp1PdApKbSwQRGEmkQYz1uM+lCOWEynDw5BJE5QFIqTZkizoyiKmVceNzrUfQT1zswb9Mk5oXH6IR0HnHva1aGt0nMNB9TiZX0VVtHQEu50J8lRiT7ol0PEHAskHWduoawfpNpNmSYHA2Ez0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319881; c=relaxed/simple;
	bh=6IAXt7kg0mXsg5guh9sUHvOjMA33teZAxvgBy5cfGJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8C/fMhubu8QyNWEM6XLIGLQ+Eo28p5pPmGmwzuebz1uLe81pR8acb8XxRJarOYMi1g7kiaHa/6jjPlpd02nvMo9xFPouAsAS0QweP8s04WwRwiBkiqULNr0fuCa4okH1mOom5wtdD5dfPUyhhLa1ED0cEiO8idHENBvtvrxCjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbf7ISbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2E5C43390;
	Sun, 24 Mar 2024 22:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319881;
	bh=6IAXt7kg0mXsg5guh9sUHvOjMA33teZAxvgBy5cfGJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lbf7ISbzATtWWAVDrbpGLTwN4H9334JuduvA8udVlqCpGf6bT97KNJ3KI33WmLU6b
	 d5eD5L/mnf4PyDVQ8IEWTVbAjE01aXDJLFFRiN8opjNJMrz8xL2Mgu4HuR+cvKYvZC
	 rzS5ThV0J9xz01/6U/HR5Mvt4aVCG34vAfJ3qjxtJS419UqtEoVA9MH7B8hgBvGSHP
	 FKWb+tBvH7UXvZzQM1j2pDzcnjZRBnePx8nIf/7fVzeUP1R2OQWzXbQkCgFP+a/3pB
	 ubjwxStpFCvS3dXg76dJubZ/M3cJi254J4pqH9EW1wtMBSmmrond43RN25ibB+6j+k
	 64ciw2OdnFZVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 186/715] arm64: dts: mediatek: mt7986: fix SPI nodename
Date: Sun, 24 Mar 2024 18:26:05 -0400
Message-ID: <20240324223455.1342824-187-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


