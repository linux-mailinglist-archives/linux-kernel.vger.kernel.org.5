Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA7D761821
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjGYMUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbjGYMT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:19:56 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D340A3;
        Tue, 25 Jul 2023 05:19:52 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-52cb8e5e9f5so3565677a12.0;
        Tue, 25 Jul 2023 05:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690287591; x=1690892391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKgU9gs3SrD9kqMiFBWOg/5RTIIycH4Kj6dCZUirkJM=;
        b=Skw5Ja0n9v+wupTZXM25KmpWUMd3XkQ/QGh60t2IyPIna+NBcWAFsir2eu+crL7crs
         ut5F9vQXg4kwmti5Cbm62dJ19p63EHAI92O06hkn8WoodHk0JYoy0PoCSfJoA3whXsDW
         q5vdedj1lVDnEnbmevYJv4PJD7wA4jVWpYBF/2nIFoDuPuVstMmMQPpeS2MIHQS6Hs2/
         xghScz6v9wvY2RDTC8iAxELf7QL52dIhP1RXsaGQGOXlI5MAlMSXiusc+M7SpaiZa+Vs
         q8bqtQLKCHdwLJvNfUrK3pvykzijy+oBEWXCq8DJDEuRFBEacMOh1CFVrmHUvsLtEYRK
         /hYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690287591; x=1690892391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKgU9gs3SrD9kqMiFBWOg/5RTIIycH4Kj6dCZUirkJM=;
        b=MnXwPmMJaiKtvFWyCkK7aRZOs2rUzF35kADWzhehZQWSnpBs+vd0ZEUqClHI+knJh2
         w//mZbq/YXk1DBbGoqToA8Tlx7VgOjCtMoviDDEy/JXyGa97R4n+hhPrpo2OZ/3r8m8k
         3tPWiQWyHYS4H2VZ4SZI2TI/Z72t+atjMyXKjtMFpTmA8Bot600omA/tjzFrULDTo9qE
         Q4OOaRrv383E3Znf6TP3wllGgf/MawFzN4VF9EnmF4GE2LpFyWmPeXf+3XnMlqMsoPbI
         CEiYfkZ87njBk4Gw0kavHRYAxvzdn2q2aXCzMFsnGpWXQICzdpXVV2ZzRcdZgW/BL3KD
         ppQA==
X-Gm-Message-State: ABy/qLYZKn8Es02IwEgG8daVkymB75ocTXb31PGhg7egMy6tzcT3qU/3
        yymPoSaV59HTDBd1Z9erOqIFE/E/Hdg=
X-Google-Smtp-Source: APBJJlH1L/HZXHquJtosIMYurZELs04Aw3D8YcKzI+1KwOpkF2UiLFV/uY+a/IVOHfQcnZUkC/pKHA==
X-Received: by 2002:a17:90a:8685:b0:263:5376:b952 with SMTP id p5-20020a17090a868500b002635376b952mr435422pjn.9.1690287590900;
        Tue, 25 Jul 2023 05:19:50 -0700 (PDT)
Received: from cxl-test.. ([103.181.222.211])
        by smtp.gmail.com with ESMTPSA id bg1-20020a17090b0d8100b002676e961261sm988185pjb.1.2023.07.25.05.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 05:19:50 -0700 (PDT)
From:   Raghu Halharvi <raghuhack78@gmail.com>
To:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        raghuhack78@gmail.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com
Cc:     linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH RESEND v6 2/2] cxl/region: Remove else after return statement
Date:   Tue, 25 Jul 2023 12:19:30 +0000
Message-Id: <20230725121930.3732-3-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230725121930.3732-1-raghuhack78@gmail.com>
References: <20230725121930.3732-1-raghuhack78@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Issue found with checkpatch

The else section here is redundant after return statement, removing it.
Sanity and correctness is not affected due to this fix.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Signed-off-by: Raghu Halharvi <raghuhack78@gmail.com>
---
 drivers/cxl/core/region.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e115ba382e04..bfd3b13dd2c1 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -133,11 +133,11 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
 				&cxlr->dev,
 				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
 			return 0;
-		} else {
-			dev_err(&cxlr->dev,
-				"Failed to synchronize CPU cache state\n");
-			return -ENXIO;
 		}
+
+		dev_err(&cxlr->dev,
+			"Failed to synchronize CPU cache state\n");
+		return -ENXIO;
 	}
 
 	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
-- 
2.39.2

