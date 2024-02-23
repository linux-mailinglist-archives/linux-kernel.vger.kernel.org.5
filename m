Return-Path: <linux-kernel+bounces-79221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2733861F20
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7957E287E31
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A457914CABD;
	Fri, 23 Feb 2024 21:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKczm5M9"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A85145B1B;
	Fri, 23 Feb 2024 21:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708724378; cv=none; b=teeor1z+xL6o5oFbIpVXwkbGQtD7Cc0SbOyK54Luj+7Pc+pQooHK4rTDyaafBuDq4byynpbzrtaRyRtIBcLF8N2yTkhhgZggto0cOUx3C+chPr4AFXVyn/RiIlM/c8Ki5uypgDX7wVGyDW9K8KXFNiEcvLwoaLXXA1fmCtvWrr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708724378; c=relaxed/simple;
	bh=sOUw0EI0A2XpPLgKATy5HO7GEagZ+UA30b2qbtJAt6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c84QQyfpZopW8YDCgK5aZ2vGUlKUtaruW22wPCE7pAyWTBq6niOHblCVRISMSTCll8+d6shfa3EriDq3axkUxeNp+zx6fJ3rLyEhTdSIdBaFWZIY5z+SPVeeIkoBIDh/TMjGMUBDi6N1TEGdz8tSgtEK5qLUHo5mvqHXH30MFAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKczm5M9; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512e733a525so822287e87.0;
        Fri, 23 Feb 2024 13:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708724375; x=1709329175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Lfyr9SJ9Apv/iNGQwbzBDI0ZB8HAoTSS9c30HeXXsY=;
        b=FKczm5M9E9vunlq0hM1WL9ouD5bQ6tIdQsvnIJ6zx0n0PUwccjcmJssLMIg34uGFRL
         BUEoNZ8xeUjqM1zZYHg44aFQrIjXjbloLWiTfXzDeFMj0SW+dflL2LfqvoRyeI5rGuSh
         w9hUVnEeePLKqK/P68ZvOe1gSxxEzAMgt+J/fLYOSdhxcbZc737WqAPfn4s7bQ69nmUh
         FufhX2np87xiKSk+li8va0SoMlOVH7Zsof1hIdTih0C/DZadSkxFrtq1I4dm4WUy0SrD
         YgfnSgjaaZoNirDm4hUIyTQ0KGrja5BkRPNGBHNV+FGpD3A6B2AXadzOR9Ry90bsnzcL
         B+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708724375; x=1709329175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Lfyr9SJ9Apv/iNGQwbzBDI0ZB8HAoTSS9c30HeXXsY=;
        b=rJJ8WW+t/eKh+fEqbwLTFZKZ6GsjPwFSNWCyAlMWfLmx3XsU4U8a8jAVEeRkQ3ibZ3
         b96wkQYFvRSVoyyLr0y1U1raH027gJyV4DE0O/G81WEW85NsRoPT7P6YfBP+Do3g/jcv
         KJZ1JNJgBn0PNy1G/thhH3FAUCvikhfcha+j5ID1pap5FcNgI4k7t4ElOwcvvLZgWc4f
         dBey7iHlMvGj35vab38TLB8iN5dbIyfOSlZk4ue0YE39FLCOtQ7zhDH8ECFs6Ag0maaE
         6lHC9wTcbNt/p9Uf6ReLWKeq4wMVCqNyB6FpCiGED+qVhriGZsXpTh5N82cO491tyFs3
         GV2w==
X-Forwarded-Encrypted: i=1; AJvYcCUv6nTpx+E95Pu7JCcVK54aNgv1ZN4ReNwXPY/zc5fYzefM8b54J6ZMb8ZlQgrpXe4J1i4SNrx7yTS99+dX2SI0SmHYUEX7w3bXiYM3WEs6X5v0CxxxoZG8sFb9gzH3V+hD/YSZREdgPBwicPJg
X-Gm-Message-State: AOJu0YwG+VyUTuXLsP8+iJp/yDCZoe25MWkFdyWxPW5pqMSkVIRK3wCX
	j2Zh/1bxo7D6FpJsZaX5Epy8VPkkxLl1QSzBtMwEnGn6g/wqQjFQ
X-Google-Smtp-Source: AGHT+IG7uwgcy2hRZyF/L1Z+9GG3qzqoKMOqijWeToDnFV18Fn1dGAbPkM11LUe/boJFFVRFRQjfkA==
X-Received: by 2002:a05:6512:ba2:b0:511:9ca5:63f with SMTP id b34-20020a0565120ba200b005119ca5063fmr366853lfv.21.1708724375052;
        Fri, 23 Feb 2024 13:39:35 -0800 (PST)
Received: from localhost.localdomain ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id i1-20020ac25b41000000b005114ee99515sm2584897lfp.220.2024.02.23.13.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:39:34 -0800 (PST)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Hilda Wu <hildawu@realtek.com>,
	Alex Lu <alex_lu@realsil.com.cn>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Arnaud Ferraris <arnaud.ferraris@collabora.com>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH 1/2] Bluetooth: hci_h5: Add ability to allocate memory for private data
Date: Sat, 24 Feb 2024 00:37:03 +0300
Message-ID: <20240223213704.290849-2-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223213704.290849-1-andrej.skvortzov@gmail.com>
References: <20240223213704.290849-1-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some cases uart-base drivers may need to use priv data. For
example, to store information needed for devcoredump.

Fixes: 044014ce85a1 ("Bluetooth: btrtl: Add Realtek devcoredump support")
Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---
 drivers/bluetooth/hci_h5.c     |  4 +++-
 drivers/bluetooth/hci_serdev.c |  9 +++++----
 drivers/bluetooth/hci_uart.h   | 12 +++++++++++-
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 71e748a9477e..b66136348bd6 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -113,6 +113,7 @@ struct h5_vnd {
 	int (*suspend)(struct h5 *h5);
 	int (*resume)(struct h5 *h5);
 	const struct acpi_gpio_mapping *acpi_gpio_map;
+	int sizeof_priv;
 };
 
 struct h5_device_data {
@@ -863,7 +864,8 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 	if (IS_ERR(h5->device_wake_gpio))
 		return PTR_ERR(h5->device_wake_gpio);
 
-	return hci_uart_register_device(&h5->serdev_hu, &h5p);
+	return hci_uart_register_device_priv(&h5->serdev_hu, &h5p,
+					     h5->vnd->sizeof_priv);
 }
 
 static void h5_serdev_remove(struct serdev_device *serdev)
diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 39c8b567da3c..214fff876eae 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -300,8 +300,9 @@ static const struct serdev_device_ops hci_serdev_client_ops = {
 	.write_wakeup = hci_uart_write_wakeup,
 };
 
-int hci_uart_register_device(struct hci_uart *hu,
-			     const struct hci_uart_proto *p)
+int hci_uart_register_device_priv(struct hci_uart *hu,
+			     const struct hci_uart_proto *p,
+			     int sizeof_priv)
 {
 	int err;
 	struct hci_dev *hdev;
@@ -325,7 +326,7 @@ int hci_uart_register_device(struct hci_uart *hu,
 	set_bit(HCI_UART_PROTO_READY, &hu->flags);
 
 	/* Initialize and register HCI device */
-	hdev = hci_alloc_dev();
+	hdev = hci_alloc_dev_priv(sizeof_priv);
 	if (!hdev) {
 		BT_ERR("Can't allocate HCI device");
 		err = -ENOMEM;
@@ -394,7 +395,7 @@ int hci_uart_register_device(struct hci_uart *hu,
 	percpu_free_rwsem(&hu->proto_lock);
 	return err;
 }
-EXPORT_SYMBOL_GPL(hci_uart_register_device);
+EXPORT_SYMBOL_GPL(hci_uart_register_device_priv);
 
 void hci_uart_unregister_device(struct hci_uart *hu)
 {
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index fb4a2d0d8cc8..68c8c7e95d64 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -97,7 +97,17 @@ struct hci_uart {
 
 int hci_uart_register_proto(const struct hci_uart_proto *p);
 int hci_uart_unregister_proto(const struct hci_uart_proto *p);
-int hci_uart_register_device(struct hci_uart *hu, const struct hci_uart_proto *p);
+
+int hci_uart_register_device_priv(struct hci_uart *hu,
+				  const struct hci_uart_proto *p,
+				  int sizeof_priv);
+
+static inline int hci_uart_register_device(struct hci_uart *hu,
+					   const struct hci_uart_proto *p)
+{
+	return hci_uart_register_device_priv(hu, p, 0);
+}
+
 void hci_uart_unregister_device(struct hci_uart *hu);
 
 int hci_uart_tx_wakeup(struct hci_uart *hu);
-- 
2.43.0


