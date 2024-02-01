Return-Path: <linux-kernel+bounces-48088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F794845713
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30371C23911
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C38A15DBAC;
	Thu,  1 Feb 2024 12:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CcXxQEh1"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8364A15CD76;
	Thu,  1 Feb 2024 12:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789535; cv=none; b=qoSLHHsYM9KCoB0ZYvy4VXkgmeIUC21iGg5vmCQ7tjmzdknk5CGp3VOMl9tOplnEr5lAUdp64x4yakYG98ale+pzDF+eU/f8eith2cCHUslEN6LjDdXgl4jkePkysqfdFmmvaIWqY+7aRXBmmZbMFSglFpu1xZr+tLbPrSk3kd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789535; c=relaxed/simple;
	bh=HTvBn1QR5M6hH9gv+M9zGi1hhi6VmTnxL+u52YhxftU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mLfp4F/2CEiO7E01JawPY8e2QJQOYOHHm43acLaxoooUii/crhxr8wxJkguf+gjD4pCbs0zGLwtTmivwjU8Jl1cmZAYIJxciy2iDvCvAS6z2N7CWAP7pW+vOqCwvlfT3dY0rqFEUF1eMc1NcBQ/tBPLNA/ZW3Al7pqLXHcMmsMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CcXxQEh1; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=pnMdN
	pfxgQzJxgzSTVf6q0src2GgoFnb5r6Fx+QgrFU=; b=CcXxQEh1Rvn0yiDz9E0yG
	XOqHrohCI1RVzLiagB5PSx54jTsUXhE/yF2FO1Av18HFyrhVJ4gdyh1bgjacSSdg
	oXMVZA76uk9WgFNe5OAwpNOb/AaYHhXr178SG8YKY7LIrtY+Ac8mD2r2ckPzf9xs
	EyCMtjQuA+UFz///vAPSc0=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wDX_35birtlKEO5AA--.30092S4;
	Thu, 01 Feb 2024 20:11:14 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH v2 3/4] arm64: dts: rockchip: rename vcc5v0_usb30_host regulator for Cool Pi CM5 EVB
Date: Thu,  1 Feb 2024 20:11:05 +0800
Message-Id: <20240201121106.1471301-3-andyshrk@163.com>
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
X-CM-TRANSID:_____wDX_35birtlKEO5AA--.30092S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFyDXFykWw4DKFy8JrykGrg_yoW8GFWfpw
	nxurZrJr1fuFWUt3yqg3Z7Krn8Cw4kJ3ZxurykJr1rKr12qFnrtFn3uF1fAFZ8J3Z2yan0
	kF98Zry7JFyqvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi3CztUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqAZ3XmVOCDrNgAAAsT

According to the schematic, USB20 HOST0 and HOST1 each have their own
independent power supply, but these two regulators controlled by a
same GPIO, so give it a more appropriate name.

Fixes: 791c154c3982 ("arm64: dts: rockchip: Add support for rk3588 based board Cool Pi CM5 EVB")
Signed-off-by: Andy Yan <andyshrk@163.com>
---

Changes in v2:
- Add two lable for this regulator

 arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
index 1b5681fe0471..9c0f408ef339 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
@@ -84,7 +84,7 @@ vcc3v3_lcd: vcc3v3-lcd-regulator {
 		vin-supply = <&vcc3v3_sys>;
 	};
 
-	vcc5v0_usb30_host: vcc5v0-usb30-host-regulator {
+	vcc5v0_usb_host1: vcc5v0_usb_host2: vcc5v0-usb-host-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_host";
 		regulator-boot-on;
@@ -200,12 +200,12 @@ &u2phy3 {
 };
 
 &u2phy2_host {
-	phy-supply = <&vcc5v0_usb30_host>;
+	phy-supply = <&vcc5v0_usb_host1>;
 	status = "okay";
 };
 
 &u2phy3_host {
-	phy-supply = <&vcc5v0_usb30_host>;
+	phy-supply = <&vcc5v0_usb_host2>;
 	status = "okay";
 };
 
-- 
2.34.1


