Return-Path: <linux-kernel+bounces-150184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B3C8A9B75
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F651F21994
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E63161933;
	Thu, 18 Apr 2024 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="c4lDgiMa"
Received: from smtpdh20-1.aruba.it (smtpdh20-1.aruba.it [62.149.155.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A781816078D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447758; cv=none; b=aD1d4QL3EJTGV4ezkZdDCT8XpYxQE2gLLeO8x1rgwGvMIXdG9RKgJkIX2yuqs+zw7TnnU5rVF3LHyXmREqMXKRqOpHS3hDf8W/au3qE4v6Op4nWZxzztE+parE1nngOQz7uUNSZPOWoAlkZVZrDTNAVqNbNQVXQgJYiKX9v6v18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447758; c=relaxed/simple;
	bh=6MUcUp/OtL7AaDM8zpiLYMwqSosY0z5R4WOeBTogrUI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S9QWaYEXddrjSVuMctJYYmAJ3/xvEvka0HiUYzMWpxvV2vfliHGcl+NXTqEu9vSaBtHz93lhFEgyIf22bYlLP6zY3j9r5cOJDdDwUdCqP8SZW7SwTFV0KQOqCBoU/LwWkBzZKZk5uMbeB08GQ0trUNURnRnFKRL/crRS9vxvAIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=c4lDgiMa; arc=none smtp.client-ip=62.149.155.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([146.241.28.123])
	by Aruba Outgoing Smtp  with ESMTPSA
	id xRz2rgYv8wWj2xRz3rpfsM; Thu, 18 Apr 2024 15:39:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1713447566; bh=6MUcUp/OtL7AaDM8zpiLYMwqSosY0z5R4WOeBTogrUI=;
	h=From:To:Subject:Date:MIME-Version;
	b=c4lDgiMaEfzTQb4VJSAWkmaql7rWCbFALx8/KIbI0AUQcKn8lO2GQikHBj2tAsMvP
	 t7ytW7OqaUJbC1t29idrNM4WO3SwiXxa6X5UJpWEfS25vGQaGqPAK3wuJkX4nyHWGD
	 dM759+/GOKtJ5Ib0kzZV+4JpibDxeanG4VPQ0+Y5gU/pRW0drPs8JEytICgDLAswis
	 U0yE34YFn46ROkdsTHuz8zZky2C5SxpTGWKyDkDAtGOL3dsDLeGEX2dXjpCRyVxKhU
	 b2sbUvWruvfNGMBj4u/zLNspEjI4Vj30NiONweVCd3O7zhZsnrGFGy1P/ZpyDARmc1
	 Lj0I3hIDxo9gA==
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fabio Aiuto <fabio.aiuto@engicam.com>
Subject: [PATCH v2 0/3] arm64: dts: imx93: add i.Core MX93 EDIMM 2.0 board
Date: Thu, 18 Apr 2024 15:39:20 +0200
Message-Id: <20240418133923.3705-1-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfLPJjMyjuC46EePe1tB96/9btQeWSPEKQd8nMiBOciL4/I/k80FuI2OCQZSoAVSxtrbAPJcmCyYr7zN2Fw1D1aVoW/BQPbue5kadG7bPGNMAufDG97zR
 DTIqauKgc9+6o3A9gWUxLdfPdffO5bPmcITi+l+SGWKlQd/50/HRzTN5I1YNukGWpWjsmWzwMMcp7fS6CijoGOs/M1k4aDlHU2B0owH6fYlzPJs6z1rJOr9Q
 KEzICuFcB1YT2e9Fgt54j5i0kg67C9B0OPFFFZKFC+TMlixLh82QUVskYpYwppc0AxmY0EL/lTktJ4uhGBsWnmryR7q+WdiIYZQx75MxGox1dwaIylCrUMCK
 T+0tqxV5rimIPXIpDEzbcGAK5EaSWyZxA/ueYpOme5T5muLhj70mfchdeOstxXKbxiZ3XDHirfn4wgSqulMemHR+AVqfeIr3tyYp1xPNefQHVTwvAgwwPn68
 YEuLqLh7EbUhIr752qtIEsA02mhyp9CwicUwTdPtN/EYxzSOQvRKUi5+dKhuz5dUQ9Z1jDRChR/mw4Yv

Hello all,

this patchset adds support for i.Core MX93 EDIMM 2.0 Starter Kit,
a SoM + Evaluation Board combination from Engicam.

The number of patch has diminished to 3, for I dropped the
patch introducing a change in nxp,pca9450 binding which has
been already submitted in regulator tree.

(Dropped also regulator tree maintainers as recipients for
they aren't anymore involved in this patchset)

Thanks in advance,

fabio
---
v1 ---> v2:
	- dropped patch updating nxp,pca9450 binding
	- fixed indentation issue
	- fixed missing space issue
	- improved naming of regulator nodes
	- removed unneeded include
	- fixed email recipients

Fabio Aiuto (3):
  dt-bindings: arm: fsl: add Engicam i.Core MX93 EDIMM 2.0 Starter Kit
  arm64: dts: imx93: add Engicam i.Core MX93 SoM
  arm64: dts: imx93: Add Engicam i.Core MX93 EDIMM 2.0 Starter Kit

 .../devicetree/bindings/arm/fsl.yaml          |   7 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx93-icore-mx93-edimm2.dts | 354 ++++++++++++++++++
 .../boot/dts/freescale/imx93-icore-mx93.dtsi  | 270 +++++++++++++
 4 files changed, 632 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-icore-mx93.dtsi

-- 
2.34.1


