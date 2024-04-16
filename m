Return-Path: <linux-kernel+bounces-146295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9D08A6349
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251DB1C21692
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BDF53363;
	Tue, 16 Apr 2024 05:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RAB5hRuU"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C3043AC5;
	Tue, 16 Apr 2024 05:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713246992; cv=none; b=Go2zn7Hf2NkdaM+kqI6YCmC6dedYDZksMi+Bt8wkq5V0k3R6I/j6Dn/XBeecX8GrVN8FNqB0LgvuNpElpSH/CFnyfA053OkGrHvd0DXC5VG/l8Z5HXpLfx+rRWCqGW1pF7+o2NQL4vsfErsskVTZZSCetqjYxzClDHH6pTd/dac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713246992; c=relaxed/simple;
	bh=o1+BbMEAnndRJzN+2AGSS8a1mhi8hNTsayce2MzKW0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lwjVOc9O+w8RQgb/wF5SlPgRbpu7tFap2t+Zw+5g08Ke8lSxxviNkOXgDSBfR8SbHEzdME7JFxCd0+6fdOGTi+5a1QYnuP/wKREvN7EFasOiQgayOaKT9ZD7uS0668qTt4yxyfano7HgZ+kfpXW/aXoexdeaoiaRFCkPG8X7PeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RAB5hRuU; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6CFB1240005;
	Tue, 16 Apr 2024 05:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713246988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xM8NmtQy3wO27koXzOqV907oXOLGnVKvQRVLtX2MIUk=;
	b=RAB5hRuUIhnf4B1Kg6AkW3Qb79F/NtYviknZrYUHCSJoELxAUCnsZ2OvAFn9j5r9d/xilp
	CgpoCPXJM7TOBbrlJNuFIhMJvH7hBXHL15Uk/ooxanIH4qI4sEaOyErQ6zjnyu+hCYiUvU
	PXAgUXxGV1DYfTGYsPwQkWJeIJqDHxD7u+ov8Ak8PROHjvbAGt4c590w/xHuOpK7jWFnhv
	bWz53xHN9xFYlXY6afwfD3Fy3vpZY/mNcycxV237TXuItZuPgJlOhxXAfWZy7foTbc5FxE
	+ENl6vhT3lsCGN8FHW79V9DurC+hEhVfrQKrAH1IquMA3k2z5LHuXU/JbN8X/g==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 16 Apr 2024 07:56:09 +0200
Subject: [PATCH 03/12] ASoC: doc: dapm: minor rewording
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-dapm-docs-v1-3-a818d2819bf6@bootlin.com>
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

Slightly reword for better readability: replace "PM" -> "power management
frameworks", add missing comma.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 Documentation/sound/soc/dapm.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/dapm.rst
index 68ef79f539f2..4dfa60519a76 100644
--- a/Documentation/sound/soc/dapm.rst
+++ b/Documentation/sound/soc/dapm.rst
@@ -5,10 +5,10 @@ Dynamic Audio Power Management for Portable Devices
 Description
 ===========
 
-Dynamic Audio Power Management (DAPM) is designed to allow portable
-Linux devices to use the minimum amount of power within the audio
-subsystem at all times. It is independent of other kernel PM and as
-such, can easily co-exist with the other PM systems.
+Dynamic Audio Power Management (DAPM) is designed to allow portable Linux
+devices to use the minimum amount of power within the audio subsystem at
+all times. It is independent of other kernel power management frameworks
+and, as such, can easily co-exist with them.
 
 DAPM is also completely transparent to all user space applications as
 all power switching is done within the ASoC core. No code changes or

-- 
2.34.1


