Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4E377095E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjHDUHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjHDUHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:07:21 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864C7E6E;
        Fri,  4 Aug 2023 13:07:20 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-26929bf95b6so529082a91.3;
        Fri, 04 Aug 2023 13:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691179640; x=1691784440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtS43VRN+wQ8hITEdXVbnPip0UGeJtnpKDCpHqfHLZ0=;
        b=qRShR6hITtCBjV+oK0KgZCb+6sv+cl9TdFrYsKET2tthiuttb8IK2pDgViMHnXYsil
         94QrwcteZ6XYPoXXNWkIIo7mjPZOFzWgrdfC0FAqW8CcHawAhI1MgSFsB9ocaGgYLjiG
         W2QR0btpWXuTaFkmRU+Ss3Jmrcc8LyTsG8BYRbTZ3nEFxJCvNkEpeGdKr7Bni+YqwSEK
         psu65ava9S9T3/yZBkLoZNEB/DBNUo8XZXzM1AGYhY4GKD0i/w/lLiZ5nR78O0PU9KxD
         aOfy/hfMj6TOQf6Kb1Dwiqd8OxcPDB3k1Oweh8yDrbm5s7kvxDCX9tVnDOglqWE+6/DN
         nwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691179640; x=1691784440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtS43VRN+wQ8hITEdXVbnPip0UGeJtnpKDCpHqfHLZ0=;
        b=NI1jhhybalD63Pad3aYyqgVej3EJt7l8CH5FLN8rZx1ayp9Svm4AtYi1tNlLlwb33s
         JKLLplyQuV1D5HZte8Ra0KqyiUmSSs6aGpOv0S+HmPEPVgFiA58BiGH45NP6xNsskQId
         NpHlVEqcT8XkwcNaZ4s1mOCw/eWZ2NXk5GaidikKk2ToJGeoqQE42jNLeJkJHd4eh5nF
         xjo0q59bi/nC3zTjvcGNxreHuUZZRZDLmZI7WPckk+CnBlkfXqZXjTNA4XoGkmKQDfnD
         mb0TDIYqYERLSNaumPjxIs2ySVZFC4eNY0+7c/hzgaPs+JKBfPSdxgbKsf0Y4dAPCWTR
         mbRw==
X-Gm-Message-State: AOJu0YzfFIwduzidQcMZA9uTWiyCZPEVXFNqrJ/tHWqSCsCEEgtRmVKO
        CX4bqcZkKrO4obhlAb/EepQU2HBpmA0=
X-Google-Smtp-Source: AGHT+IEyWUYvrH/JemdEKPGi4U2p6ZES9M//wAnNICsyd8RzpEAx4vwqKv3W+aBTx7dE+oqKc3wacA==
X-Received: by 2002:a17:90b:889:b0:268:352c:9d13 with SMTP id bj9-20020a17090b088900b00268352c9d13mr2467096pjb.0.1691179639882;
        Fri, 04 Aug 2023 13:07:19 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:1056:ada3:1859:30f6:c95a:3e44])
        by smtp.gmail.com with ESMTPSA id ge13-20020a17090b0e0d00b0024e4f169931sm4534070pjb.2.2023.08.04.13.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 13:07:19 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH v2] fixes warning
Date:   Sat,  5 Aug 2023 01:37:11 +0530
Message-Id: <20230804200711.65750-2-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230804200711.65750-1-coolrrsh@gmail.com>
References: <20230804200711.65750-1-coolrrsh@gmail.com>
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

Typecasting the interrupt number from "unsigned int" to "signed int" to compare with 0(signed int by default).
Declaring interrupt number as "signed int" would violate kernel standards. So typecasting is the possible approach.
The fix is for spi-mpc52xx.

This fixes warning such as:
drivers/spi/spi-mpc52xx-psc.c:332:5-13: WARNING: Unsigned expression compared with zero: mps -> irq < 0

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

