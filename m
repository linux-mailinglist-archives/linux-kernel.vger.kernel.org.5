Return-Path: <linux-kernel+bounces-18001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52F08256CC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52951284887
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7032E640;
	Fri,  5 Jan 2024 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEHktiNr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265C52E823;
	Fri,  5 Jan 2024 15:37:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545FEC433C7;
	Fri,  5 Jan 2024 15:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704469066;
	bh=cxMHZsqoXoXL9f4WjZLur+k1h6gb5OUA+yOongsuZG4=;
	h=From:To:Cc:Subject:Date:From;
	b=hEHktiNrwI/qC3Ln9MQp7E4Bq64RgQ4TGGACEtPa0pjHRHP7vswfDLVkCDkJN3aE1
	 +2RLLA4uio+2sY/IlYrRtb7d2nAhsJmawYKDiFA/L6xRACWZj3PzYMAtE5Eg/5+gds
	 tBx+ilHqoo8rso71IjpYcIMAV3QEG4EhdDF/RTG2+4/lAVUwcgHORDMe1I2mgM9iVC
	 OupuC9p7uqNhAs63ah8NlBCcvVX24u470AKtq1YvwaAi2rpahuFvgdQ7e0/o/u+hA4
	 g76QNx3kzVVkJ2Sup3M5w4fLIknkBehXlR9h24MPwZxf2IhKOM0SNXtyXD9bS+ngZO
	 pkbrBCte7FKVQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Felix Fietkau <nbd@nbd.name>
Cc: lorenzo.bianconi@redhat.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: airoha: fix pcie ranges properties
Date: Fri,  5 Jan 2024 16:37:19 +0100
Message-ID: <95e2d79c1c36663cfffce5a20c95f8201670bbec.1704468417.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduce and split pcie controller memory ranges for en7523 SoC
in order to properly load a pcie card on the second port.

Fixes: 08a4aeb2c23f ("ARM: dts: Add PCIe support for Airoha EN7523")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 arch/arm/boot/dts/airoha/en7523.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/airoha/en7523.dtsi b/arch/arm/boot/dts/airoha/en7523.dtsi
index b523a868c4ad..bb78d54e94f6 100644
--- a/arch/arm/boot/dts/airoha/en7523.dtsi
+++ b/arch/arm/boot/dts/airoha/en7523.dtsi
@@ -159,7 +159,7 @@ pcie0: pcie@1fa91000 {
 		clocks = <&scu EN7523_CLK_PCIE>;
 		clock-names = "sys_ck0";
 		bus-range = <0x00 0xff>;
-		ranges = <0x82000000 0 0x20000000  0x20000000  0 0x8000000>;
+		ranges = <0x82000000 0 0x20000000 0x20000000 0 0x2000000>;
 		status = "disabled";
 
 		#interrupt-cells = <1>;
@@ -188,7 +188,7 @@ pcie1: pcie@1fa92000 {
 		clocks = <&scu EN7523_CLK_PCIE>;
 		clock-names = "sys_ck1";
 		bus-range = <0x00 0xff>;
-		ranges = <0x82000000 0 0x28000000  0x28000000  0 0x8000000>;
+		ranges = <0x82000000 0 0x22000000 0x22000000 0 0x2000000>;
 		status = "disabled";
 
 		#interrupt-cells = <1>;
-- 
2.43.0


