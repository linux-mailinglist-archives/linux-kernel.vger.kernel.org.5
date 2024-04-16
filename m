Return-Path: <linux-kernel+bounces-146861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B92B58A6BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747D6281793
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9555F12C475;
	Tue, 16 Apr 2024 13:17:28 +0000 (UTC)
Received: from mail-m12823.netease.com (mail-m12823.netease.com [103.209.128.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D9612A16E;
	Tue, 16 Apr 2024 13:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.209.128.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713273448; cv=none; b=tNi2KqnMpP/8wS3X9M78WK7AAh9lkDobBmRuhbkZVdVwEd+3hO+25hS7H4qgOcQkhTEXyq4nIQLAYQXBohlNV2KPZ90VARuWeUZxadDXYTEv1bbi+mUQ8Bg+eTHqYvkQf+S7Y7TKcXveW+/Po/9g0qWAVNjlGNJGninqrqY5zEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713273448; c=relaxed/simple;
	bh=hyiEPB8L5mFUohZUkwNFrVzE6hLdGgK864C/chAB2H4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m63K5eFumOArxMSoWE/yhoVdNj+QnQrD9JD6/WtYTku0EdT8rbFYdqXrfF6rLfWS8Hj8hTNOXDjzWHNzY9c2PKzUK1OrTpeU1URfZL/HUl9w3hn4sXE/HZl+Q5X1mTkzRGLOeBTFkMVxI/JzLgTu4Cp6+8G9Ua43vtV1fo58QK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=103.209.128.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:5e10:948:ebda:821b:6681])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 437647E0101;
	Tue, 16 Apr 2024 21:00:16 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 1/2] dt-bindings: arm: rockchip: add Radxa ROCK3 Model C
Date: Tue, 16 Apr 2024 21:00:09 +0800
Message-Id: <20240416130010.379705-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQ0hLVhpKGR0YHh1DSB9CHlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0tBTh5KS0FCT0NBHhkfGkFDSUoZQU1NQ0pZV1kWGg8SFR0UWU
	FZT0tIVUpKS0hKQ1VKS0tVS1kG
X-HM-Tid: 0a8ee6fe68e303a2kunm437647e0101
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oj46PTo5VjMUAQ0vLBkBPR0a
	TixPCj1VSlVKTEpISUxJT0pNQ05NVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBTh5KS0FCT0NBHhkfGkFDSUoZQU1NQ0pZV1kIAVlBSUtOTzcG

The Radxa ROCK3 Model C is a similar board to
the Radxa ROCK3 Model A with the RK3566 SoC.
Add devicetree binding documentation for it.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 99bd5e2c76a0..dc3847bd67fe 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -777,6 +777,11 @@ properties:
           - const: radxa,rock3a
           - const: rockchip,rk3568
 
+      - description: Radxa ROCK3 Model C
+        items:
+          - const: radxa,rock3c
+          - const: rockchip,rk3566
+
       - description: Radxa ROCK 5 Model A
         items:
           - const: radxa,rock-5a
-- 
2.25.1


