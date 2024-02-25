Return-Path: <linux-kernel+bounces-80345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 652EA862D89
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 23:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96CAF1C212E0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D7A1C2BE;
	Sun, 25 Feb 2024 22:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="ELa2MzcP"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E701CA83;
	Sun, 25 Feb 2024 22:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708901851; cv=none; b=WFL8A1qhCFbvpkGcnOlViMBPH2OBV374pglwieCMeMgCLSrgknQMtYs9Y6uJiqsD0IuOonWHYH7k+auJMXQJG+7yNDhzM+aS/QPMDbzIp9QIqRT0uDQ9a9ToZ4AVhdB+eeIr77vsva502QK1OruPBp6Cfaa6m2kOzC5jqrM5LOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708901851; c=relaxed/simple;
	bh=o5bX03US8Sve1tRCoSNZ35XHbWPiDIVPzkJeF2sRr4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lsdGHosn56P5iOzwFZilYqW0Swx7bxXUGR1I3+APhI6RUb20cfPCWw1MjxTUPXGsnIdIKuDNhA5Zk1D1qrPGNT33EsZ0E6T7PR6sVrj7zFY5p/MctGn4vLrDPQleGkwpaZWPGGvV50lMbaetV+od4MtAPLHiBX9SVvThWK77dXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=ELa2MzcP; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tL2xqaDy2Owl8JnIMnWmV+KkuV5UDXRRMqbcTjWXteg=; b=ELa2MzcPFuS5eN2BNsvmSFAtDc
	AWDYTXTOnDrV8D0cUS1BdGrm2tRxiEiE1/eHdWqZjZsP1B+Byxh3UQC8m3MBKnnO3PBXiSCWCZxtZ
	ERwcYZye+8jZkw/PkY1lBGVho+T5uUr9VbGachqQKNjyxKuqhGq09LPrmvOlWirMUCxd9HvTo4LmP
	R/CuRfwim1eT5Ib7hWXWUahTh7cCCnUxXCeW60M2Jg5spgnQRw1ozljkxqc+7qIX/VBeMpv8lzSIV
	z9B0K9zjBlbgD7LyzGrGwL9sjhHkm85E00GooZCyvLD6uV5Mncc0VEzBBFyFmHLWZrjntiJzGFNBT
	LozlCJUg==;
Received: from p200301077700b1001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:b100:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1reNQx-009mDz-CW; Sun, 25 Feb 2024 23:57:23 +0100
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1reNQw-00ELTZ-24;
	Sun, 25 Feb 2024 23:57:22 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] ARM: dts: imx6: fix IRQ config of RC5T619
Date: Sun, 25 Feb 2024 23:57:20 +0100
Message-Id: <20240225225720.3419129-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set interrupt type to level low to correctly describe the hardware and
do not rely on the driver to do the right thing.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/nxp/imx/e60k02.dtsi                | 2 +-
 arch/arm/boot/dts/nxp/imx/e70k02.dtsi                | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/e60k02.dtsi b/arch/arm/boot/dts/nxp/imx/e60k02.dtsi
index dd03e3860f97f..13756d39fb7b9 100644
--- a/arch/arm/boot/dts/nxp/imx/e60k02.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/e60k02.dtsi
@@ -127,7 +127,7 @@ ricoh619: pmic@32 {
 		compatible = "ricoh,rc5t619";
 		reg = <0x32>;
 		interrupt-parent = <&gpio5>;
-		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
 		system-power-controller;
 
 		regulators {
diff --git a/arch/arm/boot/dts/nxp/imx/e70k02.dtsi b/arch/arm/boot/dts/nxp/imx/e70k02.dtsi
index 4e1bf080eaca0..dcc3c9d488a88 100644
--- a/arch/arm/boot/dts/nxp/imx/e70k02.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/e70k02.dtsi
@@ -145,7 +145,7 @@ ricoh619: pmic@32 {
 		compatible = "ricoh,rc5t619";
 		reg = <0x32>;
 		interrupt-parent = <&gpio4>;
-		interrupts = <19 IRQ_TYPE_EDGE_FALLING>;
+		interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
 		system-power-controller;
 
 		regulators {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts b/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts
index 922749bf11bc1..04027627fe62b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts
@@ -161,7 +161,7 @@ ricoh619: pmic@32 {
 		pinctrl-0 = <&pinctrl_ricoh_gpio>;
 		reg = <0x32>;
 		interrupt-parent = <&gpio5>;
-		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
 		system-power-controller;
 
 		regulators {
-- 
2.39.2


