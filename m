Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4B078F92A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 09:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348499AbjIAHfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 03:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbjIAHfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 03:35:21 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5111010D2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 00:35:18 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68a4bcf8a97so1227929b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 00:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693553718; x=1694158518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=twC24zwbv4rxrutTxkfSyT3gLWKA93+iK2AGFx/l/NE=;
        b=SKnLI9TUQ8UOQzraFdSHVXjnDnmc1JKu2SlQ2/VzdUVinUuyArUplhvL56QySnOSWd
         2qVV7svLC2z5cYaLwP/KUm7pONjXDM2k7qQt62ZAUeuNizG2ou2oeptFVf3BbGwQgMQS
         qLpjH5DKebm2ZrxktUW9lkVv8JjTNU/G01WM7vJtPK1XS4o8nGiw2Q9/FxgJD2r60k3b
         3pfejLDTiWWIvLZbZSKCHRtovus+JPGkL69TMeP7N/Al71QUt1hvgAhtJFz8ZpZQdsRL
         tDo2ZGFTPn/TKFSAEnmW4PsG4xebfGZsMG48PI0JQDdcOIQHmmsSToHOr+ohcL1V7cap
         YJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693553718; x=1694158518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twC24zwbv4rxrutTxkfSyT3gLWKA93+iK2AGFx/l/NE=;
        b=ROPKEwt4MlZvDDkNk3WgEgDK+i9hXABssBNWmUH+fbz1Jc+DC9qL9LRGZsf99v5RWw
         KYcFSOrypY/S82Dbf9AtFKQ4NKVY6iq+jFeuolBYYYxFHkZ172jiz57hrfvqcly4NOf4
         yGNTmiyXOukKkniYXmaZF/dPxo97GbHyYfBOWxiUsmW6nmOr19//sEVgMyynZLiujmXi
         FJKCZqxi4RwZ2H3SNNgnVQ7mafOMj88qL4cyjGitRiloK8+m87bVzSDo6xoxxLQbwmKc
         fGJW0zeTOiEkdKYV62DPttOaDMB5IHuMvsoe0xxlTeG4TThUGWIpRCmTRaaMUOjCqUwk
         aAUQ==
X-Gm-Message-State: AOJu0YwqmQcSWAHtmRp2px4zkGrLxO57363YfYBS7pF2N5TOWu64/Cq2
        yPQwZiPIWZmXDDsQSy4ZzsCz
X-Google-Smtp-Source: AGHT+IEbqx6ojHyG0IAXecWFY7u2o3fb/zTxAc6jY/6YNuNvZeWI4jiOxr2Du4dLiD2wjQrRHcx6Iw==
X-Received: by 2002:a05:6a00:180f:b0:68a:3bb9:7e86 with SMTP id y15-20020a056a00180f00b0068a3bb97e86mr2327112pfa.0.1693553717713;
        Fri, 01 Sep 2023 00:35:17 -0700 (PDT)
Received: from localhost.localdomain ([59.92.102.217])
        by smtp.gmail.com with ESMTPSA id g20-20020a62e314000000b00688214cff65sm2376427pfh.44.2023.09.01.00.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 00:35:17 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msarkar@quicinc.com, schintav@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH] bus: mhi: ep: Do not allocate event ring element on stack
Date:   Fri,  1 Sep 2023 13:05:02 +0530
Message-Id: <20230901073502.69385-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that the host controller driver would use DMA framework to
write the event ring element. So avoid allocating event ring element on the
stack as DMA cannot work on vmalloc memory.

Cc: stable@vger.kernel.org
Fixes: 961aeb689224 ("bus: mhi: ep: Add support for sending events to the host")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 52 +++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 600881808982..66ca470bf302 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -71,45 +71,61 @@ static int mhi_ep_send_event(struct mhi_ep_cntrl *mhi_cntrl, u32 ring_idx,
 static int mhi_ep_send_completion_event(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring,
 					struct mhi_ring_element *tre, u32 len, enum mhi_ev_ccs code)
 {
-	struct mhi_ring_element event = {};
+	struct mhi_ring_element *event = kzalloc(sizeof(struct mhi_ring_element), GFP_KERNEL);
+	int ret;
+
+	event->ptr = cpu_to_le64(ring->rbase + ring->rd_offset * sizeof(*tre));
+	event->dword[0] = MHI_TRE_EV_DWORD0(code, len);
+	event->dword[1] = MHI_TRE_EV_DWORD1(ring->ch_id, MHI_PKT_TYPE_TX_EVENT);
 
-	event.ptr = cpu_to_le64(ring->rbase + ring->rd_offset * sizeof(*tre));
-	event.dword[0] = MHI_TRE_EV_DWORD0(code, len);
-	event.dword[1] = MHI_TRE_EV_DWORD1(ring->ch_id, MHI_PKT_TYPE_TX_EVENT);
+	ret = mhi_ep_send_event(mhi_cntrl, ring->er_index, event, MHI_TRE_DATA_GET_BEI(tre));
+	kfree(event);
 
-	return mhi_ep_send_event(mhi_cntrl, ring->er_index, &event, MHI_TRE_DATA_GET_BEI(tre));
+	return ret;
 }
 
 int mhi_ep_send_state_change_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state state)
 {
-	struct mhi_ring_element event = {};
+	struct mhi_ring_element *event = kzalloc(sizeof(struct mhi_ring_element), GFP_KERNEL);
+	int ret;
+
+	event->dword[0] = MHI_SC_EV_DWORD0(state);
+	event->dword[1] = MHI_SC_EV_DWORD1(MHI_PKT_TYPE_STATE_CHANGE_EVENT);
 
-	event.dword[0] = MHI_SC_EV_DWORD0(state);
-	event.dword[1] = MHI_SC_EV_DWORD1(MHI_PKT_TYPE_STATE_CHANGE_EVENT);
+	ret = mhi_ep_send_event(mhi_cntrl, 0, event, 0);
+	kfree(event);
 
-	return mhi_ep_send_event(mhi_cntrl, 0, &event, 0);
+	return ret;
 }
 
 int mhi_ep_send_ee_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_ee_type exec_env)
 {
-	struct mhi_ring_element event = {};
+	struct mhi_ring_element *event = kzalloc(sizeof(struct mhi_ring_element), GFP_KERNEL);
+	int ret;
+
+	event->dword[0] = MHI_EE_EV_DWORD0(exec_env);
+	event->dword[1] = MHI_SC_EV_DWORD1(MHI_PKT_TYPE_EE_EVENT);
 
-	event.dword[0] = MHI_EE_EV_DWORD0(exec_env);
-	event.dword[1] = MHI_SC_EV_DWORD1(MHI_PKT_TYPE_EE_EVENT);
+	ret = mhi_ep_send_event(mhi_cntrl, 0, event, 0);
+	kfree(event);
 
-	return mhi_ep_send_event(mhi_cntrl, 0, &event, 0);
+	return ret;
 }
 
 static int mhi_ep_send_cmd_comp_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_ev_ccs code)
 {
+	struct mhi_ring_element *event = kzalloc(sizeof(struct mhi_ring_element), GFP_KERNEL);
 	struct mhi_ep_ring *ring = &mhi_cntrl->mhi_cmd->ring;
-	struct mhi_ring_element event = {};
+	int ret;
+
+	event->ptr = cpu_to_le64(ring->rbase + ring->rd_offset * sizeof(struct mhi_ring_element));
+	event->dword[0] = MHI_CC_EV_DWORD0(code);
+	event->dword[1] = MHI_CC_EV_DWORD1(MHI_PKT_TYPE_CMD_COMPLETION_EVENT);
 
-	event.ptr = cpu_to_le64(ring->rbase + ring->rd_offset * sizeof(struct mhi_ring_element));
-	event.dword[0] = MHI_CC_EV_DWORD0(code);
-	event.dword[1] = MHI_CC_EV_DWORD1(MHI_PKT_TYPE_CMD_COMPLETION_EVENT);
+	ret = mhi_ep_send_event(mhi_cntrl, 0, event, 0);
+	kfree(event);
 
-	return mhi_ep_send_event(mhi_cntrl, 0, &event, 0);
+	return ret;
 }
 
 static int mhi_ep_process_cmd_ring(struct mhi_ep_ring *ring, struct mhi_ring_element *el)
-- 
2.25.1

