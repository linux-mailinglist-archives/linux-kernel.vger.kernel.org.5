Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5C0788292
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243990AbjHYIoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243965AbjHYIo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:44:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3576426BC;
        Fri, 25 Aug 2023 01:43:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5AF267535;
        Fri, 25 Aug 2023 08:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37FCCC433C9;
        Fri, 25 Aug 2023 08:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692953024;
        bh=X/MOk5kpPYjr9ggDQSqDheWAQJ8w+TztTS+czaBk9c4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=qvgMc/lD8it1d00ARwunt2wDI4+CWYYnBeQSmFUvcjctozV+uMo8yHYIdTW5yufVl
         UD7R+5cD0tut8wpKnsoF7INe/rwY2PCpI139nwFRsmJx1AS2TiegbOhbdNmEORGEMM
         LfGBQwONZ8130HVs2nI8ke35gi4UsYFLSZ+ObQDoxWdihK02c/IG3dI3/7HBEPQtNl
         jKUppMiox/KXZXXzfS9vo8jeNslkIy3qYL2n58qEYHlCNrfF0hjtD40Tv3fOJwb+Pw
         APHyszGzY9HfWd7wXqycTk05Gbxhan7q/tD7ejhvRFkQHPAJuMdYiajAkE+vqzmfwF
         Hk137NyC7VARw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFE4C71133;
        Fri, 25 Aug 2023 08:43:44 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Fri, 25 Aug 2023 11:43:26 +0300
Subject: [PATCH v2 2/2] rtc: m48t86: add DT support for m48t86
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230823-m48t86_device_tree-v2-2-21ff275f949d@maquefel.me>
References: <20230823-m48t86_device_tree-v2-0-21ff275f949d@maquefel.me>
In-Reply-To: <20230823-m48t86_device_tree-v2-0-21ff275f949d@maquefel.me>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692953023; l=1171;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=nNUJapNSivCRonCxS+mxGAyZP1Hfr/cFgMFRykuTeBc=; =?utf-8?q?b=3Dt8EdvTM3pBf/?=
 =?utf-8?q?eWnAA9hjBP05Hqrk+CPRL0vgdXsuo78XhZ19AlHRuzDRrVAvMRCr+GwDExzEXXr0?=
 /IoFvxGMD9jklEZy3uITWLE1Z0wa5EaB7TJTXKj9M+NwrIZkhrQ3
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add OF ID match table.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/lkml/20230601054549.10843-12-nikita.shubin@maquefel.me/
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/rtc/rtc-m48t86.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
index 481c9525b1dd..dd4a62e2d39c 100644
--- a/drivers/rtc/rtc-m48t86.c
+++ b/drivers/rtc/rtc-m48t86.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/rtc.h>
 #include <linux/platform_device.h>
 #include <linux/bcd.h>
@@ -269,9 +270,16 @@ static int m48t86_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id m48t86_rtc_of_ids[] = {
+	{ .compatible = "st,m48t86" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, m48t86_rtc_of_ids);
+
 static struct platform_driver m48t86_rtc_platform_driver = {
 	.driver		= {
 		.name	= "rtc-m48t86",
+		.of_match_table = m48t86_rtc_of_ids,
 	},
 	.probe		= m48t86_rtc_probe,
 };

-- 
2.39.2

