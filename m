Return-Path: <linux-kernel+bounces-72074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C452D85AE9F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803D4282B47
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6435A0FE;
	Mon, 19 Feb 2024 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=6tel.net header.i=@6tel.net header.b="nRbP/S8m"
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9786856B86;
	Mon, 19 Feb 2024 22:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382133; cv=none; b=MTxUpGU9T8PWKm0iUoGYigZ0AWSY+4jq54/ZnQla5fCODmk4NfknCrGDoehyGy8PYTH06pMUCB4wO9AEhGp8q4J8DYP4tpTmUmGJa3EybN7k3PgCwzk1dMRTWwHVzEZb9F209b5zKOzKAbWzbIjpm8XU639ZWNw6rlD8X7LhbSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382133; c=relaxed/simple;
	bh=LPe5cBAQ5DxD9/GpxtQHs824wvR+g0xz5uetKcqrKhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPGT21kaZO9jc4sC2kkWbCbjBF2zvs0mati9SUyZKKOA/O6btP6ER01tSBeuVMJkhiYYjss+jUQV+otYKCh91fNxlmFJ7IguWPI8bgr0z4q7WZ4XQPeVE790vqrOeacLIN1VeGexsRFb/qtvLP0DgwK0zkaNDWrzR7Hsp8/bybg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=6tel.net; spf=pass smtp.mailfrom=6tel.net; dkim=pass (1024-bit key) header.d=6tel.net header.i=@6tel.net header.b=nRbP/S8m; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=6tel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6tel.net
Received: from mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3285:0:640:fd1e:0])
	by forward500c.mail.yandex.net (Yandex) with ESMTPS id 3632260F32;
	Tue, 20 Feb 2024 01:35:24 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id bYZIDNh7RSw0-x9YMRqpM;
	Tue, 20 Feb 2024 01:35:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=6tel.net; s=mail;
	t=1708382123; bh=JI2cRwXvHUsxvJo/pXgFMq6i1VmcadyuSYPCZy3AMrY=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=nRbP/S8mwjF6pesBwuOv5WR4P3tM3nanelxFQkhnHfbsFR7RPbbX/AYTkMZdUaG+f
	 stHi0m2suWduaRhjEQQkUZakYop6l+c5I5dYGBuB7djqU0KjeZn25hZcwtxwW990d8
	 9SzesQD0AbazpktNcdXC5B+F3DeCunoKjFZRofm8=
Authentication-Results: mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net; dkim=pass header.i=@6tel.net
From: efectn@6tel.net
To: linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	sebastian.reichel@collabora.com,
	Muhammed Efe Cetin <efectn@protonmail.com>
Subject: [PATCH 7/9] arm64: dts: rockchip: Add SFC to Khadas Edge 2
Date: Tue, 20 Feb 2024 01:34:23 +0300
Message-ID: <00942603f7e61ecb2a0067bebf6795dab3571613.1708381247.git.efectn@protonmail.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <5a7bd2cd8703e51382abfc11242de59d45286477.1708381247.git.efectn@protonmail.com>
References: <5a7bd2cd8703e51382abfc11242de59d45286477.1708381247.git.efectn@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammed Efe Cetin <efectn@protonmail.com>

This commit adds SPI flash support for Khadas Edge 2.

Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
---
 .../boot/dts/rockchip/rk3588s-khadas-edge2.dts     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index dfcdbec3534d..c2a329f151a1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -299,6 +299,20 @@ &sdmmc {
 	status = "okay";
 };
 
+&sfc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&fspim2_pins>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-max-frequency = <100000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <1>;
+	};
+};
+
 &spi2 {
 	status = "okay";
 	assigned-clocks = <&cru CLK_SPI2>;
-- 
2.43.1


