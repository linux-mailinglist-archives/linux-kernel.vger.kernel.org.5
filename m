Return-Path: <linux-kernel+bounces-104338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3524B87CC4E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE5B1C22575
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1EC20B33;
	Fri, 15 Mar 2024 11:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nQloQW+L"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9856B1C687;
	Fri, 15 Mar 2024 11:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502086; cv=none; b=EZYrCRzdqABbvPZv6SQMHmzIFr3eXXskNq9tDrfsTiFEmk0gfuj+FxxhCxVNZcJUk4FWvuejk0KQED4VJnHMLKAODibGKeiFxJXe74ddrqr/zUujX82s/DfaRSv/Lkjdy2Hwr2OomjE9i9v5h0uWSB+t3xNPu0ruv/Z4v8ifcyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502086; c=relaxed/simple;
	bh=XVrqaYGWmJTFebdeWf0nePt+KDZv5ZIE/BRC4hiKX1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcvdpF48z7dXZp9L3hAmDMKGRMLgUwgrSms/QdYy9vQAFEriLB+qQNSSj/JPKbH4aZDyXssvCz4qn4w2prj76wnsPIAUGMVMpZHGZ+KMe+9vn/2GswqjJRm7DU/kGscFA45dA0ebd3G3LAYNQ5Ca4yUVkkCeNKeGr2AP3b6EPfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nQloQW+L; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 4FE46E0004;
	Fri, 15 Mar 2024 11:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710502083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rIIVeMMbsAWvQSYg8CaxSM8SnaSJIx8VolCRbQElsx8=;
	b=nQloQW+LiV7NH+lAEDVXoJbNi3po1hk/8VSb3nnFfLqg3YhAzmXIS4BV63HKESHUBS5PHw
	mjTogem3ct8QXJ1rglzYWWCcYDokmAJ/uUh+JsBeaxZukIHK1SGmDMfY+etmN8yZyKv4qZ
	UGRb0H1QDD7DOryGFKFJvp/poc87G+J6gxXSOjTS2Qmhvtora+DGRn77j2oGcWu96rHvqT
	kDa17wCDAtXpEqAID8cGXcc9A2HZea0sGM4y0BVeTXrwMzDP+7OZs4zuqF4qSW7+30a4tZ
	6FcQDGWNJNUgwmVTivFucl+QrfUXMmzKMea3RRfEFhG0a13uGNtGIohaP9fIqg==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com,
	christophercordahi@nanometrics.ca
Subject: [PATCH 06/13] ASoC: ti: davinci-i2s: Delete unnecessary assignment
Date: Fri, 15 Mar 2024 12:27:38 +0100
Message-ID: <20240315112745.63230-7-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

In davinci_i2s_hw_params(), mcbsp_word_length is set twice to
asp_word_length[fmt].

Remove second unnecessary assignment.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 sound/soc/ti/davinci-i2s.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
index 8ee22d79b0f4..f4514d4dff07 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -479,7 +479,6 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 			return -EINVAL;
 		}
 	}
-	mcbsp_word_length = asp_word_length[fmt];
 
 	switch (master) {
 	case SND_SOC_DAIFMT_BP_FP:
-- 
2.43.2


