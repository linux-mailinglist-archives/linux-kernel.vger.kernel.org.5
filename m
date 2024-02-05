Return-Path: <linux-kernel+bounces-52479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A349C8498C5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E4F2B254D1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09D318C3A;
	Mon,  5 Feb 2024 11:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TgPAjrgS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455A91864D;
	Mon,  5 Feb 2024 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707132366; cv=none; b=OOiM/2oCuj0G/puaRT1x8SeRYQSuYBkNV0QmGl0hnRRPVGMpm08T2fyBI1SaBvUD4UEpNhpLpiOvwD07YrTrZMbYehqFZERs88RGh1e5AgRLyKcroHFvbdrNei+KhTSAkZaHOT4Phk+O02Uxikn8uxWBH5oxv8IUCLTEX2bW1o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707132366; c=relaxed/simple;
	bh=HEFTrisHcwP/RUwGwlzUD3rlgftR0EEubBnkx8n5Y6o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MboTGskkyWWIyR+ev6cfjbyFBsrP0Fk2FAW0YfLIVSGDhrrBYpEdulkAsyuJABnPPzrchEJCEQpVSTR4uK5Ze40zUOVqz3wFaWkWBAFh1H9Wbua9sDZC7zj90x7mhlMoywIGlOcZjVP4s8bijg0AEoNr4dqq2Q4/ib3QFsj91cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TgPAjrgS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707132361;
	bh=HEFTrisHcwP/RUwGwlzUD3rlgftR0EEubBnkx8n5Y6o=;
	h=From:Subject:Date:To:Cc:From;
	b=TgPAjrgSt35SPVjCcqmmPj/tSXqjAbk4HD7ypkMPNnq4uEeG5UaPfN8sK25450VLM
	 9ilvuQHdgHWsdP8Ex2CLGEJ4muZ5Wqg5mdflZpGZmexoLCZljKlu53z3UcVKAzI6t+
	 M4Vd2668bc2SY90W4XseI8Kch8rde3ufYGM1jq7scSs0zRf850H4NSeDiZSiDw7puZ
	 xjbw/jXIwYAXG271YafuGuMxXYrI3nKU+VtyP9Ljy2a9UL4y6nIOGbGSI2Qa4I7Q6G
	 m9l0P16ACm/R2HsCIOEz+Edk+360NJ/4F4ntM0cmC3mS3cEBSZerJV7kW/JwzhnxXt
	 MeVQ3O2adLQkQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F1332378107C;
	Mon,  5 Feb 2024 11:26:00 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v2 0/2] Add support for RK3588 HDMI/eDP Combo PHY
Date: Mon, 05 Feb 2024 13:24:23 +0200
Message-Id: <20240205-phy-hdptx-v2-0-a7150814c047@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGjFwGUC/6WOQQqDMBBFryJZN5JEkdhV71FcjHFsBtTIREQR7
 97oqvsuHzze/4eIyIRRPLNDMK4UKUwJzCMTzsP0QUldYmGUKZU2Vs5+l76bl01aqC20leq0RZH
 8mbGn7W69m8Q9h1EunhF+CrrWdWFVlWtVKKNLqaVjigvBlDsKDoYF4eXCMEAbGHIXxqvtkxJ4v
 2+u+lr4o9ec5/kFnws8avkAAAA=
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Andy Yan <andy.yan@rock-chips.com>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Algea Cao <algea.cao@rock-chips.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, kernel@collabora.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-a684c

Add driver and bindings to add initial support the Rockchip HDMI/eDP TX
Combo PHY found on RK3588 SoC.

The PHY is based on a Samsung IP block and supports HDMI 2.1 TMDS, FRL
and eDP links.

Please note that currently only the TMDS related functionality has been
implemented.  This has been tested on Radxa ROCK 5B and Rockchip EVB1
boards.

Changes in v2:
- Rebased series onto next-20240129
- Removed patch 'dt-bindings: soc: rockchip: Add rk3588 hdptxphy syscon'
  already applied by Heiko
- For consistency with SoC TRM, replaced all references to DP with eDP
- Updated PHY schema per Krzysztof's review; also collected his R-b tag
- Dropped FRL, EARC and 10-bit color depth functionality until the HDMI
  configuration options become available in PHY API
- Squashed lots of regmap_write operations via regmap_multi_reg_write
  (Sebastian)
- Introduced parametrized {CMN|SB|LNTOP|LANE}_REG() macros to replace
  the long list of register defines
- Optimized handling of the config arrays by using ARRAY_SIZE() (Sascha)
- Link to v1:
  https://lore.kernel.org/r/20240119193806.1030214-1-cristian.ciocaltea@collabora.com

---
Cristian Ciocaltea (2):
      dt-bindings: phy: Add Rockchip HDMI/eDP Combo PHY schema
      phy: rockchip: Add Samsung HDMI/eDP Combo PHY driver

 .../bindings/phy/rockchip,rk3588-hdptx-phy.yaml    |   91 ++
 drivers/phy/rockchip/Kconfig                       |    8 +
 drivers/phy/rockchip/Makefile                      |    1 +
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c  | 1040 ++++++++++++++++++++
 4 files changed, 1140 insertions(+)
---
base-commit: 596764183be8ebb13352b281a442a1f1151c9b06
change-id: 20240128-phy-hdptx-8a98ab60d18e


