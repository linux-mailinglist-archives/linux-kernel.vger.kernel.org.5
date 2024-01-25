Return-Path: <linux-kernel+bounces-37951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B0C83B8B7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3684B1C23737
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E806A12B78;
	Thu, 25 Jan 2024 04:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="im/a+eHc"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052CB125B2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706157465; cv=none; b=NhRvzUOcFZVvOQ1S127Ian6bmiKqCFTFJJziIPIpZOgp3pd/xvFGdh8uqGHA4DQaJdRxtWv9hOCRrMFn0nKlpXnNdeqgi3B2vD5jEcStVRXWVfaHF+BT/vZ8tE3eXvBIn8DlzsIV2idwApQBR+o59svWTTHuBRGwIamwDyNOvEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706157465; c=relaxed/simple;
	bh=N6YRbOW5sc62cmePVN+BHVrn7+I8UHKno0vh3VSNZR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=nTGnmMlgXKoVrOWwTxAanJVNTg9fQdMd8t51olAtfNat9ZX64o2c0jqylE2u+BAM0L/irRe+4Mz0bKLWWka97pwdP4Ca31BEsYmjb6ay2i5VfqpSOvG018hPp+tH3PdMROUODIqAhUFJqtLh2NdXsn+s7sBfGPL/Wt4ukT5qFM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=im/a+eHc; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240125043741epoutp03bc0aeb67a64372a6f7dcb02df6d97cfe~tfSvVfC-_0190001900epoutp03n
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:37:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240125043741epoutp03bc0aeb67a64372a6f7dcb02df6d97cfe~tfSvVfC-_0190001900epoutp03n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706157461;
	bh=IMWsqDQkVcKt9jaVESfOT/GxXvrsIs2b7EQgMe6T0po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=im/a+eHcJNNsf9LX7NEbL1lDlULcI03lhdaX0ue/TM9JEm3cdQGDflznRopZtnWON
	 M1utlP+s9z9Eu4NZp/NHbSYtAcm6CD/dGK2AyR5szVQDLTc/I8KVMjtpX73PL5ktvi
	 jxBUAnJDwCxIdx71vWGLtQJSXnS6wwW9eSCuXwKY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240125043740epcas5p4c8426d2434f2e4180e96caa44a7a9637~tfSvCkUFO1197811978epcas5p4x;
	Thu, 25 Jan 2024 04:37:40 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TL7NM0kTfz4x9Pr; Thu, 25 Jan
	2024 04:37:39 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E5.7B.09672.095E1B56; Thu, 25 Jan 2024 13:37:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240125043736epcas5p3e42a8c2513e9ee271221df2ee5128240~tfSqyCcLl1781017810epcas5p3a;
	Thu, 25 Jan 2024 04:37:36 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240125043736epsmtrp2412f7d95ac9b2457a6f920d81b19c458~tfSqxOcI11848518485epsmtrp2i;
	Thu, 25 Jan 2024 04:37:36 +0000 (GMT)
X-AuditID: b6c32a4b-39fff700000025c8-22-65b1e590ce6a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	92.5A.07368.095E1B56; Thu, 25 Jan 2024 13:37:36 +0900 (KST)
Received: from ws2030077324.sa.corp.samsungelectronics.net (unknown
	[107.99.237.91]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240125043734epsmtip200f21792839eddbd5a636fb185b3097b~tfSpUZ7ww1113111131epsmtip2K;
	Thu, 25 Jan 2024 04:37:34 +0000 (GMT)
From: Sandeep C S <sandeep.cs@samsung.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<benjamin.tissoires@redhat.com>
Cc: gaudium.lee@samsung.com, ih0923.kim@samsung.com,
	suhyun_.kim@samsung.com, jitender.s21@samsung.com, junwan.cho@samsung.com,
	sandeep.cs@samsung.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [HID Patchsets for Samsung driver v4 6/6] HID: Samsung : Add
 Samsung wireless bookcover and universal keyboard support.
Date: Thu, 25 Jan 2024 10:06:29 +0530
Message-Id: <20240125043630.4031634-7-sandeep.cs@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125043630.4031634-1-sandeep.cs@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTS3fC042pBssOq1pcn7KZ1eL2Ak+L
	rUvmslrcOt7KaPHywQZ2i82TH7FY3Pz0jdXi8q45bBbts58xWjxasYnJgctj06pONo/3+66y
	efRtWcXo8XmTXABLVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2S
	i0+ArltmDtA9SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8dL28
	1BIrQwMDI1OgwoTsjPNL3Ase6ldsXj+PqYHxhXoXIyeHhICJxKKF/9i7GLk4hAR2M0q833CT
	BcL5xCgx/9hZKOcbo8SkQ7uYuxg5wFrO706FiO8Fiq/ezwoySkigk0ni6SxHEJtNQEui78h3
	JhBbRCBC4t2CTYwgNrPAdUaJBw8DQZqFBZoYJbZs2wJWxCKgKvFl7mewBbwCthKPfstDnCcv
	sf/gWWYQm1PATqJv6Ruwcl4BQYmTM5+wQMyUl2jeOpsZZKaEwF92iUszQGaCHOoisecTL8Qc
	YYlXx7ewQ9hSEp/f7WWDqO9mlFh6+xg7hDODUaJl51VmiCp7iZ+vJ7CBDGIW0JRYv0sfYhmf
	RO/vJ1DzeSU62oQgqlUknnbtZoWZ//3ERiYI20Pi0q53zJDwmcgosfoz4wRG+VlIXpiF5IVZ
	CMsWMDKvYpRMLSjOTU8tNi0wzksth0drcn7uJkZwotTy3sH46MEHvUOMTByMhxglOJiVRHhN
	TDemCvGmJFZWpRblxxeV5qQWH2I0BQbxRGYp0eR8YKrOK4k3NLE0MDEzMzOxNDYzVBLnfd06
	N0VIID2xJDU7NbUgtQimj4mDU6qB6Z5wvLOZSQkP95c94qwM2t9Fnl89V71dyrh291xNxxZp
	7VseE+rFutcrNksbbm06K/h0l6uq+YIb/0s2RuUUODldlhL6fIalV1ZyOtOllcGF3kFCvtKq
	mbn8dh9DHGbxFL0xVfBQLfjn/ezZnUju709L9qa3T5z9MfpuRYpc4eHUedwG7pt57rm/nSbS
	8npOkdjt3OOZP2MTH2l/VlURniZfrx9xWl/gus/s/hehnlWXevWupST6H3jeN3nSVYsESe1L
	xnkqLAIsy/W89rJeFvdoCjSovT/r5OPAHSskrPf8vx8YIyZ97l33pnvr7gWfz7CbbcwnEDbV
	Pup86+yD9+emJd6+ILJx346Je88osRRnJBpqMRcVJwIAGsuumx0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsWy7bCSvO6EpxtTDTq+sVpcn7KZ1eL2Ak+L
	rUvmslrcOt7KaPHywQZ2i82TH7FY3PwEVHF51xw2i/bZzxgtHq3YxOTA5bFpVSebx/t9V9k8
	+rasYvT4vEkugCWKyyYlNSezLLVI3y6BK+P8EveCh/oVm9fPY2pgfKHexcjBISFgInF+d2oX
	IxeHkMBuRolFW3YxdTFyAsWlJFZdv8cIYQtLrPz3nB2iqJ1J4vGqZmaQBJuAlkTfke9gDSIC
	ERLT/q1lBCliFrjPKLF1/1U2EEdYoIFRov/wf7BRLAKqEl/mfmYGWc0rYCvx6Lc8xAZ5if0H
	z4IN5RSwk+hb+gZsqBBQyf03s1lBbF4BQYmTM5+wgNjMQPXNW2czT2AUmIUkNQtJagEj0ypG
	ydSC4tz03GTDAsO81HK94sTc4tK8dL3k/NxNjOAw19LYwXhv/j+9Q4xMHIyHGCU4mJVEeE1M
	N6YK8aYkVlalFuXHF5XmpBYfYpTmYFES5zWcMTtFSCA9sSQ1OzW1ILUIJsvEwSnVwHQk4E5E
	3yqxWV2JmfvsGSztr+dkPFcOXP5DWKOaZf6+F8cqfx1Y9WJPiJDwRb9jzUlPwheZfJl/rmXK
	0vk6Gu+LzHde6X7Wcdnyi1TfHD7x8ktz181c9X+L1YXALXF7+PWiLtx8MK1GLs8qcCpHhXYa
	k53VRtO+cpNEz30Hvi7btLZTdquavU7eVPunbgKTu9l1zxxsrxdMjN3cf/69QXH6LAmjSUIr
	s+Xvp3710jGNS6li1HqrtcnxQVE584fpS+w2S6/c/G/SlJMX3V4ssettMmd+1qMzOWfGqSL1
	VTzn+c8mxbC+dr+5+82lfTnpqRpnL+4r1Li5eUf1UaXjhmuuO8/QEz4j+WEXv6Ov92ElluKM
	REMt5qLiRACE/etx4gIAAA==
X-CMS-MailID: 20240125043736epcas5p3e42a8c2513e9ee271221df2ee5128240
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240125043736epcas5p3e42a8c2513e9ee271221df2ee5128240
References: <20240125043630.4031634-1-sandeep.cs@samsung.com>
	<CGME20240125043736epcas5p3e42a8c2513e9ee271221df2ee5128240@epcas5p3.samsung.com>

Add support for samsung wireless bookcover and universal keyboard with input mapping events.

Device a005 (Samsung wireless bookcover keyboard)
Device a006 (Samsung wireless universal keyboard)
Device a064 (Samsung wireless multi hogp keyboard)

Signed-off-by: Sandeep C S <sandeep.cs@samsung.com>
Signed-off-by: Junwan Cho <junwan.cho@samsung.com>
Signed-off-by: Jitender Sajwan <jitender.s21@samsung.com>
Signed-off-by: Gwangho Lee <gaudium.lee@samsung.com>
---
 drivers/hid/hid-ids.h     |   3 +
 drivers/hid/hid-samsung.c | 131 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 06bf718961da..221bae808c25 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1149,6 +1149,9 @@
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD	0x7021
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD	0xa000
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_ACTIONMOUSE	0xa004
+#define USB_DEVICE_ID_SAMSUNG_WIRELESS_BOOKCOVER	0xa005
+#define USB_DEVICE_ID_SAMSUNG_WIRELESS_UNIVERSAL_KBD	0xa006
+#define USB_DEVICE_ID_SAMSUNG_WIRELESS_MULTI_HOGP_KBD	0xa064
 
 #define USB_VENDOR_ID_SEMICO			0x1a2c
 #define USB_DEVICE_ID_SEMICO_USB_KEYKOARD	0x0023
diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
index 0de23a70dddb..08fb25b8459a 100644
--- a/drivers/hid/hid-samsung.c
+++ b/drivers/hid/hid-samsung.c
@@ -346,6 +346,129 @@ static int samsung_actionmouse_input_mapping(struct hid_device *hdev,
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
+		case 0x32:
+			samsung_kbd_mouse_map_key_clear(KEY_BACKSLASH);
+			break;
+		case 0x64:
+			samsung_kbd_mouse_map_key_clear(KEY_102ND);
+			break;
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
@@ -372,6 +495,12 @@ static int samsung_input_mapping(struct hid_device *hdev, struct hid_input *hi,
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
@@ -417,6 +546,8 @@ static const struct hid_device_id samsung_devices[] = {
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


