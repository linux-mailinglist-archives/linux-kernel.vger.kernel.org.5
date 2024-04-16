Return-Path: <linux-kernel+bounces-146535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1AA8A66AD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33DAD284936
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F6785939;
	Tue, 16 Apr 2024 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="n75wWrJC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ApxXmv1d"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7934B8526C;
	Tue, 16 Apr 2024 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713258266; cv=none; b=lKjiO9VNyqOD2ZIeH/owink6AyqlX2ijM4UMYcgxecSRqzBRCCMglL1IjcF4wuVHk8koEFi7SC4qqRW9LjSC8lOkvLDoh9/yVE0/Y+grUi25XLLF/y8a6FzGiTcawXpl9TetYI7/lTi2XfrUEU/qomvDoyxiOpokz14CWI7N+Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713258266; c=relaxed/simple;
	bh=khksgLVwfQimzFpzKjcf56Bik5fqMDQ1OHVmttn5CuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKkOkl64QN5d+56W6ACFN0nbFcC2rJX51zmd1MkSisbG555KbsjTz43Rujzmylt1yTUuySMGVUr3oOPtPR12t/wBWQO59UKUxjXD4ZoQc7CruohrW0YWv3m7MBo5aCmIm7y6FdC8BHtWBoVp0/sulQ/vcksFVkNx/+H37Ah0vjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=n75wWrJC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ApxXmv1d; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 82B8B138010D;
	Tue, 16 Apr 2024 05:04:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 16 Apr 2024 05:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1713258262; x=
	1713344662; bh=gSRx7mQh8gdUE9jnpHJm2EkzDbubH03thXXqIjS/0i8=; b=n
	75wWrJCh0bui1dtb/dIGIRTe4T2Vp8rsg7dEP0waWVmiB+J7k9O0SPEWXn7v85cI
	JcUOrNJNXwwG8ZjpoSjTbhbKFoyyOGZjW4bepnVgpuu+iNT94Mb1/XYlPUMi5wsB
	QMZvCs0kmKGKCt3uA+tIO56uR4tI2eOjyBAVP115pE4uqRS61aygCYML5RPdM+WP
	qGK/UjAYI4krJ46ZtJxmHL0QFnW6uFqleiLsyYnqAljKj4stN53dETck15TlVrNW
	x2TTXZz1fe121Tqfk0asFnrJbKahkkwvNFPfmCNssO7sk+nKOgIYZhm1aBeG0Gwo
	lKXAg9Smhoca6KJ0Nckxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1713258262; x=
	1713344662; bh=gSRx7mQh8gdUE9jnpHJm2EkzDbubH03thXXqIjS/0i8=; b=A
	pxXmv1dzoB1W1PDOHmAJ2QLsFvU1VHumU4vV5B6iWYJkqBTzNepX/40iq2G6oZgb
	K5OqvNQwvFEFTYu5bWfb9nFOA7GRTYhg9M7nzbO7RrQC2DuCbrpno7hPRFca8nCM
	nlwLjxDCKbmnCjJUOiwTOQR0bA2waLeufpT9p9A3EL3UaVnp+eFgP+aRL68uGREb
	t3KrNIAqRrbqEenHlyHZiEtWggVeM1IUYA7t1s/qBZgwOUb5whtZ9IdSRwp5R2kF
	Dexl8zgnvpeXUZYYLXb2wmjykjcOQEODIOaCKtRK28HW4aQ/D4d9elAHeAP63650
	XGzJROBJ4eIeAq8tv3B3g==
X-ME-Sender: <xms:Fj8eZnzeOcN7Fn7R_rhsNia5yedRuUgm_Ys_oR7CN0e0qCbGQuL_iA>
    <xme:Fj8eZvQ-zQcV5_rG5yj4ECN2opAJuxS1z4llvOwbygeLgNTOwXxFIL2u_sKJ7xsbe
    dAQEag6aXw1WYO8Ur0>
X-ME-Received: <xmr:Fj8eZhVeQ1H5t2qUhvBN7V1UJvish89lzM-XD5xFoJX_h_6G1PoewM3rKKd5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:Fj8eZhhZdVa5PNXhPXSgV25XlJgOduyTQsqJYrUgzum-JQPkkh5RJg>
    <xmx:Fj8eZpBDZmzRn7ZL5QOHWZ5P9cWZomIIASCI4GDsw8qsIxr3VgBKmw>
    <xmx:Fj8eZqLA5LH6mlaf5kE_9CMJPBezS7YdoF_Iz2zMwsxxNX1uA4idfQ>
    <xmx:Fj8eZoAibcc72Bg7RcoK8DhHR8STe5CQasTIgrwqGRiIji7AHOOv3w>
    <xmx:Fj8eZk-B8E5f8gkQd4OwyKc2fQPNUpp6TuzlYzoZyDdaq7mgwC9449XC>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Apr 2024 05:04:19 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: jikos@kernel.org
Cc: benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 2/4] HID: asus: make asus_kbd_init() generic, remove rog_nkey_led_init()
Date: Tue, 16 Apr 2024 21:04:00 +1200
Message-ID: <20240416090402.31057-3-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416090402.31057-1-luke@ljones.dev>
References: <20240416090402.31057-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the n-key stuff is old and outdated, so
make asus_kbd_init() generic to use with other
report ID and remove rog_nkey_led_init().

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/hid/hid-asus.c | 70 +++++++++++-------------------------------
 1 file changed, 18 insertions(+), 52 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index d6d8a028623a..18062f9804fb 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -386,9 +386,9 @@ static int asus_kbd_set_report(struct hid_device *hdev, const u8 *buf, size_t bu
 	return ret;
 }
 
-static int asus_kbd_init(struct hid_device *hdev)
+static int asus_kbd_init(struct hid_device *hdev, u8 report_id)
 {
-	const u8 buf[] = { FEATURE_KBD_REPORT_ID, 0x41, 0x53, 0x55, 0x53, 0x20, 0x54,
+	const u8 buf[] = { report_id, 0x41, 0x53, 0x55, 0x53, 0x20, 0x54,
 		     0x65, 0x63, 0x68, 0x2e, 0x49, 0x6e, 0x63, 0x2e, 0x00 };
 	int ret;
 
@@ -400,9 +400,10 @@ static int asus_kbd_init(struct hid_device *hdev)
 }
 
 static int asus_kbd_get_functions(struct hid_device *hdev,
-				  unsigned char *kbd_func)
+				  unsigned char *kbd_func,
+				  u8 report_id)
 {
-	const u8 buf[] = { FEATURE_KBD_REPORT_ID, 0x05, 0x20, 0x31, 0x00, 0x08 };
+	const u8 buf[] = { report_id, 0x05, 0x20, 0x31, 0x00, 0x08 };
 	u8 *readbuf;
 	int ret;
 
@@ -431,51 +432,6 @@ static int asus_kbd_get_functions(struct hid_device *hdev,
 	return ret;
 }
 
-static int rog_nkey_led_init(struct hid_device *hdev)
-{
-	const u8 buf_init_start[] = { FEATURE_KBD_LED_REPORT_ID1, 0xB9 };
-	u8 buf_init2[] = { FEATURE_KBD_LED_REPORT_ID1, 0x41, 0x53, 0x55, 0x53, 0x20,
-				0x54, 0x65, 0x63, 0x68, 0x2e, 0x49, 0x6e, 0x63, 0x2e, 0x00 };
-	u8 buf_init3[] = { FEATURE_KBD_LED_REPORT_ID1,
-						0x05, 0x20, 0x31, 0x00, 0x08 };
-	int ret;
-
-	hid_info(hdev, "Asus initialise N-KEY Device");
-	/* The first message is an init start */
-	ret = asus_kbd_set_report(hdev, buf_init_start, sizeof(buf_init_start));
-	if (ret < 0) {
-		hid_warn(hdev, "Asus failed to send init start command: %d\n", ret);
-		return ret;
-	}
-	/* Followed by a string */
-	ret = asus_kbd_set_report(hdev, buf_init2, sizeof(buf_init2));
-	if (ret < 0) {
-		hid_warn(hdev, "Asus failed to send init command 1.0: %d\n", ret);
-		return ret;
-	}
-	/* Followed by a string */
-	ret = asus_kbd_set_report(hdev, buf_init3, sizeof(buf_init3));
-	if (ret < 0) {
-		hid_warn(hdev, "Asus failed to send init command 1.1: %d\n", ret);
-		return ret;
-	}
-
-	/* begin second report ID with same data */
-	buf_init2[0] = FEATURE_KBD_LED_REPORT_ID2;
-	buf_init3[0] = FEATURE_KBD_LED_REPORT_ID2;
-
-	ret = asus_kbd_set_report(hdev, buf_init2, sizeof(buf_init2));
-	if (ret < 0) {
-		hid_warn(hdev, "Asus failed to send init command 2.0: %d\n", ret);
-		return ret;
-	}
-	ret = asus_kbd_set_report(hdev, buf_init3, sizeof(buf_init3));
-	if (ret < 0)
-		hid_warn(hdev, "Asus failed to send init command 2.1: %d\n", ret);
-
-	return ret;
-}
-
 static void asus_schedule_work(struct asus_kbd_leds *led)
 {
 	unsigned long flags;
@@ -558,17 +514,27 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 	int ret;
 
 	if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD) {
-		ret = rog_nkey_led_init(hdev);
+		/* Initialize keyboard */
+		ret = asus_kbd_init(hdev, FEATURE_KBD_REPORT_ID);
+		if (ret < 0)
+			return ret;
+
+		/* The LED endpoint is initialised in two HID */
+		ret = asus_kbd_init(hdev, FEATURE_KBD_LED_REPORT_ID1);
+		if (ret < 0)
+			return ret;
+
+		ret = asus_kbd_init(hdev, FEATURE_KBD_LED_REPORT_ID2);
 		if (ret < 0)
 			return ret;
 	} else {
 		/* Initialize keyboard */
-		ret = asus_kbd_init(hdev);
+		ret = asus_kbd_init(hdev, FEATURE_KBD_REPORT_ID);
 		if (ret < 0)
 			return ret;
 
 		/* Get keyboard functions */
-		ret = asus_kbd_get_functions(hdev, &kbd_func);
+		ret = asus_kbd_get_functions(hdev, &kbd_func, FEATURE_KBD_REPORT_ID);
 		if (ret < 0)
 			return ret;
 
-- 
2.44.0


