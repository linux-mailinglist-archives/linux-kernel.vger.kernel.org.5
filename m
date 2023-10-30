Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C467DB5D0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjJ3JKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjJ3JKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:10:21 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E47A8E;
        Mon, 30 Oct 2023 02:10:19 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc3bc5df96so6196815ad.2;
        Mon, 30 Oct 2023 02:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698657018; x=1699261818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0KasjG3lbdmEdowQesDN0GTK9cnTjvbboVljOhtY6nQ=;
        b=jI8dWByEhaw7PfQ4j8aNyYisJ0INMbD/8K98A3CvAuq1n03mHlKPK6dDJnj6meVgOn
         RnBuF4A++0lHmsa/OrMIYZwuaLbPdJ6wfl3xSYD2dGz6sHLZPHVHaz9zq4rqSjmIzY5x
         /y+y4YRblbKnsUJOBJvr2RLZ3mDExPdjyvNxWH9d+iIpg2KVB6BNBiqXRbcCPVkrfDxX
         6Af03juNyU1+jt52HQDuRqFFwDwMRBNxfk/ZehW/yrxcHCW90er97ECCzpyYJ7trEzUC
         mSJChkbAUAzyXy+FhMMz+iLJb8f0wOiK7m8KnQcMNCmxKmOAiDCWY7lTDTG82qTBWLKz
         wAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698657018; x=1699261818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0KasjG3lbdmEdowQesDN0GTK9cnTjvbboVljOhtY6nQ=;
        b=YwKP1SxEQ/dN1PvJQqshqy0OTWt5sSPJPq58y4pecuf/bbV3cAPZ3czZdFcJiSO/Af
         dLhO3xdYf9QEsP/2143+2yoTTjkKM7UowlN0TxcSopPt3OX8a8B39/Ju9UgIGQHLZD0T
         gIQtnCmu0niIibKq24hcp4E+uXsyFgt7q9m8leAHeDApee467zvzWtn3khmCp2b3yleN
         L/u5iurleklNqfVwjdtc2nXuFPvsyME0dz/9tuQPBMn6yBd7f1x4tHZoh5pSbQwWdx3s
         eaPMsaKQcB/AexbC1fsqITAnMp2tt9ZOOvbxkdjx93Td1kQO5DKpvh84UR79mOxClc4E
         b7iw==
X-Gm-Message-State: AOJu0YwE2V/pzD8J0EeMPAcqbxPvHlMe2TW5qvd1iY1yknmkiUKnt0Ou
        rGi9R3Ze9TfDnEIqt/DcfnU=
X-Google-Smtp-Source: AGHT+IFJowL8mS3xjs/H8LY6fOM0ia8pY5tuBTEwjYVFdfw6XNNIpSZSJUmKUMZiLlnKmHVu/ZDlqw==
X-Received: by 2002:a17:902:d04a:b0:1ca:3e40:beae with SMTP id l10-20020a170902d04a00b001ca3e40beaemr5736669pll.38.1698657018515;
        Mon, 30 Oct 2023 02:10:18 -0700 (PDT)
Received: from oslab-pc.tsinghua.edu.cn ([166.111.139.134])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f7c900b001b8a3e2c241sm5887429plw.14.2023.10.30.02.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 02:10:18 -0700 (PDT)
From:   Tuo Li <islituo@gmail.com>
To:     sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, baijiaju1990@outlook.com,
        Tuo Li <islituo@gmail.com>, BassCheck <bass@buaa.edu.cn>
Subject: [PATCH v2] scsi: message: fusion: Fix a possible data race in mpt_ioc_reset()
Date:   Mon, 30 Oct 2023 17:09:24 +0800
Message-Id: <20231030090924.2873408-1-islituo@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable ioc->taskmgmt_quiesce_io is often protected by the lock
ioc->taskmgmt_lock when is accessed. Here is an example in
mpt_SoftResetHandler():

  spin_lock_irqsave(&ioc->taskmgmt_lock, flags);
  ...
  ioc->taskmgmt_quiesce_io = 0;
  ...
  spin_unlock_irqrestore(&ioc->taskmgmt_lock, flags);

However, ioc->taskmgmt_quiesce_io is set to 1 without holding the lock
ioc->taskmgmt_lock in mpt_ioc_reset(), which can cause possible data
races:

  case MPT_IOC_SETUP_RESET:
    ioc->taskmgmt_quiesce_io = 1;

To fix this possible data race, WRITE_ONCE() is used to access the
variable ioc->taskmgmt_lock.

Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
---
v2:
* Replace lock operations with a WRITE_ONCE to avoid possible data 
races.
  Thank Bart Van Assche for helpful advice.
---
 drivers/message/fusion/mptbase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index 4bf669c55649..6c67eec9ab85 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -6563,7 +6563,7 @@ mpt_ioc_reset(MPT_ADAPTER *ioc, int reset_phase)
 {
 	switch (reset_phase) {
 	case MPT_IOC_SETUP_RESET:
-		ioc->taskmgmt_quiesce_io = 1;
+		WRITE_ONCE(ioc->taskmgmt_quiesce_io, 1);
 		dtmprintk(ioc, printk(MYIOC_s_DEBUG_FMT
 		    "%s: MPT_IOC_SETUP_RESET\n", ioc->name, __func__));
 		break;
-- 
2.34.1

