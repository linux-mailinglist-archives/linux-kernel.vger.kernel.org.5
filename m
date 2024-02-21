Return-Path: <linux-kernel+bounces-73962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D3785CE19
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFCC71F23A68
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EE1282F1;
	Wed, 21 Feb 2024 02:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="GYmhSy8b"
Received: from mail-m25472.xmail.ntesmail.com (mail-m25472.xmail.ntesmail.com [103.129.254.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23D73C29;
	Wed, 21 Feb 2024 02:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.129.254.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708483145; cv=none; b=GgFw6r2CfufIeGdhJ5dPGMqDPD43ZSY3hevbLqVzQRvxWzfLertClyeNO8SbuaJzMH45GcE95swdkdBg2khIWv7ab0W729PojWQeSIHMC3n2fzh3oKHiv2thq9uywED60l6KwXzlIBzuvHctYFtlK0208F7dAcxn1FohkYX+VPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708483145; c=relaxed/simple;
	bh=gDH+n+0NnV9FxQRfCsoM/AhVCuoBlilZUMfWQoy5EE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DTSiIj0mymPV3qqsl5MJXUIndQXhCofiMy5k/zeNnbHR6PU6m2N3WnkMmwTd5TX5wgEL+ZszfZVGrHdBeQFI0l5TQB/4vgmEtt1KcIuDvQL6RmnMKs0ElkRW5gURa4tqS5eDYcMIfNXGu30pnfQRYqm/KIvY/TEpoY//0luDFHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=GYmhSy8b; arc=none smtp.client-ip=103.129.254.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=GYmhSy8b3DQvLH8AKVVc4plknLVoNZKnArUxzqkd8yLxr8TzLWUPALshEFGn8ZTKWk7x4JtrAiESM9tuPHaj6rT5oWWzXYPe4g5pS7TGiLFyGvFBm+/X+2bLLPY69tKTWII9anzJygBay7g+BsM3fWc0MMteACfWdJWL2jRMnJs=;
	s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=s+djMZiOg/oatebJVJNtdf28VXXHPNCfX6vs4XlvzIk=;
	h=date:mime-version:subject:message-id:from;
Received: from zhangzj-rk.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 5ECF72A0144;
	Wed, 21 Feb 2024 10:31:03 +0800 (CST)
From: Elon Zhang <zhangzj@rock-chips.com>
To: heiko@sntech.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: weizhao.ouyang@arm.com,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Elon Zhang <zhangzj@rock-chips.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/2] dt-bindings: arm: rockchip: Add Toybrick TB-RK3588X
Date: Wed, 21 Feb 2024 10:29:02 +0800
Message-Id: <20240221022902.751528-2-zhangzj@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221022902.751528-1-zhangzj@rock-chips.com>
References: <20240221022902.751528-1-zhangzj@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR8ZHVZCT0NJT05PGB8aSktVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
	tLWQY+
X-HM-Tid: 0a8dc980960403aakunm5ecf72a0144
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MAg6PSo5GDMTExoJCwEhFjkY
	GQhPFAtVSlVKTEtDT0NJTU1PSE1IVTMWGhIXVQETGhUcARE7CRQYEFYYExILCFUYFBZFWVdZEgtZ
	QVlOQ1VJSVVMVUpKT1lXWQgBWUFJTktJNwY+

Add devicetree binding for Toybrick TB-RK3588X board from Rockchip Toybrick.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Weizhao Ouyang <weizhao.ouyang@arm.com>
Signed-off-by: Elon Zhang <zhangzj@rock-chips.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 5cf5cbef2cf5..d29df97c7b25 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -878,6 +878,11 @@ properties:
           - const: rockchip,rv1108-evb
           - const: rockchip,rv1108
 
+      - description: Rockchip Toybrick TB-RK3588X board
+        items:
+          - const: rockchip,rk3588-toybrick-x0
+          - const: rockchip,rk3588
+
       - description: Theobroma Systems PX30-uQ7 with Haikou baseboard
         items:
           - const: tsd,px30-ringneck-haikou
-- 
2.34.1


