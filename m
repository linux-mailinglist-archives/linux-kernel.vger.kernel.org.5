Return-Path: <linux-kernel+bounces-37675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C0983B373
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA29C1C22A20
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8D71353E9;
	Wed, 24 Jan 2024 20:59:31 +0000 (UTC)
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9A31350CF;
	Wed, 24 Jan 2024 20:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706129971; cv=none; b=uAAxHPhw+RfsZYlI3v5cHHLE6gVXP8Iaw6/mYZCROfvkkDzhMp+uKr0ep61JFZrcLanmcKL9VueTAPfPjl9bYEesCXoUHqQwfagcYOwGaCZcv3lk3BnhOK+66dAm5c9f8NXlSWl8h5k10MC7pfgR8V6BXsD/slVlkQimo30IRrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706129971; c=relaxed/simple;
	bh=vdwlVXOvqU/TDeD5gJUt9sEEFVyptDTtGD4h21A3ijU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YhJ3e3MS6rzm6tnK/55zA1Ozc/xYga+86hpiQtktIDboWJNmuSdidCCKunIO6NBPx7uYVEWSdBzFAk2zy1UBzj/hPA8KE9olI3jAfw8SvG2TaOc6JRhCnuEt4+AoNHlvQwh33J9i/AZr9H0w3iIxUzx1iUNuWWqtzkk9Yr3w0XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from dslb-188-097-042-032.188.097.pools.vodafone-ip.de ([188.97.42.32] helo=martin-debian-2.paytec.ch)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@kaiser.cx>)
	id 1rSkL3-000SPR-02;
	Wed, 24 Jan 2024 21:59:13 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Shawn Guo <shawnguo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Peng Fan <peng.fan@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v4 3/4] ARM: imx_v6_v7_defconfig: enable the vf610 gpio driver
Date: Wed, 24 Jan 2024 21:58:59 +0100
Message-Id: <20240124205900.14791-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124205900.14791-1-martin@kaiser.cx>
References: <20240124205900.14791-1-martin@kaiser.cx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vf610 gpio driver is used in i.MX7ULP chips (Cortex A7, ARMv7-A
architecture). Enable it in imx_v6_v7_defconfig.

(vf610 gpio used to be enabled by default for all i.MX chips. This was
changed recently as most i.MX chips don't need this driver.)

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v4:
 - add a new patch to enable COMPILE_TEST

v3:
 - split the changes into three patches

 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 0a90583f9f01..3cdcb786f33f 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -208,6 +208,7 @@ CONFIG_PINCTRL_IMX8MQ=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_MXC=y
 CONFIG_GPIO_SIOX=m
+CONFIG_GPIO_VF610=y
 CONFIG_GPIO_MAX732X=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCF857X=y
-- 
2.39.2


