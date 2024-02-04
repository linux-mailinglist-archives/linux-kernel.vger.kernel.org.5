Return-Path: <linux-kernel+bounces-51769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AF6848F1C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 653FCB21CD9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E870722EE9;
	Sun,  4 Feb 2024 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="IlLJcWv1"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B023722615;
	Sun,  4 Feb 2024 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707062523; cv=none; b=s32uywVJp//Y2QqKhkRACxQcpzzjVqzfIrvCodfjcI0QxQfYrn/WwZermL5AZ7dW5d2FA36KrX+9ubbdqwGUWU691y/MRUtqmOj99WgH2R+ZYSiFGURHfJSg7ZuBLg3SWMeXIYIuSz6fQwfIfcn37fSZCAblDNvWe0bWzpTxk74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707062523; c=relaxed/simple;
	bh=RqP6QjR5oTC6j42WuoSoTTRBG6hJG83IUJl3HfLS4T8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aqWP1Y8dtyJMF/92AM873xry5v0qdjFLS8tuuSgNBGa1kgNL8jTr1VE7MQqzcq4FA0FYiQfLSGxYPFj+aY7J1Ape4b6cqMbcsNLmBWaqw+ENFalyUdBuOMqTFEa77b2ApIkA1kXDvoD60UvyB3ALzei2tPRC/puBNUIEKaOUM28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=IlLJcWv1 reason="key not found in DNS"; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so3354874a12.1;
        Sun, 04 Feb 2024 08:02:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707062521; x=1707667321;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6tux3yF+FHKohV0YPTE6voYVdRiZgTqWRcrEfWddH8=;
        b=hvkiygz9jYnXQjjAWxcox5S6QiUtdzSyaZfOGN4DM3RxCXWAMIjhvLyPQ2iTd9OqVX
         G7IvPfxi/eteLFn0D9SqUzD9+4Te6t+FoxOZU/3IfbwO55ThrXJ7psq+bX9h65ixBxPV
         wymUNV9RBhc2fJKii8GEL9E3AvgrYYLdrpKGEAlsQE/8o7/Xr+i38fLBv/yXf5GbzfQG
         p7zafDCIJqAS04Q0Wi5THGmY8FoHSLsWganPIpDYBl6xW/uva7Ewq6/5AQNIjxVQV4Yj
         lCTzxSizVKb/p0ycgahATuDgm5sr06U/o0rzubpMz+UsfChf8QhrjijVu8R9W1LOF8K5
         bknw==
X-Gm-Message-State: AOJu0YzlR30NeFEGamNxzdI1PjM9dhfQY7oJgZHXOU0bLxwaOogM9BP3
	vDFOzdxDCIgbunIwpSEIysZwe92gxLTSURyvUMtbHJC0Vmedu6aZ
X-Google-Smtp-Source: AGHT+IGrEzNLrWh2A3+bwOZhlPVbVvN5QhQQ/i0u95LngB3psgTK/DGRVeYaitc0JrIEYHLQnrNEpQ==
X-Received: by 2002:a17:90a:eb0d:b0:296:3a70:ad55 with SMTP id j13-20020a17090aeb0d00b002963a70ad55mr7820425pjz.34.1707062520975;
        Sun, 04 Feb 2024 08:02:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVQerWtxHV4Aotuwy0a5CxNNFpSr0PieNwWzSGUvrHqFR2kSdrvJvvE/Mi+pxMYpbqYM56Lz9WrOZP18qpfmvCUZ7ISfS3vAM77x20yWtXlCz3zBmFOJTPeNbLnjFTV9bkCTc6v8kWnwQ==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902ea8500b001d95224a53asm4732148plb.81.2024.02.04.08.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 08:02:00 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707062519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I6tux3yF+FHKohV0YPTE6voYVdRiZgTqWRcrEfWddH8=;
	b=IlLJcWv1PCy8f/pODEBKuI9VB3cCRmnm1J48jL/fFU7wj3XTmoYHY3u44WRekyXrC8Uwu1
	ywzzd8MGT/1bye6X/z3KfX/yL2pme/dPbOPlU7RLxeL94yb3rA7+o8PNnIMfQOjCxftv0k
	2AsvX9HI7/WRc+kK5K/ZQa7zEe53HDNBSFqlALZwJ/K9tMRCQ14bijK4+MFOwK5ILRfRJg
	jrqpBSGlGhxbZiaNS6BvMlL+4J2ovZOt/TDYsiGSS8vR88wTtkaGlxjTAizTtl60Oy+Njq
	jHhxfiIjn4t9MskV0ATyXxSFtPt3856v3ZyVt+1s86lAqSnWRu461qTYB2HVKw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 13:02:30 -0300
Subject: [PATCH] counter: make counter_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-counter-v1-1-cef9dd719bdc@marliere.net>
X-B4-Tracking: v=1; b=H4sIABW1v2UC/x2MQQqAIBAAvyJ7TlARgr4SEaZbLYSKZgTi35OY0
 xxmKmRMhBkmViHhQ5mC7yIHBvY0/kBOrjsoobRQQvOt5NVeaHyJ3Ibib0x8RKOk0Z3NQS9jwp3
 e/zovrX2tnX67ZQAAAA==
To: William Breathitt Gray <william.gray@linaro.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=RqP6QjR5oTC6j42WuoSoTTRBG6hJG83IUJl3HfLS4T8=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv7UVDoMMvRFdaUMmzfeNufqSOcFOACR6hZoo0
 IdGsmiLamSJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+1FQAKCRDJC4p8Y4ZY
 plT0EACgaeZeRKiYQY5DeJGs750z10UQ2poe6YzS852KuFNtlgsQH4OUGhcKX20h92MdDYzGwE1
 13vPR9vrTWxO0BCa7NQbCRpLWntRITDhSDp5pWkylKb4UOnyZaKfYiQlMEiwm9aXWRZdOenCj8w
 0yzZSxtu45Urgf87cf9fCbesK8MnjhVezP0BVAZrOq0j/1g0q6Jfrr4AKnQ1EI0DhY/GSj2bUH1
 xfGqS+v1toJYzc0pdyoI2QWAvNPzK989/0B1svOyA4/9UDthHJPf6+0yI+HWB9ttG1JvMWqpnR1
 7yEKfFIDX7kt/0tpZQNUt+45R71RrjqEjauRYMOzkbJdA8hpza33zmPncdnBvIKObKbe/yKOBAK
 JVboMNmCcafPq/8hHMGBghsbKXxRbIJgIWYJlNJjcjthQ7rEScgWwz1KAb6M9jIu2r4Mxuu7Lrl
 xQ3/65sTHJ2l1gvRbt/87L7M4Ruf57WLLUqUiyVgP3Kj9SOOEFWXlXuaUfNg11t7DGdeBZCXZC1
 kKGGUgCpyOtyBGIT5vAPmFHPB96JXFrLI+hjcIOk6vJ4Y3ICMxRhBEt3h/Cd5p6pzzgSOUsgKMQ
 ZHNM+6CrBY9GiOZsDwzCGyj671tn8gi8O6iawXtCM7YYtv16/0hHCSBmOQEKAGGMLHSsAEB2aK6
 DfWlmVWJLfQVsAA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the counter_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/counter/counter-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index 09c77afb33ca..f6a939d51171 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -53,7 +53,7 @@ static struct device_type counter_device_type = {
 	.release = counter_device_release,
 };
 
-static struct bus_type counter_bus_type = {
+static const struct bus_type counter_bus_type = {
 	.name = "counter",
 	.dev_name = "counter",
 };

---
base-commit: 0b3bbd8f9baf245ec77d86f6f5bc902105b4bfa9
change-id: 20240204-bus_cleanup-counter-7ea21a4a4abd

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


