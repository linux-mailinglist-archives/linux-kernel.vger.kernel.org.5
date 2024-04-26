Return-Path: <linux-kernel+bounces-160418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F300A8B3D51
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F9BC1C23DE2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E54615B57B;
	Fri, 26 Apr 2024 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U5jR77Qx"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E792B9DB;
	Fri, 26 Apr 2024 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150610; cv=none; b=oJW+hrNewg6jgilRKSgGYP2l3WBKbqRXYRvCNGcXpAWJLynuPb0TVKhh8Cj58rDPYuXsMclh2OwoFcMr1EV0h+MR8LLrHFKx2En0+CiUupq5fvHGu8X14CNMGIDhrFdVJ3wOgjjNNtDZtGf6VBhD2CBhlLH3vHoiXOyo00OgoOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150610; c=relaxed/simple;
	bh=ctBHqodqZgGGTSswC9O8hy6U/QfUzuq3luFOBHlspG8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Yd37dlnugW4sAL5UbsqTruX3LMjZMTqWgfkngwjvQcqtpDWanjKuJ8RCMEwP6VzVumw450hMMRGRliRl2D/u7wAMwgCtG6QVas+KGhjzE8P6O92I/6U3BPA5byZtaOa4Hj5W02vRmJjNq4MffT1KkRG6vbo/4lNhDiasIv8DBZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U5jR77Qx; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 09022FF806;
	Fri, 26 Apr 2024 16:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714150605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8I2iXWuHxUfNdCHc6ywXlDR+bk9FdGJkwhwlgVB1g9o=;
	b=U5jR77Qx90zrGk3o30kM4OBvVWpiFOhpZXN7L+QJZ/BJdxxuJo3CEMkkxsCUk5L+iQP5LT
	tEbofImG8j/FfqsPm1HEU6IDfQYGGJfEN6hK1/GZEOZ1Fkie83xvKwLP6AzWXB+u9yi70c
	TBQnJ4K6TzRQf4y7R0m/Jw8OXTm4Fedp+nd0SRYmM+MUxZ4L9jRoWUaAoDWP2rsM/kR8sQ
	1KIsHqd/NU6J6JlSoZa+PsDx5fAZvgeRswZGmPXA/BSmumm8re5FJIYKtI4Q2kWfX28ZPE
	eu7eqkwjYHCdVRkrpjDqxiATmq7+Qu/3YxuoB1iMz6WCGNuZKNGaGpVHgEkYnQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v2 00/12] ASoC: doc: dapm: various improvements
Date: Fri, 26 Apr 2024 18:56:33 +0200
Message-Id: <20240426-dapm-docs-v2-0-87b07547eb5b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMHcK2YC/03MSw6CMBSF4a2QO7aGW3kUR+7DMOhTbiKUtKTRk
 O7dihOH/8nJt0O0gWyEa7VDsIki+aUEP1WgJ7k8LCNTGnjNm/qCLTNynZnxOrJ+UKZFx7veKCj
 /NVhHr8O6j6UnipsP74NO+F1/SoPdn5KQ1UwKFIYLHJTrbsr77UnLWfsZxpzzB2aOiIykAAAA
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

This series applies various improvements to the DAPM documentation: a
rewrite of a few sections for clarity, style improvements and typo fixes.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v2:
- avoid wrapping in patch 3 as suggested by Alex
- Link to v1: https://lore.kernel.org/r/20240416-dapm-docs-v1-0-a818d2819bf6@bootlin.com

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
 Documentation/sound/soc/dapm.rst       | 174 ++++++++++-----
 2 files changed, 492 insertions(+), 57 deletions(-)
---
base-commit: c942a0cd3603e34dd2d7237e064d9318cb7f9654
change-id: 20240315-dapm-docs-79bd51f267db

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


