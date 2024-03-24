Return-Path: <linux-kernel+bounces-112605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8C2887BDC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 07:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3FC61F219E2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 06:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA55314008;
	Sun, 24 Mar 2024 06:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thefossguy.com header.i=@thefossguy.com header.b="hHxJ/wM8"
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461E51A38EB
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 06:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711261712; cv=none; b=GQQJf4bB65LizEs+WpyUuZxn+lxdFn7Z+nQpEDb3IDXRp7nF1ALBFW8VJ774ZASe1C74Zsn44F520afNz9XQB319HzNKYD7O1TYXedxal41NiOxLOsqLZ3tQo0Gbkqr0xBuHnabPEDKLpF2HENCs1FxFy7OVijEGA7ARPQkySFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711261712; c=relaxed/simple;
	bh=DiFiTxtC4+mNZik5jfzRqgogbn+kJlJXcy4jKp87dUY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=EbAFxDtXpB800+9d492GRbp7rmoEFNxr44nkwBQhGrO0E/+JBLRMPT1fZ5q6zlkDDhs/JpSZbMjkaK0d3zsDABH3JbbffllQ06J072P6WpyMUFvYAtALbOcztpT/IqNG2Jaupd905OLE5OaXlnj8OR55T9woO6y901SFO7afLQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thefossguy.com; spf=pass smtp.mailfrom=thefossguy.com; dkim=pass (2048-bit key) header.d=thefossguy.com header.i=@thefossguy.com header.b=hHxJ/wM8; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thefossguy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thefossguy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thefossguy.com;
	s=protonmail; t=1711261707; x=1711520907;
	bh=a63CZcwFphRB57yPggM+jr72sf2vf1666LkQCgfK334=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=hHxJ/wM8FAmmGAR72NKrEG2yhdCpRUhNFL6Xd7KLv6Qe1y2gv5z8n4yZUEQv8ljNO
	 iOy67FMN0U+dv8rR31yUEPONhfaK8yYync3e5Kudlcez3M0BeH2joCUR1nX2pDazWG
	 21JtDOr8cLGOYAY6xeHDB6BhLBX3L4O8UtyqxsE3vJcvOiiJBWEhHVOR+Qh/5Vm5Ay
	 DN/DIYPjjsTtXMrC0CGbujV+DKRORGGKGKi9z1TxqDgEQdoM7E2NR5JnITFSsClZ+K
	 jIkmw55zBdFPIxvo6BiZ0f4tNOw9xc14i7kldml9vHyYgc4JZ8snub59c5v2M+gvtR
	 +WYLAqyAEL4sQ==
Date: Sun, 24 Mar 2024 06:28:23 +0000
To: robh@kernel.org
From: Pratham Patel <prathampatel@thefossguy.com>
Cc: krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, heiko@sntech.de, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] arm64: dts: rockchip: disable analog audio for rock-5b
Message-ID: <20240324062816.145858-1-prathampatel@thefossguy.com>
Feedback-ID: 104309535:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------3c806d4c2f81f7a599b0ee2b3bd7400598ea8a4eeaf69b05d445b87dd6a7713e"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------3c806d4c2f81f7a599b0ee2b3bd7400598ea8a4eeaf69b05d445b87dd6a7713e
Content-Type: multipart/mixed;
 boundary=8b8383b24c45133ed25453f6bb43398b50bf4dbdc8feb4450923da509f1c
From: Pratham Patel <prathampatel@thefossguy.com>
To: robh@kernel.org
Cc: krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] arm64: dts: rockchip: disable analog audio for rock-5b
Date: Sun, 24 Mar 2024 11:58:16 +0530
Message-ID: <20240324062816.145858-1-prathampatel@thefossguy.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0

--8b8383b24c45133ed25453f6bb43398b50bf4dbdc8feb4450923da509f1c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The addition of `of: property: fw_devlink: Fix stupid bug in remote-endpoint parsing`
has surfaced an issue with the analog audio property in the devicetree
for the rock-5b. Booting kernels v6.7.9+ and v6.8.0+ would cause the
following call trace:

[   21.595068] Call trace:
[   21.595288]  smp_call_function_many_cond+0x174/0x5f8
[   21.595728]  on_each_cpu_cond_mask+0x2c/0x40
[   21.596109]  cpuidle_register_driver+0x294/0x318
[   21.596524]  cpuidle_register+0x24/0x100
[   21.596875]  psci_cpuidle_probe+0x2e4/0x490
[   21.597247]  platform_probe+0x70/0xd0
[   21.597575]  really_probe+0x18c/0x3d8
[   21.597905]  __driver_probe_device+0x84/0x180
[   21.598294]  driver_probe_device+0x44/0x120
[   21.598669]  __device_attach_driver+0xc4/0x168
[   21.599063]  bus_for_each_drv+0x8c/0xf0
[   21.599408]  __device_attach+0xa4/0x1c0
[   21.599748]  device_initial_probe+0x1c/0x30
[   21.600118]  bus_probe_device+0xb4/0xc0
[   21.600462]  device_add+0x68c/0x888
[   21.600775
]  platform_device_add+0x19c/0x270
[   21.601154]  platform_device_register_full+0xdc/0x178
[   21.601602]  psci_idle_init+0xa0/0xc8
[   21.601934]  do_one_initcall+0x60/0x290
[   21.602275]  kernel_init_freeable+0x20c/0x3e0
[   21.602664]  kernel_init+0x2c/0x1f8
[   21.602979]  ret_from_fork+0x10/0x20

This is a temporary workaround to at least have the SBC boot. There are
a few more SBCs that _might_ have this issue. I suspect that the
rock-5a and nanopc-t6 might also have this issue but I do not own either
board to verify this claim, yet.

Closes: https://lore.kernel.org/regressions/28S1EMw5YOnQIBpQ8_qaZZ6c9Go-j6-lLuWWbRpe6-MtRUd7Ay-uXq8JHbVVtJv3LzpxjI8jYg7ukNntbN22PVV-hOWbuTY8FNWgvM4zSwI=@thefossguy.com/T/#m69eedea6fbcb0591d54a9ccd478c2782ef045547

Signed-off-by: Pratham Patel <prathampatel@thefossguy.com>
---
 .../boot/dts/rockchip/rk3588-rock-5b.dts      | 110 +++++++++---------
 1 file changed, 57 insertions(+), 53 deletions(-)

diff --git a/arch/arm64/boot/d
ts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 1fe8b2a0e..6d3b9f52c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -20,22 +20,24 @@ chosen {
 		stdout-path = "serial2:1500000n8";
 	};
 
-	analog-sound {
-		compatible = "audio-graph-card";
-		label = "rk3588-es8316";
-
-		widgets = "Microphone", "Mic Jack",
-			  "Headphone", "Headphones";
-
-		routing = "MIC2", "Mic Jack",
-			  "Headphones", "HPOL",
-			  "Headphones", "HPOR";
-
-		dais = <&i2s0_8ch_p0>;
-		hp-det-gpio = <&gpio1 RK_PD5 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&hp_detect>;
-	};
+	/*
+	 *analog-sound {
+	 *	compatible = "audio-graph-card";
+	 *	label = "rk3588-es8316";
+	 *
+	 *	widgets = "Microphone", "Mic Jack",
+	 *		  "Headphone", "Headphones";
+	 *
+	 *	routing = "MIC2", "Mic Jack",
+	 *		  "Headphones", "HPOL",
+	 *		  "Headphones", "HPOR";
+	 *

+	 *	dais = <&i2s0_8ch_p0>;
+	 *	hp-det-gpio = <&gpio1 RK_PD5 GPIO_ACTIVE_HIGH>;
+	 *	pinctrl-names = "default";
+	 *	pinctrl-0 = <&hp_detect>;
+	 *};
+	 */
 
 	leds {
 		compatible = "gpio-leds";
@@ -236,43 +238,45 @@ hym8563: rtc@51 {
 	};
 };
 
-&i2c7 {
-	status = "okay";
-
-	es8316: audio-codec@11 {
-		compatible = "everest,es8316";
-		reg = <0x11>;
-		clocks = <&cru I2S0_8CH_MCLKOUT>;
-		clock-names = "mclk";
-		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
-		assigned-clock-rates = <12288000>;
-		#sound-dai-cells = <0>;
-
-		port {
-			es8316_p0_0: endpoint {
-				remote-endpoint = <&i2s0_8ch_p0_0>;
-			};
-		};
-	};
-};
-
-&i2s0_8ch {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2s0_lrck
-		     &i2s0_mclk
-		     &i2s0_sclk
-		     &i2s0_sdi0
-		     &i2s0_sdo0>;
-	status = "okay";
-
-	i2s0_8ch_p0: port {
-		i2s0_8ch_p0_0: endpoint {
-			dai-format = "i2s";
-			mclk-fs = <256>;
-			remote-endpoint = <&es8316_p0_0>;
-		};
-	};
-};

+/*
+ *&i2c7 {
+ *	status = "okay";
+ *
+ *	es8316: audio-codec@11 {
+ *		compatible = "everest,es8316";
+ *		reg = <0x11>;
+ *		clocks = <&cru I2S0_8CH_MCLKOUT>;
+ *		clock-names = "mclk";
+ *		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
+ *		assigned-clock-rates = <12288000>;
+ *		#sound-dai-cells = <0>;
+ *
+ *		port {
+ *			es8316_p0_0: endpoint {
+ *				remote-endpoint = <&i2s0_8ch_p0_0>;
+ *			};
+ *		};
+ *	};
+ *};
+ *
+ *&i2s0_8ch {
+ *	pinctrl-names = "default";
+ *	pinctrl-0 = <&i2s0_lrck
+ *		     &i2s0_mclk
+ *		     &i2s0_sclk
+ *		     &i2s0_sdi0
+ *		     &i2s0_sdo0>;
+ *	status = "okay";
+ *
+ *	i2s0_8ch_p0: port {
+ *		i2s0_8ch_p0_0: endpoint {
+ *			dai-format = "i2s";
+ *			mclk-fs = <256>;
+ *			remote-endpoint = <&es8316_p0_0>;
+ *		};
+ *	};
+ *};
+ */
 
 &pcie2x1l0 {
 	pinctrl-names = "default";
-- 
2.42.0


--8b8383b24c45133ed25453f6bb43398b50bf4dbdc8feb4450923da509f1c
Content-Transfer-Encoding: base64
Content-Disposition: attachment; name="publickey -
 prathampatel@thefossguy.com - f2dde54d.asc"; filename="publickey -
 prathampatel@thefossguy.com - f2dde54d.asc"
Content-Type: application/pgp-keys; name="publickey -
 prathampatel@thefossguy.com - f2dde54d.asc"; filename="publickey -
 prathampatel@thefossguy.com - f2dde54d.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tClZlcnNpb246IEdvcGVuUEdQIDIu
Ny4zCkNvbW1lbnQ6IGh0dHBzOi8vZ29wZW5wZ3Aub3JnCgp4ak1FWmZjR2RSWUpLd1lCQkFIYVJ3
OEJBUWRBa2VYM3NrdFI1R0lZQTM5VXhoRTlZcitZMy8zd0ZXUmxmVnlPClhsaWdnS2ZOT1hCeVlY
Um9ZVzF3WVhSbGJFQjBhR1ZtYjNOelozVjVMbU52YlNBOGNISmhkR2hoYlhCaGRHVnMKUUhSb1pX
WnZjM05uZFhrdVkyOXRQc0tNQkJBV0NnQStCWUpsOXdaMUJBc0pCd2dKa01lcFhtOWRLYStXQXhV
SQpDZ1FXQUFJQkFoa0JBcHNEQWg0QkZpRUU4dDNsVFJRTDQ4NE9oNDE3eDZsZWIxMHByNVlBQUNi
UUFQOUxzU3BSClQwSTV2TC8ycHpBa2F2UVhLdStWR1BRMk44RUVYZGpSVkRseGl3RUFwMVpSUHQz
aTlEb2pxeDU4T0xDZHc3bEcKMlVwdkJGZ2dCeGVrV216d1dRbk9PQVJsOXdaMUVnb3JCZ0VFQVpk
VkFRVUJBUWRBcmU5anlpVHdUUEZKM1prMgpvTVd0ZDVxSi9zcWNKRUZrckZxNUpVVzRWalVEQVFn
SHduZ0VHQllLQUNvRmdtWDNCblVKa01lcFhtOWRLYStXCkFwc01GaUVFOHQzbFRSUUw0ODRPaDQx
N3g2bGViMTBwcjVZQUFEVEZBUDlZRkgvQXErNUV3ekdDTEllaE00YmwKUW5hK2t0cnNPRWlwVllV
TVZMd0tjQUQvVktHQzR4VG1MQ1RBQ0NwU2pGN1VHMFVjY005VTRPbVlXZGVVT0dSTQphd1k9Cj01
cTBtCi0tLS0tRU5EIFBHUCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0=
--8b8383b24c45133ed25453f6bb43398b50bf4dbdc8feb4450923da509f1c--

--------3c806d4c2f81f7a599b0ee2b3bd7400598ea8a4eeaf69b05d445b87dd6a7713e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYIACcFAmX/yAYJEMepXm9dKa+WFiEE8t3lTRQL484Oh417x6leb10p
r5YAAPO5AP9YZpo1HThMcfrMLya9+c3+SBqyU8JuDWvN2MRLtkaMMgEApkZZ
dpmaWfNi4Vdfs4OUd1oSAfLGUw9dCGUaufd3JQk=
=GeuM
-----END PGP SIGNATURE-----


--------3c806d4c2f81f7a599b0ee2b3bd7400598ea8a4eeaf69b05d445b87dd6a7713e--


