Return-Path: <linux-kernel+bounces-103128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D2A87BB60
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B166284AC0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32D96EB47;
	Thu, 14 Mar 2024 10:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3npdZz2i"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BCC57330;
	Thu, 14 Mar 2024 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412551; cv=none; b=oRO1FBr6pRNGju4IjByGe18BP5jpvyH+6YlH6Aw+O8dweJMIVzIJgyV7GmSaMeeMHBWmnJeM3b9HKIh/l2URRWCUTRBwzrvVb7JUBUoFM0PgM+pZeECoRGaPMRuCl1rGjdi4/FIDeb1Y0lIr/3zq+86qqNw3K84f2NQK16eexVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412551; c=relaxed/simple;
	bh=J6gb1OM02C9ikyOM174uH6DQpHWs4urKUhlvpsHkC/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ABATL+5fUvjcevIw32cpee0MPPQ/D+pefgdoJ7GHFOWx7zZeDermocNehnc91yCPtzR2K7sKN79UsWjOlhoH/6erdKxusoHZJo/O5XrSh87on4WZHOcjH0gsMSQmGyqi0YcK2cD6dg1c3A+w417h80H7svc5nV1ea6wWpTHQ1Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3npdZz2i; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710412547;
	bh=J6gb1OM02C9ikyOM174uH6DQpHWs4urKUhlvpsHkC/o=;
	h=From:To:Cc:Subject:Date:From;
	b=3npdZz2i/ErBoZ0oKKMPq94oMjo2fcIql3voyUdnx2U42zfqXA6eRW2MTOLaaZtYk
	 2ulDO8hO2OnDUFwyeK8shrGfbjb8AtwkNcqVpx1A9eqAPcOuipirvqjPMrSVYtvGHS
	 3nZ1Y38qPseUJ2yjowGjdOUI651u8wj8Cys/BSxgQ+hzpQx1S/HRynbG1EAMNOBJHR
	 Vjdw7AhR/tvLi+e8lK9b0i9ywJ2nw14dVYuYpSXLIyO5HjqcgtN/PWKmiTsZWZRAoO
	 OIw7JSTMnGOs/XeszVmvj4b1+Yk8nW3Pw3cd+Z95uOlw6kLNPx5tbLMFgNCyfYt4QR
	 V8nFLp+ZC0NZg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E198537820EF;
	Thu, 14 Mar 2024 10:35:46 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	wenst@chromium.org,
	jenneron@protonmail.com,
	kernel@collabora.com
Subject: [PATCH 0/2] MediaTek: Add HP Chromebook x360 13b-ca0002sa
Date: Thu, 14 Mar 2024 11:34:58 +0100
Message-ID: <20240314103500.93158-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the HP Chromebook x360 13b-ca0002sa,
Cherry platform, codename Dojo.

There are very few differences with Tomato, and specifically:
 - Different touchscreen controller (still HID over I2C, different addr)
 - Different (dual MAX98390) speaker amplifier
 - Slightly different keyboard top row keymap
 - NVMe storage over PCIe0

This series depends on [1] the ASoC MTK cleanup, and was tested working
by PostmarketOS community members.

As for the changes in mt8195-cherry.dtsi: personally tested on MT8195
Cherry Tomato, no issues.

[1]: https://lore.kernel.org/r/20240313110147.1267793-1-angelogioacchino.delregno@collabora.com

AngeloGioacchino Del Regno (2):
  dt-bindings: arm: mediatek: Add MT8195 HP Chromebook x360 13b-ca0002sa
  arm64: mediatek: mt8195-cherry: Introduce the MT8195 Dojo Chromebook

 .../devicetree/bindings/arm/mediatek.yaml     |   8 ++
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 .../dts/mediatek/mt8195-cherry-dojo-r1.dts    | 114 ++++++++++++++++++
 .../boot/dts/mediatek/mt8195-cherry.dtsi      |   5 +
 4 files changed, 128 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dts

-- 
2.44.0


