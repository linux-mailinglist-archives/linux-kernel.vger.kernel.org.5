Return-Path: <linux-kernel+bounces-31871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9378335B2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 19:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D138D1C20DEA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 18:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7FA13AC5;
	Sat, 20 Jan 2024 18:30:06 +0000 (UTC)
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8311EEC6;
	Sat, 20 Jan 2024 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705775405; cv=none; b=Hl7Xt8LnOjemToboGkSgQvaKEgvOUfnbQuyycEUwXbsxCJdjhX5wxWDz6l3AI/u0JOiTf9hT7pImO//hCYV6QSdgWWtX2lFtVGl647GNqKhyxMZEBx8BIA5qB3uja+MNKPxHNdOUh+Kk4X0fviQDDtsWf24Qyh4msWeVJ7KCYKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705775405; c=relaxed/simple;
	bh=402VGEfExEgOIX4MN7FxGefgsD24E3ZTdyyu/5bhCVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FVO/M8SfBJvliuT1SOwjrJ5l2VgrB+q+9L6gagCzGVlYyTyN4ZA6lfbYKZ8mk1ORQ4hZf7vqTHnFdobc0yn8J6M4kbr05+lnBRAzDhd1UcRgqwRfBm4RZu9Y7cF5H1o8/NiQcAEHLGBPPypu2+Q8hB0TfesmfpnQ3seM4fTWXnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from dslb-178-004-202-210.178.004.pools.vodafone-ip.de ([178.4.202.210] helo=martin-debian-2.paytec.ch)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@kaiser.cx>)
	id 1rRG6O-000BIC-1O;
	Sat, 20 Jan 2024 19:29:56 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Shawn Guo <shawnguo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Peng Fan <peng.fan@nxp.com>,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v3 3/3] arm64: defconfig: enable the vf610 gpio driver
Date: Sat, 20 Jan 2024 19:29:29 +0100
Message-Id: <20240120182929.1129183-4-martin@kaiser.cx>
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

The vf610 gpio driver is used in i.MX8QM, DXL, ULP and i.MX93 chips.
Enable it in arm64 defconfig.

(vf610 gpio used to be enabled by default for all i.MX chips. This was
changed recently as most i.MX chips don't need this driver.)

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v3:
 - split the changes into three patches

v2:
 - enable the vf610 gpio driver in the defconfig files for arm_v7
   (i.MX7ULP) and arm64 (i.MX8QM, DXL, ULP and i.MX93)

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


