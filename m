Return-Path: <linux-kernel+bounces-165961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F9A8B93E0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76BE21F2191F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748A51C696;
	Thu,  2 May 2024 04:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJNw7TW7"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF3912E75;
	Thu,  2 May 2024 04:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714623981; cv=none; b=hl+gqo5/wStmYlI0eV1ZFkjt86EfS3M5+oOkIGJG8V1itlC8p0NOGxQGURWQurcKrYOWKeaDtKrGkdr/f6EY4/Y90lG0LznjRFGHlgrLsf8LpR9NHnXxoPOD+mRsFdC3jX+VwpbrxkPuCm+Ja5/hBseN1WoVaNXwlgxh1/OVU2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714623981; c=relaxed/simple;
	bh=hOGvMhnMGIslAPT4/IyMobqnJTj0q/QjAOxGjXzxvvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LnQ0knUIl4D0ci8Z/zPzXM+l7mJig0AnsXHjEut57KAdEG/wXmw6+CDS5PsMTzN9FKBuy5UkQlxUxyfShNB8tJYPyCAv7Xws63A+07qj7DddTPvvitIG59Idn+9IG+o9B2cKrlF356SMdBlQJkFfhlnXOQ4fOBv//l3lwEb/Keg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJNw7TW7; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed32341906so6906552b3a.1;
        Wed, 01 May 2024 21:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714623979; x=1715228779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EwkkbR5jtlRIqs4q7AIXw2usBpBG0ifKeFkcWSpVJKg=;
        b=kJNw7TW7N1SGTmSe2LGafV+BCxbmoX1Sz25vW4v3ecGama3LImHhiqQ6LEYe9lwQpE
         uAwi987gheUkmKUbqCAZRc870Z/aQaMECR3RpvoWZLfrb4/BDPaAbwc6YnO/gAWvOKhA
         B8qD8oDSVc9IsTnroWBnRzVuk6kM0B1ASZerX2c31oHhh1cbvn1ZNRUYnXUvDcknhAWw
         c6HnnMaxijji8V9A3rchx1HpCgjqtr1sGaqakzun7rOZLXD5yzG4oXSYkoRLfkc1By3Q
         DzCIGZQ0YZ6M540gEwprcwHLVBshFfGmFrr/DwWedq6/Wc2NcslQxyQxvCQUxPzZbVGg
         4T3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714623979; x=1715228779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EwkkbR5jtlRIqs4q7AIXw2usBpBG0ifKeFkcWSpVJKg=;
        b=PoLAWbJ6oxBS6YpPGij/PhYq6RKU9lr7icvj2eyEvSEeaVQEyO1ghBxaTdzWPvfVcy
         p5Ega/VsKwd9x9npLUPien4uIbp7zjPkzTmm/JaIzbki+KhFcw5PvhBukY1UH0rHp0Ta
         5Brvmlo4juxTJ4KtwEHSdHmTtUWoaaxNBFJk/rmUSlusvfVLS1R554IevWfCv4yZSpv9
         GdN/cDskVmx6vHPNErdII7Ijq0Ck4WPEv258q6d1UNIn5bUd+4hmqaCPgm4+ihp646v7
         +OtBp0tjZ/9/do3xD5tTOAAwNZUYN+8z9T5xMIP0faRhXw2giNDp3syrV7i4OAuoT3dT
         x8AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpq7exCm5iBcLt9MCg9N2M6md8G5u92ZaQYS7LAreURlz7dyvvgWVpuHn3imwi17lu53HsuvUSKaaTYpslMnrdXcb22UCAKop+HEei
X-Gm-Message-State: AOJu0Yx35hJqKJjPg0h7fT1Y9Aqj2uk34b8Op8UyKjckptQgzKXdl2LI
	qwxn+Pmo7zslEXVNdv7NnbB8c0ZuyXfp+46v7XPyEWJeSt/N7z1CloFXep5f
X-Google-Smtp-Source: AGHT+IG4PgaSwzaK6+7hFUQOu+rxr0FyUvsjjwsL7hVMRZUeExH+MX1v1bZPU4bL/uSjofjTYZuDrw==
X-Received: by 2002:a05:6a00:3d06:b0:6ec:ec8f:d588 with SMTP id lo6-20020a056a003d0600b006ecec8fd588mr1191606pfb.16.1714623977870;
        Wed, 01 May 2024 21:26:17 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.201])
        by smtp.gmail.com with ESMTPSA id k3-20020a633d03000000b005f80080586asm192387pga.93.2024.05.01.21.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 21:26:17 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: linux-input@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: kye: Change Device Usage from Puck to Mouse
Date: Thu,  2 May 2024 12:23:31 +0800
Message-ID: <20240502042335.15611-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change device type because
a. it is exactly a mouse, with left/right buttons and scroll wheel;
b. it does not have visible marks or crosshairs, thus does not provide
higher accuracy than stylus.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/hid/hid-kye.c | 75 +++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 31 deletions(-)

diff --git a/drivers/hid/hid-kye.c b/drivers/hid/hid-kye.c
index eb9bf2829937..70ceb9437332 100644
--- a/drivers/hid/hid-kye.c
+++ b/drivers/hid/hid-kye.c
@@ -209,7 +209,7 @@ static const __u8 pensketch_t609a_control_rdesc[] = {
 	0xC0               /*  End Collection            */
 };
 
-/* Fix indexes in kye_tablet_fixup if you change this */
+/* Fix indexes in kye_tablet_fixup() if you change this */
 static const __u8 kye_tablet_rdesc[] = {
 	0x06, 0x00, 0xFF,             /*  Usage Page (FF00h),             */
 	0x09, 0x01,                   /*  Usage (01h),                    */
@@ -262,12 +262,16 @@ static const __u8 kye_tablet_rdesc[] = {
 	0x27, 0xFF, 0x07, 0x00, 0x00, /*      Logical Maximum (2047),     */
 	0x81, 0x02,                   /*      Input (Variable),           */
 	0xC0,                         /*    End Collection,               */
-	0xC0,                         /*  End Collection,                 */
-	0x05, 0x0D,                   /*  Usage Page (Digitizer),         */
-	0x09, 0x21,                   /*  Usage (Puck),                   */
+	0xC0                          /*  End Collection,                 */
+};
+
+/* Fix indexes in kye_tablet_fixup() if you change this */
+static const __u8 kye_tablet_mouse_rdesc[] = {
+	0x05, 0x01,                   /*  Usage Page (Desktop),           */
+	0x09, 0x02,                   /*  Usage (Mouse),                  */
 	0xA1, 0x01,                   /*  Collection (Application),       */
 	0x85, 0x11,                   /*    Report ID (17),               */
-	0x09, 0x21,                   /*    Usage (Puck),                 */
+	0x09, 0x01,                   /*    Usage (Pointer),              */
 	0xA0,                         /*    Collection (Physical),        */
 	0x05, 0x09,                   /*      Usage Page (Button),        */
 	0x19, 0x01,                   /*      Usage Minimum (01h),        */
@@ -280,7 +284,7 @@ static const __u8 kye_tablet_rdesc[] = {
 	0x95, 0x04,                   /*      Report Count (4),           */
 	0x81, 0x01,                   /*      Input (Constant),           */
 	0x05, 0x0D,                   /*      Usage Page (Digitizer),     */
-	0x09, 0x32,                   /*      Usage (In Range),           */
+	0x09, 0x37,                   /*      Usage (Data Valid),         */
 	0x95, 0x01,                   /*      Report Count (1),           */
 	0x81, 0x02,                   /*      Input (Variable),           */
 	0x05, 0x01,                   /*      Usage Page (Desktop),       */
@@ -317,7 +321,7 @@ static const struct kye_tablet_info {
 	__s32 y_physical_maximum;
 	__s8 unit_exponent;
 	__s8 unit;
-	bool has_punk;
+	bool has_mouse;
 	unsigned int control_rsize;
 	const __u8 *control_rdesc;
 } kye_tablets_info[] = {
@@ -402,7 +406,7 @@ static __u8 *kye_consumer_control_fixup(struct hid_device *hdev, __u8 *rdesc,
 static __u8 *kye_tablet_fixup(struct hid_device *hdev, __u8 *rdesc, unsigned int *rsize)
 {
 	const struct kye_tablet_info *info;
-	unsigned int newsize;
+	__u8 *newdesc = rdesc;
 
 	if (*rsize < sizeof(kye_tablet_rdesc)) {
 		hid_warn(hdev,
@@ -420,36 +424,45 @@ static __u8 *kye_tablet_fixup(struct hid_device *hdev, __u8 *rdesc, unsigned int
 		return rdesc;
 	}
 
-	newsize = info->has_punk ? sizeof(kye_tablet_rdesc) : 112;
-	memcpy(rdesc, kye_tablet_rdesc, newsize);
-
-	put_unaligned_le32(info->x_logical_maximum, rdesc + 66);
-	put_unaligned_le32(info->x_physical_maximum, rdesc + 72);
-	rdesc[77] = info->unit;
-	rdesc[79] = info->unit_exponent;
-	put_unaligned_le32(info->y_logical_maximum, rdesc + 87);
-	put_unaligned_le32(info->y_physical_maximum, rdesc + 92);
-	put_unaligned_le32(info->pressure_logical_maximum, rdesc + 104);
-
-	if (info->has_punk) {
-		put_unaligned_le32(info->x_logical_maximum, rdesc + 156);
-		put_unaligned_le32(info->x_physical_maximum, rdesc + 162);
-		rdesc[167] = info->unit;
-		rdesc[169] = info->unit_exponent;
-		put_unaligned_le32(info->y_logical_maximum, rdesc + 177);
-		put_unaligned_le32(info->y_physical_maximum, rdesc + 182);
+	memcpy(newdesc, kye_tablet_rdesc, sizeof(kye_tablet_rdesc));
+
+	put_unaligned_le32(info->x_logical_maximum, newdesc + 66);
+	put_unaligned_le32(info->x_physical_maximum, newdesc + 72);
+	newdesc[77] = info->unit;
+	newdesc[79] = info->unit_exponent;
+	put_unaligned_le32(info->y_logical_maximum, newdesc + 87);
+	put_unaligned_le32(info->y_physical_maximum, newdesc + 92);
+	put_unaligned_le32(info->pressure_logical_maximum, newdesc + 104);
+
+	newdesc += sizeof(kye_tablet_rdesc);
+
+	if (info->has_mouse) {
+		if (newdesc + sizeof(kye_tablet_mouse_rdesc) > rdesc + *rsize)
+			hid_err(hdev, "control desc unexpectedly large\n");
+		else {
+			memcpy(newdesc, kye_tablet_mouse_rdesc, sizeof(kye_tablet_mouse_rdesc));
+
+			put_unaligned_le32(info->x_logical_maximum, newdesc + 44);
+			put_unaligned_le32(info->x_physical_maximum, newdesc + 50);
+			newdesc[55] = info->unit;
+			newdesc[57] = info->unit_exponent;
+			put_unaligned_le32(info->y_logical_maximum, newdesc + 65);
+			put_unaligned_le32(info->y_physical_maximum, newdesc + 70);
+
+			newdesc += sizeof(kye_tablet_mouse_rdesc);
+		}
 	}
 
 	if (info->control_rsize) {
-		if (newsize + info->control_rsize > *rsize)
-			hid_err(hdev, "control rdesc unexpectedly large");
+		if (newdesc + info->control_rsize > rdesc + *rsize)
+			hid_err(hdev, "control desc unexpectedly large\n");
 		else {
-			memcpy(rdesc + newsize, info->control_rdesc, info->control_rsize);
-			newsize += info->control_rsize;
+			memcpy(newdesc, info->control_rdesc, info->control_rsize);
+			newdesc += info->control_rsize;
 		}
 	}
 
-	*rsize = newsize;
+	*rsize = newdesc - rdesc;
 	return rdesc;
 }
 
-- 
2.43.0


