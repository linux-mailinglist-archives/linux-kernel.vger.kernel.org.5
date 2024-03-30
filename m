Return-Path: <linux-kernel+bounces-125663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A889A892A43
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5101AB217FB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC080282E1;
	Sat, 30 Mar 2024 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hRtYCYiD"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ED6847E;
	Sat, 30 Mar 2024 10:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711792973; cv=none; b=r+URjvDHFgxrIoloDXsgVubdr3nd0/+HPqsH00SM3/9E9gM2a5EZRw7iuzy679DX636D+zgXGV2TCJdgybQPHtiu1hLEbQskOQk7j+oBZYcMoAdXH+6Eoi7okPBetP3jQ/OnBKMBtKs4ds6rXud1u8F9ZM21gT06egwH4ZvF0qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711792973; c=relaxed/simple;
	bh=Mvb9VhGdlAVrE+7YH58d2bkpXQUwNAywhiU5zDOKkSc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NGn/0HRulmgi4Wes4c0WuD9IEJa+Z56Zfhrnoj55k1eaZfh638JkZFz/i7UdwbElYuzDCOcdOLveEyBgB5uXlufZtGWVcLkNbI/GHtB6CrS7uGTELKqf8v+ZuZeQHLT4kb1cuAUgp2mbowJMcUtUTPcuf4P5tjFzKW0sn5+q2gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hRtYCYiD; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=d68tz
	j2BQ4TGr4P7mb/TUCnqot1Kau2tzI5UUtJi4X0=; b=hRtYCYiDE5DMRPfN7uq6T
	Ae9BE2W1vnHQmzHNwuI4vi0I6DILyt4lbjmTVn4Z9NKTSxWJjWzMe+T56fRlExHJ
	CFaISx42srZOPfP+YbGEo24xbgzBzoUAAVgV2U3AvV6xAURY51A5ha9+BisI3FtY
	QdTQ5TjZxIEHrYP46W6yOI=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wD3_3H_4gdmq7XiCg--.34374S2;
	Sat, 30 Mar 2024 18:01:41 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: krzysztof.kozlowski+dt@linaro.org,
	devicetree@vger.kernel.org,
	dsimic@manjaro.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	sebastian.reichel@collabora.com,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH 1/2] arm64: dts: rockchip: Enable gpu on Cool Pi CM5
Date: Sat, 30 Mar 2024 18:01:33 +0800
Message-Id: <20240330100134.3588223-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_3H_4gdmq7XiCg--.34374S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFyDZry5KFW5Ww45Gw13twb_yoW3Jrc_ta
	1Iga18Ja1fGrs0g34ktas5G34fK3yDuFyxXayYvFWkAF9IvayDJayrGayfKw1DGF129r4f
	J395XF15AwnrCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_4rXtUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0h2xXmWXw3f-GwABsD

Enable mali gpu node and add the board specific supply-regulator.

Signed-off-by: Andy Yan <andyshrk@163.com>
---

 arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
index 94ecb9b4f98f..6f5cf6a06c2c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
@@ -136,6 +136,11 @@ &gmac0_rgmii_clk
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&vdd_gpu_s0>;
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-0 = <&i2c0m2_xfer>;
 	status = "okay";
-- 
2.34.1


