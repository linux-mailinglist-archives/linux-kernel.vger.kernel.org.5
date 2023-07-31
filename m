Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A621B76964A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjGaM10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjGaM1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:27:25 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245611724;
        Mon, 31 Jul 2023 05:26:47 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-522bc9556f5so2457044a12.0;
        Mon, 31 Jul 2023 05:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690806382; x=1691411182;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwhaajtiWbAK0+aLK2xFSMs0ohtyw35IKQkHVzwXE8Q=;
        b=AnYWCg8THtmqrYKDgEWhGEj4akQmYhihbNAeSRam1/TdCJuZIrOA33P7Jf2F6GrsGQ
         RNhF3NbcUuAV+mw5z72qcIr9tMx3Msi9enDZV8ESejhjQj586qF2OSf7kqXZrICPgiL5
         hqOcCW/2NFdJNEVjq5Md1ZSlD2lOwgWEpusqqK+JfSQ3PmVwvlJEBorqjIgsDXU/6+oV
         b2r247/jzsbfUkJ9WOLDPrka179JjM+r/to86iaD5+QOHYFN8jEVPVyBEa5sZbijb01f
         XaJ+7ECaj24RGDvssOn8xZoGYJtn4swg7ArddeIlj8dhjKhoX1vNM+TBfJTpNMErWGE9
         w33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690806382; x=1691411182;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwhaajtiWbAK0+aLK2xFSMs0ohtyw35IKQkHVzwXE8Q=;
        b=ZbBbhWBO56wHg4pr7Gu3+qZMZ2JUgz1LFJMN2hacoKc/BRUYTU9EmzlymbK4Ao28q8
         GUiJz8UhpslS+Ooh1KkBSueYo6Fava9iMdRXfuk7dGKBFvmHWiUiKlHMDITPTZWa8jJA
         UsbZm8/Fm7rIpkUL8DiSJjelOftereoJEUhj6HTqvLWAUkxIQHWZ5q7dOhCCZ/QPLqGa
         4O3VmA7rf6lkO2xVaEYXUTmvZM5JQOI4EWBQeBA7P+8hS3lo0CAeMGuHy2sksNVczJCz
         /7rRbhXwH2o0SlkbetTo56AJqoVHAwmbc3QCPRt3bCS9gy4VYyiboGSBF6brUi3LtgHo
         dKXQ==
X-Gm-Message-State: ABy/qLaSFcVrPv/mNh3+Pan9HVonE2mvD0ftEVYMAoBIpBxYwjS2ic6M
        DBYV249d/ucUr9Axtmjo8Mg=
X-Google-Smtp-Source: APBJJlFqh6O8ZhZZrVhxyzkGtfKV31CkB3xqadtfge9pqNyKNfX9Qj6+rE7GluS3HH43H8S7tBjmPA==
X-Received: by 2002:aa7:dbd8:0:b0:522:3b6e:5f6a with SMTP id v24-20020aa7dbd8000000b005223b6e5f6amr8992130edt.29.1690806382404;
        Mon, 31 Jul 2023 05:26:22 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:c9d4:a174:b52d:4c33])
        by smtp.gmail.com with ESMTPSA id y19-20020aa7ccd3000000b0051d9ee1c9d3sm5359982edt.84.2023.07.31.05.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 05:26:22 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Walker Chen <walker.chen@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust file entry in STARFIVE JH71XX PMU CONTROLLER DRIVER
Date:   Mon, 31 Jul 2023 14:26:11 +0200
Message-Id: <20230731122611.4309-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f3fb16291f48 ("soc: starfive: Move the power-domain driver to the
genpd dir") moves:

  drivers/{soc/starfive/jh71xx_pmu.c => genpd/starfive/jh71xx-pmu.c}

However, the update to the file entry in MAINTAINERS only addresses the
move in directories, but misses the renaming from jh71xx_pmu.c to
jh71xx-pmu.c. Hence, ./scripts/get_maintainer.pl --self-test=patterns
complains about a broken reference.

Adjust the file entry in STARFIVE JH71XX PMU CONTROLLER DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 003b0461641a..7a20d6ab1d18 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20408,7 +20408,7 @@ M:	Walker Chen <walker.chen@starfivetech.com>
 M:	Changhuang Liang <changhuang.liang@starfivetech.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/power/starfive*
-F:	drivers/genpd/starfive/jh71xx_pmu.c
+F:	drivers/genpd/starfive/jh71xx-pmu.c
 F:	include/dt-bindings/power/starfive,jh7110-pmu.h
 
 STARFIVE SOC DRIVERS
-- 
2.17.1

