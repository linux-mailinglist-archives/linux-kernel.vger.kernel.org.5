Return-Path: <linux-kernel+bounces-78239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DC2861097
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03BA21C22455
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38967EEE7;
	Fri, 23 Feb 2024 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PYwhk9Of"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9EF7D41D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688274; cv=none; b=EOAJ+UdZx9Lk5aX3su3oCRbyp2rZLRNAJJCjqIA00QnglAhIYZNnyuII7JC/cGg+VlwAmebExbXsGjuo6IbjrI01g21F3rAs4TvhcZ49nlADGSc0sMFRemNrn+xNp0Oug9jQNmqXypdg+XDCYwZyTrXvp9WPN/dM5rZJKFleMuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688274; c=relaxed/simple;
	bh=WDAxkhzjtawKA8ibJoFIkQ/DkTdgQXrpylNOsCS8bTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LROgjtrbh15V2CSQ/0yM5GAkpQyZS23vnXOz+EA9MgaJbILXKnOUPS5T5IPzittBb7EnAkEMSgyxr+kinK0EaG9qINVMV/zFOeRDC2ti7OCCrFNTfvpVNATs3WwgfiS7/RQ13kuDvdXs5Ae42kyR+roesgwIy8+TUr3Lciz+cRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PYwhk9Of; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB3B040007;
	Fri, 23 Feb 2024 11:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708688270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1mJQirOrh5uVlCQFN4AJsimww+6ayqe/xDiVoFk4V7I=;
	b=PYwhk9OfsG/mMht0I1jiLjeD84ClOCScsLvw1o3f4GAiXhVON6pspy9Ybahvbys3n83Qy5
	WIT4IHxSfWV2ZwYxvVw1ST3FAM8d9ryy/OItXbVw7e2CSCXrT1NijOM11DlfSVhQvBZbIX
	C/sD+lrOCX/TqVuYNzD/TGD8F4UXdS1EAZUMxg/VKb/KLEKGgPtBEx58E6YSf+6djMHMZq
	mqL6wD8U4ruEK5q0qcQhKum+sBg1HbDlAw4sSiVps5zmgmazTT/V9ngML/Ki6GO724NSKI
	0lEXzDdBDP4Fqyo9+fXbY7u1dpG326h4g/TWpwVGOXGxXoHBJYUfu3IKz9/SnA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 23 Feb 2024 12:37:28 +0100
Subject: [PATCH v2 8/9] drm/vkms: Drop YUV formats TODO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-yuv-v2-8-aa6be2827bb7@bootlin.com>
References: <20240223-yuv-v2-0-aa6be2827bb7@bootlin.com>
In-Reply-To: <20240223-yuv-v2-0-aa6be2827bb7@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, arthurgrillo@riseup.net, 
 Jonathan Corbet <corbet@lwn.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=881;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=cRkkP1b8eceTuEm0QTSGTTTnDinaYzDjRJLok06bIiI=;
 b=kA0DAAgBIK0uxlsQLOIByyZiAGXYg4Wgrf4s8NRyCy2qmIlyNHA4yLL3bKYtN/ZQk9hSIM1p+okC
 MwQAAQgAHRYhBE+PuD++eDwxDFBZBCCtLsZbECziBQJl2IOFAAoJECCtLsZbECziaLAP/1k2eXjQRD
 3FL/HeJpArItvi8W0tZUWGN1/seXhVi1peCBKJH6kiNG8VzTUHUDK4cGD4shANtO2QPQ7kiB9hMbLN
 jcZn3AkOHphwPKFBXYBcZDkbISyGE4f2lF1ycR2jGH/0kx2QIbefWJUfNm69JRjITbDcMlInLRiN1+
 UYAV5Em6fI8ma1HQU7Ml2jTPSX4mY3crSAtwKbzlBBEHIP2yaw1cnlVkTji/1EqmzsfB4PLCo/nGCR
 rm8nNYL3pamibxKc2LKG4pZwsgEaxrvR0FpPWm9HVweiGMat0XN5eChwACLbVg7DLv4+erpB72x6O4
 jqwvYt2gep3PMjtqgO6c0KP8mSgGVfIuVEa9yiKBXWR9F9O4RPR6l6gEKN1uh+Y/ircDUSnMToJt2P
 OzuGGyVI5imeR+CPVcuCeqJ2xZ8TF6PpFLhNRv4wv2T7s51AiEQjWnEzVWcVVA6bYGMv4NbCYwlAvK
 V2wqHofMtn80Z21PhsvbsocogwtarOoQNLHInURpgyR5LVhp0JdauobP/e8ZxpyNtV9r1eZJvK0p2Y
 P7gEJryTmo5GJFcouepmKgvA+UGwhTdIBCn/FJxKOAFejGmJVE6DhQ9zCud1zuNZmUFLKGrVb8mUUO
 cL8WfifL2gM+xaXyOMzAlDWex6VWKvMhu0QZh4C5ndYe8Qay4c
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


