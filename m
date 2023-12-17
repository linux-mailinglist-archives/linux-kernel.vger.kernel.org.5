Return-Path: <linux-kernel+bounces-2576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F281815F00
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FDD81F21FAD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AFD3528F;
	Sun, 17 Dec 2023 12:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7M8siJZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEDA341AC;
	Sun, 17 Dec 2023 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d099d316a8so2036688b3a.0;
        Sun, 17 Dec 2023 04:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702816225; x=1703421025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uj2/vEASdfQFfYYxCwA+Fiegf94zykA3Ey5h7VNktmk=;
        b=T7M8siJZEz5TjTJbXogSjNTuuxAN8XI5RXHhosTgi0wzoPpUTNCMYVoQ+/Ep/Ky+hs
         CB3ueNkKOFWBqDQjVTVPDLPx1bT/+TjYz3JCwyq5iIsWejNvXbseCtNe/TANOzei+901
         iTz0+Bk5xfn3l+72tzGHlzrFDfe1v6/3+cnfRQoP9n7glKdeTUQNjNGh9upi+Hg1xfJi
         jZGHRg+JJE8w1/4j6IHqkhgtb0t4hyfkhQh1hO8shbdxKwygcP1oXtFADmaBIoQ/89zS
         ezRLaE1Jrm6ddDrDt91qKK3fQWHYgehL4O0k/0HTsX6BwpyZbz9ghBqbHw4QVWyGLXCF
         PJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702816225; x=1703421025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uj2/vEASdfQFfYYxCwA+Fiegf94zykA3Ey5h7VNktmk=;
        b=MetK4NZ7/OzO9QZVzeAwWhcU2Ze3wQb6FsghRe8680GcAGyiGgP1W2RBRMBwPGzLxP
         4UzJqbRSupMaoudIZ3mURvhOzvbiBhTbUb+gvSdSFsYUrx9QZFxImWkKDf6T2QGUsGRr
         CnOhNNHqqIKH3UcWbQtVgiGpsFsO2kNP1Ez6nv5UeoySg1mNOWmlCVsxEbwOIcw/NpYZ
         QW6vTXsDYpVqjTl/EvsgiD3KCc8PzHpfqvZyLP/gTpVhKyJUTkNjAgJpEpRVWqqHVUtX
         4TaIvGQniw99q0MD/RFhdNbP7SBhDCgW5NwRQ2P8P8S9AekSG223osSRxgbRDldS8PKD
         Djbg==
X-Gm-Message-State: AOJu0YxBYoILl/OyLHoSuDlOIPW9+RJnEN25jEo6KAu5nxFCazflStXo
	1MsiXqf5y3YiMsCurfy16Jg=
X-Google-Smtp-Source: AGHT+IHE75it6Lbva9RJWVrrY+w15y7xOeMx/zBLr/4a/9aPlII9c55FygKrPFkIc6lDaMFIiHKxGA==
X-Received: by 2002:a05:6a00:2f09:b0:6d4:2e66:6eb0 with SMTP id fe9-20020a056a002f0900b006d42e666eb0mr1994889pfb.13.1702816224582;
        Sun, 17 Dec 2023 04:30:24 -0800 (PST)
Received: from localhost.localdomain (1-170-84-144.dynamic-ip.hinet.net. [1.170.84.144])
        by smtp.googlemail.com with ESMTPSA id m3-20020aa78a03000000b006d4a9cac891sm1446334pfa.108.2023.12.17.04.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 04:30:23 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: Jes.Sorensen@gmail.com
Cc: kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com,
	Larry.Finger@lwfinger.net,
	Zenm Chen <zenmchen@gmail.com>
Subject: [PATCH v3] wifi: rtl8xxxu: Add additional USB IDs for RTL8192EU devices
Date: Sun, 17 Dec 2023 20:30:17 +0800
Message-ID: <20231217123017.1982-1-zenmchen@gmail.com>
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
v3:
 - Put these new USB IDs back into the CONFIG_RTL8XXXU_UNTESTED section
   as Larry Finger suggested.

v2:
 - Not to put these USB IDs in CONFIG_RTL8XXXU_UNTESTED
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


