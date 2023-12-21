Return-Path: <linux-kernel+bounces-7791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C98A81AD0E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FAAF1C22EA4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC19B673;
	Thu, 21 Dec 2023 03:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="nsy9PIGX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YSFecz5c"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D972EA947
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 03:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id A63333200A8D;
	Wed, 20 Dec 2023 22:09:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 20 Dec 2023 22:09:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1703128188; x=
	1703214588; bh=NFwX6DpI/WDWMxbg2l+n1YK4Zppa2WdhFie4RInmDDo=; b=n
	sy9PIGXoJl8MlHl//j7yCZzYQuFBwDmp9H3FWwxoZfDrCaVWwvdVCkEr/MjDm2SE
	iBXCdce6v93yu+3SUwn8ulHhzfkKbPsY0jANrbr3ktomQV6/fH9cnCUpy0kQyL7+
	g9oAPXuqBqKkc3JrXalh3DM1nqjMM4SKc1Y++MI3Yju0ZkFjp/CIX1ioQG4xOr/V
	fhN04zE6nDhn48mpOJmjHsV4sW1y73etnNg1GsHnaRzuXO2YpPZlzA+spiDWofxf
	+vwpUWp53xuw/FBfovqvVSwDezYDsLoYta/QWptt7Gwx9bKZq+BPqjKi0m/VcAPM
	YfOQSqQQ7StRMdsCn6zbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703128188; x=
	1703214588; bh=NFwX6DpI/WDWMxbg2l+n1YK4Zppa2WdhFie4RInmDDo=; b=Y
	SFecz5cmZUg9Cl1vPXYbdxMy+Phhzt2k70FZCBfVcGvzpDndLgiKxq9P8K+ZqT/k
	nkyhH/vy8uHnoeeV7xnQCZMYSKNruvCvg8ivt5gOTqKIpKzsHSWa5a8v10cbOvzl
	BiW1mntG/cJshuF+p2O5GrLJIUl+06yRiMs8uVEsALCgfVatScweT9s7XFqhrGOT
	DbIPWah6YL4Uc3MpRA9ajzTP+d6RNa+96hCXDgy6E9QRk3pvKNrX4hu0/+A3RX4v
	itwRtkyHjd72T3LBawnHcxEQGN2lNSZ2Rbo+OszpFfd1ENBOjo1iiN+osF2IwMEP
	ep146nRTwroFUei7i3wuw==
X-ME-Sender: <xms:e6yDZbDVOv2Cu4L6j4qL6WvJSW2USBZ_CGr4WjnI4Fgnmsp1qEhx-Q>
    <xme:e6yDZRg4P5Tb40BSC2XCYSUqT0PbAg_3hUMlNmc9TNbSbwopvVW_bRHoA9WHzoCFw
    RPfRCfhrdr_viH2-00>
X-ME-Received: <xmr:e6yDZWnK0GgIdJ3RIjt_gHnOVvJWEFZTqYxJ2LqDHKk3uOO2yxbC5sr9GdD4T82T3dReU8ZZdba84V_2wrKWTv4Q4cVfEfly>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddufedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:fKyDZdzwbyJ7a9PLHjeunXRhxAFmP8n_mPaUM8cBUvspoOMwaMce7g>
    <xmx:fKyDZQT6IktMnxQvSnIQvpGEov90yzN0xbzRC_dDKZU38DTtcUgrnA>
    <xmx:fKyDZQaoGt_QRxZ7bRL2P3fT2YOHL9uoag0Wh095ewUiUIwEMTTdKQ>
    <xmx:fKyDZWfIUTn6IuszC9dFIB51f4xS1wGW1sGaX5vakjygb1t_1H4Efg>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Dec 2023 22:09:47 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@list.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 3/5] staging: rtl8192e: rename variable HTCCheck
Date: Wed, 20 Dec 2023 22:10:02 -0500
Message-ID: <20231221031004.14779-4-garyrookard@fastmail.org>
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
rename it. HTCCheck -> ht_c_check

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index a32f3553df93..5698b48fdcc9 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -622,7 +622,7 @@ void HT_update_self_and_peer_setting(struct rtllib_device *ieee,
 }
 EXPORT_SYMBOL(HT_update_self_and_peer_setting);
 
-u8 HTCCheck(struct rtllib_device *ieee, u8 *pFrame)
+u8 ht_c_check(struct rtllib_device *ieee, u8 *pFrame)
 {
 	if (ieee->ht_info->current_ht_support) {
 		if ((IsQoSDataFrame(pFrame) && Frame_Order(pFrame)) == 1) {
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 78eae7daa351..341d9ddc9a1f 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1767,7 +1767,7 @@ u8 ht_get_highest_mcs_rate(struct rtllib_device *ieee, u8 *pMCSRateSet,
 		       u8 *pMCSFilter);
 extern u8 MCS_FILTER_ALL[];
 extern u16 MCS_DATA_RATE[2][2][77];
-u8 HTCCheck(struct rtllib_device *ieee, u8 *pFrame);
+u8 ht_c_check(struct rtllib_device *ieee, u8 *pFrame);
 void ht_reset_iot_setting(struct rt_hi_throughput *ht_info);
 bool is_ht_half_nmode_aps(struct rtllib_device *ieee);
 u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate);
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 5f219cfb65eb..595ec9af25ea 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -857,7 +857,7 @@ static size_t rtllib_rx_get_hdrlen(struct rtllib_device *ieee,
 	size_t hdrlen;
 
 	hdrlen = rtllib_get_hdrlen(fc);
-	if (HTCCheck(ieee, skb->data)) {
+	if (ht_c_check(ieee, skb->data)) {
 		if (net_ratelimit())
 			netdev_info(ieee->dev, "%s: find HTCControl!\n",
 				    __func__);
@@ -1401,7 +1401,7 @@ static int rtllib_rx_Monitor(struct rtllib_device *ieee, struct sk_buff *skb,
 		return 0;
 	}
 
-	if (HTCCheck(ieee, skb->data)) {
+	if (ht_c_check(ieee, skb->data)) {
 		if (net_ratelimit())
 			netdev_info(ieee->dev, "%s: Find HTCControl!\n",
 				    __func__);
-- 
2.43.0


