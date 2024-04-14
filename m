Return-Path: <linux-kernel+bounces-144272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 333348A43EF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC71F1F210DD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173C413698E;
	Sun, 14 Apr 2024 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h86mwFjK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA0F135406;
	Sun, 14 Apr 2024 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713112605; cv=none; b=MPwv5jyxhQ6fi1ACmERkXB6UfYgtLybhNeCx2yYg0hB0ToMsne0DtJ7fHninsb5EzZyMviwGtnBaAMz0VzKrQTGVNpQMJ7XOMDepxKQzTEwuQJTRUF5fQI7nLvULxo9hppWqkO5ccwk3kvKQbeaA1nJGY1yDGxYqJ4HE5NIxhQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713112605; c=relaxed/simple;
	bh=88cr00ugVAy6jT3uweB13pEg01tQBkHxONaOOrvSJr4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UmOAcpFT/pNTyPxVybwpkFzQ1L/bNX1R5ExiTiuW3LB/FX++EL8b9kWpCmMdSEg2OoonDxyUhWnekJ/sr7rKjPTMG6h4hnidXYyBQTIx5RAvDWvW5o26BccFO7GRTxDrLjTtvnz5zkW2HvharuAeiU6K63NdKRCi0UCK9NbQnEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h86mwFjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06E5C32783;
	Sun, 14 Apr 2024 16:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713112604;
	bh=88cr00ugVAy6jT3uweB13pEg01tQBkHxONaOOrvSJr4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h86mwFjKHmZcRJ9ZSaE72bZDjmGP52SPWemcrGuyOPu4blsNFLlbsilJdmbv7IS+L
	 AqJj+Et8N6sDUgvX751ehcr8xD594u7A2K5d5FAT36+g1OvzzquTPpY0B89H4D3mgt
	 kBOmhsKJDlAAi6TglfS8tnR5rFtTPzVe1cexRlT7pZI1m1nSpvznRwqbXIBtxRRvjr
	 Ei6K/P891ntD9fS03jCK1x2xBnDpt0yfRjfxWy0RvuP4o9uIzazEcsMpzi8NOzF3eF
	 fgVaYp0Ge1EgDGabx+yNXuhaTVsaD+z1T65hbOGBOOKZ+BMxBLCtXcwnMR51EGUBj+
	 V/UE8uJGVbIsw==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 18:36:02 +0200
Subject: [PATCH 04/18] backlight: hx8357: Constify lcd_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-video-backlight-lcd-ops-v1-4-9b37fcbf546a@kernel.org>
References: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
In-Reply-To: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 =?utf-8?q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Alexander Shiyan <shc_work@mail.ru>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-omap@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=742; i=krzk@kernel.org;
 h=from:subject:message-id; bh=88cr00ugVAy6jT3uweB13pEg01tQBkHxONaOOrvSJr4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmHAX2M38hZGStBZtwBXfjnULAK0J4hB8k+kZwy
 ZsNXzIQjE+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhwF9gAKCRDBN2bmhouD
 1236EACUAKGm9Y/BnFg+tXVFYTF6OHukRnl8sbwA5jbZqziu8R90NGD9vH5/fsmWeXKvHarT2bB
 RNv0WZNTrP/TjXEEhQ0/nU/Pc0GF0GMn1UiYaPyPUmGFfJ4+WAZY4bNHtYuLm172FWkTAiTpvDZ
 zS76L2OEwVRT7pYaxzu/0d0zm7hCznV2WONMZW0UDJbnaoAxg7/y8qZdrhVbRU5Un+a4hq3aqeu
 U78hYryAXf3odENjH77BfUcFixxb0Fyp/UW4cvUtX2HmOqpNI18jhe6FpPFEB8B3X4/tI8oDQtE
 bw4HWSqgCXQD6xU64UOkwa+lUSG3ToBhMqiPQBMP7TGQnSLBfEmijhhhFAsVGpxK3rlOSMS0PGY
 mI2/y7ss0GH0W230fRUkqrHH3OLZRRS/6bi/c0tw7TnE9M65q3j7ttx0jiniRgXfcsVe1X0AEIZ
 ts4i7aimrPmUbLLY8kqMV6d4E/rmNpuKWyKuP8Sp32tU2Dg1MRr+23Bvngr5e4jKYeitwwudFvq
 2SNxdbwfSvjbGIzJWvPugy0VFRHuGEDP64/odcsJSvFPGDzD9BfI8ybMB5xaa3SoxEhb0pmXRIR
 C3pIG2xbvOZwnQePbIsOEfI6X3NZqYFnFfcv1LYO90FOETOwmlyw2XpUTN0iXt6rht/J4z1UQug
 k1627LcFZ0WbtQQ==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct lcd_ops' is not modified by core backlight code, so it can be
made const for increased code safety.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/video/backlight/hx8357.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight/hx8357.c
index 339d9128fbde..cdd7b7686723 100644
--- a/drivers/video/backlight/hx8357.c
+++ b/drivers/video/backlight/hx8357.c
@@ -559,7 +559,7 @@ static int hx8357_get_power(struct lcd_device *lcdev)
 	return lcd->state;
 }
 
-static struct lcd_ops hx8357_ops = {
+static const struct lcd_ops hx8357_ops = {
 	.set_power	= hx8357_set_power,
 	.get_power	= hx8357_get_power,
 };

-- 
2.34.1


