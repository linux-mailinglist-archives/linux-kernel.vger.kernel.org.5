Return-Path: <linux-kernel+bounces-113075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A150888144
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAAB31C215B7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD38E14AD24;
	Sun, 24 Mar 2024 22:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGM6jiF6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CBA54735;
	Sun, 24 Mar 2024 22:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319884; cv=none; b=oOwk7mX4haZFdMDpn/z7eKzE24t2j/YGdPfA6noOVVWyZb/sSB0BSBXYVVYHFg+f1DJzXlqbq8qZg9Z7vc9rMySVvQTC4w7g0N9o9nulYHE6e+I0qHfSa8iWtVKqFWzJ9NRnWGneWRZoFFMrUDoC/5JAjslDCGLChe9g+cbd7TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319884; c=relaxed/simple;
	bh=/qCNevVVEggzTf1GpDuuZorY4cKNTJEWoKSpqvi5tJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=df5Gho7UBqLIdc1MMj1R59Im+s9iQaiEf4zg7KQIeUePN5Gjtd+gpoQfDcc8qLcIpRXv9dTOZDvYp8ACWaMM1KByr+UCgY6zB2OmEEUS769jHZAuhAwSa3z9/uAY/eO3YkgH9wZkVt5WEX4Um7dCakvsaAWFyWmm7V0VIOq1m+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGM6jiF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1102AC433F1;
	Sun, 24 Mar 2024 22:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319883;
	bh=/qCNevVVEggzTf1GpDuuZorY4cKNTJEWoKSpqvi5tJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZGM6jiF6fwnzwHDo91seJ55WU12pnXfNlLoI2b47VFYK8lJxxpIRXTr6ojUbOvNIK
	 x00SjsPH4FlK8Kc/1pQh+mctY2YwJrLyPb5t11OBRAQDzaNusWqe5y0Gj8orsSpKrY
	 SDaR6+5YvN1A0IhW+v6dM+wSQfFzac0sXmMbtaEnCxeU9mqYmhz9EXO3Ks51zzne39
	 51ZYX8/eJ2IxkJ32BbF6WqG7kp3QSD7M1/OxG38sny7E59Se1IH/9zfg6hwEnTmFDu
	 FmqcANb6/RNkJXpNMtQv1JMZmJrKzLn7uu9eECX07zrp+mcBPmEUMSoHEmgYJYxKP8
	 kZ/sj/Svx+01Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Sam Shih <sam.shih@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 188/715] arm64: dts: mediatek: mt7986: add "#reset-cells" to infracfg
Date: Sun, 24 Mar 2024 18:26:07 -0400
Message-ID: <20240324223455.1342824-189-sashal@kernel.org>
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

[ Upstream commit d993daff5962b2dd08f32a83bb1c0e5fa75732ea ]

MT7986's Infrastructure System Configuration Controller includes reset
controller. It can reset blocks as specified in the
include/dt-bindings/reset/mt7986-resets.h . Add #reset-cells so it can
be referenced properly.

This fixes:
arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtb: infracfg@10001000: '#reset-cells' is a required property
        from schema $id: http://devicetree.org/schemas/arm/mediatek/mediatek,infracfg.yaml#

Fixes: 1f9986b258c2 ("arm64: dts: mediatek: add clock support for mt7986a")
Cc: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Link: https://lore.kernel.org/r/20240101182040.28538-2-zajec5@gmail.com
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index 7b6591509c54d..d974739eae1c9 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -153,6 +153,7 @@ infracfg: infracfg@10001000 {
 			compatible = "mediatek,mt7986-infracfg", "syscon";
 			reg = <0 0x10001000 0 0x1000>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 		};
 
 		wed_pcie: wed-pcie@10003000 {
-- 
2.43.0


