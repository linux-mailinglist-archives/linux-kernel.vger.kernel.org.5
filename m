Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26742779B79
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237272AbjHKXkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbjHKXkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:40:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570A010FE;
        Fri, 11 Aug 2023 16:40:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3BB6637A7;
        Fri, 11 Aug 2023 23:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F7DC433C7;
        Fri, 11 Aug 2023 23:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691797217;
        bh=aV2LJbtr8NPZCiOq8BIk41FJhgohqOqu0LS4nEr0uvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pPzegMV35VO8/6lfUmFitMOeXOXQlxTtJSYEEEUs072M5HMy7ZlwLp+ThLKXkM58a
         ZGwSmrWv5ryjCypWVw29kdV33ksGUtDQ2bPaH3VSdPYvmlAc+IAD8ozkMlwk6GjoxU
         Ie6GqQikR28FN8jX1n36DowvVmlDveyVvFvurZlFoVQwuzaFvNIvQPfjMjze8ybKvS
         XNoAkJLRi0BEmbslbouybFecovD3DeD9DER5yxvPH6itnDFYKelihtkhaeOqmT4zy5
         40kR0UupcJuKAiShCB9kglBcHpJoTz7/NeHFGH3rKdmZsGIj3S6sQ5xWP9R6Gw5wUi
         9yVsqFceY6sBQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-integrity@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] tpm_tis: Opt-in interrupts
Date:   Sat, 12 Aug 2023 02:40:02 +0300
Message-Id: <20230811234002.2656180-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230811234002.2656180-1-jarkko@kernel.org>
References: <20230811234002.2656180-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: stable@vger.kernel.org # v6.4+
Link: https://lore.kernel.org/linux-integrity/CAHk-=whRVp4h8uWOX1YO+Y99+44u4s=XxMK4v00B6F1mOfqPLg@mail.gmail.com/
Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm_tis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 3c0f68b9e44f..7fa3d91042b2 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -89,7 +89,7 @@ static inline void tpm_tis_iowrite32(u32 b, void __iomem *iobase, u32 addr)
 	tpm_tis_flush(iobase);
 }
 
-static int interrupts = -1;
+static int interrupts;
 module_param(interrupts, int, 0444);
 MODULE_PARM_DESC(interrupts, "Enable interrupts");
 
-- 
2.39.2

