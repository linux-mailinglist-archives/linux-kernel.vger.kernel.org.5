Return-Path: <linux-kernel+bounces-114166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB4E8888D6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B87289507
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59D6247F91;
	Sun, 24 Mar 2024 23:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msOKPKAU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A803204FCD;
	Sun, 24 Mar 2024 23:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321480; cv=none; b=ufaO4MniI2ANMJ/tQuLx0obKiGI+iTKLoT9kWOrcFDGtDaXySVQ0PdMVf1gh3melOogE7kqgu/OtW8s6RxURJsJ21qva/bGLwtiK2rBBPfMokq/NpQZC6s5mfJw2NdQGAAc2X+YWOcuyCKRWiIzt/OGvHjhH+gPWYsh0u9mZ5/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321480; c=relaxed/simple;
	bh=A5zfCys77iQwcQNBaFkrV0ST82y1Y9bXQsEUU83makM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0Z1Jz+UOWwfbu+G5X4U4kIZcjmeLHzmCOsdclIB1PCQE1wpLDIehFkIaXuVG6Lr+2o4c6CWLXjEJelyXooKQhdixEL4WTwR899ejcHDYqV23wqthVv8WkKJGIqxNioE8q+qXs2ZqahEnj1Cmlj3fI0RMW9iwN6nkVe0Dz50rYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msOKPKAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C50FC433C7;
	Sun, 24 Mar 2024 23:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321480;
	bh=A5zfCys77iQwcQNBaFkrV0ST82y1Y9bXQsEUU83makM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=msOKPKAUI4yaetAhN9Lf60Ri7BVQYnCD8f1YTc7R4ASeChyTntb1Ao3ai+iUYrXYz
	 lzU+FSq2r3T8uFJyw98h9r/Lgbf1DiNviSMgitY20bASGxRxhPUJZuZoKAeLNrNDep
	 /cYk/u1cmSMa1rntkMSqPOyS98duNMHIjfi7ZrN2lEnVbIu2Bm4kyrVbGE61LqyshY
	 d2QxSXRkMPdL8BXMM+IxV91lrOuKCNMo/AAmURDMDlQihey+5MvL6m08fy7YAJkUGw
	 cHDM72R3bI9+kS6CF4TVRSxNrVJXSqM+G9nbCpFFuo1UlJxugG5yzhILwBUAbO+WKe
	 Z/A49OU5v/kEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Daniel Golle <daniel@makrotopia.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 205/638] arm64: dts: mediatek: mt7986: fix reference to PWM in fan node
Date: Sun, 24 Mar 2024 18:54:02 -0400
Message-ID: <20240324230116.1348576-206-sashal@kernel.org>
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


