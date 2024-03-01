Return-Path: <linux-kernel+bounces-88994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D2186E92D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DDD11F2901A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3867D848E;
	Fri,  1 Mar 2024 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="LpF0qO4U"
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596D524B23
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 19:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319979; cv=none; b=JqYCeK0WCERioZ+cei6Bu9nJlu/KNV4mtJYAfrwuu65EOthFuwLEFloCyaeStO34Wr5/eyEfgpkUj/o63bYLYcrjpQ1Kk21kkLSGHyX+oZ0IcVLmGi3kXHz2eUi/9vq6CpFKREaulJX9JyayCMt9DRyow9KTHCTFRWQClgz12do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319979; c=relaxed/simple;
	bh=fBKQb/U2gC/96fp2K2GWljmoZQn9BibE1AkFqiHeIUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IlKDUMo3XMqlOdnIYVLvuX3CH6szzvMsO7pWYUYbFNf7ibBcodjdEonyu7G/p83a+INWnThpaPWm+HVV129Cy0v6CqEGeFOf36v9Dh8TkaXIhUgk0/5lfFAXiIPTqjNTX5B82gdKdJskLy5PCZsCxPc0jB7tFpyl/M8xApE2hc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=LpF0qO4U; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 18082DCE59BB9;
	Fri,  1 Mar 2024 22:06:09 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 67HJQtmzNR1y; Fri,  1 Mar 2024 22:06:08 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id D9520DCE59BBA;
	Fri,  1 Mar 2024 22:06:08 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru D9520DCE59BBA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1709319968;
	bh=kclR9O1Au8wRehRzcfqdqVCqhOZ+OqTDy0X/Usb2D9w=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=LpF0qO4UY3zq8WFvfMYTDR419wAIeTTaU+28M4bjF48HF3Fk8cLVDiUVvukA6S3xf
	 LQV5kmSoorpDoEVfmqbF3di3udKnRg4jYZ1IGQ3AXGiMtk6Rit5sfp6Z3LjbacGNRL
	 w2v2AClGz6r4CWLWnTyazNB7IGiIU5ajLdpKUcgdyf1XoBA2+oBUOTSvr/Sqg0s2wj
	 XVpUGrzUB8pYNuzUIt1s10sCFq1tXQnW0qkmRIX4eRQapHb215i5a+lXfW0AufIL5i
	 RUXTL2+VtxS3tRvt0MJEf4ERbuAqjfuLyjsxHAsTGok1lJ86W88XUQ2OVijDjxIGSS
	 2PazYN5T3KB3A==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VQ-MjpTfyj7b; Fri,  1 Mar 2024 22:06:08 +0300 (MSK)
Received: from localhost.localdomain (unknown [62.217.186.174])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id A728DDCE59BB9;
	Fri,  1 Mar 2024 22:06:08 +0300 (MSK)
From: Mikhail Lobanov <m.lobanov@rosalinux.ru>
To: Rui Miguel Silva <rmfrfs@gmail.com>
Cc: Mikhail Lobanov <m.lobanov@rosalinux.ru>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] greybus: Fix deref of NULL in __gb_lights_flash_brightness_set
Date: Fri,  1 Mar 2024 14:04:24 -0500
Message-ID: <20240301190425.120605-1-m.lobanov@rosalinux.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dereference of null pointer in the __gb_lights_flash_brightness_set funct=
ion.
Assigning the channel the result of executing the get_channel_from_mode f=
unction
without checking for NULL may result in an error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 2870b52bae4c ("greybus: lights: add lights implementation")
Signed-off-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>
---
 drivers/staging/greybus/light.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/li=
ght.c
index 87d36948c610..929514350947 100644
--- a/drivers/staging/greybus/light.c
+++ b/drivers/staging/greybus/light.c
@@ -148,10 +148,15 @@ static int __gb_lights_flash_brightness_set(struct =
gb_channel *channel)
 						GB_CHANNEL_MODE_TORCH);
=20
 	/* For not flash we need to convert brightness to intensity */
-	intensity =3D channel->intensity_uA.min +
+
+	if (channel) {
+		intensity =3D channel->intensity_uA.min +
 			(channel->intensity_uA.step * channel->led->brightness);
=20
-	return __gb_lights_flash_intensity_set(channel, intensity);
+		return __gb_lights_flash_intensity_set(channel, intensity);
+	}
+
+	return 0;
 }
 #else
 static struct gb_channel *get_channel_from_cdev(struct led_classdev *cde=
v)
--=20
2.43.0


