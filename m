Return-Path: <linux-kernel+bounces-117448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD3388AB8A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1B11C3D801
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4925712D74C;
	Mon, 25 Mar 2024 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="usN4vTLw"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C312912C54F;
	Mon, 25 Mar 2024 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383558; cv=none; b=aAJQEwY5aOBxl5iA2X9t3SJ3PyYnbbAi2XsKqvmpB+/O2o6RZPn0a4O66xCnRzc38EUnu3tF3+xcLdJJcU0CAteCUJvdE1T7We4IRkTvq/QT9wblNqBMPQqOWfgE4c6+s94lJJ7JVpcwMIkz0aPwY6SwZzfECLQDDO6N6sMesBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383558; c=relaxed/simple;
	bh=IwzaoHW/HagSH6BZIf0SV6u2TapiSTBNzgHXVGJRXNs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b7BRf+xaU45tHjdjs4Fpw9LoDMONb/rDifOp9K4TjQ7Jsbt8fkiD6Jxd25II8otbly1OZ3i21lbrv6LqWBTMoStQtfrEhkqbpuz7ELkGy019APbi91QF67kSuxtfKjQUuopidmKuaxUFXngNFUiAvbmwFbnrnNAZP5rTmXh7KXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=usN4vTLw; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711383550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eeOca0jbpn3vxiTcP6H4it2Gf901TrwEixbj2YXQxJc=;
	b=usN4vTLw2BTrm1ZtUsYd9bMu8sefjTpAeJQxdnBsko2UADgccF2naLIgLbsHe/sx/pY5Sf
	aFhOhb/fgrWjEiEhhi9d7PdhjtFpWi50o4dmgS5XE8SNwSrkhCdyKs6dLOt/XEYoX7A8CR
	UgyD1T6d3HsvPK9S6eD1KNYNNbDoM6qq3HmN8bG4GHTYukr8aO8YCXScC0bpbqM87D0yCg
	n6QJOqEwGGkcdF92uy8qsQGXw/Tm5590pjAKU/t2FgECrkXxTfTG1FkVPZOGro7sw1kkH6
	SLF3EoI0XnRcTS8CZjkjRCKqUj+hn4YDFKb0gfiYJzwObEejr/q+xitu2sr/xA==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	boris.brezillon@collabora.com,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	sebastian.reichel@collabora.com
Subject: [PATCH] arm64: dts: rockchip: quartzpro64: Enable the GPU
Date: Mon, 25 Mar 2024 17:19:04 +0100
Message-Id: <0f3759ee390f245dac447bbee038445ddfecbec0.1711383286.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Following the approach used to enable the Mali GPU on the rk3588-evb1, [1]
do the same for the Pine64 QuartzPro64, which uses nearly identical hardware
design as the RK3588 EVB1.

The slight disadvantage is that the regulator coupling logic requires the
regulators to be always on, which is also noted in the comments.  This is
obviously something to be improved at some point in the future, but should
be fine for now, especially because the QuartzPro64 isn't a battery-powered
board, so low power consumption isn't paramount.

[1] https://lore.kernel.org/linux-rockchip/20240325153850.189128-5-sebastian.reichel@collabora.com/

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 .../arm64/boot/dts/rockchip/rk3588-quartzpro64.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
index 67414d72e2b6..68d432c61ea5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
@@ -285,6 +285,12 @@ &gmac0_rgmii_clk
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&vdd_gpu_s0>;
+	sram-supply = <&vdd_gpu_mem_s0>;
+	status = "okay";
+};
+
 &i2c2 {
 	status = "okay";
 
@@ -491,11 +497,15 @@ rk806_dvs3_null: dvs3-null-pins {
 		regulators {
 			vdd_gpu_s0: dcdc-reg1 {
 				regulator-name = "vdd_gpu_s0";
+				/* regulator coupling requires always-on */
+				regulator-always-on;
 				regulator-boot-on;
 				regulator-enable-ramp-delay = <400>;
 				regulator-min-microvolt = <550000>;
 				regulator-max-microvolt = <950000>;
 				regulator-ramp-delay = <12500>;
+				regulator-coupled-with = <&vdd_gpu_mem_s0>;
+				regulator-coupled-max-spread = <10000>;
 
 				regulator-state-mem {
 					regulator-off-in-suspend;
@@ -545,11 +555,15 @@ regulator-state-mem {
 
 			vdd_gpu_mem_s0: dcdc-reg5 {
 				regulator-name = "vdd_gpu_mem_s0";
+				/* regulator coupling requires always-on */
+				regulator-always-on;
 				regulator-boot-on;
 				regulator-enable-ramp-delay = <400>;
 				regulator-min-microvolt = <675000>;
 				regulator-max-microvolt = <950000>;
 				regulator-ramp-delay = <12500>;
+				regulator-coupled-with = <&vdd_gpu_s0>;
+				regulator-coupled-max-spread = <10000>;
 
 				regulator-state-mem {
 					regulator-off-in-suspend;

