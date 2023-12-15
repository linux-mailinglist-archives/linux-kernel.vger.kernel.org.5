Return-Path: <linux-kernel+bounces-1808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8FC81545F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A502B23196
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98925F1F1;
	Fri, 15 Dec 2023 23:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="Qej8fymQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kfkRurrw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4591456391
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 23:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 8B4AB5C01BA;
	Fri, 15 Dec 2023 18:12:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 15 Dec 2023 18:12:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1702681927; x=
	1702768327; bh=eP5A/gmHCPtTycTJxJLZQNbIr/FqbR3Kb8PAuvHL7i0=; b=Q
	ej8fymQpOvdQmzkeMoPsf0+zBdKR2X3/CAZQKBAxB4wZQVPwqAfWOAhoZQOo0ArD
	9Ix9KXq/t+30ZtewrewTAiqJe00VshfSCdH8EjTF3H2ohtpqZEHcAAr3ydZMR85C
	9q7RmtXMuypQ5oj14bnwJm8FAihd5mCF18helWtJOj4BGNbivWXZsy+RVqQrBlVx
	vrEDff/j0FFsoZjxP71wi0yRYnyANSsCvxSMroBbNzcYUH/zCxkssHu0dC/9PqOM
	f6SwRFPH5/L6EeWfbNuvVMkAAzPX1SzkS5gHYuEIvxTFSeGcbB+qxULMh9JU88LH
	E1EwRA4iKebZlFLUHNO5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702681927; x=
	1702768327; bh=eP5A/gmHCPtTycTJxJLZQNbIr/FqbR3Kb8PAuvHL7i0=; b=k
	fkRurrw2zREvBRAjfJj3ZlQWpd/cwqVEXcYacminV+9y9vtJYED21L+UIUdOxnoM
	iWh8fAg1iitaJ5LRH4h1RNv5xlFjOTKeAdy55zd2YPlxMT/j8j3tJaEpYTkkYh1H
	Gj2RHXi3nc4of2syW6hT+lnJN4oU8LCMf9M8+bFJGJKCR0JGk6uQiDffGESMmTlE
	WScUJg6gDeRR4E2/l353X5dyLr1WZtwsBL2dHEqtuNteBB7kIR3SOjqAFfFUVjNU
	P04qX3Q5+oSmR4V5RRUUWoZSkWuEbrIdnTHN5cUpxDE1rfhefA3C4kRHMWYGYR9m
	wv0LOKGOc2g1PU9BPlSuw==
X-ME-Sender: <xms:R918Zbx7XJss_4aLirAddW97yA_UbhJxCInntHARicCZ_V-xFX1LUg>
    <xme:R918ZTSz0Z5DIZskfIOdFHA13lcWmXRn83FE3miY_Th_QM4-vsgYcXWCAAd4ybnpW
    sZm5REU-6ZdfEWOXsk>
X-ME-Received: <xmr:R918ZVVdmklAjR2gUfdgMWVKCikD9UHTgyZx-ZDDv3JaMj7mAQd1CTKn4R5CTI2nho0UsySr3vrVnS_ZKz90ZRLADYj1SRAJoznfICui4BM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtfedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:R918ZViH0wuREvaC8jgVLAJnjydG3Rlnw9gJcirj9-anKX0eIbrxTg>
    <xmx:R918ZdB0DWYBIc73x35ZRTGGUeuqonRmUF5Q8jTIcejrJW5jTG_RSQ>
    <xmx:R918ZeI4VBsN1ffL0_esxXH7-lBq64mATzMIeuKzlQOOaBcYVO8Esw>
    <xmx:R918ZcMYglGmtCjb6NTuI5mRV25uoMhKnYKJmJ6I_KgeDlA81Z4mag>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Dec 2023 18:12:06 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 4/4] staging: rtl8192e: renamed variable HTFilterMCSRate
Date: Fri, 15 Dec 2023 18:12:35 -0500
Message-ID: <20231215231235.8265-5-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231215231235.8265-1-garyrookard@fastmail.org>
References: <20231215231235.8265-1-garyrookard@fastmail.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coding style issue, checkpatch Avoid CamelCase,
rename it. HTFilterMCSRate -> ht_filter_mcs_rate

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 6c1af19d67d2..0d57bcda33b4 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -397,7 +397,7 @@ u8 ht_get_highest_mcs_rate(struct rtllib_device *ieee, u8 *pMCSRateSet,
 	return mcsRate | 0x80;
 }
 
-static u8 HTFilterMCSRate(struct rtllib_device *ieee, u8 *pSupportMCS,
+static u8 ht_filter_mcs_rate(struct rtllib_device *ieee, u8 *pSupportMCS,
 			  u8 *pOperateMCS)
 {
 	u8 i;
@@ -490,7 +490,7 @@ void ht_on_assoc_rsp(struct rtllib_device *ieee)
 
 	ht_iot_act_determine_ra_func(ieee, ((pPeerHTCap->MCS[1]) != 0));
 
-	HTFilterMCSRate(ieee, pPeerHTCap->MCS, ieee->dot11ht_oper_rate_set);
+	ht_filter_mcs_rate(ieee, pPeerHTCap->MCS, ieee->dot11ht_oper_rate_set);
 
 	pMcsFilter = MCS_FILTER_ALL;
 	ieee->HTHighestOperaRate = ht_get_highest_mcs_rate(ieee,
-- 
2.41.0


