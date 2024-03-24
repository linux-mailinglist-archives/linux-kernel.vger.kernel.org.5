Return-Path: <linux-kernel+bounces-115636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50687889458
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E618F1F2FA90
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D693834DF03;
	Mon, 25 Mar 2024 02:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPXpfyx6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20B22057D1;
	Sun, 24 Mar 2024 23:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321485; cv=none; b=YQUsPO70I9m9bPwlHzotO5iRJ6M+geN9p7++iJnt7aQMknsqalfT77ApbDf2zdBveL+u1Re41Fg+gLtxFgVsvvF393sIm55SJcZZegwK1Hxi5cElNwZ2CFC11LLaucHo+2HbeOeJFEe44B8mTrczJctAEmiYolZVi5mXvGQf5IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321485; c=relaxed/simple;
	bh=/qCNevVVEggzTf1GpDuuZorY4cKNTJEWoKSpqvi5tJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOMQBvdwtnTuC5vOF9QAWdiBdNfpUZeYH0CFMsjfCvWcu5w+bOCp3etLbimOzXkZIxSJRIDfExBOYBP8XbWB4SGnxzzljaDCtU7xvmDhYQSCoJpqi6V3ziZkQgLxpvFQqZQdNf/54VOoaIsuW7G9yavYShQTqUyKu0Gz6Yq2anU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPXpfyx6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8235DC43394;
	Sun, 24 Mar 2024 23:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321485;
	bh=/qCNevVVEggzTf1GpDuuZorY4cKNTJEWoKSpqvi5tJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sPXpfyx64OGsq9Xqj5JYGsnbiVqg+YdRhQd2jObH7qncrk1HgZeZf83qbfHL04z1O
	 Mk8togRqV+wNR1nwwQ/jhr/6m9+vcOXP8KEomvQAArt23gU+KyOcF5z4d8QtjCJuHI
	 AGHfLN9bDe0Loxs25he1nDzbALu727gJJy5LCy2o1dkOvW7o6k1cbHXtxT/HeYJjat
	 K8RWNkwrZ/hKUvJzQygjn7OVIhAjU+5uRUtJKdio9WNBDu0kIjPA4qRNJaEO6Dfu4V
	 y+MtyyPbFbKRAxgZc1G+oxs71ybxlognTfcTZ7onEhFoNAz6bySp9+fjHapw3+CAfr
	 jAEpPAbulw7RQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Sam Shih <sam.shih@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 210/638] arm64: dts: mediatek: mt7986: add "#reset-cells" to infracfg
Date: Sun, 24 Mar 2024 18:54:07 -0400
Message-ID: <20240324230116.1348576-211-sashal@kernel.org>
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


