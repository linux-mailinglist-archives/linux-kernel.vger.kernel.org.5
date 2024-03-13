Return-Path: <linux-kernel+bounces-102308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BBC87B04C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8471C25F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29220135A7D;
	Wed, 13 Mar 2024 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="C17aOn2S"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A863B67A04
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351943; cv=none; b=YEWYPIjWNO1W7lFZ0Dr8GBJ75hKxKGTs9xCWLthWIfTrSCF7lA0RJ47vGF2jk376IbxOJFb3rKus1+6+UBPn9Ew1t+2wohKw4OT4SLVNmX6kZE8BNB8HjBcGMTFLgsjhYtzlIIGfA9kvs61MpBhDNXujP1xKa+twMLGnCP3nls4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351943; c=relaxed/simple;
	bh=WDAxkhzjtawKA8ibJoFIkQ/DkTdgQXrpylNOsCS8bTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cTuLuxyTxc9P9ilsgZ0GYigjImy9kOyjg3waxbBX1b2iMhJ6LC7fsmk1SQC91ndGd0hwKL3z85uc7NNMIE81ds8IB+XDRp/y9zbDCzWxn1tvfZZF3yBzzwbY8iDYsm9QWv0IF1GyEL0mQQU2f3q9T8ZjYLydqtkSPO+TJvgjYKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=C17aOn2S; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 548B340003;
	Wed, 13 Mar 2024 17:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710351940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1mJQirOrh5uVlCQFN4AJsimww+6ayqe/xDiVoFk4V7I=;
	b=C17aOn2SwmfUwqtxzCrK39wG/2jjP8yjS1HTKUdVG5VwmS+QkJF9R8k4HP12CqqtPLC+H9
	CnKpdEbM61q9WcVM8hy4au9Dn+qTR3wYiU6iwf2sq78tD1zR5WTPgJLGCaM5YArxQdRI9x
	CLhRRu/IJwQD3DarkM9mEYk7KvCHFR07MpTYl3sC7maz7LslCsoCDX2qvWSHIvw8wVxUJ0
	uJpiHJNgvtxbvgHYv5cI3mIRcsMXdRCL1gawcGjCWUima1VA0snk4i8JNf6tHnY8Gw0o3a
	nd3bDDNAxtF45pc3t2fw8c/b7xZF2cVc8N6yZT2Hj9OXdGuGHPsd6KKPku9CDQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 13 Mar 2024 18:45:07 +0100
Subject: [PATCH v5 13/16] drm/vkms: Drop YUV formats TODO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240313-yuv-v5-13-e610cbd03f52@bootlin.com>
References: <20240313-yuv-v5-0-e610cbd03f52@bootlin.com>
In-Reply-To: <20240313-yuv-v5-0-e610cbd03f52@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, arthurgrillo@riseup.net, 
 Jonathan Corbet <corbet@lwn.net>, pekka.paalanen@haloniitty.fi
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com, 
 nicolejadeyee@google.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=881;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=cRkkP1b8eceTuEm0QTSGTTTnDinaYzDjRJLok06bIiI=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBl8eY0+z3WAhCy2IMeG8a1Zkre9wnYeZj8SIIpx9sY
 HczWmz6JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZfHmNAAKCRAgrS7GWxAs4jW4D/
 4qAo1dZm2a0nRqQiHL6nTT0z4G5R7SoJRefwwbIQ9oLn/87s7B7lyyvNnZ5twDZHPD7NMALtU2x3R9
 hOyeInWO1ZcOa6ilo8NZjAZE2wUBkM8X1hDd0G4rV7cGNzxr6YvLNKm+sY7w3QZzQNuXOXmPc9k2z2
 50WEb8f/NnXGZfg9lfTsyAxoAe5mgnPrarHmMNTGO0ji1z8tj5xY96Az9fTx68JH8lgFJ2zk4n7N3l
 Je0bDoz0U63X4Ir7MVm1QohDt6+GiKU+brYD20ldmdYd3AtOl2W0h59ExJi3CdfNm0DO2+uZkHUkDV
 l3ooPA7SqZ1D+//2ahX0s1e+5p0Lhhd5yomiOuaaFslehGHLXN/tqPi4j0xA8GWmOH/jLERJ3IP+Ie
 7AZqUU3WUWIDliNwzqknwAKhhTHH2LaZOCUqArJBcZm4qWeghPZyGo5hAiFo3JCXg1ZBzdVE3yrgaQ
 sjxKUYvrHokeUUl9SlyMtNuJG3rcxH9iC9CaviRM9PCno3Egx3DGWw/AkE+nIAtCkIMjz5wSRkX0Xg
 aFH+3A23XZL+QIOC9kGmEsNrAEMR1FzKmvCyz0X2IO0i/hJO+bd67hexUth/y+Qb0jGzjtXL+cLEEI
 NjqwSNlAtd+XEQQYtS0BsuNjXjXCIMH0xUG3cPOjtPYzOZgtmPAnnnoPYjQw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

From: Arthur Grillo <arthurgrillo@riseup.net>

VKMS has support for YUV formats now. Remove the task from the TODO
list.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/gpu/vkms.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index ba04ac7c2167..13b866c3617c 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -122,8 +122,7 @@ There's lots of plane features we could add support for:
 
 - Scaling.
 
-- Additional buffer formats, especially YUV formats for video like NV12.
-  Low/high bpp RGB formats would also be interesting.
+- Additional buffer formats. Low/high bpp RGB formats would be interesting.
 
 - Async updates (currently only possible on cursor plane using the legacy
   cursor api).

-- 
2.43.0


