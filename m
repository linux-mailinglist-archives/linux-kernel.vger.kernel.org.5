Return-Path: <linux-kernel+bounces-103375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DAF87BEB3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7475E1C210D1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F77070CA0;
	Thu, 14 Mar 2024 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="R49TF6P4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="AP/A3Cp1"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B26F6FE0A;
	Thu, 14 Mar 2024 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425867; cv=none; b=T4VwumHSWZ56S3uONjtdNnPvTiX8KCJJYrTGSvQ4I1uVU5c7SMkfBbVMUIromOcoSdxEQsO7eND4kk1znSyIMg0ubcy/hWYwK7BkWsWRh8unna/uQs5Bj+F/0PFhLFmtpe526zpeVAUtvKVJBqgfyT7zzhZRzYJYXrQxwIOGcPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425867; c=relaxed/simple;
	bh=3T0nZYw/Vu3MmuK8V/lGVF5Avsur+Dcj0IraJ2AOBYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j0P9oKVXAOk40cBonE+9HlsA0j01ngauAqKu3LTiOqEXSCG2CS+VtAsnI+J23tzRkIkLeu8H0LCaiDcJjscdiOGThlLnFjK2tIjQvi4CUQWEwT3pRr58Rz0Ar8eB2iJUtRpsjXgutEdVAgJwPzPVMN2SR6t2af+ndvYVLf1De+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=R49TF6P4; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=AP/A3Cp1 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1710425865; x=1741961865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2czTNmO6Hvzk6slEUxrfQsMvIr0fj9UZv80dzMCqHbo=;
  b=R49TF6P4JipaqGW0601Q7xSXd6rd/H10Q4gPZq/CTncKIY3kymKWbtTF
   8T8XsgOdg8nXVDcnErSiAc4M+k5g1izitlKQZ+YEW9Xheo1ZHlADoeu9S
   II865AtBkDEWIkaEqE93ybJWiDu7zVeDaUkt8bcd6tTwJMOoItwPI0oT7
   tSCH5ZTh0ZVSErjvGXJvDbXGJxfusRqJimSv0tAyjshZsLzgBIQ3e5eg/
   +HNkjiqH36mGwotd6nNrNLZloQpz7ZPNwsYBBePgmqYHWo847XMja4hrx
   3EA2g6zm/u/DUBL9rd9WpTGCfwK6xZEq5TkL3M1NnwV8btV8pOSdyS7L9
   Q==;
X-IronPort-AV: E=Sophos;i="6.07,125,1708383600"; 
   d="scan'208";a="35915610"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 14 Mar 2024 15:17:44 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B68816FD1A;
	Thu, 14 Mar 2024 15:17:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1710425860; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=2czTNmO6Hvzk6slEUxrfQsMvIr0fj9UZv80dzMCqHbo=;
	b=AP/A3Cp1oCMW6rOk1abj2tGMowSyeNxmA+g1JUtL3DmSbk9QNQQyWMywxNFrCUQAej4JNK
	bYO3UFLLkwoJuDFv16hIqN3Kg6M1MZs5wTxKfg1hd3POk16xRvAnbOSaA6WQu+r+AE/9GW
	TOEe3Wh4/kYnhYNdesMRAjkEbTNcj27Ueg0YPWrJU74dCgSIxT7zLGZjUp+op8eYG+QIJY
	016/hUSeeecxNu6Q8LfXpDs1mGmYHNMd/waLJsIeV/rzMepDQkzrmCZrY0ZlmDthfYSWX3
	HM7ddfjrZLD9XM2OSv/vNzp68AzFMfa0+Pmfw6Kn/223+Da012hA+p7qmU4McA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: imx6qdl: Remove LCD.CONTRAST pinctrl from muxing
Date: Thu, 14 Mar 2024 15:17:36 +0100
Message-Id: <20240314141736.2943858-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240314141736.2943858-1-alexander.stein@ew.tq-group.com>
References: <20240314141736.2943858-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

GPIO4_IO20 is unused on MBA6x, unless LVDS display is attached.
Remove the pinctrl for GPIO4_IO20, so it can be used otherwise.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi
index 9bf1cc6f508d..60aa1e947f62 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi
@@ -442,8 +442,6 @@ MX6QDL_PAD_EIM_A25__HDMI_TX_CEC_LINE 0x1f8b0
 
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
-			MX6QDL_PAD_DI0_PIN4__GPIO4_IO20 0x0001b099
-
 			MX6QDL_PAD_ENET_RXD1__GPIO1_IO26 0x0001b099
 			MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x0001b099
 			MX6QDL_PAD_ENET_TXD0__GPIO1_IO30 0x0001b099
-- 
2.34.1


