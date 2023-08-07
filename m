Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438D47724F3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjHGNGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbjHGNG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:06:29 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE05799;
        Mon,  7 Aug 2023 06:06:28 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so72349571fa.2;
        Mon, 07 Aug 2023 06:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691413586; x=1692018386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=edF6okRAhEIaoVUfu5c9jPsQSXq90gu04OWEswlro8E=;
        b=KzmV2E1b2U/AM3KoeVkXej0i5CiLcSaVxeBij8r0v8W3DjXFMr6btU1Wgk/pNp+EuC
         L8shhipPz00p9phnxCl86jYMVzizlMwDok23vi5c/CQ7tIaWS1Bhr1XOJlXAdJNso9p1
         63QVanjxnl4KfaljeI12ENNN/fBCrLLtGyBfk+eAiw2SiJjG68I0IsgIyqrMRwPzpMqs
         wxYLtZyfal8b0VyRKxcCqk//agU5OLZDDPw+BgXNs7qYI1ke11A8YEAJv7K5uLAfMT2e
         72L9l2VQpE55GFSOgrNDcrM1Go45Bq0HMgvq+U7/cKoGYPsJX3VACbDLGgnSgfGs5x9r
         pm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691413586; x=1692018386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=edF6okRAhEIaoVUfu5c9jPsQSXq90gu04OWEswlro8E=;
        b=YgZzcUB1onwui/XrGTe/+PDt+KBcEUXakpJjw8SKLb5j8fezeA58iJZ5Ph+Dvd+fcU
         h4DcZx0wSLBfs/P2/6UUTSxAk/GYMd/nA/X5l7vQ+FeXhZ6oAbfnG79jADwEJDvl5+Dw
         jnQjmzxlSSZytwiUSAKAkD4QxTaqH56HzY9c+LdiHZk1OX8/rD/shMQ/EnxeUYUJuxyi
         RNCJeC0eZ8/cCcx8miZvbuFMcluOhq6ERqEh0s1whzd1s1dxeGR5SdON9J+bCC1pFBqW
         B/n4SySVfQUpZnvtK9x4DiKjmYJK0Zzt5dn90H8mLLbfZ6MDXAUjgFwXrCm+AJrcIO3U
         P04Q==
X-Gm-Message-State: AOJu0YwNhuP67fSjMTOh//MSbyDFlv4ChXbl9KUaZNA/91IeKFtHBuS5
        bT5V0PPuGjoyxNwsFmuAJf4Q6oCg6rjhWQ==
X-Google-Smtp-Source: AGHT+IEREQ5rf3VpJcbhPJeLG7cE8+lkekw18g7T+dbFBfKpb2yB7bla1owo2msSSozbFf0SfNi0JQ==
X-Received: by 2002:a05:651c:14c:b0:2b9:cf47:ce69 with SMTP id c12-20020a05651c014c00b002b9cf47ce69mr6536905ljd.48.1691413586295;
        Mon, 07 Aug 2023 06:06:26 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id x23-20020a1c7c17000000b003fe539b83f2sm6759493wmc.42.2023.08.07.06.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:06:25 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     broonie@kernel.org, f.fangjian@huawei.com, alex@shruggie.ro,
        Andrei Coardos <aboutphysycs@gmail.com>
Subject: [PATCH] spi: hisi-sfc-v3xx: removed unneeded call to platform_set_drvdata()
Date:   Mon,  7 Aug 2023 16:06:15 +0300
Message-Id: <20230807130615.17991-1-aboutphysycs@gmail.com>
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
 drivers/spi/spi-hisi-sfc-v3xx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
index 7cbcb065bb44..b0da667eefb9 100644
--- a/drivers/spi/spi-hisi-sfc-v3xx.c
+++ b/drivers/spi/spi-hisi-sfc-v3xx.c
@@ -443,8 +443,6 @@ static int hisi_sfc_v3xx_probe(struct platform_device *pdev)
 	host = spi_controller_get_devdata(ctlr);
 	host->dev = dev;
 
-	platform_set_drvdata(pdev, host);
-
 	host->regbase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(host->regbase)) {
 		ret = PTR_ERR(host->regbase);
-- 
2.34.1

