Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1955176FFB9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjHDLve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjHDLvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:51:31 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB4C180;
        Fri,  4 Aug 2023 04:51:30 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1357752a12.1;
        Fri, 04 Aug 2023 04:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691149889; x=1691754689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2EtyOVR4achsHfoqHulXQMM4qvU1Tc5rB6swnOUt9A=;
        b=RkXaPq+y0NMC78lUo79YLQxkRdl8QVxoFjh2/Pb8teHzMojIAmXpeIkvM6to9j2877
         ZlWpuWKOaunJeaN0afmlmfGTHThR7/9oH9Cfkmjksy1Hr+lxB2vVnGHuBe8RdqhtS3NQ
         uPNeTOoZhwCHV0zk2g+heC6yoYCdTu59n+tUsBevLutgQ8Yn2cR6lOeG/d2lExMrhWBz
         FxriyZomUg1pWe6+93XUC/2Y5Ch0myj0nvZ5dOM2+4Up6AXxklX1ehN4uwOCY4hJKu9U
         zvPdv3PCad31AL1uoYo0RdQ+9jSA6Z7kR78z518SUTclU2ElQEjfMU+qLcg7sP58AhBw
         rBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691149889; x=1691754689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2EtyOVR4achsHfoqHulXQMM4qvU1Tc5rB6swnOUt9A=;
        b=i2ocQjVIqJ1+2tkt73Z5Ylto11wvTDXGIRnsJluSCi69cQKUFLVHCDgyAoI6UYkACL
         cLXoEtdqIv0yxKY3vI0qH0k2p/HC2kJbAeaHbvtuMJTMJ/ZOrNzFam7S9YshxSQOD1eA
         ajEH0P4XnJk6ZcvBBtAbXbDcQI67m3UtvOT9/UZQBH0NeKYX30YIhvZZ1u20lKUzViSN
         sJZt4liCeFEwI7Aw0j10GZGbxffylUd7aH1XAR8TSjBQaLYh91Y6rW5wfDxQuGleNGmF
         ftoO27H2SX8slT2JMFyA3whQEujv9MQFkRsYsd95kkrH3KkWf88Jnn4Kl2TvK2WXgGVS
         Aq6g==
X-Gm-Message-State: AOJu0Yx/EJvZbsG7GM2g+yQ4Jv9oyEORS4ejDAKqfd94Y8Zs5HD71z1o
        DlwFx2g81rp3MRQ2cYyyqrM=
X-Google-Smtp-Source: AGHT+IFrlm4tOx+dZl0DNygmKZUm3g3WWUWZy8C2IkoWH/jLQBTmJeONwoqQItdqyH7rurNQ6Cd9rw==
X-Received: by 2002:a17:90a:dc06:b0:261:2a59:dc38 with SMTP id i6-20020a17090adc0600b002612a59dc38mr1602346pjv.25.1691149889549;
        Fri, 04 Aug 2023 04:51:29 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:1022:c939:1859:30f6:c95a:3e44])
        by smtp.gmail.com with ESMTPSA id je19-20020a170903265300b001b9dab0397bsm1587773plb.29.2023.08.04.04.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 04:51:29 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH 2/2] fixes warning
Date:   Fri,  4 Aug 2023 17:21:21 +0530
Message-Id: <20230804115121.34035-2-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230804115121.34035-1-coolrrsh@gmail.com>
References: <20230804115121.34035-1-coolrrsh@gmail.com>
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

From: Rajeshwar R Shinde <coolrrsh@gmail.com>

drivers/spi/spi-mpc52xx-psc.c:332:5-13:
WARNING: Unsigned expression compared with zero: mps -> irq < 0

Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
---
 drivers/spi/spi-mpc52xx-psc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index 9a1a080..7452bc9 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -329,7 +329,7 @@ static int mpc52xx_psc_spi_of_probe(struct platform_device *pdev)
 	mps->fifo = ((void __iomem *)mps->psc) + sizeof(struct mpc52xx_psc);
 
 	mps->irq = platform_get_irq(pdev, 0);
-	if (mps->irq < 0)
+	if ((int)mps->irq < 0)
 		return mps->irq;
 
 	ret = devm_request_irq(dev, mps->irq, mpc52xx_psc_spi_isr, 0,
-- 
2.25.1

