Return-Path: <linux-kernel+bounces-19266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E432D826A92
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 099EA1C21D43
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519DF14AA2;
	Mon,  8 Jan 2024 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZuFzHN7l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E010814A8C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240108092012epoutp01bfdc41c19f88b18304ef46ffb724e5e5~oVLjjYxeE1907819078epoutp01g
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:20:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240108092012epoutp01bfdc41c19f88b18304ef46ffb724e5e5~oVLjjYxeE1907819078epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704705612;
	bh=JER64z6YgXsvP6WOJLry40zGqwaQo1yWzkXmbxq2ByQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZuFzHN7liIbCSPso378ei+JBi93dMW0EFqKrJen0mrAOgXUdVDA8Rz6MipSd/KklR
	 ICB1ng7pzPlSm3VEvGvxVF4zJcuJ4Gyo+Mx6ZgQBE1xvTzJbysZGXA9UAnCKqss3jl
	 ucdsqsb780l4YA8em2IF7wY0TXdqEDX+Y/T0fnnQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240108092011epcas5p11a77fac6e70603822beeaa8f8eef49d3~oVLjRNr3q2667326673epcas5p1r;
	Mon,  8 Jan 2024 09:20:11 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4T7pS96DPkz4x9Py; Mon,  8 Jan
	2024 09:20:09 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EA.88.09672.94EBB956; Mon,  8 Jan 2024 18:20:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240108092009epcas5p15c5be87fa427a5c4426c55c86c5ce3bc~oVLhFrozI2667326673epcas5p1Y;
	Mon,  8 Jan 2024 09:20:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240108092009epsmtrp2ebdbb4c3b337cef34748291db26d2d27~oVLhE_mOG2003120031epsmtrp2C;
	Mon,  8 Jan 2024 09:20:09 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-cd-659bbe4968e3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7F.57.08755.94EBB956; Mon,  8 Jan 2024 18:20:09 +0900 (KST)
Received: from ws2030077324.sa.corp.samsungelectronics.net (unknown
	[107.99.237.91]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240108092007epsmtip254afeccaaa7d464d392151075f9d7472~oVLfbglWK2117021170epsmtip2d;
	Mon,  8 Jan 2024 09:20:07 +0000 (GMT)
From: Sandeep C S <sandeep.cs@samsung.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<benjamin.tissoires@redhat.com>
Cc: gaudium.lee@samsung.com, ih0923.kim@samsung.com,
	suhyun_.kim@samsung.com, jitender.s21@samsung.com, junwan.cho@samsung.com,
	sandeep.cs@samsung.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [HID Patchsets for Samsung driver v2 4/6] HID: Samsung : Add
 Samsung wireless gamepad support.
Date: Mon,  8 Jan 2024 14:49:14 +0530
Message-Id: <20240108091917.1552013-5-sandeep.cs@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108091917.1552013-1-sandeep.cs@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTU9dz3+xUg1u79C2uT9nManF7gafF
	1iVzWS1uHW9ltHj5YAO7xebJj1gsbn76xmpxedccNov22c8YLR6t2MTkwOWxaVUnm8f7fVfZ
	PPq2rGL0+LxJLoAlKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
	xSdA1y0zB+geJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5e
	aomVoYGBkSlQYUJ2xpyrc1kLTihXLN79hLWB8bhsFyMnh4SAicT5D19Zuxi5OIQEdjNKbFnT
	zgjhfGKUaHyxnB3C+cYo0b+kmx2mZevT21Atexkl5h79wQqSEBLoZJJ48UwAxGYT0JLoO/Kd
	CcQWEYiQeLdgEyOIzSxwnVHiwcNAEFtYIFNi476dYL0sAqoSTz6sZAOxeQVsJfZch4hLCMhL
	7D94lhnE5hSwk9j2ZCMTRI2gxMmZT1ggZspLNG+dzQxykITAT3aJSXd2QV3qIrF5yWFGCFtY
	4tXxLVBxKYnP7/ayQTR0M0osvX2MHcKZwSjRsvMqM0SVvcTP1xOAqjiAVmhKrN+lD7GNT6L3
	9xMmkLCEAK9ER5sQRLWKxNOu3aww87+fgDhUQsBDYvKFdeyQAJrIKLH/bcIERvlZSH6YheSH
	WQjLFjAyr2KUTC0ozk1PLTYtMM5LLYfHbHJ+7iZGcLrU8t7B+OjBB71DjEwcjIcYJTiYlUR4
	JWfMThXiTUmsrEotyo8vKs1JLT7EaAoM5InMUqLJ+cCEnVcSb2hiaWBiZmZmYmlsZqgkzvu6
	dW6KkEB6YklqdmpqQWoRTB8TB6dUA5POL8Y3K/Oy9bv+JM4KPcb6RenJt7JpG459E19ssezi
	ZQ6l8rglTUKLvBxfNETfq3zQcWYa38UXjsumH3rR2zqhjiP+3V/to4FTO9MmKN3/o/Pk6fI0
	hhWnTk0pdtjh2HquQ54juXV7cL/Djw0y3fOFLtRoFNouMuE/6HrnggCrRram+XbX31P7F6jm
	u2yb9Npq6/evnSVbhPfHesv9zhboyhd2mmw5ufnEC/bT+w21K2qfHFcV/VPJIbVUIff+328v
	f9TLfGXZ5se8JUcxNKk/e/n0mDk6IUZ6Ho9iV//J22a/onmy9l3mrzMjsq+E3pvDaat+rFdk
	fXd+kO/iBc5B34tYHx0Lnet/Piiw6ZgSS3FGoqEWc1FxIgA9JldtIAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSvK7nvtmpBm+28Vpcn7KZ1eL2Ak+L
	rUvmslrcOt7KaPHywQZ2i82TH7FY3Pz0jdXi8q45bBbts58xWjxasYnJgctj06pONo/3+66y
	efRtWcXo8XmTXABLFJdNSmpOZllqkb5dAlfGnKtzWQtOKFcs3v2EtYHxuGwXIyeHhICJxNan
	t1m7GLk4hAR2M0q03T/LApGQklh1/R4jhC0ssfLfc3aIonYmiUkv3rCCJNgEtCT6jnxnArFF
	BCIkpv1bywhSxCxwn1Fi6/6rbCAJYYF0iSNb14BNYhFQlXjyYSVYnFfAVmLP9Z2sEBvkJfYf
	PMsMYnMK2Else7IRbKgQUM2LKd/YIeoFJU7OfAJ2HTNQffPW2cwTGAVmIUnNQpJawMi0ilEy
	taA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjONS1NHcwbl/1Qe8QIxMH4yFGCQ5mJRFeyRmz
	U4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzir/oTRESSE8sSc1OTS1ILYLJMnFwSjUwHQ99/6XW
	e8UkO1Ov2A9Xf+nI+imK7UiavGirh95JIbse9pN3djXpbmGq33JY9+2xbvlnLxuyNQ8qN5yf
	Zs7V1ea298uj4p6ARJ9k/Tzua5NcHhWu0BBn9JpTozDxx7rDl0rNHyjnl733fODIesmk+TW7
	ZCHXwk756Rsu6aaZWi1QOssu9NBz5tdJf8Su/WX58f605Xojbn6RmSFfema/9/nUZLpuso/e
	ow9CZ0o3zlS9nrLX5ppAj47ctiNSO3VvNNY+3hfS9Hn//e+vGsMEXR5x6qieuLfYSGjHQaFM
	rbItE5u7rU4bKyRP+NRsF7P3+ruUyTxiNzo2n31TsOyMLuuTwtqOf7ZRlXcf7ZmUoMRSnJFo
	qMVcVJwIANp7o9LkAgAA
X-CMS-MailID: 20240108092009epcas5p15c5be87fa427a5c4426c55c86c5ce3bc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240108092009epcas5p15c5be87fa427a5c4426c55c86c5ce3bc
References: <20240108091917.1552013-1-sandeep.cs@samsung.com>
	<CGME20240108092009epcas5p15c5be87fa427a5c4426c55c86c5ce3bc@epcas5p1.samsung.com>

Add support for samsung wireless gamepad with input mapping events.

Device a000 (Samsung wireless gamepad)

Signed-off-by: Sandeep C S <sandeep.cs@samsung.com>
Signed-off-by: Junwan Cho <junwan.cho@samsung.com>
Signed-off-by: Jitender Sajwan <jitender.s21@samsung.com>
---
 drivers/hid/hid-ids.h     |  1 +
 drivers/hid/hid-samsung.c | 95 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 2f526dc8983a..2851dc25f949 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1143,6 +1143,7 @@
 #define USB_DEVICE_ID_SAMSUNG_IR_REMOTE	0x0001
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE	0x0600
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD	0x7021
+#define USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD	0xa000
 
 #define USB_VENDOR_ID_SEMICO			0x1a2c
 #define USB_DEVICE_ID_SEMICO_USB_KEYKOARD	0x0023
diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
index 611acd7ffd6d..6b08acd3c4fd 100644
--- a/drivers/hid/hid-samsung.c
+++ b/drivers/hid/hid-samsung.c
@@ -248,6 +248,97 @@ static int samsung_kbd_input_mapping(struct hid_device *hdev,
 	return 1;
 }
 
+static int samsung_gamepad_input_mapping(struct hid_device *hdev,
+	struct hid_input *hi, struct hid_field *field, struct hid_usage *usage,
+	unsigned long **bit, int *max)
+{
+	if (!(HID_UP_BUTTON == (usage->hid & HID_USAGE_PAGE) ||
+			HID_UP_CONSUMER == (usage->hid & HID_USAGE_PAGE)))
+		return 0;
+
+	dbg_hid("samsung wireless gamepad input mapping event [0x%x], %ld, %ld, [0x%x]\n",
+		usage->hid & HID_USAGE, hi->input->evbit[0], hi->input->absbit[0], usage->hid & HID_USAGE_PAGE);
+
+	if (HID_UP_BUTTON == (usage->hid & HID_USAGE_PAGE)) {
+		switch (usage->hid & HID_USAGE) {
+		case 0x01:
+			samsung_kbd_mouse_map_key_clear(BTN_A);
+			break;
+		case 0x02:
+			samsung_kbd_mouse_map_key_clear(BTN_B);
+			break;
+		case 0x03:
+			samsung_kbd_mouse_map_key_clear(BTN_C);
+			break;
+		case 0x04:
+			samsung_kbd_mouse_map_key_clear(BTN_X);
+			break;
+		case 0x05:
+			samsung_kbd_mouse_map_key_clear(BTN_Y);
+			break;
+		case 0x06:
+			samsung_kbd_mouse_map_key_clear(BTN_Z);
+			break;
+		case 0x07:
+			samsung_kbd_mouse_map_key_clear(BTN_TL);
+			break;
+		case 0x08:
+			samsung_kbd_mouse_map_key_clear(BTN_TR);
+			break;
+		case 0x09:
+			samsung_kbd_mouse_map_key_clear(BTN_TL2);
+			break;
+		case 0x0a:
+			samsung_kbd_mouse_map_key_clear(BTN_TR2);
+			break;
+		case 0x0b:
+			samsung_kbd_mouse_map_key_clear(BTN_SELECT);
+			break;
+		case 0x0c:
+			samsung_kbd_mouse_map_key_clear(BTN_START);
+			break;
+		case 0x0d:
+			samsung_kbd_mouse_map_key_clear(BTN_MODE);
+			break;
+		case 0x0e:
+			samsung_kbd_mouse_map_key_clear(BTN_THUMBL);
+			break;
+		case 0x0f:
+			samsung_kbd_mouse_map_key_clear(BTN_THUMBR);
+			break;
+		case 0x10:
+			samsung_kbd_mouse_map_key_clear(0x13f);
+			break;
+		default:
+			return 0;
+		}
+	}
+
+	if (HID_UP_CONSUMER == (usage->hid & HID_USAGE_PAGE)) {
+		switch (usage->hid & HID_USAGE) {
+		case 0x040:
+			samsung_kbd_mouse_map_key_clear(KEY_MENU);
+			break;
+		case 0x223:
+			samsung_kbd_mouse_map_key_clear(KEY_HOMEPAGE);
+			break;
+		case 0x224:
+			samsung_kbd_mouse_map_key_clear(KEY_BACK);
+			break;
+
+		/* Screen Capture */
+		case 0x303:
+			samsung_kbd_mouse_map_key_clear(KEY_SYSRQ);
+			break;
+
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
@@ -268,6 +359,9 @@ static int samsung_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD)
 		ret = samsung_kbd_input_mapping(hdev,
 			hi, field, usage, bit, max);
+	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD)
+		ret = samsung_gamepad_input_mapping(hdev,
+			hi, field, usage, bit, max);
 
 	return ret;
 }
@@ -311,6 +405,7 @@ static const struct hid_device_id samsung_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, samsung_devices);
-- 
2.34.1


