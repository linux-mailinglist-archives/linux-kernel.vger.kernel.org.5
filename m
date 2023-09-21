Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2D17A9140
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 05:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjIUDWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 23:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjIUDVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 23:21:40 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C885DF5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 20:21:34 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1d682fd3c58so283989fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 20:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1695266494; x=1695871294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtRvKPT9+7eyOX/zT8mRxryLZr0gtKfNxCNmwldDtxU=;
        b=XVc0ylKjUxWnuogapF8RrY35487ZKl17Y0I56UbhK9aaBVG6e3ZA0UdaPFtyWHL806
         RCPLaX5xHKF+Zo1qOjeQWSIaRMygLkh/a4A/BoFSBgm8C7TuDg/vli785h5Z1hYxfuxl
         W1bDOYVT+sc1CPUPZuroGFaHdHIUJ141UzgAvgihZQpjFWjhTZ5nPIQaVCJaNQLG4flL
         TfnrGrNX9mk+MTilKydG3JV4gQz01NBqhh2ALdSWhM1FSCuXTDRVYdr3mVFzhVjoh8mU
         8+t8bRT/zXJWSFhHfbHeNpxO8GByQlqCUKiz96a6hYiQew+qOXWXDgfg1C9iwYG17H28
         0Fkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695266494; x=1695871294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtRvKPT9+7eyOX/zT8mRxryLZr0gtKfNxCNmwldDtxU=;
        b=JKRHMGF3O3AWPAiCSil9j/l2YTq0fy9ocbGTrjMfjKUuburQET+JTHqXJ76cT4Gwp9
         /IagYcRy5gJn1ysTTN1oiyTXMwmsppMjOFnBNnMJvx+hAnLKMRrAgFFv7jS5ZdxqZ61Y
         ApRe84YM4r8OkqHxHbLZOmcvbGRgEa2BMwYn8Wr96vAnNo6VQx01C+Cvjym0bCZbCdyo
         zYRLMt+XGU8CsyPEyYmR8RzR37rY4fSajoYCQe70zCYaXILFDRJLRfAxD26o0r650iH5
         mgeveP4L9q7tsU3cc1IH7SoaUmjL2vSCIyAbs9tveoutx4vgnJyEajjkPfesq37fqWIo
         bdOQ==
X-Gm-Message-State: AOJu0Yx2XnytWreQ9vRHPWsDamp+K876VmVPFpHGXpwGhMA1hVzOtuiO
        Mhgb+vyjXFrZFkP9vFILL+gubA==
X-Google-Smtp-Source: AGHT+IEbX8Qo9V4QuueKm1KdT+rcfOJ1gMmzn3ve2in8nVuvW+Hh4gvNkRQ99n1WWgiQVfRd8wpWUA==
X-Received: by 2002:a05:6870:8a27:b0:1d5:bb9e:a30e with SMTP id p39-20020a0568708a2700b001d5bb9ea30emr4757501oaq.34.1695266494121;
        Wed, 20 Sep 2023 20:21:34 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id p14-20020a62ab0e000000b0068e49cb1692sm237324pff.1.2023.09.20.20.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 20:21:33 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 08/11] Staging: rtl8192e: Rename variable Policy
Date:   Wed, 20 Sep 2023 20:25:12 -0700
Message-ID: <20230921032515.96152-9-tdavies@darkphysics.net>
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

Rename variable Policy to policy to fix checkpatch warning Avoid
CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 4 ++--
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index a5676f01855b..5fc4038708b6 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -462,7 +462,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 }
 
 void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *pTS,
-			   u8 Policy, u8	bOverwritePending)
+			   u8 policy, u8	bOverwritePending)
 {
 	struct ba_record *pBA = &pTS->TxPendingBARecord;
 
@@ -473,7 +473,7 @@ void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *pTS,
 
 	pBA->dialog_token++;
 	pBA->ba_param_set.field.amsdu_support = 0;
-	pBA->ba_param_set.field.ba_policy = Policy;
+	pBA->ba_param_set.field.ba_policy = policy;
 	pBA->ba_param_set.field.tid = pTS->TsCommonInfo.TSpec.f.TSInfo.field.ucTSID;
 	pBA->ba_param_set.field.buffer_size = 32;
 	pBA->ba_timeout_value = 0;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index b518e23ff558..427f97325e87 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1834,7 +1834,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb);
 void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *pTS,
-			   u8 Policy, u8 bOverwritePending);
+			   u8 policy, u8 bOverwritePending);
 void rtllib_ts_init_del_ba(struct rtllib_device *ieee,
 			   struct ts_common_info *pTsCommonInfo,
 			   enum tr_select TxRxSelect);
-- 
2.39.2

