Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7A380F3B7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376786AbjLLQ4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376346AbjLLQ4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:56:09 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1290B95
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:56:16 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.west.internal (Postfix) with ESMTP id 297343200AB1;
        Tue, 12 Dec 2023 11:56:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 12 Dec 2023 11:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=fm1; t=1702400174; x=
        1702486574; bh=2mXfL9IW6ycYX1z5aGtzBPjpQKShBvxr7MP2joA8Ff0=; b=W
        EAUY6PIAYEdSdAvllHW8+K/osMQbRZQuok6/V6S+hrklACABt7NoqUtW+pJGjTBQ
        re3gpqb4m7HLdKxotPG+i7O5+pmuTwWPw/sqG8ZLv26vNYTpRHCB83TDKu68xAJD
        z05eF/RB88oNP4aMrhBHok6PU0vJnuDCFrn97n4SNFNDKfWKJu1sboPPsPRyLGQ6
        UnCR//TaYLs5PJNXr2lRO+pqc+LA9PaEOVn+X69m77PcxQH3JXY8XOLyQ17HdVFg
        qcrNYpL/blCpwOnPrE53LpebyhFnmIr/rgdobop5GP8BWk0q1q1THnZmAe//4mbB
        qzwFJeUtshcTidmX5ZVzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702400174; x=
        1702486574; bh=2mXfL9IW6ycYX1z5aGtzBPjpQKShBvxr7MP2joA8Ff0=; b=p
        31OgRRR+OqzIINM3SxEDR1iv+MYRU1V5chOhefsJwsyMI8rIxNFVctqHN8zxc+cr
        R3HIeLPsuQhmA3ArT25oVq57HuI2sZiBILFQQD6UsFD7NZWFyJeu/6QbGLth4RdL
        RHUaVt763djjm5Sicw50Hxmlv2TlwfEGUfEhYyjV3qfomcrEhmmr83PO41Q3GrRx
        RYqGwHmOWFKu/KopGCh+PbQEdhcv/pIunFoLroGr6aLELtgBWdKRzxOYSeLv7Vpb
        /dEyCz14nOCHQPP+PBv9e4MFcEc7ZTRbt9Z7UDyT1/ssxLBuGNCu/m52P2Ens1vU
        v8qZvTCuBmzF1Focyh5RA==
X-ME-Sender: <xms:rpB4ZYzKNK7rJ12ZTXbVvlZNkPKs2YeA36TXjIhQkhqmgGy4tZPc1Q>
    <xme:rpB4ZcQhegMeR_IK3FJ2BS10avEAX0qssVZmebu9csD85tuJmfcKSSFWkfFBfSwCG
    BJ5aJ34HSEM92fariw>
X-ME-Received: <xmr:rpB4ZaXQZkUD0KGG5jwJzWhdnW9_GpQjJXJLBqUJSISQ8JyGSQn65PJPwakKjR5mgsXa0Hk-m1q4Hugo3e4kqulAyO6rPIfRw38wn-KDlo8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelgedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:rpB4ZWiAOp9OitiprrkV8Y_F0BxKAf_Mqwf2Vx0J6ylTrcFNAju-pA>
    <xmx:rpB4ZaDgaSck59Wrvzwg44EyVE9UYI-qeLwR3QirlHzliifoEc0Miw>
    <xmx:rpB4ZXIASzz2M2_Yk3NhasOZ53gaSv3latN1P19vQd2YkKC3KOr2_A>
    <xmx:rpB4ZVNCFB-WV9FdTYDvH_tYqV6DW5Dy_tBarvKlm2maOaRUCHn_Pg>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Dec 2023 11:56:14 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 3/5] staging: rtl8192e: rename variable bAssoc
Date:   Tue, 12 Dec 2023 11:56:35 -0500
Message-ID: <20231212165637.17618-4-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212165637.17618-1-garyrookard@fastmail.org>
References: <20231212165637.17618-1-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coding style issue, checkpatch Avoid CamelCase,
rename it. bAssoc -> assoc

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index b6e9b7e000ef..ac85151a6069 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -248,7 +248,7 @@ void ht_reset_iot_setting(struct rt_hi_throughput *ht_info)
 }
 
 void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
-				  u8 *len, u8 is_encrypt, bool bAssoc)
+				  u8 *len, u8 is_encrypt, bool assoc)
 {
 	struct rt_hi_throughput *pHT = ieee->ht_info;
 	struct ht_capab_ele *pCapELE = NULL;
@@ -260,7 +260,7 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 	}
 	memset(pos_ht_cap, 0, *len);
 
-	if ((bAssoc) && (pHT->ePeerHTSpecVer == HT_SPEC_VER_EWC)) {
+	if ((assoc) && (pHT->ePeerHTSpecVer == HT_SPEC_VER_EWC)) {
 		static const u8	EWC11NHTCap[] = { 0x00, 0x90, 0x4c, 0x33 };
 
 		memcpy(pos_ht_cap, EWC11NHTCap, sizeof(EWC11NHTCap));
@@ -308,7 +308,7 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 
 	pCapELE->ASCap = 0;
 
-	if (bAssoc) {
+	if (assoc) {
 		if (pHT->iot_action & HT_IOT_ACT_DISABLE_MCS15)
 			pCapELE->MCS[1] &= 0x7f;
 
-- 
2.41.0

