Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D3D790CA0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 17:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242607AbjICPIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 11:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237182AbjICPIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 11:08:16 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5BACCC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 08:07:59 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b962c226ceso10104491fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 08:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693753678; x=1694358478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=csKX5A9kXXALBeT5X7dLtErmAX0Hy/N1x58zC4BBgNs=;
        b=QNt3YYqZF9nlt0pVomMBOtGuTgz0HZgGzQIMaSMBNRbVWl/ubhFZsj4VYfQuDJmwP/
         yOvfeZa26O/Xjo3ZltulWWQRzc45RKdRMFm3wSZK76x+2CZoKa6xf7uphNI7ZdS/xLOp
         sqwoFSdku0v0A5xNFsmJkigqaeJyZDnUI2HM0nLX08LZb5t05rfpA8lDmfWoq84QrktR
         3sL6Z0mcNw5JfEXcEqzjH3HuHm77j/p32i3JZvOJYkbiHOmGJ+Lmn6OOoS8V/pMNQSyy
         y0Qjs4+DAp/zRIa69/aasLwgcfenAyALdVr7WEC88BUHlyw6hJMHy7T+SKeMx7xJ2UG3
         G45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693753678; x=1694358478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=csKX5A9kXXALBeT5X7dLtErmAX0Hy/N1x58zC4BBgNs=;
        b=IL8nx2ZjfdY36GM05IZDjyTXyItqUkKhcXsauPy7MkI5ZFH2hWQVyhPlI5yvYHyjvI
         IGrHo79xZ9/nNzTKoB1GgGBARIROUE/VatqfdRG9cOtJAjleO4m++FdavpM32HIO0nrg
         A2QYEPJe4vLRskHw+KEljDfuQSSSn33KX7SUTURwAeKFv4eBaP2GBCsPUH04JCPTm71y
         ire42RWZeYEPkbnYSWs3+kw4RnPo79svvfWerRLVhRbeMLrY/7UKFgbP0P5psGTRY14y
         G8oLZA3peBQc7aC3irifeh+IJRpaOVz1xPf6Nb1p5Hnz+doxuWLduaAsXx9bMAPhf1nC
         kG3g==
X-Gm-Message-State: AOJu0Yy0m3cM2CysSlP3QNW5XbnpRKVh1QtC5yhcSTNbTSs9GTFV50A/
        udmDcvbDGOw/WrFHVMU+MbhCAePCmVPtLndHSoY=
X-Google-Smtp-Source: AGHT+IFQwplZBOYCSQvP1lfdW5q3h0qUHtTwnFzNEd19JikuePPyjZpP4PkPsrL7CBP6VpdwJcDAfw==
X-Received: by 2002:a2e:9d8d:0:b0:2bc:fd7b:8ded with SMTP id c13-20020a2e9d8d000000b002bcfd7b8dedmr5429229ljj.20.1693753677804;
        Sun, 03 Sep 2023 08:07:57 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id b23-20020a2e8497000000b002bcdeeecd11sm1547944ljh.66.2023.09.03.08.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 08:07:57 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH] staging: vme_user: Remove unused (commented) code causing unnecessary checkpatch warning
Date:   Sun,  3 Sep 2023 17:06:23 +0200
Message-Id: <20230903150623.571984-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Removed unused/commented code from vme_fake.c which was causing spurious
checkpatch warnings.

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/vme_user/vme_fake.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index 7c53a8a7b79b..9bcb89a84d53 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -1009,9 +1009,6 @@ static void fake_free_consistent(struct device *parent, size_t size,
 		void *vaddr, dma_addr_t dma)
 {
 	kfree(vaddr);
-/*
-	dma_free_coherent(parent, size, vaddr, dma);
-*/
 }
 
 /*
-- 
2.34.1

