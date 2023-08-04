Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE7077095C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjHDUHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjHDUHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:07:18 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AABFE6E;
        Fri,  4 Aug 2023 13:07:18 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2683add3662so1676867a91.1;
        Fri, 04 Aug 2023 13:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691179637; x=1691784437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9KXDwNu6aYrXX0sYCTUcQetgCxUApoq2fXsL5SXF8OE=;
        b=QQcJz9uCjbag3hM391nlRlQLmZBvvnS+vaGXe2qOCoj40pUkuIMTHsCYlmPsvXPOnf
         Bvd7j2y3NN+ZcmUPVAWVZggjSCRtbfCIDzxCrAHd/Asg5dSnfMKmgFvThGbeWwgci281
         tffCY4q8Uff/3XdMlijRwnYUvAUjvs4vsbdt/UoH/x2yq9i18ZkJG19EEBbOA8Douc1e
         SZWaV1HWjuxpRq5Fo6R8mBcJFiy7h7vGkn3OnuLb9kVV08soes8nSI3O/RD50hxL8ScW
         ZOA6OlmKjE0sZDvDGXOC9w71yFrBApzpyH4+/FDUIyw/8qtFqLIYDU+FijqlIHe7Pptp
         QtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691179637; x=1691784437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9KXDwNu6aYrXX0sYCTUcQetgCxUApoq2fXsL5SXF8OE=;
        b=ccQcx7PM2e03HRDSf2E4BPuPvRqsjiMNc8MHaiD9SMRArgFCyrxbunfusm4TSUyfPW
         HIxFBj5ERdoNWPIYqmaCvfsop1/IRK86psKw8YthY3OrPYbcZQfX28djQLSTxaB/Slag
         j6XZ8/DklbNbgJDrTNIKUXm06fba2k95VKIZeJXbf8uZ8Co4XmoaRByld+OvxXV/1owj
         9aqO7wDNBt+QrWQT+vlwf+JEPjjTfWUOS9bAZleN7hTfPqwthYTzheq6urgOn1O0Hu0T
         Le+xlzYr2h8DPdWwf9mRfLfkOV1mdGEYd+HQD9E76kDfMMvscWvTkGoEnBjB9DBiF7/4
         jlng==
X-Gm-Message-State: AOJu0Yz+83Gg8lA/+oqCWVZU4CvZksKlY6xOoFRFbeuNmROnIYJ9QpHq
        WtMXminKVDVGo4X0n1IsvLy31ELX+/c=
X-Google-Smtp-Source: AGHT+IFvx1XZlGEz6pMwJWkfglH5KDZBXPOJzoBmZBez6tvBB1Nv+7/cZdn3eekdoJKXI5GzGsYp3w==
X-Received: by 2002:a17:90b:f8a:b0:268:2f2:cc89 with SMTP id ft10-20020a17090b0f8a00b0026802f2cc89mr2804820pjb.4.1691179637364;
        Fri, 04 Aug 2023 13:07:17 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:1056:ada3:1859:30f6:c95a:3e44])
        by smtp.gmail.com with ESMTPSA id ge13-20020a17090b0e0d00b0024e4f169931sm4534070pjb.2.2023.08.04.13.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 13:07:16 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH v2] fixes warning
Date:   Sat,  5 Aug 2023 01:37:10 +0530
Message-Id: <20230804200711.65750-1-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
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
The fix is for spi-mpc512x. 

This fixes warning such as:
drivers/spi/spi-mpc512x-psc.c:493:5-13: WARNING: Unsigned expression compared with zero: mps -> irq < 0

Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
---
 drivers/spi/spi-mpc512x-psc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 99aeef2..50a4f31 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -490,7 +490,7 @@ static int mpc512x_psc_spi_of_probe(struct platform_device *pdev)
 		(struct mpc512x_psc_fifo *)(tempp + sizeof(struct mpc52xx_psc));
 
 	mps->irq = platform_get_irq(pdev, 0);
-	if (mps->irq < 0)
+	if ((int)mps->irq < 0)
 		return mps->irq;
 
 	ret = devm_request_irq(dev, mps->irq, mpc512x_psc_spi_isr, IRQF_SHARED,
-- 
2.25.1

