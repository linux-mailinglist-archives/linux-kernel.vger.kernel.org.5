Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BDD762DE8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjGZHhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjGZHgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:36:13 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0E71BC3;
        Wed, 26 Jul 2023 00:35:04 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1bbaa549bcbso775411fac.3;
        Wed, 26 Jul 2023 00:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690356903; x=1690961703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpAr8v012KhqX1+x4NzPtOBVQVImVkoVUEI38Fgz8rc=;
        b=i0eKRsjIyVVbYd1lVLYFxs9VTw0eWkseRLxPrzo9du3bo1l6Nzh8E1FwkWGBF2qugV
         Y8U1q5Ph/70usobN09D7YmqaNyyArEvNbSprA0/2uxpvKlv2uQjCaMfnHMva3Yb0f1FB
         ddR0dZZn6opfxuiMHySD5eknjPBwgYMHlgrpOlRVhVGAT+8UonayAU5yvdTKTDQqTPEK
         CFNrU2R2qA6Ym9PDMgNAS4IsDymUeoyhRfRgmnew0xzJg0+Nkb02anrDM6/qucjm96FN
         SUZSp9zve0eb2iVwngD3Gf1tsbeYG/NR5YxVxCmFRUxRguroX6gNXx11a/Glro8JQyJz
         Z3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690356903; x=1690961703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpAr8v012KhqX1+x4NzPtOBVQVImVkoVUEI38Fgz8rc=;
        b=DWSMpdWVVe/fzRWip3kvwYRZjCrE8hjTue8NPHzLHYyi11VUvZcR8M/FvPK3A5vPjU
         EJYKfUNm4wzRfp+nrKu9wfMPVzys7ktJ1hTey7LP9o371p9T85/SRi8gIC3d7jYGs06V
         MUsq4GfQqnbx21W+Ckfu3ewB5mqFIyvUUnXiaO/HHJS+zS0z4tgwlRn4/Xx8p2hlzvzI
         8r/ELiRxG64zfFFoJ4C15TBWuZl6jv8xIaLblzj3VOuBBb/KsDowPQn6zbHm5tpxNOln
         D8WfW50tA5KozeDERU5YqlQhZggroeleuj5nSjOfQCV5UaDWNZbMTxOF7GnblDgnPGog
         5vpw==
X-Gm-Message-State: ABy/qLZ5KKfLblYvmGZRCNvC5j//cUkQq9AziG96VZxQXyZkNYrqV79s
        3coaGvAQlS3ey4BHjhgRAl97QGx3VJU=
X-Google-Smtp-Source: APBJJlFFomszN8kP3yspGJBy2E3RSVrZUxTKDq37vM5cokbTsNsZRBeutqBDHbNe6M8AoC5aMFbX+w==
X-Received: by 2002:a05:6870:3049:b0:1bb:979d:5b05 with SMTP id u9-20020a056870304900b001bb979d5b05mr1623942oau.57.1690356903596;
        Wed, 26 Jul 2023 00:35:03 -0700 (PDT)
Received: from cxl-test.. ([103.181.222.211])
        by smtp.gmail.com with ESMTPSA id hi16-20020a17090b30d000b0025be7b69d73sm692301pjb.12.2023.07.26.00.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:35:03 -0700 (PDT)
From:   Raghu Halharvi <raghuhack78@gmail.com>
To:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        raghuhack78@gmail.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com
Cc:     linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v7 2/2] cxl/region: Remove else after return statement
Date:   Wed, 26 Jul 2023 07:34:21 +0000
Message-Id: <20230726073421.2452-3-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230726073421.2452-1-raghuhack78@gmail.com>
References: <20230726073421.2452-1-raghuhack78@gmail.com>
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

Signed-off-by: Raghu Halharvi <raghuhack78@gmail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
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

