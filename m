Return-Path: <linux-kernel+bounces-10850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 837EB81DD5D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 01:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2234F1F2171A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 00:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D5C7E9;
	Mon, 25 Dec 2023 00:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Q7qT8tVX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECEA62D;
	Mon, 25 Dec 2023 00:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=PCPH+
	8SVMJT5ORmwxUBbY5agPi3Em+ScLQ2lM/Hrli8=; b=Q7qT8tVXXsNOXNYVvnOtl
	zigxPV+UiiPRrNL8wOWQ878n8ij0NIuG7s1Wyu/2gr2arDMO2JfCZ5bZ7LHUXEFE
	opSawQ3jvAbLHrSYfBbyECFXkCu9BeicNbNoaGFRBMBThZcHOuoUYwxqqA2ZSHsV
	R9LWJ3h4frT3fzwI8/Gdac=
Received: from ProDesk.. (unknown [58.22.7.114])
	by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wDXf_bx0YhlDExdGg--.45426S2;
	Mon, 25 Dec 2023 08:51:01 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	lasstp5011@gmail.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	zhangn1985@outlook.com,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH v2] arm64: dts: rockchip: Fix led pinctrl of lubancat 1
Date: Mon, 25 Dec 2023 08:50:55 +0800
Message-Id: <20231225005055.3102743-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXf_bx0YhlDExdGg--.45426S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7WryrXFyfKF4DKr1UCF4kWFg_yoWkArbEga
	4Ig3W8AF4kJryFv34aya95W3sIk3sIk34rGa47AF1DKay3XrWUAFyrJay8Cw15G34Ikrs7
	X3yDXF1kCa1Y9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMFApUUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEBdRXmVOBJ60+AAAs1

According to the sch, the gpio control sys_led
is GPIO0_C5.

Fixes: 8d94da58de53 ("arm64: dts: rockchip: Add EmbedFire LubanCat 1")
Reported-by: Zhang Ning <zhangn1985@outlook.com>
Closes: https://lore.kernel.org/linux-rockchip/OS0P286MB06412D049D8BF7B063D41350CD95A@OS0P286MB0641.JPNP286.PROD.OUTLOOK.COM/T/#u
Signed-off-by: Andy Yan <andyshrk@163.com>

---

Changes in v2:
- remove "boot" in subject prefix
- Add Zhang Ning full name in Reported-by

 arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts b/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
index 1c6d83b47cd2..6ecdf5d28339 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
@@ -455,7 +455,7 @@ &pcie2x1 {
 &pinctrl {
 	leds {
 		sys_led_pin: sys-status-led-pin {
-			rockchip,pins = <0 RK_PC7 RK_FUNC_GPIO &pcfg_pull_none>;
+			rockchip,pins = <0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
 
-- 
2.34.1


