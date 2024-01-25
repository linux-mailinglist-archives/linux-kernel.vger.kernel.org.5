Return-Path: <linux-kernel+bounces-37946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A0783B8AD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC22D1C22D3F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CA8CA7C;
	Thu, 25 Jan 2024 04:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JuNSNrst"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380D98832
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706157422; cv=none; b=Cmfhgha1KUNdBqx1M4E0LOm7fRZSpP5o/uXgbu2mMeKsGBn5Yuluh/S6KLvxK12VSOGveSeHFbXTIVDT4Q65w52mT6/B1ym2X/MPRAjugK1UsN1eTKeBGKF1/SLnzw93lsdm/oPbGhMxAsM1uAtutQJVvPrA74MdXTVUzeuPXg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706157422; c=relaxed/simple;
	bh=xfsQLJ/2vU+01sZsEX/6QiGDSwmC4PQVvgtOhSVA27M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=H1l9lAlAEWu4Ih8zjNqTQDWuhmIRp4FiqUY+jwtg1D2xaD4gJCrC+Nj/nHwxhB3OIR7jP258K8X8Ga5XyiruXw9ElbBIyXpUUemaYuj2Yz4hmhFsIX6h4K/lj05OvLolgQZ7Tp797U9MtJL1EGjA2xVbj1NSr8UYKwM4xCEDdLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JuNSNrst; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240125043657epoutp03c03bfeefae251da988501d9eec6048d3~tfSHLlLNF0189501895epoutp03J
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:36:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240125043657epoutp03c03bfeefae251da988501d9eec6048d3~tfSHLlLNF0189501895epoutp03J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706157417;
	bh=FxRt1IQQ9RC5YoH6B7ssFdDYXaY2b2Jj8AIgAplcqlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JuNSNrstCX6YtCsIJxTrGm3s446quYIXgJqM7dMYTXVSW8e4DgBVO9DM3wJyKosMe
	 JZxCmOrGGEhSFe5FlDTY/ggepXB0dYZLnLnLpOnLzDiv80si55E4V+hDKR/b2rctlm
	 61+xEzLeiB5h9Q6dsNR05cUp4Cs+NswrwEs5FOl4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240125043657epcas5p2e8dcabc0d9f5640cf3243ccc69e1ab4b~tfSG5Cmqj2349523495epcas5p2x;
	Thu, 25 Jan 2024 04:36:57 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TL7MV6TbTz4x9Pt; Thu, 25 Jan
	2024 04:36:54 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1C.E8.19369.665E1B56; Thu, 25 Jan 2024 13:36:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240125043654epcas5p10aa2da156c494bbaebd0bd63a37c87aa~tfSD8Vyld0294902949epcas5p1a;
	Thu, 25 Jan 2024 04:36:54 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240125043654epsmtrp1ccfa2db4cf445bd7254aaf5488fa490a~tfSD7qyDD1583815838epsmtrp1x;
	Thu, 25 Jan 2024 04:36:54 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-0d-65b1e566f3a3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A4.4A.07368.665E1B56; Thu, 25 Jan 2024 13:36:54 +0900 (KST)
Received: from ws2030077324.sa.corp.samsungelectronics.net (unknown
	[107.99.237.91]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240125043652epsmtip28c11c214583483f9bc409b94a14d4064~tfSCfoI_g2197421974epsmtip2k;
	Thu, 25 Jan 2024 04:36:52 +0000 (GMT)
From: Sandeep C S <sandeep.cs@samsung.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<benjamin.tissoires@redhat.com>
Cc: gaudium.lee@samsung.com, ih0923.kim@samsung.com,
	suhyun_.kim@samsung.com, jitender.s21@samsung.com, junwan.cho@samsung.com,
	sandeep.cs@samsung.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [HID Patchsets for Samsung driver v4 1/6] HID Samsung : Broaden
 device compatibility in samsung driver.
Date: Thu, 25 Jan 2024 10:06:24 +0530
Message-Id: <20240125043630.4031634-2-sandeep.cs@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125043630.4031634-1-sandeep.cs@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmpm7a042pBr/XG1lcn7KZ1eL2Ak+L
	rUvmslrcOt7KaPHywQZ2i82TH7FY3Pz0jdXi8q45bBbts58xWjxasYnJgctj06pONo/3+66y
	efRtWcXo8XmTXABLVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2S
	i0+ArltmDtA9SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8dL28
	1BIrQwMDI1OgwoTsjJtffjIWbBGouN25jq2B8QRvFyMnh4SAicTrIzcZuxi5OIQE9jBKLG57
	zwLhfGKUaP98H8r5xihxrL2RFa5l3jaoxF5GibOvFzBDOJ1MEqcf7mUGqWIT0JLoO/KdCcQW
	EYiQeLdgEyOIzSxwnVHiwcNAEFtYoEjiQN9qFhCbRUBV4v6yY2A2r4CtxJdXc6C2yUvsP3gW
	bCangJ1E39I3TBA1ghInZz5hgZgpL9G8dTbYERICP9klFn/vYYFodpH4ueoR1CBhiVfHt7BD
	2FISL/vb2CEauhkllt4+BuXMYJRo2XmVGaLKXuLn6wlsXYwcQCs0Jdbv0ofYxifR+/sJE0hY
	QoBXoqNNCKJaReJp125WmPnfT2xkgrA9JP7tvsIOCaGJjBKXZl9hnMAoPwvJE7OQPDELYdsC
	RuZVjFKpBcW56anJpgWGunmp5fDITc7P3cQITppaATsYV2/4q3eIkYmD8RCjBAezkgivienG
	VCHelMTKqtSi/Pii0pzU4kOMpsBgnsgsJZqcD0zbeSXxhiaWBiZmZmYmlsZmhkrivK9b56YI
	CaQnlqRmp6YWpBbB9DFxcEo1MNn+KNXvedQzsf+f7txrTfuXhTi3H+/cvN+9T+Pu01L1k9Jf
	c757e7+KZy5+pcPNsbKwtkrt84oOnq9zevkM1k70CPBqNSgzFfV8ud8wLk1n693ka6ab/6lf
	vGXRI1hk7WLQVWbSocH38uHbN+f19H+E9hydF3BhW9SfkGvLd7zN3+GofVsqtk8sX53jj4XL
	ErtjqnfLL/pzc1+WO74/f5MRi9mpi3x3MydKBVwyTl6bxrLZyyTFN2fntr6QTK5Ktl1u6oVT
	ee+KTjB91ZK8MiD7WFmrY4Vmn1dF1fSUKb5fYr6vD+2Im/zpn/2BL+yH9y9aEiiS3WlwxmzV
	He30DaYXfvYx8yvJTL8swH1ZiaU4I9FQi7moOBEATl15LSMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSvG7a042pBrMmSlhcn7KZ1eL2Ak+L
	rUvmslrcOt7KaPHywQZ2i82TH7FY3Pz0jdXi8q45bBbts58xWjxasYnJgctj06pONo/3+66y
	efRtWcXo8XmTXABLFJdNSmpOZllqkb5dAlfGzS8/GQu2CFTc7lzH1sB4greLkZNDQsBE4vW8
	bSxdjFwcQgK7GSVuHvvLDJGQklh1/R4jhC0ssfLfc3aIonYmiVu/17KBJNgEtCT6jnxnArFF
	BCIkpv1bywhSxCxwn1Fi6/6rYEXCAgUSK7qPsoPYLAKqEveXHWMBsXkFbCW+vJrDCrFBXmL/
	wbNgmzkF7CT6lr4BGyoEVHP/zWxWiHpBiZMzn4D1MgPVN2+dzTyBUWAWktQsJKkFjEyrGCVT
	C4pz03OTDQsM81LL9YoTc4tL89L1kvNzNzGCQ11LYwfjvfn/9A4xMnEwHmKU4GBWEuE1Md2Y
	KsSbklhZlVqUH19UmpNafIhRmoNFSZzXcMbsFCGB9MSS1OzU1ILUIpgsEwenVANTxcmuzc6n
	OJft2/v4YkicysFoPfNtRzvNve3ql1ucqMm+8OHNL/3pV7uC27+xCWyVWLZI9/Ksx96Lbdjk
	9svmx11+Yx6yXJVld4fKsjeeLw6+snod2+ZSxLh8nXd8S87RWfO2hHzLebv1yV7Z6HOrr+qI
	/bxQuHm5mO2HOwl1J1Nys/d//X5u9tw32XFR1rvk7L/NDDq84rzFpJndz7esW1z/+QmLyVfz
	7oyCbbumMLirzZM+oeTlJeC+d1LJkoOfexduan7Atl0/4WODk2hBvdQv3aWlEup/k4JfHbi9
	OdzO3lC0X1n0IoeofsVZs5u/zV74Hl7/bv6M98026tqLHr1K1ZnIkfvIL+WMzPqociWW4oxE
	Qy3mouJEAFscY7HkAgAA
X-CMS-MailID: 20240125043654epcas5p10aa2da156c494bbaebd0bd63a37c87aa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240125043654epcas5p10aa2da156c494bbaebd0bd63a37c87aa
References: <20240125043630.4031634-1-sandeep.cs@samsung.com>
	<CGME20240125043654epcas5p10aa2da156c494bbaebd0bd63a37c87aa@epcas5p1.samsung.com>

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
index cf5992e97094..3a8756232731 100644
--- a/drivers/hid/hid-samsung.c
+++ b/drivers/hid/hid-samsung.c
@@ -128,7 +128,7 @@ static int samsung_kbd_mouse_input_mapping(struct hid_device *hdev,
 static __u8 *samsung_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	unsigned int *rsize)
 {
-	if (USB_DEVICE_ID_SAMSUNG_IR_REMOTE == hdev->product)
+	if (USB_DEVICE_ID_SAMSUNG_IR_REMOTE == hdev->product && hid_is_usb(hdev))
 		rdesc = samsung_irda_report_fixup(hdev, rdesc, rsize);
 	return rdesc;
 }
@@ -139,7 +139,7 @@ static int samsung_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 {
 	int ret = 0;
 
-	if (USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE == hdev->product)
+	if (USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE == hdev->product && hid_is_usb(hdev))
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


