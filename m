Return-Path: <linux-kernel+bounces-115391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00289889D35
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9F7DB32D25
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1DC1FD5D3;
	Mon, 25 Mar 2024 02:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HK2/S+NH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DAF1DA15D;
	Sun, 24 Mar 2024 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320675; cv=none; b=ns/Lc1enj/i/Oc02cXI5gvFeahSmAPShojrib4iUxFu3ZaNYZ8Ng5lFGuL7c2X2hMvczZSkymWhrkwB7THXECs0auR47STOq1NAfFRSqJkU+o32QtS58EjKy4IkPVy4WqVuwOhUhIno4E8Ge8I5BPLmL1/K2LOAUS1wvVU28vrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320675; c=relaxed/simple;
	bh=A5zfCys77iQwcQNBaFkrV0ST82y1Y9bXQsEUU83makM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1D/akBVrkV2pjy3SuHVElROg/ZbeilvJYuiawBP25VmoXsxMDSi2dS9fbSRZoA68nlWMN0wWp3dhiduonj7TKZnxgp+mJCd2OMb2MkxW7+6LS/f3tzFwAjU1kooOGSmhsO+Xakdw3vBOud0ffks2ThKtXCoYabMOQ0SevfJ5jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HK2/S+NH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2130FC43399;
	Sun, 24 Mar 2024 22:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320674;
	bh=A5zfCys77iQwcQNBaFkrV0ST82y1Y9bXQsEUU83makM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HK2/S+NHrCOt3yQPAgkLu8RcT2stot7t/rtEcXGj0qYkHuk2VPYrZxiaDAmHJY1Tv
	 R+LYHGES9O4BbuOMbDfGI22t7J/UqgYiTadRACNVxCYuV4Wpgvddn4JTgrM3LwjNwz
	 s4BBJ00tN3GebiD/6g7pSEfOVyR4qtoAEXNVX8p9mwXgm0YzIlAFCeNHoIOWcnB6PW
	 b73AKIF7VdIBP6nlM/UxPlioVTIWpgYGFGMhPoiVRgn5xU1XmkYqtAWT97IGlVMb3u
	 WOcGW8caG0UqPgOCiwyZBRnPXZfpaisHoASvm9vYswNMfL1I9m1tVuL7FJtixB+waK
	 aTc13iUgUP7dQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Daniel Golle <daniel@makrotopia.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 237/713] arm64: dts: mediatek: mt7986: fix reference to PWM in fan node
Date: Sun, 24 Mar 2024 18:39:23 -0400
Message-ID: <20240324224720.1345309-238-sashal@kernel.org>
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

[ Upstream commit 7865abbbdf1e1ee57a0bb8ec83079f8840c16854 ]

This fixes typo and resolves following validation error:
arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtb: pwm-fan: pwms: [[54, 0, 10000], [0]] is too long
        from schema $id: http://devicetree.org/schemas/hwmon/pwm-fan.yaml#

Fixes: c26f779a2295 ("arm64: dts: mt7986: add pwm-fan and cooling-maps to BPI-R3 dts")
Cc: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20231116130816.4932-1-zajec5@gmail.com
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
index b876e501216be..e1ec2cccf4444 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
@@ -43,7 +43,7 @@ fan: pwm-fan {
 		#cooling-cells = <2>;
 		/* cooling level (0, 1, 2) - pwm inverted */
 		cooling-levels = <255 96 0>;
-		pwms = <&pwm 0 10000 0>;
+		pwms = <&pwm 0 10000>;
 		status = "okay";
 	};
 
-- 
2.43.0


