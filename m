Return-Path: <linux-kernel+bounces-113703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC9B888617
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA2D29089C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2BD12882F;
	Sun, 24 Mar 2024 22:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGfmGUl4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFD21D5F92;
	Sun, 24 Mar 2024 22:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320681; cv=none; b=U8iwsjES+fM4EH2K3sspP6mNDJnvdmx/x/AWTK9E4qIA7CbR057OeYF4hr+XkaJl+rlK9nU4WSGbiQkrUMnzsnzCrftz9zdJdWKlQkSIkhClUbDoKyTo12qOjg7fbaYTH4m16fE4DFF8Mw+UVx0xppd1T564mpWLrkCRyWXbUtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320681; c=relaxed/simple;
	bh=/qCNevVVEggzTf1GpDuuZorY4cKNTJEWoKSpqvi5tJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RqUpoyjoLqt60F2ejt8BoKcLmktQMiwHA7oT//dz4VdEZNJ7/hfxt1au+yyWubDOQpNc3BQYAe5JA2of4s4tWb1PIIR7h6HLEj5cyQz3ZxHbJYd0OG5WlJ++jdBvkIsqq53dty6Nly5y+HGoW3/IOZhP4p/E6d1AHeKJX8uu+Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGfmGUl4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506C5C433C7;
	Sun, 24 Mar 2024 22:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320680;
	bh=/qCNevVVEggzTf1GpDuuZorY4cKNTJEWoKSpqvi5tJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HGfmGUl4UVzCnbw4jo/XAeGfJddGx8+VFVH8D0Tziak2HP6u3B2CHifx/h60u9wJb
	 Wqd1uCFTCTary1D41sy4qCWcvEU8LvjYDLXPOyfDuNkQcdNbfywMcmK9mmQqwSGd8U
	 1YHd0ltIrai2uooR7eC7VjwNWRvgGrgbMlBURhv/hudJ3LQGgWlTJzsnCGw/4mbhG+
	 +5De5JFxYS3JcQdkUX3pjUnwMj8iNKyeNiYPle0Q98GZiz8i/idM/WxRHGYN5EIIKB
	 Ze7/rczj3ZPOZUDJl0sZdRg4MuEAvEjWiOgIQ7WbBe91ajsyvBQ4DmdoZ7MGg7unvL
	 kuKOlk8eUWSHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Sam Shih <sam.shih@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 242/713] arm64: dts: mediatek: mt7986: add "#reset-cells" to infracfg
Date: Sun, 24 Mar 2024 18:39:28 -0400
Message-ID: <20240324224720.1345309-243-sashal@kernel.org>
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


