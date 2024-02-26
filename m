Return-Path: <linux-kernel+bounces-80955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBB5866E5D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9D31F22448
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765155D90D;
	Mon, 26 Feb 2024 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CVuxn1my"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632ED5D46A
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937278; cv=none; b=fiiCkGZIBmgGa6XEgsvdRcW+D48IJZ5VB0hCdwrCCbVUVBM6z4WFGHqHVxrq1Y9ATp5JZxVP/9J5WkCkQZFpNzl68HrH+RT93UpgUzd9oLAAnWeInqUkveMlKQytVOUk4graOoO76Q2IJ1nFN4auNBwM51zs7DFMhv7VV6VIO8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937278; c=relaxed/simple;
	bh=WDAxkhzjtawKA8ibJoFIkQ/DkTdgQXrpylNOsCS8bTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uvy6QiAC5E74Ep3cTrmBEeHAPqdN1D1v1shGMo2F/uLsSXofcblDQpP7UNbwhxGkGRjJ8ZnN/Tul6G7Wcsb9bq466qWW+qclnSB1D/hEOtixA/X0czLObo/msUtwTD8mxur0ztTqfoGMgvs+7CC/41ZeLynC9V4bJ1HttXmt2BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CVuxn1my; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A26D6E0017;
	Mon, 26 Feb 2024 08:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708937274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1mJQirOrh5uVlCQFN4AJsimww+6ayqe/xDiVoFk4V7I=;
	b=CVuxn1myfU3LPO3kH3trNGJMOwPFbT8wPap3ipJ7wly2E6Zp4lXXxWgy62jODYSjiHFi92
	TrFwS/V8zP5tSUgZqHSBIkJDfHw7Qo8igxIh4C4GVp80chJClwxz1Tba20yLxz/89EHQIr
	ZJc+jA5fkaIberpmWnsjH21oE4ePyDwpYJlXCyA+d+yUczeQCRvEn992RtK9g9Nolh2UWW
	NgfOFEVVMYHZNV/cwK/zs7SQxc3oDsYJFyqNazx+TaTYr1nOVqI1yreTJhimmGp4FsTUVd
	mh8sMuvt2Yek1v3nW98MldkBil7DJJ2F5512W3W6tyCXAm8zNB+gbIV9QzDQYA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 26 Feb 2024 09:46:38 +0100
Subject: [PATCH v3 8/9] drm/vkms: Drop YUV formats TODO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-yuv-v3-8-ff662f0994db@bootlin.com>
References: <20240226-yuv-v3-0-ff662f0994db@bootlin.com>
In-Reply-To: <20240226-yuv-v3-0-ff662f0994db@bootlin.com>
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
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBl3FAu3/xcYIu2XAyaRI/irSXXd3yp6kz0cLwrVbyp
 0xQKpeWJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZdxQLgAKCRAgrS7GWxAs4py2D/
 4oCJKYWdQ5WV+LIcdPmG3crkYWUByr39Mn+bDJCPeCOV1vmo34h/CzYxTmVCtbug32zjEBXJlmSOak
 G9hmdOjo7SyfibyQXn7WdpM5Vo8CKFW+7coN0KFrCCdxHYCiOZiHgA6Zu3JUv48i+woltLznIqFlkg
 R1+1Za/MBevfss2JwDRKMwkK9EvW5mHFhaJzD94H8EF9J70djpk6mzet9dxpotZafXhm8nvnlrkkkQ
 DXqKgLq9jImO6XKuNgvRlWgOZYOVu1F1wqYWuelXbOTxxwk7jRSbVMm4mY3oSqdKbgn08JALodn5Tl
 NJIAZ4hZJxJvg3VWm19TumirnP4uGP/v2eAqeeT9N5VvtMnKaUp8lAH3GhRl6C7eFqxddBAGzhhXcz
 cyWJXzoQVqZmWDsqOT05WuSCL0AYWvR5odfLjHvrv6utXqsk54GbimCsr04yY9uCm8/4uu1fSafYwR
 FLz6NHcsSV8zhkQH7aILKm7DRWbdrOD1UiietonzLCN2c619aFilI+/tcjnPHGobVtpMcoOkyGDY4b
 rpKAYQxTah8fK8YADYY/llu7TFyBQxJZMD2sR/tR+E9Jo9uFiIFweUE/GQkLGNeUAVC4xSnDu6Zk03
 fpKLdfYom5S/iVYWHeM+K8Vs2x1V6+S/PacHfDQGausgla/IgjwIgV43JnyQ==
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


