Return-Path: <linux-kernel+bounces-71869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A0685AC14
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635261F22D85
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC50652F7D;
	Mon, 19 Feb 2024 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gyd1pS54"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067D450A6C;
	Mon, 19 Feb 2024 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371253; cv=none; b=LhvISgpG0eT0S0eFicpqF7YDHy83Mm02/FeFqGGuykCmt14Z3sCchOHvtGfNseDpowloIe5CzlXdbb4O8wStqirp061d+WrcL3Vae06mp/XFSRVIGMLkJVo4uBZc0pAsD3a9zxPBt+M0t0MFjWeoMjf7nPJLdoSDESOO/IZG8q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371253; c=relaxed/simple;
	bh=VBBzZL1sbQUWX8s7W+Rxhwa/GFzhUokChjTCd2OPvZs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fH4stJq/g2xcteTway5IC/cgfdK3DPd1D0olbCVU7jMPO1FGYVu7yFAWORuFSWpLcYGODxKuGQc4S4WdlskI84bppBmZSwtyfRb5vU1H+A3uOOAbeqbycg3Civnfih5FdeUbgoTOiY6TyaIzfvBTGmjYIllEnkbPXfhjxa7SzPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gyd1pS54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AF07C433F1;
	Mon, 19 Feb 2024 19:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371252;
	bh=VBBzZL1sbQUWX8s7W+Rxhwa/GFzhUokChjTCd2OPvZs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Gyd1pS549pPnd7m/NFFPI/ymrM9JzvQASr1cE7le5VovrX7iDzvOLbdq224OgmzuZ
	 f0g5Ons4BLlyB1vfPpn+hXKeJdRrIGRC6YUDMbQxjzSR2P9IYTjg3G7joDpZa2a1z4
	 zDt1k2/uDfMGALUnI9I5jqTOjpW2lQ2OBfhBDCoAUC58Y2AalQAegzoZveIVxYDa3p
	 1ZsblBg7QGS7noQiL0SYTqCj2LtSK97IdK6NXm6bh8LUtULqFaO0lC8F0Hg+aio2gk
	 7XBnY+IChaBEH4VVw2x/XVLl2NWmxm0A6w7lTgMLrSBeTtFBzEXAcXTyo33KDa2Aik
	 Gz3Rp2Yb3v8Yw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE30C48BF8;
	Mon, 19 Feb 2024 19:34:12 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v5 0/5] mmc: add hi3798mv200 specific extensions of DWMMC
Date: Tue, 20 Feb 2024 03:34:11 +0800
Message-Id: <20240220-b4-mmc-hi3798mv200-v5-0-f506c55f8e43@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADOt02UC/4XOwcrCMAzA8VeRnq00adpunnwP8bAtnSs6K5sWR
 fbudnr5PhQ8/gP5JQ8x+iH4UawXDzH4FMYQTznMciGarjrtvQycW6BCUoAga5J938guaFcWfUK
 lZGWcVp5bQGxEXjwPvg23F7rd5e7CeInD/XUjwTx9cwj2G5dAKumYLNcFmcrbTbxejjEeVk3sx
 Qwm/I1gRhQottrbCth8Ivov4r4iOiMtGLIEzpbkPhH6jdD8Sctc1kyF0fgfmabpCVjDUCaFAQA
 A
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>, 
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708371252; l=2929;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=VBBzZL1sbQUWX8s7W+Rxhwa/GFzhUokChjTCd2OPvZs=;
 b=n5seOJpVgcXJiNOqTira+AGmCcejJ0L9aGwGMx/FnEmrUqbYiOLwRaAR/f3DjVoRtGUAiVQqs
 IuS4i0xor2GDzp3eAtduPhhKV5D+NFAOYRJ9QETNFFKUrGIZe/G3drr
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

it's modified from hi3798cv200 driver, but quite a lot of code gets
rewritten because of the hardware differences. Actually cv200 DWMMC core
is called HIMCIV200 while mv200 DWMMC core is called HIMCIV300 in
downstream.

Pending on:
[PATCH] mmc: host: replace 1st argument to struct device * for mmc_of_parse_clk_phase():
	https://lore.kernel.org/all/20240215-mmc_phase-v1-1-f27644ee13e4@outlook.com/

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v5:
- pick the dependant patch: https://lore.kernel.org/all/20240215-mmc_phase-v1-1-f27644ee13e4@outlook.com/
  to fix the bot build error.
- edit the semantic meaning of hisilicon,sap-dll-reg property (Rob Herring)
  The suggestion is from the CRG driver side:
  https://lore.kernel.org/all/20240218205741.GA1561527-robh@kernel.org/
- Link to v4: https://lore.kernel.org/r/20240217-b4-mmc-hi3798mv200-v4-0-0fdd9bd48532@outlook.com

Changes in v4:
- rename dw_mmc-hi3798 back to hi3798cv200 - Suggested by Krzysztof Kozlowski.
- add r-bs to patch 1 and 2 - Reviewed by Krzysztof Kozlowski.
- Link to v3: https://lore.kernel.org/r/20240217-b4-mmc-hi3798mv200-v3-0-f15464176947@outlook.com

Changes in v3:
- dw_mmc-hi3798: fix bot error (Rob Herring)
- Link to v2: https://lore.kernel.org/r/20240216-b4-mmc-hi3798mv200-v2-0-010d63e6a1d5@outlook.com

Changes in v2:
- dw_mmc-hi3798mv200: use dev_err_probe() helper - Suggested by Krzysztof Kozlowski.
- dw_mmc-hi3798mv200: add missing err=0;
- dw_mmc-hi3798c(m)v200: remove unused MODULE_ALIAS() - Suggested by Krzysztof Kozlowski.
- binding: rename the binding, a lot of tweaks suggested by Krzysztof Kozlowski.
- Link to v1: https://lore.kernel.org/r/20240216-b4-mmc-hi3798mv200-v1-0-7d46db845ae6@outlook.com

---
Yang Xiwen (5):
      mmc: host: replace 1st argument to struct device * for mmc_of_parse_clk_phase()
      mmc: dw_mmc-hi3798cv200: remove MODULE_ALIAS()
      mmc: dw_mmc: add support for hi3798mv200
      dt-bindings: mmc: dw-mshc-hi3798cv200: convert to YAML
      dt-bindings: mmc: hisilicon,hi3798cv200-dw-mshc: add Hi3798MV200 binding

 .../bindings/mmc/hi3798cv200-dw-mshc.txt           |  40 ----
 .../mmc/hisilicon,hi3798cv200-dw-mshc.yaml         |  97 +++++++++
 drivers/mmc/core/host.c                            |   4 +-
 drivers/mmc/host/Kconfig                           |   9 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/dw_mmc-hi3798cv200.c              |   1 -
 drivers/mmc/host/dw_mmc-hi3798mv200.c              | 239 +++++++++++++++++++++
 drivers/mmc/host/sdhci-of-aspeed.c                 |   2 +-
 include/linux/mmc/host.h                           |   2 +-
 9 files changed, 349 insertions(+), 46 deletions(-)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240121-b4-mmc-hi3798mv200-a5730edf122c

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


