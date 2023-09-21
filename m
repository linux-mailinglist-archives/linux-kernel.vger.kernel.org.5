Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E0E7A9141
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 05:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjIUDWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 23:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIUDVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 23:21:39 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6C4F4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 20:21:33 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3adba522a5dso327946b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 20:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1695266493; x=1695871293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdTofcyZS0AKt9ZBJvnueeLkRS3GUhVVwU6EDW/iNno=;
        b=hQVwxXvOczekdy6uYEEk04Gqe26fpZnooOvR5ytEdMyZlFSDPgKO5GNAG+MBr1lmWu
         ghAjiCft7mLnFIxNnPieTsxKOV/rsyqfHQgtgM2EosJML2SNo/jSjgplT+UKSRlRU+Bs
         oLrjkUYRw059b/29MWUN0WfZSgDMAxGKwi+f/ly6htMSO4Y0N0z6Yxm/96Fm0QyIV1zG
         IcyASbreol0pIZMOFZKeV2wPjY+FuxsXFOQ4Nz5Tw0Rpb7Y3pgfNrU41rSxkkc2avDxk
         VLr+j07UOHM4lraPdhAKl0I02Hd31H85XsA7301g1PKKgu8GAC2N3bxUSKUP9fF8H4HK
         1heg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695266493; x=1695871293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdTofcyZS0AKt9ZBJvnueeLkRS3GUhVVwU6EDW/iNno=;
        b=dj9ElmRgO87eHRR9WUfKdKgfwX6w35Ta4ajvQJZK8ZGNn3tBVuQhyfsvVCvbCfERAw
         t38XDdrCwWxkeCxlr/6QzvdMBG5NffWTELpzIFqX5r65ATk0jKj7kYo7hyvKxaPohrvf
         o0+qEF+w/2e/Yk/pWfYh/GPxsLdbPGvuBBYo6mnsSKyR6StdUBrb8gq5SQuosSioatJ7
         OOHtm/vPcSsYMkH4m59Heh7gb+HHxCXBr2JQo4vgDH/DXkxvy99DU1a3onCXynyXR4f6
         XiHeCFB2KqHsVW+YfLM/N6rqIchxh5IdFMjdO6M/wpIgcGmFzM233fNjMyAQKNqf3WUY
         Ruww==
X-Gm-Message-State: AOJu0YwAE5dCtfs9JujxC5KkNU4nCpyehhjLhseeVOru7CGCRbwqAhzr
        1+qrDV3F6ylcVFajcOxQ6I2t1g==
X-Google-Smtp-Source: AGHT+IFggucz4dCbL4PulcvIsH7OS6MECN6T5307nBCOQYoCjWyEZ92QQjMxWX0V6iIgaZbBc04Dcg==
X-Received: by 2002:a05:6808:158c:b0:3a7:a548:d92a with SMTP id t12-20020a056808158c00b003a7a548d92amr4929603oiw.5.1695266492786;
        Wed, 20 Sep 2023 20:21:32 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id p14-20020a62ab0e000000b0068e49cb1692sm237324pff.1.2023.09.20.20.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 20:21:32 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 07/11] Staging: rtl8192e: Rename variable pStatusCode
Date:   Wed, 20 Sep 2023 20:25:11 -0700
Message-ID: <20230921032515.96152-8-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921032515.96152-1-tdavies@darkphysics.net>
References: <20230921032515.96152-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable pStatusCode to status_code to fix checkpatch warning Avoid
CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 3468bdcea7fc..a5676f01855b 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -306,7 +306,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	struct ba_record *pending_ba, *pAdmittedBA;
 	struct tx_ts_record *pTS = NULL;
 	u8 *dst = NULL, *pDialogToken = NULL, *tag = NULL;
-	u16 *pStatusCode = NULL, *pBaTimeoutVal = NULL;
+	u16 *status_code = NULL, *pBaTimeoutVal = NULL;
 	union ba_param_set *pBaParamSet = NULL;
 	u16			ReasonCode;
 
@@ -321,7 +321,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	dst = (u8 *)(&rsp->addr2[0]);
 	tag += sizeof(struct ieee80211_hdr_3addr);
 	pDialogToken = tag + 2;
-	pStatusCode = (u16 *)(tag + 3);
+	status_code = (u16 *)(tag + 3);
 	pBaParamSet = (union ba_param_set *)(tag + 5);
 	pBaTimeoutVal = (u16 *)(tag + 7);
 
@@ -362,11 +362,11 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	} else {
 		netdev_dbg(ieee->dev,
 			   "%s(): Recv ADDBA Rsp. BA is admitted! Status code:%X\n",
-			   __func__, *pStatusCode);
+			   __func__, *status_code);
 		deactivate_ba_entry(ieee, pending_ba);
 	}
 
-	if (*pStatusCode == ADDBA_STATUS_SUCCESS) {
+	if (*status_code == ADDBA_STATUS_SUCCESS) {
 		if (pBaParamSet->field.ba_policy == BA_POLICY_DELAYED) {
 			pTS->bAddBaReqDelayed = true;
 			deactivate_ba_entry(ieee, pAdmittedBA);
-- 
2.39.2

