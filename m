Return-Path: <linux-kernel+bounces-65283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20727854A92
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A5B1C26E00
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA11F54BCF;
	Wed, 14 Feb 2024 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="R9gRfktJ"
Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF0E54673;
	Wed, 14 Feb 2024 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707917674; cv=none; b=kdzaYAH1NoEuaHLZSXDVXBqpjZea6DL6NjnzGW30cP14ZGOu6fIaxmKsA6Lx82CYpUkSkvvv35BiBs4GkhxZgs1tDlHxJ1BoTQEeJsZGOijGcS8slO3IkiO2lUhYk3t8vtz7M7HipTOAi8sQiV9+YZ+Xmvkl/vF8N2WHRs5KbJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707917674; c=relaxed/simple;
	bh=KhJWijdD+8bkUZJ+O/XoQfTsdzvUphRJ1CzBA4p1eBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PDhkg0K+UKdb2rwJgbH2j8AizYG1zVvt+7m7LU8npwppLDMjTk3iUf5eIxXfCOvCEDfWTt30Ah039TZJmk5aad7RAL3Hz30HuMsRUKhOZb4hSZRbH3D8hsH7nBrCHdS20PwG3vf9br0uU6lfp4Uar8Rf00RBfsVTN8zrDF8JK4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=R9gRfktJ; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 7F34F940010D;
	Wed, 14 Feb 2024 14:25:32 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id S3te8OplpbRY; Wed, 14 Feb 2024 14:25:32 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 547AE9400115;
	Wed, 14 Feb 2024 14:25:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 547AE9400115
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1707917132; bh=SB9gUP4B3cFgEKKjgiQRSSTPQoKGv/D855xgKNgmWR8=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=R9gRfktJpIhAcnTjvaKDb8tQTldck+pIgTD5EybwhQzdMWRw2L3n5aJf9NCgE0hj7
	 m1FC24NyR/zqM4ts2yd4mZkQtn6ONQbIqeWa18aksWAMdH6c/IA4eT/rTRvLavwTnJ
	 DHQ2wncl8NSN8UHaAaQQu11II5vHremvEUPLYS4aO6ww/RFjgIbtPxDpChI0/hS8jP
	 bYW+R0B+rmaLYH+LCHEV0mhxhbIJFJR1j+G4mYarPpda46UjwJaYOzq2NoYBd3cTL1
	 LRoUbg2NREO5jTxqRGNS0NoHjc/WWYiOA+GrAIukVk7CDtr+60fJq2HLFL6sXCUf2f
	 Arkwx2tuAUDQA==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id NXURZRmmlb0Q; Wed, 14 Feb 2024 14:25:32 +0100 (CET)
Received: from ws-565760.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id E87DA940010D;
	Wed, 14 Feb 2024 14:25:31 +0100 (CET)
From: Andre Werner <andre.werner@systec-electronic.com>
To: steve.glendinning@shawell.net,
	UNGLinuxDriver@microchip.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel.krueger@systec-electronic.com,
	Andre Werner <andre.werner@systec-electronic.com>
Subject: [PATCH net-next] net: smsc95xx: add support for SYS TEC USB-SPEmodule1
Date: Wed, 14 Feb 2024 14:25:07 +0100
Message-ID: <20240214132507.28072-1-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds support for the SYS TEC USB-SPEmodule1 10Base-T1L
ethernet device to the existing smsc95xx driver by adding the new
USB VID/PID pair.

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
---
 drivers/net/usb/smsc95xx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index a530f20ee257..bb4e62a93d96 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -2109,6 +2109,11 @@ static const struct usb_device_id products[] =3D {
 		USB_DEVICE(0x184F, 0x0051),
 		.driver_info =3D (unsigned long)&smsc95xx_info,
 	},
+	{
+		/* SYSTEC USB-SPEmodule1 10BASE-T1L Ethernet Device */
+		USB_DEVICE(0x0878, 0x1400),
+		.driver_info =3D (unsigned long)&smsc95xx_info,
+	},
 	{ },		/* END */
 };
 MODULE_DEVICE_TABLE(usb, products);
--=20
2.43.0


