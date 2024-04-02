Return-Path: <linux-kernel+bounces-127255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE7A8948D1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 428661C22AC8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CDC14AA8;
	Tue,  2 Apr 2024 01:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="Z3i7c9dm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UCdpp33s"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC25214A99;
	Tue,  2 Apr 2024 01:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712021734; cv=none; b=Wyzo93M+hROhaMA5Yvnd6l3T7PY2oLz/v8hMyWowbVweg/4EldRAxfjwLNJoosDEA9h9RC3dPMMMkODkVeHijgkY55QzLfpjQH1b/EX3Vq91pwBbune89Qa9KS2Q03ihf8hflq3HnFpI33m1pGMsPhfIITBngbf6ynp08qEyxFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712021734; c=relaxed/simple;
	bh=YGnLU4DMgKySQEjPe0P6Ui/q2SAR7zugjDjW5DXFI3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHaSAD8edWSKc/9o8HQqAl+F5jZodphe0U0V/jptv9rhCr+Ob//X28M0TOIEspeRwf0lJbNPNi8Vfw724YMWmgktu3ioEy65YOkEXIHUkXtniGQLgR7Sx16mkaNasTPYrTxjAJYZx3l2FM+szB38/P3Quw3+bP60k9n4UugeHD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=Z3i7c9dm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UCdpp33s; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id 95EE31C000A0;
	Mon,  1 Apr 2024 21:35:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 01 Apr 2024 21:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1712021731; x=
	1712108131; bh=tXgXU16gHPPexP/een5uEQeJLLKmVvpOpyL4QaBKpWs=; b=Z
	3i7c9dm6kFDlCJimnST8X5SysefqCCnjrcJ/X32o6LwN3koVyNmvuApcJ3cVGYlP
	ZOE2iw3EaFP/0BlVdRTaXegKfvR2Y0a0NNYBHWi3OxNRCrzWPstuhxFjf8NRWh6l
	tnTKSIq1hwD6AqiOL9QRuCpiWWshm+25/PrwanWAWCIyCKRxd4BV6LUGx9xpqiFQ
	v3TQTyPuIp9zifkNnFcA5G7ynnKaQbwXH8XGBawE81q2UYa4k3lRJc4IW/uHWeQc
	c5RAYbH9hQRQb8PbsY/7wLi0AG9uI1nzUNg6Jbfa6IDGZBs239l6xVeJ5b5TcvCX
	gkZFWrkNSmHyI53uteSAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712021731; x=
	1712108131; bh=tXgXU16gHPPexP/een5uEQeJLLKmVvpOpyL4QaBKpWs=; b=U
	Cdpp33sM5AIWk6Bmp1/qrBdsFhzQFAag0VQ+y0h2mEXhI0+eKW5Y4XfoYcgk1cxJ
	oNFxpxyx4kPCU2Kff7n0tAPLZEZOXHNvEKncRI2m9/V7nkfSttMurYcn3FX05lQM
	dxyWubY3szSJOvK1n1ytd+6GiZT9atrNxdLBNiXCamrJxOd2SPw8Vk4lGSSiQdHb
	ABtqaZDw5VlWRKin+dVZdZ67yjpKCMC35ydCwPX/NrfG5zpHe4uPSF5LXrY0fWwh
	1DdO5ahULampn44YU+WX1Rh8heZUrB8pnSI5XZlxlY9pTQNaxieSCGM5+fxV0eeB
	xO1vkKZZsPPBVCNKBMTDw==
X-ME-Sender: <xms:4mALZn_oLT2gqqOSLN94xgFrhZ8oGWVOqqAguEmcup5uNnhDj5rttw>
    <xme:4mALZjs0eAp6EVOWqdOzCOrbPmHPFXQj9XjtkR-oXJNtr6ds0jbzhbWfvlbzXAO5J
    8VbGCc4j12BlcZBPZ8>
X-ME-Received: <xmr:4mALZlCX37tjJhvDu1n_eqvvQpD0oP0k5eRlYICI57hPHL-IivdjmybRWMov>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:4mALZje5yALbjdSxVuHr1Z8UHq_j2G3CKL5m_I--kNFuvXzoSYWRTQ>
    <xmx:4mALZsMK1jLN3xlSzX7IHnNmyYEi5c1Pq3CYyV2wtQIxxO6Y38IeYA>
    <xmx:4mALZlljeHnUPLvLEU1YrzdfEjR59q1_BXThxQ2S401Bf0RWnsZvrw>
    <xmx:4mALZmvULRgXGEEF1CiDTLbCYaMn07iMEC8dUdlM_sBcc4PVBzj5Sg>
    <xmx:42ALZoBrcokifuCIvPaLPTa2EZYo80NIYjZxATCc_mK9MctHqE3lVABLv1Y>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 21:35:28 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v1 6/9] platform/x86: asus-wmi: adjust formatting of ppt-<name>() functions
Date: Tue,  2 Apr 2024 14:34:50 +1300
Message-ID: <20240402013453.18205-7-luke@ljones.dev>
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

Shift the call to dev_get_drvdata() up to top of the function block
in all of the ppt_<name>() functions as part of a minor cleanup.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 0d304a04e7de..2ff78e194801 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -997,11 +997,10 @@ static ssize_t ppt_pl2_sppt_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
+	struct asus_wmi *asus = dev_get_drvdata(dev);
 	int result, err;
 	u32 value;
 
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
 	result = kstrtou32(buf, 10, &value);
 	if (result)
 		return result;
@@ -1041,11 +1040,10 @@ static ssize_t ppt_pl1_spl_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
+	struct asus_wmi *asus = dev_get_drvdata(dev);
 	int result, err;
 	u32 value;
 
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
 	result = kstrtou32(buf, 10, &value);
 	if (result)
 		return result;
@@ -1084,11 +1082,10 @@ static ssize_t ppt_fppt_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
+	struct asus_wmi *asus = dev_get_drvdata(dev);
 	int result, err;
 	u32 value;
 
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
 	result = kstrtou32(buf, 10, &value);
 	if (result)
 		return result;
@@ -1128,11 +1125,10 @@ static ssize_t ppt_apu_sppt_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
+	struct asus_wmi *asus = dev_get_drvdata(dev);
 	int result, err;
 	u32 value;
 
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
 	result = kstrtou32(buf, 10, &value);
 	if (result)
 		return result;
@@ -1172,11 +1168,10 @@ static ssize_t ppt_platform_sppt_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
+	struct asus_wmi *asus = dev_get_drvdata(dev);
 	int result, err;
 	u32 value;
 
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
 	result = kstrtou32(buf, 10, &value);
 	if (result)
 		return result;
@@ -1216,11 +1211,10 @@ static ssize_t nv_dynamic_boost_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
+	struct asus_wmi *asus = dev_get_drvdata(dev);
 	int result, err;
 	u32 value;
 
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
 	result = kstrtou32(buf, 10, &value);
 	if (result)
 		return result;
@@ -1260,11 +1254,10 @@ static ssize_t nv_temp_target_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
+	struct asus_wmi *asus = dev_get_drvdata(dev);
 	int result, err;
 	u32 value;
 
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
 	result = kstrtou32(buf, 10, &value);
 	if (result)
 		return result;
-- 
2.44.0


