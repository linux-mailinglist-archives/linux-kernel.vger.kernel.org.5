Return-Path: <linux-kernel+bounces-160421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585A08B3D56
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135E42804D2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3C01598F5;
	Fri, 26 Apr 2024 16:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MrysdL9W"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15E515B55F;
	Fri, 26 Apr 2024 16:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150613; cv=none; b=e3uVtxW398I80MRypHvltJWe7ZijFP4DZeps225DwYq/eY8cjgTUGcy4icTh705emoWHhtgEpEBRddTZLeaIVEvTre7XfTGGXv6V7uP12HDskr2K44Ahn/wHN6+NF719YEKQd2HT5Z0O7CCO2rEOS38BbRWgJH5KkInpxlsDxOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150613; c=relaxed/simple;
	bh=iAvdCPOrzIXYffqO3FbcSrYObGd1PeIB+S0uhVk1E6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FyTl//b5knA5AII83NwdoSuYds0NasnDjzRVOukYvAvJPMYTX/S9IWabe2CCtl/OrTE265txrd7JeJ5TKlOsgUoiLTJ1KQHKNFyf6/Dsasw8ZXWJg7MPjbwBdJevaejgZNOSBzduA8HLHgQnSOdkkaOp/Mq/GR+2lt/7hDlbCpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MrysdL9W; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 784D7FF80B;
	Fri, 26 Apr 2024 16:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714150609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nuJ5K/2010lvsI68FrIzNz+OnkbnxjU46I0ZJTtVqOI=;
	b=MrysdL9WDgD3EUp66JQXXj4BxGmUw85HntBsatMQPkIEk11fepJsHqXPgD/omPe0UtYvSF
	uqI4CBc4+3SzYpydB8BLMSm8Zg3TxWkaOk1iHcNNHtW7LUD2FNpkmTj7E59Rldr63Vp8Mg
	pdIt8sPjb/hHfazpMkIyy+dgHNXC1Xjr2zO/51dLw0NyYFaKyiSy5HStYR/7pycOW6kab8
	2ZprB0J1redKN6kiXNi8gqGsy0eSvso6+er+21oyXhDfxZbXdGKXtmg9QksPw62gk5dNtr
	CNMbtVxnfcxJNFLdxK78U2USz5nhhKFsIHq0aAgduu6k12WNOQH4uzBk5LdwIA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 26 Apr 2024 18:56:37 +0200
Subject: [PATCH v2 04/12] ASoC: doc: dapm: remove dash after colon
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-dapm-docs-v2-4-87b07547eb5b@bootlin.com>
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

There is no need for a dash after colons. Also fix an incorrect ":-::"
sequence.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 Documentation/sound/soc/dapm.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/dapm.rst
index 479c010d2dac..be849879274d 100644
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


