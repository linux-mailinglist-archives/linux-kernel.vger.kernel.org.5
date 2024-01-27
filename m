Return-Path: <linux-kernel+bounces-41127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8242183EC45
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 10:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B532D1C21CCA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 09:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10EB1EA90;
	Sat, 27 Jan 2024 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="K8nyT+Z5"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9861DFE8;
	Sat, 27 Jan 2024 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706347286; cv=none; b=gxLpowdfscs7A8M/Mf9cN94cJ9Al0onxSxdizs9Tq++7zj075J6nwlIJcUiXJD1Kaa/wDDa4/3zQgEVjJP1XXVtEf1RxyMS3riHsfLTLg6eP8zvBsLLKmqVNpCG49jpwnh7au+ubEOTnE/oWB9Q1ia/s0rR5wDLdQbFw0vik/TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706347286; c=relaxed/simple;
	bh=UOxD5C37dYkQwJfR2+WR1Axl/c9z0AvtCPGa2cvizAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cEOjGbZQNYyu2XcLJ5m+iOHKGhu0WTd2cO5X297We0RGNMIcGEQ0BCRWZYf9P6MSXRnlzo+VYZ17VAaZ3soN9EB072P8/AQwQ8puzpRqhqQ0+ZDtruTuE6qj1b2AgS8Ae6kFAJUm7wRz32KFFFdQboEzvu66+WC4p6rVGUNtBE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=K8nyT+Z5; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=a/VjS
	8XMkdiNaejedJEj7VqbTBOy9aX70K9qWnPW79Y=; b=K8nyT+Z58mrUAFpNviP9Z
	b48JmtTNY//qVDuM+J5t0K4TtsY6DMtLDNd+mqQkoPbHDbtGSHNBBNTFaYjarPHy
	EVh/6F/v76SjPpaFq/f3bOzphtxVN0Zcl6d+M6qOoOihPMrBNzyAssUynJgr6DlS
	useRmwyIrZm5kAfR3awejM=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wD3rzHkyrRl5GopBA--.2976S5;
	Sat, 27 Jan 2024 17:20:41 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH 4/4] arm64: dts: rockchip: Fix the num-lanes of pcie3x4 on Cool Pi CM5 EVB
Date: Sat, 27 Jan 2024 17:20:34 +0800
Message-Id: <20240127092034.887085-4-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240127092034.887085-1-andyshrk@163.com>
References: <20240127092034.887085-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3rzHkyrRl5GopBA--.2976S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw4DuryfJF17JrWDJFW5Wrg_yoWDZFb_ta
	4xW3W8Xa1rGrn0g3s0yay3G3ySk39F9FW7Ga1UZFWDAF9xta1DJFyrtFW2q34UKr429w4f
	Aa9xJF18C3Z8CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_LvttUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0gxyXmWXvvkQhAAAsT

The 4 lane pcie30 phy is shared by pcie3x4 and pcie3x2, so
the num-lanes of pcie3x4 should be 2.

Fixes: 791c154c3982 ("arm64: dts: rockchip: Add support for rk3588 based board Cool Pi CM5 EVB")
Signed-off-by: Andy Yan <andyshrk@163.com>
---

 arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
index 5f42f1065d73..9bff04fc7e43 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
@@ -126,6 +126,7 @@ &pcie30phy {
 	status = "okay";
 };
 
+/* Standard pcie */
 &pcie3x2 {
 	reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_sys>;
@@ -134,6 +135,7 @@ &pcie3x2 {
 
 /* M.2 M-Key ssd */
 &pcie3x4 {
+	num-lanes = <2>;
 	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_sys>;
 	status = "okay";
-- 
2.34.1


