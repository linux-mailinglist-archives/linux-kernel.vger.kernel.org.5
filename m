Return-Path: <linux-kernel+bounces-145110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6DE8A4FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31818B22A59
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2F37F7FA;
	Mon, 15 Apr 2024 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUUD9smI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110BA70CDE;
	Mon, 15 Apr 2024 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185375; cv=none; b=lRrWTNoAHqB5PxhndASMM2F7RGM5B6ktvnnYe2vkWv/Z/vdTYV78mgo/oL1eEvlwAepZ2LCnRFA+8dk9AFUvHmPBlfWJn8Gc7Ez8SR84Bw08QTOmksTPt7mG9Vs8EYSI1qgd7rhilCjDhGeePxhralU8QNzy4O0cW0wLjcyMBSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185375; c=relaxed/simple;
	bh=Hkbqg3u5DORmc+Id5+eWoE5zJPzeijN0PqbXK/gojgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LohjloNM1yoT3L8mo1cZxHoFvsxGtZJcXzeyMc1rcF6ZPGYFxd4DpQ0JTNrqurzak++5R5tWNYvlhUCqiS9E2c0XDKdf2BjolWj3UmOEUBlH49DAvsEhTAAR3r9A+WtCGQ03vtu5EEa51uwp7zxRN2UjmFotcS6WH72Ieq36Ur4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUUD9smI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15ABC4AF09;
	Mon, 15 Apr 2024 12:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185374;
	bh=Hkbqg3u5DORmc+Id5+eWoE5zJPzeijN0PqbXK/gojgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DUUD9smItFfJBPVDR6qOLuglDxo/hWg7XEgGfDf2nlZxDI6UBYnuwJHVgme/W0qhV
	 3MOBDW4A7n8fuPja5hU3KEYzmgjoWlq4sLXrHwzo0egg/hcMbCNVU4mA5BU5r/wxCm
	 vT/Vob6jdHBPzAObbbNW6LAhtZWKu0zGsjU0NDDf9S1Rgf7u994Mp3dUoXgkVjN/v4
	 FDBBpoCsE1GSDYD9jgS7yTkl4+rcylMXaLwH29317ShOi7nNBDjlc3lVmGNWC4Cynk
	 YQRh6mXJYBVDyMFeI/con4JogQJ6C7ctdRjjrDk/T0VTd5OHFPgAFt/zd69a1GlZdW
	 f7/Qs5+LV+4RA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Yi <zhangyi@everest-semi.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	zhuning0077@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 11/15] ASoC: codecs: ES8326: modify clock table
Date: Mon, 15 Apr 2024 06:02:51 -0400
Message-ID: <20240415100311.3126785-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415100311.3126785-1-sashal@kernel.org>
References: <20240415100311.3126785-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.6
Content-Transfer-Encoding: 8bit

From: Zhang Yi <zhangyi@everest-semi.com>

[ Upstream commit 4581468d071b64a2e3c2ae333fff82dc0391a306 ]

We got a digital microphone feature issue. And we fixed it by modifying
the clock table. Also, we changed the marco ES8326_CLK_ON declaration

Signed-off-by: Zhang Yi <zhangyi@everest-semi.com>
Link: https://msgid.link/r/20240402062043.20608-3-zhangyi@everest-semi.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/es8326.c | 22 +++++++++++-----------
 sound/soc/codecs/es8326.h |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/es8326.c b/sound/soc/codecs/es8326.c
index fd1af97412bdd..a3dbeebaeb0c9 100644
--- a/sound/soc/codecs/es8326.c
+++ b/sound/soc/codecs/es8326.c
@@ -326,9 +326,9 @@ static const struct _coeff_div coeff_div_v3[] = {
 	{125, 48000, 6000000, 0x04, 0x04, 0x1F, 0x2D, 0x8A, 0x0A, 0x27, 0x27},
 
 	{128, 8000, 1024000, 0x60, 0x00, 0x05, 0x75, 0x8A, 0x1B, 0x1F, 0x7F},
-	{128, 16000, 2048000, 0x20, 0x00, 0x31, 0x35, 0x8A, 0x1B, 0x1F, 0x3F},
-	{128, 44100, 5644800, 0xE0, 0x00, 0x01, 0x2D, 0xCA, 0x0A, 0x1F, 0x1F},
-	{128, 48000, 6144000, 0xE0, 0x00, 0x01, 0x2D, 0xCA, 0x0A, 0x1F, 0x1F},
+	{128, 16000, 2048000, 0x20, 0x00, 0x31, 0x35, 0x08, 0x19, 0x1F, 0x3F},
+	{128, 44100, 5644800, 0xE0, 0x00, 0x01, 0x2D, 0x48, 0x08, 0x1F, 0x1F},
+	{128, 48000, 6144000, 0xE0, 0x00, 0x01, 0x2D, 0x48, 0x08, 0x1F, 0x1F},
 	{144, 8000, 1152000, 0x20, 0x00, 0x03, 0x35, 0x8A, 0x1B, 0x23, 0x47},
 	{144, 16000, 2304000, 0x20, 0x00, 0x11, 0x35, 0x8A, 0x1B, 0x23, 0x47},
 	{192, 8000, 1536000, 0x60, 0x02, 0x0D, 0x75, 0x8A, 0x1B, 0x1F, 0x7F},
@@ -337,10 +337,10 @@ static const struct _coeff_div coeff_div_v3[] = {
 
 	{200, 48000, 9600000, 0x04, 0x04, 0x0F, 0x2D, 0xCA, 0x0A, 0x1F, 0x1F},
 	{250, 48000, 12000000, 0x04, 0x04, 0x0F, 0x2D, 0xCA, 0x0A, 0x27, 0x27},
-	{256, 8000, 2048000, 0x60, 0x00, 0x31, 0x35, 0x8A, 0x1B, 0x1F, 0x7F},
-	{256, 16000, 4096000, 0x20, 0x00, 0x01, 0x35, 0x8A, 0x1B, 0x1F, 0x3F},
-	{256, 44100, 11289600, 0xE0, 0x00, 0x30, 0x2D, 0xCA, 0x0A, 0x1F, 0x1F},
-	{256, 48000, 12288000, 0xE0, 0x00, 0x30, 0x2D, 0xCA, 0x0A, 0x1F, 0x1F},
+	{256, 8000, 2048000, 0x60, 0x00, 0x31, 0x35, 0x08, 0x19, 0x1F, 0x7F},
+	{256, 16000, 4096000, 0x20, 0x00, 0x01, 0x35, 0x08, 0x19, 0x1F, 0x3F},
+	{256, 44100, 11289600, 0xE0, 0x01, 0x01, 0x2D, 0x48, 0x08, 0x1F, 0x1F},
+	{256, 48000, 12288000, 0xE0, 0x01, 0x01, 0x2D, 0x48, 0x08, 0x1F, 0x1F},
 	{288, 8000, 2304000, 0x20, 0x00, 0x01, 0x35, 0x8A, 0x1B, 0x23, 0x47},
 	{384, 8000, 3072000, 0x60, 0x02, 0x05, 0x75, 0x8A, 0x1B, 0x1F, 0x7F},
 	{384, 16000, 6144000, 0x20, 0x02, 0x03, 0x35, 0x8A, 0x1B, 0x1F, 0x3F},
@@ -349,10 +349,10 @@ static const struct _coeff_div coeff_div_v3[] = {
 
 	{400, 48000, 19200000, 0xE4, 0x04, 0x35, 0x6d, 0xCA, 0x0A, 0x1F, 0x1F},
 	{500, 48000, 24000000, 0xF8, 0x04, 0x3F, 0x6D, 0xCA, 0x0A, 0x1F, 0x1F},
-	{512, 8000, 4096000, 0x60, 0x00, 0x01, 0x35, 0x8A, 0x1B, 0x1F, 0x7F},
-	{512, 16000, 8192000, 0x20, 0x00, 0x30, 0x35, 0x8A, 0x1B, 0x1F, 0x3F},
-	{512, 44100, 22579200, 0xE0, 0x00, 0x00, 0x2D, 0xCA, 0x0A, 0x1F, 0x1F},
-	{512, 48000, 24576000, 0xE0, 0x00, 0x00, 0x2D, 0xCA, 0x0A, 0x1F, 0x1F},
+	{512, 8000, 4096000, 0x60, 0x00, 0x01, 0x08, 0x19, 0x1B, 0x1F, 0x7F},
+	{512, 16000, 8192000, 0x20, 0x00, 0x30, 0x35, 0x08, 0x19, 0x1F, 0x3F},
+	{512, 44100, 22579200, 0xE0, 0x00, 0x00, 0x2D, 0x48, 0x08, 0x1F, 0x1F},
+	{512, 48000, 24576000, 0xE0, 0x00, 0x00, 0x2D, 0x48, 0x08, 0x1F, 0x1F},
 	{768, 8000, 6144000, 0x60, 0x02, 0x11, 0x35, 0x8A, 0x1B, 0x1F, 0x7F},
 	{768, 16000, 12288000, 0x20, 0x02, 0x01, 0x35, 0x8A, 0x1B, 0x1F, 0x3F},
 	{768, 32000, 24576000, 0xE0, 0x02, 0x30, 0x2D, 0xCA, 0x0A, 0x1F, 0x1F},
diff --git a/sound/soc/codecs/es8326.h b/sound/soc/codecs/es8326.h
index 4234bbb900c45..dfef808673f4a 100644
--- a/sound/soc/codecs/es8326.h
+++ b/sound/soc/codecs/es8326.h
@@ -101,7 +101,7 @@
 #define ES8326_MUTE (3 << 0)
 
 /* ES8326_CLK_CTL */
-#define ES8326_CLK_ON (0x7e << 0)
+#define ES8326_CLK_ON (0x7f << 0)
 #define ES8326_CLK_OFF (0 << 0)
 
 /* ES8326_CLK_INV */
-- 
2.43.0


