Return-Path: <linux-kernel+bounces-37947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9679B83B8AE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 451C32881CD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625AC10A1A;
	Thu, 25 Jan 2024 04:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FnQmKy8X"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5572010A0A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706157430; cv=none; b=BBsSM5kGemYpMtxvDGBPjScUwuEs5Q68dm5/PN/8KI6ZgMp3nQWlIj24w0CuhNUC7+svcWephdbP1azhKv2qxPFKxgURG5jqjhfZYCMSLAeW1lL5myBlT29HfA8x4SLeluSOXKf8zAWzSFGHwFCkixCptzDyGKjwjkodQa6oPsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706157430; c=relaxed/simple;
	bh=rmEWhlVDpeIv0NBvUoVUkcUuNtoCG83x6jLTykAx0mI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Mih9/vRJy3HREwdTAgbRDZ4kNCvhdaFhizfuzK9n9GZ6JDDtaIeaUFn10GwqjbqbpbaL1S3BzO/QiBDJGp6G8T4h66Dh11gyu++EIv6edPZcDZWDgdLvMelpnMuSdAJevb/3qzsYXne/6LBok5Fv6Bt6ZnjUl1zgAKIEc50TldM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FnQmKy8X; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240125043705epoutp01b5563a18b45d2faff699dc4a7c0fdb05~tfSNzDx_U0209802098epoutp01e
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:37:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240125043705epoutp01b5563a18b45d2faff699dc4a7c0fdb05~tfSNzDx_U0209802098epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706157425;
	bh=KW0GPlc8JiP+I2GAgypKX/jwr3P9ZdZ55AOnVvit4IE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FnQmKy8X2fB2W9KnM9z43KKEIYAyNKSnd30fzG2rhtcKVcUXHmCg2MHvYjpE1ONy7
	 QSBij66y7d61n2kGDauPTp5SeqdDQ1g6x7l46Hocz3ErXNUAG6OYYfEjlMcNclZ+FU
	 bihsuo+BENsFTotUO02RzV+1hBjTJUWT/Tx7gqCU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240125043704epcas5p4860f2846d3f44b15c3d426a8fe32fe67~tfSNfEfVB2513325133epcas5p4E;
	Thu, 25 Jan 2024 04:37:04 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TL7Mg0Y0Qz4x9Q8; Thu, 25 Jan
	2024 04:37:03 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	93.C6.09634.E65E1B56; Thu, 25 Jan 2024 13:37:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240125043702epcas5p33d9ef989dc51276185972d4517ba80fd~tfSLl3TTk0575905759epcas5p3Z;
	Thu, 25 Jan 2024 04:37:02 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240125043702epsmtrp10f457bf9d1f2c4998f7b9d6a583b78cf~tfSLkXaOM1583815838epsmtrp1U;
	Thu, 25 Jan 2024 04:37:02 +0000 (GMT)
X-AuditID: b6c32a49-eebff700000025a2-4e-65b1e56ea263
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	1B.DB.18939.E65E1B56; Thu, 25 Jan 2024 13:37:02 +0900 (KST)
Received: from ws2030077324.sa.corp.samsungelectronics.net (unknown
	[107.99.237.91]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240125043701epsmtip2c0ee6edc7c3236fb782a9d45485830e1~tfSKG6JX12197421974epsmtip2r;
	Thu, 25 Jan 2024 04:37:00 +0000 (GMT)
From: Sandeep C S <sandeep.cs@samsung.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<benjamin.tissoires@redhat.com>
Cc: gaudium.lee@samsung.com, ih0923.kim@samsung.com,
	suhyun_.kim@samsung.com, jitender.s21@samsung.com, junwan.cho@samsung.com,
	sandeep.cs@samsung.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [HID Patchsets for Samsung driver v4 2/6] HID: Samsung : Fix the
 checkpatch complain. Rewritten code using memcmp where applicable.
Date: Thu, 25 Jan 2024 10:06:25 +0530
Message-Id: <20240125043630.4031634-3-sandeep.cs@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125043630.4031634-1-sandeep.cs@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTSzfv6cZUg21rbSyuT9nManF7gafF
	1iVzWS1uHW9ltHj5YAO7xebJj1gsbn76xmpxedccNov22c8YLR6t2MTkwOWxaVUnm8f7fVfZ
	PPq2rGL0+LxJLoAlKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
	xSdA1y0zB+geJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5e
	aomVoYGBkSlQYUJ2xvmr/5kLTmpVTFp2g6WBcYtyFyMnh4SAicTjqWdYuxi5OIQEdjNKPP8E
	43xilNjQMgPB+Xx1FztMy6P9FxkhEjsZJc4+fcwC4XQySUzY/ZQJpIpNQEui78h3MFtEIELi
	3YJNjCA2s8B1RokHDwNBGoQF+hglnl7+DTaWRUBV4vvSk8wgNq+ArcSU81+YIdbJS+w/eBbM
	5hSwk+hb+oYJokZQ4uTMJywQQ+UlmrfOZgYZKiHwlV3iy8N5QEUcQI6LxIyl3hBzhCVeHd8C
	9YKUxMv+NnaI+m5GiaW3j0E5MxglWnZehdpsL/Hz9QQ2kEHMApoS63fpQyzjk+j9/QRqPq9E
	R5sQRLWKxNOu3aww87+f2MgEYXtIHLl9HxpCExklWuf8YJ7AKD8LyQ+zkPwwC2HbAkbmVYyS
	qQXFuempxaYFhnmp5fC4Tc7P3cQITplanjsY7z74oHeIkYmD8RCjBAezkgivienGVCHelMTK
	qtSi/Pii0pzU4kOMpsBAnsgsJZqcD0zaeSXxhiaWBiZmZmYmlsZmhkrivK9b56YICaQnlqRm
	p6YWpBbB9DFxcEo1MJUV6LR36OSuW/6yu3al57870c+q/+/kbF9YxvngiMTmm8b9VgGPzaOW
	PGlR2brNWKVzTmgRj+0fLtmX536fqfaeqLHMS8ClVU92QvCLVYz7Hs+b5sFRGsEeolj5IL/j
	4Zb+azN1ZBeckbykOOf9vkV2/ya9eHvgQ5DCwpUBH049T2ZlSH0r5tgpx/avPFLnneUSndfx
	54wemT/sWLzH7pL9KrPMKRGvjwRf+WL/3CxnSkvsrl+XOBLCHDokp3xZsuBz0T8b/fZzzRwy
	Iqoxv7gutz36f7T1QnTeyYe1rCvTp2vyPyg6vsnG2EVV4uRynsoDfjaLYiWXC7SlSoYd3rWY
	9WOe5Y0/wuKVPpm/+5RYijMSDbWYi4oTATDmAN8iBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWy7bCSvG7e042pBs+PqVhcn7KZ1eL2Ak+L
	rUvmslrcOt7KaPHywQZ2i82TH7FY3Pz0jdXi8q45bBbts58xWjxasYnJgctj06pONo/3+66y
	efRtWcXo8XmTXABLFJdNSmpOZllqkb5dAlfG+av/mQtOalVMWnaDpYFxi3IXIyeHhICJxKP9
	FxlBbCGB7YwSh57ZQcSlJFZdv8cIYQtLrPz3nL2LkQuopp1JYu7PS2wgCTYBLYm+I9+ZQGwR
	gQiJaf/WMoIUMQvcZ5TYuv8qG4gjLNDDKPH38j1mkCoWAVWJ70tPgtm8ArYSU85/YYZYIS+x
	/+BZMJtTwE6ib+kbJoiTbCXuv5nNClEvKHFy5hMWEJsZqL5562zmCYwCs5CkZiFJLWBkWsUo
	mlpQnJuem1xgqFecmFtcmpeul5yfu4kRHOJaQTsYl63/q3eIkYmD8RCjBAezkgivienGVCHe
	lMTKqtSi/Pii0pzU4kOM0hwsSuK8yjmdKUIC6YklqdmpqQWpRTBZJg5OqQampQKTjl0Q99V7
	+KgpcILUBt3iL0v+eRhNmNLaed+iscZyXeK55b6nP65ecqgn7uLP1eGa0ZE9Sze+WzeFT+ut
	n4npI2fezw+Kc2f+i+k7wNjs8UIi8rxXeLDHK6uAD9bRW98m6H7T/bXx3+FspS0tD5/qXe66
	ofQskYXb/fQ//un6+35+mVnnFjuz/HeRZM2S719WN97wuKrxNLuMv215hTL3hcjEjxda5A0n
	3F/Dxxk+c47B+WP5/IcXrdssyn5PrE3VwPJR7Y/SD6KdvL7ZSpNc1WLcV21e8naOWsq5A1P3
	MxVvnKgic4+Jd6e4YNOmBLNjQZsLWqblXyyrCXPZ8tms7U1uB7OMbZaBlHO3EktxRqKhFnNR
	cSIATNyjseACAAA=
X-CMS-MailID: 20240125043702epcas5p33d9ef989dc51276185972d4517ba80fd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240125043702epcas5p33d9ef989dc51276185972d4517ba80fd
References: <20240125043630.4031634-1-sandeep.cs@samsung.com>
	<CGME20240125043702epcas5p33d9ef989dc51276185972d4517ba80fd@epcas5p3.samsung.com>

Resolved warnings found by checkpatch.pl script.

Signed-off-by: Sandeep C S <sandeep.cs@samsung.com>
Signed-off-by: Junwan Cho <junwan.cho@samsung.com>
Signed-off-by: Jitender Sajwan <jitender.s21@samsung.com>
---
 drivers/hid/hid-samsung.c | 80 +++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 33 deletions(-)

diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
index 3a8756232731..97d0bf7d4d7e 100644
--- a/drivers/hid/hid-samsung.c
+++ b/drivers/hid/hid-samsung.c
@@ -58,33 +58,25 @@ static inline void samsung_irda_dev_trace(struct hid_device *hdev,
 static __u8 *samsung_irda_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
-	if (*rsize == 184 && rdesc[175] == 0x25 && rdesc[176] == 0x40 &&
-			rdesc[177] == 0x75 && rdesc[178] == 0x30 &&
-			rdesc[179] == 0x95 && rdesc[180] == 0x01 &&
+	if (*rsize == 184 && !memcmp(&rdesc[175], "\x25\x40\x75\x30\x95\x01", 6) &&
 			rdesc[182] == 0x40) {
 		samsung_irda_dev_trace(hdev, 184);
 		rdesc[176] = 0xff;
 		rdesc[178] = 0x08;
 		rdesc[180] = 0x06;
 		rdesc[182] = 0x42;
-	} else
-	if (*rsize == 203 && rdesc[192] == 0x15 && rdesc[193] == 0x0 &&
-			rdesc[194] == 0x25 && rdesc[195] == 0x12) {
+	} else if (*rsize == 203 && !memcmp(&rdesc[192], "\x15\x00\x25\x12", 4)) {
 		samsung_irda_dev_trace(hdev, 203);
-		rdesc[193] = 0x1;
-		rdesc[195] = 0xf;
-	} else
-	if (*rsize == 135 && rdesc[124] == 0x15 && rdesc[125] == 0x0 &&
-			rdesc[126] == 0x25 && rdesc[127] == 0x11) {
+		rdesc[193] = 0x01;
+		rdesc[195] = 0x0f;
+	} else if (*rsize == 135 && !memcmp(&rdesc[124], "\x15\x00\x25\x11", 4)) {
 		samsung_irda_dev_trace(hdev, 135);
-		rdesc[125] = 0x1;
-		rdesc[127] = 0xe;
-	} else
-	if (*rsize == 171 && rdesc[160] == 0x15 && rdesc[161] == 0x0 &&
-			rdesc[162] == 0x25 && rdesc[163] == 0x01) {
+		rdesc[125] = 0x01;
+		rdesc[127] = 0x0e;
+	} else if (*rsize == 171 && !memcmp(&rdesc[160], "\x15\x00\x25\x01", 4)) {
 		samsung_irda_dev_trace(hdev, 171);
-		rdesc[161] = 0x1;
-		rdesc[163] = 0x3;
+		rdesc[161] = 0x01;
+		rdesc[163] = 0x03;
 	}
 	return rdesc;
 }
@@ -99,7 +91,7 @@ static int samsung_kbd_mouse_input_mapping(struct hid_device *hdev,
 	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
 	unsigned short ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
 
-	if (1 != ifnum || HID_UP_CONSUMER != (usage->hid & HID_USAGE_PAGE))
+	if (ifnum != 1 || HID_UP_CONSUMER != (usage->hid & HID_USAGE_PAGE))
 		return 0;
 
 	dbg_hid("samsung wireless keyboard/mouse input mapping event [0x%x]\n",
@@ -107,17 +99,39 @@ static int samsung_kbd_mouse_input_mapping(struct hid_device *hdev,
 
 	switch (usage->hid & HID_USAGE) {
 	/* report 2 */
-	case 0x183: samsung_kbd_mouse_map_key_clear(KEY_MEDIA); break;
-	case 0x195: samsung_kbd_mouse_map_key_clear(KEY_EMAIL);	break;
-	case 0x196: samsung_kbd_mouse_map_key_clear(KEY_CALC); break;
-	case 0x197: samsung_kbd_mouse_map_key_clear(KEY_COMPUTER); break;
-	case 0x22b: samsung_kbd_mouse_map_key_clear(KEY_SEARCH); break;
-	case 0x22c: samsung_kbd_mouse_map_key_clear(KEY_WWW); break;
-	case 0x22d: samsung_kbd_mouse_map_key_clear(KEY_BACK); break;
-	case 0x22e: samsung_kbd_mouse_map_key_clear(KEY_FORWARD); break;
-	case 0x22f: samsung_kbd_mouse_map_key_clear(KEY_FAVORITES); break;
-	case 0x230: samsung_kbd_mouse_map_key_clear(KEY_REFRESH); break;
-	case 0x231: samsung_kbd_mouse_map_key_clear(KEY_STOP); break;
+	case 0x183:
+		samsung_kbd_mouse_map_key_clear(KEY_MEDIA);
+		break;
+	case 0x195:
+		samsung_kbd_mouse_map_key_clear(KEY_EMAIL);
+		break;
+	case 0x196:
+		samsung_kbd_mouse_map_key_clear(KEY_CALC);
+		break;
+	case 0x197:
+		samsung_kbd_mouse_map_key_clear(KEY_COMPUTER);
+		break;
+	case 0x22b:
+		samsung_kbd_mouse_map_key_clear(KEY_SEARCH);
+		break;
+	case 0x22c:
+		samsung_kbd_mouse_map_key_clear(KEY_WWW);
+		break;
+	case 0x22d:
+		samsung_kbd_mouse_map_key_clear(KEY_BACK);
+		break;
+	case 0x22e:
+		samsung_kbd_mouse_map_key_clear(KEY_FORWARD);
+		break;
+	case 0x22f:
+		samsung_kbd_mouse_map_key_clear(KEY_FAVORITES);
+		break;
+	case 0x230:
+		samsung_kbd_mouse_map_key_clear(KEY_REFRESH);
+		break;
+	case 0x231:
+		samsung_kbd_mouse_map_key_clear(KEY_STOP);
+		break;
 	default:
 		return 0;
 	}
@@ -128,7 +142,7 @@ static int samsung_kbd_mouse_input_mapping(struct hid_device *hdev,
 static __u8 *samsung_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	unsigned int *rsize)
 {
-	if (USB_DEVICE_ID_SAMSUNG_IR_REMOTE == hdev->product && hid_is_usb(hdev))
+	if (hdev->product == USB_DEVICE_ID_SAMSUNG_IR_REMOTE && hid_is_usb(hdev))
 		rdesc = samsung_irda_report_fixup(hdev, rdesc, rsize);
 	return rdesc;
 }
@@ -139,7 +153,7 @@ static int samsung_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 {
 	int ret = 0;
 
-	if (USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE == hdev->product && hid_is_usb(hdev))
+	if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE && hid_is_usb(hdev))
 		ret = samsung_kbd_mouse_input_mapping(hdev,
 			hi, field, usage, bit, max);
 
@@ -158,7 +172,7 @@ static int samsung_probe(struct hid_device *hdev,
 		goto err_free;
 	}
 
-	if (USB_DEVICE_ID_SAMSUNG_IR_REMOTE == hdev->product) {
+	if (hdev->product == USB_DEVICE_ID_SAMSUNG_IR_REMOTE) {
 		if (!hid_is_usb(hdev)) {
 			ret = -EINVAL;
 			goto err_free;
-- 
2.34.1


