Return-Path: <linux-kernel+bounces-135002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A52A089B9DC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456281F21701
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB72F4AEC2;
	Mon,  8 Apr 2024 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/4/QCWF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EB347F6A;
	Mon,  8 Apr 2024 08:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563810; cv=none; b=o8YfqP6vLiEGoCdbPtOYZfzvBxXsgjXuA4UbhCv0YuwURl+V/l2ZKT8am9U8SlsGwfAcNMWQzpHqKRLJb7hOXpTzY91JNe7w2TPFDeD+UutmcCTEuISBXmUBlI0Q3C6ZQOG/FlvbAkmCpeHg9wlcoL7Ap1RtrBY/4p5v5bHItQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563810; c=relaxed/simple;
	bh=IIA39zjHLzll86E9aMpUuAcvhrfq1ysOLkBGOaeDoyY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aJd+hrGgCtl07+6mzwF5wgBnKhWQqPG+aFkekju8R2qtglNBiL1By2/hShNNRvHhcV73OMJugqQ+3S1TmK8qtCZ9KFEwMKpxVNbmZpooApl17fXCTdIv25MHitUfBwPq63jQe8p6C+vddui3g852X0I1PzQ6KvWszoTjce7Dedg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/4/QCWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDA2CC43394;
	Mon,  8 Apr 2024 08:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712563809;
	bh=IIA39zjHLzll86E9aMpUuAcvhrfq1ysOLkBGOaeDoyY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=n/4/QCWFfHGh0rrTQ17mrgLgSDnHduSB00YXZtRGEJg4Hr8CfZ5XuDY6GVGQ+5O1A
	 D1YXZGIATxyHwvICJOTwf5ZeZVQh0jDMspG+sRl61bTpmPJ07tcwWaVXL0aU+xupFY
	 4OhJNi2MbNkKUozWwkquH/B7F0MYXyKjtgMtYKyWgH9R345Yl3vFTMoWrNniz4ujvl
	 xAh72fUsIDIXXYYJT5V6PeIBjQOLMd/eG/O/f6MdmNH3hmsqXjblRg5Wdfxe4fNETh
	 jQVBB2hcyK3Yw4Cx+SiZCuNYE/Yg1x3aRkGqqowMyyp0DSAYsxPomIIyaPcUZOzC11
	 VA8nDHV3b0n5g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B93CD128A;
	Mon,  8 Apr 2024 08:10:09 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Subject: [PATCH 0/4] DONOTMERGE: ep93xx-clk from ep93xx device tree
 conversion
Date: Mon, 08 Apr 2024 11:09:52 +0300
Message-Id: <20240408-ep93xx-clk-v1-0-1d0f4c324647@maquefel.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFCmE2YC/x2NywqDQAwAf0VybmB9bttfKT3ENWqobiUpZUH89
 649DsMwOxirsMG92EH5KybvmKG8FBBmihOjDJmhclXjGndF3m51ShiWF3atp7Ju/cCdhxz0ZIy
 9UgzzmaxkH9ZTbMqjpP/l8TyOH6ea6q51AAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712563809; l=1512;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=IIA39zjHLzll86E9aMpUuAcvhrfq1ysOLkBGOaeDoyY=;
 b=VrVRfqAJGBH1TITFNnree6/Us9PYdMLtl0Qns75QqpclZGI12eTYgimDEbaQtaCmo5HyyCKqye4S
 b9UycqxfAzF8HtZKL8jJJAmsAgmFG7MRjTlg8fqfD9DJ0646I32q
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
Nikita Shubin (4):
      ARM: ep93xx: add regmap aux_dev
      clk: ep93xx: add DT support for Cirrus EP93xx
      dt-bindings: soc: Add Cirrus EP93xx
      soc: Add SoC driver for Cirrus ep93xx

 .../bindings/arm/cirrus/cirrus,ep9301.yaml         |  38 +
 .../bindings/soc/cirrus/cirrus,ep9301-syscon.yaml  |  94 +++
 drivers/clk/Kconfig                                |   8 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-ep93xx.c                           | 840 +++++++++++++++++++++
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/cirrus/Kconfig                         |  13 +
 drivers/soc/cirrus/Makefile                        |   2 +
 drivers/soc/cirrus/soc-ep93xx.c                    | 240 ++++++
 include/dt-bindings/clock/cirrus,ep9301-syscon.h   |  46 ++
 include/linux/soc/cirrus/ep93xx.h                  |  26 +
 12 files changed, 1310 insertions(+)
---
base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
change-id: 20240408-ep93xx-clk-657a1357de67

Best regards,
-- 
Nikita Shubin <nikita.shubin@maquefel.me>



