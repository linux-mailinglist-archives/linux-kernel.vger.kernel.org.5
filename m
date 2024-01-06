Return-Path: <linux-kernel+bounces-18735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BB08261FF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 23:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 658ACB21ADB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 22:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B251101DB;
	Sat,  6 Jan 2024 22:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="JXbv8KoV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAF610787;
	Sat,  6 Jan 2024 22:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1704580892; x=1705185692; i=w_armin@gmx.de;
	bh=rGKAWbb6mv2MvQvmMWvtbAEkan0WCklL9CFLbJgURSI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=JXbv8KoV6cRdOCWdJmGOV0tksVZtgXKGpfZBvXpliALP9wg093yY64mq9Gc7ryhj
	 TF7zOW/cZXWkidd7DirmpII+WfbJ1BhDkLGt9q9xzoph8caOPxpEv8J7/1e6zW1TS
	 wG7OGEwX6RB5Ir3pjQJ2SNAY//R0mfaQZzFQZeT49aD/p2Dm1zaU97N+3RzXQ4/eo
	 +2KCRp5FDn/yRtbtEUTi5hI3Dpq5xYXsrCdv4uwKdPRkFwzmMN4CfWy+QtLWdCq9C
	 feaer1YS94zTpijlG0hb1OLB70e1O3IfGa/YnFuYraLUe3KNmv8bgC+wirYQKyPnI
	 97VIwIMtg9UZd+KZZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MryXH-1qs9Gw3kCj-00o2HB; Sat, 06 Jan 2024 23:41:31 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jithu.joseph@intel.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: intel-wmi-sbl-fw-update: Fix function name in error message
Date: Sat,  6 Jan 2024 23:41:26 +0100
Message-Id: <20240106224126.13803-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9BAjZBJl7gR/XFYztgEXLa6G4yMtLMv9Q46uL/pXEy7hTNGA7OL
 Wivy3wxyhqoFKWVaR7/pXFA3K4h1l05ROcwER5BqLHdgb5/tVnxfXkx69JjYsERxa6QALTF
 zLIVbgoNPIPT8byt5SZvND5spdVR9CnCrc5DtvyCqrwg1dnxg3OFSZKnpA/DvIqYzrj6c19
 jmE4CdTtUFdYVky/1mWKg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aFw9eUN7Bts=;YG58MA7+Rok80yWchiFPjYdyWOR
 dx+94u7v0av3NUoUFSqk3yNzdx7QRK1P1WcQghmXk6w+RMZgUH9fqAlzYQb3X2V5FCYVLMyBK
 vrTZ1VlI3+xLGLjazHvSz8t6t8lSGWCD5dMV69PEsERj24WtSH2NsrSXIqq/mfSzegOC4kL7I
 P4ZnBaEyuh0826XtGNvxRhfVY2npG6h/mJttJQ69J4ALx7VfQ7gJ4x8bOaQ/bZoog3lX/1Ll1
 5VaD2wGuu9pRYyK2bQmlCGLILuXiBwp1URZscKj35qKoOprttpZ+iMQaHEeBU51UIE2bXj+fu
 DaZUMLuhT2AnQXwmQyile82stB65+6EbNT7NwOx/g8cXa2ZmWT+DYwZt4fWQPl/CCv61ioHCe
 4+Lo+Zbk643RRLBAgbXGNmNkKZlR64019le/RyJdwyCwC+nz1onT8rhF7HDRBGf2DsgBkUgqh
 uMJCArT2Axn4bZ6v1fjke8Cml9EUcY/G6jNMU9jGVdImkQLVIThISZiVDZprl5aAV6TT+w9A4
 0p+NPoUiRw7hO7rwRuu3ohm9abU8nb3ZmBVuLWsbIUQU2Hf+Brh6y9aEb+0RH0LdUdojp7R71
 wfQVgjUGmgL+HjnGB5UQfnb03PhvfzUVMs0Ounl3u8k9UuRl7gPGsom9XBFIc08WSX688PhAn
 E2SnT2jXPhIxS4niPSNFNHfS2M+Y54Fz5S6QISUgmBKjJ4Pi0E/+zmQvtL18m3Arllt29nIa3
 IbdA6Xp1PWlyJz3/HEpUGxWN4LW3KMtoD9AJ6ovwWodO/3RGFnOCGdh2Bekfo9G8Gk0+8qOFy
 CimrnSzQaXXNhYJYMMRf8Nt0Xnjj3YEVGXNwX8kEaNa7Oe+AWRyPEtoftFu6c75ooiDRQ7tfc
 BlU3CvaO/6uDPi9WRZZ5lCQsYOt5xw9IrA+kSfeG1PVq2Zhch0F7Qakwjm6fXhKN57QKZlIDV
 SRxV0DYZL6jUnym1hY4QLhGdSw8=

Since when the driver was converted to use the bus-based WMI
interface, the old GUID-based WMI functions are not used anymore.
Update the error message to avoid confusing users.

Compile-tested only.

Fixes: 75c487fcb69c ("platform/x86: intel-wmi-sbl-fw-update: Use bus-based=
 WMI interface")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/intel/wmi/sbl-fw-update.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/wmi/sbl-fw-update.c b/drivers/plat=
form/x86/intel/wmi/sbl-fw-update.c
index 9cf5ed0f8dc2..040153ad67c1 100644
=2D-- a/drivers/platform/x86/intel/wmi/sbl-fw-update.c
+++ b/drivers/platform/x86/intel/wmi/sbl-fw-update.c
@@ -32,7 +32,7 @@ static int get_fwu_request(struct device *dev, u32 *out)
 		return -ENODEV;

 	if (obj->type !=3D ACPI_TYPE_INTEGER) {
-		dev_warn(dev, "wmi_query_block returned invalid value\n");
+		dev_warn(dev, "wmidev_block_query returned invalid value\n");
 		kfree(obj);
 		return -EINVAL;
 	}
@@ -55,7 +55,7 @@ static int set_fwu_request(struct device *dev, u32 in)

 	status =3D wmidev_block_set(to_wmi_device(dev), 0, &input);
 	if (ACPI_FAILURE(status)) {
-		dev_err(dev, "wmi_set_block failed\n");
+		dev_err(dev, "wmidev_block_set failed\n");
 		return -ENODEV;
 	}

=2D-
2.39.2


