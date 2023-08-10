Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BC8777696
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjHJLOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbjHJLOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:14:33 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A46B26BD;
        Thu, 10 Aug 2023 04:14:17 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe4a89e7efso6387525e9.3;
        Thu, 10 Aug 2023 04:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691666036; x=1692270836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+qKWAh96nsPTii+Vr0MXkg/ZLKKDB5ORHCNmQRS3YPg=;
        b=ZpbOUNrE6Af4c3ZCNq8UylkS3e0wwclXXJN2OIHiUi0F6HlgtsNFQBLuSSnvfIVzvn
         wPsE8kZYvRpozi+wnN1H8UYDkHM9cbE9vTdbM5wPl08UmbWUzDQvn1FIXkxZmOrW/1I1
         WfKm3oTZk9+KvSZs/jHwanXy2G93yB0oX9ZKWIzvk8HQ9nNkew2On8CyxSbGKjGDlxJK
         arC2dcIcgkXqC6sHukcPqVDZZ3Hh4VTY5pPoWEp4fqRzFlkeGSPMIosrt/tK7RbZkAHT
         Ud6pDwr72znVZ+cs9vuklJml4QX+0esfmZ1nvg2Q2TWSuzqdfUgKPju7mi5Ed1Ii5w0B
         Qj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691666036; x=1692270836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qKWAh96nsPTii+Vr0MXkg/ZLKKDB5ORHCNmQRS3YPg=;
        b=hmigIGPV2jTVRwiQX8F1dttX/e6sijCpyUgg4uw/LoYi1WOX3l5cEqnBZsiCHAM6Lj
         /lAi7CJoRqIVjzM86y2EfUSFOuos0Tiuv0PHfrBf1u9dqpPoRq3f3Z+ga0qKCHw66Syv
         zIRS7fKY4PJ1QP7Xws5OT15YlDe2BficNRMA9AiG0QYTaLDdCUthGAkXy71eKQmwPkPJ
         V+wYZE9OamQ8Qg8f4zBGpcMPGhzMXLPieKmwA76bsjJ+z02tc+bE08w7z8SC6E2Vrl3e
         ZM4wTtv9sBViNxwY0lXNUc/tk8shtLs6Hhoy3K4TZ0NGsNcq5NBhTLolH4FzZartCKP0
         RfSA==
X-Gm-Message-State: AOJu0YwVohlMqxSV4GrkX6j3Um805DEzpeRePVqpP8tgnpyeNU/jrEtc
        7h75P//lsolovxGOuCuHn+pKNf/s5QqZ/Q==
X-Google-Smtp-Source: AGHT+IFpoDHmW6lXvcnh62To8vf5ZBO5ilXWs3O71KZBCcfTHkjwGfYZszjgWA1urkBKDmQW9rLcrA==
X-Received: by 2002:a7b:c451:0:b0:3fe:266f:fe28 with SMTP id l17-20020a7bc451000000b003fe266ffe28mr1684325wmi.14.1691666036229;
        Thu, 10 Aug 2023 04:13:56 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0ad500b003fbb346279dsm1790283wmr.38.2023.08.10.04.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 04:13:55 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     hayashi.kunihiko@socionext.com, bchihi@baylibre.com,
        rui.zhang@intel.com, amitk@kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org, alex@shruggie.ro,
        Andrei Coardos <aboutphysycs@gmail.com>
Subject: [PATCH] thermal: broadcom: sr-thermal: removed call to platform_set_drvdata()
Date:   Thu, 10 Aug 2023 14:13:30 +0300
Message-Id: <20230810111330.3248-1-aboutphysycs@gmail.com>
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
 drivers/thermal/broadcom/sr-thermal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/broadcom/sr-thermal.c b/drivers/thermal/broadcom/sr-thermal.c
index 747915890022..9a29dfd4c7fe 100644
--- a/drivers/thermal/broadcom/sr-thermal.c
+++ b/drivers/thermal/broadcom/sr-thermal.c
@@ -91,7 +91,6 @@ static int sr_thermal_probe(struct platform_device *pdev)
 
 		dev_dbg(dev, "thermal sensor %d registered\n", i);
 	}
-	platform_set_drvdata(pdev, sr_thermal);
 
 	return 0;
 }
-- 
2.34.1

