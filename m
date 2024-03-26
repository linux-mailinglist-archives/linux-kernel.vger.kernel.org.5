Return-Path: <linux-kernel+bounces-118349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4824488B905
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 04:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEBBDB22E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D1C129E88;
	Tue, 26 Mar 2024 03:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="pGuva+Ua"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B567E1292E6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 03:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711425022; cv=none; b=OqyDTHWsb7j7rkKtqDRAehRlURIkPzMn26Tl2FpkY7SAAzB/kHpPVMcPWzFxdYe5ZdPb7jp06rUq+tqzAW3Ye9UOckOHXJTd4xWnpSf5QnjkWt8ZYLMiNYSFtQ5xHt84uQvtz26VIlV/Lg0Xu/MSZTSgEejBRKYdseqAl/wuWUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711425022; c=relaxed/simple;
	bh=bctQBJg26saGhxU9s8UlkMFaCikEYQsmHPO5D2q9/BE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rLvMHGlVaVYwihgvhsLCqHkKiwph5XikeQsoJgXcrWHUi4GyTJEdchIcinx0zs7fAGsh+Lt/QoXa5/QyAwLtaQijyYH6Nrh9kMmgSpZhS2iHOLvrDNeFiaAe9mO8oKKH8YzS7tqaNpRgU3qj2wBn6W8IHP6CMdHJm/Oq4tLJIRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=none smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=pGuva+Ua; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1711425015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K9DFWcbSfaZCwj5K7OSlhvorCFoj07hKTzCP89IkAuA=;
	b=pGuva+Uac4faL7cAdCOY51vt/AXVNR2AT7b/EsX4N4yx/vjM89RFH1EEGcZEH3zMLII4uc
	TjKqbTX5GMWpmnIwbTrYuFNoBJ8SUxqFrqqbVFV0+l8METXSuEqMA6M42TLXNwhdaiWdAY
	Av5q49y28YcZH/DQjgS3sFS8Gyk8SfXrm6AAV7KVVVTzMwzBxXceC4aOIvf3qaY5138gbf
	MZa127VUNTNK1SaSmrOgEos5/JqP/knJyjS1MPKY8nKIX7BttNhgCo5V0dTlRIjZb/1MEx
	TcPZX/JVDZ13nGn2bkb7MCCcvZyz30/vPq+MXSqnnQa+kbbrAwfOCLymn9bX2A==
From: John Watts <contact@jookia.org>
Date: Tue, 26 Mar 2024 14:50:03 +1100
Subject: [PATCH] ASoC: sunxi: sun4i-i2s: Enable 32-bit audio formats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-sunxi_s32-v1-1-899f71dcb1e6@jookia.org>
X-B4-Tracking: v=1; b=H4sIAOpFAmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyMz3eLSvIrM+GJjI900o8QkI9Mki1QzCwsloPqCotS0zAqwWdGxtbU
 AUQ+OeVsAAAA=
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1711425003; l=1320;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=bctQBJg26saGhxU9s8UlkMFaCikEYQsmHPO5D2q9/BE=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAWWEuABqUeoiIQmUDevKLBIs
 55txNImjUfXyzNdEM4lMfiVhlRL7Fz/dVUvLSegPOrhOchxP+1vRLZ0uIkvZMDQUAAOcU
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:6LBQmZH5u7i/edmEZXzCTwCrpSevs/ZshZxNmlD1thY
X-Migadu-Flow: FLOW_OUT

The I2S driver already supports and checks for 32-bit sample sizes,
so indicate this size is available for use in the DAI driver.

This change has been tested on the T113-S3, but it should work just
fine on older hardware as get_sr checks for sample size support
correctly according to each core's datasheet.

Signed-off-by: John Watts <contact@jookia.org>
---
This patch enables support for 32-bit audio in the sunxi I2S driver.

I have only tested this on the Allwinner T113 but I'm fairly
certain it will work on older boards.
---
 sound/soc/sunxi/sun4i-i2s.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index a736f632bf0b..aeea852141c1 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1103,7 +1103,8 @@ static const struct snd_soc_dai_ops sun4i_i2s_dai_ops = {
 
 #define SUN4I_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
 			 SNDRV_PCM_FMTBIT_S20_LE | \
-			 SNDRV_PCM_FMTBIT_S24_LE)
+			 SNDRV_PCM_FMTBIT_S24_LE | \
+			 SNDRV_PCM_FMTBIT_S32_LE)
 
 static struct snd_soc_dai_driver sun4i_i2s_dai = {
 	.capture = {

---
base-commit: 72fb52fb0ac44b6a1edd9bc390e44bce3acccd26
change-id: 20240326-sunxi_s32-f2ab25b8e688

Best regards,
-- 
John Watts <contact@jookia.org>


