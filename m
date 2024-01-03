Return-Path: <linux-kernel+bounces-15656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF63822FA6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385B128609E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D0D1A5B2;
	Wed,  3 Jan 2024 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="IvXmoJxc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFAC1B268;
	Wed,  3 Jan 2024 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rL2MW-0005mQ-LZ; Wed, 03 Jan 2024 09:36:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
	references; bh=Xt5kL03dGlCCOFmmhGy6NWYfXXspqCZA8XaL0CgGlg0=; b=IvXmoJxcBCyoV7
	b4ytFoxi5fnfD0fD/UM8kiRQwIYSswBxXEcd1Bv70Y3lw7AWzZyWUnws0xiOkhB3IDSWdbuwvJNAU
	p1Bp3bsgGqOjUOTY9BZoAmqEAfJyUhF175F6m1bDtb0DKEW43QMf2YAxNyePiu2/1lB2+xL27rKEm
	jsDHiiUaaBmT/cuoSmUs4umilgJqg7SU1bK0IjVAcjtxwxSQfKU5+DbXQYAwp15bwrAblR1j7CuDw
	zc3h5APMvJhmO7PSKaKXSVW13vyxCmQSZ+TUyXCgTlCOBA/HHhumCw9vh3ME4bhmsEp9v4hZFtcCv
	+4Y7XWDDIKDHURAbpZHA==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	Stefan Wahren <wahrenst@gmx.net>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH v5 0/2] Add Variscite VAR-SOM-MX93 support
Date: Wed,  3 Jan 2024 15:36:37 +0100
Message-ID: <20240103143639.32280-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey,

This is a v5 adding support for the Variscite VAR-SOM-MX93 SoM on Symphony
Board.

Thanks,

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
Changes in v5:
- Add gpio-keys and gpio-leds
- Enable lpuart6

Changes in v4:
- Add ethernet0 alias
- Remove useless properties

Changes in v3:
- Fix indentation on a continuation line
- Remove useless nodes and include

Changes in v2:
- Remove "nxp,pca9451a" block
- Fixed checkpatch warnings
- Fixed dtb_checks warnings
- Introduce dt-bindings documentation

v4: https://lore.kernel.org/linux-devicetree/20231227170919.8771-1-othacehe@gnu.org/

Mathieu Othacehe (2):
  dt-bindings: arm: fsl: Add VAR-SOM-MX93 with Symphony
  arm64: dts: imx93-var-som: Add Variscite VAR-SOM-MX93

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx93-var-som-symphony.dts  | 352 ++++++++++++++++++
 .../boot/dts/freescale/imx93-var-som.dtsi     | 111 ++++++
 4 files changed, 470 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-var-som.dtsi

-- 
2.41.0


