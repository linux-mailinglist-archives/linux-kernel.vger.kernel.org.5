Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517B277BF91
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjHNSJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjHNSJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:09:35 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E5410F4;
        Mon, 14 Aug 2023 11:09:32 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so11718708a12.1;
        Mon, 14 Aug 2023 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692036571; x=1692641371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bxONjU63MftJxOkz6NRM6Rjes407erh4cDi2X8r/lC8=;
        b=RXaptiT73Iw/RatjIT3TbwicFz49/1Kgq/z3oAArQb21M1AA35hTR4RxkjMNMn0UQ2
         NbII15mE4CbsWQ8rxd2N71tQ8+KrU7SJM4kKmvGf6A56qpdJ+oxWnEW3phDKjHUrCcYR
         FyBYLKsNTbZ58nX/pIGNnnqzosrcmT9KIemBfLcG1htT74mvtMy2t3vyQZAYP/7awu42
         4K/TsDJDc72KCjKK4c584nCKsn0rnBY1A1x43ujs39gwW6wq+rpii2+vqUxtQ0vdMz9S
         eU19i3Sxjgb9ptu5Kv1ljMj5sZR0eVXnv+RZNuHMNuZKd/tJ5j0OLJmbahjo+TjWC6GO
         EaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692036571; x=1692641371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxONjU63MftJxOkz6NRM6Rjes407erh4cDi2X8r/lC8=;
        b=cg6UslqNlgjnPn+hA+jrdgtpj8Xaw0BTxXXh554kqaW151FWtCnSJayKLM/W9GrnI7
         u3rjFmAdxIgDlhZODkp3WohaDrCLQq0ZsGSP3j1I9DHrrBbvzGzmoO7jTnEbRKrW6SHe
         kGMpGiZ+yCAJ2CyqM5avscTA7ZwLXbda/VT1ktP9HON0l1IYZ3utoV8XoiWd+YyIHCsj
         dqbTnaFroediK2f7dzlMRbKlCMIU4e6yHXTW7PKB4hL8Rxhmu9x3XyANiD/xR4i/GTOu
         58BVRI3p0l00Y5bMgiWmS6WImAp/eUWa2MyXsOjQcFbbg+yORSLg+6gyB1RWGA9YUUzd
         uFfQ==
X-Gm-Message-State: AOJu0Ywy6WUndqP83Ljtl+BQF5Rzt1+Do6wkdFgMDjGwHmTsyTexy0dw
        BPvJkSEX3rBlzMKz1ABlKVsw2R//9eQ=
X-Google-Smtp-Source: AGHT+IFuIvxah9VY9deeEY7DkiCilqjEm+mvmyD4TsGmOlNBPn8JWVcsCQLkrpbtD7P8KZUq1B1khg==
X-Received: by 2002:a17:907:a423:b0:98d:4b97:acc8 with SMTP id sg35-20020a170907a42300b0098d4b97acc8mr15128687ejc.25.1692036570563;
        Mon, 14 Aug 2023 11:09:30 -0700 (PDT)
Received: from localhost.localdomain ([78.97.234.98])
        by smtp.gmail.com with ESMTPSA id lf6-20020a170906ae4600b0099cf840527csm5911348ejb.153.2023.08.14.11.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 11:09:30 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     alex@shruggie.ro, rui.zhang@intel.com, amitk@kernel.org,
        daniel.lezcano@linaro.org, rafael@kernel.org,
        Andrei Coardos <aboutphysycs@gmail.com>
Subject: [PATCH] thermal: generic-adc: removed unneeded call to platform_set_drvdata()
Date:   Mon, 14 Aug 2023 21:09:21 +0300
Message-Id: <20230814180921.3336-1-aboutphysycs@gmail.com>
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

This function call was found to be unnecessary as there is no equivalent
platform_get_drvdata() call to access the private data of the driver. Also,
the private data is defined in this driver, so there is no risk of it being
accessed outside of this driver file.

Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/thermal/thermal-generic-adc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index f4f1a04f8c0f..1717e4a19dcb 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -142,7 +142,6 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 		return ret;
 
 	gti->dev = &pdev->dev;
-	platform_set_drvdata(pdev, gti);
 
 	gti->tz_dev = devm_thermal_of_zone_register(&pdev->dev, 0, gti,
 						    &gadc_thermal_ops);
-- 
2.34.1

