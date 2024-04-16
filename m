Return-Path: <linux-kernel+bounces-146298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E978A634F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318521C206A4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFC03D551;
	Tue, 16 Apr 2024 05:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HlNqpEe1"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4623D0AD;
	Tue, 16 Apr 2024 05:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713247007; cv=none; b=TQc9Q3uxEOrYVqA+Vc3wuxq84oLiXeeY52RlA7j5NF5QSfIF024xv2T56R2THUbnB7kfyxyjyoEbesokxyjwqW6nST8s48yUXb2oa+LvSX2441oVj855VmS1RmHFsAOLjz+cES9nzoreVav/zlmv75+10DIpLwHwSBPHOzgxHOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713247007; c=relaxed/simple;
	bh=NzF9WSm5hjJeV8VjR/dtbCVCV5aw4bi9iF0cHO7hxl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HD17yPKhzsgjU4n9AtH6hEqoUe8/JcaxTtxkIaGlxALo1drm0HYfb8Hjy5pBrq4q7wMb4aORYhlIcaZladV/Jj7iVPofFo6/8ncOg5be7AN71RxNgBLcbb9B23tlYcvCyKzRg8HcJdXKg1C3VNKFCQKsAly7bCs0CZkreuYDpCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HlNqpEe1; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DFA8F240005;
	Tue, 16 Apr 2024 05:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713247004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kTeg2Oy81IFfigKGZfw4tgkhOc4F2FX2VCyGvP0yTvA=;
	b=HlNqpEe1v55AmdcpuA3VCelMAXy+zU4JujAIXBjjidaCB+1Ck2rzllzaqWUNRcCa66+xea
	x4g7m3SAhYoVoG9j7FGDzO42NZMyBMxFDjZrfmIsZym/p2LfBcHP8VzsDkiEq76hA7BeVC
	AOuOgoohJSIIUhkg14tkUC5uJdam7ZbVp0+5Zu0gZAatEOBxWFI0A0SRKSkZK9+Vu58t2+
	eJAT7DU7ff05nQ+zcsBx0Jpwdmg4ABRhG3m5OIQnjLSkVYwR8md546JpPTsxvDMhwarNqw
	n0R2GXr1Weh08oxCsdSB9RsEjm4gsMB2OiJoLtq0oOtw4JRkIysnKZvMgFBpSg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 16 Apr 2024 07:56:12 +0200
Subject: [PATCH 06/12] ASoC: doc: dapm: replace "map" with "graph"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-dapm-docs-v1-6-a818d2819bf6@bootlin.com>
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

DAPM is actually based on a graph, so use this specific term instead of the
more generic "map".

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 Documentation/sound/soc/dapm.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/dapm.rst
index 4200bcf18fcd..cab40a6b4c96 100644
--- a/Documentation/sound/soc/dapm.rst
+++ b/Documentation/sound/soc/dapm.rst
@@ -49,7 +49,7 @@ Stream domain
       stopped respectively. e.g. aplay, arecord.
 
 All DAPM power switching decisions are made automatically by consulting an audio
-routing map of the whole machine. This map is specific to each machine and
+routing graph of the whole machine. This graph is specific to each machine and
 consists of the interconnections between every audio component (including
 internal codec components). All audio components that affect power are called
 widgets hereafter.
@@ -230,7 +230,7 @@ to any stream event or by kernel PM events.
 Virtual Widgets
 ---------------
 
-Sometimes widgets exist in the codec or machine audio map that don't have any
+Sometimes widgets exist in the codec or machine audio graph that don't have any
 corresponding soft power control. In this case it is necessary to create
 a virtual widget - a widget with no control bits e.g.
 ::
@@ -248,7 +248,7 @@ Codec/DSP Widget Interconnections
 
 Widgets are connected to each other within the codec, platform and machine by
 audio paths (called interconnections). Each interconnection must be defined in
-order to create a map of all audio paths between widgets.
+order to create a graph of all audio paths between widgets.
 
 This is easiest with a diagram of the codec or DSP (and schematic of the machine
 audio system), as it requires joining widgets together via their audio signal

-- 
2.34.1


