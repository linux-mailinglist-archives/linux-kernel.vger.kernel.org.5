Return-Path: <linux-kernel+bounces-28225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEBA82FBD6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4EC1F2882D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA17E16BDFA;
	Tue, 16 Jan 2024 20:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUysoDLg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0813E16BDE6;
	Tue, 16 Jan 2024 20:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435499; cv=none; b=R5pz4M41H61dl3wQg6+ZTAK3dvZsqAu5cqQnGAqXllztYNlXVwu0NIImowmDyDaPjLacvuA5GjqS9iQ0reoDECVVB6s9pltdULVGzo7yQroASYZT2UFJ4sXtNbcfDJZdO+v8cMtvkNsAuA9rWO0QTlo+Axr3ZzejoIXF0g4f5Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435499; c=relaxed/simple;
	bh=8lIii65UvIwVnVl0Dlka4aS7PFjgnFDZ1TEO6Srmzaw=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=WPGI7C/pjudrduSDy84/MNKLVTSLnikwKi9c5inAFbrzyxvw8MkOrOFFOSBMTleG5o13EAUgjbJuyEZ/OHkXwX751E8OQBWks55AdKFkIlrbF+tM6aGXv5pqGtpO6MqFuFadVH4+4EZSdmr/d4GLHfFHgzPEYqXc649EQ6P0Bl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUysoDLg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3BDC433F1;
	Tue, 16 Jan 2024 20:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435498;
	bh=8lIii65UvIwVnVl0Dlka4aS7PFjgnFDZ1TEO6Srmzaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nUysoDLgDB2gan4SmCdlnPOGODw/LJAOY5WO/SqdPONlaxhHVdfJC4qtcuF6hewpZ
	 f9JV8+7VL1y+IUrvIFm1HAfFYoMLwxor6MygFqQ49RU2iS8HdsAbGP3P+66fN4rtL+
	 wrJWlrTUseiD6Bq2AawFVBRknLo1pIKyIZAcSPsp25Gm48AiB2Zw0ig0dsah/KYHbm
	 lkRgXZjPfhxLhs3XMmiHzoBkhIKgdsml/bt8GP2jWhcbboNrkOU1ssC5c+RKc+eIAk
	 2hq5aSrzMF/YfHStzMw8m/lr/+Amwuv2TzzZYHZj6LfkC/q9lhNKqWHp4jGeTrSU3m
	 mC4gkt0aVGAHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fabio Estevam <festevam@denx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 14/22] ARM: dts: imx1: Fix sram node
Date: Tue, 16 Jan 2024 15:04:08 -0500
Message-ID: <20240116200432.260016-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200432.260016-1-sashal@kernel.org>
References: <20240116200432.260016-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit c248e535973088ba7071ff6f26ab7951143450af ]

Per sram.yaml, address-cells, size-cells and ranges are mandatory.

The node name should be sram.

Change the node name and pass the required properties to fix the
following dt-schema warnings:

imx1-apf9328.dtb: esram@300000: $nodename:0: 'esram@300000' does not match '^sram(@.*)?'
	from schema $id: http://devicetree.org/schemas/sram/sram.yaml#
imx1-apf9328.dtb: esram@300000: '#address-cells' is a required property
	from schema $id: http://devicetree.org/schemas/sram/sram.yaml#
imx1-apf9328.dtb: esram@300000: '#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/sram/sram.yaml#
imx1-apf9328.dtb: esram@300000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/sram/sram.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx1.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx1.dtsi b/arch/arm/boot/dts/imx1.dtsi
index 2b6e77029de4..8c4c7464b133 100644
--- a/arch/arm/boot/dts/imx1.dtsi
+++ b/arch/arm/boot/dts/imx1.dtsi
@@ -268,9 +268,12 @@ weim: weim@220000 {
 			status = "disabled";
 		};
 
-		esram: esram@300000 {
+		esram: sram@300000 {
 			compatible = "mmio-sram";
 			reg = <0x00300000 0x20000>;
+			ranges = <0 0x00300000 0x20000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
 		};
 	};
 };
-- 
2.43.0


