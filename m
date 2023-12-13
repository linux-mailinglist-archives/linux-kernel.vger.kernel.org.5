Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E74D811B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377733AbjLMRyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjLMRyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:54:25 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3459B11B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:54:31 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id A099E5C03F4;
        Wed, 13 Dec 2023 12:54:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 13 Dec 2023 12:54:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=fm1; t=1702490070; x=
        1702576470; bh=i6sYGuPDBH+SwDmNT1F0jT4yWhEaJFSaHFLA9Ubs09s=; b=R
        rbMPoR7TTzlTugKb0TIKnpYgPJdSApkaSe3n5OpEL1BFJrDS3AXKGWTSsHIbTzEQ
        FCL5BuyGEm/b23u60vgmzINPEFBTAkkaVhp7n2hWT0Otxg5JBati/gw844KXTJnL
        H2PO3ZNdq9LiHKS1Z4xLsDiCE3cOmFfxxMWy6jeNiQ21mK+P/8gZc0SOxbCVJv+9
        7ZX9orvWDDdkNhgc+JZUSM+HVOV1u65bboF97E20lHFjz4NnMc0URZWLsgSbyKwi
        Q41imdXbVLd/9lO+Hpn06Dqm0ENRU2Ja91lN3j+yiegrAEY3C/kwEEfMKnZsgehU
        Icro787MIyXyBG4K6ZjEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702490070; x=
        1702576470; bh=i6sYGuPDBH+SwDmNT1F0jT4yWhEaJFSaHFLA9Ubs09s=; b=J
        kZOSNFI7hSQZh6K4Ez7MjDslPTJ6Otx+1PMukEBSVb0KCsxR7Q5AWovIMSgB3O8C
        oVSG//aW2nKdnm306wRU9EsOeQy9QCbWTLz2voPzsOf2lNFap4uFmJxAJwFvgCtd
        4t2svWOy1S6u8W4QFGjP8RwNRXFcC6eNOqqsMFz6B9hkqXqhpBhAli5UE2MKp79i
        H7PiGYl+sY3BVgc+M8PZ9o2SmSrdC1qM1lNovoKhEd+5mgoLZ439YrNZwgPNLfrC
        LuuydLIdf0rG9MKqrNDzttaG3jLIpfKRmyPtc/fXwYfA8Ft4zZRZoD9Smly8b9LS
        OdTGqL3jyPfNLcJhEbbOQ==
X-ME-Sender: <xms:1u95ZXYzGqTIEYbJZA_tSG4z7Z1byGkBp0_twsx68mSuokJhTCTgNg>
    <xme:1u95ZWYJInZ0yCPPx8YaOo1d1mxY4E5PN9wRqjpI5z7fB5KjsB11ZnQC6jm1cZ0__
    5SFTI9Y4z7kils-6xo>
X-ME-Received: <xmr:1u95ZZ_8V_Z7h0yV_INFTPrXdWHCH1UCQq_mVVpy3krYz0YtcrBYtsn2M55p5JyXlDNbdp2_GKXjH34AexZ1qqxMu7Hf7L6O48Shtsiw8V8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeljedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:1u95ZdrV5PmQzs3K5J5WyM-TcXhMwCtTiJFICpeDz27fjRU3o24zNA>
    <xmx:1u95ZSquzGurv7q-7GVGHfzdSdH0zaZ1h5saDnQ06ENmqjpWXjeh_A>
    <xmx:1u95ZTSAPkYXXUgCs4amu6homKRrg5jZFXJJP3ueqLFplZj3wzrDYQ>
    <xmx:1u95ZVU425jf1LknGeF3Z75-E6_SgFiuw4ota3HIsHCq8_fgJJTUBA>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Dec 2023 12:54:30 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 3/5] staging: rtl8192e: rename variable HTSetConnectBwMode
Date:   Wed, 13 Dec 2023 12:54:57 -0500
Message-ID: <20231213175459.5425-4-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231213175459.5425-1-garyrookard@fastmail.org>
References: <20231213175459.5425-1-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coding style issue, checkpatch Avoid CamelCase,
rename it. HTSetConnectBwMode -> ht_set_connect_bw_mode

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 6 +++---
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 9f942352a119..4c99e2db97d7 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -437,7 +437,7 @@ static u8 ht_filter_mcs_rate(struct rtllib_device *ieee, u8 *pSupportMCS,
 	return true;
 }
 
-void HTSetConnectBwMode(struct rtllib_device *ieee,
+void ht_set_connect_bw_mode(struct rtllib_device *ieee,
 			enum ht_channel_width bandwidth,
 			enum ht_extchnl_offset Offset);
 
@@ -473,7 +473,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 	print_hex_dump_bytes("%s: ", __func__, DUMP_PREFIX_NONE,
 			     pPeerHTCap, sizeof(struct ht_capab_ele));
 #endif
-	HTSetConnectBwMode(ieee, (enum ht_channel_width)(pPeerHTCap->ChlWidth),
+	ht_set_connect_bw_mode(ieee, (enum ht_channel_width)(pPeerHTCap->ChlWidth),
 			   (enum ht_extchnl_offset)(pPeerHTInfo->ExtChlOffset));
 	ht_info->cur_tx_bw40mhz = ((pPeerHTInfo->RecommemdedTxWidth == 1) ?
 				 true : false);
@@ -728,7 +728,7 @@ static void HTSetConnectBwModeCallback(struct rtllib_device *ieee)
 	ht_info->sw_bw_in_progress = false;
 }
 
-void HTSetConnectBwMode(struct rtllib_device *ieee,
+void ht_set_connect_bw_mode(struct rtllib_device *ieee,
 			enum ht_channel_width bandwidth,
 			enum ht_extchnl_offset Offset)
 {
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index eef7c2b8c660..ff7fef68e309 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1751,7 +1751,7 @@ int rtllib_wx_get_rts(struct rtllib_device *ieee, struct iw_request_info *info,
 		      union iwreq_data *wrqu, char *extra);
 #define MAX_RECEIVE_BUFFER_SIZE 9100
 
-void HTSetConnectBwMode(struct rtllib_device *ieee,
+void ht_set_connect_bw_mode(struct rtllib_device *ieee,
 			enum ht_channel_width bandwidth,
 			enum ht_extchnl_offset Offset);
 void ht_update_default_setting(struct rtllib_device *ieee);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 31a072e2a6d7..a6de4db9a9cc 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1112,7 +1112,7 @@ static void rtllib_associate_procedure_wq(void *data)
 	mutex_lock(&ieee->wx_mutex);
 
 	rtllib_stop_scan(ieee);
-	HTSetConnectBwMode(ieee, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_EXT);
+	ht_set_connect_bw_mode(ieee, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_EXT);
 	if (ieee->rf_power_state == rf_off) {
 		ieee->rtllib_ips_leave_wq(ieee->dev);
 		mutex_unlock(&ieee->wx_mutex);
-- 
2.41.0

