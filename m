Return-Path: <linux-kernel+bounces-37677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B16283B37B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE59B1C23753
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CAF135A5F;
	Wed, 24 Jan 2024 20:59:34 +0000 (UTC)
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531C8135406;
	Wed, 24 Jan 2024 20:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706129973; cv=none; b=Y3iN56QNPpKuZsKmgRnhb8X9jRWs2U3S06ONkpoqbNKAUu8LEgjo7V5Q3e0VmuskfSZTgQ0PxSxPatRwObnWg5V2qu0IM5ifsG5yOq7tjJdp8MdV0jqpKWX37ihYNMTusdolttRmcXK3Cm0IuRzgqJgB23p+UND/1cWTGs6f0Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706129973; c=relaxed/simple;
	bh=G8A2V4leR/bypbOm6+EMWi8fEQbxiOfb61B5puKDZGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DMBospBLfxKos8W8Ai88KjKYAbT4bKtt4zZ3bMSjJr6KEIOEMgsGgVwQLV1SNS0tOMhogIfmw5HkHZiDc32uincDMHunqaKbPPAQtijYOerd0n2h42AMNLux12E5ovOCbCSo0wl7NOI+RzD/GC0rNiBgnRQWhAtLzKBjbsNsQHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from dslb-188-097-042-032.188.097.pools.vodafone-ip.de ([188.97.42.32] helo=martin-debian-2.paytec.ch)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@kaiser.cx>)
	id 1rSkL3-000SPR-34;
	Wed, 24 Jan 2024 21:59:14 +0100
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
Subject: [PATCH v4 4/4] arm64: defconfig: enable the vf610 gpio driver
Date: Wed, 24 Jan 2024 21:59:00 +0100
Message-Id: <20240124205900.14791-5-martin@kaiser.cx>
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

The vf610 gpio driver is used in i.MX8QM, DXL, ULP and i.MX93 chips.
Enable it in arm64 defconfig.

(vf610 gpio used to be enabled by default for all i.MX chips. This was
changed recently as most i.MX chips don't need this driver.)

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v4:
 - add a new patch to enable COMPILE_TEST

v3:
 - split the changes into three patches

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e6cf3e5d63c3..915c7c8fd13f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -632,6 +632,7 @@ CONFIG_GPIO_SYSCON=y
 CONFIG_GPIO_UNIPHIER=y
 CONFIG_GPIO_VISCONTI=y
 CONFIG_GPIO_WCD934X=m
+CONFIG_GPIO_VF610=y
 CONFIG_GPIO_XGENE=y
 CONFIG_GPIO_XGENE_SB=y
 CONFIG_GPIO_MAX732X=y
-- 
2.39.2


