Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7F1781BDA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 02:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjHTA56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjHTA5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:57:18 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42A87D82B
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:31 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b9e478e122so1651402a34.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692492331; x=1693097131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysy6KqWBdSIiPtqdG1q8s0EmvM3hksz/JnZTcoVMaYg=;
        b=SDqR35oC2HkOSMM1WGpi3NWTOWCkl43q3xZ5Gko3Vhvt7aQOmQqc/wnfKjTR0SEDR1
         DwJM6J82Gp3Wo7SGU4WJkqBeBZqoqdMHOtqNV2vOjppVynr9xA+YGKtOf+rK1pox1GHx
         3Z886WniKdEsCzRZ9frmXiMx3A+RAh++1Gol0bPsVVmezEMuY4GKtGFb2WcqMknaPcB6
         b+TZGtN9zYnwRnGFmCXIwoS12nc5faznB46vYMotjommIKvBUgNPOajLHHIHzQBUU7QR
         TGgJwQkQB8/L2ixvH5SiiqXc6nGwSPtS2iSssPc1CU2sxkARfNfpl8QBc5fQLiwdgsOw
         YnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692492331; x=1693097131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysy6KqWBdSIiPtqdG1q8s0EmvM3hksz/JnZTcoVMaYg=;
        b=ffxiDXjb9RShgZGTV5i2tHbxOXjkQ332aODndDpQNlXEH+UmDAHwpbDAOh+vyAmvOg
         rhWVk0zx9slsNc98+XLVepB/qSzRIx09AhhK4ohIgxErEGDRYY6cjASGXu955HkKFBoo
         dlVu8T9r+2sFUHK8GtExPwIdlXhOp16WtvpaVyHchtP/91fDj/i2KgOjbh3D0QumxeaV
         47aavXG8LfC+7At6dPks+tQTkEJl9mH+3teJr4pKOZxiisBbKbYw1IFjfFxEiAJhIfny
         F+giPm1Sra7RJZ+YBAgv7ZTj3ok06UHqrERUrX7aUkC3Hw4BbNCI+SfSovuBzFSDKhG6
         8V0g==
X-Gm-Message-State: AOJu0YxSB67c6fyvauCvwKQXH9CTiQNuMoL0L4+igdOKvqcdWjIoAqn9
        VLjat5VHptcR5KQnfXFdWZBcEw==
X-Google-Smtp-Source: AGHT+IHOF0/g/YsZ5K8+gBCvADVjrSIfrL9ZcK0dM/YcukPXFZacvttvxqKEdBr/qhW1XVPQsOb1fw==
X-Received: by 2002:a05:6870:32ce:b0:1c0:131b:2bb8 with SMTP id r14-20020a05687032ce00b001c0131b2bb8mr4532785oac.58.1692492331213;
        Sat, 19 Aug 2023 17:45:31 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a1a1900b00268b439a0cbsm4004884pjk.23.2023.08.19.17.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 17:45:30 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 16/16] Staging: rtl8192e: Rename variable pTS in function rtllib_rx_InfraAdhoc()
Date:   Sat, 19 Aug 2023 17:47:44 -0700
Message-ID: <20230820004744.278022-17-tdavies@darkphysics.net>
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

Rename variable pTS in function rtllib_rx_InfraAdhoc() to ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 491789ebcc08..53ec4f077bd8 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1280,7 +1280,7 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 	struct rtllib_hdr_4addr *hdr = (struct rtllib_hdr_4addr *)skb->data;
 	struct lib80211_crypt_data *crypt = NULL;
 	struct rtllib_rxb *rxb = NULL;
-	struct rx_ts_record *pTS = NULL;
+	struct rx_ts_record *ts = NULL;
 	u16 fc, sc, SeqNum = 0;
 	u8 type, stype, multicast = 0, unicast = 0, nr_subframes = 0, TID = 0;
 	u8 dst[ETH_ALEN];
@@ -1386,7 +1386,7 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 		&& (!bToOtherSTA)) {
 		TID = Frame_QoSTID(skb->data);
 		SeqNum = WLAN_GET_SEQ_SEQ(sc);
-		GetTs(ieee, (struct ts_common_info **)&pTS, hdr->addr2, TID,
+		GetTs(ieee, (struct ts_common_info **)&ts, hdr->addr2, TID,
 		      RX_DIR, true);
 		if (TID != 0 && TID != 3)
 			ieee->bis_any_nonbepkts = true;
@@ -1425,10 +1425,10 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 	}
 
 	/* Indicate packets to upper layer or Rx Reorder */
-	if (!ieee->ht_info->cur_rx_reorder_enable || pTS == NULL || bToOtherSTA)
+	if (!ieee->ht_info->cur_rx_reorder_enable || ts == NULL || bToOtherSTA)
 		rtllib_rx_indicate_pkt_legacy(ieee, rx_stats, rxb, dst, src);
 	else
-		RxReorderIndicatePacket(ieee, rxb, pTS, SeqNum);
+		RxReorderIndicatePacket(ieee, rxb, ts, SeqNum);
 
 	dev_kfree_skb(skb);
 
-- 
2.41.0

