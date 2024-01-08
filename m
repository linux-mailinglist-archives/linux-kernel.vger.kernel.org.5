Return-Path: <linux-kernel+bounces-19267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F98F826A95
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BB21C21CE2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EA225554;
	Mon,  8 Jan 2024 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fQ6/yQxV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A602209B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240108092020epoutp02867bad8cdc74f91af9fbbb700ba567e8~oVLrNNvNa3251132511epoutp02a
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:20:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240108092020epoutp02867bad8cdc74f91af9fbbb700ba567e8~oVLrNNvNa3251132511epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704705620;
	bh=n5G3LFStaWOaj8LKX+Yj5qv1FL8fnQNC3jRblVEBwZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fQ6/yQxVUBOs7TSlPU5KulIs4PrTdAlV19rLtHh6yuI7R+IHp8TTOmoHdU5yBSxsK
	 l6JOesEqPypJLE/JqvWBwFi0+36Yu096M2UOSKWjStPnklwZjktQTcaZjogl7d6YuV
	 yXgG2ftjV/O6raf8z+VM6hv0JRDQ/kMm/R8iWvmY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240108092019epcas5p32bb7cedfa6eae9ccfc0871ae5fcefbc7~oVLq19bw60530905309epcas5p3B;
	Mon,  8 Jan 2024 09:20:19 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4T7pSL0fD6z4x9Px; Mon,  8 Jan
	2024 09:20:18 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	26.32.10009.15EBB956; Mon,  8 Jan 2024 18:20:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240108092017epcas5p24c1c263149a0a8bf3204c86925e3cfd9~oVLoxkwlr0637406374epcas5p2Z;
	Mon,  8 Jan 2024 09:20:17 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240108092017epsmtrp1ef99b2c3aa419f9c256adedbe3d85f9c~oVLow1Sqz1924619246epsmtrp1T;
	Mon,  8 Jan 2024 09:20:17 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-ef-659bbe510e22
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	98.D0.18939.15EBB956; Mon,  8 Jan 2024 18:20:17 +0900 (KST)
Received: from ws2030077324.sa.corp.samsungelectronics.net (unknown
	[107.99.237.91]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240108092015epsmtip298468bd97585da0b265c6f4d1e4d2783~oVLnOrt3l2167221672epsmtip2B;
	Mon,  8 Jan 2024 09:20:15 +0000 (GMT)
From: Sandeep C S <sandeep.cs@samsung.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<benjamin.tissoires@redhat.com>
Cc: gaudium.lee@samsung.com, ih0923.kim@samsung.com,
	suhyun_.kim@samsung.com, jitender.s21@samsung.com, junwan.cho@samsung.com,
	sandeep.cs@samsung.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [HID Patchsets for Samsung driver v2 5/6] HID: Samsung : Add
 Samsung wireless action mouse support.
Date: Mon,  8 Jan 2024 14:49:15 +0530
Message-Id: <20240108091917.1552013-6-sandeep.cs@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108091917.1552013-1-sandeep.cs@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdlhTQzdw3+xUgzOnbCyuT9nManF7gafF
	1iVzWS1uHW9ltHj5YAO7xebJj1gsbn76xmpxedccNov22c8YLR6t2MTkwOWxaVUnm8f7fVfZ
	PPq2rGL0+LxJLoAlKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
	xSdA1y0zB+geJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5e
	aomVoYGBkSlQYUJ2xv4LK1kKVolXvJzo0MDYKNLFyMkhIWAi8f/ONeYuRi4OIYHdjBLzl59n
	g3A+MUq8atvECOdsXfCCFablzNxGqMRORokjc19CtXQySTy6+Bysik1AS6LvyHcmEFtEIELi
	3QKQUZwczALXGSUePAwEsYUF8iQuL+hnA7FZBFQltl1+wwJi8wrYSrRtbWeB2CYvsf/gWWYQ
	m1PATmLbk41MEDWCEidnPmGBmCkv0bx1NjNE/Vt2iaOv9LoYOYBsF4kFW5ggwsISr45vYYew
	pSRe9rexg9wsIdDNKLH09jEoZwajRMvOq1CD7CV+vp7ABjKIWUBTYv0ufYhdfBK9v58wQczn
	lehoE4KoVpF42rWbFWb+9xMbofZ6SHzfdJwdEj4TGSV2rnrGPoFRfhaSF2YheWEWwrYFjMyr
	GCVTC4pz01OLTQuM8lLL4RGbnJ+7iRGcLLW8djA+fPBB7xAjEwfjIUYJDmYlEV7JGbNThXhT
	EiurUovy44tKc1KLDzGaAsN4IrOUaHI+MF3nlcQbmlgamJiZmZlYGpsZKonzvm6dmyIkkJ5Y
	kpqdmlqQWgTTx8TBKdXAJPJ5T6/Ci4+v03M6fls8THyaEnUqUq7cvYoz+5a9v8zlG2FmAc5H
	p1k+m90nsqZ8mudlc+myC9+THrAu5etcGD/vZV3N6qvdWVPtBBdq7C4+EiXGcXBz9t/o41MX
	aD+ZzMrG9stp7rG1Gqs1WLUmCW7nFmy5F3m4eNmZYhXzHVkHo0SDz6d33zKcc+D8rPQ1vw4e
	qpEI0urnPfg0qEvX6kPulobnlbu/SWvPz67apdp6Q90zoWbPwztPnxYvuss/4/XNJ29niBRd
	1vBau/fwzYd9Grovk7n3Jk46eaq5bu4J8TYRHke1S+p1AQe/fXS/+kBV4cS53LjZgnOFou5f
	0fsgHnpGq5+N8Z3Vm17ZVUosxRmJhlrMRcWJAAoJOXkfBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWy7bCSvG7gvtmpBpuXKVlcn7KZ1eL2Ak+L
	rUvmslrcOt7KaPHywQZ2i82TH7FY3Pz0jdXi8q45bBbts58xWjxasYnJgctj06pONo/3+66y
	efRtWcXo8XmTXABLFJdNSmpOZllqkb5dAlfG/gsrWQpWiVe8nOjQwNgo0sXIySEhYCJxZm4j
	YxcjF4eQwHZGiW9rr7BAJKQkVl2/xwhhC0us/PecHaKonUni6KnTYAk2AS2JviPfmUBsEYEI
	iWn/1oJNYha4zyixdf9VNpCEsECOxLUJ15lBbBYBVYltl9+AbeAVsJVo29oOtU1eYv/Bs2A1
	nAJ2EtuebAQbKgRU82LKN3aIekGJkzOfgNUzA9U3b53NPIFRYBaS1CwkqQWMTKsYRVMLinPT
	c5MLDPWKE3OLS/PS9ZLzczcxggNcK2gH47L1f/UOMTJxMB5ilOBgVhLhlZwxO1WINyWxsiq1
	KD++qDQntfgQozQHi5I4r3JOZ4qQQHpiSWp2ampBahFMlomDU6qByZzt/WEn355YWYZzcYc3
	vTXskfm/VDO/6nifWLJP3uGvO59dWHhWpO3l+qWrhD+VHVk9T5KF43/ovY2zE763W06z0+yb
	4166JHTx57kNv9ZuZL12/MU9TbYK3vPt7C6Rk6detVmoVchV9FONjTl7UceGqsevTyrf2ZwR
	dPWT6CldwSStpJDaZTZLVJ5xSJsX8P8/fW+KF7PfvQVr1B4pVHLwcX+8wiWn9XlilGDh1PTq
	ZTw3TRY9V87Jl1rRZsD74V3WwQPP3sTrrRN/mBlQvXqxo1rCzBsRAWc2Goeu9z9xKUhtXc+f
	pqv2d9MuSBbGc9lWGOzc/bNanePtuger/OSdjigLfbbeF2ef3FOWr8RSnJFoqMVcVJwIAPa6
	amTfAgAA
X-CMS-MailID: 20240108092017epcas5p24c1c263149a0a8bf3204c86925e3cfd9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240108092017epcas5p24c1c263149a0a8bf3204c86925e3cfd9
References: <20240108091917.1552013-1-sandeep.cs@samsung.com>
	<CGME20240108092017epcas5p24c1c263149a0a8bf3204c86925e3cfd9@epcas5p2.samsung.com>

Add support for samsung wireless action mouse with input mapping events.

Device a004 (Samsung wireless action mouse)

Signed-off-by: Sandeep C S <sandeep.cs@samsung.com>
Signed-off-by: Junwan Cho <junwan.cho@samsung.com>
Signed-off-by: Jitender Sajwan <jitender.s21@samsung.com>
---
 drivers/hid/hid-ids.h     |  1 +
 drivers/hid/hid-samsung.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 2851dc25f949..b1208d04712c 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1144,6 +1144,7 @@
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE	0x0600
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD	0x7021
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD	0xa000
+#define USB_DEVICE_ID_SAMSUNG_WIRELESS_ACTIONMOUSE	0xa004
 
 #define USB_VENDOR_ID_SEMICO			0x1a2c
 #define USB_DEVICE_ID_SEMICO_USB_KEYKOARD	0x0023
diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
index 6b08acd3c4fd..36ab9540e064 100644
--- a/drivers/hid/hid-samsung.c
+++ b/drivers/hid/hid-samsung.c
@@ -339,6 +339,29 @@ static int samsung_gamepad_input_mapping(struct hid_device *hdev,
 	return 1;
 }
 
+static int samsung_actionmouse_input_mapping(struct hid_device *hdev,
+	struct hid_input *hi, struct hid_field *field, struct hid_usage *usage,
+	unsigned long **bit, int *max)
+{
+
+	dbg_hid("samsung wireless actionmouse input mapping event [0x%x], [0x%x], %ld, %ld, [0x%x]\n",
+			usage->hid, usage->hid & HID_USAGE, hi->input->evbit[0], hi->input->absbit[0],
+			usage->hid & HID_USAGE_PAGE);
+
+	if (((usage->hid & HID_USAGE_PAGE) != HID_UP_CONSUMER) && ((usage->hid & HID_USAGE_PAGE) != HID_UP_BUTTON))
+		return 0;
+
+	switch (usage->hid & HID_USAGE) {
+	case 0x301:
+		samsung_kbd_mouse_map_key_clear(254);
+		break;
+	default:
+		return 0;
+	}
+
+	return 1;
+}
+
 static __u8 *samsung_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	unsigned int *rsize)
 {
@@ -362,6 +385,9 @@ static int samsung_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD)
 		ret = samsung_gamepad_input_mapping(hdev,
 			hi, field, usage, bit, max);
+	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_ACTIONMOUSE)
+		ret = samsung_actionmouse_input_mapping(hdev,
+			hi, field, usage, bit, max);
 
 	return ret;
 }
@@ -406,6 +432,7 @@ static const struct hid_device_id samsung_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_ACTIONMOUSE) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, samsung_devices);
-- 
2.34.1


