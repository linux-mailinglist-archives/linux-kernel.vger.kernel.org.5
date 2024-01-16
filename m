Return-Path: <linux-kernel+bounces-28117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 146FE82FA65
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2DC628AA93
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E778154C0E;
	Tue, 16 Jan 2024 19:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLXGwrIX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD84F154BFE;
	Tue, 16 Jan 2024 19:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435179; cv=none; b=M0TKb9Ii7vp8McZV0n9laI/fO6u68lCe4F7MhC7gkgSRDaBDve8tI4+Str6t52HwLR5xJ61BVdNFtxlR42KSVk/s8LbSo+OvHsGrUu4O4qhpYCXrfUDVKrnEPeA0zAQpWMdSBB6A7eSVseuKK8j2fo0gsUuNLjvZVOwjkIzoltg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435179; c=relaxed/simple;
	bh=+0dGaX1WomVTx+JiBsBfua71kEuDLYrscLBuSIfB700=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=iKq13GUyZClOXlyZdVj5m8VEt2JHLfpyrGSUEx8uGxx0eGOWt13h/LqC7qPo9sjhBW4BsARaV7UJLRU3px5S3JpPdU/MQgpU8RhPll6kSPcBbFBUD4QseiyYHkTUHwcqj2+zSiFWqBivc8dfbAxo2o+CFWxStnCXKjZD+G65LNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLXGwrIX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABDDC43399;
	Tue, 16 Jan 2024 19:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435179;
	bh=+0dGaX1WomVTx+JiBsBfua71kEuDLYrscLBuSIfB700=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bLXGwrIXsgPC9ZKC/jW4cXHRJiNRchGDEZq2f0haONG1fB64Pw6mf/ryJMntU0q25
	 UG9Rr/fd/qVORGxRyhol69c8+L57CZ47fp/25BYUdnCaBak0qyNGUo7oZQhDO6e8Aj
	 VnJYANf9N+XRS5EXE7nhQykuxOUpM3//mkDA4ywB4NVH6BR+7TkEk8AlE0eRSBQkuJ
	 jtD6vhWxy8dpIgfqGgWXBqDJzYBiwYIm8y84hPOguPlxPQn0HvRDsWAKYiL9QyOX4F
	 GBUZEp8dDJXBFTp/DkJ5lyxudKGEEr+CGTo79G+8dnCxPDonc1OTXjJVCeI6xw/idE
	 tos2x9N86R8gQ==
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
Subject: [PATCH AUTOSEL 5.15 30/47] ARM: dts: imx27-apf27dev: Fix LED name
Date: Tue, 16 Jan 2024 14:57:33 -0500
Message-ID: <20240116195834.257313-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195834.257313-1-sashal@kernel.org>
References: <20240116195834.257313-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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


