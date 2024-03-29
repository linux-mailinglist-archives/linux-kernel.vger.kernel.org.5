Return-Path: <linux-kernel+bounces-124061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2748911B1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A23D28A378
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A7F32C60;
	Fri, 29 Mar 2024 02:36:53 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BCB1755B;
	Fri, 29 Mar 2024 02:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.80.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711679812; cv=none; b=Vgw2u/Jpm9SBLTTAO4MYtqfJd5A9/m3/AhDwOKKFaOda/nfryOAbYrLowzr7uQiW1xBIDhslxp4XMoFZTlGrFeBaCjbYunGDpkz/pX2tz434kU2cTbrD3RrJgyzVXrecwDQdUigzugb//DI5J8pF2CU0O7aMIN8SNn4vOTYHBgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711679812; c=relaxed/simple;
	bh=lNo8VGQtKXlMfN/GYEunrmU3o4T2AUaXwiOuGq+GC6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pBBWQ32zuet58KDvpeaFGkKSL/Elm0+ehOk6hkB7YNIp+yFGOS7EUiDBGGGyB7dj+W1pnUAu7TsQwc/PO1sJ+Fw9VXETruDXNkPNwWhyWIhJymGNo2RKICFsfFl0X8k4HOK2+9YWiETtY0uiA4jV/kVse74LcDAzpU130wsj+/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=43.155.80.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp84t1711679709tqsna5x2
X-QQ-Originating-IP: 9DI/m0nSHoWrbokge9cHLwFEuyqWtQa85xBPKylsOvw=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 Mar 2024 10:35:08 +0800 (CST)
X-QQ-SSF: 01400000000000C0B000000A0000000
X-QQ-FEAT: dKvkn8qoLrENEuiqnKnh9VViaa0Ck5dpdvYt66Om678Du6fG4F5jOWi9xLycH
	0x800yDg72x2tc6GIm7S29N1SP8HaCEOuVPPGPzTInfWr0hL2ndppAaTM780+IqaiEkXFgy
	MKoiPhkslcsFTqoiOsxNkRoIQde70anacwn+kz4QgmPOnf5/59PLc3CkDMC/mGK2WLoiIOM
	6/kArRC3s8f8F/5owm3Hj0BUOQqfce8WTfV5PYhQvawSN3D1iMVbB31fmQYml53ED05OeBW
	TEVDlLvQSejbPQAFlYH0aNDmBymvOP/ddK7vdFI+IDptD2l+w3D35KYd+sEwG6k1itUP0ac
	bPFMT/s/wKaHkl9r2hpUJYQ6DU4OPGCNdRAdjhpaTNt5dtpGOinxHSSNR6rgQcIro464cir
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1572931789947820350
From: WangYuli <wangyuli@uniontech.com>
To: wangyuli@uniontech.com,
	Larry.Finger@lwfinger.net,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	guanwentao@uniontech.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [RESEND. PATCH v2] Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0bda:0x4853
Date: Fri, 29 Mar 2024 10:34:39 +0800
Message-ID: <883A1BECA61AB8B7+20240329023440.191799-1-wangyuli@uniontech.com>
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

Add the support ID(0x0bda, 0x4853) to usb_device_id table for
Realtek RTL8852BE.

Without this change the device utilizes an obsolete version of
the firmware that is encoded in it rather than the updated Realtek
firmware and config files from the firmware directory. The latter
files implement many new features.

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

Cc: stable@vger.kernel.org
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c391e612b83b..3356af3a7f61 100644
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


