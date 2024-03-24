Return-Path: <linux-kernel+bounces-114025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B418887F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AB92B224A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EAB149E07;
	Sun, 24 Mar 2024 23:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wh+kRcmj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5D314EC41;
	Sun, 24 Mar 2024 23:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321320; cv=none; b=iCYlpDk9ru6OUVj2N5F/r9ghSQj2dxS3ikEqenai9A0a6DOXnwzrh7ubjSij8xhOEv0+Ej/zmmr27BEjxFZoVufJux3D4jrowweB4tdedEUHnjCtZcOYRT5l6iPjqMJUpZDKpugd3aq/OwweMDQurOWSnq3g48eUwDlWB0ODHa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321320; c=relaxed/simple;
	bh=n6A4tUBhWX7HwegfEx4yiXj5Dlp8rAGYSamdvQLeZP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jBgmoUD4sNrI9vXOvbbkv24jVOkLEQKi0dcs/1WI3BSsRUxstDVmtoIU1iKNZhulUhtMCIs7xfnqpZ617rhz4WmIgxbntbJBM4uEY1rdGiN0Tr9uOieZ2gpBJRGznWLixCIsgmWleneTm26GnfnDorR9J2vr5/SUbg8OnDlBiaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wh+kRcmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26116C43399;
	Sun, 24 Mar 2024 23:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321318;
	bh=n6A4tUBhWX7HwegfEx4yiXj5Dlp8rAGYSamdvQLeZP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wh+kRcmjqUNNbO5SOhE9nbB4dcMMwMSdwnxgOKR05nCPIamswDTieeg+fWgR3yNjw
	 CI4WrQ2Muctr1+07K128RkqGOwv6GBSzLoEfvESf4NkgHCscq1gSOQG89MveVAMBdy
	 wd9fET9tmGhc8aGbmAaA187ayvW91ZV5mApDRQM7m3YWzJPIuKt0+N/Je8UTG+juzm
	 u5Hh8QaKxEvThxjNfCf/t7HE5VHlEGgmXLn9C2OjSrlA3P/jUbniIhLM7zSFUmwaoi
	 k0vf/dmbTV/8dhu9b5PViNBQuWicyWjhVGYqG56YbtpY5EX9Rjsm4UVUkAU0pLt6a/
	 mgXZoC7+naF/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 041/638] ARM: dts: renesas: rcar-gen2: Add missing #interrupt-cells to DA9063 nodes
Date: Sun, 24 Mar 2024 18:51:18 -0400
Message-ID: <20240324230116.1348576-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 8c987693dc2d292d777f1be63cb35233049ae25e ]

make dtbs_check W=2:

    arch/arm/boot/dts/renesas/r8a7790-lager.dts:444.11-458.5: Warning (interrupt_provider): /i2c-mux4/pmic@58: Missing '#interrupt-cells' in interrupt provider
    ...

Fix this by adding the missing #interrupt-cells properties.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/a351e503ea97fb1af68395843f513925ff1bdf26.1707922460.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/renesas/r8a7790-lager.dts   | 1 +
 arch/arm/boot/dts/renesas/r8a7790-stout.dts   | 1 +
 arch/arm/boot/dts/renesas/r8a7791-koelsch.dts | 1 +
 arch/arm/boot/dts/renesas/r8a7791-porter.dts  | 1 +
 arch/arm/boot/dts/renesas/r8a7792-blanche.dts | 1 +
 arch/arm/boot/dts/renesas/r8a7793-gose.dts    | 1 +
 arch/arm/boot/dts/renesas/r8a7794-alt.dts     | 1 +
 arch/arm/boot/dts/renesas/r8a7794-silk.dts    | 1 +
 8 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/renesas/r8a7790-lager.dts b/arch/arm/boot/dts/renesas/r8a7790-lager.dts
index 5ad5349a50dc9..ab7e9fa90b9fe 100644
--- a/arch/arm/boot/dts/renesas/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/renesas/r8a7790-lager.dts
@@ -437,6 +437,7 @@ pmic@58 {
 			interrupt-parent = <&irqc0>;
 			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 			interrupt-controller;
+			#interrupt-cells = <2>;
 
 			rtc {
 				compatible = "dlg,da9063-rtc";
diff --git a/arch/arm/boot/dts/renesas/r8a7790-stout.dts b/arch/arm/boot/dts/renesas/r8a7790-stout.dts
index fe14727eefe1e..25956661a8754 100644
--- a/arch/arm/boot/dts/renesas/r8a7790-stout.dts
+++ b/arch/arm/boot/dts/renesas/r8a7790-stout.dts
@@ -332,6 +332,7 @@ pmic@58 {
 		interrupt-parent = <&irqc0>;
 		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 
 		onkey {
 			compatible = "dlg,da9063-onkey";
diff --git a/arch/arm/boot/dts/renesas/r8a7791-koelsch.dts b/arch/arm/boot/dts/renesas/r8a7791-koelsch.dts
index 26a40782cc899..4a76be68887b4 100644
--- a/arch/arm/boot/dts/renesas/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/renesas/r8a7791-koelsch.dts
@@ -800,6 +800,7 @@ pmic@58 {
 		interrupt-parent = <&irqc0>;
 		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 
 		rtc {
 			compatible = "dlg,da9063-rtc";
diff --git a/arch/arm/boot/dts/renesas/r8a7791-porter.dts b/arch/arm/boot/dts/renesas/r8a7791-porter.dts
index ec0a20d5130d6..fcc9a2313e1df 100644
--- a/arch/arm/boot/dts/renesas/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/renesas/r8a7791-porter.dts
@@ -389,6 +389,7 @@ pmic@5a {
 		interrupt-parent = <&irqc0>;
 		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 
 		watchdog {
 			compatible = "dlg,da9063-watchdog";
diff --git a/arch/arm/boot/dts/renesas/r8a7792-blanche.dts b/arch/arm/boot/dts/renesas/r8a7792-blanche.dts
index 6a83923aa4612..20963c9bbf0ad 100644
--- a/arch/arm/boot/dts/renesas/r8a7792-blanche.dts
+++ b/arch/arm/boot/dts/renesas/r8a7792-blanche.dts
@@ -330,6 +330,7 @@ pmic@58 {
 		interrupt-parent = <&irqc>;
 		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 
 		rtc {
 			compatible = "dlg,da9063-rtc";
diff --git a/arch/arm/boot/dts/renesas/r8a7793-gose.dts b/arch/arm/boot/dts/renesas/r8a7793-gose.dts
index 79b537b246426..9358fc7d0e9f6 100644
--- a/arch/arm/boot/dts/renesas/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/renesas/r8a7793-gose.dts
@@ -735,6 +735,7 @@ pmic@58 {
 		interrupt-parent = <&irqc0>;
 		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 
 		rtc {
 			compatible = "dlg,da9063-rtc";
diff --git a/arch/arm/boot/dts/renesas/r8a7794-alt.dts b/arch/arm/boot/dts/renesas/r8a7794-alt.dts
index 4d93319674c6e..3a9db455ddec9 100644
--- a/arch/arm/boot/dts/renesas/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/renesas/r8a7794-alt.dts
@@ -458,6 +458,7 @@ pmic@58 {
 		interrupt-parent = <&gpio3>;
 		interrupts = <31 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 
 		rtc {
 			compatible = "dlg,da9063-rtc";
diff --git a/arch/arm/boot/dts/renesas/r8a7794-silk.dts b/arch/arm/boot/dts/renesas/r8a7794-silk.dts
index b7af1befa126b..b825f2e25dd06 100644
--- a/arch/arm/boot/dts/renesas/r8a7794-silk.dts
+++ b/arch/arm/boot/dts/renesas/r8a7794-silk.dts
@@ -424,6 +424,7 @@ pmic@58 {
 		interrupt-parent = <&gpio3>;
 		interrupts = <31 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 
 		onkey {
 			compatible = "dlg,da9063-onkey";
-- 
2.43.0


