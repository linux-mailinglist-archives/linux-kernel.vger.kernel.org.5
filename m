Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2665781BE6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 03:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjHTA6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjHTA6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:58:18 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516C47C9E4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:20 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-269304c135aso1499305a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692492320; x=1693097120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7p3fw0kwSoZpKrJw9KM7osJqs5KPh0SGVdEcaIOTdU=;
        b=RAJ9uS44fZVALqAfHfrFKcMqAsF6v1FxZKGw1B3FLwQjQz+pYcrkiGWlwXTQ92l1is
         Cdfo7nIpT7xd3eRLSQChC+8S50WePsefmzagISmFva92mf9Tt1PNIKI1gszLswmdXTjP
         NoN7/9yD+bB+wiPZe+QsVu6MyqGazUsRJrZPjo7HFqtEZmxnqKH77KmigOvCy77iJ85V
         ajYum42WGVfzCjhJSEO8Y4QVgAKVqkLdKsc3wiBWSK9LDE2Nev1V0W/1aTxCo2K7DSyP
         P+IMpOlg/Qo7fLRyzE6ZahN8lWa9Yerlw5SQaIN/l+mB0ZQZGhUNB+GDVRMyHuyKtjqT
         O1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692492320; x=1693097120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7p3fw0kwSoZpKrJw9KM7osJqs5KPh0SGVdEcaIOTdU=;
        b=Lgil5HP8CDkbZib13u2hWW2W1SoaAkjnCXS6LdP7y//4g72qqwV2a8SP56/ywoetbZ
         EPn3+gNtGCDga2l5Ym2eVzA3VI3+1P3BNesw3UZY8p7dTTRsZyfHPL/FysoYYlPWjLUt
         css8UfMxrZa47ru6Ma1An5lmSD5gCVgyJ7knLbh1fic+lXR0X766kLgdBJiJJnI1H79D
         U6S/s52rKsD+wZKkAF2P0YAd8ttyW+gnoAvwtU8TzFc1eDplOVhQEBZxBNEwQvcjVN95
         efT4c/y/rVjakas7juQbogARBCXktJbILMalJzlnUcXz9a4+ok7CwcKkcih3u7IWV+vj
         Eg7Q==
X-Gm-Message-State: AOJu0YxjdwL1aKUnjPzI609RG1B6YSkHCGE6tjiBwxDn+FjA/5OAuOUH
        BVuB3juRElV9ARJlTBHbaS4sZw==
X-Google-Smtp-Source: AGHT+IGm5IP0WszE8rWDTpMzx+0/sR6s+ScbtHYEs85ddB6aTPJgrQQZtsrwd3VH8HH/6WjHAeqpnQ==
X-Received: by 2002:a17:90a:8a95:b0:268:b7a2:62e8 with SMTP id x21-20020a17090a8a9500b00268b7a262e8mr2633842pjn.7.1692492319742;
        Sat, 19 Aug 2023 17:45:19 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a1a1900b00268b439a0cbsm4004884pjk.23.2023.08.19.17.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 17:45:19 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v3 02/16] Staging: rtl8192e: Rename variable pTS in function rtllib_rx_ADDBAReq()
Date:   Sat, 19 Aug 2023 17:47:30 -0700
Message-ID: <20230820004744.278022-3-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230820004744.278022-1-tdavies@darkphysics.net>
References: <20230820004744.278022-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable pTS in function rtllib_rx_ADDBAReq() to ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v3:Resend as 16 patch series - no longer throttled by email provider
v2:Resending in smaller patch series
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index da29163f3022..03d76765e85f 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -220,7 +220,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 	union ba_param_set *pBaParamSet = NULL;
 	u16 *pBaTimeoutVal = NULL;
 	union sequence_control *pBaStartSeqCtrl = NULL;
-	struct rx_ts_record *pTS = NULL;
+	struct rx_ts_record *ts = NULL;
 
 	if (skb->len < sizeof(struct rtllib_hdr_3addr) + 9) {
 		netdev_warn(ieee->dev, "Invalid skb len in BAREQ(%d / %d)\n",
@@ -253,13 +253,13 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 			    ieee->ht_info->bCurrentHTSupport);
 		goto OnADDBAReq_Fail;
 	}
-	if (!GetTs(ieee, (struct ts_common_info **)&pTS, dst,
+	if (!GetTs(ieee, (struct ts_common_info **)&ts, dst,
 		   (u8)(pBaParamSet->field.tid), RX_DIR, true)) {
 		rc = ADDBA_STATUS_REFUSED;
 		netdev_warn(ieee->dev, "%s(): can't get TS\n", __func__);
 		goto OnADDBAReq_Fail;
 	}
-	pBA = &pTS->rx_admitted_ba_record;
+	pBA = &ts->rx_admitted_ba_record;
 
 	if (pBaParamSet->field.ba_policy == BA_POLICY_DELAYED) {
 		rc = ADDBA_STATUS_INVALID_PARAM;
@@ -268,7 +268,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 		goto OnADDBAReq_Fail;
 	}
 
-	rtllib_FlushRxTsPendingPkts(ieee, pTS);
+	rtllib_FlushRxTsPendingPkts(ieee, ts);
 
 	deactivate_ba_entry(ieee, pBA);
 	pBA->dialog_token = *pDialogToken;
-- 
2.41.0

