Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52A678EFFD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344993AbjHaPNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241589AbjHaPNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:13:15 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1C2E53
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 08:13:12 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68c0d262933so763162b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 08:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693494792; x=1694099592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WePhCNprvzhfqTcAW8CAS7gMkvp1uxO5II/jSZFqoo0=;
        b=IKiyddqunebL5PqCO5pRWhlI5rlULcjlVcYmZ+bkqC2O251WcBtq+Z7dFMfBbvRPrf
         rhZnnTV3/P8zdHFNm6zFavouhyhhva0G1GtJ/WzEPxP+1jQgpUfw7baaoEKjEnd1DOWO
         X2FUys0ICcQHasqxUx1TMP+k1eELR7rAOU5kC0eUlm1ceA8kbep9ZwIDz/UfHzZChmgR
         hPccGiAaTSZ+r4FjSZoN+7WVf+6nlXRnH/sdOh5+fsVGsCtecBQUdWfvEgmLnc4mq8Mj
         ltKLGN9b+YHe+6AJsV3uE5fT1pogMvc18vM0OJhxpqLRnxfHku6XxFMCZg5Sfu4KyRxy
         sbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693494792; x=1694099592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WePhCNprvzhfqTcAW8CAS7gMkvp1uxO5II/jSZFqoo0=;
        b=dq7kPF8aKI1OCnFKAWbLjnOmQzr511/TeWAjyhS5Tp0Wqeit4JISdxbsFRIfwOG4fd
         cwpC6E75OaGykvmWFr9MWBb5ncp/tdAlwPUuSnMoQWs7WakBIdT7uwlwxO/+myYyhsfo
         NRe3srepavEqNxsLtsa9oUMtVJQWsY8e/bDqTy1N78IVJUGGGQgEsIGY2HNhbZ5fLm/O
         /pxcI01SJn1CxdAg7YKvILhyf5pOfYgTJV+gGIoC1k4nN+Knci+gpNXlTxL/XrRfoqE/
         16L7mctumvOLhC4WenpwGQpZlUL71PfidEGr2Cu6OlFBwAZ7QX261EvH8YNkYcrU7gcF
         Ugag==
X-Gm-Message-State: AOJu0YxpnhI6i7oc31iRQuh3VX6tosEc13JHmM+ZLhPMjO8EmtUruJaw
        LrEc+0UocDfAK1HiYupTxA==
X-Google-Smtp-Source: AGHT+IE3CdbiyXgOsrhkN+CKDpvSMC1AK2ggAryze0oq38fRNfV/ZWHANRwGGuKVyhv3o+tGoz5NCQ==
X-Received: by 2002:a05:6a20:4416:b0:14e:509:2007 with SMTP id ce22-20020a056a20441600b0014e05092007mr74093pzb.42.1693494791781;
        Thu, 31 Aug 2023 08:13:11 -0700 (PDT)
Received: from svr-pkl-eng-01.pkl.mentorg.com ([110.93.212.98])
        by smtp.gmail.com with ESMTPSA id q15-20020a656a8f000000b00553dcfc2179sm1337238pgu.52.2023.08.31.08.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 08:13:11 -0700 (PDT)
From:   "Arsalan H. Awan" <arsalanhassanawan@gmail.com>
X-Google-Original-From: "Arsalan H. Awan" <arsalan.awan@siemens.com>
To:     ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     "Arsalan H. Awan" <arsalan.awan@siemens.com>
Subject: [PATCH] soc: ti: pm33xx: fix resume from non-rtc suspend modes
Date:   Thu, 31 Aug 2023 20:12:32 +0500
Message-Id: <20230831151232.4169624-1-arsalan.awan@siemens.com>
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

The am33xx_pm_rtc_setup() checks if the rtc device is available or not.
It configures the rtc if device is available, otherwise keeps the rtc
mode suspend functionality disabled.

In case a platform does not use the internal rtc and it is needed to
disable the rtc-only suspend mode, the resume from deepsleep or standby
modes fails right now becasue the am33xx_pm_end() tries to access the
rtc device and that results in a NULL pointer dereference.

This patch moves the rtc-only code within the correct bounds.
Otherwise, we get a kernel OOPS with a NULL pointer dereference on
resume when we try to access omap_rtc_scratch0.

Signed-off-by: Arsalan H. Awan <arsalan.awan@siemens.com>
---
 drivers/soc/ti/pm33xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index f04c21157904..e3ccb0bb198a 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -305,10 +305,6 @@ static void am33xx_pm_end(void)
 	u32 val = 0;
 	struct nvmem_device *nvmem;
 
-	nvmem = devm_nvmem_device_get(&omap_rtc->dev, "omap_rtc_scratch0");
-	if (IS_ERR(nvmem))
-		return;
-
 	m3_ipc->ops->finish_low_power(m3_ipc);
 	if (rtc_only_idle) {
 		if (retrigger_irq) {
@@ -324,6 +320,10 @@ static void am33xx_pm_end(void)
 				       + retrigger_irq / 32 * 4);
 		}
 
+		nvmem = devm_nvmem_device_get(&omap_rtc->dev, "omap_rtc_scratch0");
+		if (IS_ERR(nvmem))
+			return;
+
 		nvmem_device_write(nvmem, RTC_SCRATCH_MAGIC_REG * 4, 4,
 				   (void *)&val);
 	}
-- 
2.25.1

