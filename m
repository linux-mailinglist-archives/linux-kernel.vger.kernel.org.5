Return-Path: <linux-kernel+bounces-115296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 360C0889A88
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4F91F3321C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101861D4C59;
	Mon, 25 Mar 2024 02:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScMrPyjh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2E97F7FF;
	Sun, 24 Mar 2024 22:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320487; cv=none; b=hA7uP12VGygyAmfgW1F6dZzJ3qQrILMIMATddth5MFimrr1wnhmm+rnUhTO53nlOqyOfRf+nK+ACPoWH/Makq5oq4qBG181yD72SkOARvdFXpJJqR4K9vfo2SGek/v46yw2BK0qTPwCgRGIdFDDY0EXdCNLTukR3K2KTYNfe5FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320487; c=relaxed/simple;
	bh=Hydcgv3m0EEIxLFQJmaHc1+FBJMwBP1WrXhgZbFNRGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRcRWJQCESbVNnHHISETasXsIXy3hUiNoFSCo74KQi05bCQWU6Yt6/AXdW8dCdMnS5xp4EOnmz+tTkkhLpHBAIFpmKa6VCas15D3V9nkQ20fmLnDupYc9hGA/xEbJdQQ+2z3xrJnVL/r2oojU9AYrYE37CqamQGR7UttVlI5zzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScMrPyjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E86DC43399;
	Sun, 24 Mar 2024 22:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320487;
	bh=Hydcgv3m0EEIxLFQJmaHc1+FBJMwBP1WrXhgZbFNRGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ScMrPyjhCDXlaesphR9woe9CdyAt4wUhWUE1tTbaNWZTboSHAfBwyV7plyX1Z+gdY
	 9yAFp4EBK8T/fbgQTX1rycQKu/0ceeT7FAY3dXptUTNohZZOcbVlodwFVGjbPNhXqT
	 elai+R8IKtUSH/uSGndnd2i5ROs1SI2zYHGb4b7bYWHzKcwGb3Dm9QUqbacY0nGqQq
	 yodlTG6VMpmSGzwYCIpGRTm1Yg6bu9jrwnfUDXr89Wpttr/DMbUPkm3ebpbDNi52O+
	 UuSrDxjQVPCSKXVwkzJgJGxMHYNzRIYh7CJUYQyQF0iJQ+Ujnz/trnxK376/F3S6c3
	 fJu9mH5YTlR0A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 046/713] ARM: dts: renesas: rcar-gen2: Add missing #interrupt-cells to DA9063 nodes
Date: Sun, 24 Mar 2024 18:36:12 -0400
Message-ID: <20240324224720.1345309-47-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 4d666ad8b114b..b17a9f9307e59 100644
--- a/arch/arm/boot/dts/renesas/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/renesas/r8a7790-lager.dts
@@ -432,6 +432,7 @@ pmic@58 {
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
index 545515b41ea3f..ec01cc8595161 100644
--- a/arch/arm/boot/dts/renesas/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/renesas/r8a7791-koelsch.dts
@@ -795,6 +795,7 @@ pmic@58 {
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
index e793134f32a30..af16f251849c6 100644
--- a/arch/arm/boot/dts/renesas/r8a7792-blanche.dts
+++ b/arch/arm/boot/dts/renesas/r8a7792-blanche.dts
@@ -332,6 +332,7 @@ pmic@58 {
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
index 08df031bc27c9..73ec4d3541541 100644
--- a/arch/arm/boot/dts/renesas/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/renesas/r8a7794-alt.dts
@@ -453,6 +453,7 @@ pmic@58 {
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


