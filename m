Return-Path: <linux-kernel+bounces-70737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6EE859BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BAA81C20E0D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD8C1F958;
	Mon, 19 Feb 2024 05:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="WwvedV/8"
Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEF4200A5;
	Mon, 19 Feb 2024 05:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708320385; cv=none; b=OyJqsTBZXhlR2DF2kDcUlvJ3PCpj9nggJ+zI4wICFVqsfN4N7aNuDbUFyI6GEuYJvmmRzOGvTfT9lx7iekwk/k1XLJ8iwqijcEyCf/VoXtzJY7T6Tid/V/XsqkuFNSRX+/z6E7hgyKd6bddQ2IYhPcJKLZ4OZcxd5Buq7lj83Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708320385; c=relaxed/simple;
	bh=Hf7mqXhNlzUUxeHMeoZI+WsoQoEFtb7ECbEnhFBLf1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C7bfFdrpRxYCw9dJ7JRtbBIeiVXAe5yE+pmCs5cna3/QGbsqgKwN3oyDjpinOkUFUgJNPS9ky2ITACUVGBppT+/awpIv1J1BQik5I7eSp77ZQ/qHa5nnqGHZpCBNuD4aVKKAGMy1VjH/g4513iTRn1jvc7Zhuw6v7Zr6h7D45O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=WwvedV/8; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 7BB989400107;
	Mon, 19 Feb 2024 06:26:12 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id tXBnMA295uNL; Mon, 19 Feb 2024 06:26:12 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 47B7D9400109;
	Mon, 19 Feb 2024 06:26:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 47B7D9400109
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1708320372; bh=3Ewc8dAHVNPMC1w5d5Us9H7cSl8PtD+Xligfbli6chk=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=WwvedV/84bG/3dFvq2tOKWIHhjhplL+1QE+FRET709SXkmWrnL6KLsXZbHy+d/k7L
	 Rwkq+duiNnrAH+YhfvexzK9fnrF/jmI5AftS3SUAZy3xFUGa0lawW6BG/6CDLYLIt8
	 0+IRothKCY5HLPf9QXAQNFS3O8A09/zNWAfeMOKkoWTrynPqtI9zv02BlaS+BLPB9c
	 a0356UpqVlkKnRjvd7ZUycEhDWPOyIj7eD4FQsB+/oz1WAjMEFaZPTdhqrMe2UEYba
	 1ET+1puf6/FyPt+g8EnT2TE58hXMTiUOwIB7S/SLsj28P7jY/YwH+QDZbP3W783bGZ
	 5s0lZl5VXKWwg==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id fniezTr3ixvC; Mon, 19 Feb 2024 06:26:12 +0100 (CET)
Received: from ws-565760.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id E45139400107;
	Mon, 19 Feb 2024 06:26:11 +0100 (CET)
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
Subject: [PATCH net-next v2] net: smsc95xx: add support for SYS TEC USB-SPEmodule1
Date: Mon, 19 Feb 2024 06:25:16 +0100
Message-ID: <20240219052609.3317-1-andre.werner@systec-electronic.com>
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
v2:
- Sort new USB_DEVICE entry by VID and swap with previous entry.
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


