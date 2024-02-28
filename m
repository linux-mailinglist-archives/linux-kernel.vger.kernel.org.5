Return-Path: <linux-kernel+bounces-84483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4D586A748
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FE6E28BB9E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66547200DA;
	Wed, 28 Feb 2024 03:45:57 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F431CD38;
	Wed, 28 Feb 2024 03:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709091957; cv=none; b=ooKFwjgeaiPVMZ37uQN4FHbMnHAavX85/2/xN59KluPQ0byZ7iKNc6bqogl62de+s9ExPtcmIF86Q9wlE7CdBBdpd90GZyJyyImMg26FjOwYOdbL9hW+KWksRvKcSiSS6knzsFJ+PlDgj1/P0j0sXhvqDN/jw3FfAqjINs0p1z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709091957; c=relaxed/simple;
	bh=nhjPA0+HwAIYi+aiuLTglwNbxfjzWgm1+msvVFndT/4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Qx8b4VptdZ5ppWGxHDOgXiqBsL/InaHKfA78sfgRE8O/dOBwgajvRa7HP5jO+ODIL5LEVTEEfMYTRCoo7h870cQOpVZgobrwjqR2ghIvvv+7jquq/GluypoXt/ZtdJH218tEL2QsHoFri4AxTjKTjp/mdbxLPm+dzVRFReu9OZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9595E2006F2;
	Wed, 28 Feb 2024 04:45:48 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5F4B52004CF;
	Wed, 28 Feb 2024 04:45:48 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id AB525180031E;
	Wed, 28 Feb 2024 11:45:46 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: shengjiu.wang@gmail.com
Subject: [PATCH v3 0/3] Add HDMI and PDM sound card for imx8mp-evk
Date: Wed, 28 Feb 2024 11:30:10 +0800
Message-Id: <1709091013-14026-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add HDMI and PDM sound card

changes in v3:
- split imx8mp and imx8mp-evk changes for HDMI audio. 

changes in v2:
- remove 'status' in sound-hdmi

Shengjiu Wang (3):
  arm64: dts: imx8mp: Add AUD2HTX device node
  arm64: dts: imx8mp-evk: Add HDMI audio sound card support
  arm64: dts: imx8mp-evk: Add PDM micphone sound card support

 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 45 ++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi    | 10 +++++
 2 files changed, 55 insertions(+)

-- 
2.34.1


