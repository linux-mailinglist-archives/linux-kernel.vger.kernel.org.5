Return-Path: <linux-kernel+bounces-27981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A6E82F8A4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E311C250AB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCEA13665A;
	Tue, 16 Jan 2024 19:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piezsCMv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD999136648;
	Tue, 16 Jan 2024 19:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434746; cv=none; b=XcJ3BGZc2CyVHdoU9m2gTDEUtsZC8oGJaRozELelbN2HAur+bwL41wzXLlKiCtXVUM1jwPBaHA486cjUXqzP+JuAwmKrvc2czfN2rqjKpdIuODN97QSI1GdYT7lPE8zIOM8k0TP8iCMdy+9kspJ4IRRS9PJCVqTzCH/UPFFPUx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434746; c=relaxed/simple;
	bh=ZjjT0IN5Xa8NXlVhiDz35d697CMkZaYKS4VppmcKL6A=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=ihTlxIqWZG0xIgo4H1Pfitm1QMJ4nTHbwb6CQaDfjZdXFd4KNcAtXIPw5aHQqcbSuDnfr/LKe6cxGyGdq6Mb81PCHztZwUHTTqeMqb+MGGjw2pQaWyWmftViudDQUYBeFGrrpZKcYo0zKb6/Yocuix1A95MiqRgCcBQEOg7rCms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piezsCMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC262C433F1;
	Tue, 16 Jan 2024 19:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434745;
	bh=ZjjT0IN5Xa8NXlVhiDz35d697CMkZaYKS4VppmcKL6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=piezsCMvUF1sgKYXxwCYx/v3A/JqJbViBDmmW9J99iFeipAwNqz1GPC+TrABYcEOU
	 sCGknEX+g7n2SDHvfURGjnwp1oeg4cozEb/zHOG134F/psnukQ63eSv+KX5/89PkiW
	 WYxh1Hw8ftF5i697gOUSy2VNSUjDmN6w5FyUXx+NpPzdKxyrL168c4F/6IAnad2QJ6
	 9ZgEtC4i6LYzYMtmnrWU86NxTY3PhLJKNxKW3MrY4EJpJwiJK2xSSgXgo9NrqzSEAK
	 6Reff0lI9Vg51Nr7058en4u7AlxvDY7vI4XahmQd9xVkeZy5iWs21Y44FO9mQFb+ai
	 advxRcGaW0apg==
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
Subject: [PATCH AUTOSEL 6.6 070/104] ARM: dts: imx23/28: Fix the DMA controller node name
Date: Tue, 16 Jan 2024 14:46:36 -0500
Message-ID: <20240116194908.253437-70-sashal@kernel.org>
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
index 5eca942a52fd..14c07b585f82 100644
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
index 763adeb995ee..9b73130887ea 100644
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


