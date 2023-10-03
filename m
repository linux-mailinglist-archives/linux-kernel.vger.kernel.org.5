Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755117B5F40
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 05:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjJCDOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 23:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjJCDOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 23:14:40 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C72BF
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 20:14:28 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2777a5e22b5so327321a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 20:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1696302868; x=1696907668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdDtuGytLFT9IW88tdQfedwXf3aK1VXTnCUS+xcMTlk=;
        b=jBciF/Km4rFosGB2B06pTZGVqIjq7ik+yKrr8Cey9fauV+gZa1cGVeEzLHcI9hM62h
         eCudtbeWtFTh6PHYEXwi9Xd3bTX99G7h53wgebAr4c+OPlL65vPmKSyngs3BtMaiJAxZ
         vMdtoR9pmLne3Ylg+uhk8jTI/65PwFU9H8SJJNsCTxPwK9kh+HpOKyWP9JVotqH6G2Qt
         9SniQ7h11BsaBc474k4lMejt7K1JgW7gj2NCwrckxqPGzr9jScspMfIv2tnfTOaiz+QR
         F8f9wPK5ic7J/gjLyFqwC/IgVdDbP06KIfM0XELbJE/sfliZA//5yaWb5hm/2hCR+cun
         e//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696302868; x=1696907668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdDtuGytLFT9IW88tdQfedwXf3aK1VXTnCUS+xcMTlk=;
        b=fBI6PkdItBMd4E+8WoJmteIIOaG0w3UEVR677maYmLANl/z7vwsBseEAsOv0TQKIl7
         JEHErQ9dAfLICFMSIlR/HRGateTd/U1xUcB26bedwamR/K+qMZuFegZqPMBcGzp3PlZB
         PQyupruSnsy8ftGcYw/R3DQT+uOIW6l7+mQ8nco9fq2VjUPGYiy3TJ8oh/H6D6yuc+Sz
         9ywN8MaBzZEE6EWGxZbAmq9EMWPffLWf6ZGnsLTPPMrHPcaz7ZplGCNrChGAKf7jUihs
         5ClTgGM1vHStlB79Kkk/gIvvxI9aUoloFYQG4G8VuBxnlYVAiuVRficC4tw/Cb7dffaH
         Q5Yg==
X-Gm-Message-State: AOJu0Yw2jBG0bjHAiEauJj79yYZnmZ37HCucJP4zCJhyhm0LIHaNMDep
        lFpJfiFwBWMrxLnPFjphWSQabcZO9oebhgwPzuU=
X-Google-Smtp-Source: AGHT+IHnuJffE5JV7HDcEWJy7lQJD1MY0djTIwoKMU+AZYkERpg6pj/LwXUvVnnwfJgkusBAqxJCeg==
X-Received: by 2002:a17:90b:2342:b0:277:33b1:94dd with SMTP id ms2-20020a17090b234200b0027733b194ddmr12998152pjb.38.1696302867698;
        Mon, 02 Oct 2023 20:14:27 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 11-20020a17090a004b00b00273fc850342sm7692550pjb.20.2023.10.02.20.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 20:14:27 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 1/3] Staging: rtl8192e: Rename variable pTSInfo
Date:   Mon,  2 Oct 2023 20:18:47 -0700
Message-ID: <20231003031849.176743-2-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003031849.176743-1-tdavies@darkphysics.net>
References: <20231003031849.176743-1-tdavies@darkphysics.net>
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

Rename variable pTSInfo to ts_info to fix checkpatch warning Avoid
CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index a482acd5ee06..eaa2a82558f1 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -242,7 +242,7 @@ bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 {
 	u8	UP = 0;
 	union tspec_body TSpec;
-	union qos_tsinfo *pTSInfo = &TSpec.f.TSInfo;
+	union qos_tsinfo *ts_info = &TSpec.f.TSInfo;
 	struct list_head *pUnusedList;
 	struct list_head *pAddmitList;
 	enum direction_value Dir;
@@ -318,15 +318,15 @@ bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 		netdev_dbg(ieee->dev,
 			   "to init current TS, UP:%d, Dir:%d, addr: %pM ppTs=%p\n",
 			   UP, Dir, addr, *ppTS);
-		pTSInfo->field.ucTrafficType = 0;
-		pTSInfo->field.ucTSID = UP;
-		pTSInfo->field.ucDirection = Dir;
-		pTSInfo->field.ucAccessPolicy = 1;
-		pTSInfo->field.ucAggregation = 0;
-		pTSInfo->field.ucPSB = 0;
-		pTSInfo->field.ucUP = UP;
-		pTSInfo->field.ucTSInfoAckPolicy = 0;
-		pTSInfo->field.ucSchedule = 0;
+		ts_info->field.ucTrafficType = 0;
+		ts_info->field.ucTSID = UP;
+		ts_info->field.ucDirection = Dir;
+		ts_info->field.ucAccessPolicy = 1;
+		ts_info->field.ucAggregation = 0;
+		ts_info->field.ucPSB = 0;
+		ts_info->field.ucUP = UP;
+		ts_info->field.ucTSInfoAckPolicy = 0;
+		ts_info->field.ucSchedule = 0;
 
 		MakeTSEntry(*ppTS, addr, &TSpec, NULL, 0, 0);
 		list_add_tail(&((*ppTS)->List), pAddmitList);
-- 
2.39.2

