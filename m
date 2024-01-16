Return-Path: <linux-kernel+bounces-27842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FC582F6A5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3C321F27A0E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684C520B02;
	Tue, 16 Jan 2024 19:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rll0t35A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87084EB2F;
	Tue, 16 Jan 2024 19:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434349; cv=none; b=TnApWPj9FgqQq9TScXCbE2tyiYp5O2DCQ164w2AgFXeuCSuZIRmiJiBlJTJW/WdQTyRGUps+hkyhwNy+5eWqS5MIAsno5PgYcKTNNzIlUx9sXZNq1ARn73GJj4x4YfOgkbLYHYkdBo/ZxroQbA13XcJWi5dn/PXIVqHgoDV6e1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434349; c=relaxed/simple;
	bh=AYCs7kkdRslZTRvMJjG8HygejvlDc3p+TAFd8ky6bX4=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=jtgIa+eZN23H4GkYnKNs18c16bpwgZuRrxbAwh4i6bXqzsA9OxKPGLFdUQpCDdum86NlZdVN6aF9KKRb6RHWBvSqMeMmLGaXE5a3t2sgQSAv/a04Vn5YXhOe0+qGo8xtey2nxVl+fuOwWzCWLxzqr8HAYDlWwOmEHXlexbZpF18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rll0t35A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A5EC433F1;
	Tue, 16 Jan 2024 19:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434349;
	bh=AYCs7kkdRslZTRvMJjG8HygejvlDc3p+TAFd8ky6bX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rll0t35A/GAMQXElSN4yU8QxcUA7fFx5i/qyXUVcVJ2Cdk4//sgsOVFnZcdwQQL8s
	 oBO/Vhl3W7tiAJPzLnvsmCRhDmQxOFi4+UNoPJmVAf+cudY34h/2SrRAjLxsR6z4wN
	 Ter3r3WbrUcSF1ak0qK/XaqOtzFUq5gQrhbqPxsyRbSa9bRD+lJhJztegf2ZvOXAaB
	 edNkKN7X4bLaBGvcDV3UiwynssrjxvblXSe0Ch4DS3XMSmC+8fPTt3tMHhHp0qMQNP
	 drZqP8Ehan7EefvxecXqsqccdy5L2iLCEG/TV+78c32+oAZB2Wcx//q8HFaS2oEWva
	 CdRaC0zF/YlwA==
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
Subject: [PATCH AUTOSEL 6.7 071/108] ARM: dts: imx23/28: Fix the DMA controller node name
Date: Tue, 16 Jan 2024 14:39:37 -0500
Message-ID: <20240116194225.250921-71-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
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
 arch/arm/boot/dts/nxp/mxs/imx23.dtsi | 2 +-
 arch/arm/boot/dts/nxp/mxs/imx28.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx23.dtsi b/arch/arm/boot/dts/nxp/mxs/imx23.dtsi
index fdf18b7cb2f6..9cba1d0224f4 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx23.dtsi
+++ b/arch/arm/boot/dts/nxp/mxs/imx23.dtsi
@@ -412,7 +412,7 @@ emi@80020000 {
 				status = "disabled";
 			};
 
-			dma_apbx: dma-apbx@80024000 {
+			dma_apbx: dma-controller@80024000 {
 				compatible = "fsl,imx23-dma-apbx";
 				reg = <0x80024000 0x2000>;
 				interrupts = <7>, <5>, <9>, <26>,
diff --git a/arch/arm/boot/dts/nxp/mxs/imx28.dtsi b/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
index 6932d23fb29d..37b9d409a5cd 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
+++ b/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
@@ -990,7 +990,7 @@ etm: etm@80022000 {
 				status = "disabled";
 			};
 
-			dma_apbx: dma-apbx@80024000 {
+			dma_apbx: dma-controller@80024000 {
 				compatible = "fsl,imx28-dma-apbx";
 				reg = <0x80024000 0x2000>;
 				interrupts = <78>, <79>, <66>, <0>,
-- 
2.43.0


