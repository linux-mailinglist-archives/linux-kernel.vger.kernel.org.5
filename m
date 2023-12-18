Return-Path: <linux-kernel+bounces-3389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE4A816BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C93A1F23605
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEDC18EB6;
	Mon, 18 Dec 2023 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZewPbAys"
X-Original-To: linux-kernel@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8ED199A5;
	Mon, 18 Dec 2023 10:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=fBHGN
	YITHW0NUuAbOpjQ5mbFub8s+SVFwFReNTMyTxo=; b=ZewPbAysTlmLbeW5F4VHM
	wvF+qvlZ05kVH+g6wTcli2otts+H/iGV/7HgOBc2SaCL2FgMCtl6MO0bchd4TzNU
	N+f13jXv2iIFGmoBNQll6Di2SC1aKTDXVu5fLAZNxHd2Lq76U5IX+TQKOr4VlVhc
	xRUiTp/UbYDWBa4rHxwxRA=
Received: from ProDesk.. (unknown [58.22.7.114])
	by zwqz-smtp-mta-g2-2 (Coremail) with SMTP id _____wDn72EdJYBln1v+Bg--.7214S4;
	Mon, 18 Dec 2023 18:55:30 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	zhengxing@rock-chips.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2 2/3] ARM: dts: rockchip: Add stdout-path for rk3036 kylin
Date: Mon, 18 Dec 2023 18:55:22 +0800
Message-Id: <20231218105523.2478315-3-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218105523.2478315-1-andyshrk@163.com>
References: <20231218105523.2478315-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn72EdJYBln1v+Bg--.7214S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruw1fKr45Zry8uF45JFy8AFb_yoWfGrX_ta
	43Kas5KFs7Gr15Xw1Dt3yxW343CwnakanxJryvyr1UJF1qqw4kXF4vyas3tw1YkFWUKrZ7
	AFW5Xa1qqa1akjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0puWJUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEAdKXmVOBAprAwAAsO

From: Andy Yan <andy.yan@rock-chips.com>

Add stdout-path to get a uart console when system boot.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v2:
- Fix typo s/patch/path/
- Change subjet s/arm/ARM/

 arch/arm/boot/dts/rockchip/rk3036-kylin.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3036-kylin.dts b/arch/arm/boot/dts/rockchip/rk3036-kylin.dts
index 67e1e04139e7..f12fa3831bbf 100644
--- a/arch/arm/boot/dts/rockchip/rk3036-kylin.dts
+++ b/arch/arm/boot/dts/rockchip/rk3036-kylin.dts
@@ -8,6 +8,10 @@ / {
 	model = "Rockchip RK3036 KylinBoard";
 	compatible = "rockchip,rk3036-kylin", "rockchip,rk3036";
 
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
 	memory@60000000 {
 		device_type = "memory";
 		reg = <0x60000000 0x20000000>;
-- 
2.34.1


