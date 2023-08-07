Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB35772249
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjHGLbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjHGLbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:31:33 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D9110DE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 04:28:42 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso43769145e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 04:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691407643; x=1692012443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kxk0yn3bHsd/RJ0FbkAiNgx85t4pR2+Dv2sbpn4c78Y=;
        b=m4SenbcsFt674qRn5+kbUSBCfNEsLcMWFRLZaeBmV10RzglyGuRzP4jfRANirlcQtk
         SDxNwHu+Dcv35Sip1lM+Srw3cPoyfhSdZywk6VPBxuQxNb3JtYLtF467sRJ8jjtUYAr0
         hl4wnwf/AeTgqsFGqnxRMT/BHx3JLT5lA8VcmPGe3Y9l4If6LcbymihK3qGnZYVvbf1S
         qFqgDF2ruqeZhxkpS11FazdO8zsPs0/MqIlzElBJqMv+Vz1zuYQGT7+NL2mvBKJz97ev
         n/qAj+0cEwaHVM6keRFewEsu75YydVB8vQw2D1dDvOaYIcW9zZeftxe7butWFQ5AOIMJ
         sbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691407643; x=1692012443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kxk0yn3bHsd/RJ0FbkAiNgx85t4pR2+Dv2sbpn4c78Y=;
        b=Whllp2PtIYmiEoPZUamnhbSJHLep/2c4xlw2LZbXSrP7TLuiEiMc+uvV8JfgZ/+bTo
         iyXtLAcgmmfB+Fic1BodnKb6+3b77fgWyfvgV2bwXe3z8F3XDmNSvcSzmWgt0rHBpGe7
         UbgeLgL+AjZ9AHTENU+ez4v4IX/dLVw6fyI6sAt5Gks88+rj0IkbK9IzagrFGvn6amo8
         CNAe8XQhj82LgbQccIGDeOi4jbj9GhX4bGrKZ4ona6VUlEzOfV9cCgiEjIz//j6OIoUX
         8jPhiEYVZK1CrVABZtbMggHpsCOOxXlryAEPHOUyhliDxj/MFL/VZDJqyTrmOguzTZtl
         fg9Q==
X-Gm-Message-State: AOJu0Yx7ds4VtY8xkIWsOgztgKXHLVuoShUH6N+3qhdoM+SinqJUsbki
        O606kYW4FDoZir0sBTf0CcxDqyBjkAarIA==
X-Google-Smtp-Source: AGHT+IGMBh83Lf6a12odjnWu7+OgCee9BjTsv45wkZZBieJgKm473rbCHKrU7qoTXhavwG8ZHHZK4Q==
X-Received: by 2002:a1c:4c15:0:b0:3fe:207c:1aea with SMTP id z21-20020a1c4c15000000b003fe207c1aeamr7010990wmf.23.1691407643550;
        Mon, 07 Aug 2023 04:27:23 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id s22-20020a7bc396000000b003fc0505be19sm10401106wmj.37.2023.08.07.04.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:27:23 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     mhiramat@kernel.org, hayashi.kunihiko@socionext.com,
        p.zabel@pengutronix.de, alex@shruggie.ro,
        Andrei Coardos <aboutphysycs@gmail.com>
Subject: [PATCH] reset: uniphier-glue: remove unneeded call to platform_set_drvdata()
Date:   Mon,  7 Aug 2023 14:27:05 +0300
Message-Id: <20230807112705.12862-1-aboutphysycs@gmail.com>
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
 drivers/reset/reset-uniphier-glue.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/reset/reset-uniphier-glue.c b/drivers/reset/reset-uniphier-glue.c
index 15abac9fc72c..df41b75786ad 100644
--- a/drivers/reset/reset-uniphier-glue.c
+++ b/drivers/reset/reset-uniphier-glue.c
@@ -99,8 +99,6 @@ static int uniphier_glue_reset_probe(struct platform_device *pdev)
 	priv->rdata.rcdev.of_node = dev->of_node;
 	priv->rdata.active_low = true;
 
-	platform_set_drvdata(pdev, priv);
-
 	return devm_reset_controller_register(dev, &priv->rdata.rcdev);
 }
 
-- 
2.34.1

