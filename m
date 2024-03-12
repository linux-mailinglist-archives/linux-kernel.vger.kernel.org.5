Return-Path: <linux-kernel+bounces-99747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0EF878C90
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E400B215FF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C9B53A1;
	Tue, 12 Mar 2024 01:52:35 +0000 (UTC)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8452469D;
	Tue, 12 Mar 2024 01:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710208355; cv=none; b=BUSs4UC4oX5sJvfitbDWXZmPdJj5UJ9UrFQjAxh73J8xl9D0b0a3VGuUKV/c3zHULA/mT4JDYeO99rfePQvM7dRFzSpi9T/PifcBeSWjkS/Vaut4m8wJZv3icJAmh7+u3P7NdZ6Y2pq9lyZ10nK/4X5enLQnTqdOM9xDBMmqIzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710208355; c=relaxed/simple;
	bh=oZSt8rOcfsApDGaXioQ83dqa7XFV7dDDeX7YZCZIXWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qjFzsdOGiOHt9eDon2HoTqMH9nfNRjO6zPRISximx74/9ERa4sBh6gyEBNgbD1yh4mJ9sn7Xo0DUhQIy89bF1flNg9VSIN3t9SGgG6eufpJyu7hiE0GQQX5bKIXyYKQanmjyQznX+j9V7Vo2vyw6gs/pJOv/4KTOM9VmVCAbFnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp90t1710208311tl9p0klz
X-QQ-Originating-IP: s65UGkHpF2o9p4eY6Dtwin3B09Ieh1+LZF8N2A+5T0M=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 Mar 2024 09:51:50 +0800 (CST)
X-QQ-SSF: 01400000000000C0B000000A0000000
X-QQ-FEAT: +ynUkgUhZJknQdj8DNcL8xe+8WjYPGdGsyvtr2K5zIPQKmQCiczINsccDoZnI
	HJVUjYUBSd8lDwyrexXgUWl244sLWMjP/w183+z4b7bftBLDzY8Av2OVl0ez4k8xWxj4Ez6
	9bVlrmszXEyztdKczipe13X4bYZh5IuP41Fln6ESwV+oA6cicmCuKIwX7ZNkZJz93pIUj7v
	K1mnHPGJ90iJTHa42FrY7yqdJfyTmUY9CCMSQZ63hJbTL/gFnxQGDXbRfvAWznFG7sQs2Re
	ZNzEZHRww3pRL4dz/zhx/1Un5HB+rQsTUwDuXR0C+bVsLICZ6YakvdM0lacMi7Y3lLjFS1e
	bkslMyyfKivbHZAYWVB+XnhmA1TuQ71x+ZCKACRgFIB4IO3XDOJprc4GMqP0dnDc8DtVFwD
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4870457541553938088
From: WangYuli <wangyuli@uniontech.com>
To: wangyuli@uniontech.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: Larry.Finger@lwfinger.net,
	guanwentao@uniontech.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: Add device 0bda:4853 to blacklist/quirk table
Date: Tue, 12 Mar 2024 09:51:33 +0800
Message-ID: <893FB314C6C03130+20240312015133.232214-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

This new device is part of a Realtek RTW8852BE chip. Without this change
the device utilizes an obsolete version of the firmware that is encoded
in it rather than the updated Realtek firmware and config files from
the firmware directory. The latter files implement many new features.

The device table is as follows:

T: Bus=03 Lev=01 Prnt=01 Port=09 Cnt=03 Dev#= 4 Spd=12 MxCh= 0
D: Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
P: Vendor=0bda ProdID=4853 Rev= 0.00
S: Manufacturer=Realtek
S: Product=Bluetooth Radio
S: SerialNumber=00e04c000001
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=81(I) Atr=03(Int.) MxPS= 16 Ivl=1ms
E: Ad=02(O) Atr=02(Bulk) MxPS= 64 Ivl=0ms
E: Ad=82(I) Atr=02(Bulk) MxPS= 64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 0 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 0 Ivl=1ms
I: If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 9 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 9 Ivl=1ms
I: If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 17 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 17 Ivl=1ms
I: If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 25 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 25 Ivl=1ms
I: If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 33 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 33 Ivl=1ms
I: If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 49 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 49 Ivl=1ms

Link: https://lore.kernel.org/all/20230810144507.9599-1-Larry.Finger@lwfinger.net/
Cc: stable@vger.kernel.org
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 06e915b57283..d9c621d15fee 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -542,6 +542,8 @@ static const struct usb_device_id quirks_table[] = {
 	/* Realtek 8852BE Bluetooth devices */
 	{ USB_DEVICE(0x0cb8, 0xc559), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0bda, 0x4853), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0bda, 0x887b), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0bda, 0xb85b), .driver_info = BTUSB_REALTEK |
-- 
2.43.0


