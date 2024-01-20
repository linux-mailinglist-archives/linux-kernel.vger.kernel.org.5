Return-Path: <linux-kernel+bounces-31874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8410F8335B6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 19:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85EEAB22DB4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 18:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80857D53C;
	Sat, 20 Jan 2024 18:30:09 +0000 (UTC)
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444F014ABB;
	Sat, 20 Jan 2024 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705775409; cv=none; b=ahQ3f3i1x2UNgLxERS1jYuap1fU8kyrReiThgCJ2wlkqJ6IHL+DSNjHcDzoaKGiv2oJyodUO7uhZi9ck7ltnjiy76ytFoivt8f9DWwg0VbskibKMsKzjgDs2LUhIDhVxF+8Tcei9r1Nnjb7bNhQEIDyG5FWQW6BBzKNXjv6lz2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705775409; c=relaxed/simple;
	bh=WrEX1i32M8aWr3iINek/tl8q5EvuhzxOCpSuCgI0Rtw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qe/TORarVFY2gqbYbqrXfPbLXQj2ieLksW9vQeoLbLdKWpAtsn6HpqVhJ1YPXmrL/UGfHw8wbcXEvQY7AixGmSBVymchK8pQgssfUdas5ydNPb4jK0yDx5H0A2ykt/DTcl0u6Z7NYp8UFeJPmmnRxYuFrBSXFRB0bYKTSShvROA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from dslb-178-004-202-210.178.004.pools.vodafone-ip.de ([178.4.202.210] helo=martin-debian-2.paytec.ch)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@kaiser.cx>)
	id 1rRG6M-000BIC-28;
	Sat, 20 Jan 2024 19:29:54 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Shawn Guo <shawnguo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Peng Fan <peng.fan@nxp.com>,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v3 2/3] ARM: imx_v6_v7_defconfig: enable the vf610 gpio driver
Date: Sat, 20 Jan 2024 19:29:28 +0100
Message-Id: <20240120182929.1129183-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240120182929.1129183-1-martin@kaiser.cx>
References: <20240120182929.1129183-1-martin@kaiser.cx>
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
v3:
 - split the changes into three patches

v2:
 - enable the vf610 gpio driver in the defconfig files for arm_v7
   (i.MX7ULP) and arm64 (i.MX8QM, DXL, ULP and i.MX93)

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


