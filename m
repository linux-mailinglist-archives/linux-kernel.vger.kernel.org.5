Return-Path: <linux-kernel+bounces-91423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AEA871151
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851AC283F30
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA2E7D3EE;
	Mon,  4 Mar 2024 23:50:10 +0000 (UTC)
Received: from tdksf2.jp.tdk.com (tdksf2.jp.tdk.com [211.16.239.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB69E7CF2B;
	Mon,  4 Mar 2024 23:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.16.239.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709596210; cv=none; b=YQSlaWgK3sDNd6uhXrieZenT3fOAmMnv0ORcjie86IvwMs9y4g8eNxok6ZLCjCcmV20CiCz9cYF/+hubBp62FnkKJww/yMxuCX66LM53mNK5vdM4s9iLSpOKhPAjFBMZr6XnoTROEqizJ3As/uaCWEi0rniJFkWExO6TYxKweG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709596210; c=relaxed/simple;
	bh=gNxB/kEJ2bC3vnX2J88FBXVKDTIphz/mAZSs5thjCvE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RpI6up5qPthfT5yuo6K61mnVTD5HPWD5IAmjX7CKgYYPVZcHxb6CCu9N2zhXEEgp94t6XO5d1qi9K7FBO7vFgB/q9HYPNVM/BxzWM0xt4ZiBVr4entMHMlcTMEPd2vPnETUvXJO1VvcZ3NuUmqMUJX/Be2Iw5QaYVDzKEnvktFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; arc=none smtp.client-ip=211.16.239.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
IronPort-SDR: 44OhpWk1rFBxA2b8OV0aJekNX5f83hbEX6UIEqEvvT7NriKOeSRB+vqFOpD5je9ApTbIMRD1dT
 P2Hk7jACH8Aw==
IronPort-Data: =?us-ascii?q?A9a23=3AUi0n6qCLvHr1ZBVW//Lhw5YqxClBgxIJ4kV8j?=
 =?us-ascii?q?S/XYbTApD0q1DcEz2sXUWjQaaveN2rxeI13Pouw8UIP78TWmodhHQtv/xmBb?=
 =?us-ascii?q?VoT8pOdWo7xwmQcns+qw0aqoHtPt63yV/GbRCwKZi6FzvuSGui5xZVM/fngq?=
 =?us-ascii?q?ovUUIYoCAgoLeNXYHtJZSZYpgIMqtUAbe5VrO+6kYiaT8X3YDdJ0tPvW44ew?=
 =?us-ascii?q?/rrRBhH5JwetN6E12HSa8ynvHeG/5UUJIoPeK/3M3f7BIJTWOyiLwrB5Ojhu?=
 =?us-ascii?q?DqIoVF3TIn9y94XcWVTKlLWFRSJkGd+R6ShxBNFo0Te145hbKpBMhwL0Wvhc?=
 =?us-ascii?q?9dZjY8lWYaLYQMoOLDc3fkGWTFGHCxke65L4rnKJT64q8P750nHdWb8hvZjF?=
 =?us-ascii?q?kc7OaUG9ettR2JD7/oVLHYKdB/rr96x2q/9aeBwj8siNsjDII8c/HpnyFnxA?=
 =?us-ascii?q?uwrTpPDa6HL48JI0jAtgMxHAffZYYweczUHRBbHYxRJElQaEpQzmKGvnHaXT?=
 =?us-ascii?q?tHygDp5voJuuy6KnVI3iv63aIO9RzBDfu0N9m7wm44M1z2R7skmCeGi?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ABu+gf6DZqa53XFjlHels55DYdb4zR+YMi2?=
 =?us-ascii?q?TDtnoBKyC9F/bzqynAppgmPHPP6Qr5O0tPpTn/Asa9qBrnnPYfjLX5Vo3SPz?=
 =?us-ascii?q?UO1lHJEKhSqa/Y6XnLBzfi8OpQzs5bAs9DIey1KWNRyebWiTPIduoI8Z2iy4?=
 =?us-ascii?q?rtoe/fyh5WPGVXQpAlyzxSTj2WGE1uRAVAGPMCZfyhz/sCgwGLPUoQdca2HR?=
 =?us-ascii?q?A+LpH+m+E=3D?=
Received: from unknown (HELO px5f.tdk.co.jp) ([10.196.2.201])
  by tdksf2.jp.tdk.com with ESMTP; 05 Mar 2024 08:48:57 +0900
Received: from toru-VirtualBox.localdomain ([10.132.234.153])
	by px5f.tdk.co.jp (8.14.4/8.14.4) with ESMTP id 424Nmv8F004456;
	Tue, 5 Mar 2024 08:48:57 +0900
Received: by toru-VirtualBox.localdomain (Postfix, from userid 1000)
	id DC01058A2B7; Tue,  5 Mar 2024 08:48:55 +0900 (JST)
From: Toru Katagiri <Toru.Katagiri@tdk.com>
To: johan@kernel.org, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Toru.Katagiri@tdk.com
Subject: [PATCH] USB: serial: cp210x: add pid/vid for TDK NC0110013M and MM0110113M
Date: Tue,  5 Mar 2024 08:46:14 +0900
Message-Id: <20240304234614.3811-1-Toru.Katagiri@tdk.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TDK NC0110013M and MM0110113M have custom USB IDs for CP210x,
so we need to add them to the driver.

Signed-off-by: Toru Katagiri <Toru.Katagiri@tdk.com>
---
 drivers/usb/serial/cp210x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 923e0ed85444..883ed97eb7e6 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -56,6 +56,8 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x0471, 0x066A) }, /* AKTAKOM ACE-1001 cable */
 	{ USB_DEVICE(0x0489, 0xE000) }, /* Pirelli Broadband S.p.A, DP-L10 SIP/GSM Mobile */
 	{ USB_DEVICE(0x0489, 0xE003) }, /* Pirelli Broadband S.p.A, DP-L10 SIP/GSM Mobile */
+	{ USB_DEVICE(0x04BF, 0x1301) }, /* TDK Corporation NC0110013M - Network Controller */
+	{ USB_DEVICE(0x04BF, 0x1303) }, /* TDK Corporation MM0110113M - i3 Micro Module */
 	{ USB_DEVICE(0x0745, 0x1000) }, /* CipherLab USB CCD Barcode Scanner 1000 */
 	{ USB_DEVICE(0x0846, 0x1100) }, /* NetGear Managed Switch M4100 series, M5300 series, M7100 series */
 	{ USB_DEVICE(0x08e6, 0x5501) }, /* Gemalto Prox-PU/CU contactless smartcard reader */
-- 
2.34.1


