Return-Path: <linux-kernel+bounces-19065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AE6826766
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 04:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F577B21235
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 03:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0347913FE7;
	Mon,  8 Jan 2024 03:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="asx10Boj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zeJqfZ7g"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AF514012
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 03:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 2C0CF32012A7;
	Sun,  7 Jan 2024 22:22:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 07 Jan 2024 22:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1704684172; x=
	1704770572; bh=wgbEUfxNY2iHRzo1R57EAm44pSGjcjmtaBwsUqyWzsc=; b=a
	sx10BojDFGi14JhZdaz4n0WupUF38BeCbp26uZrgg12JrqD8zqOYSZZ9k7dqhmZ+
	eQkUaQcrF4ooMU2EOFkcXSli4C65DswU1XpbnRaeXeiksp0vOTQCuuPRSjW7Lo4b
	8bXzXT/sDWiuu71sVR3VlSCWOwsfI6r50ADDwv3NLsGty0phQMO9oOmAEeeRwQ/B
	tzwca8amvzNDuYaIXtPp6atujie+xhImMQE0TqLGWzHzeTRoULGFGAdErbP0t4y0
	tksu4zP56en1EvgnQFslX+LDgEbNXXS32dL8Y/SZzYio2CAdSD+XhdP1tAmQ+nTd
	51rPipuogy356BHfnZFiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704684172; x=
	1704770572; bh=wgbEUfxNY2iHRzo1R57EAm44pSGjcjmtaBwsUqyWzsc=; b=z
	eJqfZ7g0YjzirNvtBNuwfImq/UVDaga9S+ZX3uZIRv2SsVDJStbajOBS/Iw/QPc5
	Vldf2V8wFp7XXTx/z0eYntRaUXSU6TxH1WHZt0gBDVKTe2NTQTRlNm8qnKDcC1nE
	t4p6IL109aLedpOpuxue+rLmdeC6iTwZ8PjxvRXhvDco/CbkB5ljqWAoz1CKvtE5
	NPL+J+25fCXII9MD4bkwq3Bkg3OAWu8r0zqCpnJvtIZpDTj7GpQgWRG72N5lEwNl
	6NHiaosmYdEBiv7hdTvGuX9XCsSdQ9AjMsBKuHFdHLqDPhGSILr2YImLH6/eFE+Q
	C7raQVkBP/iZ+H2x+x3JA==
X-ME-Sender: <xms:jGqbZY2zkGda-zNM1LD894rUjVctSIIkfGF3K4TzED98jB7HWuHdBQ>
    <xme:jGqbZTE93y1ky-cVD4mHj6qEa1pbe1wjLzScUhgP-pKxrnbdlw75eTAXoDI6JyKY0
    rfiiqcNKhXMTRppEqM>
X-ME-Received: <xmr:jGqbZQ5sk_cXN5OUWad9a3KzMxb4K6qvB_X8MK0QWsv1NGW8sMBWiMECuG-7Qrp1_TDvXOBRNHXiPP_KBuUjC__Fh5FdykmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehhedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:jGqbZR0CpeKmqwJSk0_qD-CThfV6VrLDug5O4USDxu6yCUYUUccbqA>
    <xmx:jGqbZbG4JxUrYaUhl0jbFXOprQxgHoiUSAezO8L7wSPvNb4PEqw_jA>
    <xmx:jGqbZa9F6_OHKYIBt3KfZRwp69HeDlGqI4OVx2E5FJvOBzHMz7QR3g>
    <xmx:jGqbZTASjzrarVDtkz2SjXRXLyCXIbpwK0h22PUWTrJW45GvwzLKCA>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Jan 2024 22:22:52 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 2/5] staging: rtl8192e: rename variable isShortGI
Date: Sun,  7 Jan 2024 22:22:30 -0500
Message-ID: <20240108032233.4280-3-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108032233.4280-1-garyrookard@fastmail.org>
References: <20240108032233.4280-1-garyrookard@fastmail.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coding style issue, checkpatch Avoid CamelCase,
rename it. isShortGI -> is_short_gi

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 1b1cb9514028..43249b9cda44 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -88,10 +88,10 @@ static u16 ht_mcs_to_data_rate(struct rtllib_device *ieee, u8 mcs_rate)
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
 	u8	is_40mhz = (ht_info->cur_bw_40mhz) ? 1 : 0;
-	u8	isShortGI = (ht_info->cur_bw_40mhz) ?
+	u8	is_short_gi = (ht_info->cur_bw_40mhz) ?
 			    ((ht_info->cur_short_gi_40mhz) ? 1 : 0) :
 			    ((ht_info->cur_short_gi_20mhz) ? 1 : 0);
-	return MCS_DATA_RATE[is_40mhz][isShortGI][(mcs_rate & 0x7f)];
+	return MCS_DATA_RATE[is_40mhz][is_short_gi][(mcs_rate & 0x7f)];
 }
 
 u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 data_rate)
@@ -99,24 +99,24 @@ u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 data_rate)
 	u16	cck_of_dm_rate[12] = {0x02, 0x04, 0x0b, 0x16, 0x0c, 0x12, 0x18,
 				   0x24, 0x30, 0x48, 0x60, 0x6c};
 	u8	is_40mhz = 0;
-	u8	isShortGI = 0;
+	u8	is_short_gi = 0;
 
 	if (data_rate < 12)
 		return cck_of_dm_rate[data_rate];
 	if (data_rate >= 0x10 && data_rate <= 0x1f) {
 		is_40mhz = 0;
-		isShortGI = 0;
+		is_short_gi = 0;
 	} else if (data_rate >= 0x20  && data_rate <= 0x2f) {
 		is_40mhz = 1;
-		isShortGI = 0;
+		is_short_gi = 0;
 	} else if (data_rate >= 0x30  && data_rate <= 0x3f) {
 		is_40mhz = 0;
-		isShortGI = 1;
+		is_short_gi = 1;
 	} else if (data_rate >= 0x40  && data_rate <= 0x4f) {
 		is_40mhz = 1;
-		isShortGI = 1;
+		is_short_gi = 1;
 	}
-	return MCS_DATA_RATE[is_40mhz][isShortGI][data_rate & 0xf];
+	return MCS_DATA_RATE[is_40mhz][is_short_gi][data_rate & 0xf];
 }
 
 bool is_ht_half_nmode_aps(struct rtllib_device *ieee)
-- 
2.43.0


