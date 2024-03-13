Return-Path: <linux-kernel+bounces-102310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED5C87B057
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B9F1C261A9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0310137C32;
	Wed, 13 Mar 2024 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bLW3cNJR"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AC167C5D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351945; cv=none; b=MSJ5XjcRf7S0cHi+N3F0QHP6yoHm6xuEihFmYu/ZrZ/48a5vn1FrSwRD+CZeKHdRKjswg6Wf6OSIsS8yKK6WbrfPWAIMj+kOfQzEa/VcKslAj+mPe6pn5D1XVDAsgPm4cytNxGjqpA9JnLFcedG3ZnBTMMI6OuRlBrxZL24CSzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351945; c=relaxed/simple;
	bh=Dap23lUACnoJxX+/EWpT/enfYH0mEU+7fwoVnAZoAcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YDpXxrhknptxzLaRafGThB6OhupxGpBiGFp5hSkUZLOsHmSTIf1qyaf2f0iaOwJVuzNbBqHYW/0lQHeeNXKYaHyn//R0FahZmMKy5qTAfXYbbeqJHLIMGvn3eo+9Dwws45SDwGXhy3151LkPWaiamFPKnb1kwrP/5cfFGQUIdcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bLW3cNJR; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2C1AD40006;
	Wed, 13 Mar 2024 17:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710351942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8vk8BNwGJAqLAVQ9fBvlyUPWgU+vNkf+DhOlg0zqa0Y=;
	b=bLW3cNJRdq9O69RxPLYwYn6gVkVh9n1OZD37GkUSiUe/lcj91kk1cnaUzNfeFuy3gc72KS
	SCvwMXpkDxQA8vedGwSz1IrrxOfEoCatKQEUzN4h3qUuihkDaLrDr6FVPk7ngF34nOeMPD
	668mmp6IiX3f+P4xsY9R987a4PQo5C7Yar2VCeqrOGz03F7zzQ1YVGFuJYupY9x599CXQf
	H+wlLImP9gysyEkJgrxDnl5ZisuYDPX5xzi9XF7RjbOLm609rj0+tzf246r9thI+cJQXVE
	qHszhokmo00bvsDSZhy/DzUliC2G1ifUZ7lSoOdJ4w628TCIzUT+dpWtzUcSNw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 13 Mar 2024 18:45:09 +0100
Subject: [PATCH v5 15/16] drm/vkms: Add how to run the Kunit tests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240313-yuv-v5-15-e610cbd03f52@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1115;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=jNe6Bg7KTpSpUer0keg/YQY7YaZCbb33mwHbW/nyqss=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBl8eY12s9vTfK6gwWnR4reCKg4IXVlpGyhmzhmWrto
 MPwKF5SJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZfHmNQAKCRAgrS7GWxAs4hTVEA
 C2PHQezur5a6ktgpKuZBu6etHWoSjMt8FaDmTTzOXNY+P6s0IYJ23vG2KymK/KwyY9llh20XM74lsm
 3BsShoiasnrBMOQhUm3R5EajOLFC+vw2h1RjuOTbVzAZCCpNOwuSMmFGDUMau/FCQRd646pUu4f0gI
 kBQCbicjKmWk0rmtdRw4694pmILamnfehF2LBsywpXOmU3nFHd6xSsqcJZv9f6/qJXqOhIRbvPKe4H
 iTM3bGLyYZjD66MSfHHgFcVyIOC24wKxWwYegNmfK4Fo+Z3EyGQ2rckh37eo4KPje1hYVY4eoj4YJd
 s1MXh7/PdhuqbcIu8gODqsriyLtOR3fm/cEtIeYl4n4Au3v4p/fHew0bZSrjYSYg5t4iCSuRNrjr6I
 Pq89f7LtAodaO6k6SAVKRXscIGdGF4psqQYs3cuElgu8p8iw+gVQG7rs141cWbD3risexzxiLtqrtg
 QtrJqC4b4hruBbCNCyO3a8ObB0iHK9XuzBHgH+M0tQfNLNCKIpPQ43Vg1U1M/T+JvM9r1T/mpYds/K
 Tmz86+RNrI6ALMHSUNqX65awQZhBvnGKzFRalB0LnTxtMqAFbwWKP3IhoLJ6Z39VHy0eyY7mZrvlJ5
 Q9CFGTTESlMpuUh9xNWVDIj4JgTu6UsgXzzxEGy+YmVSQblv9PMiPKzWi63Q==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

From: Arthur Grillo <arthurgrillo@riseup.net>

Now that we have KUnit tests, add instructions on how to run them.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/gpu/vkms.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 13b866c3617c..5ef5ef2e6a21 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -89,6 +89,17 @@ You can also run subtests if you do not want to run the entire test::
   sudo ./build/tests/kms_flip --run-subtest basic-plain-flip --device "sys:/sys/devices/platform/vkms"
   sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./build/tests/kms_flip --run-subtest basic-plain-flip
 
+Testing With KUnit
+==================
+
+KUnit (Kernel unit testing framework) provides a common framework for unit tests
+within the Linux kernel.
+More information in ../dev-tools/kunit/index.rst .
+
+To run the VKMS KUnit tests::
+
+  tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/vkms/tests
+
 TODO
 ====
 

-- 
2.43.0


