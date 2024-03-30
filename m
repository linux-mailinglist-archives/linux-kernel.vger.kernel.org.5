Return-Path: <linux-kernel+bounces-125662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09894892A41
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA9B280C89
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF91E20DCD;
	Sat, 30 Mar 2024 10:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jayC3L4H"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4772A64F;
	Sat, 30 Mar 2024 10:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711792971; cv=none; b=CbghGT1lcIXgczjNHGtLYfBxt9/vHoKYg4JjH2NAGqRiVOFT8k1gnXG8GWqIfOlcmZLmpwdet2aMZXgY1IzGOnwLxpX7iN6CFfGPmU41YgUD9rb+lDb5lQz3deXN6LQc76HV4dBRQFCujs/44GroGb7+Jh54zWjQq3eBqalDhX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711792971; c=relaxed/simple;
	bh=htJFzVAYmEOW9lrTsfzNTUK776+uGzEaMgpjowuxn0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=My14mcN5CKScb2I3Wc0ojbKe98seBuO4QKLcy5DgtaV7mGECudvDct0yfkzJlAEPDfSOxzLZHhmMTqb+06veu47yR3d/AUCb1wUhNQwJ6Q7afDd6XEYBYO2Ggw5TIQyVKIyp5GbQ816GrBiN8DT9M3UIRpS4/vg6RItfuyFKjbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jayC3L4H; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=M7Tok
	/UBCV8rcegKEQ5Q2x/dUQ7SH8Wy3obY8/nLX2I=; b=jayC3L4HemKkYUi9rT638
	IxD++P3skxnLCiQMmM4aEuQCFLhjz42xVV2lgo1OS/YpG3H7iP3rfSOmTuuxCDOz
	zoxlkQsshbtQdjuDRnXl2uuatcjKWyT0eqDUAc5EFRIuQS8VA43C1Iy+jLXVlATx
	ydCyWb2uMbBWbmLJnNqitE=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wD3_3H_4gdmq7XiCg--.34374S3;
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
Subject: [PATCH 2/2] arm64: dts: rockchip: Enable gpu on Cool Pi 4B
Date: Sat, 30 Mar 2024 18:01:34 +0800
Message-Id: <20240330100134.3588223-2-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240330100134.3588223-1-andyshrk@163.com>
References: <20240330100134.3588223-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_3H_4gdmq7XiCg--.34374S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFyDZry5Kw1DCryxArW5Wrg_yoW3JFb_tF
	yxWF1rJF4fCr1aq3s5ta4UGa4xK3y8KF4xtFWYvFZxJFnI9a18JayrJay293srGFWjkw4x
	Jw45AFyUArnI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRJKsUUUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0h2xXmWXw3f-GwACsA

Enable mali gpu node and add the board specific supply-regulator.

Signed-off-by: Andy Yan <andyshrk@163.com>
---

 arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
index e037bf9db75a..25a2ae7d4827 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
@@ -203,6 +203,11 @@ &cpu_b2 {
 	cpu-supply = <&vdd_cpu_big1_s0>;
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


