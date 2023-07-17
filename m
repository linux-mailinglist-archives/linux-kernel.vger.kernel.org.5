Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B81C75703D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjGQXHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGQXHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:07:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9035C191
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:06:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DADCB61305
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD47C433C7;
        Mon, 17 Jul 2023 23:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689634828;
        bh=98oD7vY/oHZpJ/7V3Rd83QDhlLAe4d9cuz/9n2FHVmA=;
        h=From:To:Cc:Subject:Date:From;
        b=hc/ILFfhTQKQJ6Z6auh2y18dwMoVvOHwrYqgIPwd4Tq3dpZi7Eljw7Ap9K7D8ZWsU
         jEM5IWIPt/cRtAE4RdbKe066lIG2I9POCHeut9eDSLqdCks14h+Fsyhr7vVImq5bDB
         UjyuB4jftlnmADgDjsW0MmVg8YmKiia2XjLxYmhDdkf0oI2EKXMgCvCU4ulRt7BruR
         5gB7dPybBbHpKc9zsKRvzkcoKOc+NvlTdxsjP4FmAq6opGQYB4DNjToA3XHdApLWu+
         3btSiH8yHvqanY1BUNAcA8QPe9U1ctc54vBBV1/XUtfGnDtbwc+/m9nTU/c73AfDRm
         I61hJmnnhqgeg==
Received: (nullmailer pid 3214097 invoked by uid 1000);
        Mon, 17 Jul 2023 22:56:12 -0000
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: keystone: Drop unused includes
Date:   Mon, 17 Jul 2023 16:56:09 -0600
Message-Id: <20230717225610.3214029-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
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

Several includes are not needed, so drop them.

of_platform.h is not needed, but it implicitly includes platform_device.h
(for now) which is needed.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-keystone/keystone.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index 68039aad3014..e0ca26182e0b 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -7,12 +7,10 @@
  *	Santosh Shilimkar <santosh.shillimkar@ti.com>
  */
 #include <linux/io.h>
-#include <linux/of.h>
 #include <linux/dma-map-ops.h>
 #include <linux/init.h>
-#include <linux/of_platform.h>
-#include <linux/of_address.h>
 #include <linux/memblock.h>
+#include <linux/platform_device.h>
 
 #include <asm/setup.h>
 #include <asm/mach/map.h>
-- 
2.40.1

