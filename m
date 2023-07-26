Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC7F762DE5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjGZHhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjGZHgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:36:12 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A826D3C06;
        Wed, 26 Jul 2023 00:34:50 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-55b0e7efb1cso3324024a12.1;
        Wed, 26 Jul 2023 00:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690356890; x=1690961690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRnV5JdNqK6jPNuTWUhB/5FsT2nTy7kPcLhJ05f7V50=;
        b=NzKVQUZrWEDUPGwG4L+CoCaFCJJhMB3qp1CBS7I0lfQxIHInFbXvLjzxd6CcGSAIMx
         UYbji16yO2CamWVEoGMpBgWgQr6OV4yZ3DWE/AIdk8L/DDD2q7ZeusVf3LISZ8H0CXa8
         OGKGLI6Bhp+wM/g6RiVwa+q23WQ+yTQlxysKN9YBUGACp7e7GVRPLURKESnjcx1nJ5fq
         DEmehtyA7lolA8OwCGibF9pECUI2lyUnOxTEh7QFUb4oQJ3GRlusSczyY8p24T0LOxvS
         IOa7OdBcEwy28ODFQNkPKCt0FBZNETXWKgEaiilD8EljeUvp4n0wb4p561Wy+pnXem7U
         6oOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690356890; x=1690961690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRnV5JdNqK6jPNuTWUhB/5FsT2nTy7kPcLhJ05f7V50=;
        b=Z5Nd7sXg2aXZGAB/aKp92ZeB2S76TY01juZSS2WbWAbosUqx6I/uWx60kvIXMiLJXi
         d2YiC48chAoH3S7Xp5qOpzU/Di0w8FiTTlqAr8oewlmtH3DnRwatpuNalHlRscbRao2a
         2lUwBi49TYeEFfigjVCgqQ1Pb7LZ01ewuR0f4bHYN/7ALuNEU4xnH5CWXsDQlZtVkq41
         F3bWDjVHv80aUntyZTGLai4qtepZ02AyD40tB23Iyt0mPVOfHKyFqgHQmG1/Yc1eEeJK
         64dkpnJDgs6uXZcIS6sBLzF08ccYpw1BDSBL2TONChdA2+y520Gd/E8qtBmkA7+Q6XzV
         DtoA==
X-Gm-Message-State: ABy/qLb3gOZWjvabigIuMAU0DQUfkpmO+vyKqqzxSHhKN7qBeSKq8MrA
        85TsR4i6NX4LTW0nid7LMT9GZ9cZvi0=
X-Google-Smtp-Source: APBJJlF6n2Ig8m+bkHWYCA2c2ByN+HHLx0s15IbXCnTeXShR14Daff60GOc1GOVPzozLC6BIyTkR5A==
X-Received: by 2002:a17:90a:6344:b0:268:400:ecef with SMTP id v4-20020a17090a634400b002680400ecefmr982916pjs.45.1690356889861;
        Wed, 26 Jul 2023 00:34:49 -0700 (PDT)
Received: from cxl-test.. ([103.181.222.211])
        by smtp.gmail.com with ESMTPSA id hi16-20020a17090b30d000b0025be7b69d73sm692301pjb.12.2023.07.26.00.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:34:49 -0700 (PDT)
From:   Raghu Halharvi <raghuhack78@gmail.com>
To:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        raghuhack78@gmail.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com
Cc:     linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v7 1/2] cxl/mbox: Remove redundant dev_err() after failed mem alloc
Date:   Wed, 26 Jul 2023 07:34:20 +0000
Message-Id: <20230726073421.2452-2-raghuhack78@gmail.com>
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

A return of errno should be good enough if the memory allocation fails,
the error message here is redundant as per the coding style, removing
it.

Signed-off-by: Raghu Halharvi <raghuhack78@gmail.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/mbox.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index d6d067fbee97..af7f37cea871 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1325,10 +1325,8 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 	struct cxl_memdev_state *mds;
 
 	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
-	if (!mds) {
-		dev_err(dev, "No memory available\n");
+	if (!mds)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	mutex_init(&mds->mbox_mutex);
 	mutex_init(&mds->event.log_lock);
-- 
2.39.2

