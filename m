Return-Path: <linux-kernel+bounces-113074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FB3888142
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AAA21F26191
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C6314AD06;
	Sun, 24 Mar 2024 22:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mh7xpah/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC9D14A4EA;
	Sun, 24 Mar 2024 22:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319883; cv=none; b=rl1yuSXaXrohjI/H6CDGXx2vICPVA5kxxB1aUnq1sFJj9B/9XwrYY1g60VVa9aiKuVBB1kNZVHPzjwEN98bpf3ER5pJP1B85sDd7XkNdx3QfmvOVCfajbvuGVx5Xn2w6OGDM4rF9FGO4EiG14KDBcDJyy98GILr1CD/yqFt4KWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319883; c=relaxed/simple;
	bh=JZ9hjUv65VKWnCNf16bYhhk7KizDvVvRGq96t8SMwzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YmqtxRCAAlFOCrdicgAOgmXYPQ2Zj8R+P9EkSVIm60zRNkx9M8vyW16TGAoj5F3gTeevzNnmuimC/JO0Ts77AjHfzeJk82Fumwg1i+25wQYQDd1APf6a437I/BFpJbfq7XGhSJetwpn5HB2lcwtcWHmekbVpPnEpNqFw+IdZ9J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mh7xpah/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA09C43399;
	Sun, 24 Mar 2024 22:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319882;
	bh=JZ9hjUv65VKWnCNf16bYhhk7KizDvVvRGq96t8SMwzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mh7xpah/gwxeGhPEhRqIsW/t0jldMYky45laiZ/T2pos/fo9kFgLjHxnMsJTau6ao
	 /S7BeP/EqaYclui8JTQK1CpjqtMat01aCfHpPNBtk0MI9WXbU5JmVpIR5HWAQ6rPO8
	 WvOBhcSBJnzHzS90e5mDQQsVevJzHI1UlrrruY58Mcr84YzTy0DlN4nP0bGWEF3yV0
	 U7GmznnP/gRqW7QGsu9GLw+fzcoXhe/6ddMkoa181dXoOyCTWQpdMAEKt5kvH0RfqE
	 f6hKvCHv9h/Z/Z2Si8GTjDFytGfZZngGaBTarfO+H4dK+BDssMr1vF0LeNZU6LM9nl
	 WCCoiQFjrGQ1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Daniel Golle <daniel@makrotopia.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 187/715] arm64: dts: mediatek: mt7986: drop "#clock-cells" from PWM
Date: Sun, 24 Mar 2024 18:26:06 -0400
Message-ID: <20240324223455.1342824-188-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


