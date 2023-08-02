Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876CD76CC54
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbjHBMJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbjHBMJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:09:37 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22917271F;
        Wed,  2 Aug 2023 05:09:36 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5221ee899a0so9016205a12.1;
        Wed, 02 Aug 2023 05:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690978174; x=1691582974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kIfnwiKIrKjy8l+DtnHC/rUW3Cj13n5h4X8XpNbnkyM=;
        b=DyhB/KMxgYS+hBfZV6y0QkwuP8HK2zVcW0tYBoZ2pEqwSEGNQB9u2GyVGUHU9FKz/h
         ydy9W6pkqAoST2V8ycIQjtjjNUUHkqvF2E0cVfug86Kg4P6//7P90W/wnalAyrifTZuq
         a4N4X4Dsd2U9EWTFJ5Z153dCUyOfH7Pn5u5CP3WQyTjpY/x9CLSx1Lz0CoohDCRmpNki
         2RGfg2nkQD4fiel6zJpsDhIHkhd6vzCayvfLNfMUWzzZfMTOOF7nINFnlLfYu14z/0j1
         2kSqTBBVhIuwtSUolQvKwf59jzQ3tpPoeu/mv1h3Z6ZQNFRYjRWVocHB6BQ01nUdz7M/
         1nYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690978174; x=1691582974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIfnwiKIrKjy8l+DtnHC/rUW3Cj13n5h4X8XpNbnkyM=;
        b=CcaHqyuJpGv9cxDJXAIchL30OMjLy9hqAl/mU1q/BL5m7r418XM8EMoUgDGHeHJ7Z9
         CQTl2s477hpf5tqAN1rAM9iN4zv6KQ97o/+9HDogWpxhE2KuDBD1emPLRiKz7XsCdNJD
         VsfnH63oPXhAbjXBd2FOUosdblAmz2xquhIMc4LJ8Ek2gRQVxFj8IPfOPcy2+Rh/eBmo
         fzMBlG6EaY2DaWln1wHNCybExWnm3cawybLTlJWi8ii+OD7XGv3NakRsoZGuS2wuqk0y
         640uc+bXUuInghtK8y+fwFneCP+YkJSDQi43dxcZyEymmJ79Jl99u/FD6tJgGeuzJLJk
         FDww==
X-Gm-Message-State: ABy/qLb+Dn0A20aUlj/H/m+LboreCe5jrOPHfpx7aDd8fLD4fsPGg9G1
        opp0YTacIFn8MyYdZFNYvRSWIiU5whyJFw==
X-Google-Smtp-Source: APBJJlFIlMpjkQXYR0nTH3B/PW4Nk+MZdj/vRDNt02fMNNjw4O3ddEje19xHCBDCsg9Jr6lvTvK/qA==
X-Received: by 2002:a05:6402:b09:b0:522:c877:568b with SMTP id bm9-20020a0564020b0900b00522c877568bmr4935572edb.16.1690978173944;
        Wed, 02 Aug 2023 05:09:33 -0700 (PDT)
Received: from localhost.localdomain ([78.97.234.98])
        by smtp.gmail.com with ESMTPSA id b21-20020a056402139500b005227e53cec2sm8375732edv.50.2023.08.02.05.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 05:09:33 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-iio@vger.kernel.org
Cc:     alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com,
        lars@metafoo.de, jic23@kernel.org,
        Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] iio: trigger: stm32-lptimer-trigger: remove unneeded platform_set_drvdata()
Date:   Wed,  2 Aug 2023 15:09:15 +0300
Message-Id: <20230802120915.25631-1-aboutphysycs@gmail.com>
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
 drivers/iio/trigger/stm32-lptimer-trigger.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/trigger/stm32-lptimer-trigger.c b/drivers/iio/trigger/stm32-lptimer-trigger.c
index 2e447a3f047d..df2416e33375 100644
--- a/drivers/iio/trigger/stm32-lptimer-trigger.c
+++ b/drivers/iio/trigger/stm32-lptimer-trigger.c
@@ -92,8 +92,6 @@ static int stm32_lptim_trigger_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(pdev, priv);
-
 	return 0;
 }
 
-- 
2.34.1

