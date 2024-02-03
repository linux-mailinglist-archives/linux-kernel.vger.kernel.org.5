Return-Path: <linux-kernel+bounces-51132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 285528486E6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A951F2485C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F1E5F579;
	Sat,  3 Feb 2024 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="oovCPkTo"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D727E5EE99;
	Sat,  3 Feb 2024 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706972277; cv=none; b=D66byqbKsON43pFnXzCssYHY3htRgOY8YpMTC0aZAtHPG5Cr7vILzufWWAlPOgVnOPprqTVCPWSTCBKpaLw2rmvkf8QKGOICPtuv/XZOcAhR9qU2zstRCnKyTFrYOdt8Abvk2oS9M99MqyewPrnxSloCCJSvY+HdyTxQudUTLWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706972277; c=relaxed/simple;
	bh=iAj0xHQKjnDvEWG01ZMhoSkt7wKBJvqr74+xx+jEdfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O2uf4YwI3QiDNYHIJwwV2yvND9ViN+G65GsJLfHvl14Qo+2MTB+JJPnbi/lUd/SXobunwCxuAlmNRC4PIce9ES60C/k/nit4dLEGkMmtPDamf7gapZkzBEkCi8tFq60wFYkln6dhozOijI8b0Mqt9zEJbbLC549kx5XcIezhc+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=oovCPkTo reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d95d67ff45so19037495ad.2;
        Sat, 03 Feb 2024 06:57:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706972275; x=1707577075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wMrCvox2emkuzihcxzjFaRnGeo9VP2X3FS1KTn7sXO8=;
        b=lwOStoxOuYft8Le0GmHGLCcaJpvbjTCSBCopQlOScYfxF6sosk0wOxMfjrTJoP7Qc2
         iEMRxIfMnUW4sxGd6LJ3cVIu/e6NyGXaX3YuvqBu5tx3IIilsLS7X6BFbGv1nC9+02Im
         LApcdwmZMb3CWggs8Vnl45vf+w8VP8AwUnNcwGVwKkjGOtjArJ8J83liyy8yXtJYBiXi
         ZOgyaX48toNRwMzbY64SQoR+HFux1E1TUve3IjfBlasCirttA7PUBmePysjvmkaQxKBA
         mNqHEMf0QZS/aKFFkWYfNBTr8fzyIDDIpc2P6oJmiTXYdzpjYEU6la/t/B5iUlx/NPjy
         QSSQ==
X-Gm-Message-State: AOJu0YzfOvivO40yQkzUufMIHBGALIpiCXfk6vaIK4XK4TJmP3s+zShH
	FrG0UKksauZI020JpmWRWxtWGB+QCzhPhPiDvi7xcV0SmRM93JFsnqgUN1H/793DmQ==
X-Google-Smtp-Source: AGHT+IFVTXkNnXKUhHMd/4xRY4Xie/6+YhhllmYaUWNBi0vfDSRtg29HAQNMd0P4XwdPy2giz/nDvw==
X-Received: by 2002:a17:903:40c9:b0:1d9:89dd:19b6 with SMTP id t9-20020a17090340c900b001d989dd19b6mr2684747pld.59.1706972275360;
        Sat, 03 Feb 2024 06:57:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV23pyAlVVbbBvq1znLAtrVTujReJMTSby7pDQeaddYuYMr5B1YDGcG1GsZF9Itd+j5FXsrW+LzkPV8dKQQ1uiMtVX7KBSBDuqdyC2homzPwdDCX+yzqktZUnApd2Xs1bxeqXo+GrZN9DJFcw1rEuFuv09nuzD1QPwLDLCkU8ShJFsadYR7miX1NWkNc3xVuUnJ8pAv456Ciu5Hcocq3Z3ZxKL0iCGFAujgJUalFMAyeO99wxQo4q3rQyULi3rKHPlbuGM9QAsS8sHUBxKMT2WJWUJAsv3J+ndp6Ik4gOnCLwmJA5kF8QzchahisGxWmWvyEzKR8Uw46ARLiQz/VUQYxBBazaS2MlzqTLllX6VFs3Fewpe5wn9hdR83G5M+a5QDvQ6IXAfG22ZN7415kSXl9ul1AKU+G1GnCKkfkkF79zJqZsRBZW8=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902eac400b001d92c29d6bbsm3374298pld.83.2024.02.03.06.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 06:57:54 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706972273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wMrCvox2emkuzihcxzjFaRnGeo9VP2X3FS1KTn7sXO8=;
	b=oovCPkTo/ok6kdhmUA83IVzle56xEXSBzylx+lX8RiINdTjg0RmSydNaQ3Yrr10pbDjddw
	i40Z9/mAwtfZB8p1dqs8//5QjG4J9WsNMeXTLiB6vCoHF2QkWtqsTKv5Wvopak5hrxmsC+
	ZCa+MLj3I2lH2H1lWuhW4oMSq/xRSr9W2sXLKjqANZd9MCoPi+9d1Hk6U/v2aHPsdpREoy
	tmEU+gtWV4/NsoRrHsWgHWOxWZooruvsw3uEt5L4fjqQRc0KuP6Qdnluf2ZQj9YmXj/Vzp
	dcgq/NMmrPvLXS0xqHTEbYAaHpqiYbIyYrRTrJYxnPpbYsMbZ8DFQa/HUF175g==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 03 Feb 2024 11:58:01 -0300
Subject: [PATCH 4/6] s390: cio: make scm_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-bus_cleanup-s390-v1-4-ac891afc7282@marliere.net>
References: <20240203-bus_cleanup-s390-v1-0-ac891afc7282@marliere.net>
In-Reply-To: <20240203-bus_cleanup-s390-v1-0-ac891afc7282@marliere.net>
To: Vineeth Vijayan <vneethv@linux.ibm.com>, 
 Peter Oberparleiter <oberpar@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Harald Freudenberger <freude@linux.ibm.com>, 
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=977; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=iAj0xHQKjnDvEWG01ZMhoSkt7wKBJvqr74+xx+jEdfk=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlvlSAmCueKzxBw4WdsI50v3l/l4YHzgi62MuVy
 uX5qqOz4PKJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb5UgAAKCRDJC4p8Y4ZY
 pmJnD/wNjxnWF2BpmA4oRLp6946c7HvKu3i4mZVLX1ZfSrBn4JC449Uf72Px90ZxQoqO1RnA73+
 kXkRJ27KpfpJZ0GEUtjLkjdwer/dYiFLGuiUhJYaaWUMxavsKONwIToi7ww+XNbRSxkyvbtVht3
 fx0CYLNZbjZX1D2XhL/d5J5rfl623VsYkFmDjtr1E4Kij1E6QMv3NLe06AcIPgR/IfPvoH4jfph
 KGq+t1cgXW72avp90phoI7uxT7Xkyz7sYGrkLKxCzPMWFXOmFrj4IJRdQqUCJDoa0HLaXhfTHD7
 pTCvwfnelsgri2FudApRxABurU87BP+eyuWoMpLUABC3NmL84tqfkGcLlAvsmTX/6dV3R21Hh8F
 SBLgO1/vRQBmNpWyXq0opGE9cqBJmz04eZKk9vSZVKk8e9cw6zpm05X0L9P+cnhsIf7Cp8jxyMK
 7ENaog+qD9CDDErkP2xItzSaQIfLkSXY9BWjTVBKNNWu+58m3r5ZHV3hcUQrJ3crfsI+XR5usjN
 DhdOqHjKDIw/KgPE0lHf1W5scxPKjmHPc6xpqsTobRPmH20M9qnOV8pDPgvGhqJIHxsd9pE3kj4
 c8a1fpGdYgNkVR6ap4SKkaxblRvwyIg//YJ5fyIAMT9bDYG9SZwRtJKkZcMIJxp7sJKmwml3KsI
 +XpA9xOW2NeJgAg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the scm_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/s390/cio/scm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/cio/scm.c b/drivers/s390/cio/scm.c
index 6b21ba68c1fe..375cbfa31b53 100644
--- a/drivers/s390/cio/scm.c
+++ b/drivers/s390/cio/scm.c
@@ -42,7 +42,7 @@ static int scmdev_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	return add_uevent_var(env, "MODALIAS=scm:scmdev");
 }
 
-static struct bus_type scm_bus_type = {
+static const struct bus_type scm_bus_type = {
 	.name  = "scm",
 	.probe = scmdev_probe,
 	.remove = scmdev_remove,

-- 
2.43.0


