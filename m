Return-Path: <linux-kernel+bounces-37950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE3883B8B5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A749D1F24E4E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07B211CBD;
	Thu, 25 Jan 2024 04:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aiDk5aOg"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1EA1171F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706157454; cv=none; b=Ks+kfA7HeXzSQT32XcKhU3wutphBX81cFoqKGaPyjJ9UQEh2Zs2EBLn1ec2T/KAcoD+4i8QwDOd97idVLM+PRuwbGb9S6qPk0d021os3DvY79zfKBRQWAqvoQIdJ+iRRy0lf56SiWnL1QfAFNH6FG6ZIqBQwOBnszpMhDj9yQVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706157454; c=relaxed/simple;
	bh=vfJqlUnGoBgdkhHRyH1JP+58dA+bo5YwqAg+NvUciqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=CMlDpFiPCRyqqn1fD3sCw4XAAx7dz97tCq44Vun36PjE51gAh1sYyz/vyO5HL6mCN37IXFMtrS0dgiwU3eXvSL/bIRVG0aD2/5rVYWR8HOIjfOdAJryExTV93+GAikkatuNFW7G10RpdV2FMYZF2hhBvg8HWs0B/bqO3uIsgF1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aiDk5aOg; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240125043730epoutp01b48f601c208aeb6004da396e23b74d03~tfSlcSyp50211902119epoutp01o
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:37:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240125043730epoutp01b48f601c208aeb6004da396e23b74d03~tfSlcSyp50211902119epoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706157450;
	bh=XjsBmEzoUTbjfbs94yMRyqbJjQFBMXVRoxTwZgBHNCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aiDk5aOgy7w90l9nyrixwnZN/585mSK+lfvvXFrWp4yLD2ZyTnds/xgE+jhyYZ16X
	 /B7k5FqQx5hVgLm6J/ExrF+5CcTHtLdDwVCz6WPSTq1YoOYjV98t+LXJb5G3Jf0mrd
	 BgDEWULUQgghWK/tn4/wIOnbI4FZ085hRq3cBtDI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240125043729epcas5p3ba3e22f5388f90001d70313b92d282c8~tfSk7wsvW0575905759epcas5p3G;
	Thu, 25 Jan 2024 04:37:29 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TL7N81CBrz4x9Q9; Thu, 25 Jan
	2024 04:37:28 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D4.FC.10009.785E1B56; Thu, 25 Jan 2024 13:37:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240125043727epcas5p2cb925e28e453a870eaa0efa248942f0f~tfSi8QLWZ0584505845epcas5p2U;
	Thu, 25 Jan 2024 04:37:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240125043727epsmtrp1ea78986663dd92f250f5040926d376d8~tfSi6y3xS1638716387epsmtrp1C;
	Thu, 25 Jan 2024 04:37:27 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-44-65b1e5872c5c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	84.E4.08755.785E1B56; Thu, 25 Jan 2024 13:37:27 +0900 (KST)
Received: from ws2030077324.sa.corp.samsungelectronics.net (unknown
	[107.99.237.91]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240125043726epsmtip2d4a8c184f671de480beedb62033e614c~tfShdU15c1113111131epsmtip2H;
	Thu, 25 Jan 2024 04:37:26 +0000 (GMT)
From: Sandeep C S <sandeep.cs@samsung.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<benjamin.tissoires@redhat.com>
Cc: gaudium.lee@samsung.com, ih0923.kim@samsung.com,
	suhyun_.kim@samsung.com, jitender.s21@samsung.com, junwan.cho@samsung.com,
	sandeep.cs@samsung.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [HID Patchsets for Samsung driver v4 5/6] HID: Samsung : Add
 Samsung wireless action mouse support.
Date: Thu, 25 Jan 2024 10:06:28 +0530
Message-Id: <20240125043630.4031634-6-sandeep.cs@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125043630.4031634-1-sandeep.cs@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTQ7fj6cZUg30tTBbXp2xmtbi9wNNi
	65K5rBa3jrcyWrx8sIHdYvPkRywWNz99Y7W4vGsOm0X77GeMFo9WbGJy4PLYtKqTzeP9vqts
	Hn1bVjF6fN4kF8ASlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk
	4hOg65aZA3SPkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafApECvODG3uDQvXS8v
	tcTK0MDAyBSoMCE7Y83K2awFq8QrJn+ez9zA2CjSxcjJISFgInGsaSt7FyMXh5DAbkaJrTcf
	MEM4nxgl2t/eZYJwvjFKfJj8ghWm5c+eaywQib2MEneeXWCFcDqZJFb8fsICUsUmoCXRd+Q7
	E4gtIhAh8W7BJkYQm1ngOqPEg4eBILawQJ7E8pNXweIsAqoS1xpusoPYvAK2ElOu/meG2CYv
	sf/gWTCbU8BOom/pGyaIGkGJkzMhdjED1TRvnQ12t4TAT3aJV2uuMEE0u0i8Ov6bBcIWBrK3
	sEPYUhIv+9vYIRq6GSWW3j4G5cxglGjZeRVqtb3Ez9cT2LoYOYBWaEqs36UPsY1Povf3EyaQ
	sIQAr0RHmxBEtYrE067drDDzv5/YCHWDh8Sff0/BbCGBiYwS/TvDJjDKz0LywywkP8xCWLaA
	kXkVo2RqQXFuemqxaYFRXmo5PGqT83M3MYITppbXDsaHDz7oHWJk4mA8xCjBwawkwmtiujFV
	iDclsbIqtSg/vqg0J7X4EKMpMJAnMkuJJucDU3ZeSbyhiaWBiZmZmYmlsZmhkjjv69a5KUIC
	6YklqdmpqQWpRTB9TBycUg1M6rof8l8sWLfgjkhv0hS5E+nzNmYezn/x6dky4YXBEzdEhJdV
	ujldkFk9TW/z6+82qW4Lb82OOXo5gplvYZBriumy48UT2Ztmt6WsffhUelk26/q7ZaIJi6vW
	3A3JT2I/+zEteYcax6HJdV18fuk3VZcmGZZ9/vg68rzI53LfkudbY+8uUGT+sN7zjAxH8yKh
	h7Py3X6ZC3ZZ/n6kfaFw1iv+qCnire1nUu352HdFyMWxyR/6OONA79Wafwuq3v6d+ePU+rkX
	bkh2rrWMnedyQr/yJmPJSwXrfav+cFw0nnXBSLokqmyBgsDpQ/8kjz6VrdNMu5y9v/dhaNJN
	Aftz79S6Jv8/9iXeZ9HvYPU1l5RYijMSDbWYi4oTAc+Qh6MhBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSvG77042pBiuuqltcn7KZ1eL2Ak+L
	rUvmslrcOt7KaPHywQZ2i82TH7FY3Pz0jdXi8q45bBbts58xWjxasYnJgctj06pONo/3+66y
	efRtWcXo8XmTXABLFJdNSmpOZllqkb5dAlfGmpWzWQtWiVdM/jyfuYGxUaSLkZNDQsBE4s+e
	ayxdjFwcQgK7GSUmP/3NDJGQklh1/R4jhC0ssfLfc3aIonYmiQlHVoIl2AS0JPqOfGcCsUUE
	IiSm/VvLCFLELHCfUWLr/qtsIAlhgRyJjkv3WUFsFgFViWsNN9lBbF4BW4kpV/9DbZOX2H/w
	LJjNKWAn0bf0DdhQIaCa+29ms0LUC0qcnPmEBcRmBqpv3jqbeQKjwCwkqVlIUgsYmVYxSqYW
	FOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgSHupbmDsbtqz7oHWJk4mA8xCjBwawkwmtiujFV
	iDclsbIqtSg/vqg0J7X4EKM0B4uSOK/4i94UIYH0xJLU7NTUgtQimCwTB6dUA1NOYHeI+rqk
	oBlVv+Q/fJAMnCq0glHrTMU+/+tP7z649iPoj1VH/yHTdX0lG4oMREyuXdJ4vp5nda60mFXH
	6cDTDs2KxcK/fO+HvtzoYvpq+1kN5bYZQhfaXrxUTp/iJ/us8/FP14md7w8y3v43/ZBcgbVw
	Mtu5jbONdodMmaPsc+rN/G5O3aT96vzahwpS6x5+M/ialdhznXeXjsW9C89Mbz6Ll5rZ0dhw
	9Kf8nmd9p13kq+5MncKubxEspPbW2CNK8lqC/InVH61XJnxxshczKD1S+8HcKz/793emuOgt
	fuo2Lec2+26bn3G2lcvNx/iEwMXpB6uP7/46o+X4s+u3qvJjAo2z3+S7ZX79cVGJpTgj0VCL
	uag4EQBjxp3u5AIAAA==
X-CMS-MailID: 20240125043727epcas5p2cb925e28e453a870eaa0efa248942f0f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240125043727epcas5p2cb925e28e453a870eaa0efa248942f0f
References: <20240125043630.4031634-1-sandeep.cs@samsung.com>
	<CGME20240125043727epcas5p2cb925e28e453a870eaa0efa248942f0f@epcas5p2.samsung.com>

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
index 8a106fd6b339..06bf718961da 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1148,6 +1148,7 @@
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE	0x0600
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD	0x7021
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD	0xa000
+#define USB_DEVICE_ID_SAMSUNG_WIRELESS_ACTIONMOUSE	0xa004
 
 #define USB_VENDOR_ID_SEMICO			0x1a2c
 #define USB_DEVICE_ID_SEMICO_USB_KEYKOARD	0x0023
diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
index 217b30b71bb8..0de23a70dddb 100644
--- a/drivers/hid/hid-samsung.c
+++ b/drivers/hid/hid-samsung.c
@@ -323,6 +323,29 @@ static int samsung_gamepad_input_mapping(struct hid_device *hdev,
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
@@ -346,6 +369,9 @@ static int samsung_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD)
 		ret = samsung_gamepad_input_mapping(hdev,
 			hi, field, usage, bit, max);
+	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_ACTIONMOUSE)
+		ret = samsung_actionmouse_input_mapping(hdev,
+			hi, field, usage, bit, max);
 
 	return ret;
 }
@@ -390,6 +416,7 @@ static const struct hid_device_id samsung_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_ACTIONMOUSE) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, samsung_devices);
-- 
2.34.1


