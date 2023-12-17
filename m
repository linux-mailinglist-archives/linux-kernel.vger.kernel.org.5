Return-Path: <linux-kernel+bounces-2564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2D7815EDD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA4E1F21762
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF92032C72;
	Sun, 17 Dec 2023 12:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qZRk0Tlq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69135328C9;
	Sun, 17 Dec 2023 12:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=yKu+k
	xVU/sZ3fnmu7Mf+YsvGsYLMArOxzariOJwOVno=; b=qZRk0TlqZgOzWS4IG8Z9m
	V1mtBrHd+aOsuRepNepmwGwpUaaDnrjASTBFVU7JT6fFzCBUA+54AtqHr6cG2fhC
	2siYqpkth0lYGIqlKU6R95XwLLoIZBcsZk0jOHnaHk70I1bIDU01y3s1b2e/unjK
	1gfWT0EUITLQ7j5Vmg6Pk0=
Received: from ProDesk.. (unknown [58.22.7.114])
	by zwqz-smtp-mta-g5-3 (Coremail) with SMTP id _____wD333AB0H5lTn2nFw--.50366S2;
	Sun, 17 Dec 2023 18:40:05 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH 1/2] arm: dts: rockchip: Add psci for rk3036
Date: Sun, 17 Dec 2023 18:39:58 +0800
Message-Id: <20231217103959.2380661-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD333AB0H5lTn2nFw--.50366S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw1kJrW8WFy5Gr13tF48tFb_yoW3JFX_t3
	WfW3W5Ka1rCr9Iq34DJw4ru347Cw48CFZ3Ww18uF1UJ3WSva1kXFWktayxJr15CFW2grZ3
	GFWfXa1Sk3W3ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0Kg4DUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBnAxJXlghmCkkNwAAsc

From: Andy Yan <andy.yan@rock-chips.com>

The system will hang at bringup secondary CPUs
without psci node.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 arch/arm/boot/dts/rockchip/rk3036.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3036.dtsi b/arch/arm/boot/dts/rockchip/rk3036.dtsi
index 78686fc72ce6..5344803442a1 100644
--- a/arch/arm/boot/dts/rockchip/rk3036.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3036.dtsi
@@ -67,6 +67,11 @@ display-subsystem {
 		ports = <&vop_out>;
 	};
 
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		arm,cpu-registers-not-fw-configured;
-- 
2.34.1


