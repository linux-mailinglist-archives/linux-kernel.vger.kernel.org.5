Return-Path: <linux-kernel+bounces-10598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6308381D6C4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 23:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0C21F21E9F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 22:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7AB20B20;
	Sat, 23 Dec 2023 22:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="9VLlq4HG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891B118053;
	Sat, 23 Dec 2023 22:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=b1HMz+ohMNl8A5LPDegcPK2gw7uCgp/vFwsqaqz/imM=; b=9VLlq4HGCfbmZy4/v3pcoPm62r
	3S/m3nXnPC7Rnd9mF2GaAKPmFZS9SXBa4FDrLzxwoWKibvw+BEkYdvjqrwZAk3IyhsXbRpcqgULWg
	xnnvZzGQlUDEZ9ByXJa3Hk9/LHabwdJGzEhFJYGFXXctzQ3Y0rQrAtnHYMAZQcDaviz814EGIb49C
	NYOYCuGxOG6QfmYcxzqIXfQPf4a3Lnm7s4yfJ/KGeBd14L558JkdX4O/vz6161ML4zuNdp7Mzg8dr
	2DOxgVk01ZSb66MHawHK3SJlsHttSbEqucaxnmvbz/JTo071Swd001FIt7uzFUufYuEkNhARVdG3l
	hS2JwNBw==;
Received: from p200301077700c3001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:c300:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1rHAEL-007f7e-CM; Sat, 23 Dec 2023 23:12:25 +0100
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rHAEK-003FaM-2N;
	Sat, 23 Dec 2023 23:12:24 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	rydberg@bitmath.org,
	andreas@kemnade.info,
	linus.walleij@linaro.org,
	Jonathan.Cameron@huawei.com,
	u.kleine-koenig@pengutronix.de,
	heiko@sntech.de,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 4/4] ARM: dts: imx6sl-tolino-shine2hd: fix touchscreen rotation
Date: Sat, 23 Dec 2023 23:12:13 +0100
Message-Id: <20231223221213.774868-5-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231223221213.774868-1-andreas@kemnade.info>
References: <20231223221213.774868-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The display is in landscape orientation, but the touchscreen is in portrait
orientation. Specify that properly in the devicetree.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts b/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts
index 815119c12bd48..5636fb3661e8a 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts
@@ -141,8 +141,10 @@ zforce: touchscreen@50 {
 		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
 		vdd-supply = <&ldo1_reg>;
 		reset-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
-		x-size = <1072>;
-		y-size = <1448>;
+		touchscreen-size-x = <1072>;
+		touchscreen-size-y = <1448>;
+		touchscreen-swapped-x-y;
+		touchscreen-inverted-x;
 	};
 
 	/* TODO: TPS65185 PMIC for E Ink at 0x68 */
-- 
2.39.2


