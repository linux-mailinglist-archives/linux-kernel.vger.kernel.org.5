Return-Path: <linux-kernel+bounces-47061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C518448C0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC4E1F22CFF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2194E3FE35;
	Wed, 31 Jan 2024 20:23:01 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645733FE20;
	Wed, 31 Jan 2024 20:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732580; cv=none; b=We9LjKuIQ8yncrYcnpmilnvKu6VCo3pKT4KoZ+Y3BTKKr8z4jEbnzTG6Yi8W8zwP0TCRxVs0kyCI8D21nsyRZTDeTcr4X1AsZTlafR6eBdksJQIHmGsPMSaiNKOITAcgDeLfjWIwzvTK5hdXbt+RrcBNhOGVCnbOWuogeq+Rju0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732580; c=relaxed/simple;
	bh=kzei8YWWi1vwFBuTAKOyOGKxOcpujzjI9lYL/4wSxIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqBNcsHMQ7xEme2SHNmZ76lxodHlSqsBnTO+zE9Pwld8CevaJ2vaFXLotXueISFQrrY9wxyoz/OjQbIrSQ3wF/QGZeeyvXTroSJ7E+pRiClCgAzQgU4CFy0o0+muso8aKEqpjDNVElNzWNr9cq2XIDd/gUomyF4oVaxsbH9fZho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id DE4D41A0D9C;
	Wed, 31 Jan 2024 20:22:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id AB4256000C;
	Wed, 31 Jan 2024 20:22:40 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Sandeep C S <sandeep.cs@samsung.com>,
	Junwan Cho <junwan.cho@samsung.com>,
	Jitender Sajwan <jitender.s21@samsung.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] HID: samsung: Object size reduction and neatening
Date: Wed, 31 Jan 2024 12:21:37 -0800
Message-ID: <a96457094b0f0f9c5adf08df6b2e2cd4d2408793.1706732238.git.joe@perches.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706732238.git.joe@perches.com>
References: <cover.1706732238.git.joe@perches.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AB4256000C
X-Stat-Signature: witbnhdefiu1taqjw7z7potc8thxnxqm
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/sGWd9AtS21nJhxuYC7ToKxHkz4KvdAAw=
X-HE-Tag: 1706732560-721697
X-HE-Meta: U2FsdGVkX1/b8I9eB1qR9uZkl8WC4GRPRa7N2Fps1EcL3Es7JFYZ/dtGi/JXFdwxAItyPX+VP++rELgkiiP8WMJF7dwWqJ2lY0asEKYJ8JAUoNArtorjeBEHegFdO70DRqCSWgBKShHTTG3D66Ic+l4XgzfBDQojRBDl1nVHMrTvyF9HXmYUKNcGOqLDhRlYjCut1AopSPEhvCus6b6OZAW7o5vikaxBt2Jk+ky8QOGyNUP9Lv66QHXs7oXdnXMFhB1jEO/6cR1ne5lgIKumxnL4azIevcoQbCCmlApkWP/Vn6yXgVyxX31XO2jt6ceCyvSlpHusQf0=

Use a switch/case in samsung_input_mapping to reduce object size.

$ size drivers/hid/hid-samsung.o*
   text	   data	    bss	    dec	    hex	filename
   2842	    432	      0	   3274	    cca	drivers/hid/hid-samsung.o.new
   3203	    440	      0	   3643	    e3b	drivers/hid/hid-samsung.o.old

Miscellaneous style neatening:

o Use unsigned int instead of unsigned
o Alignment to open parenthesis
o Line wrapping

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/hid/hid-samsung.c | 166 +++++++++++++++++++++-----------------
 1 file changed, 94 insertions(+), 72 deletions(-)

diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
index d701dd3a914e7..63c18b9b8279f 100644
--- a/drivers/hid/hid-samsung.c
+++ b/drivers/hid/hid-samsung.c
@@ -49,31 +49,35 @@
  * Report #3 has an array field with logical range 0..1 instead of 1..3.
  */
 static inline void samsung_irda_dev_trace(struct hid_device *hdev,
-		unsigned int rsize)
+					  unsigned int rsize)
 {
 	hid_info(hdev, "fixing up Samsung IrDA %d byte report descriptor\n",
 		 rsize);
 }
 
 static __u8 *samsung_irda_report_fixup(struct hid_device *hdev, __u8 *rdesc,
-		unsigned int *rsize)
+				       unsigned int *rsize)
 {
-	if (*rsize == 184 && !memcmp(&rdesc[175], "\x25\x40\x75\x30\x95\x01", 6) &&
-			rdesc[182] == 0x40) {
+	if (*rsize == 184 &&
+	    !memcmp(&rdesc[175], "\x25\x40\x75\x30\x95\x01", 6) &&
+	    rdesc[182] == 0x40) {
 		samsung_irda_dev_trace(hdev, 184);
 		rdesc[176] = 0xff;
 		rdesc[178] = 0x08;
 		rdesc[180] = 0x06;
 		rdesc[182] = 0x42;
-	} else if (*rsize == 203 && !memcmp(&rdesc[192], "\x15\x00\x25\x12", 4)) {
+	} else if (*rsize == 203 &&
+		   !memcmp(&rdesc[192], "\x15\x00\x25\x12", 4)) {
 		samsung_irda_dev_trace(hdev, 203);
 		rdesc[193] = 0x01;
 		rdesc[195] = 0x0f;
-	} else if (*rsize == 135 && !memcmp(&rdesc[124], "\x15\x00\x25\x11", 4)) {
+	} else if (*rsize == 135 &&
+		   !memcmp(&rdesc[124], "\x15\x00\x25\x11", 4)) {
 		samsung_irda_dev_trace(hdev, 135);
 		rdesc[125] = 0x01;
 		rdesc[127] = 0x0e;
-	} else if (*rsize == 171 && !memcmp(&rdesc[160], "\x15\x00\x25\x01", 4)) {
+	} else if (*rsize == 171 &&
+		   !memcmp(&rdesc[160], "\x15\x00\x25\x01", 4)) {
 		samsung_irda_dev_trace(hdev, 171);
 		rdesc[161] = 0x01;
 		rdesc[163] = 0x03;
@@ -82,19 +86,21 @@ static __u8 *samsung_irda_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 }
 
 struct key_clear_map {
-	unsigned use;
+	unsigned int use;
 	__u16 kb;
 };
 
 static int samsung_kbd_mouse_input_mapping(struct hid_device *hdev,
-	struct hid_input *hi, struct hid_field *field, struct hid_usage *usage,
-	unsigned long **bit, int *max)
+					   struct hid_input *hi,
+					   struct hid_field *field,
+					   struct hid_usage *usage,
+					   unsigned long **bit, int *max)
 {
 	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
 	unsigned short ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
 	int i;
-	unsigned use;
-	unsigned up = usage->hid & HID_USAGE_PAGE;
+	unsigned int use;
+	unsigned int up = usage->hid & HID_USAGE_PAGE;
 	static const struct key_clear_map kcm[] = {
 		{ 0x183, KEY_MEDIA },
 		{ 0x195, KEY_EMAIL },
@@ -129,12 +135,14 @@ static int samsung_kbd_mouse_input_mapping(struct hid_device *hdev,
 }
 
 static int samsung_kbd_input_mapping(struct hid_device *hdev,
-	struct hid_input *hi, struct hid_field *field, struct hid_usage *usage,
-	unsigned long **bit, int *max)
+				     struct hid_input *hi,
+				     struct hid_field *field,
+				     struct hid_usage *usage,
+				     unsigned long **bit, int *max)
 {
 	int i;
-	unsigned use;
-	unsigned up = usage->hid & HID_USAGE_PAGE;
+	unsigned int use;
+	unsigned int up = usage->hid & HID_USAGE_PAGE;
 
 	if (!(up == HID_UP_CONSUMER || up == HID_UP_KEYBOARD))
 		return 0;
@@ -193,12 +201,14 @@ static int samsung_kbd_input_mapping(struct hid_device *hdev,
 }
 
 static int samsung_gamepad_input_mapping(struct hid_device *hdev,
-	struct hid_input *hi, struct hid_field *field, struct hid_usage *usage,
-	unsigned long **bit, int *max)
+					 struct hid_input *hi,
+					 struct hid_field *field,
+					 struct hid_usage *usage,
+					 unsigned long **bit, int *max)
 {
 	int i;
-	unsigned use;
-	unsigned up = usage->hid & HID_USAGE_PAGE;
+	unsigned int use;
+	unsigned int up = usage->hid & HID_USAGE_PAGE;
 
 	if (!(up == HID_UP_BUTTON || up == HID_UP_CONSUMER))
 		return 0;
@@ -258,12 +268,14 @@ static int samsung_gamepad_input_mapping(struct hid_device *hdev,
 }
 
 static int samsung_actionmouse_input_mapping(struct hid_device *hdev,
-	struct hid_input *hi, struct hid_field *field, struct hid_usage *usage,
-	unsigned long **bit, int *max)
+					     struct hid_input *hi,
+					     struct hid_field *field,
+					     struct hid_usage *usage,
+					     unsigned long **bit, int *max)
 {
 	int i;
-	unsigned use;
-	unsigned up = usage->hid & HID_USAGE_PAGE;
+	unsigned int use;
+	unsigned int up = usage->hid & HID_USAGE_PAGE;
 	static const struct key_clear_map kcm[] = {
 		{ 0x301, 254 },
 	};
@@ -271,7 +283,8 @@ static int samsung_actionmouse_input_mapping(struct hid_device *hdev,
 	use = usage->hid & HID_USAGE;
 
 	dbg_hid("samsung wireless actionmouse input mapping event [0x%x], [0x%x], %ld, %ld, [0x%x]\n",
-		use, usage->hid & HID_USAGE, hi->input->evbit[0], hi->input->absbit[0],
+		use, usage->hid & HID_USAGE,
+		hi->input->evbit[0], hi->input->absbit[0],
 		up);
 
 	if (!(up == HID_UP_CONSUMER || up == HID_UP_BUTTON))
@@ -288,12 +301,14 @@ static int samsung_actionmouse_input_mapping(struct hid_device *hdev,
 }
 
 static int samsung_universal_kbd_input_mapping(struct hid_device *hdev,
-	struct hid_input *hi, struct hid_field *field, struct hid_usage *usage,
-	unsigned long **bit, int *max)
+					       struct hid_input *hi,
+					       struct hid_field *field,
+					       struct hid_usage *usage,
+					       unsigned long **bit, int *max)
 {
 	int i;
-	unsigned use;
-	unsigned up = usage->hid & HID_USAGE_PAGE;
+	unsigned int use;
+	unsigned int up = usage->hid & HID_USAGE_PAGE;
 
 	if (!(up == HID_UP_CONSUMER || up == HID_UP_KEYBOARD))
 		return 0;
@@ -362,43 +377,46 @@ static int samsung_universal_kbd_input_mapping(struct hid_device *hdev,
 }
 
 static __u8 *samsung_report_fixup(struct hid_device *hdev, __u8 *rdesc,
-	unsigned int *rsize)
+				  unsigned int *rsize)
 {
-	if (hdev->product == USB_DEVICE_ID_SAMSUNG_IR_REMOTE && hid_is_usb(hdev))
+	if (hdev->product == USB_DEVICE_ID_SAMSUNG_IR_REMOTE &&
+	    hid_is_usb(hdev))
 		rdesc = samsung_irda_report_fixup(hdev, rdesc, rsize);
 	return rdesc;
 }
 
-static int samsung_input_mapping(struct hid_device *hdev, struct hid_input *hi,
-	struct hid_field *field, struct hid_usage *usage,
-	unsigned long **bit, int *max)
+static int samsung_input_mapping(struct hid_device *hdev,
+				 struct hid_input *hi,
+				 struct hid_field *field,
+				 struct hid_usage *usage,
+				 unsigned long **bit, int *max)
 {
-	int ret = 0;
-
-	if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE && hid_is_usb(hdev))
-		ret = samsung_kbd_mouse_input_mapping(hdev,
-			hi, field, usage, bit, max);
-	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD)
-		ret = samsung_kbd_input_mapping(hdev,
-			hi, field, usage, bit, max);
-	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD)
-		ret = samsung_gamepad_input_mapping(hdev,
-			hi, field, usage, bit, max);
-	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_ACTIONMOUSE)
-		ret = samsung_actionmouse_input_mapping(hdev,
-			hi, field, usage, bit, max);
-	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_UNIVERSAL_KBD)
-		ret = samsung_universal_kbd_input_mapping(hdev,
-			hi, field, usage, bit, max);
-	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_MULTI_HOGP_KBD)
-		ret = samsung_universal_kbd_input_mapping(hdev,
-			hi, field, usage, bit, max);
-
-	return ret;
+	switch (hdev->product) {
+	case USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE:
+		if (hid_is_usb(hdev))
+			return samsung_kbd_mouse_input_mapping(hdev, hi, field,
+							       usage, bit, max);
+		break;
+	case USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD:
+		return samsung_kbd_input_mapping(hdev, hi, field,
+						 usage, bit, max);
+	case USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD:
+		return samsung_gamepad_input_mapping(hdev, hi, field,
+						     usage, bit, max);
+	case USB_DEVICE_ID_SAMSUNG_WIRELESS_ACTIONMOUSE:
+		return samsung_actionmouse_input_mapping(hdev, hi, field,
+							 usage, bit, max);
+	case USB_DEVICE_ID_SAMSUNG_WIRELESS_UNIVERSAL_KBD:
+	case USB_DEVICE_ID_SAMSUNG_WIRELESS_MULTI_HOGP_KBD:
+		return samsung_universal_kbd_input_mapping(hdev, hi, field,
+							   usage, bit, max);
+	}
+
+	return 0;
 }
 
 static int samsung_probe(struct hid_device *hdev,
-		const struct hid_device_id *id)
+			 const struct hid_device_id *id)
 {
 	int ret;
 	unsigned int cmask = HID_CONNECT_DEFAULT;
@@ -406,14 +424,13 @@ static int samsung_probe(struct hid_device *hdev,
 	ret = hid_parse(hdev);
 	if (ret) {
 		hid_err(hdev, "parse failed\n");
-		goto err_free;
+		return ret;
 	}
 
 	if (hdev->product == USB_DEVICE_ID_SAMSUNG_IR_REMOTE) {
-		if (!hid_is_usb(hdev)) {
-			ret = -EINVAL;
-			goto err_free;
-		}
+		if (!hid_is_usb(hdev))
+			return -EINVAL;
+
 		if (hdev->rsize == 184) {
 			/* disable hidinput, force hiddev */
 			cmask = (cmask & ~HID_CONNECT_HIDINPUT) |
@@ -424,22 +441,27 @@ static int samsung_probe(struct hid_device *hdev,
 	ret = hid_hw_start(hdev, cmask);
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");
-		goto err_free;
+		return ret;
 	}
 
 	return 0;
-err_free:
-	return ret;
 }
 
 static const struct hid_device_id samsung_devices[] = {
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMOTE) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE) },
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD) },
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD) },
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_ACTIONMOUSE) },
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_UNIVERSAL_KBD) },
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_MULTI_HOGP_KBD) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG,
+			 USB_DEVICE_ID_SAMSUNG_IR_REMOTE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG,
+			 USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS,
+			       USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS,
+			       USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS,
+			       USB_DEVICE_ID_SAMSUNG_WIRELESS_ACTIONMOUSE) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS,
+			       USB_DEVICE_ID_SAMSUNG_WIRELESS_UNIVERSAL_KBD) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS,
+			       USB_DEVICE_ID_SAMSUNG_WIRELESS_MULTI_HOGP_KBD) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, samsung_devices);
-- 
2.43.0


