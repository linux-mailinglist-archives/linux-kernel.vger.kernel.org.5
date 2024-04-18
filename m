Return-Path: <linux-kernel+bounces-150132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCC18A9ADA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938DB1C211AB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC12915AAB7;
	Thu, 18 Apr 2024 13:07:24 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C9A84D02;
	Thu, 18 Apr 2024 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445644; cv=none; b=a+2pidHzKPsKyErdRulXLdoXWflaj9H2pKz4yHlWGzKbBSQ7kM1B3oVFt2qMuNxeTR8c0DpOtU06P4FRZNHl+9rF+Ze2Mq+lgjodwwZeqGoj2lwznrmgPKEQ1I6JDwdGuQxvpUnbSzQEHgRkc5uS4PcwBjmsSok0B0YbsVyX+HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445644; c=relaxed/simple;
	bh=wzYXTTZodLpHWmXLYPOfb429W7+YUKyQjonKJgIFyAg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HbV4j7ZS8m6C5XcgSOp4VOyTRu5RwN0S0B+ros2OhJbWpLyKdK3wvCq5+elgbgefTGtWSDrboBLcvBBNFWtsiPL1SK1sKzNL1GoORSu11jkq4FeJO+44lfjhZTwzY2ppcgGuDGw0HOWWSIW+3wgleuEkTwXNojrK2qwpgIx6esE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:5e10:18fd:e06e:24de:a3c9])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 9188C7E0172;
	Thu, 18 Apr 2024 21:01:25 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>,
	FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH 1/2] dt-bindings: arm: rockchip: correct the model name for Radxa ROCK 3A
Date: Thu, 18 Apr 2024 21:01:19 +0800
Message-Id: <20240418130120.67663-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCT0pJVkwYQkkaTEwfSR0fT1UTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0tBTh5KS0FKQx0fQR5LTR5BSU8fHkEaSBhCWVdZFhoPEhUdFF
	lBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a8ef14c2fc803a2kunm9188c7e0172
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mzo6ORw5SjMcQkozDC0*UTdI
	Gj1PCTRVSlVKTEpIT09OSUNNSkxJVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBTh5KS0FKQx0fQR5LTR5BSU8fHkEaSBhCWVdZCAFZQUlJTkg3Bg++

According to https://radxa.com/products/rock3/3a,
the name of this board should be "Radxa ROCK 3A".
Also update compatible to match the model name.

Suggested-by: FUKAUMI Naoki <naoki@radxa.com>
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 99bd5e2c76a0..88e9e0011953 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -772,9 +772,9 @@ properties:
           - const: radxa,rock2-square
           - const: rockchip,rk3288
 
-      - description: Radxa ROCK3 Model A
+      - description: Radxa ROCK 3A
         items:
-          - const: radxa,rock3a
+          - const: radxa,rock-3a
           - const: rockchip,rk3568
 
       - description: Radxa ROCK 5 Model A
-- 
2.25.1


