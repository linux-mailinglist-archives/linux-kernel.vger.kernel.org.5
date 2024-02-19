Return-Path: <linux-kernel+bounces-72075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B3385AEA1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 725FE284674
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9325A7B4;
	Mon, 19 Feb 2024 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=6tel.net header.i=@6tel.net header.b="hN8ntcPc"
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96405A0E9;
	Mon, 19 Feb 2024 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382135; cv=none; b=Q25hs4ru4kDSNL5ij1+omFjWib5yboLylOxEdQZNWVdwiSQMSsfs3WX4iPTND1nrVNm4iaTaGXMi8Aw96CQa0/kumULUz1TfmcOfNsm7bvLJ4rZZubZVnvpryenKx2xZhhOLzoVGNPRiOD4a8v3iJiD/bdWh3EtniglAWbHNm0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382135; c=relaxed/simple;
	bh=OQ+8UTq+tY1exkcTmF44GrHFcjR1YveGQgSJL/m7YpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4Zo8Ut/awbFx3ZFtpW6ABaRlZxjM5bXYJaVpNY9hpkPyFkwp82UcqYqLCmKfi2hPfqTyjIzb9zBkSpgOxfXuZdL2vEs28bwFBSd1ijDJWeIZs2t0vnmbZQ8X+VQZxJ83EsJhcpbFfUmcNE1u20FULaUiGiOztQHFb8LPfzXJjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=6tel.net; spf=pass smtp.mailfrom=6tel.net; dkim=pass (1024-bit key) header.d=6tel.net header.i=@6tel.net header.b=hN8ntcPc; arc=none smtp.client-ip=178.154.239.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=6tel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6tel.net
Received: from mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3285:0:640:fd1e:0])
	by forward502b.mail.yandex.net (Yandex) with ESMTPS id 1FC815EBA5;
	Tue, 20 Feb 2024 01:35:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id bYZIDNh7RSw0-thMYkJl5;
	Tue, 20 Feb 2024 01:35:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=6tel.net; s=mail;
	t=1708382125; bh=b4eLeZh5Mnbkx+vP9QhG8D6/bkdc9Is/49k/ny0l1yM=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=hN8ntcPcjSH7ehEGUMHSl64uKd2f9r8XbFLPVVeS6MIETBO1wZeaP5fNVvM4uJR/k
	 vHbZmqqDeHRdkKbr7x8gYqVD9rysxSKFEew6rHr/sReurUKr+gI40j2R4a++CIok7b
	 2OMAPcMczDofNEm5rY1NK72sUANXIo+2FB7CzvTI=
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
Subject: [PATCH 8/9] arm64: dts: rockchip: Add UART9 (bluetooth) to Khadas Edge 2
Date: Tue, 20 Feb 2024 01:34:24 +0300
Message-ID: <0a10afeff3aec3a8bccca2dbe4e65f7b4a2c4666.1708381247.git.efectn@protonmail.com>
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

Khadas Edge 2 has onboard AP6275P Wi-Fi6 (PCIe2) and BT5 (UART9) module.
This commit enables UART9.

Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
---
 .../dts/rockchip/rk3588s-khadas-edge2.dts     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index c2a329f151a1..767e21b2dc34 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -244,6 +244,20 @@ ir_receiver_pin: ir-receiver-pin {
 			rockchip,pins = <1  RK_PA7  RK_FUNC_GPIO  &pcfg_pull_none>;
 		};
 	};
+
+	wireless-bluetooth {
+		bt_reset_pin: bt-reset-pin {
+			rockchip,pins = <0 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_wake_pin: bt-wake-pin {
+			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		bt_wake_host_irq: bt-wake-host-irq {
+			rockchip,pins = <0 RK_PD5 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
 };
 
 &pcie2x1l2 {
@@ -647,6 +661,12 @@ &uart2 {
 	status = "okay";
 };
 
+&uart9 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart9m2_xfer &uart9m2_ctsn>;
+	status = "okay";
+};
+
 &u2phy2 {
 	status = "okay";
 };
-- 
2.43.1


