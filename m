Return-Path: <linux-kernel+bounces-146293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EF48A6345
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF261F218CF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D843D0AD;
	Tue, 16 Apr 2024 05:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kCdRT8w1"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501FE3BB27;
	Tue, 16 Apr 2024 05:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713246987; cv=none; b=sx/dVpzGdV1AByGA1iHyNFlMCPo+Qr8a9ahZtiNf0Hi4JOcSY/eN1+7vMz/KBqP0lt8xI1m6tv4YU6m6RhWv0bJyFOexYngvfSPdeml3srnUnnSPa1n3JrMlgk+uEit1bYQg9L/KXQiUq+oHEIaD/s0yXg9J6JnXO5TvS6GT95A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713246987; c=relaxed/simple;
	bh=sIDZ37omvPJlr1EjoCNsy3gXk5EP2o3QL2zoRZT03vY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TnvYTU6RF8uCa0x/KCJ+exWiFZ1eGONdQh4ckbvbNTwtw2zqx+HETTx2zCCQb/uJ5rSN/W8UYnB1uYnGFC1Q225ZyQQJzY4eebp+rSpXpXGgHhl2ooogwjkbIUmeAibpJKmaRwX5P1+PCuAdQ0sFdeFmCgejsSbyjqFXoJK3urA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kCdRT8w1; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 05E68240004;
	Tue, 16 Apr 2024 05:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713246983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SU60F/TtVpw5iTA/baQhbWO9BMLZGG+/I93Pm7TH4/w=;
	b=kCdRT8w1LfTfm22mtG7FCETZkPMVycuqCY4yymiPxXb0PIvzCXwy7pzZSOynySdoF6+Foh
	CcyjzsrEsCSQpBzkXEiw7OCtPIbArjbVP0EqtZBd8MvZ3NiT0wenTdwqeD7PT5EyJOZwer
	xvX9C3F8OQ5UT0lTFV7azmJiHk0qGv+lQ+iZ/KuSXLsahQtPyYdd32F1fjADEfT6dZVCf1
	sW/h4z/fMlNpRQpICG2mIWehKf0jWcEyHlqWEiMDXgypd7zLzfnUJ/e/C4ZfxACtp7gT9D
	9+KiGLiGiAO7pBC6yhmXUfm/+UN1FOr1hys/dUEloRKcv8X8h7obXX5lq0p9mg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 16 Apr 2024 07:56:08 +0200
Subject: [PATCH 02/12] ASoC: doc: dapm: fix struct name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-dapm-docs-v1-2-a818d2819bf6@bootlin.com>
References: <20240416-dapm-docs-v1-0-a818d2819bf6@bootlin.com>
In-Reply-To: <20240416-dapm-docs-v1-0-a818d2819bf6@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-sound@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

struct snd_soc_codec_dai does not exist.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 Documentation/sound/soc/dapm.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/dapm.rst
index 59f65b181828..68ef79f539f2 100644
--- a/Documentation/sound/soc/dapm.rst
+++ b/Documentation/sound/soc/dapm.rst
@@ -148,7 +148,7 @@ Stream widgets have the following format:-
   SND_SOC_DAPM_AIF_IN(name, stream, slot, reg, shift, invert)
 
 NOTE: the stream name must match the corresponding stream name in your codec
-snd_soc_codec_dai.
+snd_soc_dai_driver.
 
 e.g. stream widgets for HiFi playback and capture
 ::

-- 
2.34.1


