Return-Path: <linux-kernel+bounces-47087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FEB8448F4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666D51C23296
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995691EEF7;
	Wed, 31 Jan 2024 20:30:35 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B087835F18;
	Wed, 31 Jan 2024 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706733034; cv=none; b=Y1b4efBt27xGPKm75X9GSZrXqDJUUaEx5J4ogyrmPFR/K6pTXLuqLeLrtbDcSvYiphR+7iFTiiWVLOso5WfWcMnmwv+A0wIYXa9VnOj4MZaygdHQHQYCkAplhvZrXwVRDY8k1Z6WaKUU5xcnaTuEyJtKKJp0+6kcdyC9R193d3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706733034; c=relaxed/simple;
	bh=zeDoYLvlNmLwt3KFjZo2WReGOSrqK1QKoZRblF9zXd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gto6Ay8xPJ3AjFURsV6AkHEu5rxwezXh9UiBZShRO+Hk7yGBdwKSMBK1spzaCXkMffHwe7EUH1BiYX/d4zM+wuYZTBhZ47PlKVm5UJ6+3sIklOVdI0RonW/TWWZevg8to81eqJZeLyNlesvId9va/LqF1EaRnQjByGG4khITnBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 6F75AC04D4;
	Wed, 31 Jan 2024 20:22:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id C18B36000C;
	Wed, 31 Jan 2024 20:22:16 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Sandeep C S <sandeep.cs@samsung.com>,
	Junwan Cho <junwan.cho@samsung.com>,
	Jitender Sajwan <jitender.s21@samsung.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] HID: samsung: Reduce code size
Date: Wed, 31 Jan 2024 12:21:36 -0800
Message-ID: <78c90f4d27b8acb2a51219bb85bc2da08b0b6f04.1706732238.git.joe@perches.com>
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
X-Rspamd-Queue-Id: C18B36000C
X-Stat-Signature: 835i6za113bm7k6atcnthoqenstj77ek
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX186VhaKV9E4mLDFBr5R/8n1hftpTOdA2fU=
X-HE-Tag: 1706732536-342852
X-HE-Meta: U2FsdGVkX1/MmcPiLsxZwKfRQmC7lcgPLWp/hHKgVALygG5ad9LGe7663aV9uJuyuT/T/I04MDHG3FRCfQsxMYgKHbw/85Ge+cC7bSRjDC0tUC1ReBapOXp9u2T+S1PpiDnyN2befBidVRyKLiVpdRwKRUb6dwdKcpW4q73938XR8My5U7cHYrhQjml1jv06n+WIES2I8LwBJ6AySoxZ+9rAmoD/auDwL5Fs7JR/Y7bISVRfUOSF5eWfHx3KCn880IS2cQs9bJPDxg8RnewhCGmuFW493LnAyH8xQ/wSwcmJNQP2YTqD+B9/przj7T0NZcDw50Cv+/s=

Remove samsung_kbd_mouse_map_key_clear macro and uses to reduce
overall code size by ~8kb.

$ size drivers/hid/hid-samsung.o*
   text	   data	    bss	    dec	    hex	filename
   3203	    440	      0	   3643	    e3b	drivers/hid/hid-samsung.o.new
  11286	    448	      0	  11734	   2dd6	drivers/hid/hid-samsung.o.old

Consolidate multiple '&' uses.
Create and use static const struct and for loops instead of multiple calls
with hidden arguments of samsung_kbd_mouse_map_key_clear macro.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/hid/hid-samsung.c | 512 +++++++++++++++-----------------------
 1 file changed, 202 insertions(+), 310 deletions(-)

diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
index 08fb25b8459af..d701dd3a914e7 100644
--- a/drivers/hid/hid-samsung.c
+++ b/drivers/hid/hid-samsung.c
@@ -81,8 +81,10 @@ static __u8 *samsung_irda_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	return rdesc;
 }
 
-#define samsung_kbd_mouse_map_key_clear(c) \
-	hid_map_usage_clear(hi, usage, bit, max, EV_KEY, (c))
+struct key_clear_map {
+	unsigned use;
+	__u16 kb;
+};
 
 static int samsung_kbd_mouse_input_mapping(struct hid_device *hdev,
 	struct hid_input *hi, struct hid_field *field, struct hid_usage *usage,
@@ -90,143 +92,101 @@ static int samsung_kbd_mouse_input_mapping(struct hid_device *hdev,
 {
 	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
 	unsigned short ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
-
-	if (ifnum != 1 || HID_UP_CONSUMER != (usage->hid & HID_USAGE_PAGE))
+	int i;
+	unsigned use;
+	unsigned up = usage->hid & HID_USAGE_PAGE;
+	static const struct key_clear_map kcm[] = {
+		{ 0x183, KEY_MEDIA },
+		{ 0x195, KEY_EMAIL },
+		{ 0x196, KEY_CALC },
+		{ 0x197, KEY_COMPUTER },
+		{ 0x22b, KEY_SEARCH },
+		{ 0x22c, KEY_WWW },
+		{ 0x22d, KEY_BACK },
+		{ 0x22e, KEY_FORWARD },
+		{ 0x22f, KEY_FAVORITES },
+		{ 0x230, KEY_REFRESH },
+		{ 0x231, KEY_STOP },
+	};
+
+	if (ifnum != 1 || HID_UP_CONSUMER != up)
 		return 0;
 
+	use = usage->hid & HID_USAGE;
+
 	dbg_hid("samsung wireless keyboard/mouse input mapping event [0x%x]\n",
-		usage->hid & HID_USAGE);
-
-	switch (usage->hid & HID_USAGE) {
-	/* report 2 */
-	case 0x183:
-		samsung_kbd_mouse_map_key_clear(KEY_MEDIA);
-		break;
-	case 0x195:
-		samsung_kbd_mouse_map_key_clear(KEY_EMAIL);
-		break;
-	case 0x196:
-		samsung_kbd_mouse_map_key_clear(KEY_CALC);
-		break;
-	case 0x197:
-		samsung_kbd_mouse_map_key_clear(KEY_COMPUTER);
-		break;
-	case 0x22b:
-		samsung_kbd_mouse_map_key_clear(KEY_SEARCH);
-		break;
-	case 0x22c:
-		samsung_kbd_mouse_map_key_clear(KEY_WWW);
-		break;
-	case 0x22d:
-		samsung_kbd_mouse_map_key_clear(KEY_BACK);
-		break;
-	case 0x22e:
-		samsung_kbd_mouse_map_key_clear(KEY_FORWARD);
-		break;
-	case 0x22f:
-		samsung_kbd_mouse_map_key_clear(KEY_FAVORITES);
-		break;
-	case 0x230:
-		samsung_kbd_mouse_map_key_clear(KEY_REFRESH);
-		break;
-	case 0x231:
-		samsung_kbd_mouse_map_key_clear(KEY_STOP);
-		break;
-	default:
-		return 0;
+		use);
+
+	for (i = 0; i < ARRAY_SIZE(kcm); i++) {
+		if (use == kcm[i].use) {
+			hid_map_usage_clear(hi, usage, bit, max, EV_KEY,
+					    kcm[i].kb);
+			return 1;
+		}
 	}
 
-	return 1;
+	return 0;
 }
 
 static int samsung_kbd_input_mapping(struct hid_device *hdev,
 	struct hid_input *hi, struct hid_field *field, struct hid_usage *usage,
 	unsigned long **bit, int *max)
 {
-	if (!(HID_UP_CONSUMER == (usage->hid & HID_USAGE_PAGE) ||
-			HID_UP_KEYBOARD == (usage->hid & HID_USAGE_PAGE)))
+	int i;
+	unsigned use;
+	unsigned up = usage->hid & HID_USAGE_PAGE;
+
+	if (!(up == HID_UP_CONSUMER || up == HID_UP_KEYBOARD))
 		return 0;
 
-	dbg_hid("samsung wireless keyboard input mapping event [0x%x]\n",
-		usage->hid & HID_USAGE);
+	use = usage->hid & HID_USAGE;
+
+	dbg_hid("samsung wireless keyboard input mapping event [0x%x]\n", use);
+
+	if (up == HID_UP_KEYBOARD) {
+		static const struct key_clear_map kcm[] = {
+			{ 0x32, KEY_BACKSLASH },
+			{ 0x64, KEY_102ND },
+			{ 0x87, KEY_RO },
+		};
 
-	if (HID_UP_KEYBOARD == (usage->hid & HID_USAGE_PAGE)) {
 		set_bit(EV_REP, hi->input->evbit);
-		switch (usage->hid & HID_USAGE) {
-		case 0x32:
-			samsung_kbd_mouse_map_key_clear(KEY_BACKSLASH);
-			break;
-		case 0x64:
-			samsung_kbd_mouse_map_key_clear(KEY_102ND);
-			break;
-		/* Only for BR keyboard */
-		case 0x87:
-			samsung_kbd_mouse_map_key_clear(KEY_RO);
-			break;
-		default:
-			return 0;
+		for (i = 0; i < ARRAY_SIZE(kcm); i++) {
+			if (use == kcm[i].use) {
+				hid_map_usage_clear(hi, usage, bit, max, EV_KEY,
+						    kcm[i].kb);
+				return 1;
+			}
 		}
+		return 0;
 	}
 
-	if (HID_UP_CONSUMER == (usage->hid & HID_USAGE_PAGE)) {
-		switch (usage->hid & HID_USAGE) {
-		/* report 2 */
-		/* MENU */
-		case 0x040:
-			samsung_kbd_mouse_map_key_clear(KEY_MENU);
-			break;
-		case 0x18a:
-			samsung_kbd_mouse_map_key_clear(KEY_MAIL);
-			break;
-		case 0x196:
-			samsung_kbd_mouse_map_key_clear(KEY_WWW);
-			break;
-		case 0x19e:
-			samsung_kbd_mouse_map_key_clear(KEY_SCREENLOCK);
-			break;
-		case 0x221:
-			samsung_kbd_mouse_map_key_clear(KEY_SEARCH);
-			break;
-		case 0x223:
-			samsung_kbd_mouse_map_key_clear(KEY_HOMEPAGE);
-			break;
-		/* Smtart Voice Key */
-		case 0x300:
-			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY13);
-			break;
-		/* RECENTAPPS */
-		case 0x301:
-			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY1);
-			break;
-		/* APPLICATION */
-		case 0x302:
-			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY2);
-			break;
-		/* Voice search */
-		case 0x305:
-			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY4);
-			break;
-		/* QPANEL on/off */
-		case 0x306:
-			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY5);
-			break;
-		/* SIP on/off */
-		case 0x307:
-			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY3);
-			break;
-		/* LANG */
-		case 0x308:
-			samsung_kbd_mouse_map_key_clear(KEY_LANGUAGE);
-			break;
-		case 0x30a:
-			samsung_kbd_mouse_map_key_clear(KEY_BRIGHTNESSDOWN);
-			break;
-		case 0x30b:
-			samsung_kbd_mouse_map_key_clear(KEY_BRIGHTNESSUP);
-			break;
-		default:
-			return 0;
+	if (up == HID_UP_CONSUMER) {
+		static const struct key_clear_map kcm[] = {
+			{ 0x040, KEY_MENU },		/* MENU */
+			{ 0x18a, KEY_MAIL },
+			{ 0x196, KEY_WWW },
+			{ 0x19e, KEY_SCREENLOCK },
+			{ 0x221, KEY_SEARCH },
+			{ 0x223, KEY_HOMEPAGE },
+			{ 0x300, BTN_TRIGGER_HAPPY13 }, /* Smtart Voice Key */
+			{ 0x301, BTN_TRIGGER_HAPPY1 },	/* RECENTAPPS */
+			{ 0x302, BTN_TRIGGER_HAPPY2 },	/* APPLICATION */
+			{ 0x305, BTN_TRIGGER_HAPPY4 },	/* Voice search */
+			{ 0x306, BTN_TRIGGER_HAPPY5 },	/* QPANEL on/off */
+			{ 0x307, BTN_TRIGGER_HAPPY3 },	/* SIP on/off */
+			{ 0x308, KEY_LANGUAGE },	/* LANG */
+			{ 0x30a, KEY_BRIGHTNESSDOWN },
+			{ 0x30b, KEY_BRIGHTNESSUP },
+		};
+		for (i = 0; i < ARRAY_SIZE(kcm); i++) {
+			if (use == kcm[i].use) {
+				hid_map_usage_clear(hi, usage, bit, max, EV_KEY,
+						    kcm[i].kb);
+				return 1;
+			}
 		}
+		return 0;
 	}
 
 	return 1;
@@ -236,88 +196,62 @@ static int samsung_gamepad_input_mapping(struct hid_device *hdev,
 	struct hid_input *hi, struct hid_field *field, struct hid_usage *usage,
 	unsigned long **bit, int *max)
 {
-	if (!(HID_UP_BUTTON == (usage->hid & HID_USAGE_PAGE) ||
-			HID_UP_CONSUMER == (usage->hid & HID_USAGE_PAGE)))
+	int i;
+	unsigned use;
+	unsigned up = usage->hid & HID_USAGE_PAGE;
+
+	if (!(up == HID_UP_BUTTON || up == HID_UP_CONSUMER))
 		return 0;
 
+	use = usage->hid & HID_USAGE;
+
 	dbg_hid("samsung wireless gamepad input mapping event [0x%x], %ld, %ld, [0x%x]\n",
-		usage->hid & HID_USAGE, hi->input->evbit[0], hi->input->absbit[0], usage->hid & HID_USAGE_PAGE);
-
-	if (HID_UP_BUTTON == (usage->hid & HID_USAGE_PAGE)) {
-		switch (usage->hid & HID_USAGE) {
-		case 0x01:
-			samsung_kbd_mouse_map_key_clear(BTN_A);
-			break;
-		case 0x02:
-			samsung_kbd_mouse_map_key_clear(BTN_B);
-			break;
-		case 0x03:
-			samsung_kbd_mouse_map_key_clear(BTN_C);
-			break;
-		case 0x04:
-			samsung_kbd_mouse_map_key_clear(BTN_X);
-			break;
-		case 0x05:
-			samsung_kbd_mouse_map_key_clear(BTN_Y);
-			break;
-		case 0x06:
-			samsung_kbd_mouse_map_key_clear(BTN_Z);
-			break;
-		case 0x07:
-			samsung_kbd_mouse_map_key_clear(BTN_TL);
-			break;
-		case 0x08:
-			samsung_kbd_mouse_map_key_clear(BTN_TR);
-			break;
-		case 0x09:
-			samsung_kbd_mouse_map_key_clear(BTN_TL2);
-			break;
-		case 0x0a:
-			samsung_kbd_mouse_map_key_clear(BTN_TR2);
-			break;
-		case 0x0b:
-			samsung_kbd_mouse_map_key_clear(BTN_SELECT);
-			break;
-		case 0x0c:
-			samsung_kbd_mouse_map_key_clear(BTN_START);
-			break;
-		case 0x0d:
-			samsung_kbd_mouse_map_key_clear(BTN_MODE);
-			break;
-		case 0x0e:
-			samsung_kbd_mouse_map_key_clear(BTN_THUMBL);
-			break;
-		case 0x0f:
-			samsung_kbd_mouse_map_key_clear(BTN_THUMBR);
-			break;
-		case 0x10:
-			samsung_kbd_mouse_map_key_clear(0x13f);
-			break;
-		default:
-			return 0;
+		use, hi->input->evbit[0], hi->input->absbit[0], up);
+
+	if (up == HID_UP_BUTTON) {
+		static const struct key_clear_map kcm[] = {
+			{ 0x01, BTN_A },
+			{ 0x02, BTN_B },
+			{ 0x03, BTN_C },
+			{ 0x04, BTN_X },
+			{ 0x05, BTN_Y },
+			{ 0x06, BTN_Z },
+			{ 0x07, BTN_TL },
+			{ 0x08, BTN_TR },
+			{ 0x09, BTN_TL2 },
+			{ 0x0a, BTN_TR2 },
+			{ 0x0b, BTN_SELECT },
+			{ 0x0c, BTN_START },
+			{ 0x0d, BTN_MODE },
+			{ 0x0e, BTN_THUMBL },
+			{ 0x0f, BTN_THUMBR },
+			{ 0x10, 0x13f },
+		};
+		for (i = 0; i < ARRAY_SIZE(kcm); i++) {
+			if (use == kcm[i].use) {
+				hid_map_usage_clear(hi, usage, bit, max, EV_KEY,
+						    kcm[i].kb);
+				return 1;
+			}
 		}
+		return 0;
 	}
 
-	if (HID_UP_CONSUMER == (usage->hid & HID_USAGE_PAGE)) {
-		switch (usage->hid & HID_USAGE) {
-		case 0x040:
-			samsung_kbd_mouse_map_key_clear(KEY_MENU);
-			break;
-		case 0x223:
-			samsung_kbd_mouse_map_key_clear(KEY_HOMEPAGE);
-			break;
-		case 0x224:
-			samsung_kbd_mouse_map_key_clear(KEY_BACK);
-			break;
-
-		/* Screen Capture */
-		case 0x303:
-			samsung_kbd_mouse_map_key_clear(KEY_SYSRQ);
-			break;
-
-		default:
-			return 0;
+	if (up == HID_UP_CONSUMER) {
+		static const struct key_clear_map kcm[] = {
+			{ 0x040, KEY_MENU },
+			{ 0x223, KEY_HOMEPAGE },
+			{ 0x224, KEY_BACK },
+			{ 0x303, KEY_SYSRQ },		/* Screen Capture */
+		};
+		for (i = 0; i < ARRAY_SIZE(kcm); i++) {
+			if (use == kcm[i].use) {
+				hid_map_usage_clear(hi, usage, bit, max, EV_KEY,
+						    kcm[i].kb);
+				return 1;
+			}
 		}
+		return 0;
 	}
 
 	return 1;
@@ -327,22 +261,29 @@ static int samsung_actionmouse_input_mapping(struct hid_device *hdev,
 	struct hid_input *hi, struct hid_field *field, struct hid_usage *usage,
 	unsigned long **bit, int *max)
 {
+	int i;
+	unsigned use;
+	unsigned up = usage->hid & HID_USAGE_PAGE;
+	static const struct key_clear_map kcm[] = {
+		{ 0x301, 254 },
+	};
+
+	use = usage->hid & HID_USAGE;
 
 	dbg_hid("samsung wireless actionmouse input mapping event [0x%x], [0x%x], %ld, %ld, [0x%x]\n",
-			usage->hid, usage->hid & HID_USAGE, hi->input->evbit[0], hi->input->absbit[0],
-			usage->hid & HID_USAGE_PAGE);
+		use, usage->hid & HID_USAGE, hi->input->evbit[0], hi->input->absbit[0],
+		up);
 
-	if (((usage->hid & HID_USAGE_PAGE) != HID_UP_CONSUMER) && ((usage->hid & HID_USAGE_PAGE) != HID_UP_BUTTON))
+	if (!(up == HID_UP_CONSUMER || up == HID_UP_BUTTON))
 		return 0;
 
-	switch (usage->hid & HID_USAGE) {
-	case 0x301:
-		samsung_kbd_mouse_map_key_clear(254);
-		break;
-	default:
-		return 0;
+	for (i = 0; i < ARRAY_SIZE(kcm); i++) {
+		if (use == kcm[i].use) {
+			hid_map_usage_clear(hi, usage, bit, max, EV_KEY,
+					    kcm[i].kb);
+			return 1;
+		}
 	}
-
 	return 1;
 }
 
@@ -350,120 +291,71 @@ static int samsung_universal_kbd_input_mapping(struct hid_device *hdev,
 	struct hid_input *hi, struct hid_field *field, struct hid_usage *usage,
 	unsigned long **bit, int *max)
 {
-	if (!(HID_UP_CONSUMER == (usage->hid & HID_USAGE_PAGE) ||
-			HID_UP_KEYBOARD == (usage->hid & HID_USAGE_PAGE)))
+	int i;
+	unsigned use;
+	unsigned up = usage->hid & HID_USAGE_PAGE;
+
+	if (!(up == HID_UP_CONSUMER || up == HID_UP_KEYBOARD))
 		return 0;
 
-	dbg_hid("samsung wireless keyboard input mapping event [0x%x]\n",
-		usage->hid & HID_USAGE);
+	use = usage->hid & HID_USAGE;
+
+	dbg_hid("samsung wireless keyboard input mapping event [0x%x]\n", use);
+
+	if (up == HID_UP_KEYBOARD) {
+		static const struct key_clear_map kcm[] = {
+			{ 0x32, KEY_BACKSLASH },
+			{ 0x64, KEY_102ND },
+			{ 0x87, KEY_RO },	/* Only for BR keyboard */
+		};
 
-	if (HID_UP_KEYBOARD == (usage->hid & HID_USAGE_PAGE)) {
 		set_bit(EV_REP, hi->input->evbit);
-		switch (usage->hid & HID_USAGE) {
-		case 0x32:
-			samsung_kbd_mouse_map_key_clear(KEY_BACKSLASH);
-			break;
-		case 0x64:
-			samsung_kbd_mouse_map_key_clear(KEY_102ND);
-			break;
-		/* Only for BR keyboard */
-		case 0x87:
-			samsung_kbd_mouse_map_key_clear(KEY_RO);
-			break;
-		default:
-			return 0;
+		for (i = 0; i < ARRAY_SIZE(kcm); i++) {
+			if (use == kcm[i].use) {
+				hid_map_usage_clear(hi, usage, bit, max, EV_KEY,
+						    kcm[i].kb);
+				return 1;
+			}
 		}
+		return 0;
 	}
 
-	if (HID_UP_CONSUMER == (usage->hid & HID_USAGE_PAGE)) {
-		switch (usage->hid & HID_USAGE) {
+	if (up == HID_UP_CONSUMER) {
 		/* report 2 */
-		/* MENU */
-		case 0x040:
-			samsung_kbd_mouse_map_key_clear(KEY_MENU);
-			break;
-		case 0x18a:
-			samsung_kbd_mouse_map_key_clear(KEY_MAIL);
-			break;
-		case 0x196:
-			samsung_kbd_mouse_map_key_clear(KEY_WWW);
-			break;
-		case 0x19e:
-			samsung_kbd_mouse_map_key_clear(KEY_SCREENLOCK);
-			break;
-		case 0x221:
-			samsung_kbd_mouse_map_key_clear(KEY_SEARCH);
-			break;
-		case 0x223:
-			samsung_kbd_mouse_map_key_clear(KEY_HOMEPAGE);
-			break;
-		/* RECENTAPPS */
-		case 0x301:
-			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY1);
-			break;
-		/* APPLICATION */
-		case 0x302:
-			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY2);
-			break;
-		/* Voice search */
-		case 0x305:
-			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY4);
-			break;
-		/* QPANEL on/off */
-		case 0x306:
-			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY5);
-			break;
-		/* SIP on/off */
-		case 0x307:
-			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY3);
-			break;
-		/* LANG */
-		case 0x308:
-			samsung_kbd_mouse_map_key_clear(KEY_LANGUAGE);
-			break;
-		case 0x30a:
-			samsung_kbd_mouse_map_key_clear(KEY_BRIGHTNESSDOWN);
-			break;
-		case 0x070:
-			samsung_kbd_mouse_map_key_clear(KEY_BRIGHTNESSDOWN);
-			break;
-		case 0x30b:
-			samsung_kbd_mouse_map_key_clear(KEY_BRIGHTNESSUP);
-			break;
-		case 0x06f:
-			samsung_kbd_mouse_map_key_clear(KEY_BRIGHTNESSUP);
-			break;
-		/* S-Finder */
-		case 0x304:
-			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY7);
-			break;
-		/* Screen Capture */
-		case 0x303:
-			samsung_kbd_mouse_map_key_clear(KEY_SYSRQ);
-			break;
-		/* Multi Window */
-		case 0x309:
-			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY9);
-			break;
-		/* HotKey App 1 */
-		case 0x071:
-			samsung_kbd_mouse_map_key_clear(0x2f5);
-			break;
-		/* HotKey App 2 */
-		case 0x072:
-			samsung_kbd_mouse_map_key_clear(0x2f6);
-			break;
-		/* HotKey App 3 */
-		case 0x073:
-			samsung_kbd_mouse_map_key_clear(0x2f7);
-			break;
-		/* Dex */
-		case 0x06e:
-			samsung_kbd_mouse_map_key_clear(0x2bd);
-			break;
-		default:
-			return 0;
+		static const struct key_clear_map kcm[] = {
+			{ 0x040, KEY_MENU },		/* MENU */
+			{ 0x18a, KEY_MAIL },
+			{ 0x196, KEY_WWW },
+			{ 0x19e, KEY_SCREENLOCK },
+			{ 0x221, KEY_SEARCH },
+			{ 0x223, KEY_HOMEPAGE },
+			{ 0x301, BTN_TRIGGER_HAPPY1 },	/* RECENTAPPS */
+			{ 0x302, BTN_TRIGGER_HAPPY2 },	/* APPLICATION */
+			{ 0x305, BTN_TRIGGER_HAPPY4 },	/* Voice search */
+			{ 0x306, BTN_TRIGGER_HAPPY5 },	/* QPANEL on/off */
+			{ 0x307, BTN_TRIGGER_HAPPY3 },	/* SIP on/off */
+			{ 0x308, KEY_LANGUAGE },	/* LANG */
+			{ 0x30a, KEY_BRIGHTNESSDOWN },
+			{ 0x070, KEY_BRIGHTNESSDOWN },
+			{ 0x30b, KEY_BRIGHTNESSUP },
+			{ 0x06f, KEY_BRIGHTNESSUP },
+			{ 0x304, BTN_TRIGGER_HAPPY7 },	/* S-Finder */
+			{ 0x303, KEY_SYSRQ },		/* Screen Capture */
+			{ 0x309, BTN_TRIGGER_HAPPY9 },	/* Multi Window */
+			{ 0x071, 0x2f5 },		/* HotKey App 1 */
+			{ 0x072, 0x2f6 },		/* HotKey App 2 */
+			{ 0x073, 0x2f7 },		/* HotKey App 3 */
+			{ 0x06e, 0x2bd },		/* Dex */
+		};
+
+		for (i = 0; i < ARRAY_SIZE(kcm); i++) {
+			if (use == kcm[i].use) {
+				hid_map_usage_clear(hi, usage, bit, max, EV_KEY,
+						    kcm[i].kb);
+				return 1;
+			}
 		}
+		return 0;
 	}
 
 	return 1;
-- 
2.43.0


