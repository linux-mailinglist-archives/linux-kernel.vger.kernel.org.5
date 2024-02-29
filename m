Return-Path: <linux-kernel+bounces-86287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFA086C369
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808A71C215A6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658D35025E;
	Thu, 29 Feb 2024 08:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="IBY8fre6"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B7E4EB5F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709195148; cv=none; b=ltKUHTVsznue2UN5J8wPZDIgt2n/la4RSUmwS9DHhtT1lnKq1Ev7YFgpbqHAccFLxeW46YdxS0oRgpSTF+kAp08nY3JgoQM7dok+kiJDBMkA2cj/yUN2kccKrB6KRtBiUQVuVDuIggdknMrXci9QXoIk0YNCLANj95T5zzhsALk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709195148; c=relaxed/simple;
	bh=Xrr2pQvNjK9HqdjZU0yutLs3+7x9Uaikc+0/N+mc4Nw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tQe3hGnjcMTRtFtChcneLM5uG6Ghtb9ZDHEhKBfkb6mRzu/N9UkntPzbXzgndWRDnp68Ddsp9BFCrYEGe/6oAJvtRfndqAx3jhnTBdkTKxGK4AEmy1Z0CSVI1Ih1O2au86dXShFR36wQy9WlZjBoeJ8j66BG24DajaTbBvfytYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=IBY8fre6; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id fTFqr6kN7PM1hfbi7rUPM8; Thu, 29 Feb 2024 08:24:11 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id fbi3rHZqtu3fafbi5rK4Cc; Thu, 29 Feb 2024 08:24:10 +0000
X-Authority-Analysis: v=2.4 cv=LsSUyGdc c=1 sm=1 tr=0 ts=65e03f2a
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=k7vzHIieQBIA:10 a=oz0wMknONp8A:10 a=vU9dKmh3AAAA:8 a=SsdV6KCYXRRehQAGIlkA:9
 a=rsP06fVo5MYu2ilr0aT5:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
	:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=M3fw+Np3S1U8MDlGpthERJ0UDarHWeHDvVRuxtYOYKU=; b=IBY8fre6bEtwsygBfag88/QM7V
	CBMahsiAY0kO6Cy5W9zDGIVFmrnuirpAVx/cdwQXntE3K0G3vK75XwojqYzyhb/RJwQpOKtiH2UcN
	YtlFU7ys/sPQyF351tCVdy8AZi4tmQbLQGYQYbYy+OdHRmPBT785HVq7oaxKvvTUPL6F1sK+bkggh
	iZYHLjy/OkHYVf+qYIY8FxJXaBmCYhoNDTgdocfuCNtFt9X1W4d1NNOsgChlNr2VEUpXL1SmJ6xXn
	eR4vwSKxogc0ThmKOOOek8EICpVQJciegbjZzKaGrCezAL+tVuJAtvDnOYq8vzSZ9pr1Y14a3L7UY
	3L+4ReHg==;
Received: from [122.165.245.213] (port=55676 helo=kural..)
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <parthiban@linumiz.com>)
	id 1rfbi1-0013bQ-37;
	Thu, 29 Feb 2024 13:54:06 +0530
From: Parthiban Nallathambi <parthiban@linumiz.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Parthiban Nallathambi <parthiban@linumiz.com>
Subject: [PATCH 1/2] dt-bindings: arm: fsl: Add Seeed studio NPi based boards
Date: Thu, 29 Feb 2024 13:53:36 +0530
Message-Id: <20240229082337.3090778-1-parthiban@linumiz.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1rfbi1-0013bQ-37
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (kural..) [122.165.245.213]:55676
X-Source-Auth: parthiban@linumiz.com
X-Email-Count: 2
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJWm2XY4iR0HyN7nqtFB6xyWV20fKbYMlcM0RSRrjHG5EUtECJJSTmVuMdLVSy6TS5pv//VKfRxOKstUun5cuWZwSry97F1GWI1AEVLV1vOIIy74tj8B
 CdPwkHEja6Cx8RyWyhzeH89D8KEbjmM24UqCN79dZOuRByl5KYD8BO6xNQIGHjDLyCn6luU0AELHKH33nde831KgnTzrWf+0LX4=

NPi i.MX6ULL eMMC/NAND is Seed Studios SoM using i.MX6ULL.
Development baords can be either based on NAND or eMMC
SoM.

Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 228dcc5c7d6f..dfe9ddd0872b 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -810,6 +810,14 @@ properties:
           - const: tq,imx6ull-tqma6ull2l      # MCIMX6Y2, LGA SoM variant
           - const: fsl,imx6ull
 
+      - description: Seeed Stuido i.MX6ULL SoM on dev boards
+        items:
+          - enum:
+              - seeed,imx6ull-seeed-npi-emmc
+              - seeed,imx6ull-seeed-npi-nand
+          - const: seeed,imx6ull-seeed-npi
+          - const: fsl,imx6ull
+
       - description: i.MX6ULZ based Boards
         items:
           - enum:
-- 
2.34.1


