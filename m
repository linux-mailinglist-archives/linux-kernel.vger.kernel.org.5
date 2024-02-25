Return-Path: <linux-kernel+bounces-80344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 798BD862D87
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 23:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB48228207B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7904D1BC58;
	Sun, 25 Feb 2024 22:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="yiePqQic"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331CE4EB20;
	Sun, 25 Feb 2024 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708901796; cv=none; b=gG4rK86lD2u4Oq9YCRRkhKm3lT+Sl8/SMLk1zZMMT9CaAJerzsXxO3iQxZ9iNkK3hNMzO/xmGRnYOlscJdZYSDmusfKzpii80H76fvE9wWtVmQSpDU8sIeW34pjuc5WugtbGzePhvD/kxI7HrnOnhASnJqPK+776RUoWio7wBog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708901796; c=relaxed/simple;
	bh=O9Vngy+bRYX7Ci9h3aCm4vsF88501smM+7GrX3xVzCE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NC7IuXzq3cey3slfuN463P0Eg2fUKVEqB2+goF49J4cLGyfu5DlBQRSBg50k2mwuhhQxTRxU1nLb+zn1pVGaKVpzOmqTrkR1qohy8XYGogv8v5KbraH+DKb1RlIBD/xSwhgye1O3TH7AEKshrQ2U4xdTJvvRz/QXYYwKfW8ysbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=yiePqQic; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ftFJcb2j+YtxD2/aw3NjN29F+pLKQHFtVTPjEz6SDiU=; b=yiePqQic1lFEU17BujkHphzNkQ
	9bsdehHZGSImUmm4lL/TPM52v4Nlk42e00+WCqXOt9TQA0CUiZzVYM9WaXZojkSvv9Vzga33HCUih
	MSN9FUjNQYDBxWT20/qc9644L1cCculAhKgtOcXkZ/jRQXOYa8HPTLFT9k3Gq4CKs2suLeCoBtPAw
	OOAFh/70dT/I+Ooy4RKHxVQihhTt//E22LWvFXIQYAMfYC3q3vBkSSCMfsO6mHjolW+RYLvkQtbYd
	pmw7pS9xhrlClKXivdqwTwUPeSYXYRiXvBJ87aNJA7I003CLKB1ujJKQLKkuZPbcK4ljePa55JPOz
	Cd1/Jagg==;
Received: from p200301077700b1001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:b100:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1reNQ3-009mDd-CD; Sun, 25 Feb 2024 23:56:27 +0100
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1reNQ2-00ELT3-22;
	Sun, 25 Feb 2024 23:56:26 +0100
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
Cc: Andreas Kemnade <andreas@kemnade.info>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] ARM: dts: imx6sl: tolino-shine2hd: fix IRQ config of touchscreen
Date: Sun, 25 Feb 2024 23:56:22 +0100
Message-Id: <20240225225622.3419104-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correctly describe the interrupt as level low. Driver enforces that
anyways, but do not rely on that in the devicetree.

Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts b/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts
index 815119c12bd48..922749bf11bc1 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts
@@ -138,7 +138,7 @@ zforce: touchscreen@50 {
 		pinctrl-0 = <&pinctrl_zforce>;
 		reg = <0x50>;
 		interrupt-parent = <&gpio5>;
-		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
+		interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
 		vdd-supply = <&ldo1_reg>;
 		reset-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
 		x-size = <1072>;
-- 
2.39.2


