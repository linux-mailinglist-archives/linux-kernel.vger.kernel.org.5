Return-Path: <linux-kernel+bounces-146294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 631438A6347
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5A2283D8A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B483FB96;
	Tue, 16 Apr 2024 05:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nDl7OTtD"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573B03BBE6;
	Tue, 16 Apr 2024 05:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713246988; cv=none; b=HDakRmmUAFsEXIAKgJBT+VpgyeMkoDnqdGRrLez1VKbZKIrReyWQVt0eq9sMCytM3uy7coVTZ8qeq70xHmMC4wBmCxGfnER8aKbDh3bBYazA/GcmrV8DqCZN3A86R1MsfGZ7Bumdm3evNrCNsIxD2036nzAj4LPfNNAQK0QYJG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713246988; c=relaxed/simple;
	bh=+vFkaCXux8xbUp0bJJl+WstJMViKzoR2BQBfL9gJnDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mXYwUB6z32dloi4Oid4cwV0scGxia9oJi8uPXLZcY91RM5aZs7+DKRcW+RS6m5QFitaiErNdS9PcjfbyZG4wsui5uqdAWmsUlvi3CpnYfY1j0HgkNsvEy5tcX0b9qNUSQYsQjSPhXOpUGCMaOaGBG4N7z6Jd19fe0SBTTXOso1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nDl7OTtD; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4FB30240002;
	Tue, 16 Apr 2024 05:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713246979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KozsKZqPxFJ6j8vO37CaaASxd2O7CRf2GFzV36+uNwM=;
	b=nDl7OTtD7SScN0Kdi+kj+8JL7ReAshegQeVDEA1xDqdJywV0PNzzThKT67Q0dX8x+PQeYk
	Q5FOCxPNPiOcefn430KMfRr5UDibAUXB0zsd4ZXuHoVkop8kucJKybPwmcI73YJxHsOSZl
	zAh3Rl+MdmGH91dqltNC1mLwpeALAer9dJ3zUV/H2C3S8Nh42SjR9wsrNuP619ySHuVkSa
	qcxXmD4gmQtbUBVQrlqTHCbPW8Hvp3gAf5/TVplSXPPEBh6NtvPE784aq1DmSpDlCt3dEi
	/HmYy9LgKXP0BgBN9TcMSSW6PBfRDbkb9OhmSvZKke0eEV5um65bof2WaSmlBA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 16 Apr 2024 07:56:07 +0200
Subject: [PATCH 01/12] ASoC: doc: dapm: fix typos
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-dapm-docs-v1-1-a818d2819bf6@bootlin.com>
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

Fix various typos.

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


