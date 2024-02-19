Return-Path: <linux-kernel+bounces-70739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3094859BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55931C216C2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956ED200AB;
	Mon, 19 Feb 2024 05:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="EiUm+fx9"
Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC731CD15;
	Mon, 19 Feb 2024 05:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708320859; cv=none; b=JI6LXym0YTf3+l4VOgY+7AKYjiyZXO1iaINkpsQVP5yfOpWufKLGiVcHeGl91FU7WBV4RBwImtHMweIrgz3aE9D0Gmts15ZPUBWFPdFTxt5huZxmRBicPvjm+3NywVKQJEgHgwOoFPFYYfeMX7AGmKv5jY+5FOYZJHbTQIHgvxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708320859; c=relaxed/simple;
	bh=vzUamUGP3WLvea5XsN957B186PZ1A28KCupKYCvHJbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=afv56NxiaMKgQbCHj3gDHhwRvOYv6xTVelMTu0O2C5WCrPWQm8gRgZhEg75dqOVBZ635Rkkbr2U6XQaUwPZ6wWyTLa3i9Ut1KsE7lQOwgAhoYLpeH1a4ioxWYXU2XyMyX7a+XjfU/aSUR/WZTZarWiSxadiaEhavoPbCLm4f6qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=EiUm+fx9; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 07E3E9400107;
	Mon, 19 Feb 2024 06:34:16 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id OVd1T5Nxl-jJ; Mon, 19 Feb 2024 06:34:15 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id D617C9400109;
	Mon, 19 Feb 2024 06:34:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com D617C9400109
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1708320855; bh=x6qX/th2i89rUvITb5zg/0LyG7dJqopWpijkvJGJMwQ=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=EiUm+fx9kH4+H4QDSEyyTZYQUbMmt6v6fWdyk1nqgJM32035hsLzk6uHXZoZy2GLr
	 A6U18x5MPf61wrU8Cb7Mkt7HW6G8T9tJI8vnalB5P/rIef7mP+27M5UUV98m1bmtEL
	 lz4+reNxpz1Ya+uObIqh2RrZoFEK747hlNkAaamTr+iOTaLeVSFCZQCKQEsxswRw44
	 AAEmub/UzGZm5bdxPvPgEMC4UzkNP1ynJQorpqpf4a04BAPbpm6NZlkXL6EyhlV1is
	 ApcKsmKqcYLvUJCxRrghR8B2vl9F6tmyMxPcU3vR+1i+TQq/noq8gKbeNghxVEZ14A
	 nP0XYtXMLjEIw==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id oUO-ghJQtDvh; Mon, 19 Feb 2024 06:34:15 +0100 (CET)
Received: from ws-565760.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 7DD119400107;
	Mon, 19 Feb 2024 06:34:15 +0100 (CET)
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
Date: Mon, 19 Feb 2024 06:33:32 +0100
Message-ID: <20240219053413.4732-1-andre.werner@systec-electronic.com>
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
index a530f20ee257..2fa46baa589e 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -2104,6 +2104,11 @@ static const struct usb_device_id products[] =3D {
 		USB_DEVICE(0x0424, 0x9E08),
 		.driver_info =3D (unsigned long) &smsc95xx_info,
 	},
+	{
+		/* SYSTEC USB-SPEmodule1 10BASE-T1L Ethernet Device */
+		USB_DEVICE(0x0878, 0x1400),
+		.driver_info =3D (unsigned long)&smsc95xx_info,
+	},
 	{
 		/* Microchip's EVB-LAN8670-USB 10BASE-T1S Ethernet Device */
 		USB_DEVICE(0x184F, 0x0051),
--=20
2.43.0


