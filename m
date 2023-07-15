Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B8B75466C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 04:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjGOCxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 22:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGOCxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 22:53:39 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E63535A9;
        Fri, 14 Jul 2023 19:53:38 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b8ad9eede0so20117525ad.1;
        Fri, 14 Jul 2023 19:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689389618; x=1691981618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8f6mcKlZ5Qexg+/68svYOAiKI8e1V4o+avgSXnoMJmA=;
        b=dxzOAxnr3Baip3gVbAvxCPfOQcWt73JtIsLXS2/XDqc7ZnG9wRmeaouBaKFt40w58T
         dN2MDLP7VH/sUS4ZWvptE/inP1LM2s9f5Gi1g56uuyZ1UHQOz3C5fAtTjJUyH//EXQvz
         xg8bra2F1sknrgmnUiHNgcW1vT7+VQNzR+LYTCNsl7F09CLTdbSopuH2Rh9hDeCQcXSS
         UifhkHl78By91Zh2gCGwob9o/oUWeiA7iT3H+5RF9Gjwb3xvkCzR+GNl8giW4r7rXdpk
         LHjQolhRLGJw7eEmYur1GOxnRUEvNVTSt7qP3Y/sbl8DgpKQHVMyk8MtpplQaAMmqXUe
         HhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689389618; x=1691981618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8f6mcKlZ5Qexg+/68svYOAiKI8e1V4o+avgSXnoMJmA=;
        b=VerFdvmZw9sEzPjqnl2rc8VcT/FCXunivHUmnukdlZc1kF91BBdPrJuBkoJX6xjytK
         UyLR+biTtO4U/l2nHQkVpUt1HNNKpL2ZjjPDFgGHpDBoPTxbi2br1EmmsBlAUv6+G4Pr
         Vw0AVrytms6jNPDjzsw3+v9Xv0cjwOZJRj5P6ksc3SklCIQiChYpCYmEGOREiXoHvmY8
         LI8aJZ0hpCNWw1FKbDKODxQ5TbtV7JOel/oC7l0nJv6QZKMeBWU6eJnP/Vi1HRGi8rur
         37F/SXkYzLcEn55zf00R/J9iOQ/x4rVEp5C4aappJe2XyXtYJoGEYpJNTU+i25xixQqi
         ySQQ==
X-Gm-Message-State: ABy/qLZhmf0rDSPyRhjXllx4lEjn4kOqmmapBt1Cwh3CBgQznz5P0Pk+
        dcdr84B6zQpYIZcq8/88gso=
X-Google-Smtp-Source: APBJJlF+jHY7cxFK5dPvwkH7aqnSJm5u1O5aYyDbJocqVmlX0/saY5poxUzi6hTxc+IKfwQkw40BxA==
X-Received: by 2002:a17:903:110c:b0:1b5:64a4:be8b with SMTP id n12-20020a170903110c00b001b564a4be8bmr6926305plh.35.1689389618021;
        Fri, 14 Jul 2023 19:53:38 -0700 (PDT)
Received: from oslab-pc.tsinghua.edu.cn ([166.111.139.122])
        by smtp.gmail.com with ESMTPSA id j13-20020a170902da8d00b001b3df3ae3f8sm8416649plx.281.2023.07.14.19.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 19:53:37 -0700 (PDT)
From:   Tuo Li <islituo@gmail.com>
To:     sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, baijiaju1990@outlook.com,
        Tuo Li <islituo@gmail.com>, BassCheck <bass@buaa.edu.cn>
Subject: [PATCH] scsi: message: fusion: Fix a possible data race in mpt_ioc_reset()
Date:   Sat, 15 Jul 2023 10:53:06 +0800
Message-Id: <20230715025306.164847-1-islituo@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
ioc->taskmgmt_quiesce_io can be rewritten by mpt_ioc_reset() when another
thread is accessing it.

To fix this possible data race, a lock and unlock pair is added when
accessing the variable ioc->taskmgmt_quiesce_io.

Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/message/fusion/mptbase.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index 4bf669c55649..560057daf4ee 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -6561,9 +6561,13 @@ mpt_config(MPT_ADAPTER *ioc, CONFIGPARMS *pCfg)
 static int
 mpt_ioc_reset(MPT_ADAPTER *ioc, int reset_phase)
 {
+	unsigned long	 flags;
+
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

