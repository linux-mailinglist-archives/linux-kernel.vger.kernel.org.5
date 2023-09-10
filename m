Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB36279A018
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 23:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjIJV1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 17:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjIJV1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 17:27:21 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C853B9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 14:27:17 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5921a962adfso36946757b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 14:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ixsystems.com; s=google; t=1694381236; x=1694986036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G3vyDGkHhGIgt9tKpS+4PfIZn5WSsDuTIQeg67GIK70=;
        b=kGK35pHTNXp9WbfCgNhkFajNKl6670pSPffe2e9IFtM2hNUg90JtNV5jesovhVVH4+
         v3NX70mJ82EkYbb4VNZnrPR9i4vyPcyv8HYS9wP0UfBv8cjP7bWb12BN8zH3s1pEu/G2
         NITSceGZ0MNc27Mg2bi/v0zS9DzwGhM36taa1bFHSCyrBAVoHFSP2kKbzrLnQSAwet9Y
         JpH6uppRcFxnJ+tWUmqszhpMmOZMECpaKCmp3VfUM1bJkAxcqW9rYQfQxgRG201CvM6T
         0zkFOaejMV8USAzEoX3xuKOipptd7JSM2BtO0fbwB1RjUTKx5VeOU9qVaipNCw9B+rG7
         BVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694381236; x=1694986036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G3vyDGkHhGIgt9tKpS+4PfIZn5WSsDuTIQeg67GIK70=;
        b=tkASDCD2G45lHfHKhcX5T7MihGCA01p2dwVxvq7RaWkyeU4vbilZMk0Ntijx3G8+fw
         WyiE3pszYyqbP2S4zjnE3pIKF2L6gT2+A88hj9R+vRlxOH21jT8MsHTzWxD3R9EWrB1Q
         uQ8N0D3qOGST+UlVwIiBWyicerxRL8WJxicEwdw2TrIC2y06RpsVk5XsoZKgZLJ3XzVM
         W609WWZxUz6JkWaLSISbNiJtKahrlwD++OHVhP1Lw5SF06252zH56KacYKRnxJzH2Gnk
         fq1qp906hkX4mCn9CMpB0fZsO1cPH8TpeDAcX3PlZ6ChFyK6NoFR2Jh4wTljTpqvEPh0
         71Cw==
X-Gm-Message-State: AOJu0YwxKNLyv/ra/ZlBuSjPxRm1rd9vQdPw9kdDurX5eCM0efio5RdY
        qQtg/rdr3ferWb4yLrFhWvZxR6nWE/7eOHvQNaM=
X-Google-Smtp-Source: AGHT+IGdJ6M/MVpvzq9gg72gcpDLWx5bSBtAOXQLOr5GqodlmWOPUBZjXiPZ6TaYXYKGjwctfihBuQ==
X-Received: by 2002:a81:4e90:0:b0:59b:4675:29c6 with SMTP id c138-20020a814e90000000b0059b467529c6mr10301423ywb.9.1694381236266;
        Sun, 10 Sep 2023 14:27:16 -0700 (PDT)
Received: from hamza-pc.. ([202.47.34.142])
        by smtp.googlemail.com with ESMTPSA id r204-20020a815dd5000000b0058e37788bf7sm1602054ywb.72.2023.09.10.14.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 14:27:15 -0700 (PDT)
From:   Ameer Hamza <ahamza@ixsystems.com>
To:     linux-nvme@lists.infradead.org
Cc:     kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        linux-kernel@vger.kernel.org, mav@ixsystems.com,
        edmund.nadolski@ixsystems.com, ahamza@ixsystems.com
Subject: [PATCH] nvme: prevent id ctrl csi for specs below 2.0
Date:   Mon, 11 Sep 2023 02:26:41 +0500
Message-Id: <20230910212641.338438-1-ahamza@ixsystems.com>
X-Mailer: git-send-email 2.39.2
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

The 'id ctrl csi' command was introduced in version 2.0, as specified
in Section 5.17.2.6 of the NVME Base Specification 2.0. Executing this
command on previous NVMe versions returns an "Invalid Field" error,
and the error entry is saved in the log page. Although, Commit
c917dd96fe41 ("nvme: skip optional id ctrl csi if it failed") reduced
the error occurrences, but the error persisted during the initial
module load. This patch ensures the command isn't executed on versions
older than 2.0, and it also eliminates the skip implementation because
NVME_ID_CNS_CS_CTRL is expected to succeed with version 2.0.

Signed-off-by: Ameer Hamza <ahamza@ixsystems.com>
---
 drivers/nvme/host/core.c | 6 ++----
 drivers/nvme/host/nvme.h | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f3a01b79148c..6c92aa5704f9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2894,9 +2894,9 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	else
 		ctrl->max_zeroes_sectors = 0;
 
+	/* NVME_ID_CNS_CS_CTRL is supported from v2.0 onwards. */
 	if (ctrl->subsys->subtype != NVME_NQN_NVME ||
-	    nvme_ctrl_limited_cns(ctrl) ||
-	    test_bit(NVME_CTRL_SKIP_ID_CNS_CS, &ctrl->flags))
+	    ctrl->vs < NVME_VS(2, 0, 0))
 		return 0;
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
@@ -2918,8 +2918,6 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 		ctrl->max_zeroes_sectors = nvme_mps_to_sectors(ctrl, id->wzsl);
 
 free_data:
-	if (ret > 0)
-		set_bit(NVME_CTRL_SKIP_ID_CNS_CS, &ctrl->flags);
 	kfree(id);
 	return ret;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f35647c470af..f3cf10710bce 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -249,8 +249,7 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_ADMIN_Q_STOPPED	= 1,
 	NVME_CTRL_STARTED_ONCE		= 2,
 	NVME_CTRL_STOPPED		= 3,
-	NVME_CTRL_SKIP_ID_CNS_CS	= 4,
-	NVME_CTRL_DIRTY_CAPABILITY	= 5,
+	NVME_CTRL_DIRTY_CAPABILITY	= 4,
 };
 
 struct nvme_ctrl {
-- 
2.39.2

