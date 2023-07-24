Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998EA75E88C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjGXBmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjGXBlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:41:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B3949F6;
        Sun, 23 Jul 2023 18:36:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 767AD60F4D;
        Mon, 24 Jul 2023 01:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203BDC433CC;
        Mon, 24 Jul 2023 01:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162382;
        bh=/lMwOp/a1X9GwFsBiE54ajNyp1XZhnGLosgfOspcy28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eOJpAEFhSTz8CawKiV5t1rAKFhHqbjKzBpVSeEESV3h8CHEl9dfmgOoWCK/PTwxrt
         yfxjJdjAYWqFUmnlf+4GKNC0O7Ek6VNJ42IX9pTeg5cS9pJcY+C+TLzArZkMVtNcSK
         Ytp/oOjrFlN2u0ap2W/wRNd5jI9Cz/XIsPE+48szlPoXP87B32PAQ5pSby32t4y7jZ
         LwC5ae786zBrCuLShsc74X00RdE5/r7xvBJBvYoYK2IrDBksqf1ggv1xvs/8C4S357
         +XMFfSBEo/2mgfyMcOP45c7YsvS80LSjTjX322HZXfPypQFFqtpopSRTWCpyYPR8rE
         0HCTbRZXVVtQg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yuechao Zhao <yuechao.zhao@advantech.com.cn>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>, wim@iguana.be,
        linux-watchdog@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 18/34] watchdog: sp5100_tco: support Hygon FCH/SCH (Server Controller Hub)
Date:   Sun, 23 Jul 2023 21:32:21 -0400
Message-Id: <20230724013238.2329166-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013238.2329166-1-sashal@kernel.org>
References: <20230724013238.2329166-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuechao Zhao <yuechao.zhao@advantech.com.cn>

[ Upstream commit 009637de1f65cff452ad49554d1e8ef9fda99e43 ]

Add PCI_VENDOR_ID_HYGON(Hygon vendor id [0x1d94]) in this driver

Signed-off-by: Yuechao Zhao <yuechao.zhao@advantech.com.cn>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lkml.kernel.org/r/20230612031907.796461-1-a345351830@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/sp5100_tco.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index 14f8d8d90920f..2bd3dc25cb030 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -96,7 +96,7 @@ static enum tco_reg_layout tco_reg_layout(struct pci_dev *dev)
 	    sp5100_tco_pci->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS &&
 	    sp5100_tco_pci->revision >= AMD_ZEN_SMBUS_PCI_REV) {
 		return efch_mmio;
-	} else if (dev->vendor == PCI_VENDOR_ID_AMD &&
+	} else if ((dev->vendor == PCI_VENDOR_ID_AMD || dev->vendor == PCI_VENDOR_ID_HYGON) &&
 	    ((dev->device == PCI_DEVICE_ID_AMD_HUDSON2_SMBUS &&
 	     dev->revision >= 0x41) ||
 	    (dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS &&
@@ -579,6 +579,8 @@ static const struct pci_device_id sp5100_tco_pci_tbl[] = {
 	  PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, PCI_ANY_ID,
 	  PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, PCI_ANY_ID,
+	  PCI_ANY_ID, },
 	{ 0, },			/* End of list */
 };
 MODULE_DEVICE_TABLE(pci, sp5100_tco_pci_tbl);
-- 
2.39.2

