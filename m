Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C56778E62
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbjHKL45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjHKL4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:56:54 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8EA11F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:56:52 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so266269566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691755011; x=1692359811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COd39iwzA46hvSxeAdraThBadyCY8RFKXPeA//q6518=;
        b=Dme376pTaFqRA03PokDCOjB2CXKH5mu9JaK7GIixlIh3BzevEYZnHA2Z7vt4fNMJ6r
         I0TxL5Ueae5b490Wvmb3DmhWJVMri5VAUrOm9BBqIM84Z0xEDp/fKeuh8Xr6+uFOxehU
         /pob1MhAjHN9D7LegYMYF2p7vD5FqYPAnYawxuz9q+JiLk3wOXgQO30mjR4SF2u+OmPz
         7mKSIgmx82EknmLrbub46VpKrruQaMqjLFi/3+3KMpkhyI48hTDQlPejcifZfbhaWpB7
         AIfVbWDxzjXK2VgDIMwBgbepulbNkI5FhIEXy3oHNpXKyMNg//wgx7jUSAJyZ2TYrVHt
         lYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691755011; x=1692359811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COd39iwzA46hvSxeAdraThBadyCY8RFKXPeA//q6518=;
        b=GCqVejGsLW4LuP82B57AsRZ77SkCGTAHJPJhjmj8lvjQhSpijfCqkfftRpILwRn7v+
         ZD789/Xv/2gVSvZ60P4cEnKwhcP/BKjEkol7KC4eHq/Un+R0TEBvBFVbrlAf7YPMhWCd
         a7rPAffJ7tGCy/6X/b9BCRl33CGL/6kDJx9fCSWjFyYPnPCUwlJxny92rW9Oz8tWy+ld
         XqExGwWcOIRPADwdCD/JiMFkfj9DkPStW3W5Oy1SjNT+5lhLWNpK4NJa565lT1UDqeXx
         a6doSu9vaSk5NgcUrE8LguE2pvmWMhYVKQ45QImtVl9nZ4rBjIc5ghodA419Ruti2YFV
         Cdog==
X-Gm-Message-State: AOJu0YyZtfnNMd5uWMOd45cn179RQ6VOOdRhDCUi8IUjbOVqFRSCT5AK
        X4K1jPV7fAal7ZJKlqpkKHhBiA==
X-Google-Smtp-Source: AGHT+IEpX/sSsrjWxtT/mvymrNAy2/AAzpFg0YkSyQAi55UPqOxx3kBLaXW6ksgWG0KV9HcnKSDKEQ==
X-Received: by 2002:a17:906:314c:b0:99b:64d0:f6c8 with SMTP id e12-20020a170906314c00b0099b64d0f6c8mr1348254eje.50.1691755011100;
        Fri, 11 Aug 2023 04:56:51 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id f16-20020a170906561000b00992076f4a01sm2165395ejq.190.2023.08.11.04.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 04:56:50 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Ekansh Gupta <quic_ekangupt@quicinc.com>,
        stable <stable@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/3] misc: fastrpc: Fix incorrect DMA mapping unmap request
Date:   Fri, 11 Aug 2023 12:56:42 +0100
Message-Id: <20230811115643.38578-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811115643.38578-1-srinivas.kandagatla@linaro.org>
References: <20230811115643.38578-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ekansh Gupta <quic_ekangupt@quicinc.com>

Scatterlist table is obtained during map create request and the same
table is used for DMA mapping unmap. In case there is any failure
while getting the sg_table, ERR_PTR is returned instead of sg_table.

When the map is getting freed, there is only a non-NULL check of
sg_table which will also be true in case failure was returned instead
of sg_table. This would result in improper unmap request. Add proper
check before setting map table to avoid bad unmap request.

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
Cc: stable <stable@kernel.org>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 2faabbd12755..8183c55283fb 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -756,6 +756,7 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 {
 	struct fastrpc_session_ctx *sess = fl->sctx;
 	struct fastrpc_map *map = NULL;
+	struct sg_table *table;
 	int err = 0;
 
 	if (!fastrpc_map_lookup(fl, fd, ppmap, true))
@@ -783,11 +784,12 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 		goto attach_err;
 	}
 
-	map->table = dma_buf_map_attachment_unlocked(map->attach, DMA_BIDIRECTIONAL);
-	if (IS_ERR(map->table)) {
-		err = PTR_ERR(map->table);
+	table = dma_buf_map_attachment_unlocked(map->attach, DMA_BIDIRECTIONAL);
+	if (IS_ERR(table)) {
+		err = PTR_ERR(table);
 		goto map_err;
 	}
+	map->table = table;
 
 	if (attr & FASTRPC_ATTR_SECUREMAP) {
 		map->phys = sg_phys(map->table->sgl);
-- 
2.25.1

