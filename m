Return-Path: <linux-kernel+bounces-27680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F88782F405
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B7D1F248E7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6881D55A;
	Tue, 16 Jan 2024 18:18:45 +0000 (UTC)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25541CFA4;
	Tue, 16 Jan 2024 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429124; cv=none; b=NOsLDN1adeSl0QdPCBqLEbKCC5HBlmEJ6G1Puejpn92GstetGf2hxjoA0BMDXs9l28CbB5amN1kauDSZLIcFkHY8N5hcPaRD94dbxeOJI39jriyNwEm2mguvJF71hW9zSwLXUNFFs0Pi2ASO39EWDwcg04RXUyFU7sSEP5tzB2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429124; c=relaxed/simple;
	bh=NpVEMfPsAjXA0Q5NZmUdXFnTRx8NQkpb0kNql8FKgPY=;
	h=Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key; b=QsvizGcLKgdpi8GfkEyPzjB86CKlZWmxvN2t6PDWPuZ3KWcO2yjEpmTGWTNBsSrPRnC8jvPUzsFaVySBAiMx/wrBYmlva8CRn0qoqbKEEwZqDPZu72ffQhHj9Xi1UIJSymEffsQH/vwTzEB6erTZh9cqvWx1944dL/kCwY2yy48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.186
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 2D0A98BC9D;
	Tue, 16 Jan 2024 19:18:33 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Subject: [PATCH 0/2] input/navpoint: remove driver
Date: Tue, 16 Jan 2024 19:17:46 +0100
Message-Id: <20240116-navpoint-removal-v1-0-593ae4954a83@skole.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAErIpmUC/x3MTQqAIBBA4avErBN07I+uEi2kphooFQ0JpLsnL
 b/FexkiBaYIY5UhUOLIzhaouoLlMHYnwWsxoMRGKtkJa5J3bG8R6HLJnEIPiO3WDL3WBkrmA23
 8/Mtpft8PN9sIdWIAAAA=
To: Russell King <linux@armlinux.org.uk>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=760;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=NpVEMfPsAjXA0Q5NZmUdXFnTRx8NQkpb0kNql8FKgPY=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlpshZkz/9R+OQ5vnzR/LAP/A7pL9s0mtW/dLiA
 VCg0TBm9eCJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZabIWQAKCRCaEZ6wQi2W
 4b8TD/0dJJ1LG3HJ7h7QT4U6DG+vSrWFIC4CIBK/t9ejmwuYXjPNEpJFXRQdxtZmHTFDeNHGaXL
 uiSkt+YQtahUnaWY1yCovBNzOZXb4GzDkfnjxNPhQ8l6mNEdEhG6QlyW2iGAXXnUtQhELKHcDJM
 sdkz3FIaceCQcN4EwDz/xE85hUT+GunJg93LZdIYDxDj+wA52ZOAerBY2oESh1+HfstYK5IVKVP
 MrsWbC8opeADEz5zDI/xeQWkM7QWzK9wgO5qH89bgtF49Nncf5ZON6iUvW4u2GIFQiQcfw4ogy9
 NXGXUyVNZdsmJNWyz+40MEiZhPj0vMYXmEQn795AJHA8a3qIx6VwgzG5PmrvmsWSI+R81DyaZhP
 m4tZoD3whp11kXIYS+c7x3F/kpFuYf6AwUldvNdrgANwy0uwsjlGM740FtNDoSdPZBX5nlBzYEH
 RXjcjxxSgX8zWas4b3oe1tZiHYUAz/1JuPbZ1h4QBpscVE+/OWumgUINx/mBaEZ+2Hq39bC+AC4
 D9Udj4JQQnG874fhTTShc0/WLumlkSK2Ae6WjV3AQMU9AD+XY35NNpdwXDqBkDEjGKfs9jQExGD
 UgwAjcxP95WYc7fUK3oCNvSnXaVqvEIwM37VXxZ3+KzF0TkgC7kHqs+euu/18PlLSK74XnkhJJb
 4aOkFUvl3syZs+A==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

Hello,

Small series to drop the navpoint driver. The rationale is explained in
the commit message of patch 2/2.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
Duje Mihanović (2):
      ARM: pxa: drop MOUSE_NAVPOINT_PXA27x from defconfig
      input/navpoint: remove driver

 arch/arm/configs/pxa_defconfig |   1 -
 drivers/input/mouse/Kconfig    |  12 --
 drivers/input/mouse/Makefile   |   1 -
 drivers/input/mouse/navpoint.c | 361 -----------------------------------------
 include/linux/input/navpoint.h |   9 -
 5 files changed, 384 deletions(-)
---
base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
change-id: 20240106-navpoint-removal-38225f48733a

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>



