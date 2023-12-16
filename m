Return-Path: <linux-kernel+bounces-2228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE968159F2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 15:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAA61C21907
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 14:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5592E83D;
	Sat, 16 Dec 2023 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLxe1MdQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3696125A4;
	Sat, 16 Dec 2023 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3ba04b9b103so1340119b6e.0;
        Sat, 16 Dec 2023 06:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702738647; x=1703343447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hkRi4pfUTqmLNnvEkk9LLtIYAZL2S2J+6ubcbFF9GZw=;
        b=OLxe1MdQjcUlGPUdw9gGMWYTjx+ar0pj/hMj2OnHQRbFPa7mBR0ukOlM7TbQ+zXw2S
         Zq4D3iqiMCvpyJIr8ZlpMKcQSVnc+NoFT7w0GSIJepdNa6bMfkeAKApSD3e7FLRv/g61
         qYiazxJ5N6M+1FGsg5TUmExWfytdGN2RVAAdUQTiVA/v4Hfpxru0UzRf9iT91tm7jX/X
         gGo34P0Go8OIcTmGEmg3MDW5juDPvMq9l7hYdvz3j/RTLNVA+CuSpG0Ta4jxJemV+uC4
         8Kqjq86tmGkxTtD07j8ejWdXkCmpvnUPPP9oBe65wkHS4z/Dwb5/bggrHz/KXrrusmMa
         lN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702738647; x=1703343447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hkRi4pfUTqmLNnvEkk9LLtIYAZL2S2J+6ubcbFF9GZw=;
        b=C3v8F+LC+IWtG0pr8kQhgdJWEP70RbpTKeOo/3JhHHqHFDYrkt/lJ7dcTjgXqHt2BB
         JmQKoGFGD5eDPuMA6z4++DlF5KXgCsWnNP2+Jxd/tPVATsGFZObPgwK8hZGiGczcDhwM
         JI1OX15F1C8AQeLNZz0anthVypQ8TDfO9tEQXdymhXYOlOnb2iydXGhqY52oThRWBaWW
         He4nB6l0L5EycRENZbL+QNTTHoaNJZtWJkOX0zlDvXsCvYDIV3HskGDz98SJH3at+kVx
         89Zw8SUUDfT3M8DdmRhuVuZOwyfaTiU97R1NDbQCdTQHZQjKHIrvclKrps20cXDZGIqy
         hwIA==
X-Gm-Message-State: AOJu0YwfPdl5YLi2BYnd/9jkFUZ4jeZF6VGmJIspWJi+qFXFXBkBT5F0
	ccsvTmK10LKL2GQcsgtCbyc=
X-Google-Smtp-Source: AGHT+IH3MFx9T6g8hbLIxlz9BAjQHRci7QpqCkxr5kfew6dsAYlQxVLjzKR4rrqhwkyTs7hEmCn1Cw==
X-Received: by 2002:a05:6808:1642:b0:3b9:efe8:b9f0 with SMTP id az2-20020a056808164200b003b9efe8b9f0mr17235825oib.55.1702738646854;
        Sat, 16 Dec 2023 06:57:26 -0800 (PST)
Received: from localhost.localdomain (1-170-85-161.dynamic-ip.hinet.net. [1.170.85.161])
        by smtp.googlemail.com with ESMTPSA id b11-20020a056a0002cb00b006ce4c7ba448sm1263527pft.25.2023.12.16.06.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 06:57:26 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: Jes.Sorensen@gmail.com
Cc: kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com,
	Zenm Chen <zenmchen@gmail.com>
Subject: [PATCH] wifi: rtl8xxxu: Add additional USB IDs for RTL8192EU devices
Date: Sat, 16 Dec 2023 22:56:55 +0800
Message-ID: <20231216145655.3772-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add additional USB IDs found in the vendor driver from
https://github.com/Mange/rtl8192eu-linux-driver to support more
RTL8192EU devices.

Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 43ee7592bc6e..180907319e8c 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -7961,6 +7961,18 @@ static const struct usb_device_id dev_table[] = {
 	.driver_info = (unsigned long)&rtl8192eu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x818c, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192eu_fops},
+/* D-Link DWA-131 rev C1 */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3312, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192eu_fops},
+/* TP-Link TL-WN8200ND V2 */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0126, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192eu_fops},
+/* Mercusys MW300UM */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x0100, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192eu_fops},
+/* Mercusys MW300UH */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x0104, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192eu_fops},
 #endif
 { }
 };
-- 
2.43.0


