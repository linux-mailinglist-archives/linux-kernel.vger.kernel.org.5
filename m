Return-Path: <linux-kernel+bounces-82248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1722868125
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DEF91F23A34
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93F012FF64;
	Mon, 26 Feb 2024 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="PRXhWHtZ"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E085712FB39;
	Mon, 26 Feb 2024 19:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976198; cv=none; b=A+t4+lO/2Rpm9kIWz/tE2NLHweyHXCUnApTsS5roXAj0LdKcRSRcaVm+qLwlQo1Z/XOlzSfg3e3gzWzTQDZb2Shvp9dXvjexJmGYcM2+qUUhR/BxJ5o5JWLjDhi+nHbO+f0Kr+GsIsktyAW28fR1ymSjBCmegIXlxmu+1pP2xUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976198; c=relaxed/simple;
	bh=0g8oO3mZalsLQAk5UUbbYQntsgQXvTMN7AAaIaAYZDE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t2f6baOGdfGBHOPfurnGJdWwjQmcAhMVEeH1AO/91/KnDHbzf+ezwUspXICc8482ZSCJyygkx76gnD48xPqglXsYqYI57xVPOhP/tJW0OP3XFI0wMnKMPQWAqO6xN4JOepRP/yOvGzVMpQHGWozAmkHZlfZJN889RH1DmmTUvEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=PRXhWHtZ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708976165; x=1709580965; i=w_armin@gmx.de;
	bh=0g8oO3mZalsLQAk5UUbbYQntsgQXvTMN7AAaIaAYZDE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=PRXhWHtZWZC4UtwCXNcZbqwz8kazePWC2v3LpTUZK1QyRcYuanjtqlSaS59jQOcW
	 RK1FO0YfD5MF3FFsSE0kMoLfOltIfTdbvv1kONbjVe1moB3IPPMB5KsnAPCqb/B3v
	 xckAVzyfG1iRQr4eEYWqO6bqd/TEI4tEIbWQbWhFfJK5i8FMY6ofhJo+Z8c3ROdGO
	 syLlR4lPPLPhn7CNZ2PNLwOfIDJMQ8UE6cJKBP1/YJH2kRZWT11/G2JER7JaNYyPj
	 sdq1CYCV194gIL54HV/KMoct9Fj2+I2/li/FXywN15yLWbXeDGZiicCuY0M6Shl+8
	 im4OHWvIXwsDbI4jGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mq2jC-1rAHxf2pSk-00nC39; Mon, 26 Feb 2024 20:36:05 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jithu.joseph@intel.com,
	linux@weissschuh.net,
	pali@kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	Dell.Client.Kernel@dell.com,
	jdelvare@suse.com,
	linux@roeck-us.net,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] platform/x86: wmi: Ignore duplicated GUIDs in legacy matches
Date: Mon, 26 Feb 2024 20:35:55 +0100
Message-Id: <20240226193557.2888-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VDydBzZvOch54Gn/Gprxj7ysOw+8qumP0PAC4sF0AkUOJA7UuVh
 thsbrxwgKZT3rfPFCFyINQWgqp4EAB/8VIHMD0UdQ1qQ+ys3ZNfMOAhVuhgZnTNdFh3q7vv
 2N0ZzV8zXg+pBkXne+4ITY6Ko7leIxWr1ztA+Myg9x0kHLRrxyJBQinfq7SQQbmQjjRJtoG
 nTwrrBGANJPo23aX6yB3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WHoeCtfxej8=;zqdJaHzShJ3dljc+NoDpiSg2ldC
 7FDX3K9NeApx9gDDBt0wck6ATGXCGcgDoUyB89Wcpuj64g06tChlTnLjXW/j97e/EDrrMWNAh
 99E+QY+UaHoLQrasYkDvsPhE8UvN+RnM36M/X1JAdNae8ktWC2MOgrW+n2XksRo88JCBH5m9+
 lvhKa/vO9Rbly1acVpt/LCI6Osz7Jp1f3Z/1oB9HPoh+oTF8TDSAXGs7Ywdg45CUMlSOCzC+g
 0MpwEYItrKQ3NAziYybpVH4Lgcf1DU62G37BHGGwERhGbrnYp7SoOnexd5safVJwueyKNijij
 BGEmVarxoT8GRiG4QebKBzFNzW7P66h75T9khKgDDnn+wVmbBb5NIIbfGFIgc7QQjLA/4J1c8
 sl2aZLXZXjP5tFZENsdsRFT9F7DHRokDf/Fq4jHZit1LBXVjmPmbPSy6kf1CS2zgqOuuOpcbK
 3XMav50Lvt4NnQbq1x/0YTDIXTUktTRoJp+q4v7tjfEwJKjC0XmqzTS1t6MMwHUKxbx5bbKUt
 L1PgxKret82sh7qwOrBIV28oANDAYaUDPNMaM2/IhWC+PcejUJntslYpsDIJDb05oPBY4pP6c
 pE6JKmveB/fEgPwqnc/y23DiS0dYtzomUHk2zs7F43E0CZP3Cxqo0sqB5Bec+yYkSCGaMXSMz
 uJpMhCbcwr00JlOmqTcMWKoU0+B9pxFkGKqyJPghynKoVfzZltcr5JePq5To669a0mhENhYwQ
 tF/rupeQPfz38GiWQaGS0FPxgGaPXTNN18VD8lQU4ZrIjKdupJxT84liakqT5to5wbCKRqNZo
 LLyeMzeW+IDD6760kn67hq6hKLRBXmWo4HNtSTDE20Iw8=

When matching a WMI device to a GUID used by the legacy GUID-based
API, devices with a duplicated GUID should be ignored.

Add an additional WMI device flag signaling that the GUID used by
the WMI device is also used by another WMI device. Ignore such
devices inside the match functions used by the legacy GUID-based API.

Tested on a ASUS Prime B650-Plus.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index abd0183c4107..29dfe52eb802 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -57,6 +57,7 @@ static_assert(__alignof__(struct guid_block) =3D=3D 1);

 enum {	/* wmi_block flags */
 	WMI_READ_TAKES_NO_ARGS,
+	WMI_GUID_DUPLICATED,
 	WMI_NO_EVENT_DATA,
 };

@@ -196,6 +197,12 @@ static int wmidev_match_guid(struct device *dev, cons=
t void *data)
 	struct wmi_block *wblock =3D dev_to_wblock(dev);
 	const guid_t *guid =3D data;

+	/* Legacy GUID-based functions are restricted to only see
+	 * a single WMI device for each GUID.
+	 */
+	if (test_bit(WMI_GUID_DUPLICATED, &wblock->flags))
+		return 0;
+
 	if (guid_equal(guid, &wblock->gblock.guid))
 		return 1;

@@ -207,6 +214,12 @@ static int wmidev_match_notify_id(struct device *dev,=
 const void *data)
 	struct wmi_block *wblock =3D dev_to_wblock(dev);
 	const u32 *notify_id =3D data;

+	/* Legacy GUID-based functions are restricted to only see
+	 * a single WMI device for each GUID.
+	 */
+	if (test_bit(WMI_GUID_DUPLICATED, &wblock->flags))
+		return 0;
+
 	if (wblock->gblock.flags & ACPI_WMI_EVENT && wblock->gblock.notify_id =
=3D=3D *notify_id)
 		return 1;

@@ -1036,10 +1049,12 @@ static int wmi_create_device(struct device *wmi_bu=
s_dev,
 	wblock->dev.dev.parent =3D wmi_bus_dev;

 	count =3D guid_count(&wblock->gblock.guid);
-	if (count)
+	if (count) {
 		dev_set_name(&wblock->dev.dev, "%pUL-%d", &wblock->gblock.guid, count);
-	else
+		set_bit(WMI_GUID_DUPLICATED, &wblock->flags);
+	} else {
 		dev_set_name(&wblock->dev.dev, "%pUL", &wblock->gblock.guid);
+	}

 	device_initialize(&wblock->dev.dev);

=2D-
2.39.2


