Return-Path: <linux-kernel+bounces-144088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E838A41B0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602132818ED
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4AE2E646;
	Sun, 14 Apr 2024 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2Npsp7Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C9018AF4;
	Sun, 14 Apr 2024 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713089051; cv=none; b=npeEHEhJmFR5rPCOQngNVXX5t3hig0wUzqmtmEVDOOiU13rLYerXZoRBzucfgLAbN1uDpYI8Y8RVqsuNH0nDLIRcd4+KOqJ8a1MfD5aFkMkihcn16d58VMVL3OYUE+QfkxCNJTSZGcMChk6xlWGiSscmqHDcdair6Q7Ga+EkuAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713089051; c=relaxed/simple;
	bh=84SLxTZp/DWUX/lhao6dmVikTW+EASr4F/Wo+VvHJ2Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qgP6EH3Yn+dRK4IIdKC2MZLUqJj8DSy2KuDliFqqiS/G/ylfHWpr8ApOYDyPEwUm8eE32MaguQuMoT+WGyt7diFsPKZq8RlaBCF2kKI8SZqM6LcZQKWPbroJbQvZV0DStIf95EYqif82mFfu8a48j79mHJ0Hvlyu0DY1Qce8vxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2Npsp7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F070C072AA;
	Sun, 14 Apr 2024 10:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713089050;
	bh=84SLxTZp/DWUX/lhao6dmVikTW+EASr4F/Wo+VvHJ2Q=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=o2Npsp7Y/2kFx6aWgxDP3pyAmSaJlirscJnkHNSwFto1h3wewpxzUxLZFOh4vsg7o
	 /OVOzCy6dndN0a9+9XCD796uTwrsaZoWiJxyTQpdgeiEFCc1tANwFbMLPLBVZ44X12
	 Q7UB5kwfdyY9WfHy1IpHYthPIH15v8vl1Ux7k7+XIVhh03xVhyGsrFBA734dt4JShs
	 4ofI649ZGqw8aM5YHrrTaj3gy+auhEYovYxG/S8+gAvck6qFvTPI7W7M7Ilhxfpiyu
	 9RIK+fBOVv4Wgh7lANfeEPg90P0xQ/0lPkL6QwLYYt91JDmAJHeA5ku2CQWQlONCHN
	 srxuAt5jEhKhg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77223C4345F;
	Sun, 14 Apr 2024 10:04:10 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Subject: [PATCH v2 0/4] DONOTMERGE: ep93xx-clk from ep93xx device tree
 conversion
Date: Sun, 14 Apr 2024 13:03:47 +0300
Message-Id: <20240408-ep93xx-clk-v2-0-9c5629dec2dd@maquefel.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAOqG2YC/22Nyw6CMBREf4Xctde0pVB15X8YFqVcpJGXLTY1h
 H+3sHZ5ZnJmVvDkLHm4ZSs4CtbbaUwgThmYTo9PQtskBsGEZJJdkOZrHiOa/oVloTTPC9VQqSA
 JtfaEtdOj6XZl0H4htxezo9bG4+VRJe6sXyb3PU4D39O/+4EjQ96wVppcyFKq+6DfH2qpPw8E1
 bZtPwK4zrS/AAAA
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, Nikita Shubin <nikita.shubin@maquefel.me>, 
 Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713089049; l=2238;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=84SLxTZp/DWUX/lhao6dmVikTW+EASr4F/Wo+VvHJ2Q=;
 b=z9XAN1DXXWE3QxCyuTkNMTNSk5hrGWnglICBc7KGTF+lnAe7G6ti2xpimedDy1Wf6oac/GtTG3kg
 fiFfdHpjAaVBVJ7+W+hyMLvKrp8qGPxNIM3ksHHchbay3miQxYWO
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

The goal is to recieve ACKs.

This is a fraction of v9 "ep93xx device tree conversion" series:

https://lore.kernel.org/all/20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me/

The clk driver for ep93xx was converted to AUX device, as suggested
originally by Stephen Boyd.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
Changes in v2:
- soc: Add SoC driver for Cirrus ep93xx:
  - added __init for ep93xx_adev_alloc(), ep93xx_controller_register()
  - added static, __initconst for pinctrl_names[]
  - clk revision for SPI is now resolved here through differently named
    clk device
  - more verbose Kconfig description

  NOTE: "of" includes are required unfortunately.

- clk: ep93xx: add DT support for Cirrus EP93xx:
  - dropped includes
  - dropped ep93xx_soc_table[]
  - add different named clk and dropped involved includes
  - moved pll's and fclk, hclk, pclk init to separate function
  - fixed ep93xx_clk_ids[] explicit lines
 
  NOTE: clk_hw_register_div() is clk-ep9xx internal function which uses
  devm.

---
Nikita Shubin (4):
      ARM: ep93xx: add regmap aux_dev
      clk: ep93xx: add DT support for Cirrus EP93xx
      dt-bindings: soc: Add Cirrus EP93xx
      soc: Add SoC driver for Cirrus ep93xx

 .../bindings/arm/cirrus/cirrus,ep9301.yaml         |  38 +
 .../bindings/soc/cirrus/cirrus,ep9301-syscon.yaml  |  94 +++
 drivers/clk/Kconfig                                |   8 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-ep93xx.c                           | 834 +++++++++++++++++++++
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/cirrus/Kconfig                         |  17 +
 drivers/soc/cirrus/Makefile                        |   2 +
 drivers/soc/cirrus/soc-ep93xx.c                    | 252 +++++++
 include/dt-bindings/clock/cirrus,ep9301-syscon.h   |  46 ++
 include/linux/soc/cirrus/ep93xx.h                  |  26 +
 12 files changed, 1320 insertions(+)
---
base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
change-id: 20240408-ep93xx-clk-657a1357de67

Best regards,
-- 
Nikita Shubin <nikita.shubin@maquefel.me>



