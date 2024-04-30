Return-Path: <linux-kernel+bounces-164336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C87058B7C78
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689DB1F2142B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD8A176FDB;
	Tue, 30 Apr 2024 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="PvvJNeoq"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82361176FB2;
	Tue, 30 Apr 2024 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492945; cv=none; b=LYQOOfdmvJQ8MORYf7aRkZriGxy/j1vfoXahCOBWg7uFDJ28D4TK/7zAFbj1ennJDZx2Boe61AJVfabCPIvB9zSQrlblLUqK5HmoWliI5rxc+B0OFNeDHzkPn/gwiYXXTlICilQVTwEzbOYw8MEO8W/9guGPp0ebBsFvWtSmgYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492945; c=relaxed/simple;
	bh=1XpWqYY6FpW+nYEyvngkH/20vtybIC+9kZBc7rpJxEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eDXpUdpInxnF8cMRvlryoI5fsEczQ5sMjIZ7Ioyt8bpg9TAVrx3Ph2jvqnKOnO25vBkULXRgwtlYmdJeuUCM0/SlTZ91UtOuA3IkN6lljGHyvDGbDcK37NalsyNs+MPxGgt/520zWLnQWlg+s9f/gxiRu5pMuwMAOimB2ycC0f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=PvvJNeoq reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 5ee6a7844c993097; Tue, 30 Apr 2024 18:02:21 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0C26D66E643;
	Tue, 30 Apr 2024 18:02:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1714492941;
	bh=1XpWqYY6FpW+nYEyvngkH/20vtybIC+9kZBc7rpJxEQ=;
	h=From:To:Cc:Subject:Date;
	b=PvvJNeoqYzENUZZBlwJRp3Cfq4aS+BRbWjHBDUy5YY4y9RrtqIZa0z+yNDSEhlRTj
	 d7I8TD6HdT1YWcstC8wrNPWmOkMQSrh7/NYT/ZwDxsGvAjzR+MTxz0P2wolkz898g5
	 zDS2KV+vBTVbss87RlEgE90Q+jfMTKI4NVV8POA7c9g0wtNpoRYZdob1UJSILVEuUg
	 zS49eOK7OzVIiTxMylPM+wp6wU93ILEqIcvvC1Zl1IYX3wXvvOxh42AF7HOsFe9877
	 vkzvUMoY67EIh5FtDHc2RqXGttCWiasihhR9ADDXlseX1nVuoeRPkFByaNgVuHk4PT
	 On7dgcmqT4xdw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Salil Mehta <salil.mehta@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v2] ACPI: scan: Avoid enumerating devices with clearly invalid _STA
 values
Date: Tue, 30 Apr 2024 18:02:20 +0200
Message-ID: <12427278.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedgleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepueeugffhuddtueeiledukeeileffieetudfhuedtfeejgefhveeigeegleettedvnecuffhomhgrihhnpehuvghfihdrohhrghdpkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghlihhlrdhmvghhthgrsehhuhgrfigvihdrtghomhdprhgtphhtthhopehjohhnrght
 hhgrnhdrtggrmhgvrhhonheshhhurgifvghirdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---

v1 -> v2:
   * Fix a confusing comment.
   * Add R-by from Jonathan (thank you!)

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
+		 * The status is clearly invalid, so clear the functional bit as
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




