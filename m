Return-Path: <linux-kernel+bounces-90833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 303B087058A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C482E1F25BA6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91942548F4;
	Mon,  4 Mar 2024 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Xk4J9VU+"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076B8535DF
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709566176; cv=none; b=YdA/0/zvFNcarAPZRZLfBJdhNjpgMdx4/tKJHOTXXIhFLB46xWUWvb+JMeW8NzdpzYDdMcuH4NM0CQJ6FlotV74ugfyNBBSLFJyuYhqkPeJxiIcTdCjmSglD/MMS6pAXTsyLqW5sJfq1alOaUD7oo5euogjitBRm6flI1DblrPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709566176; c=relaxed/simple;
	bh=WDAxkhzjtawKA8ibJoFIkQ/DkTdgQXrpylNOsCS8bTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DhiEiNa6xZ/ud7N3PUsACRByP8AFw9zXPEvte4UlPdwLAPPPb3xX614M7J2l5POOveLtThthBm9u0KyH2ljrr1nHuxtzjDhciKnOh5tjd2bNpAaFLJmmDbDsNj8Z2hoOQ4gfdqasPppz30hOIUsDWWzBY/Ujqx/nElSj5IliCZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Xk4J9VU+; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 551711C0004;
	Mon,  4 Mar 2024 15:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709566173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1mJQirOrh5uVlCQFN4AJsimww+6ayqe/xDiVoFk4V7I=;
	b=Xk4J9VU+pc7nMsKkFc0PCYSd0Uqy9K3tIKHRaV9ewrg7Rd/qEqHMCcMAqJwVa0TJrQBvHv
	O5qS1eBGut0j3WSf/UTmr2wj14SPT7Jk1i9VTvjeXtBhWTFwMtBJUUui+IO5qK8pka6HtC
	6GDy5CUmLD38yQeF0vBcmShM00uM7kyvIs+wOg3HcntYmxLo/PhTQzpIF0AWBtJF7vRJ54
	uwnFE6i2rnLbj7o18pUl2Aue6N9hK5xhibJygd1Mbvyr14QIvUaWl5w1pD+V1zARik6sjZ
	JhvS3EZZfOmfZJVWdYs0+sN2wwV+ngs7RvKww2OeuXT5NoHCETjIlsXcQWS7VA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 04 Mar 2024 16:28:18 +0100
Subject: [PATCH v4 13/14] drm/vkms: Drop YUV formats TODO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-yuv-v4-13-76beac8e9793@bootlin.com>
References: <20240304-yuv-v4-0-76beac8e9793@bootlin.com>
In-Reply-To: <20240304-yuv-v4-0-76beac8e9793@bootlin.com>
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
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBl5ejN9NMOsH5mc7MJuPKBhjpy8/A2Pbt9HDaq6Wzi
 tKnejwmJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZeXozQAKCRAgrS7GWxAs4pO2D/
 96UYBmCNnqyEt/7G+7haOSQC/qglT/fzK77FF2xMd0MYFlrW8XGXuE9aq1Rj2QiCC4jTgVb597PaUU
 lkvUu4GKnfyBePKMCOEngZOWsW9duc0+Cqm6G/b9AoRAbQZQEU9t0Eb2XGk4LbcLfeadUdTAIan36B
 gKqFdJOFuNpJJog6MKfDjQxe0JzdVyiABSvwxCq6AfYO2HILZS2yqKcIA6ZdtgIYdm7mDvWhihtdyI
 gn3YmeNO1qTV9YKKI8b9BodFr3oe7KBAR1cwWNJD1E/8hQRzZWqmImfPWHyxBSHqt3tYgqasjMs+4X
 6sGev7z6CmlaP2gVNcPvMPHj7ksawgVJ1dpwTakCGwDH32ayeoMC4wHlSo5XF4Xjp0MpS7sb3pFFPa
 5moafTrnNTvxUGBDM04aLF8cqjwwhbjYaj20Acg9eQU0soFYDClKAqu9mfZpwd+7FtGqdummT+NkLE
 Je5GrodyuEztOMlaffvVuLENBoTEmhsNGOBp41iYqbE9zPcJ9MS1DJ0rvImgv3muTMni6WluE/PMlA
 G8Bw1xFBMfuGUHaUOHV9acOEFsaJHM8tm5cL9Q4euG1jakI5E5R1TGgetTVjgXpB5j3mQ2Pf3RF6JT
 4y6m5UCHAePgspKzh99ycSK6R0PB6JMHAPZmQZsfluAKQ4CQBGiqKPHchDzw==
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


