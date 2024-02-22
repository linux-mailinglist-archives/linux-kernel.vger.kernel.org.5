Return-Path: <linux-kernel+bounces-77271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 879E98602EE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40EA02873CC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3DB6E5FD;
	Thu, 22 Feb 2024 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewFDjOQf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB0F548E7;
	Thu, 22 Feb 2024 19:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708630837; cv=none; b=OLgFwkEsgDAucY/SXnniqhcEo9wRPzp/KE7hEX5bN/Es5yK2Pbj0/QqTa+s2zDZOV3ineK6P7WoZlbgQBnARYsIBDNGM+UUEYiebY/AJ00Wnj6n4MTk8zujWtfUHhlbWgF4rbX9dpcBC9jHeGLNFjV+WcDpgMu0lRi1quB7mE7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708630837; c=relaxed/simple;
	bh=aEJwhXImnZlG7CDsaIYX4SI0jp1bWvk6d41It98Jybs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d095gVYuY8Q20GZG3GrSt0MxAX6bH9uG2LaunOH9paQtxZWEUgNvpqQWF1BNK7F3dTX0eKpZBuYQAqAf+yJwH3C3TbGZAJ8QtF0s8ON0i66Nj4NZRi9rKDLwUCccip5zMMMuY61z1FCZZOEJUEDxz9WY+GgM0vNpkoRgVi8Orpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewFDjOQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FE4FC433C7;
	Thu, 22 Feb 2024 19:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708630836;
	bh=aEJwhXImnZlG7CDsaIYX4SI0jp1bWvk6d41It98Jybs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ewFDjOQfu9nVhOPbo18S4GilBcFJD5VNt20ofD/5y7zXyaoDAF5xRvkBcvIyCC7Um
	 P2LBpPETFOvsummu2VB5++nzZpWOSyrMhwc/TxaR8L/IPfmu/pTTInHshqs6k3NeF+
	 no7Kngci8V+p1QfqfxLM205F3xAUoki/JobL773jxaYg25+l0s/xp+EGgBKzsW9LfZ
	 V+xWuuITIo52NKC6K3oJBobZp/syqRg29v6K/TaBcu47Nr2V7gSroyeA0MQS79vk25
	 yCvT773m557lm6RJ8+Rs9af3icfgGGaYQ2NAmjcMGE+nJUmdYmPExiavP5+6Q8QBos
	 L9hks9BBjdGTg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDCBC48BF8;
	Thu, 22 Feb 2024 19:40:36 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v4 0/7] clk: hisilicon: add support for Hi3798MV200
Date: Fri, 23 Feb 2024 03:40:10 +0800
Message-Id: <20240223-clk-mv200-v4-0-3e37e501d407@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABqj12UC/23MTQ6CMBCG4auQrq0ZplDAlfcwLkodpOGnpsVGQ
 7i7hRVGl99knndmnpwhz07JzBwF440d48gOCdOtGu/EzS1uhoAZYCq57js+BATgWpdakagkEbD
 4/3DUmNfWulzjbo2frHtv6ZCu13+VkHLgCiulCSuSQp7tc+qt7Y7aDmztBNzbYm8x2rookTKqp
 WyKXyt2FnFvRbSNgKLK6xxEWn7bZVk+buBEsBwBAAA=
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708630834; l=3178;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=aEJwhXImnZlG7CDsaIYX4SI0jp1bWvk6d41It98Jybs=;
 b=YqA4nNJSTfz8MeqQJgmJun8HZaAauoycAGFJWjwwixURnZVnFlg2+MRVianFBm/fcLTPkf6lp
 HbcUiBhCC9pCi8cLOgmwKIH80zVuMFLF365iowbQg2Upp7eAls+Rzn4
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

This SoC is similar to Hi3798CV200 with a few more clocks in CRG module.

Note this driver is still ongoing, many clocks are not registered in the
driver now. Feedback is welcomed, especially from HiSilicon people.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v4:
- dt-bindings: hisi-crg: add reg and #reset-cells to required, add reset-controller to required for cv200
- dt-bindings: hisi-crg: do not add "simple-mfd" and "syscon" for hi3519 (Krzysztof Kozlowski)
- dt-bindings: hi3798mv200: replace spaces with tabs (Krzysztof Kozlowski)
- dt-bindings: s/DTS/DT_BINDINGS_CLOCK (Krzysztof Kozlowski)
- Link to v3: https://lore.kernel.org/r/20240222-clk-mv200-v3-0-f30795b50318@outlook.com

Changes in v3:
- remove RFC (Krzysztof Kozlowski)
- rearrange patches so dt-binding comes before drivers (Krzysztof Kozlowski)
- dt-bindings: Remove lots of properties
- dt-bindings: stop merging all hisi-clock bindings, only convert hisi-crg.txt for now.
- dt-bindings: remove hisilicon,hisi-sdmmc-dll subnode (Rob Herring, Krzysztof Kozlowski)
- split histb-clock.h into two files, deprecate this header file
- fix all users (hi3798cv200.dtsi and hi3798cv200 CRG driver)
- hi3798mv200-crg: add a few missing clocks
- Link to v2: https://lore.kernel.org/r/20240217-clk-mv200-v2-0-b782e4eb66f7@outlook.com

Changes in v2:
- s/dt-binding/dt-bindings in commit logs: (Krzysztof Kozlowski)
- fix bot error by adding "hisilicon,hisi-sdmmc-dll" to syscon.yaml (Rob Herring)
- hi3798mv200-crg: assign fixed rate parents to some gates
- hi3798mv200-crg: s/ETH/FEMAC, add GMAC ctrl clock
- Link to v1: https://lore.kernel.org/r/20240216-clk-mv200-v1-0-a29ace29e636@outlook.com

---
Yang Xiwen (7):
      dt-bindings: clock: convert hisi-crg.txt to YAML
      dt-bindings: clock: histb-clock: split into two header files
      arm64: dts: hisilicon: fix include path
      clk: hisilicon: fix include path for crg-hi3798cv200
      dt-bindings: clock: hisilicon,clock-reset-controller: add Hi3798MV200 SoC
      dt-bindings: clock: hisilicon: add clock definitions for Hi3798MV200
      clk: hisilicon: add CRG driver for Hi3798MV200 SoC

 .../devicetree/bindings/clock/hisi-crg.txt         |  50 ---
 .../bindings/clock/hisilicon,hisi-crg.yaml         |  76 ++++
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi     |   3 +-
 drivers/clk/hisilicon/Kconfig                      |   8 +
 drivers/clk/hisilicon/Makefile                     |   1 +
 drivers/clk/hisilicon/crg-hi3798cv200.c            |   3 +-
 drivers/clk/hisilicon/crg-hi3798mv200.c            | 462 +++++++++++++++++++++
 .../dt-bindings/clock/hisilicon,hi3798cv200-crg.h  |  62 +++
 .../clock/hisilicon,hi3798cv200-sysctrl.h          |  17 +
 .../dt-bindings/clock/hisilicon,hi3798mv200-crg.h  | 150 +++++++
 .../clock/hisilicon,hi3798mv200-sysctrl.h          |  21 +
 include/dt-bindings/clock/histb-clock.h            |  70 +---
 12 files changed, 810 insertions(+), 113 deletions(-)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240216-clk-mv200-cc8cae396ee0

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


