Return-Path: <linux-kernel+bounces-27967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E652882F875
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F24371C24265
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9268E13342D;
	Tue, 16 Jan 2024 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpD0G3Ly"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F7213341B;
	Tue, 16 Jan 2024 19:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434701; cv=none; b=TNtkLXmqTIzujeWZ5qOrwQpr7EqrGnNO1Q8g5z6g3pqKEakptdGUzH3M/IjsDP+4bEHk6xmOkD9+F5lCLcvXhdZXh9JOvx89BrofmXWRlTOGFcs+MccXO8RqV53OK0RLUfku/PYR8e5ZhL/rq3r3GqoMGVoFl5IspymM9bh54O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434701; c=relaxed/simple;
	bh=tndzEldCKSFHwVnQUGmS9Q6JRTxbQAawwREa7yCfkDQ=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=AgT0f5ftFlLELjX26oxnru1Cr87hWWrlPGQUITj2Wcbnvm+BSyrC0EyCKo6Lsp8Pc0Hc47vQPmxx9Z8o81+0QUNPZJoa7sRdJTbnVYWC7H/3TQVd8b0Yg7gobDI5hAosfwgygFS/STYy4wHKsRvI3di8zvJGRKN7X/2yac+Ru9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpD0G3Ly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AAEC43394;
	Tue, 16 Jan 2024 19:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434701;
	bh=tndzEldCKSFHwVnQUGmS9Q6JRTxbQAawwREa7yCfkDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mpD0G3Lyq1NZYtzX4BAMd+aMuNwQ6eecOpAAFGPkQRvA+KM2TcKMdvj1qa4e8+loj
	 nmq13ekUvNQASE+UY1AFrBkoO0wqesw+jW/RJEjIfvMJqiTXTkS7v28GNVJDDKPadQ
	 4EjWxI7CuZx+YtTuLUhYdj3xGtYuDz5jTWsYs3THSIBQTgVq1yrOP19wnHmubq50fU
	 jLdIrSq+F+tnFHql5WBgj/ceilJogP7AujBz/caPhIoCtx93kcVaZtQBwiI/jL4n4k
	 +8EX32npMbO5wlD+MyqKV3LVvohKzPYgpn/4xcHAKfYiR2F5KOC9myKqlZZtjAoyyu
	 bbSsGZtWodwAg==
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
Subject: [PATCH AUTOSEL 6.6 056/104] ARM: dts: imx: Use flash@0,0 pattern
Date: Tue, 16 Jan 2024 14:46:22 -0500
Message-ID: <20240116194908.253437-56-sashal@kernel.org>
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

[ Upstream commit 1e1d7cc478fb16816de09740e3c323c0c188d58f ]

Per mtd-physmap.yaml, 'nor@0,0' is not a valid node pattern.

Change it to 'flash@0,0' to fix the following dt-schema warning:

imx1-ads.dtb: nor@0,0: $nodename:0: 'nor@0,0' does not match '^(flash|.*sram|nand)(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mtd/mtd-physmap.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx1-ads.dts                  | 2 +-
 arch/arm/boot/dts/nxp/imx/imx1-apf9328.dts              | 2 +-
 arch/arm/boot/dts/nxp/imx/imx27-eukrea-cpuimx27.dtsi    | 2 +-
 arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-som.dtsi | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx1-ads.dts b/arch/arm/boot/dts/nxp/imx/imx1-ads.dts
index 5833fb6f15d8..2c817c4a4c68 100644
--- a/arch/arm/boot/dts/nxp/imx/imx1-ads.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx1-ads.dts
@@ -65,7 +65,7 @@ &weim {
 	pinctrl-0 = <&pinctrl_weim>;
 	status = "okay";
 
-	nor: nor@0,0 {
+	nor: flash@0,0 {
 		compatible = "cfi-flash";
 		reg = <0 0x00000000 0x02000000>;
 		bank-width = <4>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx1-apf9328.dts b/arch/arm/boot/dts/nxp/imx/imx1-apf9328.dts
index 1f11e9542a72..e66eef87a7a4 100644
--- a/arch/arm/boot/dts/nxp/imx/imx1-apf9328.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx1-apf9328.dts
@@ -45,7 +45,7 @@ &weim {
 	pinctrl-0 = <&pinctrl_weim>;
 	status = "okay";
 
-	nor: nor@0,0 {
+	nor: flash@0,0 {
 		compatible = "cfi-flash";
 		reg = <0 0x00000000 0x02000000>;
 		bank-width = <2>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx27-eukrea-cpuimx27.dtsi b/arch/arm/boot/dts/nxp/imx/imx27-eukrea-cpuimx27.dtsi
index 4b83e2918b55..c7e923584878 100644
--- a/arch/arm/boot/dts/nxp/imx/imx27-eukrea-cpuimx27.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx27-eukrea-cpuimx27.dtsi
@@ -90,7 +90,7 @@ &usbotg {
 &weim {
 	status = "okay";
 
-	nor: nor@0,0 {
+	nor: flash@0,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "cfi-flash";
diff --git a/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-som.dtsi
index 7191e10712b9..efce284b5796 100644
--- a/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-som.dtsi
@@ -314,7 +314,7 @@ &usbotg {
 &weim {
 	status = "okay";
 
-	nor: nor@0,0 {
+	nor: flash@0,0 {
 		compatible = "cfi-flash";
 		reg = <0 0x00000000 0x02000000>;
 		bank-width = <2>;
-- 
2.43.0


