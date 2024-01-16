Return-Path: <linux-kernel+bounces-28202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD5682FB86
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27A61C26B49
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76485167425;
	Tue, 16 Jan 2024 20:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sagkwNLo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F77166D14;
	Tue, 16 Jan 2024 20:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435436; cv=none; b=jJOMKHrb0/cF+L4XPyJ90A5ouaXRgywMmp1a4IzBPOungiKuNPnH1Qgw7zTPjco0Fxj+SQt8LU6ndpbTqJXXgIKfZYvGn42wEm9S1VXcjvKGy22YkY0WAKOnAfjH9J+5+WGbXu98uv8LzjcjAvHOMZKJXRSPRMZeDVL6tpT47KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435436; c=relaxed/simple;
	bh=JCM2nX1Rh1xGw9hp4QoKanglz8lJXXnJ0dfErsTB4W8=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=g9hqgruCFRFO7SnQK7YlkBWibtwcqCDi3wQJ6KlQ16zm+XntA3HjKm4ankK8ey5zyVAoDQumQOCh4o3ZNTFSjs70iiHsHVKFdGTrofsVtm7rkv0dkVfwVncl9zBTv7aOtWHjdtzSYNeNSkq+Ea3VlMbZXW7wPG8hprWux1/KvTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sagkwNLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA09C433C7;
	Tue, 16 Jan 2024 20:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435436;
	bh=JCM2nX1Rh1xGw9hp4QoKanglz8lJXXnJ0dfErsTB4W8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sagkwNLowhauhoub5VFnaWBOF2Q2hLA9WgQumyJ5O38fyfmi2OxqU1yMBL8niNxQo
	 D/R0h9PipT1st7eQcJevcwyQfB8Alf/a/MNwsjhgKT7lY0asmuWZY5N+Z0OVdbbJgM
	 Kau9nt+U3TJiyvPqbP0VIZC/IgTSEK5kRBWN3W9/6fhKQ6R4mzQrEERUCNi/564Vn+
	 MYjPaVOjVVw9RXpix0/A6W+GaTMTgNLZ4AvcypWQrMi4bYJkig0ugg13wl9bUSGHKj
	 uwVR5M/8YfkP5C8YBqFDPffOm50IAU5JpXxUzuMk34STKGL6gZc0L8YLXI8YJR4JR4
	 kGTBpTUb3p6nA==
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
Subject: [PATCH AUTOSEL 5.4 22/31] ARM: dts: imx23/28: Fix the DMA controller node name
Date: Tue, 16 Jan 2024 15:02:31 -0500
Message-ID: <20240116200310.259340-22-sashal@kernel.org>
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
index 42700d7f8bf7..ba1705595b29 100644
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
index 235c69bd181f..26dc6c9e1e6c 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -982,7 +982,7 @@ etm: etm@80022000 {
 				status = "disabled";
 			};
 
-			dma_apbx: dma-apbx@80024000 {
+			dma_apbx: dma-controller@80024000 {
 				compatible = "fsl,imx28-dma-apbx";
 				reg = <0x80024000 0x2000>;
 				interrupts = <78 79 66 0
-- 
2.43.0


