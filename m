Return-Path: <linux-kernel+bounces-160422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B312F8B3D58
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6652819A3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB3716D9DF;
	Fri, 26 Apr 2024 16:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Nlgah74g"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D1A15E80A;
	Fri, 26 Apr 2024 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150613; cv=none; b=biHblDqCgnx1VV0XiLaCyWfRRyMSFTCUcwnBM9HHDaOR2vEWme4Ukt9EQ41DCMB5DxRC8N3yhzJdxRxLRbOaVS7/aMuR8DmLY/nJ5NfvrEEYRXSVoU1v11ka/70CZHhrrfKHvFdBocRfamHTqM0IjI5NpuvNiGIOy/XyP/iT/Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150613; c=relaxed/simple;
	bh=izH8aN9JbxlJCgVXuJj/T6p5ltAsS+zG4LVColcQa3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FITZy66yPK9vId1gwtywtA7Y3rcjQ3Ow14+kzzEZPn1gMXQ2U6VhS2BN02xdjgMwgHIo1U0Znswd8beW9VMoIc4MSUGOb5vHHdM1rwFWye27wCmRfrZCnEqKeAxtEEb2izUSCg0PpB4A5UgFaJOt1cXiu8uoWKnNSu8fuyHCcMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Nlgah74g; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 858C6FF804;
	Fri, 26 Apr 2024 16:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714150610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xUcsggNakbTjb/NCiIo3V9WybOVWhSaKxz4EMUq9xB8=;
	b=Nlgah74gBN6VHionFpPM2GzQoDnt2RjjVVCHXoqjF7jSKqOJYdzbsvF4vWSXGaltHDCpXz
	9t+Crnsh3EZ0lIeaqTD1nnf0fUQ+k9rtFB/Wav1fgsnT/hRppaYJsEVQRaK0v8oGcgdigD
	VCA/EPT/78WWNVGg6sPefjZwPHdDPRPplTwG9jc0khLRHZC84heuqlleDp+7zKIgxbyMTN
	ubniy+fQMol+XvgoYJRhJOCMxMoWovR4LGi5nNMP5+tZ64O2DpKkwAGEQtV2ClhYouZjP1
	usu3Wr9pQ4mBiNiAjSP636rpOUyYUBD9SXY1mplO9X/H6vB5aYm11rmu82fG6Q==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 26 Apr 2024 18:56:38 +0200
Subject: [PATCH v2 05/12] ASoC: doc: dapm: clarify it's an internal API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-dapm-docs-v2-5-87b07547eb5b@bootlin.com>
References: <20240426-dapm-docs-v2-0-87b07547eb5b@bootlin.com>
In-Reply-To: <20240426-dapm-docs-v2-0-87b07547eb5b@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Bagas Sanjaya <bagasdotme@gmail.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-sound@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

Clarify DAPM does not expose any API to user space, and adapt the paragraph
accordingly.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 Documentation/sound/soc/dapm.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/dapm.rst
index be849879274d..f96a32f137aa 100644
--- a/Documentation/sound/soc/dapm.rst
+++ b/Documentation/sound/soc/dapm.rst
@@ -11,9 +11,10 @@ subsystem at all times. It is independent of other kernel power
 management frameworks and, as such, can easily co-exist with them.
 
 DAPM is also completely transparent to all user space applications as
-all power switching is done within the ASoC core. No code changes or
-recompiling are required for user space applications. DAPM makes power
-switching decisions based upon any audio stream (capture/playback)
+all power switching is done internally to the ASoC core. For this reason
+DAPM does not expose a kernel API to user space and no code changes or
+recompiling are required for user space applications to use it. DAPM makes
+power switching decisions based upon any audio stream (capture/playback)
 activity and audio mixer settings within the device.
 
 DAPM spans the whole machine. It covers power control within the entire

-- 
2.34.1


