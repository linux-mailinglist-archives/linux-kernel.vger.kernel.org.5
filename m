Return-Path: <linux-kernel+bounces-146297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F368A634D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CBD91F2225E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F795DF1C;
	Tue, 16 Apr 2024 05:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="grZHN6ot"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3065BACB;
	Tue, 16 Apr 2024 05:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713247002; cv=none; b=fIFBdZ2hUwD5z904/LQeoQYID4zEPKIG3m8tkHVjcFozfqw3gOa4TssZI67YZOfcr12VfHq5xLbC74wDLpC/X3+Uzf5CdkXEO6ECDVLkrEId+Qmybx6bWJi+lK5lCEgCu+BXD3Bd62y+O7nD5xg3zyLt+otFy8bsBGjgTV/JShY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713247002; c=relaxed/simple;
	bh=/q9wubkivGEbctuzAxXEJE9bOlNQjNL2qpWg+Go76xY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oS0nUYsTHoPHaXOCQ9k4FARw5FvBun4vt5QItIm8h8K7QDKi+whFWD8jyeyFRZHeN9Q1C0DnhUvrJYzhUdZd8InmmHGcfFUeoaJoBx64ZxpI2oPKH9FlyPeH8sUEEG6V/s4UUikfU5623aNP0ynA137DaZgnV4/U4nUEIVcR4nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=grZHN6ot; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BF71D240008;
	Tue, 16 Apr 2024 05:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713246999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p1gKTZTbM5i3YvX9k1E5G0MG67ZU6ZM1oZhyfUs3KBw=;
	b=grZHN6otZdV8BZ2w2M9XxruzuXiGs8WriPq9tTCjr2I1vdJA1K0sYa85xkF3tA84pc2HdS
	QbzsVQ+NOi0ardeCRxbmqHnNA7WHkWqr+1KmVxsAkTz8AaYBJgL+QVKZYJgi6n4VXb7rHl
	vs2cGfCd7yo6Z6EHULsEoFRpXgGgDGdqHOCA8vh+j/A/CJe/0Yn9X6VMsnwT2XpyphSc6D
	Vzzd882SIXLOGeFZ0sOjAxpagCjbi8vAkCDDGjrPiECnLlk9dsLC536R+Jp1RcdYEDHhDG
	6OQLNy365ivTXAhJ8z08g4jrYFvALOWJVT4OjfcXrTrE7I+IDl9AP5hUH/A+8w==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 16 Apr 2024 07:56:11 +0200
Subject: [PATCH 05/12] ASoC: doc: dapm: clarify it's an internal API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-dapm-docs-v1-5-a818d2819bf6@bootlin.com>
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

Clarify DAPM does not expose any API to user space, and adapt the paragraph
accordingly.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 Documentation/sound/soc/dapm.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/dapm.rst
index e3b399201622..4200bcf18fcd 100644
--- a/Documentation/sound/soc/dapm.rst
+++ b/Documentation/sound/soc/dapm.rst
@@ -11,9 +11,10 @@ all times. It is independent of other kernel power management frameworks
 and, as such, can easily co-exist with them.
 
 DAPM is also completely transparent to all user space applications as
-all power switching is done within the ASoC core. No code changes or
-recompiling are required for user space applications. DAPM makes power
-switching decisions based upon any audio stream (capture/playback)
+all power switching is done internally to the ASoC core. For this reason
+DAPM does not expose a kernel API to user space and no code changes or
+recompiling are required for user space applications to use it. DAPM makes
+power switching decisions based upon any audio stream (capture/playback)
 activity and audio mixer settings within the device.
 
 DAPM spans the whole machine. It covers power control within the entire

-- 
2.34.1


