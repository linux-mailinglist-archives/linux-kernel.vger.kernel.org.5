Return-Path: <linux-kernel+bounces-7792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A52981AD0F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE5A1C241A2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD8E3E498;
	Thu, 21 Dec 2023 03:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="an7Go/Er";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cn7/Ke8a"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A918D38DD0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 03:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 83A633200A30;
	Wed, 20 Dec 2023 22:09:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 20 Dec 2023 22:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1703128194; x=
	1703214594; bh=0bq2fN9Uza31d9KmzZhN4ub+BZ6fkGAQSHJ72vJy0/s=; b=a
	n7Go/ErwMbHIwufWkoi0nbK8acgDnkErzr6/zmDEi35n+Md5I5jAew3IHsrSwuKS
	v8f+O+KUZ/pEsgNUWffz3NkCfb6YgVtp67/9GzbK2ouquEAepPyaGH/lwi+cV82S
	O2k/c/EUzklMWICo1bjSbafMO/1kODT16vt2nxrhZPuqRgbR/WzKgAbnA7jWUZa1
	tczJtkiwJbqOntQUaJv2VnZLTK9XUrYbB4ezpil54pSxttrdgBFDlLeFEpvFBdVq
	KPErxBu5xix7zQZIbPPUXL9Q8AGIn/1JzyN6y+FY0gnUnpoNBItdkbjcBcHQfXOb
	sbPEHEjs/RlBU6VIlH+fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703128194; x=
	1703214594; bh=0bq2fN9Uza31d9KmzZhN4ub+BZ6fkGAQSHJ72vJy0/s=; b=C
	n7/Ke8aTqE5dv2JoMDDjVB3orPHoSpaa4D52uqe3Z+/O1KfpCT8kURjmY3YbUtMi
	4ICINHoldFYjRS+aAIFasDj5QMXVmptkme/phT+kA3B/NnofM5AvDoKo0oADrW9A
	J7C4x2PosYRRNHLW97LnznBn2Th9OYCEcfgWehKrBueXHv4rBK1P9ZLBkhB2F0MX
	sm/sgYVNGmltVMElk4IL/sjeDbjA3k3GKtAUlZzwMAmzYyv5Ah5/suaQ7VR+csRM
	emGjI/78/3tbSAdc5kcyIhHm0pm0Z2YHIX9d5ViP7fM/Z1DjM78SJm0JDqe7nwQy
	fT6lXVFtosbBETTcq1A/A==
X-ME-Sender: <xms:gayDZc-czRjmUSR2MjZvRYr9FVIyYlmPEPSte9r99foAMpUQlN0BLA>
    <xme:gayDZUvaN6OC2O0mUmBOGtUnt3kcJxShxLfdaEYdRPOmDDKp7FY1XbMkulU-Jme-3
    XPwHWv0xXzV6BSABVY>
X-ME-Received: <xmr:gayDZSCsa-vkJtJdXB-We7dK09JMM2dCaj8QoK75QEC25Ylmi4weyGVGqdiPXGOqZRaWvL54mZDjcQeC2w31mLZSHfTs6T0c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddufedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:gayDZcd14Ku6BZty07oWb-LXNSOiwHHGe51XgwHkxB92cnPsIB7Ozw>
    <xmx:gayDZRO0GjowENrw0XGV46-iKUAQ0aMqtNG_1o1bi3SIHb4kwNZ5nQ>
    <xmx:gayDZWlakrdcjgDCFiQzXiexdedejMalGGUuxH5jpi_gT3lmVe0Aew>
    <xmx:gqyDZSpE2r2Gy5j6OMFhk0uasKw9rttxQs3r6-AxYY7GJtR-j49xWA>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Dec 2023 22:09:53 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@list.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 4/5] staging: rtl8192e: rename variable HTSetConnectBwModeCallback
Date: Wed, 20 Dec 2023 22:10:03 -0500
Message-ID: <20231221031004.14779-5-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221031004.14779-1-garyrookard@fastmail.org>
References: <20231221031004.14779-1-garyrookard@fastmail.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coding style issue, checkpatch Avoid CamelCase,
rename it. HTSetConnectBwModeCallback -> ht_set_connect_bw_mode_callback

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 5698b48fdcc9..ac17d510a2a5 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -633,7 +633,7 @@ u8 ht_c_check(struct rtllib_device *ieee, u8 *pFrame)
 	return false;
 }
 
-static void HTSetConnectBwModeCallback(struct rtllib_device *ieee)
+static void ht_set_connect_bw_mode_callback(struct rtllib_device *ieee)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
@@ -695,5 +695,5 @@ void ht_set_connect_bw_mode(struct rtllib_device *ieee,
 
 	ht_info->sw_bw_in_progress = true;
 
-	HTSetConnectBwModeCallback(ieee);
+	ht_set_connect_bw_mode_callback(ieee);
 }
-- 
2.43.0


