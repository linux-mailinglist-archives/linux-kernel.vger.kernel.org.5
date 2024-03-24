Return-Path: <linux-kernel+bounces-114159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A444F8888C7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3367FB21767
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC4A204E35;
	Sun, 24 Mar 2024 23:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFiPa1Gt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F762057C3;
	Sun, 24 Mar 2024 23:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321484; cv=none; b=DjjyYltNudWsXDJmQV27LFNfk5cvEn3Osxrlb7PEdmCggVNu4PhUQzzx78RIt/GjwxhvLhv+8FF4z/OnPxLgGba43lfkTn+Ut97cTMmhD2xNSHwbZ4g6grC8ajjdMlq7lXogiZmW6oawJMfwkTcIthRHJabFRgfu86jHywoO80Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321484; c=relaxed/simple;
	bh=JZ9hjUv65VKWnCNf16bYhhk7KizDvVvRGq96t8SMwzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jVzmiIL9du0QwdyMpIUqgHwSqA06aHRNpawPYkJFEEjWzV0bEHcmJpdRULdGBxIT54c68VdIXVb/9ySG5Z7LC178n55sweKd+celI0VLym6pQ4R7sWIXQaWM2S4F7rC6wdYMP1gN7tbp0FUfW/pGqsy8j7B+fIcQmv4ysn/ugqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFiPa1Gt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBF6C43390;
	Sun, 24 Mar 2024 23:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321484;
	bh=JZ9hjUv65VKWnCNf16bYhhk7KizDvVvRGq96t8SMwzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YFiPa1GtDJiC1HaxU+h7kmSOxhwDRV6phdrZt5Y4RqSU0oQg8UzH/txS0lJH9sp8X
	 uAUYj8/jp3NLYiKRR7Y74HUg4BGvVd2k5/Pql3R2XEgLA8r6oS0naaNGc9Z4XhViiH
	 eEhM59vtWoZ8mpFtGYNwkANAoEeKLyBTM2ZWdTf9X14wO5hqvbYjbYEmsCCRHDzYF8
	 4Z/7ApZgsA+vdVuUPVLRpgsRB6oLsBmlFbprgLILM7ycZA6Wr/qIbs89UScEZF5ph9
	 OOmI62kNlAhmfBb5rV3PXadc8gMzf8nXfKKdxhxL7Sm0bI/V8PEfZfe0x2uLbk9nfS
	 0eRRZHUOk/DjA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Daniel Golle <daniel@makrotopia.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 209/638] arm64: dts: mediatek: mt7986: drop "#clock-cells" from PWM
Date: Sun, 24 Mar 2024 18:54:06 -0400
Message-ID: <20240324230116.1348576-210-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


