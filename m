Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF167D4881
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjJXH2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjJXH2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:28:13 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C84B7;
        Tue, 24 Oct 2023 00:28:11 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7d532da4bso41781917b3.2;
        Tue, 24 Oct 2023 00:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698132490; x=1698737290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SUy/pIrJQ4lVdyCwvzrdoIndJvrnQzFed6oGXznF0Zw=;
        b=YkFmo1KbozvojfmtoNpVOnk0PnbgW/ABJ0cwZK0oe1uDZkQzUmLHVQhpxahh/tspo8
         HFMGiqM0hUz0hmCYAsE33FipDPBFeNSjJzrOPFTv0dIJihZ9j5rVtATKRsNQ3Ou1VwvK
         fMwtvyoe42hr+2CYdSH+VB11Loz/7XUgU5sg1OOkJbBKmFcsdJzMFlPWB0/fWER2eby4
         PE9ztXlN1JfcZ3d7BF5YQVCdmB9zrtYNK92z85UVVING61rilmE5Ctx5alKhgdLJ5Gt+
         OMUZtuK4l4CCeXv43groWoULxD/acaHPczf2fUmr2OdnuFyR2QLPHdI/2aIHgg9RT4ns
         20/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698132490; x=1698737290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SUy/pIrJQ4lVdyCwvzrdoIndJvrnQzFed6oGXznF0Zw=;
        b=tmf7aNvcRNU5ef1sVSz4sTw4TdM1RqN6dfSOQDkhLosXU5C19D5HVo8rOzqqkzuX8r
         PqJVrYzARaB464+29z5NVODs6R/nYhUwi8lJNrQU+bGBOI8z9ylo0nmFSNGfJeJ50PmP
         f7oPgVd+BVi66JLlp10jn5EyVw7b5HMyQ9E/nIQ8Pw131mlq7iwuWOX+WfmD0JpAii0C
         UzH6rJuFeftz+wmOupHRDg2MZJ6RXd0n/PwbHMcjpIynnwUXAt2ReOvTDmK6y/CDPE0t
         aTzh4L1Nnm08SubM0eDZF8RvsGzAU1pW0mi3AzSsa+0M+y9tj3PdrMRfDTiTjQY2QCm8
         SIHg==
X-Gm-Message-State: AOJu0YyuyOep7ZFy1yBSoDBasAp5WB3BLkGZwUpDJzEGVtCibM+1tV9v
        +Uwd8kg5oqC8AbPSes4uiY0=
X-Google-Smtp-Source: AGHT+IFiUKZgW8uw2nL4PMkSlWakXmkWoCncPkXTNUxzrhXZ6ZyWHnZpow89FyC3MaicobKDya/p5g==
X-Received: by 2002:a0d:f741:0:b0:59b:5696:c33 with SMTP id h62-20020a0df741000000b0059b56960c33mr11474071ywf.46.1698132490313;
        Tue, 24 Oct 2023 00:28:10 -0700 (PDT)
Received: from oslab-pc.tsinghua.edu.cn ([166.111.139.134])
        by smtp.gmail.com with ESMTPSA id c4-20020a056a00008400b006be22fde07dsm7152827pfj.106.2023.10.24.00.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 00:28:09 -0700 (PDT)
From:   Tuo Li <islituo@gmail.com>
To:     sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, baijiaju1990@outlook.com,
        Tuo Li <islituo@gmail.com>, BassCheck <bass@buaa.edu.cn>
Subject: [PATCH] scsi: message: fusion: Fix a possible data race in mpt_ioc_reset()
Date:   Tue, 24 Oct 2023 15:27:29 +0800
Message-Id: <20231024072729.455713-1-islituo@gmail.com>
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
ioc->taskmgmt_lock in mpt_ioc_reset():

  case MPT_IOC_SETUP_RESET:
    ioc->taskmgmt_quiesce_io = 1;

In my opinion, this may be a harmful race, because the value of
ioc->taskmgmt_quiesce_io can be rewritten by mpt_ioc_reset() when
another thread is accessing it.

To fix this possible data race, a lock and unlock pair is added when
accessing the variable ioc->taskmgmt_quiesce_io.

Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/message/fusion/mptbase.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index 4bf669c55649..86d7b4defeb0 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -6561,9 +6561,12 @@ mpt_config(MPT_ADAPTER *ioc, CONFIGPARMS *pCfg)
 static int
 mpt_ioc_reset(MPT_ADAPTER *ioc, int reset_phase)
 {
+	unsigned long flags;
 	switch (reset_phase) {
 	case MPT_IOC_SETUP_RESET:
+		spin_lock_irqsave(&ioc->taskmgmt_lock, flags);
 		ioc->taskmgmt_quiesce_io = 1;
+		spin_unlock_irqrestore(&ioc->taskmgmt_lock, flags);
 		dtmprintk(ioc, printk(MYIOC_s_DEBUG_FMT
 		    "%s: MPT_IOC_SETUP_RESET\n", ioc->name, __func__));
 		break;
-- 
2.34.1

