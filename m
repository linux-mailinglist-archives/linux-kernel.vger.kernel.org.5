Return-Path: <linux-kernel+bounces-161424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D31A8B4BC7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E8A1F21AE7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9406BFA4;
	Sun, 28 Apr 2024 12:42:46 +0000 (UTC)
Received: from mail-m92102.xmail.ntesmail.com (mail-m92102.xmail.ntesmail.com [103.126.92.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F1D53E0D;
	Sun, 28 Apr 2024 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.126.92.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714308166; cv=none; b=StCkxU9h8uDW17nQrgbjAZmuF1an5lwH+fbUELf/7b0YAH5Nmbv56jvJQHTpY0zabFZe4AQtcSuKXbm3ylr+j0XueRI29rzGTFuD+t4/8btWgL3qQyYNuM0S1ggPb8TSh1g3AEJIHvCueVHCmut3u+M8H8jAmE4PcG59p2V4cBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714308166; c=relaxed/simple;
	bh=pYH3MW6UZKTfpCgbG6Ne2hDDEvhTdlGJWmkhcaMOB38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E/2oJ1nClXckkYLK1ZjEGPl5TAccJIcnDT7owd0C77tBf/B1zjF96o2vcKFxynlHig0gFJIVvYw52vfKsV5ACVZhnT7xL+tYPp1yST2Zc+MbKPJmPDJJaNrDdaO6E9Lc3ja/6cTqSwIm7OllgNF2uHOC51W/lYh54Edsg48X6NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=103.126.92.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:6c50:87d:6be4:19e8:d47])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 72D4A7E012E;
	Sun, 28 Apr 2024 20:36:46 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: rockchip: add Radxa ROCK 3C
Date: Sun, 28 Apr 2024 20:36:17 +0800
Message-Id: <20240428123618.72170-2-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240428123618.72170-1-amadeus@jmu.edu.cn>
References: <20240428123618.72170-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGE5KVkpDT00YGUtPSkgZSFUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0tBTRhOS0FDTB9BTRkeT0FKQh5DQR9PTFlXWRYaDxIVHRRZQV
	lPS0hVSkpLSEpDVUpLS1VLWQY+
X-HM-Tid: 0a8f24b535ee03a2kunm72d4a7e012e
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PjI6Dhw5TzNRPi4dPDwSOEwZ
	KRoKCSpVSlVKTEpPSEtMQ0tMS0tJVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBTRhOS0FDTB9BTRkeT0FKQh5DQR9PTFlXWQgBWUFJSE1KNwY+

The Radxa ROCK 3C is a similar board to the
Radxa ROCK 3A with the Rockchip RK3566 SoC.
Add devicetree binding documentation for it.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 1bbbaf81134b..e04c213a0dee 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -799,6 +799,11 @@ properties:
           - const: radxa,rock3a
           - const: rockchip,rk3568
 
+      - description: Radxa ROCK 3C
+        items:
+          - const: radxa,rock-3c
+          - const: rockchip,rk3566
+
       - description: Radxa ROCK 5A
         items:
           - const: radxa,rock-5a
-- 
2.25.1


