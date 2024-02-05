Return-Path: <linux-kernel+bounces-52424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B4C8497EC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2D81C233CE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250D817C61;
	Mon,  5 Feb 2024 10:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJLuue+j"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE6417582;
	Mon,  5 Feb 2024 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707129659; cv=none; b=OfzB4B7tbJ2Ixbr1uhZQRBDjnlP7RyBG1nbLkp7nEcKWhC4dgNJoKPo9X3Zd2wpVflHzRuu4MX0WHwWocwQDzAYiz592DiysiY2IU/MAMDCwlk1QK8Jo9egRqgv0BYHJi6EZcl0DpL0ZXJK70R0ZpX3M5fbaunGt58FJIaCU8FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707129659; c=relaxed/simple;
	bh=wtrUsFtRb+dksK9niN3BPbZz1VhgUlfAsa/4rO98xQE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zm6HXeH5AhGeROGr+BsveO3p2YxdpZOCjRYYUv7Ivi7e/5n6/FqWkOEgez+KB40xuZecNBSf1LSVkD5GXakvtoQprgpKBHbyt5sW+ne9LK/FrVEUxbB+/FhdqG5AIsolXcdvCmXq1dobG97JtXA0ezWQsEdXK13QQVYDL5waDzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJLuue+j; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40fdb18ffc7so7030955e9.1;
        Mon, 05 Feb 2024 02:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707129655; x=1707734455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTkdEF41NsPQG6hz5sAOnT5dFTTDWAVd/8SJ84ufz0o=;
        b=cJLuue+jhRuuFCT8XOMdHrjVtBLHmhps4YJCpXw3mBMEhFs4de5huIdIh5q/3uRVcz
         b6Tp7ZQ1bIQvHYjWYEUMEmCwGg69wM97tY8iULt0ufnHzOswna84wglH704HenUCMv/0
         fMi5YtyfJtdsxFlceAd+uhDbiIyy8EfuFMsiidheRslN5IbbtNuaHBKK184ncMZ60zXV
         KY7TmCv+fQwuoDF0CiYp4XHaTC5ZRfshZdH3N06E02VNJhtiVQIV7Q6m9mEa+1nmy6XE
         arpuXnxR8rNe53hHZ1/BQpx48BtqQhXm5JMq05viMCHtrvcQu8s9STiSLj9qmubYTOme
         J13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707129655; x=1707734455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTkdEF41NsPQG6hz5sAOnT5dFTTDWAVd/8SJ84ufz0o=;
        b=UHxpAd1RNjBIdLJEeHItZ0Fb0QoOrVLevww2O5c8vxHUGo4lef8bSAimYrCxHutDgk
         Q6obfWFQEbjtF7Qx1+9eOaq/ZcPV1UxEoH0nX4dPu1IntVVveQPYH3IM4r9m35u7YNiR
         c+6VVNh6y+SmN3oxG5MO9CLGPRXpEJISawMVFIRhWDOi6SOKCg9bEx3qE1AjGw6TfVxP
         Y5v6Xsc92n6TKTNm7nxIELX0nhqohZqzY6R06TgcMkLHthG1n3PK0HD8tMG4VZNBsDqD
         DGZH/zFWxw1trGyOs5sm0kNivpW0Ri+ATHeEsgOQlAep2pSaz5da8ZniBtDhdXxdO+tE
         nvBw==
X-Gm-Message-State: AOJu0YwucQ6cKtT5/p0ACMAOOhyz9sixdUR3y7Lw5JMrC1zUm2+Qcgya
	hwu9WMIDwMBYDMAtQLjgOCfyCmWromc4EMkxIipahSqvS4Yti58l
X-Google-Smtp-Source: AGHT+IERIpD8G4mzv/5seLaxZUwvRcU+Jhc1Og6pLolAQtG/y9lhnxiRiWDdFp1IXAPE6b+aEU2RLg==
X-Received: by 2002:a05:600c:4687:b0:40f:e40:b53d with SMTP id p7-20020a05600c468700b0040f0e40b53dmr4080465wmo.1.1707129655078;
        Mon, 05 Feb 2024 02:40:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUdbxgd0LW0/idogMMbC+jRsK3d8+u8pG6vnmCLbpQCX9sKffYukgQZkRWVYK03j+IWyMbUUQlFy9Urf6RyxP1IxS+NdIVFSCtSpJz/8XUNFrWk1JGhlODok6FpbDQSTLBlXH2lxZvALBCFRAFaGgAFpSIz79pr4ELSVZokrFuwUkdHUFLi2vt4ZoVfai4aXq2kL6Lhhph8QE3TR7fb2+iQqMiqeFN0jahgpl1u/wrV19JtUT6Sj7BHU1A15rtODHxzVDPoPqrCt4nj6qWBgnA=
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id fm24-20020a05600c0c1800b0040ee8765901sm8299011wmb.43.2024.02.05.02.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 02:40:54 -0800 (PST)
From: Christian Hewitt <christianshewitt@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Grant Grundler <grundler@chromium.org>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] net: asix: cosmetic tidying of the usb device list
Date: Mon,  5 Feb 2024 10:40:49 +0000
Message-Id: <20240205104049.48900-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205104049.48900-1-christianshewitt@gmail.com>
References: <20240205104049.48900-1-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cosmetic corrections for tabs/spaces, capital letters, and formatting.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
While checking the patch for adding the ID's (cribbing the format from                    
the existing entries) checkpatch complained about "space prohibited                       
between function name and open parenthesis" and "No space is necessary                    
after a cast"; so this patch fixes the same issues on the existing ID's                     
in the same list. While here, also fix some tabs/spaces and Capitals
for consistency.

 drivers/net/usb/asix_devices.c | 136 ++++++++++++++++-----------------
 1 file changed, 68 insertions(+), 68 deletions(-)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 9a7b1136cd98..56ea5a943a16 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -1424,152 +1424,152 @@ static const struct driver_info hg20f9_info = {
 static const struct usb_device_id	products [] = {
 {
 	// Linksys USB200M
-	USB_DEVICE (0x077b, 0x2226),
-	.driver_info =	(unsigned long) &ax8817x_info,
+	USB_DEVICE(0x077b, 0x2226),
+	.driver_info =	(unsigned long)&ax8817x_info,
 }, {
 	// Netgear FA120
-	USB_DEVICE (0x0846, 0x1040),
-	.driver_info =  (unsigned long) &netgear_fa120_info,
+	USB_DEVICE(0x0846, 0x1040),
+	.driver_info =  (unsigned long)&netgear_fa120_info,
 }, {
 	// DLink DUB-E100
-	USB_DEVICE (0x2001, 0x1a00),
-	.driver_info =  (unsigned long) &dlink_dub_e100_info,
+	USB_DEVICE(0x2001, 0x1a00),
+	.driver_info =  (unsigned long)&dlink_dub_e100_info,
 }, {
 	// Intellinet, ST Lab USB Ethernet
-	USB_DEVICE (0x0b95, 0x1720),
-	.driver_info =  (unsigned long) &ax8817x_info,
+	USB_DEVICE(0x0b95, 0x1720),
+	.driver_info =  (unsigned long)&ax8817x_info,
 }, {
 	// Hawking UF200, TrendNet TU2-ET100
-	USB_DEVICE (0x07b8, 0x420a),
-	.driver_info =  (unsigned long) &hawking_uf200_info,
+	USB_DEVICE(0x07b8, 0x420a),
+	.driver_info =  (unsigned long)&hawking_uf200_info,
 }, {
 	// Billionton Systems, USB2AR
-	USB_DEVICE (0x08dd, 0x90ff),
-	.driver_info =  (unsigned long) &ax8817x_info,
+	USB_DEVICE(0x08dd, 0x90ff),
+	.driver_info =  (unsigned long)&ax8817x_info,
 }, {
 	// Billionton Systems, GUSB2AM-1G-B
 	USB_DEVICE(0x08dd, 0x0114),
-	.driver_info =  (unsigned long) &ax88178_info,
+	.driver_info =  (unsigned long)&ax88178_info,
 }, {
 	// ATEN UC210T
-	USB_DEVICE (0x0557, 0x2009),
-	.driver_info =  (unsigned long) &ax8817x_info,
+	USB_DEVICE(0x0557, 0x2009),
+	.driver_info =  (unsigned long)&ax8817x_info,
 }, {
 	// Buffalo LUA-U2-KTX
-	USB_DEVICE (0x0411, 0x003d),
-	.driver_info =  (unsigned long) &ax8817x_info,
+	USB_DEVICE(0x0411, 0x003d),
+	.driver_info =  (unsigned long)&ax8817x_info,
 }, {
 	// Buffalo LUA-U2-GT 10/100/1000
-	USB_DEVICE (0x0411, 0x006e),
-	.driver_info =  (unsigned long) &ax88178_info,
+	USB_DEVICE(0x0411, 0x006e),
+	.driver_info =  (unsigned long)&ax88178_info,
 }, {
 	// Sitecom LN-029 "USB 2.0 10/100 Ethernet adapter"
-	USB_DEVICE (0x6189, 0x182d),
-	.driver_info =  (unsigned long) &ax8817x_info,
+	USB_DEVICE(0x6189, 0x182d),
+	.driver_info =  (unsigned long)&ax8817x_info,
 }, {
 	// Sitecom LN-031 "USB 2.0 10/100/1000 Ethernet adapter"
-	USB_DEVICE (0x0df6, 0x0056),
-	.driver_info =  (unsigned long) &ax88178_info,
+	USB_DEVICE(0x0df6, 0x0056),
+	.driver_info =  (unsigned long)&ax88178_info,
 }, {
 	// Sitecom LN-028 "USB 2.0 10/100/1000 Ethernet adapter"
-	USB_DEVICE (0x0df6, 0x061c),
-	.driver_info =  (unsigned long) &ax88178_info,
+	USB_DEVICE(0x0df6, 0x061c),
+	.driver_info =  (unsigned long)&ax88178_info,
 }, {
-	// corega FEther USB2-TX
-	USB_DEVICE (0x07aa, 0x0017),
-	.driver_info =  (unsigned long) &ax8817x_info,
+	// Corega FEther USB2-TX
+	USB_DEVICE(0x07aa, 0x0017),
+	.driver_info =  (unsigned long)&ax8817x_info,
 }, {
 	// Surecom EP-1427X-2
-	USB_DEVICE (0x1189, 0x0893),
-	.driver_info = (unsigned long) &ax8817x_info,
+	USB_DEVICE(0x1189, 0x0893),
+	.driver_info = (unsigned long)&ax8817x_info,
 }, {
-	// goodway corp usb gwusb2e
-	USB_DEVICE (0x1631, 0x6200),
-	.driver_info = (unsigned long) &ax8817x_info,
+	// Goodway corp usb gwusb2e
+	USB_DEVICE(0x1631, 0x6200),
+	.driver_info = (unsigned long)&ax8817x_info,
 }, {
 	// JVC MP-PRX1 Port Replicator
-	USB_DEVICE (0x04f1, 0x3008),
-	.driver_info = (unsigned long) &ax8817x_info,
+	USB_DEVICE(0x04f1, 0x3008),
+	.driver_info = (unsigned long)&ax8817x_info,
 }, {
 	// Lenovo U2L100P 10/100
-	USB_DEVICE (0x17ef, 0x7203),
+	USB_DEVICE(0x17ef, 0x7203),
 	.driver_info = (unsigned long)&ax88772b_info,
 }, {
 	// ASIX AX88772B 10/100
-	USB_DEVICE (0x0b95, 0x772b),
-	.driver_info = (unsigned long) &ax88772b_info,
+	USB_DEVICE(0x0b95, 0x772b),
+	.driver_info = (unsigned long)&ax88772b_info,
 }, {
 	// ASIX AX88772 10/100
-	USB_DEVICE (0x0b95, 0x7720),
-	.driver_info = (unsigned long) &ax88772_info,
+	USB_DEVICE(0x0b95, 0x7720),
+	.driver_info = (unsigned long)&ax88772_info,
 }, {
 	// ASIX AX88178 10/100/1000
-	USB_DEVICE (0x0b95, 0x1780),
-	.driver_info = (unsigned long) &ax88178_info,
+	USB_DEVICE(0x0b95, 0x1780),
+	.driver_info = (unsigned long)&ax88178_info,
 }, {
 	// ASIX AX88179A 10/100/1000
 	USB_DEVICE(0x0b95, 0x1790),
 	.driver_info = (unsigned long)&ax88178_info,
 }, {
 	// Logitec LAN-GTJ/U2A
-	USB_DEVICE (0x0789, 0x0160),
-	.driver_info = (unsigned long) &ax88178_info,
+	USB_DEVICE(0x0789, 0x0160),
+	.driver_info = (unsigned long)&ax88178_info,
 }, {
 	// Linksys USB200M Rev 2
-	USB_DEVICE (0x13b1, 0x0018),
-	.driver_info = (unsigned long) &ax88772_info,
+	USB_DEVICE(0x13b1, 0x0018),
+	.driver_info = (unsigned long)&ax88772_info,
 }, {
 	// 0Q0 cable ethernet
-	USB_DEVICE (0x1557, 0x7720),
-	.driver_info = (unsigned long) &ax88772_info,
+	USB_DEVICE(0x1557, 0x7720),
+	.driver_info = (unsigned long)&ax88772_info,
 }, {
 	// DLink DUB-E100 H/W Ver B1
-	USB_DEVICE (0x07d1, 0x3c05),
-	.driver_info = (unsigned long) &ax88772_info,
+	USB_DEVICE(0x07d1, 0x3c05),
+	.driver_info = (unsigned long)&ax88772_info,
 }, {
 	// DLink DUB-E100 H/W Ver B1 Alternate
-	USB_DEVICE (0x2001, 0x3c05),
-	.driver_info = (unsigned long) &ax88772_info,
+	USB_DEVICE(0x2001, 0x3c05),
+	.driver_info = (unsigned long)&ax88772_info,
 }, {
-       // DLink DUB-E100 H/W Ver C1
-       USB_DEVICE (0x2001, 0x1a02),
-       .driver_info = (unsigned long) &ax88772_info,
+	// DLink DUB-E100 H/W Ver C1
+	USB_DEVICE(0x2001, 0x1a02),
+	.driver_info = (unsigned long)&ax88772_info,
 }, {
 	// Linksys USB1000
-	USB_DEVICE (0x1737, 0x0039),
-	.driver_info = (unsigned long) &ax88178_info,
+	USB_DEVICE(0x1737, 0x0039),
+	.driver_info = (unsigned long)&ax88178_info,
 }, {
 	// IO-DATA ETG-US2
-	USB_DEVICE (0x04bb, 0x0930),
-	.driver_info = (unsigned long) &ax88178_info,
+	USB_DEVICE(0x04bb, 0x0930),
+	.driver_info = (unsigned long)&ax88178_info,
 }, {
 	// Belkin F5D5055
 	USB_DEVICE(0x050d, 0x5055),
-	.driver_info = (unsigned long) &ax88178_info,
+	.driver_info = (unsigned long)&ax88178_info,
 }, {
 	// Apple USB Ethernet Adapter
 	USB_DEVICE(0x05ac, 0x1402),
-	.driver_info = (unsigned long) &ax88772_info,
+	.driver_info = (unsigned long)&ax88772_info,
 }, {
 	// Cables-to-Go USB Ethernet Adapter
 	USB_DEVICE(0x0b95, 0x772a),
-	.driver_info = (unsigned long) &ax88772_info,
+	.driver_info = (unsigned long)&ax88772_info,
 }, {
 	// ABOCOM for pci
 	USB_DEVICE(0x14ea, 0xab11),
-	.driver_info = (unsigned long) &ax88178_info,
+	.driver_info = (unsigned long)&ax88178_info,
 }, {
 	// ASIX 88772a
 	USB_DEVICE(0x0db0, 0xa877),
-	.driver_info = (unsigned long) &ax88772_info,
+	.driver_info = (unsigned long)&ax88772_info,
 }, {
 	// Asus USB Ethernet Adapter
-	USB_DEVICE (0x0b95, 0x7e2b),
+	USB_DEVICE(0x0b95, 0x7e2b),
 	.driver_info = (unsigned long)&ax88772b_info,
 }, {
 	/* ASIX 88172a demo board */
 	USB_DEVICE(0x0b95, 0x172a),
-	.driver_info = (unsigned long) &ax88172a_info,
+	.driver_info = (unsigned long)&ax88172a_info,
 }, {
 	/*
 	 * USBLINK HG20F9 "USB 2.0 LAN"
@@ -1577,11 +1577,11 @@ static const struct usb_device_id	products [] = {
 	 * doesn't (yet) conflict with any known Linksys product.
 	 */
 	USB_DEVICE(0x066b, 0x20f9),
-	.driver_info = (unsigned long) &hg20f9_info,
+	.driver_info = (unsigned long)&hg20f9_info,
 }, {
 	// Linux Automation GmbH USB 10Base-T1L
 	USB_DEVICE(0x33f7, 0x0004),
-	.driver_info = (unsigned long) &lxausb_t1l_info,
+	.driver_info = (unsigned long)&lxausb_t1l_info,
 },
 	{ },		// END
 };
-- 
2.34.1


