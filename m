Return-Path: <linux-kernel+bounces-3388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A9D816BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16798B21E56
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDAD18E36;
	Mon, 18 Dec 2023 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IDSAkXb/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11806199A6;
	Mon, 18 Dec 2023 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=M+QB+
	W4x0XaSH0qLHe9p44+VE5HHYX/QVSrXFOkfL7o=; b=IDSAkXb/r7PmhAbB6wrqP
	dm7J/h/5wrYDHVhkqiHK9iF1mpkD5B+j/J6V33NtCGo1iTOzaG10Jsm+Y7KFgv8B
	NDG+Bszdy8pdy11I0nvlBA76ViS61kAsWM1FhMTiCjYMfvupBFjVsrgdb6nUOClG
	hIwLRpT3tijujTO29c27Rc=
Received: from ProDesk.. (unknown [58.22.7.114])
	by zwqz-smtp-mta-g2-2 (Coremail) with SMTP id _____wDn72EdJYBln1v+Bg--.7214S3;
	Mon, 18 Dec 2023 18:55:29 +0800 (CST)
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
Subject: [PATCH v2 1/3] ARM: dts: rockchip: Add psci for rk3036
Date: Mon, 18 Dec 2023 18:55:21 +0800
Message-Id: <20231218105523.2478315-2-andyshrk@163.com>
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
X-CM-TRANSID:_____wDn72EdJYBln1v+Bg--.7214S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw1kAF47Jr48Kr17KrW3KFg_yoW3XFc_t3
	WfW3W5Ga1rAr9Iq34DGw48u347Cw40kFZ3Ww18uF1UJF1Sva1kAFWktayxJr15CFW2grZ3
	GFWrXa1Sk3W3ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnAHUDUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEgVKXmVOBAp8owAAs5

From: Andy Yan <andy.yan@rock-chips.com>

The system will hang at bringup secondary CPUs
without psci node.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

(no changes since v1)

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


