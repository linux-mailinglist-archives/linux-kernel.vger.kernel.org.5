Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F90175C23B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjGUI5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjGUI4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:56:50 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2032D76;
        Fri, 21 Jul 2023 01:56:50 -0700 (PDT)
Received: from [185.206.209.215] (helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qMlwO-0001Cf-Lw; Fri, 21 Jul 2023 10:56:48 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/2] hwrng: cn10k - delete empty remove function
Date:   Fri, 21 Jul 2023 10:54:43 +0200
Message-Id: <20230721085444.496863-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230721085444.496863-1-martin@kaiser.cx>
References: <20230721085444.496863-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The remove function is empty, we can delete it. It's ok for a PCI driver
to have no remove function.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/cn10k-rng.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/char/hw_random/cn10k-rng.c b/drivers/char/hw_random/cn10k-rng.c
index 0cd7e1a8e499..794ec77feb2c 100644
--- a/drivers/char/hw_random/cn10k-rng.c
+++ b/drivers/char/hw_random/cn10k-rng.c
@@ -213,11 +213,6 @@ static int cn10k_rng_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 }
 
-static void cn10k_rng_remove(struct pci_dev *pdev)
-{
-	/* Nothing to do */
-}
-
 static const struct pci_device_id cn10k_rng_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, 0xA098) }, /* RNG PF */
 	{0,},
@@ -229,7 +224,6 @@ static struct pci_driver cn10k_rng_driver = {
 	.name		= "cn10k_rng",
 	.id_table	= cn10k_rng_id_table,
 	.probe		= cn10k_rng_probe,
-	.remove		= cn10k_rng_remove,
 };
 
 module_pci_driver(cn10k_rng_driver);
-- 
2.30.2

