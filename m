Return-Path: <linux-kernel+bounces-136952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C68D89DA43
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075CF2898ED
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC2B131BDF;
	Tue,  9 Apr 2024 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WZhjgNZb"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D1A131734
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669163; cv=none; b=OzxFpOp3CPV0qQnt7Vybp+3MYyIaKGs7C06eGOz4gAq60AJ7scSh/VDH05BU49SnBOd4llsceU4VCOLDplYA6Y0b+w192gu9vcA1+DXekAXTYzoXWys6WqOp2903C3xxPtVMtTY/oA/uRJxDzrjpEzfxc4dRbREdZlebzi/RECE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669163; c=relaxed/simple;
	bh=WDAxkhzjtawKA8ibJoFIkQ/DkTdgQXrpylNOsCS8bTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GLgqHDpfBL71NVc+LaWeAYkFu6atf6BreRGgIW16mtLcI/ix+AZcInceYyuz/rpuWwewR37pFGrsJhnGPrZB7MSAPL5Ue/R5gGUImNmhKkFVRxyuA5sdEeA0W1mB5dQXQAA4LA4K7PdiPLyQG79132k5zfSa739nBWTD1FVl9gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WZhjgNZb; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2974124000D;
	Tue,  9 Apr 2024 13:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712669160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1mJQirOrh5uVlCQFN4AJsimww+6ayqe/xDiVoFk4V7I=;
	b=WZhjgNZbhe1inJQhx+kDzoapFvhfDpMn5etEIcFsZc+BmHOQNOt8sHCtRjQ+ODQrtrNQPU
	M+8/DGF9DX9qxUYDEFIx++rbYOak1jBLNvrPN88xrAY08F7lZWde9AhKZzG3eVeHgxvV3w
	GIz+ekBton2PYpdGV6VYkX3uHuqZxd+4NJGO8c3uvRMzCl2ZZIuZtyZEei4SQoXG4dfCuU
	ANqPJQ1fZBvxsrarzjgGRiy5wglhnA3OI1RWbNA8120jpwGKg5nTUIaC3tX+DKcWaNTuzS
	PXfQvfw8GHJrgeZQKiExFg2Fi83iGZXGDJA7N/bsM6cLXA5qK3SeEnV2DDeVOw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Tue, 09 Apr 2024 15:25:32 +0200
Subject: [PATCH v6 14/17] drm/vkms: Drop YUV formats TODO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-yuv-v6-14-de1c5728fd70@bootlin.com>
References: <20240409-yuv-v6-0-de1c5728fd70@bootlin.com>
In-Reply-To: <20240409-yuv-v6-0-de1c5728fd70@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, rdunlap@infradead.org, 
 arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>, 
 pekka.paalanen@haloniitty.fi
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com, 
 nicolejadeyee@google.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=881;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=cRkkP1b8eceTuEm0QTSGTTTnDinaYzDjRJLok06bIiI=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmFUHTz8zP9efvg7NCkW4Fqc9/zG18J9dEg8Olx
 ahIBysKX9OJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZhVB0wAKCRAgrS7GWxAs
 4iRKD/0a9HNXg9O6s7vJrac/m6ZXWrzNtKZ9DzL2pPgFhXr8pZzn1N0//qZ8oiQEhwnkoQ3LLJt
 kvWONGAnc1+7SLlwpINXPDmRcfAn+/aq1goLAMG0ywVwHm81x9aNpAoGsZ89qaUXbgbHjBgJxbE
 u3JUFOnhoZKN2npdgnohMch0ZjuS8tckhJBxbAZM8Awo1fJYPz/EFBND/zrT+EXXg76R4Ts6YxK
 49T8O/6a068hQHq0zeUIwR9V7aaj9y3NzoZWdp0JxtoLD7zhBskiJC3lD81zmL/EVU/2tQCS2XO
 ULT9deKVobVQuLOi8+hA1aTDuO7L1BpR+weKyHtoVn3C2+fSLf9PvMgy/YJjPGua+JZHr90I+gA
 qmUtPky1+b6MUUMeQG4UitHh6nAMw05djNlieMiFuHdxhnGuyzLrFQhukRSWpxPW/SHs+4y2Y0n
 cI1bGr+4Rp+LXVn5HzaZrF2HTBvaY/CDzxB9tCCoRY9RXtlkahdFz13wl7tquSjd+2sksG/JWZj
 59TcdyEkfDTqaln/IBjDe0oVlT+wsbfVgtUD63Crf80qnI3JMCOP55ZzfIoPb7SARywSuF6fqrW
 No5kozExrJvD1DaxBK135//iQ585PyQGdlAV0hLO+CptFOemqwi242cbl/D5uN6WbMPP9uW1RNX
 hXzb9VjU1HUN9FA==
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


