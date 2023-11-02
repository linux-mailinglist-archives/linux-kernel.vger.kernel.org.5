Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8027DFAB8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjKBTOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBTOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:14:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE8B184
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698952407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7LVQ5w0anuOTdJBcIcyfQ+Yv7Aq7P2CcDXfLuUSgG6s=;
        b=emDxtLff10NfNzkNGuKBgF7VR9Cef+Ox/s8VoBP7PVkUf7qhnpJbuDE5rcpJLoYaS5U/hN
        82PHGjf2/9siW5KhQLSfQKixtEYL04BgYhmPXqY+n8DCsg9gMS2A9KBHeTGyTdgYRIMW0c
        b9yFak/gSaFOG7NfwfC/eb1GHm6WTfg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-HcMwHxEnPuGCzW_Mrk2aow-1; Thu, 02 Nov 2023 15:13:23 -0400
X-MC-Unique: HcMwHxEnPuGCzW_Mrk2aow-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4084b6f4515so2668435e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698952401; x=1699557201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LVQ5w0anuOTdJBcIcyfQ+Yv7Aq7P2CcDXfLuUSgG6s=;
        b=K0AVw0RrAchsjg0Rngjy5x6gNGqPEZTI8099BMdfJGMeQ8vXC/UO6Ol2k1NRk/4jNW
         KsZlj2lvPhbLI7FJSebUm52MRlPLSZ+vVAI/WRu2zS2gj/sjS5BSr9v8adbBQmvh7UPE
         +WI4K3U9PEiejrVWRrCTcDxLBy7Gbu39FJ2U+S0nh4Rge0OEfTAbXF5CLY3Be/KQo/Yd
         PDV53+hNqnWR0LyKh9kPSxxNp0fhsr9OLpzU28ftGSvmSrDk7y561H44mUHi4rXlnXzs
         Rm7I/HiAs/+hK5BKEb1UPbtWI15UmPK1D0M41KlMlM3aHoPa6+nwgp2lHpawPxQUy+TG
         eO1w==
X-Gm-Message-State: AOJu0YxNZd+SLzCb9eg3BXYgGVsa9gsp/vzjStnEcs/9hI/+xMlfv1QG
        9aGd53L6QO5wlkMpYOn68dhMyW0gwMNSgJFeAm4DfaDEwmeZq/sVSkkZZizPZOI5eBqFWVqD0s8
        ETIbZaX/XwdoUNE6rPl+hJgVE
X-Received: by 2002:a05:6000:4020:b0:32f:acb1:ba92 with SMTP id cp32-20020a056000402000b0032facb1ba92mr1805443wrb.5.1698952401539;
        Thu, 02 Nov 2023 12:13:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc/Z5HzAbSYw7FRmZqVCx27vETGDl61gL7t1KU+fDXjOWmc8h6FEfym3dg9o0oQJdooS0Nxg==
X-Received: by 2002:a05:6000:4020:b0:32f:acb1:ba92 with SMTP id cp32-20020a056000402000b0032facb1ba92mr1805432wrb.5.1698952401192;
        Thu, 02 Nov 2023 12:13:21 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c5:d600:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d4fce000000b0032196c508e3sm91398wrw.53.2023.11.02.12.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 12:13:20 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH] drivers/infiniband: copy userspace arrays safely
Date:   Thu,  2 Nov 2023 20:13:09 +0100
Message-ID: <20231102191308.52046-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, memdup_user() is utilized at two positions to copy userspace
arrays. This is done without overflow checks.

Use the new wrapper memdup_array_user() to copy the arrays more safely.

Suggested-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/infiniband/hw/hfi1/user_exp_rcv.c | 4 ++--
 drivers/infiniband/hw/hfi1/user_sdma.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
index 96058baf36ed..53a623892d9d 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
@@ -491,8 +491,8 @@ int hfi1_user_exp_rcv_clear(struct hfi1_filedata *fd,
 	if (unlikely(tinfo->tidcnt > fd->tid_used))
 		return -EINVAL;
 
-	tidinfo = memdup_user(u64_to_user_ptr(tinfo->tidlist),
-			      sizeof(tidinfo[0]) * tinfo->tidcnt);
+	tidinfo = memdup_array_user(u64_to_user_ptr(tinfo->tidlist),
+				    tinfo->tidcnt, sizeof(tidinfo[0]));
 	if (IS_ERR(tidinfo))
 		return PTR_ERR(tidinfo);
 
diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
index 29ae7beb9b03..f7fa8e699a78 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.c
+++ b/drivers/infiniband/hw/hfi1/user_sdma.c
@@ -494,8 +494,8 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 		 * equal to the pkt count. However, there is no way to
 		 * tell at this point.
 		 */
-		tmp = memdup_user(iovec[idx].iov_base,
-				  ntids * sizeof(*req->tids));
+		tmp = memdup_array_user(iovec[idx].iov_base,
+					ntids, sizeof(*req->tids));
 		if (IS_ERR(tmp)) {
 			ret = PTR_ERR(tmp);
 			SDMA_DBG(req, "Failed to copy %d TIDs (%d)",
-- 
2.41.0

