Return-Path: <linux-kernel+bounces-28222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F59782FBC8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C341C27023
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833D416B65C;
	Tue, 16 Jan 2024 20:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ki1AEHWm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44DC16B649;
	Tue, 16 Jan 2024 20:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435493; cv=none; b=jrw91Gf3t5RMUJDo4OHgpt9qYgn8ZIhW30b208TGNlPmfw39S3iOusmfP7+AmkZIFGABYhJXVetyGZblh2Ayjz9PKDwmRv9hEdlyI9TTS8yt0WxDwhZ1MqyQvzeV8hJJ1vSPV+H8mLfwJI+B0TFHhGbosPm5Vw+ceWOEfcZTqto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435493; c=relaxed/simple;
	bh=XS4xD5+JSM0hLaFKTHOhUtxbkAsrKi3g0kPahUStMkg=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=rFmow7OgOxFMizPxkO8SQNnk9Wz+mLMaa9m/zQyrt3G5CyPHELhfRjH9y2ssF3CsWGUsBH8C9a9D3b9IxARDb9uY7h/aanNEBdNdAc8P/vulnpgO8QO2z1UQKHWAb/NXn5M+X6jpH1ubbJlRiMOrVUMcy8jCA5+JrEOYgJjrqlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ki1AEHWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F127C43399;
	Tue, 16 Jan 2024 20:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435493;
	bh=XS4xD5+JSM0hLaFKTHOhUtxbkAsrKi3g0kPahUStMkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ki1AEHWmowu6e7FRn36XQOLoDqmyfION1eGy3rkBcbD4ww9jzotgMKGteaA5v/syG
	 P90Dpg53BTtXBjnN8yRczhr5XxoW4bFjH8GrHl9FiSVDKWAWq3Uf9okN1KwyN5jS3n
	 0YzX4C7p2cJESvpll4Ma4EYiuNDW61es6zS/6ddRtBfdjnzB33o1K4FZhIPNzFz4BR
	 tR1BOX5f2CcIp1xHXDb+zuCJHPwtx90dObpKzcJVNgmV8omSSA2NtJYPg18z2Ai/F/
	 wxd954sAZhBbyRYo4ReurDv82JxDZMoyW7zLFF86kDMvynYxEY2iqEgn6hDeTIaaxW
	 iVyo2vyy+pyDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fabio Estevam <festevam@denx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 11/22] ARM: dts: imx25/27-eukrea: Fix RTC node name
Date: Tue, 16 Jan 2024 15:04:05 -0500
Message-ID: <20240116200432.260016-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200432.260016-1-sashal@kernel.org>
References: <20240116200432.260016-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit 68c711b882c262e36895547cddea2c2d56ce611d ]

Node names should be generic. Use 'rtc' as node name to fix
the following dt-schema warning:

imx25-eukrea-mbimxsd25-baseboard.dtb: pcf8563@51: $nodename:0: 'pcf8563@51' does not match '^rtc(@.*|-([0-9]|[1-9][0-9]+))?$'
	from schema $id: http://devicetree.org/schemas/rtc/nxp,pcf8563.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi | 2 +-
 arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi b/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
index e4d7da267532..5858ec8a409a 100644
--- a/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
+++ b/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
@@ -35,7 +35,7 @@ &i2c1 {
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
-	pcf8563@51 {
+	rtc@51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 	};
diff --git a/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi b/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
index c85f9d01768a..56c790705155 100644
--- a/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
+++ b/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
@@ -39,7 +39,7 @@ &i2c1 {
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
-	pcf8563@51 {
+	rtc@51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 	};
-- 
2.43.0


