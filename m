Return-Path: <linux-kernel+bounces-130695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3D5897BBA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96B828AF8F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BD615531D;
	Wed,  3 Apr 2024 22:41:59 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C131419B3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 22:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712184119; cv=none; b=JhfpgrH1cburpjkujX8MOAgXBRqxXcBes6+EdKKcUIehtaZ59hIhGGqbf2nWY514vRXAxmO4Hvp0YElhsBbOf7e8fx77fihlE9UATdpgTH8zinteVPRMQZr7SUb0oRzGSdcp8268XZ2Ucs5UIWwrhJJIjd5TJ9Nr9K7+eUMoSQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712184119; c=relaxed/simple;
	bh=PuR8Jo9jk2o0K65cEHhrQfsjp+rx/bDqR1i6qoh0MzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B02//6tcsJ3ZN3emP0CddEN4KfBsstwL6kIZEAfEY25Wq0KodkEwFLr6pgWLym3lZx8PZu1yjDzgxC7AkRdO7Dw2AFla3u1WgH9sVW11YVUxB/z+5cWKuNcYgrAE7lTzl59HQ1WXyubGQh+vXpBjNySE+/M1PJKdUE69iNNo8tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 5f4aa124-f20b-11ee-abf4-005056bdd08f;
	Thu, 04 Apr 2024 01:41:55 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jimmy A <jimand04@hotmail.com>
Subject: [PATCH v1 1/1] serial: 8250_pci: Remove redundant PCI IDs
Date: Thu,  4 Apr 2024 01:41:52 +0300
Message-ID: <20240403224152.945099-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver complains that PCI IDs are not needed for some of the LAVA cards:

[    0.297252] serial 0000:04:00.0: Redundant entry in serial pci_table.
[    0.297252] Please send the output of lspci -vv, this
[    0.297252] message (0x1407,0x0120,0x0000,0x0000), the
[    0.297252] manufacturer and name of serial board or
[    0.297252] modem board to <linux-serial@vger.kernel.org>.

Do as suggested.

Reported-by: Jimmy A <jimand04@hotmail.com>
Closes: https://lore.kernel.org/r/VI1P194MB052751BE157EFE9CEAB75725CE362@VI1P194MB0527.EURP194.PROD.OUTLOOK.COM
Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/tty/serial/8250/8250_pci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 400b16c0336cf..40af74b55933c 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -5010,12 +5010,6 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUATRO_B,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_2_115200 },
-	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUATTRO_A,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_2_115200 },
-	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUATTRO_B,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_2_115200 },
 	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_OCTO_A,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_4_460800 },
-- 
2.44.0


