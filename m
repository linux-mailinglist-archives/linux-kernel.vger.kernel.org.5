Return-Path: <linux-kernel+bounces-92941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B516E87285E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98A91B2A1C8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA7B1272A2;
	Tue,  5 Mar 2024 20:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="RkqfWiOc"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA3B17BDC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709669635; cv=none; b=Jja7m9Gl0e+LQ8PfrHf4GXmMczWOWvbv9/Bb40Io2wUdwJ7BpwWiaPBFSwZ5YGNggERmxUtud1TkXqHvcS3+BU4MxeQYAXj2cANP37ultMzJxPV5ohoes4ghUUG1alj5sUQcD6GVaacuKrSKR4y1SOA2HksCRTENWEN/SXkX7Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709669635; c=relaxed/simple;
	bh=5Wm0Feou8DRiXWce7bt01xh1tGKc1xLn2CN27Ctf2Ug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WosVnvxCpyOURhwvbwX/uvFv/6FZ6sskuYo4paXY7+VsnE9aNuZBFLqXAGnG6YhMt2RiX7ZsJkevg6bGqiFAxlBWsGmi4VCM38dI2lqeIQxBGcgO3uWfmGOBjz4CvTvrN2iRjoPqgoB98PXOdLqytZIp14Y4WDWglGWJYlj5xEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=RkqfWiOc; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dd2dca2007so8199415ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 12:13:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709669633; x=1710274433;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSYXVhW6IE2D5ajlQEa1B1vvrGKQQuPtcjeRLrqLYrQ=;
        b=s0yJDnS2vITgTupUohbffQt0HobDe9tymCNImR0hNAUW4Ez3Ru75LTxNlHcsphd10w
         FCRBZptQQ9GwMwTovZdpY1UJC4y1tSmBN/0J825UA2LUSpJeqLDCEMbaQ+4fNwFiM1Ul
         yvAtod8OOyQSphO3nbOVvV9NdmLVtbZeu3ZJAayjzZaiUWIHKidUGOmtjZrOdW/rjexe
         d7WxENaQLHiJR33wCLRA2iaRSTC+U4/8FomyyV4C7NkBl80fmvkihU2cZmILBmwoETtu
         rRzctXHBOSVqsLfuQdoRIehonMG1d8/VgdPqBA7xn5YK5vpyQqLPI1B2Cf0mklreW6uz
         iOQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO7i2Xv1mNVCqt6IcvuHk8q8VFS3FstvopDMB37kzQ2z8ktWx9s488LFJ/SlIUdNAOug1cAh+l2nFUFhzRijX99L+OlQdbpIq9Dkc1
X-Gm-Message-State: AOJu0YwjP9AIHIbHj4ALazA8dxcMu5pj0jLBSce4CRkepOgvh6zzWXip
	kSba9J8FrqmavTCLz2ZvKRFVeYj6Lps5YpaHRlUmdgxnLuqBJlCf+p0mmmiT+8FQLw==
X-Google-Smtp-Source: AGHT+IF+RsAWrAMSe9G/BWeWxtXL6Wd1ZdhDRF1td5dyHKERADparXdgED8Dbw7TGeOs4HsS+NM/9Q==
X-Received: by 2002:a17:902:dac9:b0:1dc:696d:ec64 with SMTP id q9-20020a170902dac900b001dc696dec64mr3190315plx.22.1709669633114;
        Tue, 05 Mar 2024 12:13:53 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f7c600b001d937bc5602sm10926938plw.227.2024.03.05.12.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 12:13:52 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709669631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XSYXVhW6IE2D5ajlQEa1B1vvrGKQQuPtcjeRLrqLYrQ=;
	b=RkqfWiOceETMbjQL91ZG0aOurtSdvq5mBrQbqJ54piY92oWTaufoIb8wOC5mRvyyuY/AQT
	hQk7r7wP8TRJbTDK2XD6IMh6VQ5XsxK09xU+SZQbqwdGUzlKSZ/s21mtzPPpn+W9qJW5JK
	X0FEoSEN/uHvATgSdfGdzK4hHwRFP/4Am2wqTIiricr2V3JVzhRZ4c2VKVIHHLp8LK5rPJ
	QCqY7rU1nIvbmlDvWfEJRhoc/LFwt+zoZcnFnpTODHlqIpDAgNm9tMxrqgzyzJaa5/Brt6
	33U+ntXeMsVky+a/gLsgcmRY3LqS0UYjCey/oJyerntyRnCsD+T3b63QxGrbNw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 17:13:48 -0300
Subject: [PATCH] macintosh: adb: make adb_dev_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-macintosh-v1-1-9c3f4f882045@marliere.net>
X-B4-Tracking: v=1; b=H4sIAPt852UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYwNT3dzE5My8kvziDF3LJAMj8xQTQ+NEA1MloPqCotS0zAqwWdGxtbU
 AigoenVsAAAA=
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1645; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=5Wm0Feou8DRiXWce7bt01xh1tGKc1xLn2CN27Ctf2Ug=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl53z8Dng6WoFoM5acsfn4yA7f7mVNkc1g8tP77
 NL1/ln0DJiJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZed8/AAKCRDJC4p8Y4ZY
 pgaqD/9mPIcZD1XS4VoldtUUUrXLtC9ZNZCu1CfgJqdxcAUe1p33nP7P0z/H7GyH884PedWXE6Y
 L0YTOI53df6Pizx+ZHehIkVORAYAWvHAzdX06p0A1erCj9PqjPie0wnChZsF2/Olactz+TCarsr
 EgnWgo8SPwsBh56vTYt1eaSUNbxJ9ME/jV/AphAcMgPeLZ//iZlAD7cJli/+pZgIM+NSbjUHRKw
 1CuZnOCD/vgBD7wPYCsme580jfwnEzhpHwdrz7HDiR9ci/B2zyOK2VzkHsA78OLV45jsUywNJ1W
 jzH9MyYzxhLLv/cCnIQQy27YQgKKd/TQbdkYkCs1RvkDmjBh+IZpwlXBjhyLD9yaRZ6oLPLPwIs
 njMqNl74F20GvR9zTnpfUur9n8bsUJ+ciUgb7YLphtnJ8AFMAUTAuJf159STbAMqdh3cwcobkZs
 HolEPdkXPNggLGsm+hgOrNUcNjaQJbBdfHJbP/1A5o21WKkade4U09CXKSUiBoHRuOc0Vo7x19i
 ibWu6VhXJF0AXy6GfkfWgV4S8k3JePsVTDCbCoLuqJATcxULyR27Bo1XGJdnTpjNtRKFRHEJug6
 lb8HZUG2M3ImINPHiea3Xg14/wjyQtJOUnNU/7sybAoSATxtWN8J2S5UDPWFXOFXfdgxL3sBjOC
 QXWzD4OC8BnPJag==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the adb_dev_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/macintosh/adb.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
index 057b0221f695..b0407c5fadb2 100644
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -74,7 +74,9 @@ static struct adb_driver *adb_driver_list[] = {
 	NULL
 };
 
-static struct class *adb_dev_class;
+static const struct class adb_dev_class = {
+	.name = "adb",
+};
 
 static struct adb_driver *adb_controller;
 BLOCKING_NOTIFIER_HEAD(adb_client_list);
@@ -888,10 +890,10 @@ adbdev_init(void)
 		return;
 	}
 
-	adb_dev_class = class_create("adb");
-	if (IS_ERR(adb_dev_class))
+	if (class_register(&adb_dev_class))
 		return;
-	device_create(adb_dev_class, NULL, MKDEV(ADB_MAJOR, 0), NULL, "adb");
+
+	device_create(&adb_dev_class, NULL, MKDEV(ADB_MAJOR, 0), NULL, "adb");
 
 	platform_device_register(&adb_pfdev);
 	platform_driver_probe(&adb_pfdrv, adb_dummy_probe);

---
base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
change-id: 20240305-macintosh-9b027d413a05

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


