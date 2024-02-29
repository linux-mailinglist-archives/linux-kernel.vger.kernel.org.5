Return-Path: <linux-kernel+bounces-87481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7F186D4F6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577DB281E6D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C2614F9D8;
	Thu, 29 Feb 2024 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sm3+t92G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7A374C11;
	Thu, 29 Feb 2024 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239232; cv=none; b=eRe3/MFK6IY95k2sW3Gjbm0a91N2ZQJdMxfSQWbbJfwPBqd1BDy2iVvofTtHD99UzD59ew9S2f1nPwWzCRxXXjmHtSHwNWWasjUBXrspP7jv0M6ahE58Q0rMZ6Aw7JGbnW40CG2Luyub5ih/M0iVsSE6pQguN+hmMD7I+4rnDYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239232; c=relaxed/simple;
	bh=n6A4tUBhWX7HwegfEx4yiXj5Dlp8rAGYSamdvQLeZP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAZB/edwHeZasHJG0nldCQBfegzG0o7+GycsRauN5Cc6gNiUrdYxmf7t9zR0So/iyPMsnQGToPui9Q0VsZt0SRT+xpWg6uyAQNBYctjKFDtkIytJNc8m69sDA4Y1USsKMl5ma8gN/byK8wdacjVJMVbHU4fWMsfFn1aCZzPkjhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sm3+t92G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E2EC433C7;
	Thu, 29 Feb 2024 20:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239232;
	bh=n6A4tUBhWX7HwegfEx4yiXj5Dlp8rAGYSamdvQLeZP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sm3+t92GnfLErmDqUsdTGMm3eIbFaK9857pqycGgIe68pYPTK/xH2rs2e2bDWXdai
	 KdWNw1VgTZO/Tlo5k2xxTM2NOlfUwD9wFdnUFKQGXhwoWNKrEToE8SCJc0AfhIup5v
	 YnY5gWyd+goJhuZ3n8shed4rBFiFX3HBDWPu2R6pfkwrVwM3uL501Y/LIGVbEzdoBF
	 2ySrYKI6HMSEo2XttKZdIDhlv/lSzFmP9wow4Bh8BB+73k73S0MZvFUO8LYfqZaZuq
	 JbhWDOfd4sIszjVo7nZpNKapZkUD0fdKokuhzsAazpXfQbDY9LvFMI0zO+IX7woHPZ
	 KIPxLfPcFhoYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	magnus.damm@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 22/22] ARM: dts: renesas: rcar-gen2: Add missing #interrupt-cells to DA9063 nodes
Date: Thu, 29 Feb 2024 15:39:15 -0500
Message-ID: <20240229203933.2861006-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229203933.2861006-1-sashal@kernel.org>
References: <20240229203933.2861006-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
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


