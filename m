Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5EB765791
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjG0P1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjG0P0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:26:51 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9A02D54;
        Thu, 27 Jul 2023 08:26:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31771bb4869so1150236f8f.0;
        Thu, 27 Jul 2023 08:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690471608; x=1691076408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HkMGDumQlalY89C6gPCAt+EinCF2NpTD+G/geonEwe8=;
        b=QJLPzqFhw7qbdOMo67W0DveidbMWfA8UYMf6LvQNtcDD1N7p0GXZhxZIqEcIQVeAbw
         l8z9ApmYfdLNVwUvry+24uZ5rpIXD6UxJr38/t3gjgIumUE3m/GQUpnoefKjDs7POAt+
         vLfkOX+x9b+g9nOMWlSQPHZbCsjfLByQ2kcks5dvPMIKnAgC1Dbhfivlz4ZngMWYk+Cs
         KajNfOMfYSb8UsQ+OHgjY7pluzshN2tfqOhIqWI5ohBJ+MNxS6ExFVf5Jb3k7KMWD9x9
         a4Kse1naYHheuCtvrdhkTZp8Z6+vusdVGKMIsWIYkHBb6r1ip1OL7OL8lqp+whvvorZ0
         SC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690471608; x=1691076408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkMGDumQlalY89C6gPCAt+EinCF2NpTD+G/geonEwe8=;
        b=bpPhQef2cdN5QRmmiUN5CUUrNYOVInj33YrQGt4qoe8WHIyH1xwq1KTGN+KqcZoAM6
         MO65Dt48fzZdJ6GDzZsNyZjFEYAOQPujaWzE4yOjJPiMJeEyfUvvD2rPblHAvf6UyvDu
         Zoztx+QfVnOrW5/Unwj35QgnkKEV+leNuRjDfxMAGO2Bxz8P4dXlCevjlDoSWQIwgQ3S
         akX+1kc1oxG+e6nZdtEJj8PKj29tDBNAMZYUK1IM8IPnGv8X/+7GLEfCOkiOKMGxd70B
         qfIUKT/ZL8Bj+kudMbSfwRrH7mhqhOb8pFalDAlybCLgjRMdt8LXaZTR/oFFpJjD3XMS
         PAjA==
X-Gm-Message-State: ABy/qLan1JwPctDSWOdZbWRHYLOOikvzBXDZOW0cbrb6IECnZd6wxx5J
        J1accy5nUuIva9160i3RmsI=
X-Google-Smtp-Source: APBJJlGn3MF6wD2StoFElm1XD+QHKQk5L//InWCg2kgAY070ed7EkqIEA74JK0+10I1+yQoWXJ803A==
X-Received: by 2002:adf:f8ce:0:b0:317:6f08:8371 with SMTP id f14-20020adff8ce000000b003176f088371mr1994540wrq.48.1690471608531;
        Thu, 27 Jul 2023 08:26:48 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id b17-20020adfde11000000b003143765e207sm2350622wrm.49.2023.07.27.08.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:26:48 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Thu, 27 Jul 2023 17:26:38 +0200
Subject: [PATCH 3/6] soc/tegra: pmc: Specify restart mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230727-pca9450-reboot-v1-3-c8edb27bf404@skidata.com>
References: <20230727-pca9450-reboot-v1-0-c8edb27bf404@skidata.com>
In-Reply-To: <20230727-pca9450-reboot-v1-0-c8edb27bf404@skidata.com>
To:     Lee Jones <lee@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Jerome Neanne <jneanne@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

Specify the implemented restart handler as a warm one.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/soc/tegra/pmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 162f52456f65..4f42febb9b0f 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -2962,7 +2962,7 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 	}
 
 	err = devm_register_sys_off_handler(&pdev->dev,
-					    SYS_OFF_MODE_RESTART,
+					    SYS_OFF_MODE_RESTART_WARM,
 					    SYS_OFF_PRIO_LOW,
 					    tegra_pmc_restart_handler, NULL);
 	if (err) {

-- 
2.34.1

