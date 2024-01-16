Return-Path: <linux-kernel+bounces-28165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D075482FB08
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859E01F2A793
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0648A15F331;
	Tue, 16 Jan 2024 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmAFCAN1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473A515F321;
	Tue, 16 Jan 2024 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435323; cv=none; b=CTt/Dm2mZPw2LmBswdqu5FOIzD9VVmz3bW5OLglv/bvs3vwf7T1oNFtwQVRJtRgDVTaL5WJ36ezOMTNgNnfvqFi+9OklYqaLbsMfcxtTJk2SmkN9BrwHri2+UMfU3lF5gz8L/9enrN92EoF563kguJ3SmuCS+UWVT6/gzXmqVrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435323; c=relaxed/simple;
	bh=+0dGaX1WomVTx+JiBsBfua71kEuDLYrscLBuSIfB700=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=Tf0q80NDpnfP3J7ZeMr82k9wyKgZCfWJO3eUwqCk1NZas+rW6Rzp01qyF272PB5mjfaJ3bqYJWDvSPOGqMV+1zKlcOGNBmDBfChlJdvwiQCGWytI2OhhBglzBS6kaIhJ7d/OuNeaHYwK3i/042UPpPgWwoXWx1462k+lMVULmSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmAFCAN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A57CC43609;
	Tue, 16 Jan 2024 20:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435323;
	bh=+0dGaX1WomVTx+JiBsBfua71kEuDLYrscLBuSIfB700=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rmAFCAN1QR6FTTklSUDjHe7JnnkjiBlQcJ8ICl7pQy8KZ7xopS7ixEmhcHC1067cR
	 bW7IpcRO3cWj800AzWXBZXCCc0ep15NgoCmcua+0XflEx5YaGU0Q0wLlHJlgBnVpSA
	 O2e28SEJQKhEXBpY1WhEoIsXvR8zgr7xNpbtIWPjzWc+zoc3Fr+iI1KBgE+3aY7VQq
	 XOdpczOHIHAYjoNc+xGaPk7dF5Cn3HjUttctOSoPpK9Zuwk9tr8JIxq1xfO99cVkfM
	 y9eMjHutavMKlMFmacQlnNAcFRHLnYYYKVbVrv0JYxjsilpWAVO+clGKR6bnt97ZMV
	 6PIe73uosxkEA==
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
Subject: [PATCH AUTOSEL 5.10 29/44] ARM: dts: imx27-apf27dev: Fix LED name
Date: Tue, 16 Jan 2024 14:59:58 -0500
Message-ID: <20240116200044.258335-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200044.258335-1-sashal@kernel.org>
References: <20240116200044.258335-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit dc35e253d032b959d92e12f081db5b00db26ae64 ]

Per leds-gpio.yaml, the led names should start with 'led'.

Change it to fix the following dt-schema warning:

imx27-apf27dev.dtb: leds: 'user' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/leds/leds-gpio.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx27-apf27dev.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/imx27-apf27dev.dts
index 68fcb5ce9a9e..3d9bb7fc3be2 100644
--- a/arch/arm/boot/dts/imx27-apf27dev.dts
+++ b/arch/arm/boot/dts/imx27-apf27dev.dts
@@ -47,7 +47,7 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		user {
+		led-user {
 			label = "Heartbeat";
 			gpios = <&gpio6 14 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
-- 
2.43.0


