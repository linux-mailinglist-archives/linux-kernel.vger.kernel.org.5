Return-Path: <linux-kernel+bounces-51785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA9D848F45
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4204E283A50
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDD0249E6;
	Sun,  4 Feb 2024 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="oQtL5POX"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A7322EEA;
	Sun,  4 Feb 2024 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707064157; cv=none; b=fUzBqZptbxUVwLfcepCkk+cg3ZkHPh1nsQbj8H/QlL3NrsABBqYUS8BaYmEYxio0gNgPvvsvo0wzHYWIbUpLupaFQVEr9i6fkVFP/u7ei362GGZE5lpuT9ggw7zfTy1kadH0olIwX0daB/8x2T4yeLN2dTZT4bM+bJU87rcOekw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707064157; c=relaxed/simple;
	bh=7Aa3vHYQq1Cas6qCMgssrF4OfAvkTLYL4PbhRMnJOpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q0lPojIYvnQIQ1WZJADxOKIkDf95OzyMr91Szye5xwKVIxUis7HEn0P2AlIXMraBDRN4w2pUaalU9WmJ6jWF97+ITPQykLkQpAyRtlsez7IQrDg5Mgm1i65vFPaOBLiZOUtAGinZYZX9YWGc6AFB3sYGTYwKQSgDqmzuOjaN2ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=oQtL5POX reason="key not found in DNS"; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-595aa5b1fe0so2523402eaf.2;
        Sun, 04 Feb 2024 08:29:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707064154; x=1707668954;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkEWH6gvNpDijd7cA4NPnUTuDEXBhNQ1QH3JdnlFRIg=;
        b=RLnPwXRTyxpB3TaONGBZtZvZJ6OC/FKf4QuO+PEw9SNJE3zvQnHnmS1nfcX2OOsi2U
         02bBvmhTf/b0XGpViPYwUPAwVm2MNmTJvO28gGOhGZTO5vJ2zzTMF59NMkpPufyfaH93
         ENS/+BzG2BT9XzPANLznFISHAcRSOPHHa0bqES2uafDHJfsBEvezKiuo4gZh3myDpRkB
         GHXW4DM3ey8PH9T3KXzyXp/ukz91dmLX+IFdCpbmJNx/K68jKTNlGtDBnAS+Um07wA0k
         gwix75JfD4RKnMTIZkjs0qOocv5083+SwQ20dZc9QJnmMzql2Jos5w9ldLVLpAOQxkd6
         jYPQ==
X-Gm-Message-State: AOJu0YwgR84dM79QKjmQgVeU9rM2nG6L2YUSej8lGEwcMvELT2wZ+lLJ
	CKodDuEH7L+p83z/ISBfPXRoVyoTWJWhKRYmMJ7WZfkR2ZvML3lTVj3beciHsOi22Q==
X-Google-Smtp-Source: AGHT+IFDd/2hkl8QGVjFRhHVZTK6ORjYHDAKtWp7a58YWgyhQvTjSfM3ja8SuDBFix4LeKYkEzYskQ==
X-Received: by 2002:a05:6358:7e13:b0:178:778a:30e1 with SMTP id o19-20020a0563587e1300b00178778a30e1mr16107803rwm.11.1707064154123;
        Sun, 04 Feb 2024 08:29:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUrYVc2ig8vzFUVeWoc6V4P/bVaX7DS/UP63Ko5rlj/MrCPLREYUbp7wugUcViWySfIxUIOU8aPGdyrRji8q8Gt9SxNfvntKg4i2PsWz1hsPJeo0Ixl1l4/QoB+Ub3Jo5glUXI+OwXSAYlx6rbWpvQUBMqkGBlmUA==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id g3-20020aa79dc3000000b006e02eb7fb05sm2359374pfq.160.2024.02.04.08.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 08:29:13 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707064151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wkEWH6gvNpDijd7cA4NPnUTuDEXBhNQ1QH3JdnlFRIg=;
	b=oQtL5POX6P4wsS9sk+vECFOCc1zVsFHanQzNpYbPLrASGnrcid4tCmdexHx2sYu5I924Kf
	+rqLpOvdq0jTqEKIUByuHHwE7uA3MoTnIEYIF18mR4R0xNkcUbLqqVZw6ObQfxO14GENQm
	gBr3CY2pnhuz2NBvdD0ENQOAfxO65o7sYii3IAfUW4fmAoP563gNjPxcZdFApGosp926aT
	z4GIQMLaBicp0jBXjTVeLYgKPFt3OI4c8Sx6KV+fv+rugGhfBIwC7B1ZNG51q6GQ31i+tS
	XFfkU+lSi4fjNSQVv3b1P/ectK7hoB/V9cfrWtr0wdBBgKG+GAk8WkkqNRpKvw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 13:29:42 -0300
Subject: [PATCH] gpio: gpiolib: make gpio_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-gpio-v1-1-82d91b4ee1de@marliere.net>
X-B4-Tracking: v=1; b=H4sIAHW7v2UC/x3MQQqAIBBA0avErBPMjKKrRMRUkw2EimIE0t2Tl
 m/xf4ZIgSnCWGUIdHNkZwuauoLtRGtI8F4MSiotldRiTXHZLkKbvDCeneh6Ihz2VmGHUDIf6OD
 nX07z+34nU20CYgAAAA==
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1075; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=7Aa3vHYQq1Cas6qCMgssrF4OfAvkTLYL4PbhRMnJOpM=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv7t262tpxtjoDfiGTQJSHx4/rnZhb6DFY3+It
 uP1aECE3ZeJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+7dgAKCRDJC4p8Y4ZY
 pkf2D/9SUPLxQHC4Wa76gTRLTGHSDdWvDnfklXGa3QPBrZwKCUooTXmdeAmFsB5IVTMvYWwEFtm
 VqEp94xV2R3yDrXaChSnrTtO5UkWGRxI2DGHLpt2+wM3bbDegPWHso2hArkbK1xyIok0FVEil8G
 7VvhQf9Yoeom7etDEW4QPbUEJ41W9gUPs0clWRVWrpBl5iAcDqd4DrXNaEWG9MCA2GhxjXu7imk
 LKe2xxRuPsWjxIECqfNoctz8n9PIH9iGhv5YKbXDelUaWJ3GMa449RqGWxsm1Knjb+XoZxNts40
 14X3WDae1Jy0qGqHii5GAdG/x2C7QqOuXQaCW59Tdobv7u8oY8PzDVQa+GDk8PIVmpdqC6KJPHl
 vGNX7RmPqdP3mRSq5mg0c+HGiCNYLcls7/mipdFp59NKIuqUxuJaSztMfKXyR7q9tcaJXEhtmPL
 Ae4ctUQ37QK6smHQGYqyiR1kSuQabtBwGLaYTmi4p3nm5HEucCa7381BL4ZdpHpqEPQs68lpZV6
 9iXV+JqnRhX4K96g5N3p3jWzmMXfPBSDz79pc1+K1Czswfej+oBYK04Aw7rnJBaDOn/bWuT38U+
 W9b1LWnXOrcqGPzS7mw5L5xgzvvRP5J8YTEFYjS9K0o+88ZSifj6n+ESy/i+tSbjAr4JfpCZqVt
 /6xNfXm02LIcQvg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the gpio_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d50a786f8176..24d046268a01 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -63,7 +63,7 @@ static int gpio_bus_match(struct device *dev, struct device_driver *drv)
 	return 1;
 }
 
-static struct bus_type gpio_bus_type = {
+static const struct bus_type gpio_bus_type = {
 	.name = "gpio",
 	.match = gpio_bus_match,
 };

---
base-commit: 3eac8bbed22e940ac1645a884f221bef408f675c
change-id: 20240204-bus_cleanup-gpio-57eea8d32a5a

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


