Return-Path: <linux-kernel+bounces-150479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911128A9FFF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C806284BA7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9E616FF23;
	Thu, 18 Apr 2024 16:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="d+hweNz2"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BEB16F8FC;
	Thu, 18 Apr 2024 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457592; cv=none; b=dUM1hv37mnTWyHxQZIwG91+WbntxRVPXYujCrDssaRijb6hEUoS/TDTHlQGEXi1OxrWsjzeu2cnFjBvKBduKF3DSRBaFyJ6OGl2GhwCNEhdzQhPVPDot9UsGnskmfPJFKoiuoLYd2foDtzoutpjjlMnddeqMVQIYnV9Uu6vGQ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457592; c=relaxed/simple;
	bh=s7R23NLs9UIvsLgJhX79KWcFfz2ljH8dt9paWDoR110=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c8nO3IViOYp34H75LZPTDmki51HoG7sx1coRz3wgjKarOAqfTmomkEgDwa+bNsB5OGsvNIEYL1VBX1rc34I7yuEw6opHUe9tYlGtTJBqGMPPGJcrebE18nLYwcr2TuTEUWA7Ayoo4XfmPZ+US5x2Uw0RYhSv6Zns4zr34+ZxvCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=d+hweNz2; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713457588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+wupbNxZE2H0FG5W1L+OSoGIdCRs9gwAXKL8/dQ4bBI=;
	b=d+hweNz2MFNfIGPfIJwYe2SfDIOZv9CjJ+tUb959aS3GJD28OEwC18sAR/gSblhcHzzMrd
	DqvVobSD8PxrL9ix0bVqd9uqh/Qix+NbFLocoLWP7Fw0MJ8YwcTogr5/rxss7SgOlzIIMJ
	gCNseL6X4XdtrMukk3eXn8a6JnfvEkxpN8fW8rSPQzFdZAZg1lzY04Oq+1svL2qQIQwceS
	DM/mhWKqjJu65gbShouULkP+j+FMQ9SBRJZuZsRXoWRPQRkpzz67PHexpxWex04uuwRPVA
	D2tTnuh2dNBMxcnTcbQhD0Z91g4gCOUmWsUbVg0Phe9X6rJCeApC2TVE8tbFhA==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	amadeus@jmu.edu.cn,
	FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH 1/2] dt-bindings: arm: rockchip: Correct the descriptions for Radxa boards
Date: Thu, 18 Apr 2024 18:26:19 +0200
Message-Id: <1e148d6cd4486b31b5e7f3824cf6bccf536b74c0.1713457260.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Correct the descriptions of a few Radxa boards, according to the up-to-date
documentation from Radxa and the detailed explanation from Naoki. [1]  To sum
it up, the short naming, as specified by Radxa, is preferred.

[1] https://lore.kernel.org/linux-rockchip/B26C732A4DCEA9B3+282b8775-601b-4d4a-a513-4924b7940076@radxa.com/

Suggested-by: FUKAUMI Naoki <naoki@radxa.com>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index fcf7316ecd74..ae58e25c29ec 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -705,7 +705,7 @@ properties:
           - const: qnap,ts433
           - const: rockchip,rk3568
 
-      - description: Radxa Compute Module 3(CM3)
+      - description: Radxa Compute Module 3 (CM3)
         items:
           - enum:
               - radxa,cm3-io
@@ -767,22 +767,22 @@ properties:
           - const: radxa,rockpis
           - const: rockchip,rk3308
 
-      - description: Radxa Rock2 Square
+      - description: Radxa Rock 2 Square
         items:
           - const: radxa,rock2-square
           - const: rockchip,rk3288
 
       - description: Radxa ROCK3 Model A
         items:
           - const: radxa,rock3a
           - const: rockchip,rk3568
 
-      - description: Radxa ROCK 5 Model A
+      - description: Radxa ROCK 5A
         items:
           - const: radxa,rock-5a
           - const: rockchip,rk3588s
 
-      - description: Radxa ROCK 5 Model B
+      - description: Radxa ROCK 5B
         items:
           - const: radxa,rock-5b
           - const: rockchip,rk3588

