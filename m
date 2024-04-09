Return-Path: <linux-kernel+bounces-136954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 041CB89DA44
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945501F2253A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A33D1327EC;
	Tue,  9 Apr 2024 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HZk0uG4t"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCC8131BCB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669165; cv=none; b=vGaNTrd23IW2TzYtGeo5meMecUDF3KSRg86tbABgpIkjF/GjigJJBeN3MFa1qHyw7UCdDM2nmvGGIUCvGBWjYL8xBD4dRAL/IMDueT+qr8N1FU2Mo6+Z5VXPNBsnMLj0vPFdftuLat/t6y5xkzP7KGgQZ9GJshqZ1kkFHTke430=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669165; c=relaxed/simple;
	bh=Dap23lUACnoJxX+/EWpT/enfYH0mEU+7fwoVnAZoAcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HrFM2UITwknsZNS/Xht9t8irLuvaaSKcpSm+qm7LyUkYHvujfX2hulcMNmp1fsyGYfVxg3XlDVynA5HLd5oR/MnyAKAA4tcTwVhiK1B6UMFDIxZCyKhxLKqoMOBZxqcqojvOraOdp6S+6lhHIyJuPvOvGpxZv+cRQSC75Ehq+MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HZk0uG4t; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 561B6240008;
	Tue,  9 Apr 2024 13:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712669162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8vk8BNwGJAqLAVQ9fBvlyUPWgU+vNkf+DhOlg0zqa0Y=;
	b=HZk0uG4ti889oBfCdvCY1MxTUwOlSf/9ZUP2j5SU3IoAvZZDEupUSmVuU3dpKqyJyNKkE5
	+Zl5gz2P3W/MAs6qCJy2DBanyX+opk/f4gdvAhlMI2UpQhZnNcO+gsy3Gvp1CVU3CBDxgC
	tgEy1FUMfdEycuhGJfPucJNwuDn7XJ0rL+3dRzy+cz+nyZzGrWp2xPhFFJnin3HqCevKDp
	C+cNxtfbynlqLtt37JwkwGlmxGxigVj5wKyOHsPRFDz+9/eWD6m+Vw6tEx9Ar9Hp1FPX+U
	W5aWoMYkR1NA/mKXLJxPT166+T2AW9jiyg6nhQbe6eF6roIjIhIxuyPE8ngdJw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Tue, 09 Apr 2024 15:25:34 +0200
Subject: [PATCH v6 16/17] drm/vkms: Add how to run the Kunit tests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-yuv-v6-16-de1c5728fd70@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1115;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=jNe6Bg7KTpSpUer0keg/YQY7YaZCbb33mwHbW/nyqss=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmFUHTMLf4/jCJUHnHT+Fa6Naia0FVWTgBVdY/R
 WVGrT779H+JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZhVB0wAKCRAgrS7GWxAs
 4gigEADYRmbR0OEQ2q8wVP/YVMKRdQzaQGbLpuwp2ZSY5c0rnsIdrEbcSL/ljP8Bhi7yvGp5L9N
 C6PJu8hhe6MJRWHolg5ah6CfB0ckL7KR+0oxdGUbVsGaYlvbMyjVIz/Z0vMoQ2OHRIX2s4S9LBO
 H9kuvAq7M6mnF0DCEIb4TeZCJxtAT/S1XBV3izXHzwguAND5PBlnCeRedCETea4DGjwk6Do1xgH
 VeDUpmh3+AgT4omzQDNZEzRjo5siLDS59gjCmJOWFM1fN0eK+mWCk9jEfpK9cZwy4qG8S8w1ldQ
 28OnlhY25qWozgisQkM27IvukZQUtEMhVfsPXeCDGbsEfyLdT4jvKH6fHdejxNR5Wg+yYdmdIgV
 52jFT4UUCda0zDsM+dDufAs0X+XH/RvQAPIu/fg6Nkmguz3z3oVl+oIaihmFEDk+KIsvpJaXI3s
 MQ0al+SSDqB9WYWOQoPny6M1sF9J45Gh7m6LqxTzz0p5v4wWtZ//8cx36N4mJx3w4zYvOp82ths
 AiHeBA4GEjjJ2TLUmvq2tOXXPMh9z6gv7VFuHAGpona7j55hw7R8X2PZw66h11HthHeZ63NsmZ0
 5Gr3nGLQHflUO5dZ6MfaDSPRbnJsfGLBV0N7wqPZuom5y8FPpKjo6mLLEQ1kfkkn+SQ62pkNiAM
 xTxSHObriauBylQ==
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


