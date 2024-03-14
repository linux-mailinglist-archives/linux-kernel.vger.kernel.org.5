Return-Path: <linux-kernel+bounces-103234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9671087BCBC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 371B0B20C3A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F786F53A;
	Thu, 14 Mar 2024 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWz7g6q4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FD04691;
	Thu, 14 Mar 2024 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710419092; cv=none; b=hcBaLVH0aEzX5EFoZEiiSN29hNYjlNpkpV11qMWol2PGFzL4bX/d+DwTcpMCN5+fNT//B1YMtRXAnRZwY+ATlo+HI9ZLo0DyJFuwVWXG792pa+DeVxm+d/VbOh+f64hGe4WMt1WmxzoxgTD7jfe5zjuQ5FniuyzN6wZjnHiluYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710419092; c=relaxed/simple;
	bh=hqAXK1pmw/COewu+0V9Imcw6HfS/0tOeytlhniyTUrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e5TVBYoQj3i0GzDehAkrgQeKn1CBciPTkI+s02T5yFskNnZuIrAksi6SMNpCeI5t7G+sHdgxJaqzYtDdEElQkcI8mwNDAfYiW7eQH2Hg2IJ+nVi27/3SiGN6RkyTZltaNU3oBqBpMGBIcp/TiFjeDLvAwY+ny+iW8WEiOOUBsaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWz7g6q4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7605C433F1;
	Thu, 14 Mar 2024 12:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710419092;
	bh=hqAXK1pmw/COewu+0V9Imcw6HfS/0tOeytlhniyTUrI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=pWz7g6q4asNXGaO/hJfhmq5cYTtFWTh7wUrpvKElY0R1qqxroABcgtXJVWCivNQSh
	 BYhVAmv1zo8AnllKyM4N/4GCRsDtktJXNsENDL2v8SpQUI0L1B9iVlh1vAUOLrOqjY
	 L1W0iEPYemZS3/zAIJbF0iKepcC/FrUbtn1yPlk0kCADRzaZ2SrZlM629CGDNaHuB0
	 EQZFk59Jg2OHMmyufkXCUf9vW4GSE8VmC4AZP1U09jaV8Bk9MbL5w8NHCsC7Mp7uaF
	 M2bVSK46E4ju1PH95ToE5MbRAcP6LAp5kctFykTSDiKPG2a4Ci327pj7DNfQCGFZ6x
	 YC7Ra+UE0Qbnw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D283BC54E68;
	Thu, 14 Mar 2024 12:24:51 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Thu, 14 Mar 2024 15:24:35 +0300
Subject: [PATCH] arm64: dts: rockchip: set PHY address of MT7531 switch to
 0x1f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id:
 <20240314-for-rockchip-mt7531-phy-address-v1-1-743b5873358f@arinc9.com>
X-B4-Tracking: v=1; b=H4sIAILs8mUC/x3NwQrCMAyA4VcZORtYu07FVxEPtU1sENeSDFHG3
 t3i8bv8/wZGKmRwGTZQeotJXTrcYYBU4vIglNwNfvRhnFxAropa0zMVafhaT/PksJUvxpyVzPA
 ej8kzczjPDL3SlFg+/8P1tu8/dVn8KXEAAAA=
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: mithat.guner@xeront.com, erkin.bozoglu@xeront.com, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710419077; l=1281;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=M6V6hLjoM7rYDNZJdf1WFKDQWTTCt8rVO23htitTxhE=;
 b=2C08ammmunglRmpdQwiQIKW95QKlBhYoQev+0BRPUVhkzTQFI6N+micHOVYOIUijFf9m8Nq5H
 HOqI2PamNGKAh9GUhP/ia6vPJ89x+92kMEyCixwO2Hq4svAgbQeGko7
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The MT7531 switch listens on PHY address 0x1f on an MDIO bus. I've got two
findings that support this. There's no bootstrapping option to change the
PHY address of the switch. The Linux driver hardcodes 0x1f as the PHY
address of the switch. So the reg property on the device tree is currently
ignored by the Linux driver.

Therefore, describe the correct PHY address on Banana Pi BPI-R2 Pro that
has this switch.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
index 7b5f3904ef61..03d6d920446a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
@@ -525,9 +525,9 @@ &mdio0 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 
-	switch@0 {
+	switch@1f {
 		compatible = "mediatek,mt7531";
-		reg = <0>;
+		reg = <0x1f>;
 
 		ports {
 			#address-cells = <1>;

---
base-commit: 0276d797531ea2d1865a04fbe54c659608f5788f
change-id: 20240314-for-rockchip-mt7531-phy-address-ba6c2fff485f

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>


