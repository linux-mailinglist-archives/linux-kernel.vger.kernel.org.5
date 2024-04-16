Return-Path: <linux-kernel+bounces-146292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA878A6343
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158E21C20B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12F83BBC9;
	Tue, 16 Apr 2024 05:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dMAFCz0X"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419D61FA1;
	Tue, 16 Apr 2024 05:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713246984; cv=none; b=FxoTEI8MdhP5aY9kbFMACVYCV7XGAJzdgVnuuIzscZFSi8EtTl3p9nyGxEHS9sRbxpyndaG0dL7AV3kWEUdBFpHkwH2j/LL/1vYd+/yO0mfWhFbuS1FGoQzTGfIKAf1sIzrnB6kwHoVmOUSDxq5+goKZMHQi6dLn/4CipWI+um8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713246984; c=relaxed/simple;
	bh=G81PiCaYxRMH5Yr1uK64EHf3fyvJO8LewC0bgtkT7gA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Gwgr7IGz8jMHEqzAAgHmuSmI72XfQnL4rZZGNFtcoxjCyaoH7U1w6ESXIu7eG8iIDuErJNhlor8ZGfoR/qPHErxV0VNmQBjnJegb/Chk+WDyDwjoruBVjodeYDVaxfoc2jM1mXvTiFUy6xyKVAFojvhzlO5QFASFqR1CVxzJl2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dMAFCz0X; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DA68E240003;
	Tue, 16 Apr 2024 05:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713246974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MYsxM8sUexu5PeidcDFg7wtBhZutdc0P4xRrT0as04E=;
	b=dMAFCz0XbNW8H5WJkyypAbjWjYkpXoJmGx9BlOkCQi4Atd1BkaeH7CtcBL+of1PNSbw3SA
	Z57stfHKQgbfhoAo0RMgdWJTOdg5Nixb1JyDA3a9wiQxWwFPjzWl4TTihw6SU5Et7TSf4x
	hNHpmp49CNMdWoUgrlbnVhEqthc4fEDrFCPpsKqDYIqLFZ5rP7MDZ/i+hBnpAB8wUyXxce
	6gJaejS97CvHBs+sToD+UE8P++rSP3+3OGqw78s0423WBGPVue2yY/JTbs5OK7/AOLIyvD
	ugK2brVD00iP4z3lgpvKslQcqIONw+W8VFHHBY0qJJiMo0uBaYeXdMMbLhVWSQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 00/12] ASoC: doc: dapm: various improvements
Date: Tue, 16 Apr 2024 07:56:06 +0200
Message-Id: <20240416-dapm-docs-v1-0-a818d2819bf6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPYSHmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0NT3ZTEglzdlPzkYl1zy6QUU8M0IzPzlCQloPqCotS0zAqwWdGxtbU
 A+qgurFsAAAA=
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-sound@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

This series applies various improvements to the DAPM documentation: a
rewrite of a few sections for clarity, style improvements and typo fixes.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (12):
      ASoC: doc: dapm: fix typos
      ASoC: doc: dapm: fix struct name
      ASoC: doc: dapm: minor rewording
      ASoC: doc: dapm: remove dash after colon
      ASoC: doc: dapm: clarify it's an internal API
      ASoC: doc: dapm: replace "map" with "graph"
      ASoC: doc: dapm: extend initial descrption
      ASoC: doc: dapm: describe how widgets and routes are registered
      ASoC: doc: dapm: fix and improve section "Registering DAPM controls"
      ASoC: doc: dapm: improve section "Codec/DSP Widget Interconnections"
      ASoC: doc: dapm: update section "DAPM Widget Events"
      ASoC: doc: dapm: update event types

 Documentation/sound/soc/dapm-graph.svg | 375 +++++++++++++++++++++++++++++++++
 Documentation/sound/soc/dapm.rst       | 178 ++++++++++------
 2 files changed, 494 insertions(+), 59 deletions(-)
---
base-commit: 8f2c057754b25075aa3da132cd4fd4478cdab854
change-id: 20240315-dapm-docs-79bd51f267db

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


