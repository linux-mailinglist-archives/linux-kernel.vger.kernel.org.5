Return-Path: <linux-kernel+bounces-130771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089C2897CEC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0EB1C2149A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BF218C38;
	Thu,  4 Apr 2024 00:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="A4qjjqs2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DEwphbKy"
Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122AF1803E;
	Thu,  4 Apr 2024 00:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712189856; cv=none; b=tC5CQDB0vHD6IyeLjmGQr68pt68PA/BY9GOdR0VIKMc25gTy6hfMLx8vGqSowjat6nt2D1Iv/UzbOIOxZcFSbCWTGp2A4ATdMCnE19PpPN36ySPaSNZ8aMlXSQTFOOk5WiXXU2xeOS8bOBQKhkn+qC3DfU5Wha58CbgJA25gYH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712189856; c=relaxed/simple;
	bh=4dW61Zig4zT7R6fjqVWWAri0VvDtQDJzyzbMJqLhgt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZeNP16kdZlaVBAnv55CvanhR/E/XdyxzcbZRWDE6pK+rLS4VNX8HgcVyXmuM5CoQj7u7lsMRibXsU9C4ImmXcGs+WR8yfeyCrVvYGZ85N3flG55Wq6JQNkXii4GrUdUvsZnNDPu9PAxG5/JZFXzFF+THuihGDDI5Z93QW7rMvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=A4qjjqs2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DEwphbKy; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id DAB7C1C000F7;
	Wed,  3 Apr 2024 20:17:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 03 Apr 2024 20:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1712189853;
	 x=1712276253; bh=SZxOjOhPVblOzmiWhEFz3xhjvExM3YdMig0MEady1SQ=; b=
	A4qjjqs2z79MdL1/+nEIJ9zYcfQhUgaIUHja24q0v1C1mXmO89iODqoBQrqXA6yW
	UePhLiDu9ec73jg8iEj84TzHkXJJlEyzPyXbYxtxt6ANgM8ArCnEDMt75kQpex0J
	GdwoI1RAoko5lZ/krdBJ3NHqf4NDHR3XwltFVwG+V/2xb1IarPyk91XuuWaJVeTv
	qh+fH/nxrxNO/oTE0Um/wJQRkMo+B7rugemhnRaQoy6dy21YFRPtBU+pbM7Vrs77
	Ml0qRj+AIXFzll5wrrYXnZ9S+J+G4KFqCnVkjyqKlT4pbfwe2rV4o7xb6qS9pJso
	J7qR09A6N31jdKAQhvG7vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712189853; x=
	1712276253; bh=SZxOjOhPVblOzmiWhEFz3xhjvExM3YdMig0MEady1SQ=; b=D
	EwphbKy9KWelqsn+5GQCk2l6ncyz93Iy4V2Y0xyR0HXVvufo2QFUq6ittRWxbu6o
	I1HUKTYu3h5npzLV1C5fVpQoM1tKL7Zmx2Tlg1LYJhI5ULh4mtRWXDB4PccHbWvA
	k9zgVXXMf5yMYzeGzt6tb/p2deSdcDcG1aytlsJiievLK3hVfIJvwMwDRPU9y+sD
	0NJVze4Urcdq/nsLsMfQuxweP2Unls/Atkh4CcgrYnGmxKZokZyvTukWGHdUPyKl
	EoOd5DsBBT9u+bw6j2QjCwOj+fBMN4poEhYkL0ERrG1d9YiNzEeWqTU2AnTV6Tj3
	MQNnAtEniwn0A8BnbPPMQ==
X-ME-Sender: <xms:nfENZpPv5IndY7d8MLzVdqyE3-d5xlPztwLejCewqDv33J9KRtyeDQ>
    <xme:nfENZr8vMgNbUBVE3jG9pelDQiMPN5sKhV3bb8JQL8vopp7REUcAyMOW_6u2FeU4j
    Rx_ATV_Dm6NJ2GwiZI>
X-ME-Received: <xmr:nfENZoRGuBAnv2Zu3jQTzeMRfiv2gmSnx0JP2icOiByVWUdihXEg17q4cDs->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvges
    lhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpeduudetudehiedvvdevveelhf
    egkeefffdvfeetuefgveefgffgffeiffeitdelieenucevlhhushhtvghrufhiiigvpedu
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:nfENZlsKZGy_qKrGU76zp_NUBw0mz0a8NgWYj_k7-jv4sGcolnLCVg>
    <xmx:nfENZhfvDbq0XHvirrdcfIlI57X4rWzNFu_smgkXzBwgpHWgc8XR2g>
    <xmx:nfENZh0T2Jjn2q4GxpZ2vpCXujGt8JwvHS0lAZk_dqXXhSP7r7Yf-A>
    <xmx:nfENZt_ChWx0NncMkxiGpYjEFtCdaC0ysAt5v9m6h9Qd4Kk-gG3wIw>
    <xmx:nfENZpRfCScLXjVbS7S-lK-ktlFGQ1G33j-B-6gUxCW-lOYRXzFTkmZg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 20:17:30 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v4 7/9] platform/x86: asus-wmi: ROG Ally increase wait time, allow MCU powersave
Date: Thu,  4 Apr 2024 13:16:50 +1300
Message-ID: <20240404001652.86207-8-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404001652.86207-1-luke@ljones.dev>
References: <20240404001652.86207-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The previous work to allow the MCU to be resumed correctly after sleep
and resume tried to take the shortest possible time. However as work
continues in various other parts of the s2idle subsystems it has shown
that it wasn't entirely reliable.

If the MCU disable/enable call is done correctly the MCU fully removes
its USB endpoints, and this shows as a full USB device reconnection on
resume. When we tried to short this as much as possible sometimes the
MCU doesn't get to complete what it needs to do before going to low-power
and this affected the reconnection.

Through trial it is found that the minimum time required is approx 1200ms
to allow a proper disconnect and disable, and the same amount of time on
resume is required to prevent a rapid disconnect/reconnect happening on
seemingly random occasions. To be safe the time is now 1500ms for msleep.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 976e26c82f80..ab98f91e573c 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -140,7 +140,7 @@ module_param(fnlock_default, bool, 0444);
 /* Controls the power state of the USB0 hub on ROG Ally which input is on */
 #define ASUS_USB0_PWR_EC0_CSEE "\\_SB.PCI0.SBRG.EC0.CSEE"
 /* 300ms so far seems to produce a reliable result on AC and battery */
-#define ASUS_USB0_PWR_EC0_CSEE_WAIT 300
+#define ASUS_USB0_PWR_EC0_CSEE_WAIT 1500
 
 static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
 
@@ -4829,6 +4829,7 @@ static int asus_hotk_resume_early(struct device *device)
 	struct asus_wmi *asus = dev_get_drvdata(device);
 
 	if (asus->ally_mcu_usb_switch) {
+		/* sleep required to prevent USB0 being yanked then reappearing rapidly */
 		if (ACPI_FAILURE(acpi_execute_simple_method(NULL, ASUS_USB0_PWR_EC0_CSEE, 0xB8)))
 			dev_err(device, "ROG Ally MCU failed to connect USB dev\n");
 		else
@@ -4840,17 +4841,8 @@ static int asus_hotk_resume_early(struct device *device)
 static int asus_hotk_prepare(struct device *device)
 {
 	struct asus_wmi *asus = dev_get_drvdata(device);
-	int result, err;
 
 	if (asus->ally_mcu_usb_switch) {
-		/* When powersave is enabled it causes many issues with resume of USB hub */
-		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_MCU_POWERSAVE);
-		if (result == 1) {
-			dev_warn(device, "MCU powersave enabled, disabling to prevent resume issues");
-			err = asus_wmi_set_devstate(ASUS_WMI_DEVID_MCU_POWERSAVE, 0, &result);
-			if (err || result != 1)
-				dev_err(device, "Failed to set MCU powersave mode: %d\n", err);
-		}
 		/* sleep required to ensure USB0 is disabled before sleep continues */
 		if (ACPI_FAILURE(acpi_execute_simple_method(NULL, ASUS_USB0_PWR_EC0_CSEE, 0xB7)))
 			dev_err(device, "ROG Ally MCU failed to disconnect USB dev\n");
-- 
2.44.0


