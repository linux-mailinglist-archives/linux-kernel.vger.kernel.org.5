Return-Path: <linux-kernel+bounces-28053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD0B82F998
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C4C2876B9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC7D2D62C;
	Tue, 16 Jan 2024 19:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cn1tM8F6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25DC200B2;
	Tue, 16 Jan 2024 19:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434989; cv=none; b=jHv6j0Iktyql/M0nBQ+ZcYhVn0EztN4QLKMFwDfHTJtu7pj+ohbo9qo2ZrhlN5o1p3EVYuYaU3a/DBw4DUaQMXiYQfw5gqOjUDVSIgM2HkZKPIM/JD3vzN9MSZXTz+TgY2AtstIk0mNDWA27A7jkGwX4zkvDzYiNoCR7q02Zszk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434989; c=relaxed/simple;
	bh=0FQ8laDqU238aCJ/u3RqOeJPzJpyFceYo+BZOzk/rJ0=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=u8/f99RdQnCrmS9pGlHKLMNFB9j/VkHKbPr9M6Su15ZMtF8MIGbop7zCINDippgVis4vNiwSTYUVj9PGPaJU96VkFfQDBpvKKuU3NBgVwrka2convLem7v3hs5yaiW+IUDIA29HfG0J49Zk+XG+x3yGVy180c2YFodkCex80SfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cn1tM8F6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16AEC43601;
	Tue, 16 Jan 2024 19:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434988;
	bh=0FQ8laDqU238aCJ/u3RqOeJPzJpyFceYo+BZOzk/rJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cn1tM8F6/JXedYSpdx9HzgFfZLTGgSGt/X0386OSl5RtLLi9L3TpL47HctFVVQPEU
	 hiBBMrlj7tdYlocZEED900N60VYeAqKDOfdWMGcJsmNJ5FK+X9LnQll/5qP8YKSByc
	 ltQfRng5kkAowz/f0VBfsUETJgV5nvdivpmhhtwyzmMEpdMOWQ9BaPOhmFF8FD+zpc
	 gzjmBHD+DLtD3MWAYQU6bIy6mgMoGCUtJVdzy9ojMm29gZkoDqA5Z0Dg+5YVvJh5AX
	 n/5aRP/NcpG0hAUd2GnhRAbz5VzSGKtaFUuir5Qf+XJe/Au2frxudo5HMYjUskdsnJ
	 Q6F9A5qyxzbmA==
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
Subject: [PATCH AUTOSEL 6.1 35/68] ARM: dts: imx1: Fix sram node
Date: Tue, 16 Jan 2024 14:53:34 -0500
Message-ID: <20240116195511.255854-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
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
index e312f1e74e2f..4aeb74479f44 100644
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


