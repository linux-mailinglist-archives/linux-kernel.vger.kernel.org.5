Return-Path: <linux-kernel+bounces-160416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1322F8B3D49
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451291C23DC8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2D3159594;
	Fri, 26 Apr 2024 16:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="HUQzo9IY"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0E713D2AC;
	Fri, 26 Apr 2024 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150593; cv=none; b=ZKdH0f+5GcQpxnl2CJc01a+Pg4/ortMcdLz0vZ3mZ5M12NJIIfsOucvcahvGcLfFkxdjtpXzDM4xwoltNL4+prEmZJPiIK5MUH8VL+kOwhFmC+7OfvbtDrcVvQmu2mmP/RubzdWDCUTVvP3UW1U6eO0BKmxXAxnnRVodstLZpOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150593; c=relaxed/simple;
	bh=2CBCeqVlaVwCRJppC6SrANWKUwwDmqsGemGxcgfUpcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Twqg6Db8nJwhqLOCwkFAhhOFYU/isJGTw4tPNWWpiUhwDL8lokN1nTXJEyd8o2AUAl5DX2XWRJA5VE/U/U2VlOrCusFOJmWeqosMwmYy10NfWkToHyWBHD253EluaXOgEfhlIersPU2c8MNQu3I5K8MSmQQA5hSQ8Fyi663m1UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=HUQzo9IY reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 5e71bb44f59ac11c; Fri, 26 Apr 2024 18:56:21 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 44FDC66E0B3;
	Fri, 26 Apr 2024 18:56:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1714150581;
	bh=2CBCeqVlaVwCRJppC6SrANWKUwwDmqsGemGxcgfUpcQ=;
	h=From:To:Cc:Subject:Date;
	b=HUQzo9IY+PrGCQP90idBk+kegZmJ0UchoCL8fLdyVsSPr1/do8ciUYMQ+baoiBgVb
	 qaDTBsbRPUQ8jaDPp/eL4qDtml39SxSPJnglsdV01uS/P9KreXqsg0RB7KWlCHAhDA
	 FQPLH2BO5Rf7WMhRjymVlLNi/cwDFJ7ld8+RRepNv4Sqq8Igmmbl7sqfQJocgdsY3/
	 EuiIhIp+bv1kWvBePUaAMPjoLToHbssGlvjEe7CZUhmf7qT9dSu2/FzIqhB/IA+bNs
	 KoFa+sBbDL/M9UZ15XP2k+j3UR7Q8KHZc8mglQ07/XuI3OlVOEZlf0RhyM2RIfl+ZH
	 egBOEzjN9xTpw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Salil Mehta <salil.mehta@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject:
 [PATCH v1] ACPI: scan: Avoid enumerating devices with clearly invalid _STA
 values
Date: Fri, 26 Apr 2024 18:56:21 +0200
Message-ID: <2741433.mvXUDI8C0e@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudelledguddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeeuuefghfdutdeuieeludekieelffeiteduhfeutdefjeeghfevieeggeelteetvdenucffohhmrghinhepuhgvfhhirdhorhhgpdhkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrlhhilhdrmhgvhhhtrgeshhhurgifvghirdgtohhmpdhrtghpthhtohepjhhonhgr
 thhhrghnrdgtrghmvghrohhnsehhuhgrfigvihdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The return value of _STA with the "present" bit unset and the "enabled"
bit set is clearly invalid as per the ACPI specification, Section 6.3.7
"_STA (Device Status)", so make the ACPI device enumeration code
disregard devices with such _STA return values.

Also, because this implies that status.enabled will only be set if
status.present is set too, acpi_device_is_enabled() can be modified
to simply return the value of the former.

Link: https://uefi.org/specs/ACPI/6.5/06_Device_Configuration.html#sta-device-status
Link: https://lore.kernel.org/linux-acpi/88179311a503493099028c12ca37d430@huawei.com/
Suggested-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/bus.c  |   11 +++++++++++
 drivers/acpi/scan.c |    2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/bus.c
===================================================================
--- linux-pm.orig/drivers/acpi/bus.c
+++ linux-pm/drivers/acpi/bus.c
@@ -112,6 +112,17 @@ int acpi_bus_get_status(struct acpi_devi
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
+	if (!device->status.present && device->status.enabled) {
+		pr_info(FW_BUG "Device [%s] status [%08x]: not present and enabled\n",
+			device->pnp.bus_id, (u32)sta);
+		device->status.enabled = 0;
+		/*
+		 * The status is clearly invalid, so clear the enabled bit as
+		 * well to avoid attempting to use the device.
+		 */
+		device->status.functional = 0;
+	}
+
 	acpi_set_device_status(device, sta);
 
 	if (device->status.functional && !device->status.present) {
Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1962,7 +1962,7 @@ bool acpi_device_is_present(const struct
 
 bool acpi_device_is_enabled(const struct acpi_device *adev)
 {
-	return adev->status.present && adev->status.enabled;
+	return adev->status.enabled;
 }
 
 static bool acpi_scan_handler_matching(struct acpi_scan_handler *handler,




