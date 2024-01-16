Return-Path: <linux-kernel+bounces-28189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D79B82FB58
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B48F1C2696C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB6F1641AD;
	Tue, 16 Jan 2024 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwwQQT0t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385B1164197;
	Tue, 16 Jan 2024 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435411; cv=none; b=ec0tWDdhtlm788r5XOcE1KHjVoddnhAfSP9flapT9Zr+egz7PX3x8aOoSLFkzrsDhX5i/Pb+thVLCfTNtDzwP4HqrrgHvYQDpeXKJaLBT023RS4hpWTHYyDyrbm7114AmeD+PYvlIK3JfCkfhLZlOYcaLN4TcJnpqBE5coeVGXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435411; c=relaxed/simple;
	bh=klE03laoYLw4js+1hKMA+82EFlxgnkuo+HT98eKBwT8=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=oPA697YwAj6hyhQuAnRsaSEm8y11YYdUNNObgNwGQVO8L8LOFr3RfjX9COMO7Jg3EH1HYCbne4zgQetIBHo5ikRKzDkRq1zgCWEC3TXpddlHbVuDTAjjmB0c43Gb4Xzluz4cZtNAYisMmqaYSZs2nk6x1cmVnRRRLimAf4nrc9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwwQQT0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5B6C433C7;
	Tue, 16 Jan 2024 20:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435411;
	bh=klE03laoYLw4js+1hKMA+82EFlxgnkuo+HT98eKBwT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GwwQQT0tIqTmL88ITu/0+o3+68nF+idML1F2WnAnogRKvBewpYm6hNj2G37+Y6/uD
	 xca3NgLYhwpkmevddOoyCSSnjE5AqsmKxYPbi+i8Tp6BE7nzUZalRWsjPsUAt7Vgli
	 7W4IQLfAFYRGmbNZ3gPL9J8LrA41PqLMy90XFB2PCJYWuSner5YCF8SP/efvzpRL2P
	 WRKDghoSM7TFfxXdD6ePUjvZu29J60w9h/ulbQ13Q53doQuNvW0b3APhKrKafJ6Apy
	 u4Pvz1rWwjSUdOgDlJLgEv/fFcHC+JAWiF+t2QK+l+VHZBVhCBPQg7KR74KcHn8Cjg
	 nHz54FIhEh9ag==
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
Subject: [PATCH AUTOSEL 5.4 09/31] ARM: dts: imx7s: Fix nand-controller #size-cells
Date: Tue, 16 Jan 2024 15:02:18 -0500
Message-ID: <20240116200310.259340-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200310.259340-1-sashal@kernel.org>
References: <20240116200310.259340-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
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
 arch/arm/boot/dts/imx7s.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index a7ed880b12fc..8e86841ef4e6 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -1217,7 +1217,7 @@ dma_apbh: dma-controller@33000000 {
 		gpmi: gpmi-nand@33002000{
 			compatible = "fsl,imx7d-gpmi-nand";
 			#address-cells = <1>;
-			#size-cells = <1>;
+			#size-cells = <0>;
 			reg = <0x33002000 0x2000>, <0x33004000 0x4000>;
 			reg-names = "gpmi-nand", "bch";
 			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.43.0


