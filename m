Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954947C92C6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 06:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbjJNEkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 00:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjJNEj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 00:39:59 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45389C0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 21:39:58 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-57e3c2adbf0so1475927eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 21:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1697258397; x=1697863197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mX2HZxkrDDTk+fsvecnLv5LzD6HcEuvgwVlrQ23incY=;
        b=ftjWoiVBNr5YL/SFWrSIV7kUB4qh7IB4TWSdWxZX5WBNKfJzE9hhGKwRX6KctPHDFz
         lB89NTBJGcxk3s7G7LHJqdt12g3LtPc3A34vqV9kISI9XweuKfWCNfpt4VvdZ7C35eZl
         2b11uVAp9bwsFLgmC0wxFQNRgjhl++cmsCEVU5XSeH7ozjlSsKG6B9DRNRcrG92fDttr
         ebkU1PSB5lV0Zyq+c9QIgugZsdwGCUNl3VFf00jZ8eBvrBMnYXO2eTFhghoB8n+n89P8
         oPmN+DRUAB4SxaKlpj/5oz9m/6ZdgdDWHoY0x0/ltNbc+IxNiJ08R2cIKyMlr3lh56iz
         nTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697258397; x=1697863197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mX2HZxkrDDTk+fsvecnLv5LzD6HcEuvgwVlrQ23incY=;
        b=JT1e38sM+Gs9DejN0Cwuxt/ziYGCLDoNgRea/x4G4S26OD/+y5zpr7tDtba4v8j0wW
         ioxHYdRrgJPecQxCnPBXmlSntBtnJiMtgIBzCOM3ezSTdvW1mY+vHQ+0zRG+RcYwmGJL
         x5LunPzfasGE1BZufg0gbD0ekXHIg9LYkhwJI+7HLDLViU0f+TZWi8KAoJS2R80bfxWB
         UbhAr3lzG8fFL6pEi3n51vGQxnkuN23BoSubskXCBz/9C09NMGw7fLFK7pSvZ0X7B6c9
         uIYV4VYGA+NEly4yngY+/mK9BnIoPu1nv8PFXjeI6GiugVFsqCcw+m/PvWT3jsAeqdcP
         pGpQ==
X-Gm-Message-State: AOJu0YyRvMz5XkkGY+OLsYZjyQWb0dmAN+KDegkgwutq7t5CUCkH+oXm
        bGBE5MrH69XCU5dxfMsT3GhbUQ==
X-Google-Smtp-Source: AGHT+IFwNlWt0M0if1Y6SYtl5KS20jSK1omEAcmkBly97Rf6gEIkFnakdZJmIUHsWhh7sX6O88AjNQ==
X-Received: by 2002:a05:6358:921:b0:143:8f7f:9150 with SMTP id r33-20020a056358092100b001438f7f9150mr33000446rwi.13.1697258397463;
        Fri, 13 Oct 2023 21:39:57 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id y6-20020aa78046000000b006934350c3absm14271926pfm.109.2023.10.13.21.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 21:39:57 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 3/4] Staging: rtl8192e: Rename variable ReasonCode
Date:   Fri, 13 Oct 2023 21:44:34 -0700
Message-ID: <20231014044435.11947-4-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014044435.11947-1-tdavies@darkphysics.net>
References: <20231014044435.11947-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable ReasonCode to reason_code to fix checkpatch warning
Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 26 +++++++++++------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index a5165fe88217..34fc400035c8 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -125,7 +125,7 @@ static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *dst,
 
 static struct sk_buff *rtllib_DELBA(struct rtllib_device *ieee, u8 *dst,
 				    struct ba_record *ba,
-				    enum tr_select TxRxSelect, u16 ReasonCode)
+				    enum tr_select TxRxSelect, u16 reason_code)
 {
 	union delba_param_set DelbaParamSet;
 	struct sk_buff *skb = NULL;
@@ -134,8 +134,8 @@ static struct sk_buff *rtllib_DELBA(struct rtllib_device *ieee, u8 *dst,
 	u16 len = 6 + ieee->tx_headroom;
 
 	if (net_ratelimit())
-		netdev_dbg(ieee->dev, "%s(): ReasonCode(%d) sentd to: %pM\n",
-			   __func__, ReasonCode, dst);
+		netdev_dbg(ieee->dev, "%s(): reason_code(%d) sentd to: %pM\n",
+			   __func__, reason_code, dst);
 
 	memset(&DelbaParamSet, 0, 2);
 
@@ -163,7 +163,7 @@ static struct sk_buff *rtllib_DELBA(struct rtllib_device *ieee, u8 *dst,
 	put_unaligned_le16(DelbaParamSet.short_data, tag);
 	tag += 2;
 
-	put_unaligned_le16(ReasonCode, tag);
+	put_unaligned_le16(reason_code, tag);
 	tag += 2;
 
 #ifdef VERBOSE_DEBUG
@@ -200,11 +200,11 @@ static void rtllib_send_ADDBARsp(struct rtllib_device *ieee, u8 *dst,
 
 static void rtllib_send_DELBA(struct rtllib_device *ieee, u8 *dst,
 			      struct ba_record *ba, enum tr_select TxRxSelect,
-			      u16 ReasonCode)
+			      u16 reason_code)
 {
 	struct sk_buff *skb;
 
-	skb = rtllib_DELBA(ieee, dst, ba, TxRxSelect, ReasonCode);
+	skb = rtllib_DELBA(ieee, dst, ba, TxRxSelect, reason_code);
 	if (skb)
 		softmac_mgmt_xmit(skb, ieee);
 	else
@@ -308,7 +308,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	u8 *dst = NULL, *pDialogToken = NULL, *tag = NULL;
 	u16 *status_code = NULL, *pBaTimeoutVal = NULL;
 	union ba_param_set *pBaParamSet = NULL;
-	u16			ReasonCode;
+	u16			reason_code;
 
 	if (skb->len < sizeof(struct ieee80211_hdr_3addr) + 9) {
 		netdev_warn(ieee->dev, "Invalid skb len in BARSP(%d / %d)\n",
@@ -333,14 +333,14 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 			    ieee->current_network.qos_data.active,
 			    ieee->ht_info->current_ht_support,
 			    ieee->ht_info->bCurrentAMPDUEnable);
-		ReasonCode = DELBA_REASON_UNKNOWN_BA;
+		reason_code = DELBA_REASON_UNKNOWN_BA;
 		goto OnADDBARsp_Reject;
 	}
 
 	if (!rtllib_get_ts(ieee, (struct ts_common_info **)&pTS, dst,
 		   (u8)(pBaParamSet->field.tid), TX_DIR, false)) {
 		netdev_warn(ieee->dev, "%s(): can't get TS\n", __func__);
-		ReasonCode = DELBA_REASON_UNKNOWN_BA;
+		reason_code = DELBA_REASON_UNKNOWN_BA;
 		goto OnADDBARsp_Reject;
 	}
 
@@ -357,7 +357,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 		netdev_warn(ieee->dev,
 			    "%s(): ADDBA Rsp. BA invalid, DELBA!\n",
 			    __func__);
-		ReasonCode = DELBA_REASON_UNKNOWN_BA;
+		reason_code = DELBA_REASON_UNKNOWN_BA;
 		goto OnADDBARsp_Reject;
 	} else {
 		netdev_dbg(ieee->dev,
@@ -370,7 +370,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 		if (pBaParamSet->field.ba_policy == BA_POLICY_DELAYED) {
 			pTS->bAddBaReqDelayed = true;
 			deactivate_ba_entry(ieee, pAdmittedBA);
-			ReasonCode = DELBA_REASON_END_BA;
+			reason_code = DELBA_REASON_END_BA;
 			goto OnADDBARsp_Reject;
 		}
 
@@ -383,7 +383,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	} else {
 		pTS->bAddBaReqDelayed = true;
 		pTS->bDisable_AddBa = true;
-		ReasonCode = DELBA_REASON_END_BA;
+		reason_code = DELBA_REASON_END_BA;
 		goto OnADDBARsp_Reject;
 	}
 
@@ -394,7 +394,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 		struct ba_record BA;
 
 		BA.ba_param_set = *pBaParamSet;
-		rtllib_send_DELBA(ieee, dst, &BA, TX_DIR, ReasonCode);
+		rtllib_send_DELBA(ieee, dst, &BA, TX_DIR, reason_code);
 		return 0;
 	}
 }
-- 
2.39.2

