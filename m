Return-Path: <linux-kernel+bounces-160420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D3E8B3D54
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DE4EB21780
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33EC168B12;
	Fri, 26 Apr 2024 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VwDPhQAJ"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28513159585;
	Fri, 26 Apr 2024 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150612; cv=none; b=a7l7S1Bhx91EhQd3yXcW11naiE1J+SKYAbAx1cbKgixiDI2RkpnxeAijzONSI4oZ7FgAVNqqvQU3xQxdMB0y582Z5lyPv37Uv0+YCvrCXpcg4oF4f/dDVPln6iLkegfmq5FaBKXGTFt21FH4rc+NSJiTN0Vx3LPP+Eb8KnygQmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150612; c=relaxed/simple;
	bh=YsqwMeqwdDsJ998lyOSvKG5ryC2QIwVYJgZEoDxKO9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZEyooE3xxsu0tPBvpug71L71eSG6szO2IjHkXzNNmYn32lRfsUYCYhPRnTPXGT6xpzfVH34pzcX9uMCQ4zF/0XF3UJPiNCyjPaSHCz6giBLAoEKjOWV0k9v+fu7gaEQ3AsASYfqP6Vcoz7QLKVGKGlcxrgSFFlwjuho5LfUyP8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VwDPhQAJ; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 66482FF80A;
	Fri, 26 Apr 2024 16:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714150608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zaY0JG+JOkRcg/2G1AMAYAPG5tJyZY3wQkGIRlf2fd8=;
	b=VwDPhQAJhNUZ3L//VkgfksMsoW3ToDWgZzlmIe31k/m58a6xlCW6GDPAcGlG0B1zV7iUVP
	uyHBSBVxfO6zBQk/J0CsJg2C1RXqV7Te1bpF1k3W4Ak8WuYIAWSS1ONXo+ujfmQzJ9kOYk
	VJ0GWx/qPQSAzifTeMq6iSVfsQVoHGNkscUn2kdRkpihmOIyDdqHErcLrFq9pnEfQvFDmG
	PA8MKjPp8vsSQOwFkziNv72IC5u6gV7qrB9GpZaNk+Rwqw6J1yRlo3SaB4JSG9qdU8/BEU
	9hSXrn4gZOYkJACVB3nIhjanR+eBavaavdGliws8PWofY6oeMvmQCBITFci1Gg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 26 Apr 2024 18:56:36 +0200
Subject: [PATCH v2 03/12] ASoC: doc: dapm: minor rewording
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-dapm-docs-v2-3-87b07547eb5b@bootlin.com>
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

Slightly reword for better readability: replace "PM" -> "power management
frameworks", add missing comma.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changed in v2:
 - don't rewrap the whole paragraph (no change to the actual patch content)
---
 Documentation/sound/soc/dapm.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/dapm.rst
index 68ef79f539f2..479c010d2dac 100644
--- a/Documentation/sound/soc/dapm.rst
+++ b/Documentation/sound/soc/dapm.rst
@@ -7,8 +7,8 @@ Description
 
 Dynamic Audio Power Management (DAPM) is designed to allow portable
 Linux devices to use the minimum amount of power within the audio
-subsystem at all times. It is independent of other kernel PM and as
-such, can easily co-exist with the other PM systems.
+subsystem at all times. It is independent of other kernel power
+management frameworks and, as such, can easily co-exist with them.
 
 DAPM is also completely transparent to all user space applications as
 all power switching is done within the ASoC core. No code changes or

-- 
2.34.1


