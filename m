Return-Path: <linux-kernel+bounces-115874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F8D889953
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8473B28032
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AC7382CA9;
	Mon, 25 Mar 2024 03:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CA20uJpV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94656146012;
	Sun, 24 Mar 2024 23:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322070; cv=none; b=Edjh2b9U+GwouW7gUKdWVrNO3y+EHAovLRD/+SftMc1bdd4WXTnyeLJIgE36LyX9rujV1UGJM5zt7EBeGlD75xMPRJDOd7BNtaSEG79lwlQ4HDWuVGv0p6TrEBqLnLhrX6T7XXjWL+/eKEYGBNXLH5KB7v9FPG5wRZEStnJ032g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322070; c=relaxed/simple;
	bh=ngHgQOKVmVf0SQhFU+gN0jqHkAr9BsZEUrD2Y21ZIjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T781g2s1RQsQTG5KYJA7Z+ZYi1s2dUmFiAb+Jm30vVHKU/H3WBv57ecm85LjvbBtSI1HZHfZ62NLc8Z3o5RREngVh/vuLERFWQGP+B+6EL/2JQTn4FVZaGXwx3FOsCxbfjbtfHVoaqfTiv1q7+iy/7if7WkZeTqeSupfcie7iR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CA20uJpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2441C43394;
	Sun, 24 Mar 2024 23:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322070;
	bh=ngHgQOKVmVf0SQhFU+gN0jqHkAr9BsZEUrD2Y21ZIjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CA20uJpVkB5exbLqDKZfpWwfZYKuRzo76fHBNGU/0wGq+tjfj7LIpohBWeLpwN3Nx
	 tCXID3oI/rGukhaVQukEZeC7KP7E7aVwXZq9Cf0T6uMsrct3Wd3sbBg/lj0I+jIAS4
	 WPNHWBSqeS/CE8Hre3ewQ6mAhcg4UIsUaJOVKnFt4F2WvMXXhpJ9eg04Bg3mAjVo7t
	 xdv45EsDHNjlHN/XKUm9W7/canhW3zOejsrTDzZRkTaVcvSuqi3RkAc33NDirfMYNN
	 cBJl6+M+c/tlIug1snCQK4/A38Jyg7JFvN3hY6s8rEgP01M2XEV0dlYxsRsrfNAicr
	 IYwGaWkMWR5Kg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Sam Shih <sam.shih@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 143/451] arm64: dts: mediatek: mt7986: add "#reset-cells" to infracfg
Date: Sun, 24 Mar 2024 19:06:59 -0400
Message-ID: <20240324231207.1351418-144-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index fc338bd497f51..108931e796465 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -110,6 +110,7 @@ infracfg: infracfg@10001000 {
 			compatible = "mediatek,mt7986-infracfg", "syscon";
 			reg = <0 0x10001000 0 0x1000>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 		};
 
 		wed_pcie: wed-pcie@10003000 {
-- 
2.43.0


