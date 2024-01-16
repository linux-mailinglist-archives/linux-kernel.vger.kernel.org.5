Return-Path: <linux-kernel+bounces-28223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB4382FBCC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1751F2873E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2863E4EB33;
	Tue, 16 Jan 2024 20:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oC/YbbUq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627A516B66B;
	Tue, 16 Jan 2024 20:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435495; cv=none; b=ExijJk3w4RY5D79PELsVBw/lKkttEqZK3skSIiDhSBxoDAZ8TVuteBCBUnauJQk0VJoT6UmSHsDOAQpfBmw7QXdoqNXUUzu2GWJfRxenPbG92W6AImq7M6n/0Y/gGE9lfx4b/rosywFAPqK7Fh3dKJ+5Ag4stGv+Rj/J7w0rtzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435495; c=relaxed/simple;
	bh=48kKvE7ro8DGOBI3CpcEacJUWZ0wrm/kiZDBXYJpZQY=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=k80EliQajNvv5me/r6bFFmX9VNG6V6Wxo5RpL85wg7yVej6NTfL0XcTavXdx/KZ5/+A/ccfulrTbE8Cy+ckxtPVLW+GapA/1Lr3+sqRqIIsq2CAk4rCjOOUUi4bnlFIXZDd+8lKYi4Oe6gQReNCRqGayuI44J2ynEko4tbikRyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oC/YbbUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3020AC43330;
	Tue, 16 Jan 2024 20:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435495;
	bh=48kKvE7ro8DGOBI3CpcEacJUWZ0wrm/kiZDBXYJpZQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oC/YbbUq1ksaKuEhoeh9kTzxahmFl2A6/GSem775VEih5SdXJFbUoQIVh1aOiDkB/
	 BY54KNLRqQ8VThmFdgKMTTam23NRw5kaiR//PLDhKZBKQD4pOqD78d4qOr282/1i7h
	 PMBn0jXznUSucCzgV40957OlWRVSMqQV4bf1nDdNtdUS0wmSAvfh/OfD2S6wX+nUw3
	 +RT8CczMcxGjkJ2pP1sLo/rxjAGmThSYZ4jr7SHLWdeHTf/y3nc/F3vBVb6wVw10EO
	 oonaqN4EUCZPNHOr+wKY7Tv00/y3AsAhnyKuTQnEGNlLlrciSFAj21WUODFh5poDa4
	 1rkIqsbMhLv9A==
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
Subject: [PATCH AUTOSEL 4.19 12/22] ARM: dts: imx: Use flash@0,0 pattern
Date: Tue, 16 Jan 2024 15:04:06 -0500
Message-ID: <20240116200432.260016-12-sashal@kernel.org>
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

[ Upstream commit 1e1d7cc478fb16816de09740e3c323c0c188d58f ]

Per mtd-physmap.yaml, 'nor@0,0' is not a valid node pattern.

Change it to 'flash@0,0' to fix the following dt-schema warning:

imx1-ads.dtb: nor@0,0: $nodename:0: 'nor@0,0' does not match '^(flash|.*sram|nand)(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mtd/mtd-physmap.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx1-ads.dts                  | 2 +-
 arch/arm/boot/dts/imx1-apf9328.dts              | 2 +-
 arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi    | 2 +-
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx1-ads.dts b/arch/arm/boot/dts/imx1-ads.dts
index 119b19ba53b6..26af4e05abec 100644
--- a/arch/arm/boot/dts/imx1-ads.dts
+++ b/arch/arm/boot/dts/imx1-ads.dts
@@ -71,7 +71,7 @@ &weim {
 	pinctrl-0 = <&pinctrl_weim>;
 	status = "okay";
 
-	nor: nor@0,0 {
+	nor: flash@0,0 {
 		compatible = "cfi-flash";
 		reg = <0 0x00000000 0x02000000>;
 		bank-width = <4>;
diff --git a/arch/arm/boot/dts/imx1-apf9328.dts b/arch/arm/boot/dts/imx1-apf9328.dts
index ee4b1b106b1a..f5015f5e808a 100644
--- a/arch/arm/boot/dts/imx1-apf9328.dts
+++ b/arch/arm/boot/dts/imx1-apf9328.dts
@@ -51,7 +51,7 @@ &weim {
 	pinctrl-0 = <&pinctrl_weim>;
 	status = "okay";
 
-	nor: nor@0,0 {
+	nor: flash@0,0 {
 		compatible = "cfi-flash";
 		reg = <0 0x00000000 0x02000000>;
 		bank-width = <2>;
diff --git a/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi b/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
index 56c790705155..bb1d0576732d 100644
--- a/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
+++ b/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
@@ -96,7 +96,7 @@ &usbotg {
 &weim {
 	status = "okay";
 
-	nor: nor@0,0 {
+	nor: flash@0,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "cfi-flash";
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
index 0935e1400e5d..e4ed62397d62 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
@@ -328,7 +328,7 @@ &usbotg {
 &weim {
 	status = "okay";
 
-	nor: nor@0,0 {
+	nor: flash@0,0 {
 		compatible = "cfi-flash";
 		reg = <0 0x00000000 0x02000000>;
 		bank-width = <2>;
-- 
2.43.0


