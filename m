Return-Path: <linux-kernel+bounces-28120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5376082FA6D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B751F27561
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85342155A2D;
	Tue, 16 Jan 2024 19:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQRY046v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1A8154C15;
	Tue, 16 Jan 2024 19:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435182; cv=none; b=RensZ+yb7cfwnkbV/t8fP3nFg98vLksJRGmmP0R+lP3ZoNsYnnDo9fRYivGR2m5tZ7xpCSD8yyvc7DnNs+MWEKRPL/f/99KDmkwXSb9V0jUAaVzWtcQkt7Bsv/NMcZk9nsOMbaRGzNJ8lV+bHPmfry/yANsvSJ1nAtVVhH3DC3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435182; c=relaxed/simple;
	bh=LHe3WbtSeAw+zMag6pGrOXRlFdOH5pbbZVwiduwmtrA=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=olR4jEeRVwBFj3UVH3J5RdFE664OiNaXdG6YLmorzspahaz3UNotmKRp8lO6dCqcdCxfH0tU+idSIr5IbPxeUgv32pOXpmr6kak2qziKAXOebmY+HipmQR5wOl3LHIXRqHYaH4uhrSAbN1cA0i7YkiIU0cRdM3iI3X1p7uJaL6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQRY046v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C51EC433F1;
	Tue, 16 Jan 2024 19:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435182;
	bh=LHe3WbtSeAw+zMag6pGrOXRlFdOH5pbbZVwiduwmtrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SQRY046vRAJrA6kzA3DYnWweIt32cEwjnehQQgyWVPEP113TmSVCdzKS7q8bZfwyi
	 0kPrjHT/tvUygUtaMzfqMasBs8dloSaSfO40f9d+m3JMGuJzSLU1TGLHMQWzLMW7/j
	 328QCQEisEVNoHwCEb0CjhISgAAhwOLKUqHMmjuLmPlf02cJpsiCdBJOC4Pgmm7IDS
	 81P8MOIbyn56h6E6ARrLEAbqyYJMQZwBjZMOjtHnL6qj91HnzGdLCoQvRyx7gsei5V
	 UtBk8cz/2UdwAsgiqAdcPBdyLya7LnNyHjwtBcLZMnKXbzPqyTh21Q+2xypTuQqYuv
	 blw9saNRylCqA==
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
Subject: [PATCH AUTOSEL 5.15 32/47] ARM: dts: imx23/28: Fix the DMA controller node name
Date: Tue, 16 Jan 2024 14:57:35 -0500
Message-ID: <20240116195834.257313-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195834.257313-1-sashal@kernel.org>
References: <20240116195834.257313-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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
index ce3d6360a7ef..b236d23f8071 100644
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
index 10eab221bc05..7fcc0d35d31c 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -992,7 +992,7 @@ etm: etm@80022000 {
 				status = "disabled";
 			};
 
-			dma_apbx: dma-apbx@80024000 {
+			dma_apbx: dma-controller@80024000 {
 				compatible = "fsl,imx28-dma-apbx";
 				reg = <0x80024000 0x2000>;
 				interrupts = <78 79 66 0
-- 
2.43.0


