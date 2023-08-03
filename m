Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8752876E5D8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbjHCKmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjHCKmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:42:37 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39047211E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 03:42:36 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99c4923195dso112985066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 03:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691059354; x=1691664154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XbPbhMPVNEeVzbeeIgaxflnjIdmgr2gMBYjVpji1WIA=;
        b=o2gOO30Wt1efKoG1KegAsqkU3b+hN8NuVghtO3ma3kL8HWxzQpksmPuMnVTXCUk2j8
         +NNc3FZnDBoXnBZdnAH6xbTVwqhKApwR6SAyV1CkzYOIIO+lEf5XtzfGxF0dVLVhfrkk
         7Q6LXLcJkuM0fpBcki7vRagHd9eyi55x1DUYyxcMfkn1vCc+FjrjW10re1GrroFEXfB6
         7jzC+kLM5x7XW3TTnZO2kYt6FeTJxd5a/Qz8j+7jgH4p8VDeL4wO42FCMJdeqlvetuvb
         BilVVALMIU3V8YKh1UrgKKrw5RchlAhP3kVgnGvUCXUwdp/ltsfCaonUiYNsvuxkkLrl
         YMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691059354; x=1691664154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XbPbhMPVNEeVzbeeIgaxflnjIdmgr2gMBYjVpji1WIA=;
        b=MPN31CI49K9HDfjHcVzEmkV2/ffbuiPtZVCHdWAJpxe1O/pFxmkUEQLfRewo904tp+
         lyuI2+qzolwlDIGYURbVlPF4+SDllY6iQvs4yxUZFUlWYQEZ+3n0kF+/j6Re9go/9MX8
         1bfmjrLWCWJIEOnbe08CAh3Dl+c701kQrc3a1LPreQHiV/lReHlDwbvJ7Z1defd0vRZD
         HW8TSi0SxZP2kY6GLhNKL+mvxRQ6gPWo9fYCJD2uY2ILuHclZdCEzi62RkZHA5Jf/XSH
         HU/Y/LZh6Yr80H81C782Y4aFe6Txt05ANA2ygbVZhCPfFvK0p/hHs3fCJd/YqXRBSeQ7
         y+4A==
X-Gm-Message-State: ABy/qLbG1DxCfR02z+gHlAfaDptaMaX8i/zxR578RG1iKBGTF60OBKVI
        rEuHRT8CaTT8QU4NQw7Psrv9TZTeZ9aujA==
X-Google-Smtp-Source: APBJJlGgqrTC8+1LMVZXagZDD6LFQNw9/8Z5hZflR8UD9ynlL2kv6dAkxidC/nIOZq6Rq7+1TqAxzw==
X-Received: by 2002:a17:906:186:b0:99b:d599:5086 with SMTP id 6-20020a170906018600b0099bd5995086mr7540965ejb.75.1691059354223;
        Thu, 03 Aug 2023 03:42:34 -0700 (PDT)
Received: from localhost.localdomain ([78.97.234.98])
        by smtp.gmail.com with ESMTPSA id o21-20020a17090637d500b009937e7c4e54sm10320333ejc.39.2023.08.03.03.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 03:42:33 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     p.zabel@pengutronix.de, Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] reset: lantiq: remove unneeded call to platform_set_drvdata()
Date:   Thu,  3 Aug 2023 13:42:25 +0300
Message-Id: <20230803104225.29740-1-aboutphysycs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function call was found to be unnecessary as there is no equivalent
platform_get_drvdata() call to access the private data of the driver. Also,
the private data is defined in this driver, so there is no risk of it being
accessed outside of this driver file.

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/reset/reset-lantiq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/reset/reset-lantiq.c b/drivers/reset/reset-lantiq.c
index 549ba45d8597..652a45890cb2 100644
--- a/drivers/reset/reset-lantiq.c
+++ b/drivers/reset/reset-lantiq.c
@@ -173,7 +173,6 @@ static int lantiq_rcu_reset_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->dev = &pdev->dev;
-	platform_set_drvdata(pdev, priv);
 
 	err = lantiq_rcu_reset_of_parse(pdev, priv);
 	if (err)
-- 
2.34.1

