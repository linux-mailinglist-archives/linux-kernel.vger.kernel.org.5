Return-Path: <linux-kernel+bounces-27938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8509982F80E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239001F2699D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBB712C521;
	Tue, 16 Jan 2024 19:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J45Btc1n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B6712C534;
	Tue, 16 Jan 2024 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434621; cv=none; b=AT06SS5tz2Jf/yrDlPVAPqCsZyrsGStgh5zDYyxVZchXxHXwec7jLkfFWH32iOfnUWmaYmLOcjobYm1GgvSyAc713g+pcbz71At6zs057WQ6y/bxI+FcIRw29sYRlU+n1EjTIJQq3CfUyK0KdkvnEp+I4WspcUAX9SD5aZeLUHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434621; c=relaxed/simple;
	bh=JTgR5zfMl/JRzKi+ixQsSK4SDjjiy9deI9cA8tBj6lU=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=XtmBGhVq9RhKhWn5cbc2SLVM/CeKnfUsnJb00RNRMEMQ9oVSihCIonRIlflb1j6ED+C3VIX69p7WDBB0Zu0A4ROjcOkZ8ESCrxqOLwpcpwSo8QUOUTzRTf32uROdyhbMmfZ8weG2LZPMu/uZAnB+a09furlgeQw0l1TfDjPNYUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J45Btc1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A589C433C7;
	Tue, 16 Jan 2024 19:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434621;
	bh=JTgR5zfMl/JRzKi+ixQsSK4SDjjiy9deI9cA8tBj6lU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J45Btc1npkqb89bQG9ZrJbxOlJMDtN2PmYZpmvcmcovth0SL3DXvxBVHaQKmlnH+k
	 BZWMvZWbfbR84Ztv0hztihppZzQm8ij8UfuOHdDtJ9ScyuQF0vC4Cm8H7Gx9lb5Og+
	 i0zGXfDmm7PWrBTOGaHaxi3CKlfW6PMsjTJFCCCPQUb3/DvYu1idudXoYy/9hNcaI6
	 0vwvFkUORfQ8OXpG2BRI12nbSEIr3kv4AvaLIqeuz37kt0CeAUFkP3ohWg3sx28r9X
	 T5OFMBz8jlb7PVAnCxoQ2Smsijs1uPuZ2HgzVIeWzrAyvqILplhvK5qYlMY59Q5+su
	 VAUXtbX3CBCSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 030/104] ARM: dts: imx7s: Fix nand-controller #size-cells
Date: Tue, 16 Jan 2024 14:45:56 -0500
Message-ID: <20240116194908.253437-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit 4aadb841ed49bada1415c48c44d21f5b69e01299 ]

nand-controller.yaml bindings says #size-cells shall be set to 0.
Fixes the dtbs_check warning:
arch/arm/boot/dts/nxp/imx/imx7s-mba7.dtb: nand-controller@33002000:
 #size-cells:0:0: 0 was expected
  from schema $id: http://devicetree.org/schemas/mtd/gpmi-nand.yaml#

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx7s.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
index b6d03794d8d9..39e9f1411ebb 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
@@ -1282,7 +1282,7 @@ dma_apbh: dma-controller@33000000 {
 		gpmi: nand-controller@33002000 {
 			compatible = "fsl,imx7d-gpmi-nand";
 			#address-cells = <1>;
-			#size-cells = <1>;
+			#size-cells = <0>;
 			reg = <0x33002000 0x2000>, <0x33004000 0x4000>;
 			reg-names = "gpmi-nand", "bch";
 			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.43.0


