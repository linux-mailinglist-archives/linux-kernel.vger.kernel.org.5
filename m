Return-Path: <linux-kernel+bounces-74521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A3D85D56C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8195EB22CA6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AF13F9F5;
	Wed, 21 Feb 2024 10:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jzlTAhMj"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2492E3F8D1;
	Wed, 21 Feb 2024 10:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708510998; cv=none; b=ZRX/K2QpygL21x3nVKJfonqssLLsg/J/DfnaFi6GS1WzIqm2giLRzY+ehxqyk2khFaybEmRIIo5yBdgmBL86QCrKwoDcurat96fn0Sq8qxewOSlwejbP6xLpZLp5E5qcfuCFcKvp7tmuSQOqhVTBPjiffm59ViACco7LTmBa0eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708510998; c=relaxed/simple;
	bh=CvoB1gOXxO0MxoxwC7GX+iWku3zqdOaKkxXzEtRJZ8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nVwNjtKUoAIb4bgFbrKvmQeQWrocmb4w+5SwJytyAhPJZdFRpGF1eKcJ+JImLyw13zb3uou+UMKXgXsWE6+7RNoMBoc0ES8huFQzqqm9svKsS4BcxaO8Jush9/sM3rcS7Unik6iN7qGF3dhuRnBxcW/2d/DjUrzQIGjUY+SuUZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jzlTAhMj; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 50BEB240012;
	Wed, 21 Feb 2024 10:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708510994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WleTd20PMIj2kUPD+6Y2hedislbfvKaEe57+SXEdJDY=;
	b=jzlTAhMjJkU6mA3eF9eQGhBxgwYTLPTu1vX/FjGNHbRckkCPa3zCZrvIXddM8L78cBiaY3
	CTRfstsXevICAOfuZHfPNlf0JqucSA7WoxdnrN6rthTaQV3eON5RewOOwyVMsJZjl4XYIl
	9a86Y01/LYJICcciA4y910SV6zjGAVNSElGjiZZDbnDc+eW/6ehPaZAWy68TlN7In2Vs9K
	5WWJrcpUGY6KAjHlAn2B461V+7kSPiXaU/8jAGHPGtiipezVymblQeeyDWUvctVD/NcyS6
	eQGehhLgJ4uAkrp9g+7VAZ+GXeX9NfejcvVxh37zL7dCp8W1XHw0eYHlypo+uA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 21 Feb 2024 11:22:49 +0100
Subject: [PATCH v3 5/7] arm64: defconfig: enable Rockchip RK3308 internal
 audio codec driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-rk3308-audio-codec-v3-5-dfa34abfcef6@bootlin.com>
References: <20240221-rk3308-audio-codec-v3-0-dfa34abfcef6@bootlin.com>
In-Reply-To: <20240221-rk3308-audio-codec-v3-0-dfa34abfcef6@bootlin.com>
To: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: luca.ceresoli@bootlin.com

This codec now has a driver.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

This patch is new in v3.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e6cf3e5d63c3..20650b03d25c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -981,6 +981,7 @@ CONFIG_SND_SOC_GTM601=m
 CONFIG_SND_SOC_MSM8916_WCD_ANALOG=m
 CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
 CONFIG_SND_SOC_PCM3168A_I2C=m
+CONFIG_SND_SOC_RK3308=m
 CONFIG_SND_SOC_RK817=m
 CONFIG_SND_SOC_RT5640=m
 CONFIG_SND_SOC_RT5659=m

-- 
2.34.1


