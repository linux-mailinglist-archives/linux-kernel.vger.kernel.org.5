Return-Path: <linux-kernel+bounces-151321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 250BC8AACE5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43E2282A9F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7709E7FBCF;
	Fri, 19 Apr 2024 10:31:16 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B74883D;
	Fri, 19 Apr 2024 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713522676; cv=none; b=PjP9tnl6i17DaGWwP+fw6nUo4mcl9ptXghPRVruT95lBYryX16qaSmMMk/0czDXCAdT0uC76ObiBVK4h2qfXaHRZuLifh0tg9gHZ0xQkbvhl6ffgOmjE6Z3plPH44QpdKyHgoGwNA2V19i+J8u+hx7wxfnQQGDtI0l8K/AtFNhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713522676; c=relaxed/simple;
	bh=Jlq1b5r2fQJPdCFDUoO6+4tL43B6HP3gdv8zfz0k3GU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ex8SOI0TycrERABg2ufTrgv8tPW1glt4Ahc0d4150cI0R9qaELNnuOTrV7UlWLzPZdpF+KkMkj24tZpSqKu1w71UeAY9lAmzlXeT/zvr2eFo5JmEfz40oQyvykljtMxd40jxPeKvDdNDZ4yZDDUIVGi74bm5De4UMFMiSHpJg68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c01:4860:bdbf:c4be:ec53:8f46])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 39EF67E0148;
	Fri, 19 Apr 2024 18:30:32 +0800 (CST)
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
	FUKAUMI Naoki <naoki@radxa.com>,
	Dragan Simic <dsimic@manjaro.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: rockchip: correct the model name for Radxa ROCK 3A
Date: Fri, 19 Apr 2024 18:30:18 +0800
Message-Id: <20240419103019.992586-2-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240419103019.992586-1-amadeus@jmu.edu.cn>
References: <20240419103019.992586-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDH0pPVk9PHkoaQh5PShgdSlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0pBT0NNS0EZHxkdQRhPGR5BHhhOSEFDHU9NWVdZFhoPEhUdFF
	lBWU9LSFVKTU9JSklVSktLVUpCWQY+
X-HM-Tid: 0a8ef5e8675603a2kunm39ef67e0148
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ky46Igw4FjMNN08YC1YtP0s#
	OR8wCi9VSlVKTEpITklJTUhJQ0NNVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0pBT0NNS0EZHxkdQRhPGR5BHhhOSEFDHU9NWVdZCAFZQUlPTko3Bg++

According to https://radxa.com/products/rock3/3a,
the name of this board should be "Radxa ROCK 3A".

Suggested-by: FUKAUMI Naoki <naoki@radxa.com>
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 99bd5e2c76a0..11f603edfb88 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -772,7 +772,7 @@ properties:
           - const: radxa,rock2-square
           - const: rockchip,rk3288
 
-      - description: Radxa ROCK3 Model A
+      - description: Radxa ROCK 3A
         items:
           - const: radxa,rock3a
           - const: rockchip,rk3568
-- 
2.25.1


