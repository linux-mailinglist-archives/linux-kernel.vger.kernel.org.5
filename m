Return-Path: <linux-kernel+bounces-37949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1194983B8B3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28C31F24DBB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3220D111B9;
	Thu, 25 Jan 2024 04:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Al2c6Ffo"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E55111A2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706157449; cv=none; b=Yan8hBtzzgVi+ILyn3mg2QwnOIfdJXI7WW2sUDVsumkhALmP8r7qDbUle92IHPSb5e9KQD0vUvVjTW0zS9BhWVq6K8WHwQap1sbIfOrEXBfQT8uGeGjtKm3f0FtSG2WWKb7CPVt1jXeMt75aCDN0s7h9hJwEu028Mt/2cUVjaAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706157449; c=relaxed/simple;
	bh=htuLjyh7MD+2wiik6bveKuTHw4ikcwrKyoVr5y6JoGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=XMuANi4w0I95iCAPSg0uZe5lUIxFUTjgMRRBSL1Z0I3W7b8D7cpyPb/PDOjBr5S3XdDXNe/pqH1LAwAubKAW6iqkAgYToLJtuUSdpDq400HwGoNB6tfPz38Wq1/ZpxaC5rCv9A24oqTNucs7cR5yYEtVIS2LDXxIH1uFlAbk3XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Al2c6Ffo; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240125043724epoutp038fd5debd0fe76f8e9daafa6d9127a7eb~tfSfoMh5K0190401904epoutp03X
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:37:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240125043724epoutp038fd5debd0fe76f8e9daafa6d9127a7eb~tfSfoMh5K0190401904epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706157444;
	bh=wqIAJgHOb3PONZDIIwi4erzvBZlBhVaiZg3QWPzJs4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Al2c6Ffotznj7MwZejSPuU4oUEdiqwHpC2zICGJlubBP/+LbzJLJ7IGk/5FwwDKhc
	 9STEjYbfd0CH1YkvzUN0WxOCLrBylKk8sG9A/IgO9CgWsC6dPxviK/Nh4VgCKGlbq9
	 gxkeL+XtlIIiApdsSxbIm4X8hbZVpTbsGFgVeD+Y=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240125043723epcas5p140bd0e63e9326f03eb25fcbac351cc78~tfSfTXtUw2411224112epcas5p1u;
	Thu, 25 Jan 2024 04:37:23 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4TL7N218F8z4x9QJ; Thu, 25 Jan
	2024 04:37:22 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2F.EC.10009.085E1B56; Thu, 25 Jan 2024 13:37:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240125043720epcas5p26d753bd642085849574b82af5c60ecb1~tfScIMvjY0578005780epcas5p2J;
	Thu, 25 Jan 2024 04:37:20 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240125043720epsmtrp2c6a37642e8aded006805999e30d2ee29~tfScHdm9y1848518485epsmtrp2T;
	Thu, 25 Jan 2024 04:37:20 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-2f-65b1e5808fb1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FD.4A.07368.085E1B56; Thu, 25 Jan 2024 13:37:20 +0900 (KST)
Received: from ws2030077324.sa.corp.samsungelectronics.net (unknown
	[107.99.237.91]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240125043718epsmtip237e0a4e89dcada12e41922fb6853f06c~tfSaoZOOu1132311323epsmtip2X;
	Thu, 25 Jan 2024 04:37:18 +0000 (GMT)
From: Sandeep C S <sandeep.cs@samsung.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<benjamin.tissoires@redhat.com>
Cc: gaudium.lee@samsung.com, ih0923.kim@samsung.com,
	suhyun_.kim@samsung.com, jitender.s21@samsung.com, junwan.cho@samsung.com,
	sandeep.cs@samsung.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [HID Patchsets for Samsung driver v4 4/6] HID: Samsung : Add
 Samsung wireless gamepad support.
Date: Thu, 25 Jan 2024 10:06:27 +0530
Message-Id: <20240125043630.4031634-5-sandeep.cs@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125043630.4031634-1-sandeep.cs@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTQ7fx6cZUg80vmSyuT9nManF7gafF
	1iVzWS1uHW9ltHj5YAO7xebJj1gsbn76xmpxedccNov22c8YLR6t2MTkwOWxaVUnm8f7fVfZ
	PPq2rGL0+LxJLoAlKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
	xSdA1y0zB+geJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5e
	aomVoYGBkSlQYUJ2RlPrJraCE8oVX7p72BoYj8t2MXJySAiYSGyd/Z+5i5GLQ0hgN6PErBeP
	mSCcT4wSszs6WCGcb4wSv/5eZYRp2Xf6PjtEYi+jRP+zLSwQTieTxKZLF5lBqtgEtCT6jnxn
	ArFFBCIk3i3YBNbNLHCdUeLBw0AQW1ggU+LL7BOsIDaLgKrErnl/WEBsXgFbiZ8r/zNBbJOX
	2H/wLNhMTgE7ib6lb5ggagQlTs58wgIxU16ieetssCckBH6yS/y99wdoGQeQ4yIx7agbxBxh
	iVfHt7BD2FISn9/tZYOo72aUWHr7GDuEM4NRomXnVWaIKnuJn68nsIEMYhbQlFi/Sx9iGZ9E
	7+8nTBDzeSU62oQgqlUknnbtZoWZ//3ERqj7PSSO/H4EDdOJjBJrbixinsAoPwvJD7OQ/DAL
	YdsCRuZVjJKpBcW56anFpgVGeanl8KhNzs/dxAhOmFpeOxgfPvigd4iRiYPxEKMEB7OSCK+J
	6cZUId6UxMqq1KL8+KLSnNTiQ4ymwECeyCwlmpwPTNl5JfGGJpYGJmZmZiaWxmaGSuK8r1vn
	pggJpCeWpGanphakFsH0MXFwSjUwHZiy83C1w8pbB9SXbLlvc3D+h/z49pZ5rSnzmVptt53u
	fS/0OPVX/guZTBEBC+77jw22qypy+bzfP8ON+eK0jTPS+O8kPvyV8vvSH4bfs5fM69D5KPPh
	+BWz0Mv/dvjdVK3o2/cikT+l7I3e9iPzd5xfnvOxu+LHRZVp3orfKq4GxxjXLmx/deRrylbJ
	PZ8KJ16wbG5xCfXc8fDqym17NmxYp7H9aU10yMZNTMlzPm5iu7v+2rpb/VuFYnbv7D38yJeh
	8I+Iz8mucJlLMSz9VlPfHrueYO6kVPucLU5tS5v0Rr15nUtyTE7IrG689LP+V3nFuUuxZveF
	N0S8cTu1QnmB860G+z1/tH9Pu343MsZUiaU4I9FQi7moOBEAlUUiGCEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSvG7D042pBjtnCVtcn7KZ1eL2Ak+L
	rUvmslrcOt7KaPHywQZ2i82TH7FY3Pz0jdXi8q45bBbts58xWjxasYnJgctj06pONo/3+66y
	efRtWcXo8XmTXABLFJdNSmpOZllqkb5dAldGU+smtoITyhVfunvYGhiPy3YxcnJICJhI7Dt9
	n72LkYtDSGA3o8TTD6/YIBJSEquu32OEsIUlVv57zg5iCwm0M0lsPQLWzCagJdF35DsTiC0i
	ECEx7d9aRpBBzAL3GSW27r8KNkhYIF1i+4RbLCA2i4CqxK55f8BsXgFbiZ8r/zNBLJCX2H/w
	LDOIzSlgJ9G39A0TxDJbiftvZrNC1AtKnJz5BKyXGai+eets5gmMArOQpGYhSS1gZFrFKJla
	UJybnptsWGCYl1quV5yYW1yal66XnJ+7iREc6FoaOxjvzf+nd4iRiYPxEKMEB7OSCK+J6cZU
	Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryGM2anCAmkJ5akZqemFqQWwWSZODilGpjWtV+0nCYo
	eTm1OF3fO+xAkdBGHp+rTKWTbx4xqRLo3Nl56ImSpwUvy5+zrOev7togHuCoskTiMnNoclJ2
	qs6t+sUxHo98eQIlZVknzXOJbDs1/97JN8zbOa/q3hWOsVp6cvra/yI/1+xZbS/NvOO8EEtX
	bqv/m8TvSgz/t5UWs1w0cLp61DDi+9W+RFeVCNfdeyVfX10iEBbNuy3jbo+368z9h0MfLPt0
	oXfPR7WsrPQtbw6wrFjuxVB6sH9Dd9yPqrRsD4vLq8+zNDrsWjnXsu28lqLjvfi1daHXjp/Q
	nVYvkb/y3YlaF3fVmWJaZYti0xx/1uYybs11mVuT9OrybCvvG2F9PRvmrNo8678SS3FGoqEW
	c1FxIgDZG0fi4wIAAA==
X-CMS-MailID: 20240125043720epcas5p26d753bd642085849574b82af5c60ecb1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240125043720epcas5p26d753bd642085849574b82af5c60ecb1
References: <20240125043630.4031634-1-sandeep.cs@samsung.com>
	<CGME20240125043720epcas5p26d753bd642085849574b82af5c60ecb1@epcas5p2.samsung.com>

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
index d7572ab5ea6c..8a106fd6b339 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1147,6 +1147,7 @@
 #define USB_DEVICE_ID_SAMSUNG_IR_REMOTE	0x0001
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE	0x0600
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD	0x7021
+#define USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD	0xa000
 
 #define USB_VENDOR_ID_SEMICO			0x1a2c
 #define USB_DEVICE_ID_SEMICO_USB_KEYKOARD	0x0023
diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
index aa8e7805be76..217b30b71bb8 100644
--- a/drivers/hid/hid-samsung.c
+++ b/drivers/hid/hid-samsung.c
@@ -232,6 +232,97 @@ static int samsung_kbd_input_mapping(struct hid_device *hdev,
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
@@ -252,6 +343,9 @@ static int samsung_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD)
 		ret = samsung_kbd_input_mapping(hdev,
 			hi, field, usage, bit, max);
+	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD)
+		ret = samsung_gamepad_input_mapping(hdev,
+			hi, field, usage, bit, max);
 
 	return ret;
 }
@@ -295,6 +389,7 @@ static const struct hid_device_id samsung_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, samsung_devices);
-- 
2.34.1


