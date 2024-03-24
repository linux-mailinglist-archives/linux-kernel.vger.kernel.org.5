Return-Path: <linux-kernel+bounces-114804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02946889155
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B086D2947CB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE03C25F260;
	Mon, 25 Mar 2024 00:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBd2q6qU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D7B175CBB;
	Sun, 24 Mar 2024 23:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323409; cv=none; b=ioiLy4+dLe5wIcCDdMVA6NwIylglFvu+SLZf2SeJH3jzd9lzNJN/rZjby6n6n+iV/CtsIzRzU0DRt8thZLX1rgx7tIuVFF1Wg7qlZB2e8FwsU+tSe1vitjpfxQY4g8SpklrPKP3T6u7TYzzcwA85WGUo9BUvLwBY0tCj7MlRMP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323409; c=relaxed/simple;
	bh=UWQXbI09pYoDEgs0/epk4bOcaXJ/RUDBrCgKW+m3SXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGD9pXkhWJCO3J/7nvytkFV1qZWStPd4mENXxzNTA2AMRQ0qHwnLdCxYA+BhNgfYvrZh3Tnf+cagT8PRiCRgmZq+ZZAYuLRUNDmMxSuA5ja68On7jfUoa7TxQh18bRoKafidHxR9mJ5FNs/51VA7LyVW/+7HgrQpDsFzGG6KpAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBd2q6qU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838B7C433F1;
	Sun, 24 Mar 2024 23:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323408;
	bh=UWQXbI09pYoDEgs0/epk4bOcaXJ/RUDBrCgKW+m3SXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jBd2q6qU0srroFVuMIv3SW9ePWUQjeGACDmQwHzOWBPgzyafX+NGqcLQ7gkuEXc4G
	 yFufIQbk7HBLjhCH7n1vY1xYuheiBoV6b00QV6Ix5NhAxS93ssY9g5ov0ffPFuJKgp
	 bVuadG5Gd/9GoSvQ0gF48lN+4OkfIjnw/qFNeuCaDwKB5/W2F+77U7X1gbg3RiLG5f
	 qVJeS7pUYyGM/86/pMXuj6FFmgJ1wMQv/ckWoVDFOvyJEtI+ArWfRg2R+FSafY+DfO
	 6QR2I3kvGi+IGeGGrrwYCFA4fGlTXg+BzOTuXyrp0pJa3chkOM/wQAGiGVpRsExEDc
	 1ApfQqJb8sQfw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 109/317] ARM: dts: arm: realview: Fix development chip ROM compatible value
Date: Sun, 24 Mar 2024 19:31:29 -0400
Message-ID: <20240324233458.1352854-110-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 3baa4c5143d65ebab2de0d99a395e5f4f1f46608 ]

When the development chip ROM was added, the "direct-mapped" compatible
value was already obsolete.  In addition, the device node lacked the
accompanying "probe-type" property, causing the old physmap_of_core
driver to fall back to trying all available probe types.
Unfortunately this fallback was lost when the DT and pdata cases were
merged.

Fix this by using the modern "mtd-rom" compatible value instead.

Fixes: 5c3f5edbe0a1dff3 ("ARM: realview: add flash devices to the PB1176 DTS")
Fixes: 642b1e8dbed7bbbf ("mtd: maps: Merge physmap_of.c into physmap-core.c")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/arm-realview-pb1176.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
index 366687fb1ee39..e794a4bb8f1f2 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -435,7 +435,7 @@ pb1176_serial3: serial@1010f000 {
 
 		/* Direct-mapped development chip ROM */
 		pb1176_rom@10200000 {
-			compatible = "direct-mapped";
+			compatible = "mtd-rom";
 			reg = <0x10200000 0x4000>;
 			bank-width = <1>;
 		};
-- 
2.43.0


