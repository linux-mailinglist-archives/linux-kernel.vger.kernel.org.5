Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D142E799D5D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 10:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbjIJIeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 04:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239000AbjIJIen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 04:34:43 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6164BCD8;
        Sun, 10 Sep 2023 01:34:26 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99cce6f7de2so425032966b.3;
        Sun, 10 Sep 2023 01:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694334865; x=1694939665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6sJcNbgOBSMSjzKpgg3NyCG1G05DQaIPABUhyueQ8Ng=;
        b=ktPiDFibUSXMUXMm3hNlbMtmHcPUJdgNTKkLvXxQWkfwzdOpnNEuTCyxA72QEK0MVM
         V0nWoi3QVBNyCwXcovltP+0LbHT5v9axSoqaO7EI9mkfDIpUxTz9mr20lJVhnX/xfuQU
         C5wlAd0aRbsnruUOxIsPN1o2qx07lgeVeUcHz2xfxUmEK/vIysvm5bl0zIpXvTjeGsYU
         KSEPIoqG2mdtOfb0QxwROPobK/wiZFJ5MLkykapGDSb0HD2Ha4bY3h0j3ijtqKLDAP1/
         df7yG/sEtE3RE7s2IDY9nBV14tRdmHnwnVBp9ck86hoZCP4z/J+6JXsIf4XlZjbE2Gdc
         xctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694334865; x=1694939665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6sJcNbgOBSMSjzKpgg3NyCG1G05DQaIPABUhyueQ8Ng=;
        b=Clp5/bQmlxaM7V1236uYaaaCj443tmPtTlU9NSbwSaKt0M1Q7BN1NBjIpceoG0H/4T
         27FNOh08pWhhHh0ieR9Z2helTv3l9IYmQOTzGxhSuTw8N30oh8ymwXNjDPktsrkHAAjn
         ixjs5XDl0e6CD/8Q4NLFd2eqlZJjSIFT6lTWz+mTLlGmDeHhhe5qbNKznmbW+xkRn4Gx
         X6G/cFzodat3BVoaPCFh9YNZWBqDR1tPFmM1ZmhfQsBLHn8UI2f11RfK5TsyL2GLVRf8
         RS2wt4c6kvg8En3NlECRWU+ovH3JliyPuGd3gXP8GT7E6J++PHE1vfZXoJ4xieC4niny
         K23A==
X-Gm-Message-State: AOJu0Yy9C9Y04CUVk41/nGLpo3rwatdg6esR7e3OADXYavJD6bEIuVGe
        rP5U0uUKUxW6cvgcjhSOIA0=
X-Google-Smtp-Source: AGHT+IFP6AbgYl3jY4RkxnAMHPgYVmcLqW7TeprlUeUk2ZxoZ7IKZnSrOzV2eAHf+vSJEBLOsRJLpA==
X-Received: by 2002:a17:906:209e:b0:9aa:167:1054 with SMTP id 30-20020a170906209e00b009aa01671054mr4985395ejq.34.1694334864625;
        Sun, 10 Sep 2023 01:34:24 -0700 (PDT)
Received: from localhost (dslb-088-076-253-094.088.076.pools.vodafone-ip.de. [88.76.253.94])
        by smtp.gmail.com with ESMTPSA id z7-20020a1709060ac700b0099bc08862b6sm3541626ejf.171.2023.09.10.01.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 01:34:23 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     Andres Salomon <dilinger@queued.net>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     "Timur I . Davletshin" <timur.davletshin@gmail.com>,
        Jo-Philipp Wich <jo@mein.io>, linux-geode@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwrng: geode: fix accessing registers
Date:   Sun, 10 Sep 2023 10:34:17 +0200
Message-Id: <20230910083418.8990-1-jonas.gorski@gmail.com>
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

When the membase and pci_dev pointer were moved to a new struct in priv,
the actual membase users were left untouched, and they started reading
out arbitrary memory behind the struct instead of registers. This
unfortunately turned the RNG into a constant number generator, depending
on the content of what was at that offset.

To fix this, update geode_rng_data_{read,present}() to also get the
membase via amd_geode_priv, and properly read from the right addresses
again.

Fixes: 9f6ec8dc574e ("hwrng: geode - Fix PCI device refcount leak")
Reported-by: Timur I. Davletshin <timur.davletshin@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217882
Tested-by: Timur I. Davletshin <timur.davletshin@gmail.com>
Suggested-by: Jo-Philipp Wich <jo@mein.io>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/char/hw_random/geode-rng.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/geode-rng.c b/drivers/char/hw_random/geode-rng.c
index 12fbe8091831..159baf00a867 100644
--- a/drivers/char/hw_random/geode-rng.c
+++ b/drivers/char/hw_random/geode-rng.c
@@ -58,7 +58,8 @@ struct amd_geode_priv {
 
 static int geode_rng_data_read(struct hwrng *rng, u32 *data)
 {
-	void __iomem *mem = (void __iomem *)rng->priv;
+	struct amd_geode_priv *priv = (struct amd_geode_priv *)rng->priv;
+	void __iomem *mem = priv->membase;
 
 	*data = readl(mem + GEODE_RNG_DATA_REG);
 
@@ -67,7 +68,8 @@ static int geode_rng_data_read(struct hwrng *rng, u32 *data)
 
 static int geode_rng_data_present(struct hwrng *rng, int wait)
 {
-	void __iomem *mem = (void __iomem *)rng->priv;
+	struct amd_geode_priv *priv = (struct amd_geode_priv *)rng->priv;
+	void __iomem *mem = priv->membase;
 	int data, i;
 
 	for (i = 0; i < 20; i++) {
-- 
2.34.1

