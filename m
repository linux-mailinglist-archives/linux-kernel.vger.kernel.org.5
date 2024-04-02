Return-Path: <linux-kernel+bounces-127256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D57828948D3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28FF1C22B8F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF950EAF0;
	Tue,  2 Apr 2024 01:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="A0uzR67R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vBxTb17E"
Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E609168B1;
	Tue,  2 Apr 2024 01:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712021739; cv=none; b=aTaoLfP5OMS4UDUXThZGGtoPRmchVAFDM58jUaMWDaMUulR+A2yJrF2RiVI7JX3jdm+82Odd+WeEXNwC+uj8PN0sy2avZRmBdm2fVFJp3rS7gT0gDH8jkRRCufq4bdON9gb41Q3uYFVAbvLQVHDpb981rKrgMCUPC+WfV+qJ4tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712021739; c=relaxed/simple;
	bh=XwuityfWCS6QCNXlBVjFpQpGfUVldGXg4D5s4omri9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5hPvjAHjVJ0YtqMaNB93vtPkUrj9dTaEDT0JFPDJK1VxaYn0hh+6jECwvEQiNklGV78+u3bDVzPThD0sQ+KME6Qx9BvnKMo/HwujQmmzKp0nF09XIp3THGNLX8A2MMsO/204NxhQ1bnU+w1lchVpQhhOvTQ2A5rHmsOclxWU6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=A0uzR67R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vBxTb17E; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 3A7A518000C3;
	Mon,  1 Apr 2024 21:35:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 01 Apr 2024 21:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1712021735; x=
	1712108135; bh=+lG+H/t6TDkZc72SdaZDtgLUZmp5G4uRmubnYfLzyJg=; b=A
	0uzR67RL+V2I12RQA2sDLGmkJniUHZbS5FRw5Bron15xuJx708+Wxzdt7xt4yvn+
	lBJ5drLlITS9m2fDNVaLzEfPxAJ1YVeZaRUb/AcTOugkS6dU9HZ1O8wgtbVhhLEM
	0t1Wq1yEQC31SK3lJAJVUw7i7BqwATvKSf7Qlm/QRHKpP9MMr/4GvweQxZxnRmcI
	sXhBNZ6Zw2s92rSgrpj2gvj2+KUIn3NZDgj8UL0Csja9/yHMf2QzwcaKfIPiXW64
	HT/kqw64vpYwumLyY2MFk9wInNlEXUDGGBu5EapNfosGiGXMiBxlLxfTf8NFP9EF
	BtKpYGpGAiIOZFQ5xrCwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712021735; x=
	1712108135; bh=+lG+H/t6TDkZc72SdaZDtgLUZmp5G4uRmubnYfLzyJg=; b=v
	BxTb17EasduJkLsQk7VXMt6qsjJ1zGXbo6XO3xGr06BPnFQxemalKTFJ7QhIXq5r
	K60Sw6CE1Yc+DiBFEoTZgxcOWCvrMnyX6CMzD/OcxT7WqjLKSt+0ccVLVxzYnI+E
	EB1/EFrFdEf4hjurV0sRbvm7hVUgQEPIBzpiymtIJeeWj2/0k1VnA3SlR1cIr4Dl
	eEazrFnE1qVi+2sdRtczTIIOKj0B0B5W8y6NnIMZEbTzcPcOBaQ5EYez2Uf+ah6h
	UVgE1FTsMUg6S34KDflPLW7T/+91xjeXT8SWePE3tLcFquxmeJBqxq4cb5OVJcI6
	wxKlJzI3ahjMVbuESOwWg==
X-ME-Sender: <xms:52ALZp4Rz8fYgCJ6PkF5xsjSHlYrFPAJq3JDJMIZ_sQIZ9xbIPADrQ>
    <xme:52ALZm6QnKa6dvCPXB0kRnOoTq8A-Emeio_ti0wBn55XOL_4hXoMfkqLEjCeF3pMO
    CvRRx2oRqK_mFCPDus>
X-ME-Received: <xmr:52ALZgerNBsuH9sFbRjYoAKmcF34As-5nH8E1iCbWvEG99Ih4zj54rrRTOOF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepuden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:52ALZiKIbOhK2an_lyLlMo84lojKOQnwagjQ6fBXCA02lpWTalZZ2Q>
    <xmx:52ALZtJGILB8drUsiAt1axtys-FB6b_o48b0Y2KfMEvFNn_4H1JLwg>
    <xmx:52ALZrxv3eM4svDATqBenRQ8zhk7L_PSZfwwg6RRBspT0aeybAJRmw>
    <xmx:52ALZpIMmXPGAayJ8WINQoJ1U18K3lmu2UjIe_Vs6Z1Zsg8Kfj1elg>
    <xmx:52ALZl8avEDfxHgdlCklLQKcJiLgC9thjkoMrLwDmNVAw9y2zzxGnnFGVFA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 21:35:32 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v1 7/9] platform/x86: asus-wmi: ROG Ally increase wait time, allow MCU powersave
Date: Tue,  2 Apr 2024 14:34:51 +1300
Message-ID: <20240402013453.18205-8-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402013453.18205-1-luke@ljones.dev>
References: <20240402013453.18205-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 2ff78e194801..ec249eca0d94 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -129,7 +129,7 @@ module_param(fnlock_default, bool, 0444);
 /* Controls the power state of the USB0 hub on ROG Ally which input is on */
 #define ASUS_USB0_PWR_EC0_CSEE "\\_SB.PCI0.SBRG.EC0.CSEE"
 /* 300ms so far seems to produce a reliable result on AC and battery */
-#define ASUS_USB0_PWR_EC0_CSEE_WAIT 300
+#define ASUS_USB0_PWR_EC0_CSEE_WAIT 1500
 
 static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
 
@@ -4814,6 +4814,7 @@ static int asus_hotk_resume_early(struct device *device)
 	struct asus_wmi *asus = dev_get_drvdata(device);
 
 	if (asus->ally_mcu_usb_switch) {
+		/* sleep required to prevent USB0 being yanked then reappearing rapidly */
 		if (ACPI_FAILURE(acpi_execute_simple_method(NULL, ASUS_USB0_PWR_EC0_CSEE, 0xB8)))
 			dev_err(device, "ROG Ally MCU failed to connect USB dev\n");
 		else
@@ -4825,17 +4826,8 @@ static int asus_hotk_resume_early(struct device *device)
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


