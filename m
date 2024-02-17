Return-Path: <linux-kernel+bounces-69748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 231E4858E09
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 09:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33182819F6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50421200A8;
	Sat, 17 Feb 2024 08:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="hFep6WkN"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310A51D551;
	Sat, 17 Feb 2024 08:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708158050; cv=none; b=UUV4fij6+agp2sUOhELNoLyd8t6NptuK0tsn2NNPlQ9/qaA9rk/Y0MZP5lsphAArfXrkfbATzDYJGtkftrvWNMO/pqIb8SbydAyYdvjcXkh12Q9cmKeq4oD/MiuQDvj9/hTEKkEm9P+t3e9dyCLszNOwqZil9pXmRZAAYSzwtGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708158050; c=relaxed/simple;
	bh=mTx5rLvb+qeLP7/2Etiy9qFxFZOTX39JjEhVVDlk1fU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pTChfyssq+/nXAW6xYklOFr9wGTjvo674jJuVOUia9GbvtDcVw/phdHwmW7AY857waud8BK6tUHPUNwJzuV7vvHeC9y4k9lyMzy+yt5WnkJJ30nwEifqv/L3sNK3hkrkiZ569q6IWMUYzElEBQJOU2LeDl57YRx1c+6K8lEjM98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=hFep6WkN; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=a89o6bX8GlKda8ggAeuclGq0WwOCA8K95wZOP4xrmIM=; b=hFep6WkNlk+zVzBjVwuuo3GwhI
	6fXDh0WoEC1rZW4IR39wUZhACUvzF72bzCixbYV3IPMNd+43bwBR+8pWAthCp3KwJms9JHJfN7OsX
	9TAOcINnv6+qGHWwUUOISeITVss4s9ZVX8ysXaRPq7gfcFUI+wnq1Cf0iHgXRdJQ6Nqed1X5HZvNH
	3DF7eHCgEtrKCoF6OSZcpDFesVc2PaiwNxyvGSR7k6j8OoqQtW+oloaeGxfQo9ErvUGbLpQokXwWx
	w1VvWiecB8+iug2rO4rRfMayYFYnfnLZNdXmU0FVjjrfozhW2lZPSBt3f0stnurivqyHLejDp797b
	74V9XOQw==;
Received: from p2003010777002c001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:2c00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1rbFw1-009WAY-V7; Sat, 17 Feb 2024 09:20:33 +0100
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rbFw1-00Dabs-1N;
	Sat, 17 Feb 2024 09:20:33 +0100
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
Subject: [PATCH v4 4/5] ARM: dts: omap4-panda-common: Enable powering off the device
Date: Sat, 17 Feb 2024 09:20:06 +0100
Message-Id: <20240217082007.3238948-5-andreas@kemnade.info>
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

As the TWL6030 chip is the main power controller here, declare
it as system-power-controller

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/ti/omap/omap4-panda-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/ti/omap/omap4-panda-common.dtsi b/arch/arm/boot/dts/ti/omap/omap4-panda-common.dtsi
index f528511c2537b..97706d6296a68 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap4-panda-common.dtsi
@@ -408,6 +408,7 @@ twl: twl@48 {
 		reg = <0x48>;
 		/* IRQ# = 7 */
 		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N cascaded to gic */
+		system-power-controller;
 	};
 
 	twl6040: twl@4b {
-- 
2.39.2


