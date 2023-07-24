Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716CF75EE4A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjGXItC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjGXIsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:48:55 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBD3E7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:48:41 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230724084838epoutp037a63b6cf3051a62886bbe4bcc3b1981e~0wYDFEFfy0662306623epoutp03L
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:48:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230724084838epoutp037a63b6cf3051a62886bbe4bcc3b1981e~0wYDFEFfy0662306623epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690188519;
        bh=4pHWqNBY3mxBfe0luIc8pUfw6H726cTdcpi5J7zudj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ci/YndVx27Pfos5RMUwMjlKs1rJhsD5bd3MdW1qbpspGgAE6qN75XIXsXABk6I2OB
         2xF3aGyWQfOSnrH+TZ8xCpV3F17ReAvSoaVr6BC7vAuML49a2P7Epm6AJ7GkPzkbh1
         a23lMrc1IfD74MowkXSefudVCy5et1HW0oGYbOKI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230724084838epcas5p3cd796af73b5a1ada7a4d2a7d93bdff2b~0wYCTLGK22180021800epcas5p3V;
        Mon, 24 Jul 2023 08:48:38 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4R8YjJ6FNGz4x9Pw; Mon, 24 Jul
        2023 08:48:36 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.1C.06099.4EA3EB46; Mon, 24 Jul 2023 17:48:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230724084836epcas5p3c6044b8e4b7824c3d1b2e221aa531a00~0wYAZFP6A1773117731epcas5p3T;
        Mon, 24 Jul 2023 08:48:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230724084836epsmtrp2f9cb70dfa13f420a915650b1c203bea1~0wYAYVReg2947729477epsmtrp2d;
        Mon, 24 Jul 2023 08:48:36 +0000 (GMT)
X-AuditID: b6c32a4b-cafff700000017d3-76-64be3ae46f1f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BB.C0.34491.3EA3EB46; Mon, 24 Jul 2023 17:48:35 +0900 (KST)
Received: from ws2030077039.sa.corp.samsungelectronics.net (unknown
        [107.99.235.14]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230724084834epsmtip10d6b2e2be083094f5159511606021054~0wX_tvcKs2888928889epsmtip1K;
        Mon, 24 Jul 2023 08:48:34 +0000 (GMT)
From:   "sandeep.cs" <sandeep.cs@samsung.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     junwan.cho@samsung.com, jitender.s21@samsung.com,
        suhyun_.kim@samsung.com, ih0923.kim@samsung.com,
        gaudium.lee@samsung.com, sandeep.cs@samsung.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [HID Patchsets v1 1/2] HID: Add support for Samsung Bluetooth hid
 devices
Date:   Mon, 24 Jul 2023 14:17:50 +0530
Message-Id: <20230724084752.371245-2-sandeep.cs@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230724084752.371245-1-sandeep.cs@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmhu4Tq30pBufm6Vtcn7KZ1eL2Ak+L
        rUvmslrcOt7KaPHywQZ2i82TH7FY3Pz0jdXi8q45bBbts58xWjxasYnJgctj06pONo/3+66y
        efRtWcXo8XmTXABLVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2S
        i0+ArltmDtA9SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8dL28
        1BIrQwMDI1OgwoTsjHXrFzEVTGtkrOh5f5ixgXFHVhcjB4eEgInE1IeyXYxcHEICuxkl1p47
        wQrhfGKU6D60lR3C+cYo0fbmEZDDCdZx7etfJojEXkaJn3P+M0I4nUwSC6e3sYFUsQloS8z4
        e40ZxBYRiJB4t2ATWBGzwHVGiecz5jCBJIQFQiQWP73MCmKzCKhK/N58iAXE5hWwkfj27i0j
        xDp5iZmXvoOt5hSwlTg6dR87RI2gxMmZT8DqmYFqmrfOZgZZICHwlV2itbObGaLZRaLn7Gcm
        CFtY4tXxLVA/SEl8freXDaKhm1Fi6e1j7BDODEaJlp1XobrtJX6+nsAGCidmAU2J9bv0Ibbx
        SfT+fsIECT5eiY42IYhqFYmnXbtZYeZ/P7ERaq+HxJwz06EBOYFR4v7hxWwTGOVnIXliFpIn
        ZiFsW8DIvIpRMrWgODc9tdi0wDgvtRweucn5uZsYwUlTy3sH46MHH/QOMTJxMB5ilOBgVhLh
        TU/flSLEm5JYWZValB9fVJqTWnyI0RQYyhOZpUST84FpO68k3tDE0sDEzMzMxNLYzFBJnPd1
        69wUIYH0xJLU7NTUgtQimD4mDk6pBqbzuRX+nRVHWh/rTVwcwZg1VT70tWm017ueV/PrQzpV
        GwxkJK2mzopuSZ7oeJq/5JLy/GVtGmsUnl+8xfP/cApz7B6bkIiyWTtEd3jsOnLXJPqctKDK
        qxuCv023OXHd/5URdDE9osqudt/Grzslr1vxlKz7JSOWr/SRLfZH/77LbG5Lzqfcb7zJ26OZ
        PMHwyrnHkflmAYudGSZan/s6cYpu7+ywJqv9Pw56HGTpe2r6r6hUh8/yZlXPY7WEMttYKZ/M
        l8o9ooxr+TjeC83x32pX+F07T03KRoojTyqu+cij3Nyyitnz58s29WW9sNVtn8F96UFo9q7M
        OaZGhxU5alT5gnbN5tnV+Zc7sG6qEktxRqKhFnNRcSIACy+NlyMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSnO5jq30pBmvOWllcn7KZ1eL2Ak+L
        rUvmslrcOt7KaPHywQZ2i82TH7FY3Pz0jdXi8q45bBbts58xWjxasYnJgctj06pONo/3+66y
        efRtWcXo8XmTXABLFJdNSmpOZllqkb5dAlfGuvWLmAqmNTJW9Lw/zNjAuCOri5GTQ0LAROLa
        179MXYxcHEICuxkl9lzoYoFISEmsun6PEcIWllj57zk7iC0k0M4ksa9NC8RmE9CWmPH3GjOI
        LSIQITHt31qwemaB+4wSJ1cagdjCAkESc1etA+tlEVCV+L35ENh8XgEbiW/v3kLNl5eYeek7
        WA2ngK3E0an7oHbZSOw4tpYdol5Q4uTMJywQ8+UlmrfOZp7AKDALSWoWktQCRqZVjJKpBcW5
        6bnFhgWGeanlesWJucWleel6yfm5mxjBga6luYNx+6oPeocYmTgYDzFKcDArifCmp+9KEeJN
        SaysSi3Kjy8qzUktPsQozcGiJM4r/qI3RUggPbEkNTs1tSC1CCbLxMEp1cAUrzhx692lQWva
        +dap1C99xNpV7tWsYxDzo7vB+o/nquvs35viazNqRSZc4S2snX33mOquz4X5SVdcrhjN/HTy
        8iG1Ox1aPFleDXdXXe/8l33leGhzQbL+pAviXQ4N6y2C9Pi+78p+Zvf25YJSixuu0V/Xn+jY
        oLqtTEDn+/875QFWQT2JOdOn2ga5Mt4pvcvht/PTtibrW2drPrK/O+iu7/5/S7XJR9G4bzeb
        pKa5u4UU5+2T1Opxd1l+xZ7jWdvd5T/XTvJIyjNlL1TKV1m7tiBdbO36Xa7TQy4ctZjLPZl5
        caxu8h8djwY/tRPWmtWuEiq8BmeuzY7Jl+Fc/+uB2AlNuXf7jRJsd2UZXlFiKc5INNRiLipO
        BAAKE72c4wIAAA==
X-CMS-MailID: 20230724084836epcas5p3c6044b8e4b7824c3d1b2e221aa531a00
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230724084836epcas5p3c6044b8e4b7824c3d1b2e221aa531a00
References: <20230724084752.371245-1-sandeep.cs@samsung.com>
        <CGME20230724084836epcas5p3c6044b8e4b7824c3d1b2e221aa531a00@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for the Samsung hid devices like keyboard, action mouse and gamepad over the Bluetooth connection.

Bluetooth devices

Vendor 04e8 (Samsung)
Device 7021 (Samsung Wireless Keyboard)
Device a000 (Samsung Wireless GamePad)
Device a004 (Samsung Wireless Action Mouse)
Device a005 (Samsung Wireless BookCover)
Device a006 (Samsung Wireless Universal Keyboard)
Device a064 (Samsung Wireless HOGP Keyboard)

And also, special key processing on each Samsung Bluetooth devices.

The changes in this commit adhere to the kernel coding guidelines.

Signed-off-by: Sandeep C S <sandeep.cs@samsung.com>
Signed-off-by: Junwan Cho <junwan.cho@samsung.com>
Signed-off-by: Jitender Sajwan <jitender.s21@samsung.com>
---
 drivers/hid/hid-ids.h     |   8 +
 drivers/hid/hid-samsung.c | 412 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 399 insertions(+), 21 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 8a310f8ff20f..35b2f50ba3c6 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1139,6 +1139,14 @@
 #define USB_DEVICE_ID_SAMSUNG_IR_REMOTE	0x0001
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE	0x0600
 
+#define USB_VENDOR_ID_SAMSUNG_ELECTRONICS	0x04e8
+#define USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD	0x7021
+#define USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD	0xa000
+#define USB_DEVICE_ID_SAMSUNG_WIRELESS_ACTIONMOUSE	0xa004
+#define USB_DEVICE_ID_SAMSUNG_WIRELESS_BOOKCOVER	0xa005
+#define USB_DEVICE_ID_SAMSUNG_WIRELESS_UNIVERSAL_KBD	0xa006
+#define USB_DEVICE_ID_SAMSUNG_WIRELESS_MULTI_HOGP_KBD	0xa064
+
 #define USB_VENDOR_ID_SEMICO			0x1a2c
 #define USB_DEVICE_ID_SEMICO_USB_KEYKOARD	0x0023
 #define USB_DEVICE_ID_SEMICO_USB_KEYKOARD2	0x0027
diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
index cf5992e97094..33e963303d11 100644
--- a/drivers/hid/hid-samsung.c
+++ b/drivers/hid/hid-samsung.c
@@ -67,20 +67,17 @@ static __u8 *samsung_irda_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		rdesc[178] = 0x08;
 		rdesc[180] = 0x06;
 		rdesc[182] = 0x42;
-	} else
-	if (*rsize == 203 && rdesc[192] == 0x15 && rdesc[193] == 0x0 &&
+	} else if (*rsize == 203 && rdesc[192] == 0x15 && rdesc[193] == 0x0 &&
 			rdesc[194] == 0x25 && rdesc[195] == 0x12) {
 		samsung_irda_dev_trace(hdev, 203);
 		rdesc[193] = 0x1;
 		rdesc[195] = 0xf;
-	} else
-	if (*rsize == 135 && rdesc[124] == 0x15 && rdesc[125] == 0x0 &&
+	} else if (*rsize == 135 && rdesc[124] == 0x15 && rdesc[125] == 0x0 &&
 			rdesc[126] == 0x25 && rdesc[127] == 0x11) {
 		samsung_irda_dev_trace(hdev, 135);
 		rdesc[125] = 0x1;
 		rdesc[127] = 0xe;
-	} else
-	if (*rsize == 171 && rdesc[160] == 0x15 && rdesc[161] == 0x0 &&
+	} else if (*rsize == 171 && rdesc[160] == 0x15 && rdesc[161] == 0x0 &&
 			rdesc[162] == 0x25 && rdesc[163] == 0x01) {
 		samsung_irda_dev_trace(hdev, 171);
 		rdesc[161] = 0x1;
@@ -107,17 +104,39 @@ static int samsung_kbd_mouse_input_mapping(struct hid_device *hdev,
 
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
@@ -125,10 +144,342 @@ static int samsung_kbd_mouse_input_mapping(struct hid_device *hdev,
 	return 1;
 }
 
+static int samsung_kbd_input_mapping(struct hid_device *hdev,
+	struct hid_input *hi, struct hid_field *field, struct hid_usage *usage,
+	unsigned long **bit, int *max)
+{
+	if (!(HID_UP_CONSUMER == (usage->hid & HID_USAGE_PAGE) ||
+			HID_UP_KEYBOARD == (usage->hid & HID_USAGE_PAGE)))
+		return 0;
+	dbg_hid("samsung wireless keyboard input mapping event [0x%x]\n",
+		usage->hid & HID_USAGE);
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
+		/* Smtart Voice Key */
+		case 0x300:
+			samsung_kbd_mouse_map_key_clear(BTN_TRIGGER_HAPPY13);
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
+		case 0x30b:
+			samsung_kbd_mouse_map_key_clear(KEY_BRIGHTNESSUP);
+			break;
+		default:
+			return 0;
+		}
+	}
+	return 1;
+}
+
+static int samsung_gamepad_input_mapping(struct hid_device *hdev,
+	struct hid_input *hi, struct hid_field *field, struct hid_usage *usage,
+	unsigned long **bit, int *max)
+{
+	if (!(HID_UP_BUTTON == (usage->hid & HID_USAGE_PAGE) ||
+			HID_UP_CONSUMER == (usage->hid & HID_USAGE_PAGE)))
+		return 0;
+	dbg_hid("samsung wireless gamepad input mapping event [0x%x], %ld, %ld, [0x%x]\n",
+		usage->hid & HID_USAGE, hi->input->evbit[0], hi->input->absbit[0], usage->hid & HID_USAGE_PAGE);
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
+		/* Screen Capture */
+		case 0x303:
+			samsung_kbd_mouse_map_key_clear(KEY_SYSRQ);
+			break;
+		default:
+			return 0;
+		}
+	}
+	return 1;
+}
+static int samsung_actionmouse_input_mapping(struct hid_device *hdev,
+	struct hid_input *hi, struct hid_field *field, struct hid_usage *usage,
+	unsigned long **bit, int *max)
+{
+	dbg_hid("samsung wireless actionmouse input mapping event [0x%x], [0x%x], %ld, %ld, [0x%x]\n",
+			usage->hid, usage->hid & HID_USAGE, hi->input->evbit[0], hi->input->absbit[0],
+			usage->hid & HID_USAGE_PAGE);
+	if (((usage->hid & HID_USAGE_PAGE) != HID_UP_CONSUMER) && ((usage->hid & HID_USAGE_PAGE) != HID_UP_BUTTON))
+		return 0;
+	switch (usage->hid & HID_USAGE) {
+	case 0x301:
+		samsung_kbd_mouse_map_key_clear(254);
+		break;
+	default:
+		return 0;
+	}
+	return 1;
+}
+static int samsung_universal_kbd_input_mapping(struct hid_device *hdev,
+	struct hid_input *hi, struct hid_field *field, struct hid_usage *usage,
+	unsigned long **bit, int *max)
+{
+	if (!(HID_UP_CONSUMER == (usage->hid & HID_USAGE_PAGE) ||
+			HID_UP_KEYBOARD == (usage->hid & HID_USAGE_PAGE)))
+		return 0;
+	dbg_hid("samsung wireless keyboard input mapping event [0x%x]\n",
+		usage->hid & HID_USAGE);
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
+	return 1;
+}
+
 static __u8 *samsung_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	unsigned int *rsize)
 {
-	if (USB_DEVICE_ID_SAMSUNG_IR_REMOTE == hdev->product)
+	if (hdev->product == USB_DEVICE_ID_SAMSUNG_IR_REMOTE)
 		rdesc = samsung_irda_report_fixup(hdev, rdesc, rsize);
 	return rdesc;
 }
@@ -139,10 +490,24 @@ static int samsung_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 {
 	int ret = 0;
 
-	if (USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE == hdev->product)
+	if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE)
 		ret = samsung_kbd_mouse_input_mapping(hdev,
 			hi, field, usage, bit, max);
-
+	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD)
+		ret = samsung_kbd_input_mapping(hdev,
+			hi, field, usage, bit, max);
+	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD)
+		ret = samsung_gamepad_input_mapping(hdev,
+			hi, field, usage, bit, max);
+	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_ACTIONMOUSE)
+		ret = samsung_actionmouse_input_mapping(hdev,
+			hi, field, usage, bit, max);
+	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_UNIVERSAL_KBD)
+		ret = samsung_universal_kbd_input_mapping(hdev,
+			hi, field, usage, bit, max);
+	else if (hdev->product == USB_DEVICE_ID_SAMSUNG_WIRELESS_MULTI_HOGP_KBD)
+		ret = samsung_universal_kbd_input_mapping(hdev,
+			hi, field, usage, bit, max);
 	return ret;
 }
 
@@ -161,7 +526,7 @@ static int samsung_probe(struct hid_device *hdev,
 		goto err_free;
 	}
 
-	if (USB_DEVICE_ID_SAMSUNG_IR_REMOTE == hdev->product) {
+	if (hdev->product == USB_DEVICE_ID_SAMSUNG_IR_REMOTE) {
 		if (hdev->rsize == 184) {
 			/* disable hidinput, force hiddev */
 			cmask = (cmask & ~HID_CONNECT_HIDINPUT) |
@@ -183,6 +548,11 @@ static int samsung_probe(struct hid_device *hdev,
 static const struct hid_device_id samsung_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_GAMEPAD) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_ACTIONMOUSE) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_UNIVERSAL_KBD) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SAMSUNG_ELECTRONICS, USB_DEVICE_ID_SAMSUNG_WIRELESS_MULTI_HOGP_KBD) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, samsung_devices);
-- 
2.25.1

