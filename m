Return-Path: <linux-kernel+bounces-160417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 384BC8B3D4D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55C428976D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2684159912;
	Fri, 26 Apr 2024 16:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k8pqd5J0"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD71158D97;
	Fri, 26 Apr 2024 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150610; cv=none; b=d/5UoUsg4JyEtHLqT1z4yP3TU7oTPBqWq9okHfaUF3zzBGwtDjxOhmDoHsOh6xlbwILfj++MEhxEhBp9lt6ki4tJ5PyKXNj7NPCw8WGiEqwTaS9FGRrWsxEEhDsx2Z7jOSLucKS2AjovHfSfq+/A3Fq28i5Hx1sYm45A3pJTTT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150610; c=relaxed/simple;
	bh=P+1rMsmlu3vZ5B86+d/1krofnxEMi9vT6St9leoKSwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UW/46w4IUL4XrvwQbAaD5+jAoqWF6eLTZdWN+gBe88dxcGk1/2JYjG+92omx9o2gdobj8h7tYAxTtmF75WTSt9SbzJY+mlFODVeYw0MXKDydxwfF/QcrU1YKd1DtfADwPP5B+DRgpOSByCaFCrQCPbSazmoJGsYUlhHBPAz0qxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k8pqd5J0; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 39C4AFF808;
	Fri, 26 Apr 2024 16:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714150606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0c2iYCYeMf93nelrLleWfSo4CLIYmfO/ZMUay8A7fbg=;
	b=k8pqd5J0SEnI/Q3NCYNucRHZGWch2GW/mNj40FYSbmu+rvS8sB6mf9AHu2omVxd+oo5mLa
	T7U2Nue9z6jsqsvt3fXmHXoIGkVTUBQy0yITLp8A18K+cD0j53jwrTclLTd7HuwTAehGkQ
	bzOZvMmzkZgidTabc6yCsscFkrZiRW9lGcVl2btgdIt6ISod0rYtl3UwUpfLUG6zPtgtzF
	yYXsrb7NlrHXO1reuPJzgpBxYpLlWaZO3MIswcv/U4AOseebrW0FCODi1FeFWSYs30Gs6/
	Ngrrk6SCBbZNSA+GZeOo4T5JbYouq834ob6MztasZobKG/36Vs21QKwJNRKtZw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 26 Apr 2024 18:56:34 +0200
Subject: [PATCH v2 01/12] ASoC: doc: dapm: fix typos
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-dapm-docs-v2-1-87b07547eb5b@bootlin.com>
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

Fix various typos.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 Documentation/sound/soc/dapm.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/dapm.rst
index c3154ce6e1b2..59f65b181828 100644
--- a/Documentation/sound/soc/dapm.rst
+++ b/Documentation/sound/soc/dapm.rst
@@ -50,7 +50,7 @@ Stream domain
 All DAPM power switching decisions are made automatically by consulting an audio
 routing map of the whole machine. This map is specific to each machine and
 consists of the interconnections between every audio component (including
-internal codec components). All audio components that effect power are called
+internal codec components). All audio components that affect power are called
 widgets hereafter.
 
 
@@ -221,7 +221,7 @@ when the Mic is inserted:-::
 Codec (BIAS) Domain
 -------------------
 
-The codec bias power domain has no widgets and is handled by the codecs DAPM
+The codec bias power domain has no widgets and is handled by the codec DAPM
 event handler. This handler is called when the codec powerstate is changed wrt
 to any stream event or by kernel PM events.
 
@@ -236,7 +236,7 @@ a virtual widget - a widget with no control bits e.g.
 
   SND_SOC_DAPM_MIXER("AC97 Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
 
-This can be used to merge to signal paths together in software.
+This can be used to merge two signal paths together in software.
 
 After all the widgets have been defined, they can then be added to the DAPM
 subsystem individually with a call to snd_soc_dapm_new_control().

-- 
2.34.1


