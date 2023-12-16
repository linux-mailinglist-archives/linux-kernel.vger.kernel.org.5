Return-Path: <linux-kernel+bounces-2284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF078815A84
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F911C2195A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733EE30CE1;
	Sat, 16 Dec 2023 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbECb8HP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D7D1EB52;
	Sat, 16 Dec 2023 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ceb93fb381so1232555b3a.0;
        Sat, 16 Dec 2023 08:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702745586; x=1703350386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z9kJnXswXfwZRpGAgHlHvXdSZEjrLXGfY7XqoPuhNfg=;
        b=VbECb8HPPY7YIAaqJIaVzET8LtDhn6WuZnwj1ERlHqKPhmkPAXQLBC8ilLP3nQMsQi
         mrlmK2G9ZDpBzI9l7JQNCagQU+v8XvvDPrTSwXv7fQ3OV+a7KhGB31H7Yr9aiNLRYjaA
         sIgvifBR5RZo16RyBIRVV3Xtkk6PO6uGit6ERJny6dJFQwtPnd0HsHog8W8VdtbFaKVF
         /XJ1OR9E7Jd/+yKLR2P4ykOYrId6TghCfMdpSjgTc0aSqDrn+XxJhzEUtJ0Gslm196hN
         YdSIymUq2JnCM2Y/9fWXYSRNehdDXjpqMCQloQsV7VbFdQ6gGalRtreTTmEZZOuz0e0G
         J02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702745586; x=1703350386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z9kJnXswXfwZRpGAgHlHvXdSZEjrLXGfY7XqoPuhNfg=;
        b=KTy3QU/ckI6tSqfOJlxmNdibGgouPCPubHNSX3T2/l9T987rmPnUZGwBxYRv6Yza4d
         j2Ps1kreVMBxHMbeEJGmp7JevSzQfSFUkMckQaF7ZvPRJBtWQ5CoSHfBojc2ugF1qkID
         Zs1aTbLuz6myUGVzaiwK7BsZv2AYJEpAHqWTzm8ooEsJwV/1CECqrfPcJgAyYIh9zOSo
         +/OunFmh/PmbgcfRIYWehqS+s0iuDk7DCF7qrs/O9PGw53EYiaTi4aTI4cbN0h7e269w
         h9DzEZ5CDkg7ARiGHEMIi40rEnoHGB/2RJeKyg1UCfORZg+RdRnATwuC1FxZpsRnHr/E
         2hLw==
X-Gm-Message-State: AOJu0Ywrdl1c9d3OaP5HwRYp1V5orIsjKDjx+Rrkl6yDFe0XG+ZDHJPy
	n8yqhAxQrTF+AHO2OOi7IFY=
X-Google-Smtp-Source: AGHT+IH1/XwA7R5JtrcvCzMT+CQxl4QuPIxTtIQNhhvm+3IcVyzHxjTcYlHQ5Uax9SMPyR1jeE1gPA==
X-Received: by 2002:a05:6a00:c93:b0:6ce:4d11:4e32 with SMTP id a19-20020a056a000c9300b006ce4d114e32mr16810857pfv.27.1702745585526;
        Sat, 16 Dec 2023 08:53:05 -0800 (PST)
Received: from localhost.localdomain (1-170-85-161.dynamic-ip.hinet.net. [1.170.85.161])
        by smtp.googlemail.com with ESMTPSA id s9-20020a056a00178900b006ce789d8022sm15229743pfg.59.2023.12.16.08.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:53:05 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: Jes.Sorensen@gmail.com
Cc: kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com,
	zenmchen@gmail.com
Subject: [PATCH v2] wifi: rtl8xxxu: Add additional USB IDs for RTL8192EU devices
Date: Sun, 17 Dec 2023 00:52:57 +0800
Message-ID: <20231216165259.5389-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add additional USB IDs found in the vendor driver from
https://github.com/Mange/rtl8192eu-linux-driver to support more
RTL8192EU devices.

Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
v2:
 - Not to put these USB IDs in CONFIG_RTL8XXXU_UNTESTED
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 43ee7592bc6e..3f30795f9375 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -7732,12 +7732,24 @@ static const struct usb_device_id dev_table[] = {
 /* TP-Link TL-WN822N v4 */
 {USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0108, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192eu_fops},
+/* D-Link DWA-131 rev C1 */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3312, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192eu_fops},
 /* D-Link DWA-131 rev E1, tested by David Patiño */
 {USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3319, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192eu_fops},
 /* Tested by Myckel Habets */
 {USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0109, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192eu_fops},
+/* TP-Link TL-WN8200ND V2 */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0126, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192eu_fops},
+/* Mercusys MW300UM */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x0100, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192eu_fops},
+/* Mercusys MW300UH */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x0104, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192eu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0xb720, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8723bu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xa611, 0xff, 0xff, 0xff),
-- 
2.43.0


