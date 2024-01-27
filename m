Return-Path: <linux-kernel+bounces-41128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AA283EC46
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 10:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4701F227EF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 09:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A671EB21;
	Sat, 27 Jan 2024 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aCwvVHfd"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9B61E516;
	Sat, 27 Jan 2024 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706347286; cv=none; b=d0bZF00mB+5yBADknJagi0yRG2QYVRSbo2tpgX6gWW3jJTQ9DPI/lbb4aLjk8t0leOhelqgGjjG2BYSvHPapYSp656UWfC7vc7ySnbJEfup4+RFEoQIkNZoImDX0JIyFR6t0ursYb6eoc97COQvWed3CkUlSmzloyZ00yJtGy0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706347286; c=relaxed/simple;
	bh=KEhFIjcnHD4A22X7uQT1+3J1ulhltLTzb67Z0RlJXUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e+bL5A2FvH6yV47zOGBFasATgHep5rvtnR7gaDP/C8SUnnG0ZReAPrB/nyhoIR3UlSh9d232QgdzK5i02CUsjFnwCmpmg61ZRe3cbWipDO5pZbEWgBx8GV1NZl9rFeyKgNWjz5C7C0NtPZ1dPEHX+6GpMybYIpk9TE2tdN4cUwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aCwvVHfd; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ke7aq
	YeO3SgKHFFAXZGTQJgNGC9RklM/X8fmVFmJVMo=; b=aCwvVHfdF6SFbE39ZmYnE
	wO4GcXjp/JfyvcAcUUnppJKIVxs5z27NtpebTolZSvusoMlVXQc2ra2ob+8bUA1I
	hMjz+/a0hzR8k6twsUngb0Yb9l6lWyTn8Z5T7fZ8vRCSZWv3+S+An0h8LLHLMn11
	MhUNKWSqRuRboG5g/gEUow=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wD3rzHkyrRl5GopBA--.2976S4;
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
Subject: [PATCH 3/4] arm64: dts: rockchip: rename vcc5v0_usb30_host regulator for Cool Pi CM5 EVB
Date: Sat, 27 Jan 2024 17:20:33 +0800
Message-Id: <20240127092034.887085-3-andyshrk@163.com>
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
X-CM-TRANSID:_____wD3rzHkyrRl5GopBA--.2976S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyDZryfuFyrCF45Cw1Dtrb_yoW8JF4fpw
	nxCrZrJr1fuFWUt3yqg3Z7Krs5C395t3Z3ur95Jw1rKw1Iq3ZrtFn3u3WrAFW5twn7Aa1q
	kFs5ury7JF1qvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_1v3UUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEAxyXmVOB+LqkAABsF

According to the schematic, this regulator is used both for USB30 and
USB20, so give it a more appropriate name.

Fixes: 791c154c3982 ("arm64: dts: rockchip: Add support for rk3588 based board Cool Pi CM5 EVB")
Signed-off-by: Andy Yan <andyshrk@163.com>
---

 arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
index 1b5681fe0471..5f42f1065d73 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
@@ -84,7 +84,7 @@ vcc3v3_lcd: vcc3v3-lcd-regulator {
 		vin-supply = <&vcc3v3_sys>;
 	};
 
-	vcc5v0_usb30_host: vcc5v0-usb30-host-regulator {
+	vcc5v0_usb_host: vcc5v0-usb-host-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_host";
 		regulator-boot-on;
@@ -200,12 +200,12 @@ &u2phy3 {
 };
 
 &u2phy2_host {
-	phy-supply = <&vcc5v0_usb30_host>;
+	phy-supply = <&vcc5v0_usb_host>;
 	status = "okay";
 };
 
 &u2phy3_host {
-	phy-supply = <&vcc5v0_usb30_host>;
+	phy-supply = <&vcc5v0_usb_host>;
 	status = "okay";
 };
 
-- 
2.34.1


