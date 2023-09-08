Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79E179830A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 09:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242524AbjIHHEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 03:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjIHHD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 03:03:59 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C514E19AE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 00:03:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401da71b85eso18571755e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 00:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694156634; x=1694761434; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+oF38aHwbiQ0hNIfHRnBks+J8uIKvy2uRm6xWV5PYSI=;
        b=BylgXa14UrUH3AjyONTOjiL4G34AQd0NixsIW9p8inOOdmkGWgkKBzlcscjia9ELB6
         anm2LSFoOgUD3gWhPzXtdxPWKcFUeIuzqy+TDRSSkaogU+Lj/GOoBoBUZ06bE1c6qr78
         /1i0uLr/W2dzt63c+67G+51FDXNs0/USzpCBIhCShcMUkEOq5gk184PIZl9uAPi5CV5y
         ec0k5URQwSd1qLQhVMYqxGU24+I2LO5N8Dl7Re3+yExyN6V8kugXHS/6i3qaTQPExUtL
         DjLsA+WBP2DaJ3qW6hEhgcoc7pe2c4jW4nHIl9n2Yhdwu/Zvm+7lNFwz/1cIHPhNtrR/
         euOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694156634; x=1694761434;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+oF38aHwbiQ0hNIfHRnBks+J8uIKvy2uRm6xWV5PYSI=;
        b=hU45aoOu/K0wZXqLTeLpI4v/lJgYlljWGHUDLjzh9U2OjjCHBpTx4NXDS6eUdSBPsc
         DXuosvMgpTmBZeJyr9QXxg2PfDwQOMc2UJLqvh3mhgc8TGrbkRDuOt9LEvdOOYLIzmC2
         B+tjzmSlrLVTbWQHtqYIrS6QC9nPkR18aGfoIimcAczn2gattP8Ha/AQeBr63IwJPZci
         Fqqe+k3JZAXmpgypi4egU0R7Vg7KqL8hUFUn7f2ghVkcwgw3aAN9KaE/65e4tn4FiXzZ
         ++PQ+9EbeQ1pVTSNWXYVYJWJ1hVGQs8SRj83fKdAU9j6gmIjH/OlYtpugA9zG0cdivO/
         9yqQ==
X-Gm-Message-State: AOJu0Yx82W2/1p0vONBFkRGENLD50Pp9JI5HU5eZPVILTp8IOMTWwv3h
        a96i3NBV7olLypTH0VK4M4qfjg==
X-Google-Smtp-Source: AGHT+IGK2O222KZD2kNm5+Uw1HhQuahUQ+tfcDyX1t6hrrbY6nsHCIIplz9dtQCcch+hrpHLRz75Pw==
X-Received: by 2002:a7b:cc96:0:b0:401:b504:b698 with SMTP id p22-20020a7bcc96000000b00401b504b698mr1267388wma.17.1694156634140;
        Fri, 08 Sep 2023 00:03:54 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y12-20020a1c4b0c000000b003fee9cdf55esm1156816wma.14.2023.09.08.00.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 00:03:53 -0700 (PDT)
Date:   Fri, 8 Sep 2023 10:03:50 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] of: dynamic: Fix potential memory leak in
 of_changeset_action()
Message-ID: <7dfaf999-30ad-491c-9615-fb1138db121c@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch complains that the error path where "action" is invalid leaks
the "ce" allocation:
    drivers/of/dynamic.c:935 of_changeset_action()
    warn: possible memory leak of 'ce'

Fix this by doing the validation before the allocation.

Fixes: 914d9d831e61 ("of: dynamic: Refactor action prints to not use "%pOF" inside devtree_lock")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202309011059.EOdr4im9-lkp@intel.com/
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/of/dynamic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 0a3483e247a8..f63250c650ca 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -890,13 +890,13 @@ int of_changeset_action(struct of_changeset *ocs, unsigned long action,
 {
 	struct of_changeset_entry *ce;
 
+	if (WARN_ON(action >= ARRAY_SIZE(action_names)))
+		return -EINVAL;
+
 	ce = kzalloc(sizeof(*ce), GFP_KERNEL);
 	if (!ce)
 		return -ENOMEM;
 
-	if (WARN_ON(action >= ARRAY_SIZE(action_names)))
-		return -EINVAL;
-
 	/* get a reference to the node */
 	ce->action = action;
 	ce->np = of_node_get(np);
-- 
2.39.2

