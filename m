Return-Path: <linux-kernel+bounces-104332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED1687CC41
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A2C1F21E37
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE81D1B7E3;
	Fri, 15 Mar 2024 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Hbu9H1td"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4922A18EB3;
	Fri, 15 Mar 2024 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502079; cv=none; b=jFV3cjDPikd8eZ4RvuZVNrogRPoT2ecimnG79KiNM96OzgYns4TxMtDi8sgjuFK6Xu2P4J5Ek0STK0fveBfoDiksl/NzisYMCi0g3G2o/4qp3TNZAJeCyGxNir5hUVuvdPVlWWg/vAQ86gf/54ZUsHA5eWQxGgILmBwBD8RfUUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502079; c=relaxed/simple;
	bh=cMBm2ZUDvv/FeHjU9MT1L6ylkEfHxwGT+Fdb6DMTg3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ShFP/CAw/L0qYj7Gcl6nkoOKnSuakTDe8r+xc8bGI94/LBqA8/GlNdIikAhGVDNqpPKEQ323IzYK4gCrXrWaNSK8HGpD+GlUs1XEWBOSz1dhtng9REQtYhojQKD/cwWS5w572SPfSnbEhj8yz3Shjxjhq0N1jRGPDPlrGaw5+L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Hbu9H1td; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 218EDE0004;
	Fri, 15 Mar 2024 11:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710502074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yKwrXtvxj8TEZrcKF8i8hnVKSrTEOPd44rgLaggpYn8=;
	b=Hbu9H1tdUnGCCxaS50Hbpsn1zVwsI8XeVjXTg81w6ZplrhN1WxMKpPRos8LILwVed0L63B
	PiW4Zy8L6nEbXD0+3psh3ELfndG3HbMMd/c2hzFfAcbSTDg0BpjNddu7dBxFqP8Hv6gxCL
	7x4t8xFtmvjwsYrZxLiuBwtxC1fg7lFCv/CF6/7kuoynStldNWHo9EYaZibQSZiGbDpcuJ
	y5CaZDVJqaVhSqV4Tdj2L6iIYrir+5froFdjZQ56Ue3zxIylI0vla324frDvmOjFNo8AEH
	QVJTO/rxL7cFSxlqOoNcyfx1GOu+ZNJWDWbk+pSsLQaAVHysLIr5BrNT1KuKNA==
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
Subject: [PATCH 00/13] ASoC: ti: davinci-i2s: Add features to McBSP driver
Date: Fri, 15 Mar 2024 12:27:32 +0100
Message-ID: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.43.2
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
Add optional properties in DT:
 - ti,enable-sync-err  : Enable the detection of unexpected frame pulses
 - ti,disable-free-run : Disable the free-running mode where McBSP drives
                         serial clocks during emulation halt
 - ti,drive-dx 	       : Outputs a chosen pattern on DX pin during
                         capture streams.

This has been tested on a platform designed off of the DAVINCI/OMAP-L138
connected to 3 daisy-chained AD7767. An external clock drives the
sample rate generator through the CLKS pin.
The hardware I have only allowed me to test acquisition side of McBSP.
It is connected to a 6 channels TDM and acts as Bit clock provider and
Frame clock consumer.

Bastien Curutchet (13):
  ASoC: dt-bindings: davinci-mcbsp: convert McBSP bindings to yaml
    schema
  ASoC: dt-bindings: davinci-mcbsp: Add new properties
  ASoC: ti: davinci-i2s: Remove the unused clk_input_pin attribute
  ASoC: ti: davinci-i2s: Replace dev_err with dev_err_probe
  ASoC: ti: davinci-i2s: Use external clock to drive sample rate
    generator
  ASoC: ti: davinci-i2s: Delete unnecessary assignment
  ASoC: ti: davinci-i2s: Add TDM support
  ASoC: ti: davinci-i2s: Add handling of BP_FC format
  ASoC: ti: davinci-i2s: Enable unexpected frame pulses detection
  ASoC: ti: davinci-i2s: Make free-running mode optional
  ASoC: ti: davinci-i2s: Add S24_LE to supported formats
  ASoC: dt-bindings: davinic-mcbsp: Add the 'ti,drive-dx' property
  ASoC: ti: davinci-i2s: Opitonally drive DX pin during capture streams

 .../bindings/sound/davinci-mcbsp.txt          |  50 ---
 .../bindings/sound/davinci-mcbsp.yaml         | 119 +++++++
 include/linux/platform_data/davinci_asp.h     |  15 -
 sound/soc/ti/davinci-i2s.c                    | 333 ++++++++++++++----
 4 files changed, 376 insertions(+), 141 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
 create mode 100644 Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml

-- 
2.43.2


