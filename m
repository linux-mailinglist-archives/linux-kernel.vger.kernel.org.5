Return-Path: <linux-kernel+bounces-156394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 994638B024F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E1B282010
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1351591F2;
	Wed, 24 Apr 2024 06:39:53 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C161591E2;
	Wed, 24 Apr 2024 06:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940792; cv=none; b=Lnu9kDLeAO9YN+BoTny3Kt1LjznnUqxZ/N0ZJ3BngAaaRpdyR/H85hX6m5fhjIFCisUxKfQYwA6tVbgWRtUxmbydTIczmpFVTjBdKdli5ajQbDUpbGOCWdNr2I3o/OC0HnWLQHNtp+Gl3yF5GBmbhzfsFxqb5a5GsqfV/bhkvK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940792; c=relaxed/simple;
	bh=rZBy/i+sD+VWCZ0HAIWMZJeuAKvsI/pfhC5oycrcFDc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=HO+seNae9B6dhMGkO4JJDaRz2Ny0ruVybnap5xd4RyalHIcZYAZKAJ5olB/1S9sKU1B98pyzQ1NLHPCM7QQOakuBM7D3t8M5O2Ux2TpKbnwI7mtHZfIL1reQ+LUTuNscvDRyf47zX60BPb1MOKkbw6h0TQOqmV9K125/ZaFjyic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 801211A22BD;
	Wed, 24 Apr 2024 08:39:43 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E16821A22EE;
	Wed, 24 Apr 2024 08:39:41 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 70D73181D0FB;
	Wed, 24 Apr 2024 14:39:39 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: conor@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	frank.li@nxp.com,
	conor+dt@kernel.org
Cc: hongxing.zhu@nxp.com,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: [PATCH v3 0/3] Add i.MX8QM HSIO PHY driver
Date: Wed, 24 Apr 2024 14:21:20 +0800
Message-Id: <1713939683-15328-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

v3 changes:
Refer to Conor's comments.
- Let filename match a compatible
- Refine description of the fsl,refclk-pad-mode.
- Remove power-domains description.
- Keep clock ording for two devices.
- Drop the unused label and status.
Refer to Rob's comments.
- Use standard phy mode defines.
- Correct the spell mistakes in the binding document.

v2:https://patchwork.kernel.org/project/linux-phy/cover/1712036704-21064-1-git-send-email-hongxing.zhu@nxp.com/ 

v2 changes:
- Place the dt-bindings header file changes as the first one
in the patch-set, make the annotation more clear, and add
Frank's Reviewed-by tag.

v1:https://patchwork.kernel.org/project/linux-phy/cover/1711699790-16494-1-git-send-email-hongxing.zhu@nxp.com/

[PATCH v3 1/3] dt-bindings: phy: phy-imx8-pcie: Add header file for
[PATCH v3 2/3] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY binding
[PATCH v3 3/3] phy: freescale: imx8qm-hsio: Add i.MX8QM HSIO PHY

Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml | 146 ++++++++++++++++++++
drivers/phy/freescale/Kconfig                              |   8 ++
drivers/phy/freescale/Makefile                             |   1 +
drivers/phy/freescale/phy-fsl-imx8qm-hsio.c                | 607 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
include/dt-bindings/phy/phy-imx8-pcie.h                    |  62 +++++++++
5 files changed, 824 insertions(+)

