Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587ED770F6E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 13:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjHELXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 07:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjHELXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 07:23:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C143468C;
        Sat,  5 Aug 2023 04:23:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D985160CBB;
        Sat,  5 Aug 2023 11:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CD83C433C7;
        Sat,  5 Aug 2023 11:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691234623;
        bh=qtEzDzm2HSlThXBY/D+hEKZQ8unmvVQ0kOBMd51+yZ4=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=pOPnzo+6btPq/Pb3T0rnzxF1TMp0Uuj+y8CFGD+O561+mn46CYkOgrlwjnk+89Ado
         g8ZnBTlvJKEHdVp9kaF2Ru+jcAIlWcCP5LwDyNd3kyXJC+DHuw2NMDtzL3RwSenfpu
         RycFJTNVbt2XVM64IIziQQkIak0uEDRJOtyGlJPb/y+GnbX7XoitfDHlWcmJ8tXZX3
         HIjveo0wUor/w3MGaCYMSXRxUbKYy8HzkkpPDNUr7vI2Mc1350dAL80KNt5gSRoEU1
         NbGnUX9cGJMYTa6QbyhwlaG7bX+U61Q8HUaVn0r51TCsaE+47nGVghwadoCeJ1d5eh
         CBKGG/mUiv7CQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7AAC001DB;
        Sat,  5 Aug 2023 11:23:43 +0000 (UTC)
From:   Xilin Wu via B4 Relay <devnull+wuxilin123.gmail.com@kernel.org>
Date:   Sat, 05 Aug 2023 19:23:35 +0800
Subject: [PATCH] media: rc: ir-spi: Correct regulator name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230805-ir-spi-v1-1-33af4a556139@gmail.com>
X-B4-Tracking: v=1; b=H4sIADYxzmQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCwNT3cwi3eKCTF1jE3PjZNM0IGVmogRUXFCUmpZZATYoOra2FgDzgm5
 UWAAAAA==
To:     Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xilin Wu <wuxilin123@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691234622; l=927;
 i=wuxilin123@gmail.com; s=20230805; h=from:subject:message-id;
 bh=+DkvKMI3r/F0yMEERA2wc0VwRO9F51Sgxxn9bTGF1zY=;
 b=BbC1D3biwOPvuRARvE7eVazY2c5pGzMwarU0ZE2bB7HXUn7mFqo97HHVYSIm9uvGwABB96jB0
 fQXhqbBV//pAH72/mrgujnR0wnvxKgz/IUkxTRTEQcJh2bElZBiXX6U
X-Developer-Key: i=wuxilin123@gmail.com; a=ed25519;
 pk=OZIrHT2qWm7yEdp5fsVR7GsFx1wxciIii20H06Ud088=
X-Endpoint-Received: by B4 Relay for wuxilin123@gmail.com/20230805 with auth_id=73
X-Original-From: Xilin Wu <wuxilin123@gmail.com>
Reply-To: <wuxilin123@gmail.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xilin Wu <wuxilin123@gmail.com>

The driver wrongly assumes regulator is called "irda_regulator"
instead of "power".

Change it to "power" to match device tree binding.

Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
---
 drivers/media/rc/ir-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/rc/ir-spi.c b/drivers/media/rc/ir-spi.c
index bbc81bed4f90..a447bb36100d 100644
--- a/drivers/media/rc/ir-spi.c
+++ b/drivers/media/rc/ir-spi.c
@@ -119,7 +119,7 @@ static int ir_spi_probe(struct spi_device *spi)
 	if (!idata)
 		return -ENOMEM;
 
-	idata->regulator = devm_regulator_get(&spi->dev, "irda_regulator");
+	idata->regulator = devm_regulator_get(&spi->dev, "power");
 	if (IS_ERR(idata->regulator))
 		return PTR_ERR(idata->regulator);
 

---
base-commit: 024ff300db33968c133435a146d51ac22db27374
change-id: 20230805-ir-spi-3473c5f34764

Best regards,
-- 
Xilin Wu <wuxilin123@gmail.com>

