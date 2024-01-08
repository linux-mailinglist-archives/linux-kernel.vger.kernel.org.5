Return-Path: <linux-kernel+bounces-19268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F57826A97
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9941C20946
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3C4D51B;
	Mon,  8 Jan 2024 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jM4KlA8I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0845429420
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240108092028epoutp0445fd0d2f5c5f985133a333a5843a56a8~oVLykesy_0770507705epoutp04e
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:20:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240108092028epoutp0445fd0d2f5c5f985133a333a5843a56a8~oVLykesy_0770507705epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704705628;
	bh=f7oEAqGc3D1UQYparyVNa8WFZxoDPCcV8mgY0hQuHNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jM4KlA8IiubKgWM1FRGiyC/nW5vo7zmxWonzpz+oYpfDWprK2zNZ9awrAXsw4Qn6F
	 Bv5sNSsMeACb31ePrO2/rFxtbZ13BOyDp/92cOeza+2MiWtZWL+vQYSGeZ98/7pq4i
	 GSME2/PERFHkp2S0NvTid7AOJSaOPKtnqCNbCuQ0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240108092027epcas5p392d31e572aa553e7cf907e920885c561~oVLyHPbMs0528705287epcas5p3K;
	Mon,  8 Jan 2024 09:20:27 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4T7pST6FkVz4x9Q4; Mon,  8 Jan
	2024 09:20:25 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6B.32.10009.95EBB956; Mon,  8 Jan 2024 18:20:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240108092025epcas5p39e2ecb3b12b4fba9e41f0694f430ec1d~oVLwDr3Gl0532205322epcas5p3s;
	Mon,  8 Jan 2024 09:20:25 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240108092025epsmtrp2a8eab9146eecf2ff52dab07c38705603~oVLwCWUDP2017920179epsmtrp21;
	Mon,  8 Jan 2024 09:20:25 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-0a-659bbe599c82
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	B4.E0.18939.95EBB956; Mon,  8 Jan 2024 18:20:25 +0900 (KST)
Received: from ws2030077324.sa.corp.samsungelectronics.net (unknown
	[107.99.237.91]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240108092023epsmtip24d4cae43eaa0bc47c78f6ad265e60e3c~oVLufuCik2133021330epsmtip24;
	Mon,  8 Jan 2024 09:20:23 +0000 (GMT)
From: Sandeep C S <sandeep.cs@samsung.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<benjamin.tissoires@redhat.com>
Cc: gaudium.lee@samsung.com, ih0923.kim@samsung.com,
	suhyun_.kim@samsung.com, jitender.s21@samsung.com, junwan.cho@samsung.com,
	sandeep.cs@samsung.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [HID Patchsets for Samsung driver v2 6/6] HID: Samsung : Add
 Samsung wireless bookcover and universal keyboard support.
Date: Mon,  8 Jan 2024 14:49:16 +0530
Message-Id: <20240108091917.1552013-7-sandeep.cs@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108091917.1552013-1-sandeep.cs@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTUzdy3+xUg2fP9C2uT9nManF7gafF
	1iVzWS1uHW9ltHj5YAO7xebJj1gsbn76xmpxedccNov22c8YLR6t2MTkwOWxaVUnm8f7fVfZ
	PPq2rGL0+LxJLoAlKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
	xSdA1y0zB+geJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5e
	aomVoYGBkSlQYUJ2xr9Nl5gKNhtWTGqcytjA2KXZxcjJISFgIjFj6R7GLkYuDiGB3YwSU3bt
	YoZwPjFKdL2cxQbntM64zgjT8mz/XFaIxE5GiWP7NzJBOJ1MErOfLWEHqWIT0JLoO/KdCcQW
	EYiQeLdgE1g3s8B1RokHDwNBGoQFmhglbp5eCVbEIqAq0fb0P9A+Dg5eAVuJr/9yILbJS+w/
	eJYZxOYUsJPY9mQjWDmvgKDEyZlPWCBmyks0b50NdreEwE92iY/3/7FDNLtIPP51kAXCFpZ4
	dXwLVFxK4vO7vWwQDd2MEktvH2OHcGYwSrTsvMoMUWUv8fP1BLCLmAU0Jdbv0ofYxifR+/sJ
	E0hYQoBXoqNNCKJaReJp125WmPnfT0AcKiHgIfFk7QIWSAhNZJT4cfYp+wRG+VlInpiF5IlZ
	CNsWMDKvYpRMLSjOTU8tNi0wyksth8dtcn7uJkZwytTy2sH48MEHvUOMTByMhxglOJiVRHgl
	Z8xOFeJNSaysSi3Kjy8qzUktPsRoCgzkicxSosn5wKSdVxJvaGJpYGJmZmZiaWxmqCTO+7p1
	boqQQHpiSWp2ampBahFMHxMHp1QDU3XvDUNVT5te64CzWtFOV87kVMy7o6ybfEpn8So3mzXH
	q5Z98nLcxuLyzawq8Wfoih4JOfdPPhvlfJoczu+T53XITAq6bbdx6mbR0/9mGd3YefvR4rIJ
	z9gdy2wZ8zYyL1vpeiLoxqvM8B8rBB98re9fPl3kL981aZ2kXc9+WfQL9nM232r5e+yVxKfj
	C8yLWF2P/FedtOxo4fTgip3bMoLtGvjUhX7eZHY7+27p8UUVl+/tXuPmlFZznffJ9B8sejla
	nA7zjq9/sGnNvyO/Qtn33fmxtMCHf7m25SvfEwY6v86eTrtQ0MxwZNc3/TdrTHWq2BwvzXl9
	8enyZodF23nL3v40j3m+z0a0sUdj0hQlluKMREMt5qLiRACV5EdkIgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWy7bCSvG7kvtmpBi+2illcn7KZ1eL2Ak+L
	rUvmslrcOt7KaPHywQZ2i82TH7FY3Pz0jdXi8q45bBbts58xWjxasYnJgctj06pONo/3+66y
	efRtWcXo8XmTXABLFJdNSmpOZllqkb5dAlfGv02XmAo2G1ZMapzK2MDYpdnFyMkhIWAi8Wz/
	XNYuRi4OIYHtjBL/frcyQiSkJFZdvwdlC0us/PecHaKonUni1J/3LCAJNgEtib4j35lAbBGB
	CIlp/9YyghQxC9xnlNi6/yobSEJYoIFRYvYcKRCbRUBVou3pf6A4BwevgK3E1385EAvkJfYf
	PMsMYnMK2Else7IRbKYQUMmLKd/YQWxeAUGJkzOfgO1lBqpv3jqbeQKjwCwkqVlIUgsYmVYx
	iqYWFOem5yYXGOoVJ+YWl+al6yXn525iBAe4VtAOxmXr/+odYmTiYDzEKMHBrCTCKzljdqoQ
	b0piZVVqUX58UWlOavEhRmkOFiVxXuWczhQhgfTEktTs1NSC1CKYLBMHp1QDU2fv7Q1NNy+3
	avBJ/Eo7t8n7wV8JQ9G8Ft/F8hs/OjBs+cv/7nvppt3ijwqmT9cKahVYc7H9TbpIyQblV1oO
	U6wXLk258bligvL592XTg23mmFyVOXq+NyZDVfmAeG5H96odrw+G/Pr04EqAuoD6n+sxH7fP
	mxZ3cXG/nPX5us0HkmxFd+aYcYcuTjm0bYMdwzmPkMcVOqUHMnS2H/lyzYVR48W2rPMFr/L1
	lnGHzn4nZmD1T6PjUI/0yoC7sSmPmw7JfZq6nsm3vHaFZFCD6tf5IXer6tLOnYyQKXgRtshn
	Rffe/2vCllx7xWDtMHHvPnf/R0VbG+/sabqmcWcuc5TxtZrulLrIqKk6918LsyixFGckGmox
	FxUnAgBvZ0zF3wIAAA==
X-CMS-MailID: 20240108092025epcas5p39e2ecb3b12b4fba9e41f0694f430ec1d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240108092025epcas5p39e2ecb3b12b4fba9e41f0694f430ec1d
References: <20240108091917.1552013-1-sandeep.cs@samsung.com>
	<CGME20240108092025epcas5p39e2ecb3b12b4fba9e41f0694f430ec1d@epcas5p3.samsung.com>

Add support for samsung wireless bookcover and universal keyboard with input mapping events.

Device a005 (Samsung wireless bookcover keyboard)
Device a006 (Samsung wireless universal keyboard)
Device a064 (Samsung wireless multi hogp keyboard)

Signed-off-by: Sandeep C S <sandeep.cs@samsung.com>
Signed-off-by: Junwan Cho <junwan.cho@samsung.com>
Signed-off-by: Jitender Sajwan <jitender.s21@samsung.com>
---
 drivers/hid/hid-ids.h     |   3 +
 drivers/hid/hid-samsung.c | 142 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b1208d04712c..c03137ada8f5 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1145,6 +1145,9 @@
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD	0x7021
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD	0xa000
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_ACTIONMOUSE	0xa004
+#define USB_DEVICE_ID_SAMSUNG_WIRELESS_BOOKCOVER	0xa005
+#define USB_DEVICE_ID_SAMSUNG_WIRELESS_UNIVERSAL_KBD	0xa006
+#define USB_DEVICE_ID_SAMSUNG_WIRELESS_MULTI_HOGP_KBD	0xa064
 
 #define USB_VENDOR_ID_SEMICO			0x1a2c
 #define USB_DEVICE_ID_SEMICO_USB_KEYKOARD	0x0023
diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
index 36ab9540e064..ba1c71f25d78 100644
--- a/drivers/hid/hid-samsung.c
+++ b/drivers/hid/hid-samsung.c
@@ -362,6 +362,140 @@ static int samsung_actionmouse_input_mapping(struct hid_device *hdev,
 	return 1;
 }
 
+static int samsung_universal_kbd_input_mapping(struct hid_device *hdev,
+	struct hid_input *hi, struct hid_field *field, struct hid_usage *usage,
+	unsigned long **bit, int *max)
+{
+	if (!(HID_UP_CONSUMER == (usage->hid & HID_USAGE_PAGE) ||
+			HID_UP_KEYBOARD == (usage->hid & HID_USAGE_PAGE)))
+		return 0;
+
+	dbg_hid("samsung wireless keyboard input mapping event [0x%x]\n",
+		usage->hid & HID_USAGE);
+
+	if (HID_UP_KEYBOARD == (usage->hid & HID_USAGE_PAGE)) {
+		set_bit(EV_REP, hi->input->evbit);
+		switch (usage->hid & HID_USAGE) {
+		/* Only for UK keyboard */
+		/* key found */
+#ifdef CONFIG_HID_KK_UPGRADE
+		case 0x32:
+			samsung_kbd_mouse_map_key_clear(KEY_KBDILLUMTOGGLE);
+			break;
+		case 0x64:
+			samsung_kbd_mouse_map_key_clear(KEY_BACKSLASH);
+			break;
+#else
+		case 0x32:
+			samsung_kbd_mouse_map_key_clear(KEY_BACKSLASH);
+			break;
+		case 0x64:
+			samsung_kbd_mouse_map_key_clear(KEY_102ND);
+			break;
+#endif
+		/* Only for BR keyboard */
+		case 0x87:
+			samsung_kbd_mouse_map_key_clear(KEY_RO);
+			break;
+		default:
+			return 0;
+		}
+	}
+
+	if (HID_UP_CONSUMER == (usage->hid & HID_USAGE_PAGE)) {
+		switch (usage->hid & HID_USAGE) {
+		/* report 2 */
+		/* MENU */
+		case 0x040:
+			samsung_kbd_mouse_map_key_clear(KEY_MENU);
+			break;
+		case 0x18a:
+			samsung_kbd_mouse_map_key_clear(KEY_MAIL);
+			break;
+		case 0x196:
+			samsung_kbd_mouse_map_key_clear(KEY_WWW);
+			break;
+		case 0x19e:
+			samsung_kbd_mouse_map_key_clear(KEY_SCREENLOCK);
+			break;
+		case 0x221:
+			samsung_kbd_mouse_map_key_clear(KEY_SEARCH);
+			break;
+		case 0x223:
+			samsung_kbd_mouse_map_key_clear(KEY_HOMEPAGE);
+			break;
+		/* RECENTAPPS */
+		case 0x301:
+			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY1);
+			break;
+		/* APPLICATION */
+		case 0x302:
+			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY2);
+			break;
+		/* Voice search */
+		case 0x305:
+			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY4);
+			break;
+		/* QPANEL on/off */
+		case 0x306:
+			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY5);
+			break;
+		/* SIP on/off */
+		case 0x307:
+			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY3);
+			break;
+		/* LANG */
+		case 0x308:
+			samsung_kbd_mouse_map_key_clear(KEY_LANGUAGE);
+			break;
+		case 0x30a:
+			samsung_kbd_mouse_map_key_clear(KEY_BRIGHTNESSDOWN);
+			break;
+		case 0x070:
+			samsung_kbd_mouse_map_key_clear(KEY_BRIGHTNESSDOWN);
+			break;
+		case 0x30b:
+			samsung_kbd_mouse_map_key_clear(KEY_BRIGHTNESSUP);
+			break;
+		case 0x06f:
+			samsung_kbd_mouse_map_key_clear(KEY_BRIGHTNESSUP);
+			break;
+		/* S-Finder */
+		case 0x304:
+			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY7);
+			break;
+		/* Screen Capture */
+		case 0x303:
+			samsung_kbd_mouse_map_key_clear(KEY_SYSRQ);
+			break;
+		/* Multi Window */
+		case 0x309:
+			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY9);
+			break;
+		/* HotKey App 1 */
+		case 0x071:
+			samsung_kbd_mouse_map_key_clear(0x2f5);
+			break;
+		/* HotKey App 2 */
+		case 0x072:
+			samsung_kbd_mouse_map_key_clear(0x2f6);
+			break;
+		/* HotKey App 3 */
+		case 0x073:
+			samsung_kbd_mouse_map_key_clear(0x2f7);
+			break;
+		/* Dex */
+		case 0x06e:
+			samsung_kbd_mouse_map_key_clear(0x2bd);
+			break;
+		default:
+			return 0;
+		}
+	}
+
+	return 1;
+}
+
 static __u8 *samsung_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	unsigned int *rsize)
 {
@@ -388,6 +522,12 @@ static int samsung_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_ACTIONMOUSE)
 		ret = samsung_actionmouse_input_mapping(hdev,
 			hi, field, usage, bit, max);
+	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_UNIVERSAL_KBD)
+		ret = samsung_universal_kbd_input_mapping(hdev,
+			hi, field, usage, bit, max);
+	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_MULTI_HOGP_KBD)
+		ret = samsung_universal_kbd_input_mapping(hdev,
+			hi, field, usage, bit, max);
 
 	return ret;
 }
@@ -433,6 +573,8 @@ static const struct hid_device_id samsung_devices[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_ACTIONMOUSE) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_UNIVERSAL_KBD) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_MULTI_HOGP_KBD) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, samsung_devices);
-- 
2.34.1


