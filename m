Return-Path: <linux-kernel+bounces-115898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 122CA8896A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435641C3047F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBD938662E;
	Mon, 25 Mar 2024 03:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZVHWpQC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89F31474B2;
	Sun, 24 Mar 2024 23:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322091; cv=none; b=AMmAU7qbOvXPAWTDwGNUmWSyah9hz5HuRXmj5+Vfu+ldbm3cncSTCCJbBnYzK3q5FqVuDQyzzKX9OO7vJ4z9fomG4SwOLT3PPzSLvHUekFzKoiND7ctRszHWTg37Fx1gxMJojwIDSPdFvpm7wyo+e6TVoaLr5F76T8EcFj74Wqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322091; c=relaxed/simple;
	bh=27pxfdOvjIe6sVYvonAoU65JJFg1qimG5TlCJRsNZYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=suu/LjIvsozjbKTDagXqFcJQp/xtDQjgTwHGcZpfUR81AqJi+CiXHczZv/GBWOX6yOkEi0P+dHamcQ8yAlmfHQqDZkepJTB1OCleB08+oksadbhQjcmDlBGxqpG86NTI6iu/eMW/2YFFjPw2FVL6aZ1OU8ARI+icN6veYhi0Lwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZVHWpQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C6BC43399;
	Sun, 24 Mar 2024 23:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322091;
	bh=27pxfdOvjIe6sVYvonAoU65JJFg1qimG5TlCJRsNZYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aZVHWpQCzyJNqeGSWEdEE7H88JhSasklHAx8Onf7j72PDnjihJ4lqVpQL2b8TK6YC
	 4XorSTGz4ro8nLtKNCwYSuDJWoJyz3OxnC7Thk36NynaQ5mUGdGgvjZ3JEOXbvRzya
	 Pf7Hm81S/qXCzUjpHRvhZKSXbq8MuMHNJgNgcMNEMnMaFuRfy/4C9yKj1npgMjTMVp
	 onPMUroCxC3RMBxa5r9PxmFJJoj/45zLgbeWJQ84iXOAG5a6qMQjna6bI7j5QzGUl7
	 oOr7KQbuDJSe4pcDdr+RYyu1AMRF7h63qDxNNoCa0P70nRS1vouSdR6GtFry+UYVWk
	 Ztx3rJ5ZoKkTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 165/451] ARM: dts: arm: realview: Fix development chip ROM compatible value
Date: Sun, 24 Mar 2024 19:07:21 -0400
Message-ID: <20240324231207.1351418-166-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index efed325af88d2..d99bac02232b3 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -451,7 +451,7 @@ pb1176_serial3: serial@1010f000 {
 
 		/* Direct-mapped development chip ROM */
 		pb1176_rom@10200000 {
-			compatible = "direct-mapped";
+			compatible = "mtd-rom";
 			reg = <0x10200000 0x4000>;
 			bank-width = <1>;
 		};
-- 
2.43.0


