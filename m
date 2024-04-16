Return-Path: <linux-kernel+bounces-146534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEEF8A66AC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B40E1F220F4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C161A85299;
	Tue, 16 Apr 2024 09:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="FzRBJRzq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PPjleeWj"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C6C84D39;
	Tue, 16 Apr 2024 09:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713258265; cv=none; b=SkgbyjXGKwZTHoe4JMaAm7PjuHTPPBj7O/Pid+4psY5I7FNnI2kL8VDzfSYT2Y4Gnt2L+JK2VqBloYHcUw4taNc3vfZXl4QCTl5B4IWr8jPS+hypGN4t11Ag9LzL/mBF3ejOOXNV+XV5gcq+Sb6UW/kSv401r9IfAQVagNLixwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713258265; c=relaxed/simple;
	bh=o8I3Yoi1eQPG8FPJU3fiRb8kC2TEcyxQCVfticFkNUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpycT3sFFZ+Plz1exrMtkhR/OoKH5oCEgdkf1Thm5qYeLNvuEG7/zBQVczPmIBGnTsMKRKgELPHfZUIXhjCUGIdarHMT5h4X8pjhI1FI1KrzafaDqSaxt3f7wlCbEDS6PlecnAw0Jh/9fgmepvYHrCY2HH37L4Cx7s+d74ZR+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=FzRBJRzq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PPjleeWj; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 94B001380243;
	Tue, 16 Apr 2024 05:04:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 16 Apr 2024 05:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1713258259; x=
	1713344659; bh=9l2tkGqTosKZsGdTtSU1QTogUKTwqy1NEzt57TKi+SY=; b=F
	zRBJRzqu9xZsQD9i1zf3orxO2nL8u7sQAFUPBXMGQnkf0kOmZ2tdqcjjU04LQssk
	uwXR2U4/PUfCFbIVBFTcIfTPznLFP1tSkzGbdtKw9j3uBND51/fMhRJHHbvuK6fy
	VeoG5gC2iM7blp4pqrB12R2RGUTCYQSpd/+kb63bm3LY4QNtbqsWs9M1EhULs9QO
	UdwcZfh+G3N7TxvR3UBgKeAh47/iR18MLcoI5g/tov6cVf0clEb1A3VMoJPoMqHz
	PbodY+gb5KNarYq03JpFgeYy+VdRC3eLyU0iEZpFqsrtw2sqZBE184i86uQk6uQZ
	RN4PkZye6PZbpcMmJaHdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1713258259; x=
	1713344659; bh=9l2tkGqTosKZsGdTtSU1QTogUKTwqy1NEzt57TKi+SY=; b=P
	PjleeWjqp9nPAQaVFbDe0E5LjChhB3fHeE/nBuBSE1qpUxFyQ+Dej6x26R5xT05m
	F9Pjfj9j29VPkkIIamAxwstT7H+MZUK0P5cWxgkFj39U7n4nIFe2VHz5tk1KE2pQ
	YDl/JKzO0Tmgm6QghPcD2xb3lLkUoxY+rQVw2fJJuAmSerwNJWdAXY55TcNT7dDI
	t3o2z4vsPyv+c7CgKjSPZ2JpxIx7M3T7A5DhKYqpF6Fugjwmsl0j1gqJYXmZkF7k
	AmwLq7e7h5sNQBvRpBIAA9qWX3gf0prtqQcNIsgCDwEgEYaniygG/HZSz2fZuuoF
	Isdal1SYpKTK9qLCEaYxA==
X-ME-Sender: <xms:Ez8eZuztAzFh5MzlOD-APMmFrV_XztG8JgLMMFQyN-JyRsWPsDAJAg>
    <xme:Ez8eZqRx9KtAEnZeHxXT9rXfbB5Totnv7ZzF6Xxz-E_Bv8qhfmZ58EhyMxjeDWV0z
    tm6LBVYXvarqWzinYQ>
X-ME-Received: <xmr:Ez8eZgUTvsdU5buEyPfLFArtLsctwReHDBrZRaWvoFQlEmx_okkF5ckuOYiS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:Ez8eZkgDhPTWMSeOQ7paw7oRr-dznjR-pU9z4Z8luP887HSi_IGJvQ>
    <xmx:Ez8eZgDay2mV5TXe8qoMGRiUUdjeuYK9l3kt8_rKCF8cBDw9L0cPgw>
    <xmx:Ez8eZlJujqqKH2_ULk6kLBAeMmNHijO3_phaNUdDbatFcZXzaUXYlQ>
    <xmx:Ez8eZnA2-Ndx9YFi60yU3uyjYZY0GpbWV7A3sDmE-qB_TcsBnMZRaA>
    <xmx:Ez8eZj8j8MPDgWxgVYQ3ioIuVZhVBuAK8301srgDv_Lg1HEuqfe9XXwD>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Apr 2024 05:04:17 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: jikos@kernel.org
Cc: benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 1/4] HID: asus: fix more n-key report descriptors if n-key quirked
Date: Tue, 16 Apr 2024 21:03:59 +1200
Message-ID: <20240416090402.31057-2-luke@ljones.dev>
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

Adjusts the report descriptor for N-Key devices to
make the output count 0x01 which completely avoids
the need for a block of filtering.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/hid/hid-asus.c | 51 ++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 78cdfb8b9a7a..d6d8a028623a 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -335,36 +335,20 @@ static int asus_raw_event(struct hid_device *hdev,
 	if (drvdata->quirks & QUIRK_MEDION_E1239T)
 		return asus_e1239t_event(drvdata, data, size);
 
-	if (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) {
+	/*
+	 * Skip these report ID, the device emits a continuous stream associated
+	 * with the AURA mode it is in which looks like an 'echo'.
+	 */
+	if (report->id == FEATURE_KBD_LED_REPORT_ID1 || report->id == FEATURE_KBD_LED_REPORT_ID2)
+		return -1;
+	if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD) {
 		/*
-		 * Skip these report ID, the device emits a continuous stream associated
-		 * with the AURA mode it is in which looks like an 'echo'.
+		 * G713 and G733 send these codes on some keypresses, depending on
+		 * the key pressed it can trigger a shutdown event if not caught.
 		*/
-		if (report->id == FEATURE_KBD_LED_REPORT_ID1 ||
-				report->id == FEATURE_KBD_LED_REPORT_ID2) {
+		if (data[0] == 0x02 && data[1] == 0x30) {
 			return -1;
-		/* Additional report filtering */
-		} else if (report->id == FEATURE_KBD_REPORT_ID) {
-			/*
-			 * G14 and G15 send these codes on some keypresses with no
-			 * discernable reason for doing so. We'll filter them out to avoid
-			 * unmapped warning messages later.
-			*/
-			if (data[1] == 0xea || data[1] == 0xec || data[1] == 0x02 ||
-					data[1] == 0x8a || data[1] == 0x9e) {
-				return -1;
-			}
 		}
-		if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD) {
-			/*
-			 * G713 and G733 send these codes on some keypresses, depending on
-			 * the key pressed it can trigger a shutdown event if not caught.
-			*/
-			if(data[0] == 0x02 && data[1] == 0x30) {
-				return -1;
-			}
-		}
-
 	}
 
 	if (drvdata->quirks & QUIRK_ROG_CLAYMORE_II_KEYBOARD) {
@@ -1250,6 +1234,19 @@ static __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		rdesc[205] = 0x01;
 	}
 
+	/* match many more n-key devices */
+	if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD) {
+		for (int i = 0; i < *rsize + 1; i++) {
+			/* offset to the count from 0x5a report part always 14 */
+			if (rdesc[i] == 0x85 && rdesc[i + 1] == 0x5a &&
+			    rdesc[i + 14] == 0x95 && rdesc[i + 15] == 0x05) {
+				hid_info(hdev, "Fixing up Asus N-Key report descriptor\n");
+				rdesc[i + 15] = 0x01;
+				break;
+			}
+		}
+	}
+
 	return rdesc;
 }
 
@@ -1319,4 +1316,4 @@ static struct hid_driver asus_driver = {
 };
 module_hid_driver(asus_driver);
 
-MODULE_LICENSE("GPL");
\ No newline at end of file
+MODULE_LICENSE("GPL");
-- 
2.44.0


