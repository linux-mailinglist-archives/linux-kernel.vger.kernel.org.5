Return-Path: <linux-kernel+bounces-70306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5226E8595D0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7914B21DBE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E064811196;
	Sun, 18 Feb 2024 08:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="YULAArt9"
Received: from mail-m1284.netease.com (mail-m1284.netease.com [103.209.128.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED5518AF1;
	Sun, 18 Feb 2024 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.209.128.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708246473; cv=none; b=lKQEqntGKezm48JSqHbRSLqtiPILJDUp2P2M8sPnMNceIKt8xzCJ+0Gn/kzH3XnYAL26FGChDwe3MUTFv2dibo3xm5Jr9952ttfTQ3YRqyj4GjK3KXEyPCv37zn4sxw8taELeszOZIGOmQSSsAv7BExslcf9RhEkKfMrsoLj9n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708246473; c=relaxed/simple;
	bh=dNPPyyu8SxU1/uq10zPXV9R2GjhQ/FWzz0JvOY1iBLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tS0A14/pr/QPtRl2TbB6dT2pM+CAiLDvdNqkdJWPfRAGd3eX4B3xr5OlRyyTxsuppIgfNEQcB1KFdxm8vy8MYnZ976x+xmFA0EWRxLLfirGhnjngdElysK/g3o6LblxIfHZd8XHG9hu4HE/XBkJyiTCRf5d2yqvlXYZHJe6pqss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=YULAArt9; arc=none smtp.client-ip=103.209.128.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=YULAArt9mv6osUOndAnXRdss14ruUMZO2tuBTFLEfQ2oNKECWgbNHTPSYj1j/QcNRJvf4xpoi3JRtHqW/zWbk54JxdFYhYwO/pD2XPgvADD8Sn2q4yj1XYlJbINlQcALaGQrFfGREGnxcFqMv2Bab/nkRNLdvvzYRCWhhNtE4ao=;
	s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=K4Fl7JEu9s5KlglszkIGJ6sdYe5Zkzfqyd/rrzoVEbc=;
	h=date:mime-version:subject:message-id:from;
Received: from zhangzj-rk.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 02FDD2A00F9;
	Sun, 18 Feb 2024 16:53:52 +0800 (CST)
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
	Elon Zhang <zhangzj@rock-chips.com>
Subject: [PATCH v2 2/2] dt-bindings: arm: rockchip: Add Toybrick TB-RK3588X
Date: Sun, 18 Feb 2024 16:53:14 +0800
Message-Id: <20240218085314.658223-2-zhangzj@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218085314.658223-1-zhangzj@rock-chips.com>
References: <20240218065407.652213-1-zhangzj@rock-chips.com>
 <20240218085314.658223-1-zhangzj@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUsfGFZCQkxMS0hNT00YSU1VEwETFh
	oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
	tLWQY+
X-HM-Tid: 0a8dbb6bfef903aakunm02fdd2a00f9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PTY6OSo5LTMWMS5RVkoiFVFK
	MzgwFFZVSlVKTEtDSU9NT0hIQ0JDVTMWGhIXVQETGhUcARE7CRQYEFYYExILCFUYFBZFWVdZEgtZ
	QVlOQ1VJSVVMVUpKT1lXWQgBWUFJSExPNwY+

Add devicetree binding for Toybrick TB-RK3588X board from Rockchip Toybrick.

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


