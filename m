Return-Path: <linux-kernel+bounces-58630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B163A84E915
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04876B312AF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D098381BF;
	Thu,  8 Feb 2024 19:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="Eq3JHS1z"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298C23612A;
	Thu,  8 Feb 2024 19:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707421010; cv=none; b=uKRQns67IXHGXRjkFAlQr/ZJOMOVdYrGtnw4j9weWbHo5Mj6uExoAUphwhk9c//Oh3zBJsRzCQhOuJ7zpMYuAlnF0SlDvvVS+CZBKOvoqjxZghnWyGrLiQW1sJYQMPHX+xI75DfSXEXWIPMXbZUf9B+PMrQzuaJedeVDNiVBMgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707421010; c=relaxed/simple;
	bh=P00MN7TEHNS0sno2RE3JL79uy5/oil+paWe4tOWUUGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VSE4eTXzbLEO7NTU+gTvo3rA4oM7ui+9wVnW/axx/Sa3UPCUnikSWe0DFzMspuM6RauCrBshn9tyO+HmcTC3xNdSxpCCO97v9+0nT+yN73RFbItdh8z4VvS5msAHBbJf31E9Os+aZDSea4htGxGCcITP+oSZ4QkdXrjKEnmlGvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=Eq3JHS1z; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-296e22229b6so158579a91.1;
        Thu, 08 Feb 2024 11:36:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707421008; x=1708025808;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkyOtDTT6XXbEX+vLQ2wDNuDNguLiW47jjofDmGnI7M=;
        b=MSAunoMnvIxj4xSaEXTb5xTRtBgW3sExVpZri2h2p2wMbLEBeaqVBALVkfH1lEWYrv
         lh5nky3P2Tp1HPSZHqi6SGLlwGIhfv51pErWZc6rtoeupf1yaxQ+xWmmacFwGedAdFDY
         lcINydLfXtpNePNlm834irvFC+0F1WJG/7XXlRusuu1o0o1RlPEpJu2VnWitWXBfHq8w
         YmMFk/9eQ5J6g1OM/ngyWGJWfN4aG2Z17aR5MmHB9trLl7a/Eua+qgShuck1fqlG4sFn
         0fmBPtJrc2wphy+Ed8wq8ETKuNH877x0nL/q5PVms51LUo8CE6si7rgiApDJKj8Zl8Bc
         73Lg==
X-Gm-Message-State: AOJu0Yx/AND8B1FTfD6xAnQsbFMtK3jpviJeQ0lIWlO5xfH+hdHbrtta
	n9y9l54XQSfXhqjlvT8jTnRo4JKo23PrsEZSqCW2AgaDnMkdxAUa
X-Google-Smtp-Source: AGHT+IGgIsdij24PFem1UQsHoJa3ba1yfpD9a7azfSvswscPwO53404H9Yyl49sSIlxqzHWeRONfOg==
X-Received: by 2002:a17:90a:3ee5:b0:297:414:73f2 with SMTP id k92-20020a17090a3ee500b00297041473f2mr284069pjc.11.1707421008331;
        Thu, 08 Feb 2024 11:36:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXm5c0rvT5dBIBj/cRxofCBIWjOpFIWs0K1HqJJsW8J2zRBJPUwraPqv/0vA/0HpkrRfPupqdOpA0oqcIztAdA/xr/YynnvZZSjot7h5Xg86GTB8b98tA9Qq31DkJ7Z8Bsvh1j6iV9429HV9N+q+BmIN7v3CnpsoqXA
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id az11-20020a17090b028b00b00296b2f99946sm153020pjb.30.2024.02.08.11.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 11:36:47 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707421005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fkyOtDTT6XXbEX+vLQ2wDNuDNguLiW47jjofDmGnI7M=;
	b=Eq3JHS1zKYfQSfsJvC7H3YF7nwfVpjBxrus6JLBjnBI7Db9G0XChQJUX97Pt6aomnKluZz
	2KgSYLFf3n7UYPmgn+15mRCXsc4w47IsYgoNfkrMF7XM09FmtnZTQH8FllFOClB6/noBpn
	RCwlkTiCi6C1P5gCNbpGbKZ2GMTmKH8omYANzWYkadnt7wrpps784p8wOBW/F8TPeRtPFD
	dMOsHoXLAfEBDM9PULFcgnYYyA/3kJKeSROPlQVme2lMrwtdsPxDOIf7Ea4HFC39UDHiHG
	c1pVHK+6ujFelxEBSE9p9Aq7pdknn2qe9AtwIW1n/u9xbzQ4KOEMIwqmaj5Njw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Thu, 08 Feb 2024 16:37:19 -0300
Subject: [PATCH] iio: core: make iio_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-bus_cleanup-iio-v1-1-4a167c3b5fb3@marliere.net>
X-B4-Tracking: v=1; b=H4sIAG4txWUC/x3MTQqAIBBA4avErBN0Mvq5SkSkTTUQJkoRSHdPW
 n6L9xJECkwR+iJBoJsjny5DlQXYfXYbCV6yASVqibIV5oqTPWh2lxfMp1BUN0oTVsZ0kCsfaOX
 nPw7j+37mZhdEYQAAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1667; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=P00MN7TEHNS0sno2RE3JL79uy5/oil+paWe4tOWUUGc=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlxS1vlXH9tddueq0J7shZnHZd1dmF8z9YK5VOR
 xPH+qOYkkiJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcUtbwAKCRDJC4p8Y4ZY
 pnrwD/9vEKOXummVQLcUj3Z4smz8/wI0u97x528XWcu1P4g02ceVg70R3Audv/4zJIPjtH0I5zQ
 /jWPREIq7bjqWBPJU2tjMlE3xS4BQKIiAmlhFMYCvqczBWFORqSSX5tpLMtABlKz+FQpmnS+9qp
 teLOghrIoPjKkaJkDXv1+QpCw4izdGPHeX87t37CFOZ2wD+sBx+EqYNP/xEOoej0nU3OLC8cF+q
 qb9IYx2roXua0UDO0uZMNjNubKGu6yO0EiGcXKDjZ7fm0nj03TTl0XAaHvACFMUBWz2eR2c6lrs
 SZyynT/tQxM8gduiEkTXCe6JAI8mMB7TioIIq/R3GdHUoogPWcKFKVFsreSdZVGnTs4mqVwf/X5
 FZPe8hINlUmRkJp0fg57rAK/KSw+QLadkQ53SPH/TQk9SP3ssAOicBowrx8+uieJvPIulX0vyjK
 jm1yyr+JRFTAxfr0vYd5Xlw6cVY7r3hcIJ3KgIaaU3RCImjREPqXjnyT5VPJVikb5km8xeePUtr
 LuGkg5Yt1TDLoE1HGIgA8Xe/N3VyPqjr5XhS7wyBGLWfbH6qG8gMk9i+X3KJq2OWUBewaEU1uVs
 h/hrL0RZbT7pe0Izud6uTlrfWR8tjbTw1Hi1j+Rc641Xxd823yZBL4O3BDkX/ijz5E1PtYEj1hB
 DnOmrqsmcpRJGtA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the iio_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/iio/industrialio-core.c | 2 +-
 include/linux/iio/iio.h         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index e8551a1636ba..9b2877fe8689 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -42,7 +42,7 @@ static DEFINE_IDA(iio_ida);
 static dev_t iio_devt;
 
 #define IIO_DEV_MAX 256
-struct bus_type iio_bus_type = {
+const struct bus_type iio_bus_type = {
 	.name = "iio",
 };
 EXPORT_SYMBOL(iio_bus_type);
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 4f89279e531c..e370a7bb3300 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -669,7 +669,7 @@ DEFINE_GUARD_COND(iio_claim_direct, _try, ({
 int iio_device_claim_buffer_mode(struct iio_dev *indio_dev);
 void iio_device_release_buffer_mode(struct iio_dev *indio_dev);
 
-extern struct bus_type iio_bus_type;
+extern const struct bus_type iio_bus_type;
 
 /**
  * iio_device_put() - reference counted deallocation of struct device

---
base-commit: 81e8e40ea16329914f78ca1f454d04f570540ca8
change-id: 20240208-bus_cleanup-iio-1e5714e23bb9

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


