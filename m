Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C52D7C7ADB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 02:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344245AbjJMAaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 20:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343497AbjJMA37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 20:29:59 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF63B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 17:29:57 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6c4bf619b57so1007899a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 17:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697156997; x=1697761797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lQmNkjrmwzSWWtINLY7udYjqrYfBzZUq+RBDqd2xGCI=;
        b=k2pV27s0PqnNJ8W7Bs8WBRIsZ+VMX+EX53bAhVFWSiKmDqDJpz63J0mihUjdScKbNS
         VHuwFZLTjAJXTchgzj6K/uT/5VcI4PlbHBSYO9TTUh3otGkBS14Vu2mU3kgaOA37bCq5
         8W16I9ReWWrobj+NLYtAWr9uV0cSSr/KME2zooTvAaAe5JJ74pa53rVE6y4YxEIH9lEZ
         o76FrdtC2yislN0vj+2NaPSh1ccIHBW9y+ik1UQggi/PrOiTr0mWk8GrCpOQlf7XQfO0
         QG41kgB3kUSXLZqP57V0YPR2zS6Wefi+Ioj+vgrTIwOMD+1snCL7EKGwwXtt7HHh/Frf
         OfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697156997; x=1697761797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQmNkjrmwzSWWtINLY7udYjqrYfBzZUq+RBDqd2xGCI=;
        b=K61WhaAycSKFEEUlzsjco61ccAH8aRw1SmWT711FMGP6h9C++zvIV7tAZ+bi++6iJv
         epWGjDIfFAIRsrws4MX8DTigEAmo2+FW8Qd5RYHNcn94QzJYHM8GKrweiknmtNG2OtHl
         GEXpUv27yc+AHjbTNoZ2nOf3dXZq9WP2+cS6rlrkOppqNVS96Laom5zIALRwahK0yxFq
         m7R9rOr6Flw0GaJhR3k3TVvWbp8Ad5aJU1MbXU3TFsuiN4GEu5t9nVtNagqw4ohaofIS
         F5j5ky3Ivp2CJapkyrmAwLagHS2V6HL2D+MVDT//TU0477iNgswLLP2pt9kWUyWYudEM
         rkIA==
X-Gm-Message-State: AOJu0YzEGaTyvWu5f/k5hJXPeFP4i5XqDpFGC/lhg4+R2pak7uNGLmeT
        yulKmpjbhNIVpRnYwbeVp4I=
X-Google-Smtp-Source: AGHT+IHs/6Ft6mMQZfzxCiHDp+QEX5s5zVr189dmmR67U2GauD6CP6SPrr3l2DlwamQXKCb6X8eBAw==
X-Received: by 2002:a05:6830:164a:b0:6bf:12:5189 with SMTP id h10-20020a056830164a00b006bf00125189mr26629234otr.26.1697156997185;
        Thu, 12 Oct 2023 17:29:57 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b2:f182:ece3:38de:3ac4:3149:fe7b])
        by smtp.gmail.com with ESMTPSA id 4-20020aa79104000000b0069305627491sm12229891pfh.159.2023.10.12.17.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 17:29:56 -0700 (PDT)
From:   Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        ruanjinjie@huawei.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, edson.drosdeck@gmail.com
Subject: [PATCH] staging: rtl8723bs: Remove unnecessary bracks
Date:   Thu, 12 Oct 2023 21:29:44 -0300
Message-Id: <20231013002944.14607-1-edson.drosdeck@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning found by checkpatch.pl script.Remove bracks than are not necessary for
a single statement blocks in hal/odm.c

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index ea3b4cd32360..b1397990680f 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -417,13 +417,11 @@ static void odm_RefreshRateAdaptiveMaskCE(struct dm_odm_t *pDM_Odm)
 	u8 i;
 	struct adapter *padapter =  pDM_Odm->Adapter;
 
-	if (padapter->bDriverStopped) {
+	if (padapter->bDriverStopped)
 		return;
-	}
 
-	if (!pDM_Odm->bUseRAMask) {
+	if (!pDM_Odm->bUseRAMask)
 		return;
-	}
 
 	for (i = 0; i < ODM_ASSOCIATE_ENTRY_NUM; i++) {
 		PSTA_INFO_T pstat = pDM_Odm->pODM_StaInfo[i];
@@ -461,9 +459,8 @@ static void odm_RefreshRateAdaptiveMaskCE(struct dm_odm_t *pDM_Odm)
 static void odm_RefreshRateAdaptiveMask(struct dm_odm_t *pDM_Odm)
 {
 
-	if (!(pDM_Odm->SupportAbility & ODM_BB_RA_MASK)) {
+	if (!(pDM_Odm->SupportAbility & ODM_BB_RA_MASK))
 		return;
-	}
 	odm_RefreshRateAdaptiveMaskCE(pDM_Odm);
 }
 
-- 
2.39.2

