Return-Path: <linux-kernel+bounces-72111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C35B685AF2A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F3F5B25674
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0707957314;
	Mon, 19 Feb 2024 22:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=6tel.net header.i=@6tel.net header.b="o0kNILLx"
Received: from forward206c.mail.yandex.net (forward206c.mail.yandex.net [178.154.239.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267735381A;
	Mon, 19 Feb 2024 22:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382595; cv=none; b=Q+neh+S+ZF/8aGb6CaOArEoPdy9my+VqSafxsH2mBdlBx9LppTXCmBi4JVeCDdXhtzoGCohYEPe3ndJ1GfIIxIIPg0XWmJ/2hnU/zAVbpH35/lhP0kXh7Z+YfvVLj8cvnTklSyMumxs8ODQrXQ00+ocqRGF2+Qzmv/hpcJBuF7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382595; c=relaxed/simple;
	bh=9gKp44U64vpDldG4mNOhjDG2liu6cXrXKG6GoC6eEP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D7p4bf1rbmMX74O69zWWChhgx4DVRVtgg8W8NhfXVphucD58MLjnx+HXjZrCffPYguvpGs9QGh4sinxX2uBGjZQb7BNWl2qKcecTsLsvzVysL/6ZeWLi1lHTmMxMWQutzcaY0utbo7vWTPo7okJq/vYDAgQrtM7kf+W0Mwge7gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=6tel.net; spf=pass smtp.mailfrom=6tel.net; dkim=pass (1024-bit key) header.d=6tel.net header.i=@6tel.net header.b=o0kNILLx; arc=none smtp.client-ip=178.154.239.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=6tel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6tel.net
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
	by forward206c.mail.yandex.net (Yandex) with ESMTPS id E577763527;
	Tue, 20 Feb 2024 01:35:16 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3285:0:640:fd1e:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 819C160985;
	Tue, 20 Feb 2024 01:35:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id bYZIDNh7RSw0-E7KFyfSe;
	Tue, 20 Feb 2024 01:35:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=6tel.net; s=mail;
	t=1708382107; bh=iaUiCJngdlVa+OcnhANuHvIOXadWyrNnDfT/O58QDVA=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=o0kNILLxyr95zX+t/8ATgV+owzuxiS3YX8f0PqUSTtB47X0Ku8lwkEKd5Ok3MShsl
	 fUU/6iYet1miI+Y9vvp79dhyiByywEWwjIwUIX2EzGCgpZFv7ZAlRfoUy2godheCi7
	 YxmcDymUhNZYeN+HA4nLTkTdumVFkUZqaFY8x2I0=
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
Subject: [PATCH 1/9] arm64: dts: rockchip: Add cpu regulators and vcc5v0_sys to Khadas Edge 2
Date: Tue, 20 Feb 2024 01:34:17 +0300
Message-ID: <5a7bd2cd8703e51382abfc11242de59d45286477.1708381247.git.efectn@protonmail.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammed Efe Cetin <efectn@protonmail.com>

This commit adds 5V fixed power regulator and CPU regulators to Khadas
Edge 2.

Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
---
 .../dts/rockchip/rk3588s-khadas-edge2.dts     | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index f53e993c785e..1d1ce70a0f3a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -17,6 +17,87 @@ aliases {
 	chosen {
 		stdout-path = "serial2:1500000n8";
 	};
+
+	vcc5v0_sys: vcc5v0-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+};
+
+&cpu_b0 {
+	cpu-supply = <&vdd_cpu_big0_s0>;
+};
+
+&cpu_b1 {
+	cpu-supply = <&vdd_cpu_big0_s0>;
+};
+
+&cpu_b2 {
+	cpu-supply = <&vdd_cpu_big1_s0>;
+};
+
+&cpu_b3 {
+	cpu-supply = <&vdd_cpu_big1_s0>;
+};
+
+&cpu_l0 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
+&cpu_l1 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
+&cpu_l2 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
+&cpu_l3 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0m2_xfer>;
+	status = "okay";
+
+	vdd_cpu_big0_s0: regulator@42 {
+		compatible = "rockchip,rk8602";
+		reg = <0x42>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_cpu_big0_s0";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <550000>;
+		regulator-max-microvolt = <1050000>;
+		regulator-ramp-delay = <2300>;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	vdd_cpu_big1_s0: regulator@43 {
+		compatible = "rockchip,rk8603", "rockchip,rk8602";
+		reg = <0x43>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_cpu_big1_s0";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <550000>;
+		regulator-max-microvolt = <1050000>;
+		regulator-ramp-delay = <2300>;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
 };
 
 &sdhci {
-- 
2.43.1


