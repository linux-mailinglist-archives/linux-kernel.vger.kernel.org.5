Return-Path: <linux-kernel+bounces-28062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD0E82F9B3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E481C25AE5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBC9148303;
	Tue, 16 Jan 2024 19:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4f60X6D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFF61482EC;
	Tue, 16 Jan 2024 19:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435017; cv=none; b=QPNL5zcXrGaKce8Y/fBgZLh6tIo7RURxeEj0DecDuQa1dq+jjCqgTH1j9P6i+TdIbFLQm+SPrHNiMi+QcGiJcmxuRlNTgLYNsCkBz137QL0hjnIQ1PI4C/SdksmhB37OENOfC+5hjmPtVRs5oqmecnnyPz5go/7V/LbyuWqR9/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435017; c=relaxed/simple;
	bh=jcwuOQxwyxb6zSdrifRuP5NhfFhRZHRGvV4Hpb4lmVA=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=oo7WE2OzoTyw2IMLHzDgmChOXNTnH9GfU73Y/+deGzUv9c+IhSiBjpkUtaBBeVUzt+XcmAOnB3uhSxjuZiREe0xqJgC7BEbK62Z/hUZRl7/uv/ywTX4TI086Spe+jveJ2W4/MPzBKSEVdVi+vn0MwNuqP1EGTpEk2PIWLj0096Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4f60X6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE8CC433B1;
	Tue, 16 Jan 2024 19:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435017;
	bh=jcwuOQxwyxb6zSdrifRuP5NhfFhRZHRGvV4Hpb4lmVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z4f60X6DXoBhcUsWt18I/PJkK0pf0WoQQ2drDiqVFC2hqM+rFjkygoXM1XF/mWfEd
	 inTQJW0OzKTlVPQKK7u5Btg+3bL23z6/rGyir/Dq2Uo1OnykFBBhXyOVyAxOmb5gDT
	 RFEtlvi87+qxCuIOSaa0NpNvW3nIAzBF7/jc8WWE2IqkaQwibE89mZf/S5PlRu0XPU
	 bhR190n/OZQC48vZrX9nxNsJEtGfFGhVBSzswSVts5ClC5+isxjcSZ2km4Z1dYD3sh
	 csVqj9QmPKAfBGtLUHMhJaHV2W+nNYmYqZHk44O3a5XS8waJx7EPBSVkD7Ww8t7tF4
	 aRJ+O/1lu0cEQ==
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
Subject: [PATCH AUTOSEL 6.1 44/68] ARM: dts: imx23/28: Fix the DMA controller node name
Date: Tue, 16 Jan 2024 14:53:43 -0500
Message-ID: <20240116195511.255854-44-sashal@kernel.org>
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

[ Upstream commit 858d83ca4b50bbc8693d95cc94310e6d791fb2e6 ]

Per fsl,mxs-dma.yaml, the node name should be 'dma-controller'.

Change it to fix the following dt-schema warning.

imx28-apf28.dtb: dma-apbx@80024000: $nodename:0: 'dma-apbx@80024000' does not match '^dma-controller(@.*)?$'
	from schema $id: http://devicetree.org/schemas/dma/fsl,mxs-dma.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx23.dtsi | 2 +-
 arch/arm/boot/dts/imx28.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 7f4c602454a5..ec476b159649 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -414,7 +414,7 @@ emi@80020000 {
 				status = "disabled";
 			};
 
-			dma_apbx: dma-apbx@80024000 {
+			dma_apbx: dma-controller@80024000 {
 				compatible = "fsl,imx23-dma-apbx";
 				reg = <0x80024000 0x2000>;
 				interrupts = <7 5 9 26
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 130b4145af82..b15df16ecb01 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -994,7 +994,7 @@ etm: etm@80022000 {
 				status = "disabled";
 			};
 
-			dma_apbx: dma-apbx@80024000 {
+			dma_apbx: dma-controller@80024000 {
 				compatible = "fsl,imx28-dma-apbx";
 				reg = <0x80024000 0x2000>;
 				interrupts = <78 79 66 0
-- 
2.43.0


