Return-Path: <linux-kernel+bounces-146304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBDC8A635B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2F91B23E73
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740555A0F5;
	Tue, 16 Apr 2024 05:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R6lMXlNH"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4C76F513;
	Tue, 16 Apr 2024 05:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713247037; cv=none; b=V+gWQBiTcKX9F95QE6UWL5INULpPfDkI6hRU90SQZAmFD9H1Bo7amP7yz6XNc/mMjWle5xglHxu8xHFta68pA60XEeTVxhShBb+VjtyXVqKq/e1jGwKVfvg86iv7PxgD2dtjysuq0O66XrQ9MePDAc+RmINpUiHYedFY6ZjJYqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713247037; c=relaxed/simple;
	bh=BSiD45iHezRW5bA1OBXq4yRQdrMCdX7Kl7um3fjh6H8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qS/s+DhogQ0tNxDmmMuqV0yO+/3dKeYvwm2JLtXE+M9fW/hEFQCerDQ3ZTg8LibI0pM9rr0RlDQyHOcYC+rlT2wObQE1OdWtvGjl9I48Y2gwJQQUIbF6+WJYgBkfFpSQDfxVjnZ1B00+GqP2ISLIxzbNYqlP79QA1TLt8mplTJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R6lMXlNH; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 25711240002;
	Tue, 16 Apr 2024 05:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713247034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6kUCOTU/KHoNeSRP9VYf4bLvh0d1EyGbb//Y+6ttp4=;
	b=R6lMXlNHkx3gtA+mxyCTBUY7GsR81/Gr9OrY6Zk+YhszsFvXJ5qQP1FtxcnBY1ZtaWCzLU
	fchP7KAvj1Okp1UnqAFmcXvXXFZrSOyHCLVF/vnjUt1BsQjBy6VnVSxTDZYIvqc6SRQncD
	EBnveo4jzDuio7ldjDbs4aA8QOksxxxvQtZALjQrmhJls8MUKaQ0ux1See/Vnv63CLY2MV
	H2U3ayIqb9IAxIZsFHLLs6C5H7ZtUP54Kq6XW5QVGwRKkQeJY+uJuuP2yxE77In8Ngq9QI
	PJjnLD9gLQtbcXarPuIjb5tTVLG/C9GRIH45X44UTzwzoPE0Gfbq36w2h0BXMA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 16 Apr 2024 07:56:18 +0200
Subject: [PATCH 12/12] ASoC: doc: dapm: update event types
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-dapm-docs-v1-12-a818d2819bf6@bootlin.com>
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

Some new event types now exist, so update the code fragment.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 Documentation/sound/soc/dapm.rst | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/dapm.rst
index 75a85c9e33ff..f76fc97dd162 100644
--- a/Documentation/sound/soc/dapm.rst
+++ b/Documentation/sound/soc/dapm.rst
@@ -405,13 +405,16 @@ See soc-dapm.h for all other widgets that support events.
 Event types
 -----------
 
-The following event types are supported by event widgets.
-::
+The following event types are supported by event widgets::
 
   /* dapm event types */
-  #define SND_SOC_DAPM_PRE_PMU	0x1 	/* before widget power up */
-  #define SND_SOC_DAPM_POST_PMU	0x2		/* after widget power up */
-  #define SND_SOC_DAPM_PRE_PMD	0x4 	/* before widget power down */
-  #define SND_SOC_DAPM_POST_PMD	0x8		/* after widget power down */
-  #define SND_SOC_DAPM_PRE_REG	0x10	/* before audio path setup */
-  #define SND_SOC_DAPM_POST_REG	0x20	/* after audio path setup */
+  #define SND_SOC_DAPM_PRE_PMU		0x1	/* before widget power up */
+  #define SND_SOC_DAPM_POST_PMU		0x2	/* after  widget power up */
+  #define SND_SOC_DAPM_PRE_PMD		0x4	/* before widget power down */
+  #define SND_SOC_DAPM_POST_PMD		0x8	/* after  widget power down */
+  #define SND_SOC_DAPM_PRE_REG		0x10	/* before audio path setup */
+  #define SND_SOC_DAPM_POST_REG		0x20	/* after  audio path setup */
+  #define SND_SOC_DAPM_WILL_PMU		0x40	/* called at start of sequence */
+  #define SND_SOC_DAPM_WILL_PMD		0x80	/* called at start of sequence */
+  #define SND_SOC_DAPM_PRE_POST_PMD	(SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD)
+  #define SND_SOC_DAPM_PRE_POST_PMU	(SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU)

-- 
2.34.1


