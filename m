Return-Path: <linux-kernel+bounces-127478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB65F894C4B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BA25B231AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C60938FBC;
	Tue,  2 Apr 2024 07:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="au69z9Y6"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8644A33986;
	Tue,  2 Apr 2024 07:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712041942; cv=none; b=AppFGrKqbSQ55uXprDlHYE6MjhluuOqT6y6CyrUBlSVJbKgq30g7uLnh7GUy/5epXoHxtUcT84ZZIVtFrnjWVY8Dv6kGazj6aPEurq2qZ+9E9OlV57enYjVNDOWdnkhNWskGAqVl47ntDkIak/KZAW6LokuLpsypa26gVAyQ0Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712041942; c=relaxed/simple;
	bh=gnN1OFzfMxXZfteMTSEnGZcF0OZvn9mUEoCB/FFpj2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ciEyjs/tep3aAvcpcnCqCDzp5Wm2Dg/c5FypLUIehU9lNCEfYkqyRvlOr4xeKKGE96a++abqVZ8llM8uK9Y4A78TAyeKEEvwLYTkOs8CCRN9ElZbNQiIR+nHgY3Mgh7Y48w/3OWIneDF88oB7eBvWq2tb9SYwlcsgYkKzSDVfKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=au69z9Y6; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 7D5B5FF80E;
	Tue,  2 Apr 2024 07:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712041936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kARtlCjFgsJx0pk6MzW4A6BY9yAEH50g5G4smmC1pek=;
	b=au69z9Y66SligpnfmD2db2hx0MbLDw5fB/g9PaFjj8OC6rnW5KltB61OVv5J+eEhyGZ0gv
	XLPDnZjGNRnYyNwNA5EqJRWKjYIRUrOh+bNqSOQHtxSkAI1bTlHXmkYe1wPtmB73QrxRxw
	J63Naei3IRdxm9vwYFWXSsiNuGhWa1dB3H00KU88xRiySZOmaaGDnd0HkkmFndOazFAnnc
	aXv6sO+daTgFbHyJD5Ybz1Mo+vQdnxNVEOc3JuysuIzD/t+HMY7dDD5CvXPCpHGbLqjdLy
	5Tv/5EX0cVcIriuxt3FowrOdMvvfalknKwlkvl3Rcvd/5qcARv3MCz4BdZLHQQ==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
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
Subject: [PATCH v2 00/13] ASoC: ti: davinci-i2s: Add features to McBSP driver
Date: Tue,  2 Apr 2024 09:12:00 +0200
Message-ID: <20240402071213.11671-1-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

This series aims to add some features to McBSP driver.

Convert bindings from .txt to .yaml.
Add possibility to use an external clock as sample rate generator's
input.
Add handling of new formats (TDM, S24_LE, BP_FC).
Enable the detection of unexpected frame pulses.
Set the clock free-running mode according to SND_SOC_DAIFMT_[GATED/CONT]
configuration in DAI format.
Add ti,T1-framing[tx/rx] properties in DT. They allow to set the data
delay to two bit-clock periods.

This has been tested on a platform designed off of the DAVINCI/OMAP-L138
connected to 3 daisy-chained AD7767. An external clock drives the
sample rate generator through the CLKS pin.
The hardware I have only allowed me to test acquisition side of McBSP.
It is connected to a 6 channels TDM and acts as Bit clock provider and
Frame clock consumer.

Change log v1 -> v2:
  PATCH 1 (bindings):
     * Drop power-domains property's description
     * Drop the unused label 'mcbsp0' in example
     * Add <> around each entry of the 'dmas' property
     * Add 'Reviewed-by: Rob Herring <robh@kernel.org>'
  PATCH 2 (bindings):
     * Drop the 'ti,enable-sync-err' flag
     * Drop the 'ti,disable-free-run' flag
     * Add 'Reviewed-by: Rob Herring <robh@kernel.org>'
  PATCH 4:
     * In probe() use dev_err for fixed error
  PATCH 7 (TDM):
     * set playback.max_channels to 128
     * Add a check on tx_mask as the one done for rx_mask
     * Allow TDM with BP_FP format
  PATCH 9:
     * Detection of unexpected frame pulses is enabled by default
  PATCH 10:
     * Free-running mode is selected by the DAI format through
       SND_SOC_DAIFMT_[CONT/GATED]
  PATCH 12:
     * drop the 'ti,drive-dx' property
     * add 'ti,T1-framing-[rx/tx]' properties
  PATCH 13:
     * Drop the drive_dx part
     * Add support for 'T1 framing' with data delay set to 2 bit-clock
       periods
Bastien Curutchet (13):
  ASoC: dt-bindings: davinci-mcbsp: convert McBSP bindings to yaml
    schema
  ASoC: dt-bindings: davinci-mcbsp: Add optional clock
  ASoC: ti: davinci-i2s: Remove the unused clk_input_pin attribute
  ASoC: ti: davinci-i2s: Replace dev_err with dev_err_probe
  ASoC: ti: davinci-i2s: Use external clock to drive sample rate
    generator
  ASoC: ti: davinci-i2s: Delete unnecessary assignment
  ASoC: ti: davinci-i2s: Add TDM support
  ASoC: ti: davinci-i2s: Add handling of BP_FC format
  ASoC: ti: davinci-i2s: Enable unexpected frame pulses detection
  ASoC: ti: davinci-i2s: Link free-run mode to
    SND_SOC_DAIFMT_[GATED/CONT]
  ASoC: ti: davinci-i2s: Add S24_LE to supported formats
  ASoC: dt-bindings: davinci-mcbsp: Add the 'ti,T1-framing-{rx/tx}'
    flags
  ASoC: ti: davinci-i2s: Add T1 framing support

 .../bindings/sound/davinci-mcbsp.txt          |  50 ----
 .../bindings/sound/davinci-mcbsp.yaml         | 113 +++++++
 include/linux/platform_data/davinci_asp.h     |  15 -
 sound/soc/ti/davinci-i2s.c                    | 278 ++++++++++++++----
 4 files changed, 333 insertions(+), 123 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
 create mode 100644 Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml

-- 
2.44.0


