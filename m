Return-Path: <linux-kernel+bounces-31870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D511C8335B0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 19:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC172B21900
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 18:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFD2125C7;
	Sat, 20 Jan 2024 18:30:05 +0000 (UTC)
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2005011733;
	Sat, 20 Jan 2024 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705775404; cv=none; b=I+qzzsW3ciQTgxjBLcVYmaUUvuS96jrmW5M6YLYhXg7n2HVlFJkDzu0Yw2Zb9Oz3y0ccqqROVNcArQzPK48iaMvK0xOTJDBVlyusJds1X6XzqFETlT1Qny9rgefIkSfWkUqOR2meP9zk/pCr7TSuLN+qh9PjpDgcGHzgB8f7kmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705775404; c=relaxed/simple;
	bh=uIPdtkbBt+Jh4Hvciji0ddUOb1PyIPzOde60CEcpvtM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jmqps3NMiLyBZG1bYnQrYU8eF+b/jFbUmc/sWulKzPc67A2AkrU2sqocgEslhKjH2xFPTUfJksXpJIXEDBDepxRHtkq+0e4zt+neePchqOFiXiMYKkDleE7Y255cBtCMeQog1Ti9m4liGPS2mU2A08pVyAWlYR3xp8AOWZZAM48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from dslb-178-004-202-210.178.004.pools.vodafone-ip.de ([178.4.202.210] helo=martin-debian-2.paytec.ch)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@kaiser.cx>)
	id 1rRG6H-000BIC-0W;
	Sat, 20 Jan 2024 19:29:49 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Shawn Guo <shawnguo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Peng Fan <peng.fan@nxp.com>,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v3 0/3] gpio: vf610: allow disabling the vf610 driver
Date: Sat, 20 Jan 2024 19:29:26 +0100
Message-Id: <20240120182929.1129183-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vf610 gpio driver is enabled by default for all i.MX machines,
without any option to disable it in a board-specific config file.

Change gpio's Kconfig to allow disabling this driver. Disable it by
default unless we have a vf610 soc. Enable it in the defconfigs
for the i.MX chips that need it.

Martin Kaiser (3):
  gpio: vf610: allow disabling the vf610 driver
  ARM: imx_v6_v7_defconfig: enable the vf610 gpio driver
  arm64: defconfig: enable the vf610 gpio driver

 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 arch/arm64/configs/defconfig         | 1 +
 drivers/gpio/Kconfig                 | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.39.2


