Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA2C7926F4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238054AbjIEQFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245568AbjIECMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 22:12:22 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B77CC6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 19:12:18 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40078c4855fso19869175e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 19:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693879937; x=1694484737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3b8khwuVaQqW/f1c2JeeYqTneL2O3VqH7nZscgYlr4c=;
        b=JHxhxzAnLYTljzkjTcl7CKq9Mp/2pIPXPj7x6nQGo6nUcMUf1o1X/GK+xMRlGWo++N
         A0qVWNuEs8pKeQ9UMs+26uFoqi3tHzoKRJUPIaFdkQ1OgJPtL4t2Z2v5q5IF5INgkHNT
         YLRczJKQESf85lxhihCXJjFvPLwJltgLBPKTsQRI0x/ea1dZ1MEDf8DTLinm+L5oW0c9
         FLmCbarTICB7ZyOf3ftnbdCt5I8ql2h58fas9FCpqlqgY2sy1NYrqKDabpSS5/TACFvA
         JT/7uBZeAf3A48OQLpzE+RIWR7DfFAz2cLlC9UBBhXi3skYhxUC+Lus0xxHSWTv0ue2n
         FCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693879937; x=1694484737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3b8khwuVaQqW/f1c2JeeYqTneL2O3VqH7nZscgYlr4c=;
        b=GOYzgmRw07tQpqEYjppJWZOaIS/X/biXcnQr5ca22fJwAeM+lUkIyODqB55uCB6gHz
         S3KkgU9bCwFbUsmc4NOly2S8z5cc17RVYNWtwyLLksRpqordpbC2Dm9EhmrLn6zgiJ4V
         ZHGpYqVSv6a4TV+4axPWt94Ut94fs09PLcjk16ZY2OzV5b7NuIVEz95HzhZKN+jWYjXL
         c8xUNpoHiHXdxidWjLe5fljXbn9GKkDBkXDDpuVVcJbpknEcLd6twOgXtKVTKvd6gY1N
         nVIXHjK8mQdGZOXwrKmmCFG9i9s88QOc1JcQdOeCz5Rw7H0WGnhUmLzYuyHpC+rwOy6D
         z8FQ==
X-Gm-Message-State: AOJu0Yx+7u4+6CNkmLvG34HXpA/O3lGRtOUh+doDJ7t6155V6ytkrj++
        /SuZTG4wVr+Dr3f+cONDmZ4=
X-Google-Smtp-Source: AGHT+IFlCn5oYvXlpwmHz+ZIUV+WgdEG+pvhiJ/LTI/7h71mbEw2Tqm+0SlCepZj8aqHE4DpXlp5dA==
X-Received: by 2002:a05:600c:29a:b0:3f5:878:c0c2 with SMTP id 26-20020a05600c029a00b003f50878c0c2mr8524056wmk.3.1693879936994;
        Mon, 04 Sep 2023 19:12:16 -0700 (PDT)
Received: from localhost.localdomain ([2a05:f480:1000:b09:5400:4ff:fe6f:7099])
        by smtp.gmail.com with ESMTPSA id e18-20020a5d5012000000b00317b063590fsm15952512wrt.55.2023.09.04.19.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 19:12:16 -0700 (PDT)
From:   zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, zhangshida@kylinos.cn,
        starzhangzsd@gmail.com, k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] mfd: cs42l43: fix defined but not used warnings
Date:   Tue,  5 Sep 2023 10:12:09 +0800
Message-Id: <20230905021209.1412987-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Shida Zhang <zhangshida@kylinos.cn>

Warnings were generated during compiling for functions like
cs42l43_*_{resume,suspend}:

../drivers/mfd/cs42l43.c:1138:12: error: ‘cs42l43_runtime_resume’ defined but not used [-Werror=unused-function]
 1138 | static int cs42l43_runtime_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~
../drivers/mfd/cs42l43.c:1124:12: error: ‘cs42l43_runtime_suspend’ defined but not used [-Werror=unused-function]
 1124 | static int cs42l43_runtime_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~~
../drivers/mfd/cs42l43.c:1106:12: error: ‘cs42l43_resume’ defined but not used [-Werror=unused-function]
 1106 | static int cs42l43_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~
../drivers/mfd/cs42l43.c:1076:12: error: ‘cs42l43_suspend’ defined but not used [-Werror=unused-function]
 1076 | static int cs42l43_suspend(struct device *dev)

Fix it by guarding it with CONFIG_PM/CONFIG_PM_SLEEP.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 drivers/mfd/cs42l43.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index 37b23e9bae82..e589a61c118d 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -1073,6 +1073,7 @@ void cs42l43_dev_remove(struct cs42l43 *cs42l43)
 }
 EXPORT_SYMBOL_NS_GPL(cs42l43_dev_remove, MFD_CS42L43);
 
+#ifdef CONFIG_PM_SLEEP
 static int cs42l43_suspend(struct device *dev)
 {
 	struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
@@ -1120,7 +1121,9 @@ static int cs42l43_resume(struct device *dev)
 
 	return 0;
 }
+#endif
 
+#ifdef CONFIG_PM
 static int cs42l43_runtime_suspend(struct device *dev)
 {
 	struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
@@ -1176,6 +1179,7 @@ static int cs42l43_runtime_resume(struct device *dev)
 
 	return ret;
 }
+#endif
 
 EXPORT_NS_GPL_DEV_PM_OPS(cs42l43_pm_ops, MFD_CS42L43) = {
 	SET_SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
-- 
2.27.0

