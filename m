Return-Path: <linux-kernel+bounces-19064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E96826765
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 04:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35C611C2185C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 03:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CCE13AE3;
	Mon,  8 Jan 2024 03:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="EIP7ciim";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="9ezDmld7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4969112B8F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 03:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 24B6032012AF;
	Sun,  7 Jan 2024 22:22:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 07 Jan 2024 22:22:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1704684165; x=
	1704770565; bh=TQ+vAMCace025Yta24D3XLwxWST60kKGlqxwczS5tME=; b=E
	IP7ciim4pJE6R8cI1u/J/wZncFKfHm7aXexyhTXHym1K1u7MhRHukNjzy9xrTe+t
	d/rkg9QKGuGHvcNmDkBdM3mjzggPPWjrLEMcyqhwot5dgus7+RoQztPre5KbE1Mu
	3PNdcfQSjeVqG0uTPiKOfDm0bGLh/06EPNZyDT0t3DKpc33FyUeDXWlYL+aOsecw
	KhlQFpNkrTwAJgdncqQa+guuEe0qu+snrupZG5KwBWuNgZ08CvrcTgqPmyHPAB+h
	CaPYi5VBrCsFeDRyEWJsbnyXx0CpEtMambGf2gZwqMPE8aP2bWZwZ3siaD0/2qgN
	mjmt1BxXdogh3aThL0/xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704684165; x=
	1704770565; bh=TQ+vAMCace025Yta24D3XLwxWST60kKGlqxwczS5tME=; b=9
	ezDmld7IzQVNGhKxKOHGot3l9SLGF4/ikwUDYV3lSpIZdDJlei9nKRmWFJJ7SNk6
	VANQwTmXFpB3cqYifPlWv8vdAd84HNAWbKaOMG0HyHnhu8BpCckocujjuBdkzFVD
	gwwAhMxaIYIokQ9yH+Lu4LehGpXfo75CMq1kxF4KBDFKet5Xw/QLIngnpigmdAf/
	prllMWQN+9ZAP+8uQdX7cToVVLIFs61e1WSOLHag9jZdnCs9MAE36+xT/nkENB2A
	tTJ5zz5Zy7u+l3VuR1onzlpgTTYqSuf4nu2dD6yKsWUV/dWIZfW8CyjmaRqlGmmN
	teZOmibtpEXJYdRPlm6AQ==
X-ME-Sender: <xms:hWqbZZ7WoyASM2M8zhODk3c8mxs3mNbueKQexla5obNbMQEHBYtkrg>
    <xme:hWqbZW5xMj4WgU824LkBrdtB42zx9u1I28gUOyTdJ8bnvSzpSHfNp0uJNRkT3HPYt
    zEuei6wPRcCq4BC-QY>
X-ME-Received: <xmr:hWqbZQd4K7q6TpiHbNezHnHlFesyryWrv6jtydoBOCjO3CUA28_loIVr5w5wNZkcqsPnwr9SYpsFWihF2ayr3_XIxNUOPtWE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehhedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:hWqbZSLRr08smvrotEkqP4jqd7naAdO_iUckPTMNWLzSpW-W70udDQ>
    <xmx:hWqbZdJbXGdCIRA7KKcJ7scXcOdzV4cPp0O9M5APmP3PyHIplGnJmA>
    <xmx:hWqbZbxgUD8kGLlC46mkkShCgUiIYoNj1T7vq6xd8bo80CAZIp7SEQ>
    <xmx:hWqbZd2hRbrflTR5NjaGMTK0NlNrQHwWcDUrShTAUl4va08LgpKvpg>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Jan 2024 22:22:45 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 1/5] staging: rtl8192e: rename variable is40MHz
Date: Sun,  7 Jan 2024 22:22:29 -0500
Message-ID: <20240108032233.4280-2-garyrookard@fastmail.org>
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

Coding style issue, checkpatch avoid CamelCase,
rename it. is40MHz -> is_40mhz

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 6d0912f90198..1b1cb9514028 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -87,36 +87,36 @@ static u16 ht_mcs_to_data_rate(struct rtllib_device *ieee, u8 mcs_rate)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	u8	is40MHz = (ht_info->cur_bw_40mhz) ? 1 : 0;
+	u8	is_40mhz = (ht_info->cur_bw_40mhz) ? 1 : 0;
 	u8	isShortGI = (ht_info->cur_bw_40mhz) ?
 			    ((ht_info->cur_short_gi_40mhz) ? 1 : 0) :
 			    ((ht_info->cur_short_gi_20mhz) ? 1 : 0);
-	return MCS_DATA_RATE[is40MHz][isShortGI][(mcs_rate & 0x7f)];
+	return MCS_DATA_RATE[is_40mhz][isShortGI][(mcs_rate & 0x7f)];
 }
 
 u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 data_rate)
 {
 	u16	cck_of_dm_rate[12] = {0x02, 0x04, 0x0b, 0x16, 0x0c, 0x12, 0x18,
 				   0x24, 0x30, 0x48, 0x60, 0x6c};
-	u8	is40MHz = 0;
+	u8	is_40mhz = 0;
 	u8	isShortGI = 0;
 
 	if (data_rate < 12)
 		return cck_of_dm_rate[data_rate];
 	if (data_rate >= 0x10 && data_rate <= 0x1f) {
-		is40MHz = 0;
+		is_40mhz = 0;
 		isShortGI = 0;
 	} else if (data_rate >= 0x20  && data_rate <= 0x2f) {
-		is40MHz = 1;
+		is_40mhz = 1;
 		isShortGI = 0;
 	} else if (data_rate >= 0x30  && data_rate <= 0x3f) {
-		is40MHz = 0;
+		is_40mhz = 0;
 		isShortGI = 1;
 	} else if (data_rate >= 0x40  && data_rate <= 0x4f) {
-		is40MHz = 1;
+		is_40mhz = 1;
 		isShortGI = 1;
 	}
-	return MCS_DATA_RATE[is40MHz][isShortGI][data_rate & 0xf];
+	return MCS_DATA_RATE[is_40mhz][isShortGI][data_rate & 0xf];
 }
 
 bool is_ht_half_nmode_aps(struct rtllib_device *ieee)
-- 
2.43.0


