Return-Path: <linux-kernel+bounces-48087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C82584570F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FDFA1C245B4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216B315DBA5;
	Thu,  1 Feb 2024 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nIbA7+1z"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB4D15B982;
	Thu,  1 Feb 2024 12:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789532; cv=none; b=uhHtu8BKnHswNGCQ6LtRxKizUZ3OqvfcfyAI7gntKjk+1mh8f9W0ldRMtEN9Q/Ba1Qk7spWcgh838d/TRKyyqVXaJlySCJo/MZWAKPyA0N1Y/Xu+AYI/ZHHq+6+qiQixUAT5cQkP3NKaj1keXOFFSMnyAEUXkL6nyVwqIyF/OKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789532; c=relaxed/simple;
	bh=/P0HVssYjsYVgkFiMB8pHevyzWbF7RSsJxKP7VdbqJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NcuruEAFviZV9AtiPi9EBA1w3Jvqf0/NFc+2IWl3HKhCh7YxRcOgcN+K4BqfuhbVVp+5/XjPy3u4u09rBXbqC6d+p9niFsvs2Ju0/XlH7g5/oBBOkZIa2F8JzhHTiEzQW4NN7mtMOVGb4tpteDHVrTYciIyr6X2xhrMdbRiR94M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nIbA7+1z; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=L5rj2
	e6lcmrpI804Cx6MRfru0SWmxeEJZFimAHJKc74=; b=nIbA7+1z3YYoyxn1LXZe8
	AQAFosc+qpAsAyOMVizE2vPJPPRUNAHcA92Qf+l/eiWU4TkgWwxJ6oRyh49w4tzz
	fgGuawTFz1gvD6C3zO009hChECRbpLMxjj4dq4v3ywSjioZvZx9xQMtqamZL57Zy
	t8F8fvmoKgtz+ujMfInNZM=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wDX_35birtlKEO5AA--.30092S5;
	Thu, 01 Feb 2024 20:11:15 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH v2 4/4] arm64: dts: rockchip: Fix the num-lanes of pcie3x4 on Cool Pi CM5 EVB
Date: Thu,  1 Feb 2024 20:11:06 +0800
Message-Id: <20240201121106.1471301-4-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201121106.1471301-1-andyshrk@163.com>
References: <20240201121106.1471301-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX_35birtlKEO5AA--.30092S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw4DuryfJF17JrWDJFW5Wrg_yoWDtrg_ta
	yxW3W8XF4rGrn0g3s8Aa9rG3yfK39F9ayxJa1UZF4DAF9xtayDJFyrtFW2qw15Kr429a1f
	Aa9rJa18C3Z8CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRiiSdPUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0gd3XmWXv1CSDAAAs-

The 4 lane pcie30 phy is shared by pcie3x4 and pcie3x2, so
the num-lanes of pcie3x4 should be 2.

Fixes: 791c154c3982 ("arm64: dts: rockchip: Add support for rk3588 based board Cool Pi CM5 EVB")
Signed-off-by: Andy Yan <andyshrk@163.com>
---

(no changes since v1)

 arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
index 9c0f408ef339..d6366e7b57bb 100644
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


