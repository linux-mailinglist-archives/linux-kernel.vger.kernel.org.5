Return-Path: <linux-kernel+bounces-114191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CEB8888F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A61288045
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCE324C340;
	Sun, 24 Mar 2024 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDuHfAOr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC611E8E58;
	Sun, 24 Mar 2024 23:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321525; cv=none; b=JkGqaGvLxK/L42VGV0R/vnbJ8MU2HZzsMXsWhTtU4VRUFCsW38crsGZAAUhB8L6j/WWkVzN4jG9yZLuq29cx/H47oiiUfl0zpOkyT4Vq4HBkjD/QiHRH6v0TbIce4zf0Ir0vSOur1wQh8BP5Ad0MCdCdOoOoivh/IgC8hQiOPGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321525; c=relaxed/simple;
	bh=YKVcdpL5+OrlaJ4q8k+EUbtblJGBjMh/yaBxJ7pH7dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S55Du/kX6YLgMvKS3dSwz6+XIJdxF6V/aVezEaW1bkGtbKI+3JkyktJqpD6CbvkMH6xBFURK16totd7ljnP/o4komvSPOJsQzvJ/lZe/LAwIcfxxiMgepmMUc8bnNeylREE5D1TGSa+yqdXZkvKqyEfZEQVNDFSU9IY11AyixPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDuHfAOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38485C433F1;
	Sun, 24 Mar 2024 23:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321523;
	bh=YKVcdpL5+OrlaJ4q8k+EUbtblJGBjMh/yaBxJ7pH7dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eDuHfAOrPS30Gd+qlxqu2n85Hlki9OsZokjbzWUwA482Ysc0mIJcu0qMCn/bVa53f
	 7HVszLob8bNizWcteq+kCnTOLxGQo7pBetJcaR3sJ9LTJd1ZygfH+x8fAcyikpd+TG
	 GNiFPhUfJ2lE0aqJb9t3ijFpKP4hfySDxnCkMMANylzznMZR42Cs6abDlz311W9YjQ
	 S45/cBTGzW168rXceo48xdXbQ4P/qzpT1ITthrMcbqsV22pfgckPgwoMF2WtaRdxah
	 SgTdffB+Rf+jxxtop39PabiYi81T2/aqtKKNJNZsFsGHATTHTH/8sWkoAKx/CRO+cs
	 qpgL3v3Aa/fFA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 250/638] ARM: dts: arm: realview: Fix development chip ROM compatible value
Date: Sun, 24 Mar 2024 18:54:47 -0400
Message-ID: <20240324230116.1348576-251-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
 arch/arm/boot/dts/arm/arm-realview-pb1176.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/arm/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm/arm-realview-pb1176.dts
index efed325af88d2..d99bac02232b3 100644
--- a/arch/arm/boot/dts/arm/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm/arm-realview-pb1176.dts
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


