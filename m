Return-Path: <linux-kernel+bounces-146296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719AC8A634B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124701F226DF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA615A109;
	Tue, 16 Apr 2024 05:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EbpO9AWa"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CF043AC5;
	Tue, 16 Apr 2024 05:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713246997; cv=none; b=QosHWqcJAnnHKD7eCzyjTLH45b6Ylw5ev+AN+xoh5I2/JfuRNPiFGPFCJsQZjEV/24kkVbIjVRAUISYlMavwGO5C02dgjMV+Un3vuczuQ+eaDrueLabHjRIPfr11ke7e1cJLKZ+c3E6y1LdEXayP/A8hVCfWkabxIO16QAblr84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713246997; c=relaxed/simple;
	bh=7ZjW2KJGMgthacCzmck+UsU4PwyYoeHyxRSrQibBUH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZGxqpODmO33M4kj2saHPpAsmt2l+Zk7NiOzYegdgig0Nb+2NRNtCZxVqQMjpJroTRt01E5DNyYphYgM/1JEs3jsNzuh7O7DrDAxFeb7QuvmWHSTw2xDxVc5LvwYbaRX/4JnHTtWNgCSpp8D6WP/MXjzKP8leFhyw9eZ2nhdK0Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EbpO9AWa; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A498C240002;
	Tue, 16 Apr 2024 05:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713246994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6zQrjhE+ysI5UolYk4pQvlwu+OCbM1GWYYOSbnnp/xU=;
	b=EbpO9AWa2pPcu0DQI3GEe9ItG8QCwPF7KqyZXtMQ8a4XAySjx5nS2ygYlFQ4CpYXhAnrE9
	Yf108b4hvIAXfI/XbIJ8D7MO/W8UfP8fu031Sc4/+T2TpjcEvrUZTP8akSmsm1YGzGUaQc
	dSSIxrX2dCE7qrJl/iXB9xgxKtDyBbJCw3o38Am3y7cmJQ/ps+RUMTNe4Oqvd+TRw4SQx/
	+IPeb8zvb+6gdn22n5NKIqYwWIjOOlG0fkjBN2YM5uvtrkYuICz2s8ChhxlR+TjlOPKRVl
	IiwoTOvvANlyXmh0d7d5p2sb9YmJw+wXz+7lz5ieb8jvsEfMMFh7AS47y08jHA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 16 Apr 2024 07:56:10 +0200
Subject: [PATCH 04/12] ASoC: doc: dapm: remove dash after colon
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-dapm-docs-v1-4-a818d2819bf6@bootlin.com>
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

There is no need for a dash after colons. Also fix an incorrect ":-::"
sequence.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 Documentation/sound/soc/dapm.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/dapm.rst
index 4dfa60519a76..e3b399201622 100644
--- a/Documentation/sound/soc/dapm.rst
+++ b/Documentation/sound/soc/dapm.rst
@@ -20,7 +20,7 @@ DAPM spans the whole machine. It covers power control within the entire
 audio subsystem, this includes internal codec power blocks and machine
 level power systems.
 
-There are 4 power domains within DAPM
+There are 4 power domains within DAPM:
 
 Codec bias domain
       VREF, VMID (core codec and audio power)
@@ -57,7 +57,7 @@ widgets hereafter.
 DAPM Widgets
 ============
 
-Audio DAPM widgets fall into a number of types:-
+Audio DAPM widgets fall into a number of types:
 
 Mixer
 	Mixes several analog signals into a single analog signal.
@@ -141,7 +141,7 @@ Stream Widgets relate to the stream power domain and only consist of ADCs
 (analog to digital converters), DACs (digital to analog converters),
 AIF IN and AIF OUT.
 
-Stream widgets have the following format:-
+Stream widgets have the following format:
 ::
 
   SND_SOC_DAPM_DAC(name, stream name, reg, shift, invert),
@@ -167,7 +167,7 @@ Path Domain Widgets
 -------------------
 
 Path domain widgets have a ability to control or affect the audio signal or
-audio paths within the audio subsystem. They have the following form:-
+audio paths within the audio subsystem. They have the following form:
 ::
 
   SND_SOC_DAPM_PGA(name, reg, shift, invert, controls, num_controls)
@@ -207,7 +207,7 @@ powered. e.g.
 A machine widget can have an optional call back.
 
 e.g. Jack connector widget for an external Mic that enables Mic Bias
-when the Mic is inserted:-::
+when the Mic is inserted::
 
   static int spitz_mic_bias(struct snd_soc_dapm_widget* w, int event)
   {
@@ -271,7 +271,7 @@ connect the destination widget (wrt audio signal) with its source widgets.
 	{"Output Mixer", "HiFi Playback Switch", "DAC"},
 	{"Output Mixer", "Mic Sidetone Switch", "Mic Bias"},
 
-So we have :-
+So we have :
 
 * Destination Widget  <=== Path Name <=== Source Widget, or
 * Sink, Path, Source, or
@@ -280,7 +280,7 @@ So we have :-
 When there is no path name connecting widgets (e.g. a direct connection) we
 pass NULL for the path name.
 
-Interconnections are created with a call to:-
+Interconnections are created with a call to:
 ::
 
   snd_soc_dapm_connect_input(codec, sink, path, source);

-- 
2.34.1


