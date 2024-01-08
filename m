Return-Path: <linux-kernel+bounces-19264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FCC826A8B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0453B20D49
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115A613AF8;
	Mon,  8 Jan 2024 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Drt3uTDS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796D511C87
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240108091957epoutp026bbff054e48d4c8ecc13e71872a52bbc~oVLWQ5bvY0283902839epoutp02G
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:19:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240108091957epoutp026bbff054e48d4c8ecc13e71872a52bbc~oVLWQ5bvY0283902839epoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704705597;
	bh=dzkbZ/aJDTM0eaofC0HD6c34S5tpUkSxQ0jX4ZPNcl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Drt3uTDSrSWgm0PXthwFHhWb2a3HdEpPCoZnyNqms3ldN34VI+Fbzf4clMVYreEBe
	 vmZl1RLSP2HyHSI5eFbuPcXBlwWaV1FxLwIS+6tLIsk4OsuMeLiZ47ejYHNff+nKAu
	 STiiVh3dJVUPTsnyz86mYN9LQLC1NNOzIkXe8Qnk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240108091957epcas5p377edd7dd749865ee39043cb46804e89b~oVLV29tfH0530905309epcas5p3A;
	Mon,  8 Jan 2024 09:19:57 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4T7pRv2KY2z4x9Q9; Mon,  8 Jan
	2024 09:19:55 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A0.22.10009.B3EBB956; Mon,  8 Jan 2024 18:19:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240108091954epcas5p39f9ca04b57adf01a7c964593b7be87d2~oVLTprznt0530905309epcas5p36;
	Mon,  8 Jan 2024 09:19:54 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240108091954epsmtrp22c13cd3c054fe334f3ca96fbdd4bbfb8~oVLTo9VEM1969219692epsmtrp2-;
	Mon,  8 Jan 2024 09:19:54 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-ad-659bbe3b11d0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	87.A0.18939.A3EBB956; Mon,  8 Jan 2024 18:19:54 +0900 (KST)
Received: from ws2030077324.sa.corp.samsungelectronics.net (unknown
	[107.99.237.91]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240108091953epsmtip24c355d58e1a701143ce2c650e39232b4~oVLSN3PR02117321173epsmtip2i;
	Mon,  8 Jan 2024 09:19:53 +0000 (GMT)
From: Sandeep C S <sandeep.cs@samsung.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<benjamin.tissoires@redhat.com>
Cc: gaudium.lee@samsung.com, ih0923.kim@samsung.com,
	suhyun_.kim@samsung.com, jitender.s21@samsung.com, junwan.cho@samsung.com,
	sandeep.cs@samsung.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [HID Patchsets for Samsung driver v2 1/6] HID Samsung : Broaden
 device compatibility in samsung driver.
Date: Mon,  8 Jan 2024 14:49:11 +0530
Message-Id: <20240108091917.1552013-2-sandeep.cs@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108091917.1552013-1-sandeep.cs@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdlhTQ9d63+xUg7U7BSyuT9nManF7gafF
	1iVzWS1uHW9ltHj5YAO7xebJj1gsbn76xmpxedccNov22c8YLR6t2MTkwOWxaVUnm8f7fVfZ
	PPq2rGL0+LxJLoAlKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
	xSdA1y0zB+geJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5e
	aomVoYGBkSlQYUJ2xrE1S1kKtglULP97nqWB8QRvFyMnh4SAicSX8+dZuhi5OIQEdjNK/J+z
	nhnC+cQosWLDc3aQKjDn0gNBmI5v814yQRTtZJQ4O2UJVHsnk8TstvnMIFVsAloSfUe+M4HY
	IgIREu8WbGIEsZkFrjNKPHgYCGILCxRJ7Hz9iw3EZhFQldj2axuYzStgK7F16iVmiG3yEvsP
	ngWzOQXsJLY92cgEUSMocXLmExaImfISzVtng50tIfCRXeJt91agQRxAjotE4yE+iDnCEq+O
	b2GHsKUkPr/bywZR380osfT2MXYIZwajRMvOq1Cb7SV+vp4ANohZQFNi/S59iGV8Er2/nzBB
	zOeV6GgTgqhWkXjatZsVZv73ExB3Sgh4SGyaMR8aihMZJe7dMp/AKD8LyQuzkLwwC2HZAkbm
	VYySqQXFuempxaYFRnmp5fCITc7P3cQITpZaXjsYHz74oHeIkYmD8RCjBAezkgiv5IzZqUK8
	KYmVValF+fFFpTmpxYcYTYFhPJFZSjQ5H5iu80riDU0sDUzMzMxMLI3NDJXEeV+3zk0REkhP
	LEnNTk0tSC2C6WPi4JRqYIpsO11SseRloIT9Gq5Lyekvd1zQWc614OSeF3W3b1zUOnDi3/Qn
	6zOkTfIiHghNzV4X32dxujH/85NP/QJvhUsFYlhj12QUVzNXeE602/i9YeWEun0LJtvukV9/
	2eKizu2zLoHPDj2J4jPt6D9jWZtVrr2eRWdHmoRNFsedSDWln2eW2yWdWBsgOUOA5xFvOJtq
	WQr/4c+zPgaLCRX4/o489dm5d2bVrzvb8/nvxV6v2cSyYfYKifVL5jXbGC4UXczUNvmlMk+u
	l9i12N7NS7Y/3/mr1lB+urCp5ER2Di+TI+4zNylZ2HAa7Z4ZwS0e5ZR08uHaxaaK3uFn6qfv
	fCO+YM3OLy8eT67I41/64IkSS3FGoqEWc1FxIgDvtNM+HwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWy7bCSvK7VvtmpBgdPm1pcn7KZ1eL2Ak+L
	rUvmslrcOt7KaPHywQZ2i82TH7FY3Pz0jdXi8q45bBbts58xWjxasYnJgctj06pONo/3+66y
	efRtWcXo8XmTXABLFJdNSmpOZllqkb5dAlfGsTVLWQq2CVQs/3uepYHxBG8XIyeHhICJxLd5
	L5m6GLk4hAS2M0pc29jACpGQklh1/R4jhC0ssfLfc3aIonYmiWdbGphBEmwCWhJ9R74zgdgi
	AhES0/6tZQQpYha4zyixdf9VNpCEsECBxOX5O8BsFgFViW2/toHZvAK2ElunXmKG2CAvsf/g
	WTCbU8BOYtuTjWBDhYBqXkz5xg5RLyhxcuYTFhCbGai+eets5gmMArOQpGYhSS1gZFrFKJpa
	UJybnptcYKhXnJhbXJqXrpecn7uJERziWkE7GJet/6t3iJGJg/EQowQHs5IIr+SM2alCvCmJ
	lVWpRfnxRaU5qcWHGKU5WJTEeZVzOlOEBNITS1KzU1MLUotgskwcnFINTNutQ+9kP7sq6ZeY
	Y7Us3aJ1C3ep9BSzbZ07WTXC0pq9DJ2KS1x+LLzMeKercEO6pp9w7Dlv9n2PLjRsMOBhO/C5
	rNkv/hibTe8VgYZNh08wP45JK7V6dnwuw5ZT+8+ctt+m4Ta7eAnvvXyu/xvqLNOlfDcvKy/z
	W/i5RUqW8XpJ/O2WiXlKj7iv7RE8us6/q/mq1oY5+TfcZ/Cy2nM1ME4IMksSSpku1cd2ICir
	lGHSofU1j2Tan5rnai6dt+cX26Lcizeq7F3mzmtLOh+61I5ZbItV/6znXde+PT/x1z9k+eH3
	GfMr3y8++17EQkuF38bkZveHpz/an2n2XN5XWvbDJGztc/GURz9sd0wzU2Ipzkg01GIuKk4E
	ADcM4nngAgAA
X-CMS-MailID: 20240108091954epcas5p39f9ca04b57adf01a7c964593b7be87d2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240108091954epcas5p39f9ca04b57adf01a7c964593b7be87d2
References: <20240108091917.1552013-1-sandeep.cs@samsung.com>
	<CGME20240108091954epcas5p39f9ca04b57adf01a7c964593b7be87d2@epcas5p3.samsung.com>

The USB validation check has been moved wherever its required.

Earlier Samsung driver only handles USB HID devices and returns an error if it encounters a Bluetooth type of HID device.
This changes improves driver compatibility and extends its support for a wide range of devices.

Signed-off-by: Sandeep C S <sandeep.cs@samsung.com>
Signed-off-by: Junwan Cho <junwan.cho@samsung.com>
Signed-off-by: Jitender Sajwan <jitender.s21@samsung.com>
---
 drivers/hid/hid-samsung.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
index cf5992e97094..885657531607 100644
--- a/drivers/hid/hid-samsung.c
+++ b/drivers/hid/hid-samsung.c
@@ -128,7 +128,7 @@ static int samsung_kbd_mouse_input_mapping(struct hid_device *hdev,
 static __u8 *samsung_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	unsigned int *rsize)
 {
-	if (USB_DEVICE_ID_SAMSUNG_IR_REMOTE == hdev->product)
+	if (USB_DEVICE_ID_SAMSUNG_IR_REMOTE == hdev->product  && hid_is_usb(hdev))
 		rdesc = samsung_irda_report_fixup(hdev, rdesc, rsize);
 	return rdesc;
 }
@@ -139,7 +139,7 @@ static int samsung_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 {
 	int ret = 0;
 
-	if (USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE == hdev->product)
+	if (USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE == hdev->product  && hid_is_usb(hdev))
 		ret = samsung_kbd_mouse_input_mapping(hdev,
 			hi, field, usage, bit, max);
 
@@ -152,9 +152,6 @@ static int samsung_probe(struct hid_device *hdev,
 	int ret;
 	unsigned int cmask = HID_CONNECT_DEFAULT;
 
-	if (!hid_is_usb(hdev))
-		return -EINVAL;
-
 	ret = hid_parse(hdev);
 	if (ret) {
 		hid_err(hdev, "parse failed\n");
@@ -162,6 +159,10 @@ static int samsung_probe(struct hid_device *hdev,
 	}
 
 	if (USB_DEVICE_ID_SAMSUNG_IR_REMOTE == hdev->product) {
+		if (!hid_is_usb(hdev)) {
+			ret = -EINVAL;
+			goto err_free;
+		}
 		if (hdev->rsize == 184) {
 			/* disable hidinput, force hiddev */
 			cmask = (cmask & ~HID_CONNECT_HIDINPUT) |
-- 
2.34.1


