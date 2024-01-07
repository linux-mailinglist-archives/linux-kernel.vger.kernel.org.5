Return-Path: <linux-kernel+bounces-19006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB8482665F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 23:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367AC1C20E7F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 22:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C49125C8;
	Sun,  7 Jan 2024 22:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amp24Fri"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F4413AC9;
	Sun,  7 Jan 2024 22:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3367a304091so1292685f8f.3;
        Sun, 07 Jan 2024 14:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704667066; x=1705271866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GhaiKiBvANWo59JD4b18pZUXdSPTrn5nNQAUnRnqMg0=;
        b=amp24FriP6KTSdndAspI69rC7V4t8YBidHxKgldO5Lighdlgg6zvUqz3d9m6W+65TG
         pqNAwqIHPYNBNn0KughI4mQ6w1MdnNWtOnqIeq5tTuzS5J7W4+H2gjzVvOC6BngHUPSk
         Vf+diilmzuiR+iiCTubix2afa/GAOt5we709CHWL++zb3WQAwMuKu6vCAvBAcXGVuT5K
         i5AhFQleUKzVKraPel4wjJr03onsJy/LOsQDveo2fIEn7hbZOFpQoqgXMW3wdvPhwyi+
         kQT6fhtDKQeb5+wGDke1YnhNxNPhicgFDvRaLZP6UBgUwKB5sGWpFIDNIYFMD9PxaNAq
         SrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704667066; x=1705271866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GhaiKiBvANWo59JD4b18pZUXdSPTrn5nNQAUnRnqMg0=;
        b=EJT8XpKFvAUjaINj1ihskK+mabH8d/5QojfNXSVCRgdHySYegg+cvArA9oH9UoOKzA
         rmCnCSN2w+KDI3AngqrX9SjdhOwyj/VrmX2Bl+g4Ls/yMnYZKLPqPyfSyiNxkEt2XIi4
         YQeTMTDlAFQ/FoXhev0SjxaPJFp201ucbSUsE7jrNMMzV6eIKNDy7VUzE6WP74Ga95FW
         SGPid8OX094znIHiZRLoIsraMqKmuiROtad2j4uZrRim+9KS9Ce8gT66t5kWlUe5TyGN
         Oe9U7aTViXCiK9FtWakemc/b7GUMc2gmx7dtwSeTzV9u66Q4sQHczBjglhCCOoIKLwsw
         nxJA==
X-Gm-Message-State: AOJu0Ywz/+Ig+OW/HOWUDN5H304VKet6rvVaaNbZfzxgr0tmu7dQ/5D8
	lMXtSMj3NCNrsSDHrSvr9wI=
X-Google-Smtp-Source: AGHT+IHbtTpDJCVHnLbP/mEAXIOl9+IjqLvn0kJzSyWzNt3xLzqfU/7qQMWukM0+J+LsEXRlMUSnmQ==
X-Received: by 2002:a5d:40c4:0:b0:337:476f:995c with SMTP id b4-20020a5d40c4000000b00337476f995cmr1052171wrq.120.1704667065877;
        Sun, 07 Jan 2024 14:37:45 -0800 (PST)
Received: from apple.sigmaris.info ([2a02:8010:6606:0:88c3:ea4a:8702:aa3b])
        by smtp.gmail.com with ESMTPSA id t3-20020a0560001a4300b003374555d88esm6216095wry.56.2024.01.07.14.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 14:37:45 -0800 (PST)
From: Hugh Cole-Baker <sigmaris@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: John Clark <inindev@gmail.com>,
	Thomas McKahan <tmckahan@singleboardsolutions.com>,
	Hugh Cole-Baker <sigmaris@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: enable NanoPC-T6 MiniPCIe power
Date: Sun,  7 Jan 2024 22:37:14 +0000
Message-Id: <20240107223714.8158-1-sigmaris@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NanoPC-T6 has a Mini PCIe slot intended to be used for a 4G or LTE
modem. This slot has no PCIe functionality, only its USB 2.0 pins are
wired to the SoC, and its USIM pins are wired to a SIM card slot on the
board. Define the 3.3v supply for the slot so it can be used.

Signed-off-by: Hugh Cole-Baker <sigmaris@gmail.com>
---
I've based the names directly on the schematic [1] (page 29) which uses
VDD_4G_3.3V and 4G_LTE_PWREN for the supply and enable signal respectively.
This means the enable pinctrl label needs an initial underscore. I'm OK with
changing that if it's considered ugly or there's a better suggested name.

[1]: https://wiki.friendlyelec.com/wiki/images/9/97/NanoPC-T6_2301_SCH.PDF

 .../boot/dts/rockchip/rk3588-nanopc-t6.dts      | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
index d7722772ecd8..d91af387f7c4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
@@ -159,6 +159,18 @@ vcc3v3_pcie30: vcc3v3-pcie30-regulator {
 		regulator-max-microvolt = <3300000>;
 		vin-supply = <&vcc5v0_sys>;
 	};
+
+	vdd_4g_3v3: vdd-4g-3v3-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio4 RK_PC6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&_4g_lte_pwren>;
+		regulator-name = "vdd_4g_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
 };
 
 &combphy0_ps {
@@ -504,6 +516,10 @@ pcie_m2_1_pwren: pcie-m21-pwren {
 	};
 
 	usb {
+		_4g_lte_pwren: 4g-lte-pwren {
+			rockchip,pins = <4 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
 		typec5v_pwren: typec5v-pwren {
 			rockchip,pins = <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
@@ -884,6 +900,7 @@ &uart2 {
 };
 
 &u2phy2_host {
+	phy-supply = <&vdd_4g_3v3>;
 	status = "okay";
 };
 
-- 
2.39.3 (Apple Git-145)


