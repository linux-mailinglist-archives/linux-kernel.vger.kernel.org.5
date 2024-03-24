Return-Path: <linux-kernel+bounces-115428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02FF8896CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B73829CEB0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC9620CDFE;
	Mon, 25 Mar 2024 02:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byMzNYNn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2231D6855;
	Sun, 24 Mar 2024 22:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320719; cv=none; b=glYPAjgx+5iDqzz40xca/imiLcg4cmVUaASLn/V10G722Sjg2m1xEdTz7VC3SzFTqzU+8I+EnUgvPFpOAui9D9Cz8S08PyHERkydPgJJxBFqg4cI0X5jIP61bJsDwrvnPl4avfeffXKZu6M2HmeiEmHogMuSGegzcRhxKThvSUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320719; c=relaxed/simple;
	bh=YKVcdpL5+OrlaJ4q8k+EUbtblJGBjMh/yaBxJ7pH7dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khyi3vsr73j27Qy5y6F5rYCXJnTWt1RMzwJRZJ1Ke+GoPzv1tgl8NHA68tgzyrR9+76pammFBApj6CIYomYskzgErNPD92wH3nTOefrtoZCShewtLMfpKMqEo/A95Kt1xwh7UC0MoEU8ppKIYEKVLIoaA1g6RfKa3mQtIiTpPLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byMzNYNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09277C433A6;
	Sun, 24 Mar 2024 22:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320718;
	bh=YKVcdpL5+OrlaJ4q8k+EUbtblJGBjMh/yaBxJ7pH7dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=byMzNYNny8a9422ENTyhBNNQ6TopQIBMcqrNzoakznLMzsBavyQpQWBF3hHueQ+N/
	 jd7EchcS6Mh1kIflLNTIkDmRHbTNVSnXn0vnxEzcT4R7uMeGX8LOw5gGBWIcjiMV5b
	 NTm8I69NDO8LOoy+k22zO6Ex66b0SvcjiguLUxSHjERDFt6go2VEH+4DA0EMrS5YTt
	 q8+IIN0s0m0wK2TypIHeH2u2EYjVMfOQEeNZMFyrjQW6qOd2e4biP2112WNUrCSv9j
	 +mTgHwJDzmybuxiUEHiZZgVadV4AbmvxmHE7zXByvTiqC6p347phCgPg1qnFvJTqyB
	 jebBjLHvKOK1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 281/713] ARM: dts: arm: realview: Fix development chip ROM compatible value
Date: Sun, 24 Mar 2024 18:40:07 -0400
Message-ID: <20240324224720.1345309-282-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


