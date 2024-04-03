Return-Path: <linux-kernel+bounces-128880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD3289616D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D61289118
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B4A1CAAA;
	Wed,  3 Apr 2024 00:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="RygKvskk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GdyOrsZf"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D131BC3C;
	Wed,  3 Apr 2024 00:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712104189; cv=none; b=AsxcKbb0Tj8MFTU+3AtzjAhIhPjVu6gcDoNLfpaLPwhqkHPC/xxUCSKWTPFgGFnXBSOV5DpPfRn8vcFSr/E5ArabB+lqcy9O3hFz0k6ZxyyFWcblHrTJP2S1tx+wV7B8lXnRgcOVTjMuaaSHWq5p0IvIJldChC6X6e/JgFR5y6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712104189; c=relaxed/simple;
	bh=hqQcBz8tjJvePBEV24EgLsCD/lpRWZ3kNVG5ktQlrmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uyb4vU7jHxQQiDkRA1pIZHo13kQklneUkJbtD8/rHm5JAG8ydq6PYWl07I2G6RxrXQRM4M0Zrwsy+XKIIxIXCb6GoUcTVUhuZbKWUe5ABJrYuM+Ln1nh0hVuzUZDbPHCss67A/nJtBSxcCmE9MjkaUxMndmBMPXVV6c2oeC0amc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=RygKvskk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GdyOrsZf; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1A8C7114010D;
	Tue,  2 Apr 2024 20:29:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 02 Apr 2024 20:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1712104187;
	 x=1712190587; bh=WFzsaT48GQrgSEFr3BSkVJlT7btMWqBLkTOeqH2ftUo=; b=
	RygKvskkKo3VnfRVe3PKHP418GAYUpY6JHezr5vnL8tn29kaktywdQLZ6DO3Ozyn
	Fkvvw7xsF4VJucUfD0I0hrjQs5oH9bpjWWKrqegqhX2aNhXYmvMR2yPlU3/IamhI
	yaIOJv8/gTPvaEa889imZXBJxN0ipisMQXWm2iarJYLP3IHtjXl47tJ+3kxCT7Fx
	kbkIYB9uWEsKCU7s/49plY5Iwa7gRliP8rOci99EtP8OoiC8YfumdS/aEt6YhQYA
	8dYawZgIa9FdHrvocFVxQ/2af88I+isxXHQw1K+bnfQtjlpX3liA9nodg2DNfkNE
	sR+AwNmT/tuvWTPscEzwDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712104187; x=
	1712190587; bh=WFzsaT48GQrgSEFr3BSkVJlT7btMWqBLkTOeqH2ftUo=; b=G
	dyOrsZf/6xTZC1yeEHaBpTvMYv/5d8jQJCBb3vNK0GHL24HSW0D5PgF+n3BaojvZ
	z5+06wG/BXYz7qhMCXwNWM9WKTFw40782EHehJUW4AwPA3D22zUoikF20unKT/BF
	bHEOh2MMv5ZwPWUhHQNk21wT10h/WFU+PjbNa8t2A5JT30KNbeWnUkxMSaRw46lq
	Zk+Q5MAmBdc0c/eqZ/JBAxwdqbqkw9WDEEmGUjTJG6V65QKqqsxSpSaLuzuIeFbY
	ICpUBA3aY8VjxUFdUTlRX4J02jrxkLKh6bWRlzNm1Kvk7R1nbhj3otxBRfffEAG4
	78o7t6VVXrrrpdat/0Ecw==
X-ME-Sender: <xms:-qIMZjiuUY6OXgsqc-ejrpmU7Sa374UezVr-UCYKI_lwev5E0MsJfQ>
    <xme:-qIMZgCa4273xcO4jJbFsxCnor3m2Grl2OBi0ZKIRSAyuCZ_qG4M5OXcCOcUan7nt
    BiOFyZKSXLLEpyB2nE>
X-ME-Received: <xmr:-qIMZjHqpKJIaTJYeMaa3clkfYTAjDM7ideih08_BklF0kbp7ccz_bbkVj23>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeffedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvges
    lhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpeduudetudehiedvvdevveelhf
    egkeefffdvfeetuefgveefgffgffeiffeitdelieenucevlhhushhtvghrufhiiigvpeef
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:-qIMZgQprxLGSa5xF5pdADSpw7mjxAC4KtV7tAwJseTLjlnG8bEtAQ>
    <xmx:-qIMZgzTYdeDT5H-epb9F4tj9zeDOfGOHMN6W6rzFKE9_DfHOVyv8A>
    <xmx:-qIMZm5AOhCGOPcp7KDNqv-j6y2OuJvyU3FqVhuSvxaqkl_dz_hfiw>
    <xmx:-qIMZlzUtXqavsEFSPjWX6E5B7c5q6A2zH6QT3rKQ86tVaQo8E2K7Q>
    <xmx:-6IMZnkR52IoHV6UNlldh7e2zeDAGgo-CI36X4MAy7mNY1LLFy3UYZ6Y>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 20:29:44 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 7/9] platform/x86: asus-wmi: ROG Ally increase wait time, allow MCU powersave
Date: Wed,  3 Apr 2024 13:29:15 +1300
Message-ID: <20240403002917.2870959-8-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403002917.2870959-1-luke@ljones.dev>
References: <20240403002917.2870959-1-luke@ljones.dev>
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
index aad4f94cfdba..7867178a9121 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -140,7 +140,7 @@ module_param(fnlock_default, bool, 0444);
 /* Controls the power state of the USB0 hub on ROG Ally which input is on */
 #define ASUS_USB0_PWR_EC0_CSEE "\\_SB.PCI0.SBRG.EC0.CSEE"
 /* 300ms so far seems to produce a reliable result on AC and battery */
-#define ASUS_USB0_PWR_EC0_CSEE_WAIT 300
+#define ASUS_USB0_PWR_EC0_CSEE_WAIT 1500
 
 static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
 
@@ -4827,6 +4827,7 @@ static int asus_hotk_resume_early(struct device *device)
 	struct asus_wmi *asus = dev_get_drvdata(device);
 
 	if (asus->ally_mcu_usb_switch) {
+		/* sleep required to prevent USB0 being yanked then reappearing rapidly */
 		if (ACPI_FAILURE(acpi_execute_simple_method(NULL, ASUS_USB0_PWR_EC0_CSEE, 0xB8)))
 			dev_err(device, "ROG Ally MCU failed to connect USB dev\n");
 		else
@@ -4838,17 +4839,8 @@ static int asus_hotk_resume_early(struct device *device)
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


