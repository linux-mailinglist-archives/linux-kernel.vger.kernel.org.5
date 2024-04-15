Return-Path: <linux-kernel+bounces-144682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 793048A4925
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D13280E2B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E7A364BE;
	Mon, 15 Apr 2024 07:35:41 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAB72C69D;
	Mon, 15 Apr 2024 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713166540; cv=none; b=O6IpQW8pVIwVFuWoDt2gYrJ38C8y2R+itjUmcblqV1RFqxGtn3SKD3/g11MIE/WvvZfSu31ov4rGc9pFUevvBl8bA+s7Ymcl68un7H1chJYgs62IpGkb9sisBYCkgr2R6wE6kSzeTDrBCiM914tGCwdlT586kQTVN1BLQok+xsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713166540; c=relaxed/simple;
	bh=tMhPX6/CEOlOG6cMkUOLb/uDvm16rguRgCsCYIerTXY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=rnIhEZcaFvlRWglas2gQetbRoqgzRpTZf6WeTl5Dm8I3gg5prvScoW6OuyW1pYiM9vlhbUuMCgPxxvWMCXT4MJsqC2mxGF+UA9QRhgUEFMwELh4lqasb6A+PtfCItLDYR9KCyKob/03OdL3NH/mwQUI6g0ZQPCwMqxUs45BmFRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D3D5D1A0197;
	Mon, 15 Apr 2024 09:35:31 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9CAB11A018D;
	Mon, 15 Apr 2024 09:35:31 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B69C9183AD16;
	Mon, 15 Apr 2024 15:35:29 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shengjiu.wang@gmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] ASoC: dt-bindings: fsl-asoc-card: Add compatbile string for wm8904 codec
Date: Mon, 15 Apr 2024 15:17:36 +0800
Message-Id: <1713165456-3494-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713165456-3494-1-git-send-email-shengjiu.wang@nxp.com>
References: <1713165456-3494-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The wm8904 codec is used on an i.MX95 Toradex board.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml b/Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml
index 42ca39eebd49..16093b48823a 100644
--- a/Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml
@@ -76,6 +76,7 @@ properties:
               - fsl,imx-audio-tlv320aic31xx
               - fsl,imx-audio-tlv320aic32x4
               - fsl,imx-audio-wm8524
+              - fsl,imx-audio-wm8904
               - fsl,imx-audio-wm8960
               - fsl,imx-audio-wm8962
               - fsl,imx-audio-wm8958
-- 
2.34.1


