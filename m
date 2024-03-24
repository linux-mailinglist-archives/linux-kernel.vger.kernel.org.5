Return-Path: <linux-kernel+bounces-113702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6570C88861D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9644A1C256A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECF61E5843;
	Sun, 24 Mar 2024 22:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5s/2GKu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4EF86276;
	Sun, 24 Mar 2024 22:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320680; cv=none; b=hFsA8DZzmZ+F0dXh8XzYARQIzI6wecOpQZE85Wrb3Heq8mBQVPOCvlfnM26wKlg1sLdvem9DA/fthLNOKP+Oa0L4hrHuM3q1kPj+rWVQCfYnrmsGxBcExjA8oINRNqnM7VLipDR3rk0Ev0BRmC8BAi7fEUfERI9Llq71Wx2u3zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320680; c=relaxed/simple;
	bh=JZ9hjUv65VKWnCNf16bYhhk7KizDvVvRGq96t8SMwzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTi0f5RovxP6UMmOdqAZeyjR3dSb5RVE/ub5e0YnuOGTo+Ph/SYa3iecARHN1hxxUNYMbAtq0ZkfGYW/PcW2JrL8r9s0X3CVWTcexxQnP7UnoRIJNpN4Ai12L/NYMPU9KDdjbJXhjdUS+RaQCHTfVxDPYPv7AGb/jkEFfosHrpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5s/2GKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A15EC43399;
	Sun, 24 Mar 2024 22:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320679;
	bh=JZ9hjUv65VKWnCNf16bYhhk7KizDvVvRGq96t8SMwzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f5s/2GKuPrhg20fFVueR/7w/BQr/PX2+QYDdnIWLO9AIVmUjpaEEIU9Qqf+OjQp7Z
	 OqQDD/6Ark7CYbN+qEbVYEE/2MF0cje1ukUVaY6cma7WRPUeE9wDqz5vuopKDIvwrn
	 0aHLyXUGP82ztBFkcprTkJed7vQUgVW6/6mhwU0iiW0kgNy4whuHdBebBqjRAxCh2o
	 CfZ+0PeJOz048CRsLCo2KNpvdBlXb+3I1LwTNUMZXn3xGLtSIvOoWb2ST3jUVe3SIn
	 ASzUJiI1Mafg/1dCbeeNUgIlUvQhvJsyz0cD4YKPyPZk1MiOU/38y3Zv68cJUw9zpE
	 sNBN8rXkCq3/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Daniel Golle <daniel@makrotopia.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 241/713] arm64: dts: mediatek: mt7986: drop "#clock-cells" from PWM
Date: Sun, 24 Mar 2024 18:39:27 -0400
Message-ID: <20240324224720.1345309-242-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

[ Upstream commit 0b721691f0c80af682d0ef3aa4a177c23d41b072 ]

PWM is not a clock provider and its binding doesn't specify
"#clock-cells" property.

This fixes:
arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtb: pwm@10048000: '#clock-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/pwm/mediatek,mt2712-pwm.yaml#

Fixes: eabb04df46c6 ("arm64: dts: mt7986: add PWM")
Cc: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Link: https://lore.kernel.org/r/20240101182040.28538-1-zajec5@gmail.com
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index a7d9c3246a875..7b6591509c54d 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -242,7 +242,6 @@ crypto: crypto@10320000 {
 		pwm: pwm@10048000 {
 			compatible = "mediatek,mt7986-pwm";
 			reg = <0 0x10048000 0 0x1000>;
-			#clock-cells = <1>;
 			#pwm-cells = <2>;
 			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&topckgen CLK_TOP_PWM_SEL>,
-- 
2.43.0


