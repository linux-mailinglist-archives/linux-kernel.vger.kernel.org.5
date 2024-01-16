Return-Path: <linux-kernel+bounces-28228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9957C82FBDD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2726D289D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021DB679FB;
	Tue, 16 Jan 2024 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g53pDbnm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43075679E6;
	Tue, 16 Jan 2024 20:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435504; cv=none; b=GtZ1lGNcQRNtfR9h0SZQ+KvM7OtDZda8vl73RajaalPPgaMC2UKqLLvb9NOk1T0i5Bk49SQaif+v1zXya7r7EFTLKM4x1saW1thYXdVI8OfOvfd3U3Nk22mZQopL9zLuH4/I53JGe98LeOb/xav8nT0+SbbeMeObZkA526MFh5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435504; c=relaxed/simple;
	bh=uMT3W3G9viCYccxdW4xwYPiACwjx+nP6x95l5zosN1U=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=gKGlV6gzkH8P6zF9YGXxCl/f6wK88jgQCS4Y3S3ekGPav1NKut9oZrL88zw2bbVNgD/Aa7F56vhqCtZ7W08hGesPTir0T8uNlkB8QBPbC5je+7jzFSK5kweH4+BCZNinZqruGQmwilKobWe4Evm5rxUp+Sl0sg11gQutxNrvkyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g53pDbnm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC28C433A6;
	Tue, 16 Jan 2024 20:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435503;
	bh=uMT3W3G9viCYccxdW4xwYPiACwjx+nP6x95l5zosN1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g53pDbnmS2SEpTKlfPfrzRoOuvwY6IIMfL0v32wt6Ef+oirDDlCAaDgal1Hr6Gued
	 O5ydNW/jcRRlwIHOGwuM0v76xvmmEq6O89nDhkayzz56NXuNoJzc4Dm30IQzCBxdeS
	 rfOuyBKRvyd3S9rVqh4QlZdSnKzuKZyd2nYfnJi0YFxkPJ//4ap0odGkJZMJK4Le/P
	 hm6sQNDA7CuBnBYTMQFQzoxoG/n1HQgkqgdOuoMZZhl4XGmsLDuTNuSOVX2VIY1zrc
	 1SWJ2I7YAkC/xFmpyOkndgTAMPV1vbiSuqDOgEsrNOFfLghY3mn1y4u90fhBc5cRw1
	 shL0T7YocUo2Q==
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
Subject: [PATCH AUTOSEL 4.19 17/22] ARM: dts: imx23/28: Fix the DMA controller node name
Date: Tue, 16 Jan 2024 15:04:11 -0500
Message-ID: <20240116200432.260016-17-sashal@kernel.org>
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
index aaaa987d8eff..223c5171edab 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -406,7 +406,7 @@ emi@80020000 {
 				status = "disabled";
 			};
 
-			dma_apbx: dma-apbx@80024000 {
+			dma_apbx: dma-controller@80024000 {
 				compatible = "fsl,imx23-dma-apbx";
 				reg = <0x80024000 0x2000>;
 				interrupts = <7 5 9 26
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 5107fdc482ea..84f7c86373b5 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -984,7 +984,7 @@ etm: etm@80022000 {
 				status = "disabled";
 			};
 
-			dma_apbx: dma-apbx@80024000 {
+			dma_apbx: dma-controller@80024000 {
 				compatible = "fsl,imx28-dma-apbx";
 				reg = <0x80024000 0x2000>;
 				interrupts = <78 79 66 0
-- 
2.43.0


