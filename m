Return-Path: <linux-kernel+bounces-69746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0603B858E00
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 09:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A9A1C21102
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECFA1D537;
	Sat, 17 Feb 2024 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="HFgKWKF3"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501711CD28;
	Sat, 17 Feb 2024 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708158047; cv=none; b=I+9r1CRNoCYwIU1spbuB4oF29U69YtMzWK3upPvxuWKveM/IDam9yQi0Yy4XsIYKUvz8fxqqr3Wfmr4Xv/aIVLWOkbyp6NbI8yBrp7PT27T2xqIiA+d38qfdBESoyv8Z/L6WJhmOoknGFEUC9ktqtj+02daEI3syQttbo4DkKhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708158047; c=relaxed/simple;
	bh=PAuqh5EVeV6fdrZQXgisgrEu31gqCwBh1o5uwtMpIls=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QI/CKAO+4/Z5+Dp+XxBvktzUAbatlXSaBa8lXzuySRzRNFguqRC8iu4mBji4D0vP3EFk7oTYOlNTiXlQXsI98zDdlUvC7tTcmOANntecO4TsDqmEr5WFG6yQXkk+rWVmiYZVjmHqcXwy77f6tTZyiKmpe0+POW23dReBpCInn4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=HFgKWKF3; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Y+sKDGaqS2L6Nx5yacVQMNpKJL6zl7yFpsfABK8t+go=; b=HFgKWKF3hO8LSHBZAi+30+DVGV
	746TXBBVXztO3evsHoxXE328X4ITFEYgixAu2ZY4EvGxm+8Ip7Vj4rzhLlKs7ym+IYZOtfItnUhaW
	4hW6LLXQUAHiVll94R1mSZeoUlm+k+mNOqerfQf3WHEshabahHLd1eNp385ZytKH1bh99LYHcUmt7
	5gSc1pFLsz0TPXIHk+6IQ6NCenNI1lj9PA2ZpyBQ4B1eNpofMvsYKDusyrgOq3it9vwDzC5UAZtgR
	F6xXSUF7+qqM0ktD4FCTVzsboNKb9tonRDbvfsF8+5QwpysIYYxzbjGntnab8ASZ8LpqGUpPzxBr4
	RECTBKPg==;
Received: from p2003010777002c001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:2c00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1rbFw1-009WAQ-7k; Sat, 17 Feb 2024 09:20:33 +0100
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rbFw0-00Dabo-2I;
	Sat, 17 Feb 2024 09:20:32 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: lee@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	bcousson@baylibre.com,
	tony@atomide.com,
	andreas@kemnade.info,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: [PATCH v4 3/5] ARM: dts: omap-embt2ws: system-power-controller for bt200
Date: Sat, 17 Feb 2024 09:20:05 +0100
Message-Id: <20240217082007.3238948-4-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240217082007.3238948-1-andreas@kemnade.info>
References: <20240217082007.3238948-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Configure the TWL6032 as system power controller to let the device
power off.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts b/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
index 24f7d0285f799..339e52ba3614b 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
+++ b/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
@@ -85,6 +85,7 @@ twl: pmic@48 {
 		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N cascaded to gic */
 		interrupt-controller;
 		#interrupt-cells = <1>;
+		system-power-controller;
 
 		rtc {
 			compatible = "ti,twl4030-rtc";
-- 
2.39.2


