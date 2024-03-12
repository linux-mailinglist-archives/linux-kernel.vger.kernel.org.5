Return-Path: <linux-kernel+bounces-99890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B944E878ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D77C1F214BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CFB4205A;
	Tue, 12 Mar 2024 06:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAvnY2j1"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F30BE7D;
	Tue, 12 Mar 2024 06:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710224963; cv=none; b=ishCshaQNPNPoQxC2vGCQ/R29OnOs1XK4AdqSlUAdaQ2tG5y2/mz2U8l8unSru/x8UoLK7pJBxUfj3H1s4Tz1Fo4lO2bY8Rebh0qF5Zj6FbUrFBUeEONuP6srhHX9JQlXV+VXgBmBmOkgMtLsRBxjNgvwrb4Whxfcr9yGFHxNTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710224963; c=relaxed/simple;
	bh=QoqZYy9lPfVpRgnuVW0vZgmrFe4O5UM+4bXUCtEpTg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TrO9WS15RzNApSJqYqFQQVNw7Gz9cSD6EA+SJ4y81IrgLaCc+ql9lLrN+34LjyAgrDGxg3Q5PeSZWTVNfD/6o+pYm4AWbiIRc+jdfvA+ZVHYxPHxBRoi3QaO8QiLbPP2i3NWfDYkuyYzRUapJHNSEU6rCY9QL6RX1a6QNsU/Zzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAvnY2j1; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e649a2548cso3536769b3a.3;
        Mon, 11 Mar 2024 23:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710224961; x=1710829761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pWqbglYQGjvnglnnweQhZidIduJU/3ZkKBz6DYUqscE=;
        b=BAvnY2j1oKGSE/HLMd1Qj8RLQOuJW8AfIbmmFlDNfdw824iPsxllAUNF5qnQCxqevO
         qioLfMsmGF0rnow2g/O23Yv84eB/d//GgXukB9VUyEBVzUY9/JDQoGqyrTOTPmivcnAJ
         IzIIPrM2AHrNq7nPjyRy6uow3KVfuCd1JGO3cZ0n3hkoXNnmvv9IxTVA4boC/COL756z
         ANAGxxM9ab3zLqCCmG+K1olL+MRS6Cb2LaocHEWI9TVV6kUEtWjHM+zmvAb7VhJp6Ad2
         r/cS4tCoyW6GQPlsHnDkZ9Mm21IlBET99oEJGZQcO2fNuRERwdv1965mGDStAOaqMwSy
         GX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710224961; x=1710829761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pWqbglYQGjvnglnnweQhZidIduJU/3ZkKBz6DYUqscE=;
        b=bEgaypEPcaDMd7rfwGvPzaOGSzWE3RRk7WUM9gIdf9n1tDgYmkEDecUMMMNSJl7TXf
         jtjBFjazEagplHtvNi7AKvZ/15JBdAlVW/zNAIkjkgwv4Zy/Ah0IpFfZO8Xb0QXTMxe4
         nMcEZnDvTMhGJQK6PhhERt5MzOg9mjCeygkSS0AV7nfjHrySE/5lcYN9xe7XhMjOIgd2
         rRb6LH+MMdPEQ7EZhEx0phyLZzmx4BJXAdPJohwtGyFWLPqsNOGztO+3fWmdItUOZhU0
         +Cs2wyKRdkpXvLX/mm4hZ4DLZ7xyZjf8LcisCWl+gsv5VCXJzmuDkYwI/t1jsN2P/zp+
         j9kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx0kKDWP0dd6iztWkB8PSlHyA2yPPfQ//3D3FkYJBmOueNml4ZBTlcDIHEhUthzXj4KBGk4D0mRNrqDA1NIv0DT46SPDsVV7ybQFZ4lzWQ0RiiOSOQWvXgIhuyzmonf/BlnKDuFxJ1EOSBj0q2WKMuzZPEeJ5Dg8jlLj7rRIMQ
X-Gm-Message-State: AOJu0YxFYj/7qkMkbhtGJVo7llLU+TP1xJ9XbGjA1I9deRLbrU048jRH
	MaPEfx1qQvmMHOv9C5UaRPyVT9l4BqNL6JUTkaJd6Ag6f893Zfzg
X-Google-Smtp-Source: AGHT+IFxUymmrhttXmQOFbKXQ015dVs+uZ7Vq1h3E1+dxY/w/pmG5TZyaOSqoRAkGgbiu6lAZn0ZmA==
X-Received: by 2002:a05:6a00:1944:b0:6e5:89f3:298b with SMTP id s4-20020a056a00194400b006e589f3298bmr12854131pfk.13.1710224961050;
        Mon, 11 Mar 2024 23:29:21 -0700 (PDT)
Received: from guoguo-thinkbook.lan ([2a09:bac5:1efd:16d2::246:a0])
        by smtp.gmail.com with ESMTPSA id o2-20020a629a02000000b006e5736e9e46sm5593292pfe.42.2024.03.11.23.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 23:29:20 -0700 (PDT)
From: Chuanhong Guo <gch981213@gmail.com>
To: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chuanhong Guo <gch981213@gmail.com>,
	stable@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] USB: serial: option: add support for Fibocom FM650/FG650
Date: Tue, 12 Mar 2024 14:29:12 +0800
Message-ID: <20240312062913.12723-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fibocom FM650/FG650 are 5G modems with ECM/NCM/RNDIS/MBIM modes.
This patch adds support to all 4 modes.

usb-devices output for all modes:

ECM:
T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  5 Spd=5000 MxCh= 0
D:  Ver= 3.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
P:  Vendor=2cb7 ProdID=0a04 Rev=04.04
S:  Manufacturer=Fibocom Wireless Inc.
S:  Product=FG650 Module
S:  SerialNumber=0123456789ABCDEF
C:  #Ifs= 5 Cfg#= 1 Atr=c0 MxPwr=504mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=06 Prot=00 Driver=cdc_ether
E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
E:  Ad=01(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=84(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms

NCM:
T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  6 Spd=5000 MxCh= 0
D:  Ver= 3.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
P:  Vendor=2cb7 ProdID=0a05 Rev=04.04
S:  Manufacturer=Fibocom Wireless Inc.
S:  Product=FG650 Module
S:  SerialNumber=0123456789ABCDEF
C:  #Ifs= 6 Cfg#= 1 Atr=c0 MxPwr=504mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0d Prot=00 Driver=cdc_ncm
E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=01 Driver=cdc_ncm
E:  Ad=01(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=84(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=05(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=86(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms

RNDIS:
T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  4 Spd=5000 MxCh= 0
D:  Ver= 3.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
P:  Vendor=2cb7 ProdID=0a06 Rev=04.04
S:  Manufacturer=Fibocom Wireless Inc.
S:  Product=FG650 Module
S:  SerialNumber=0123456789ABCDEF
C:  #Ifs= 6 Cfg#= 1 Atr=c0 MxPwr=504mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=e0(wlcon) Sub=01 Prot=03 Driver=rndis_host
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
E:  Ad=01(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=84(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=05(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=86(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms

MBIM:
T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  7 Spd=5000 MxCh= 0
D:  Ver= 3.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
P:  Vendor=2cb7 ProdID=0a07 Rev=04.04
S:  Manufacturer=Fibocom Wireless Inc.
S:  Product=FG650 Module
S:  SerialNumber=0123456789ABCDEF
C:  #Ifs= 6 Cfg#= 1 Atr=c0 MxPwr=504mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
E:  Ad=01(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=84(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=05(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=86(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/usb/serial/option.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 55a65d941ccb..964d3fffa545 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2277,6 +2277,10 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a3, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a4, 0xff),			/* Fibocom FM101-GL (laptop MBIM) */
 	  .driver_info = RSVD(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0a04, 0xff) },			/* Fibocom FM650-CN (ECM mode) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0a05, 0xff) },			/* Fibocom FM650-CN (NCM mode) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0a06, 0xff) },			/* Fibocom FM650-CN (RNDIS mode) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0a07, 0xff) },			/* Fibocom FM650-CN (MBIM mode) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2df3, 0x9d03, 0xff) },			/* LongSung M5710 */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */
-- 
2.44.0


