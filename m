Return-Path: <linux-kernel+bounces-116555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8FF88A0A5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0541C37939
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A14160873;
	Mon, 25 Mar 2024 08:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="Xia4K07L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JeRvy5Xg"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6818D148832;
	Mon, 25 Mar 2024 05:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711345834; cv=none; b=r1IwHkx+anlAHTi1oJFnAN+fu99LAcMef+1+lGD8gYHIU4Tkh0bKGUxCVA8pQP5bZUNA1xqv+WdBbY/rglqjUjidb1fQnXVo0oeHjZUA1q1Ja/8U6nmmqKarKen+N0nNR5D9L1miJ+ze9ztZOuOXN7+jHE51GE94YslIdM9xkXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711345834; c=relaxed/simple;
	bh=PAbaZ26oXCeEslKbt2mvcfwjNMVINvP4RHoc5eMChdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngyu8zbdTgVhnrqJ7eiVCLX8GJEAd6l3HwYXCvFKhmO6xrme+2lZPydZi/gfYOV2Sq9YuVhlwBtfr1gavpUthUzs0cPIQNo8/Nkr4LlB3IXFklGFUwXR2nQHS9hO/I6pypajQ1YtCYiGoxvPRnSew9fNQt4CREPoMmvUbEenum4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=Xia4K07L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JeRvy5Xg; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 481F911400CD;
	Mon, 25 Mar 2024 01:50:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 25 Mar 2024 01:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1711345830; x=
	1711432230; bh=h0LXpwNc4zaj4DBhUj2bGO+AItXmEbI2AqKPkhjHjZY=; b=X
	ia4K07LflJi5JjqSGPr5ftJ4/vUALFLuy62r6fJU2ZsVCiIaNBcTqtqKIj+34aPl
	GBxAKhhDRjAQqGGU3MQOKYKfJ9HQwO+mCPb5a2kk5KKr8AFNe933fgNiyAcDp/H4
	H6TH2zgOKc37fwL9wTdx4joksYQech/Zx8AqJq+MlVX4JZvRViscPQU23L0jBrDX
	gaUtjSjxvI5bYVS4+R74e43sGvEDMB3//R0MR6dL+YqAzZjmTU7rlJ6Pokjh09Kc
	wFHeq/7no8sBzPTaIxIn11naL2diGFq90QhyTURR2yy61TAQhMrKQ3g1G+x+ejw1
	l3CEg2rr2yqoVI4Z60cPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711345830; x=
	1711432230; bh=h0LXpwNc4zaj4DBhUj2bGO+AItXmEbI2AqKPkhjHjZY=; b=J
	eRvy5XgCpuTwgedKkLAxyZH7h+2du6Bj3x6pPUTut2XZXXoxVZSc3KjJ9kYPhwON
	sonaIQ9bCg2zC0s7uY/NZAkpMxorWoVP6/RcmcECF13AuapgSUxOA/iyWM4/lvUP
	QUHVX9DnNzIq6ZtSRkWDnX8UufC/ypBLpkCxy79iLsh2srYggIPiXhShyiMpe6S6
	YKkFMMiaQ9cUEpcnEyuN0gNDiV+esnlNmIyyRqmo3NWvIi7mdkM/wZ34cDT/X1dv
	MwVhVWNSswSBorvzrKSg8pOyVBzFASwet6TJXU74jn37CKVynJzObXqh0IbGBMQs
	ILQHKvtjQq2eZFh5jAu5g==
X-ME-Sender: <xms:phABZswNk0WKMX0E5x0FhgXBtoZmd9W8UjgsQ5U5LFgSeMmT8Bbq9A>
    <xme:phABZgRECKYEa13JRzNymMlulTX9_n3ARQ5n8wHnc5tmYStbHea9dbCRVcLP6HCY0
    jWFQcg8rzTeYebLk2g>
X-ME-Received: <xmr:phABZuXlsEGMSQmcvzzjKCOLKH9eEAR8p403_PCmAjIg9VnKlYKOMSTw-Jd6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtkedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:phABZqgM3bDA3e4YtkK4voQVN7e5VKk-9_1gY4ikyfoaFDkEeRxhOg>
    <xmx:phABZuAXoX7QJSCNZZMg6kwxs6jj4mlPIwYS2vApVEO-5M9cCS64AA>
    <xmx:phABZrIGcWmRnYUfi93OqC_bt0qTr_jx72vBt5E5hvbc8usBYbEefQ>
    <xmx:phABZlBX2WuuLl2A24v7lO1rGIApj5lQAjw8VigTR5-f6S6uKcCS3Q>
    <xmx:phABZg1-TzxBP0ouXNpe5wMKMmWMZw75vO-adWorahjkeOh62QE0Uw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 01:50:26 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 7/9] platform/x86: asus-wmi: ROG Ally increase wait time, allow MCU powersave
Date: Mon, 25 Mar 2024 18:49:36 +1300
Message-ID: <20240325054938.489732-8-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325054938.489732-1-luke@ljones.dev>
References: <20240325054938.489732-1-luke@ljones.dev>
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
index 11ce6dec31c6..de338f7180e0 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -136,7 +136,7 @@ module_param(fnlock_default, bool, 0444);
 /* Controls the power state of the USB0 hub on ROG Ally which input is on */
 #define ASUS_USB0_PWR_EC0_CSEE "\\_SB.PCI0.SBRG.EC0.CSEE"
 /* 300ms so far seems to produce a reliable result on AC and battery */
-#define ASUS_USB0_PWR_EC0_CSEE_WAIT 300
+#define ASUS_USB0_PWR_EC0_CSEE_WAIT 1500
 
 static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
 
@@ -4873,6 +4873,7 @@ static int asus_hotk_resume_early(struct device *device)
 	struct asus_wmi *asus = dev_get_drvdata(device);
 
 	if (asus->ally_mcu_usb_switch) {
+		/* sleep required to prevent USB0 being yanked then reappearing rapidly */
 		if (ACPI_FAILURE(acpi_execute_simple_method(NULL, ASUS_USB0_PWR_EC0_CSEE, 0xB8)))
 			dev_err(device, "ROG Ally MCU failed to connect USB dev\n");
 		else
@@ -4884,17 +4885,8 @@ static int asus_hotk_resume_early(struct device *device)
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


