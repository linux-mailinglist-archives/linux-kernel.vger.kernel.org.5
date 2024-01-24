Return-Path: <linux-kernel+bounces-37674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BBD83B371
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDBC128619E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EA11350F6;
	Wed, 24 Jan 2024 20:59:31 +0000 (UTC)
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4CF1350D0;
	Wed, 24 Jan 2024 20:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706129971; cv=none; b=txH01z6qdr72hg/gtl9rRn6oq6VUqnx98Oa3ZVPrDldWwU+rhc+k3Zg4Mv0tmcvvhXAFzcR5gkBCMELSw6EyheNJTm5V83gW7pI+sR1Xwu6rurj4lkHIHnGdubcAfrecU3h4r8iEVidzvPZkCdnWP8S4+s/VR89psOvcxHD8zko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706129971; c=relaxed/simple;
	bh=7e5Izmg/91tveRQeeNZdkglwhXxoRY7LY+zlKksZL1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VDYaIlnHtfDevWOPsRuIdzsCO0aZTEd0tXVM1EsQLnrztKt8XlqEOttxrgTnNV42QG5d80gM/ug9yvmJShYGvt32gETS/bjwqYCPdtf7ddYKHEJ0ZNNXYG/WhcOuQMlxbJjXalpjJNUs9tPN43n5SO61vpz0hkyZlmih84Ww9cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from dslb-188-097-042-032.188.097.pools.vodafone-ip.de ([188.97.42.32] helo=martin-debian-2.paytec.ch)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@kaiser.cx>)
	id 1rSkKy-000SPR-1Q;
	Wed, 24 Jan 2024 21:59:08 +0100
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
Subject: [PATCH v4 0/4] gpio: vf610: allow disabling the vf610 driver
Date: Wed, 24 Jan 2024 21:58:56 +0100
Message-Id: <20240124205900.14791-1-martin@kaiser.cx>
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

While at it, enable COMPILE_TEST for the vf610 gpio driver.

Martin Kaiser (4):
  gpio: vf610: allow disabling the vf610 driver
  gpio: vf610: enable COMPILE_TEST
  ARM: imx_v6_v7_defconfig: enable the vf610 gpio driver
  arm64: defconfig: enable the vf610 gpio driver

 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 arch/arm64/configs/defconfig         | 1 +
 drivers/gpio/Kconfig                 | 5 +++--
 3 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.39.2


