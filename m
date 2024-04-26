Return-Path: <linux-kernel+bounces-160423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD03E8B3D5A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF1C21C23723
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FD516F26B;
	Fri, 26 Apr 2024 16:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Mbvn6Lit"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE0B168AE6;
	Fri, 26 Apr 2024 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150614; cv=none; b=a2mOG7gktyk2L9hmeIOAIPEtYP2U5wkV+h/PBSmKYAdU6h3zOUBpcmz4pIa3N3jRggMWD2+9hTniNcYlv5EvpDvRDGkx2t/YeTz62th6dfXrTpGROhDodJdSEezgtxmOdOpr2CSEAq61sblzJFbeXqZljivAddFoNgiguGrfzv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150614; c=relaxed/simple;
	bh=Y9CUnck7THjoN6x8IrAFw09G6hJUpUvGCNUaNkYbzZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EGsfsf5z06ZWPAxLdxX3YmJGIlIglxKmFSMDyZ5ZT8ETWBXEg/NCCNAx5WZ+pH6KAdjxe8OnIGHxxq1/VLvTsFwVf5C8tLzKIDk8XTVZYP8Nn3+3yxQF5sZFsHz7Xp/PAxna1uvFDHPmpt7AfNg2BLimqVJTyXTco9HIcJi8KSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Mbvn6Lit; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8FF8DFF807;
	Fri, 26 Apr 2024 16:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714150611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iSUU7C4Fcf6ZvY0mTm+OdGB1Q5lauGV6mB1GfXERmdg=;
	b=Mbvn6LitXY8/acwBgzfvXmcLNflwTmAotthAi+skuIcs/SEo6PyF/35YB3sqEZmdlKRRYD
	InRnupPiBEGpwAiojpf+aCKVS3+TI/JY7D21kI4NmhSD3eTzF6MDN/ylyOasMEKQp4Voke
	B45kf31txw1sqap7oVgNQABdQJPBJFYfVCo3eCWL0fKMLWfDIu9bbl4wnyMc9DANbZzHUL
	3Cg6Pk4qYa+k+8RfbELBTosvISUPGz+6zkkIhcAxDBIPp8wbUjac91WpZ56Uw1/VJGX3Vx
	RIv2extlaWJhfDLuOMj5GUTamE+Ewdhu5+6U7lD8HDZTK0N1KdyavYPnpYcKuQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 26 Apr 2024 18:56:39 +0200
Subject: [PATCH v2 06/12] ASoC: doc: dapm: replace "map" with "graph"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-dapm-docs-v2-6-87b07547eb5b@bootlin.com>
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

DAPM is actually based on a graph, so use this specific term instead of the
more generic "map".

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 Documentation/sound/soc/dapm.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/dapm.rst
index f96a32f137aa..11f7f2f685af 100644
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


