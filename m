Return-Path: <linux-kernel+bounces-104334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 429BA87CC45
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90221F21FA9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252071BC26;
	Fri, 15 Mar 2024 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ohc8rMAZ"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3504F1B597;
	Fri, 15 Mar 2024 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502081; cv=none; b=D5eqODBrUl41vwO8I7MCu+qBRIUYkv2sdjYZhAuk12S5CWM48wwVAysg3bMHImhE2tW5JVQGBx6dLZBW2ObBHz53boiKiKeB+dlgit6VhKMsE6ckeACM9KKkq7CcvWguNIqfkqu5ZMWfwfHEx7iDSSYqVsszJU1AyzNjE/ROshg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502081; c=relaxed/simple;
	bh=Vqa6QA158MoJJhfEt2Iy0wh9/kNKE3uYlMHDc5V99h4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xrfc8FMFW4y+nPtC5I7UnWuXarkJCMddFIWQNYdJ6KylqMbMnsBRg2S3stLDfZumoddnt6kISh4hHsMWEMWrxAt1reh7kDm/6eg8k4TepUflNDUPggiscXCw3xYrR3dvqi3Oouh28EpLU9eFPxGSKN/k5TaVPKxIThzKOCWGwnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ohc8rMAZ; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id B465DE0005;
	Fri, 15 Mar 2024 11:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710502077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R6wAImaMrQQgDt9yLO+ckEgLXUzk4/YE6uy/Vm+UgWI=;
	b=Ohc8rMAZZQx0N2dF+PKKTV4O9wDsMc5dVw6E/m4mHYRavO52U//ZROTrJgthdMmQqkJKQZ
	4YTOOU1vpC8MGeWcaFJmfQIfoiZrBvrsYPFA2ZJ6D5PsIuVPDZ85dKj0KR8tI2ZtpCh4vv
	5IW2+I4vm30iSb1BZDnRu6boyg2It16Ebims7bIzVmx9uW60OohG3Wad2WEn99v5cpKNR4
	ePZkxJlQomAPo4tckYT8XnDBRir76ecEKH9m3Lli6ivMlVGcYWIgB1JIFC2BGjp9tkFNHj
	kjrZHgd3IPs51zP3/tFI5lbTx1RZ1JyZ4NHzG0c9Ht/g++MAnlE07DbYYRYazA==
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
Subject: [PATCH 02/13] ASoC: dt-bindings: davinci-mcbsp: Add new properties
Date: Fri, 15 Mar 2024 12:27:34 +0100
Message-ID: <20240315112745.63230-3-bastien.curutchet@bootlin.com>
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

Following features are not described in the bindings:
 - The McBSP uses an internal sample rate generator to provide bit clock
   or frame clock. This sample rate generator can be programmed to be
   driven by McBSP's internal clock source or by an external clock source
   (located on CLKS pin).
 - McBSP can be configured in 'free-running' mode so that its serial
   clocks will continue to run during emulation halt.
 - McBSP can generate a SYNCERR when unexpected frame pulses are detected

Add an optional clock item that allows to select an external clock as
sample rate generator's input.

Add a 'ti,disable-free-run' flag to disable the free-running mode. This
mode is selected by default by the driver that's why I add a disabling
flag instead of an enabling one.

Add a 'ti,enable-sync-err' flag to enable SYNCERR generation when
unexpected frame pulses are detected.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 .../devicetree/bindings/sound/davinci-mcbsp.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml b/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml
index 8b0e9b5da08f..d8d4e7ea6e02 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml
+++ b/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml
@@ -50,12 +50,16 @@ properties:
       - const: tx
 
   clocks:
+    minItems: 1
     items:
       - description: functional clock
+      - description: external input clock for sample rate generator.
 
   clock-names:
+    minItems: 1
     items:
       - const: fck
+      - const: clks
 
   power-domains:
     description: phandle to the corresponding power-domain
@@ -64,6 +68,18 @@ properties:
   "#sound-dai-cells":
     const: 0
 
+  ti,disable-free-run:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Disable free-running mode. If not present, serial clocks continue to run
+      during emulation halt.
+
+  ti,enable-sync-err:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enable synchronisation error detections when an unexpected frame pulse is
+      received. If not present, unexpected frame pulses are ignored.
+
 required:
   - "#sound-dai-cells"
   - compatible
-- 
2.43.2


