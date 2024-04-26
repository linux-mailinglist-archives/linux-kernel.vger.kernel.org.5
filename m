Return-Path: <linux-kernel+bounces-160429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A65478B3D68
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3A61F21A8C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC5F15B15D;
	Fri, 26 Apr 2024 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iF2KkeQB"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAEA16FF50;
	Fri, 26 Apr 2024 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150621; cv=none; b=GkZlafysaXj+nDS56Neroa4ATyS0vKNs2qqrpuYJfE2XYNJkeO38LUHRRNUr88i6aHtDtdJpIKQcKKN8bSMJQrRg8QkNvTgesFAYF/nU6QKLzbWe74mGPe/TVHI/aC+RclpOPneOMYFXEH8r+M1fikogE7GU96xKLlVmk+1sdEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150621; c=relaxed/simple;
	bh=wnFgu9dI3D2py+XrxISiUUb14iuf8bUF3qAQUXBua9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eQbmxGz6GKCDMEZyfWHfPW0jRbyL9/RcUlB2881qcBMIThH/Qhzr/gtQXq/eM9fRlR8R9/RyGzQHBt6ydNFKw4+n0q04tpzsVV4W4LWBlX1OlZziExg6cyQ2MwM88CTjM5+N8jTqIb8d2zy+XrYoN1FuqVGNjhCWBWwSxmJwK6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iF2KkeQB; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 139A4FF80C;
	Fri, 26 Apr 2024 16:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714150618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=50K17wTh30wqpE0frf03Mw6JWq1YiGmGGG3UJIVv2+c=;
	b=iF2KkeQBRDLsiVMmuXwQZSZExzcC31z+QcrhaeQ9K6rmeSEdpFAKFgiu5ZoSJeGmk6bD5g
	KO5C9RUJrb28v3De1uJT0SyYBhHYYiyLWBYAQPX5YPuWmpPi3tbHKzwyxe2wvute8oGuMI
	2LVucLcjOe7DPfsk+uEBxMw0w42XClDduTxfy3B8v3m7KmBwWuyZTbccsaaikw3OUQ97kR
	Spu2ksyCasIUr/NmWz9ciC4pwRRWJ00b+kWDS31rp6EEiX7CM07E9U51r4RXaqm1IfDDRE
	Mzr2FHYIB6qlh6h6g/qwFITJH6eUnFNOWAZSlvAPLZ9r6HXCp66YcovtSpEq+Q==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 26 Apr 2024 18:56:45 +0200
Subject: [PATCH v2 12/12] ASoC: doc: dapm: update event types
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-dapm-docs-v2-12-87b07547eb5b@bootlin.com>
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

Some new event types now exist, so update the code fragment.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 Documentation/sound/soc/dapm.rst | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/dapm.rst
index da9313e10fd4..574667f3aabe 100644
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


