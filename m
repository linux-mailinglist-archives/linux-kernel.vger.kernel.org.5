Return-Path: <linux-kernel+bounces-93629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E718987328F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C33BB25EE6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9CC5F489;
	Wed,  6 Mar 2024 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q4KzraUf"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2D05DF14;
	Wed,  6 Mar 2024 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709717418; cv=none; b=G7fbuRihZh04BddtCPjGjHnzn7qhJ3XSivHL+O415HDiqEDrQckcZIcYGBD0MtcePCOzO7N+/9Li+zvFABYBoAKswpx6TNZlmZU06x6U28YdpfIUcpK5PGpF4ESrin62+AFSUtU4oysbGgoOvEFREH16+V3yy8LqMJDJP2llpSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709717418; c=relaxed/simple;
	bh=cTefToFtwVhAQ8i3dFPgBPjlikGLUDhBO/cbOnwlNP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qv1/SrQOJ38yY6ZtU3RZhfzd9UkX6qRQzxGBgSuPrZbB1lVrASxLih2xGzaNPeSKNItJZBwTUJ8DG3mWTCz6Ns+mCWTJ3V7l+EW2N8fU2QuPA4h+zsLAJPkZJ2jSCgdMicua7naczT+z0zsNloolwPdGQMgZiBVu3PsIJJmfDkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q4KzraUf; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7C9FA1C0008;
	Wed,  6 Mar 2024 09:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709717409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQ3VHuLfhnfTcsfgCprSG/Jx5UxR5Py4OUyE2oFEY7o=;
	b=Q4KzraUfQuzhH0i5kczTZn1IU4kllu6HVuILq8u8bXcIrCiAtcQi6yZa80emo4MBRiFdqv
	Xlscq1RBGfOrcEjQNK9q5liHgCs//res/hsNUrtnJF+bueLkHEV23Xjh58zWYY0L0ueNoR
	kmjG9UI957MwbdlHZatHKiz34mUJBYqUDfpIlIK9roBbP2V4+Q166fOVc3m/64mvTrTk+J
	WQ73sLX8Jzq2Ynl9LS1gu4B3tgvqHfGHOkjbRX3toUtybarxPgbU50vQ6nb9ONBLHiBHYY
	B0HTvTHAfbQk9k06yAtHwjcvtaJHNNHWRHEba7Qm65KhDdjtzPJwAATtzbwwaQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 06 Mar 2024 10:30:01 +0100
Subject: [PATCH 2/2] ASoC: trace: add event to snd_soc_dapm trace events
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-improve-asoc-trace-events-v1-2-edb252bbeb10@bootlin.com>
References: <20240306-improve-asoc-trace-events-v1-0-edb252bbeb10@bootlin.com>
In-Reply-To: <20240306-improve-asoc-trace-events-v1-0-edb252bbeb10@bootlin.com>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

Add the event value to the snd_soc_dapm_start and snd_soc_dapm_done trace
events to make them more informative.

Trace before:

           aplay-229   [000]   250.140309: snd_soc_dapm_start:   card=vscn-2046
           aplay-229   [000]   250.167531: snd_soc_dapm_done:    card=vscn-2046
           aplay-229   [000]   251.169588: snd_soc_dapm_start:   card=vscn-2046
           aplay-229   [000]   251.195245: snd_soc_dapm_done:    card=vscn-2046

Trace after:

           aplay-214   [000]   693.290612: snd_soc_dapm_start:   card=vscn-2046 event=1
           aplay-214   [000]   693.315508: snd_soc_dapm_done:    card=vscn-2046 event=1
           aplay-214   [000]   694.537349: snd_soc_dapm_start:   card=vscn-2046 event=2
           aplay-214   [000]   694.563241: snd_soc_dapm_done:    card=vscn-2046 event=2

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 include/trace/events/asoc.h | 16 +++++++++-------
 sound/soc/soc-dapm.c        |  4 ++--
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index b7ac7f100bb4..4eed9028bb11 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -57,34 +57,36 @@ DEFINE_EVENT(snd_soc_dapm, snd_soc_bias_level_done,
 
 DECLARE_EVENT_CLASS(snd_soc_dapm_basic,
 
-	TP_PROTO(struct snd_soc_card *card),
+	TP_PROTO(struct snd_soc_card *card, int event),
 
-	TP_ARGS(card),
+	TP_ARGS(card, event),
 
 	TP_STRUCT__entry(
 		__string(	name,	card->name	)
+		__field(	int,	event		)
 	),
 
 	TP_fast_assign(
 		__assign_str(name, card->name);
+		__entry->event = event;
 	),
 
-	TP_printk("card=%s", __get_str(name))
+	TP_printk("card=%s event=%d", __get_str(name), (int)__entry->event)
 );
 
 DEFINE_EVENT(snd_soc_dapm_basic, snd_soc_dapm_start,
 
-	TP_PROTO(struct snd_soc_card *card),
+	TP_PROTO(struct snd_soc_card *card, int event),
 
-	TP_ARGS(card)
+	TP_ARGS(card, event)
 
 );
 
 DEFINE_EVENT(snd_soc_dapm_basic, snd_soc_dapm_done,
 
-	TP_PROTO(struct snd_soc_card *card),
+	TP_PROTO(struct snd_soc_card *card, int event),
 
-	TP_ARGS(card)
+	TP_ARGS(card, event)
 
 );
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 7e8a2a5312f5..ad8ba8fbbaee 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1963,7 +1963,7 @@ static int dapm_power_widgets(struct snd_soc_card *card, int event)
 
 	snd_soc_dapm_mutex_assert_held(card);
 
-	trace_snd_soc_dapm_start(card);
+	trace_snd_soc_dapm_start(card, event);
 
 	for_each_card_dapms(card, d) {
 		if (dapm_idle_bias_off(d))
@@ -2088,7 +2088,7 @@ static int dapm_power_widgets(struct snd_soc_card *card, int event)
 		"DAPM sequencing finished, waiting %dms\n", card->pop_time);
 	pop_wait(card->pop_time);
 
-	trace_snd_soc_dapm_done(card);
+	trace_snd_soc_dapm_done(card, event);
 
 	return 0;
 }

-- 
2.34.1


