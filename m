Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A1975702A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjGQXBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjGQXBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:01:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51EF1BC8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:00:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A38E561306
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A368EC433C8;
        Mon, 17 Jul 2023 23:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689634843;
        bh=Ay5ljBkwVc2fqKDgl+j5GKtS+R/gvbLAjPMhqjMBKEc=;
        h=From:To:Cc:Subject:Date:From;
        b=VHjk3NjK36dq3DNJPCkBfj43Ys/rE2WlKYBvjKf8fa0QOp1hE20UXlhLI75LR7tGS
         86cI0t4/6MyDiSdUB7iIwF2tBJplL82mkCJM3yJof1+M1jbAT9k/ANBlHCyIpc/ok5
         1TS3BcC9B/EsEVKYau6MAHDNLGwKbVQP1UXU1J9/WZqzkHL+8AdB+JlIpCZS+F3mr8
         qiybUWbo8lCSYxeiJdkPa70TxrQOiCZfaRAz5W6t3tLG4xT6l9Jr2gCczmxmx23yHW
         Qc0m7zo1rFqPCEOhYdd8Om3OS2ghHcWaydQPwr3PZ0vVruferVeivAn+y0+/iQ9l47
         peBbZJmyU8QsA==
Received: (nullmailer pid 3213463 invoked by uid 1000);
        Mon, 17 Jul 2023 22:55:49 -0000
From:   Rob Herring <robh@kernel.org>
To:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: npcm: Drop unused includes
Date:   Mon, 17 Jul 2023 16:55:45 -0600
Message-Id: <20230717225545.3213329-1-robh@kernel.org>
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

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-npcm/platsmp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-npcm/platsmp.c b/arch/arm/mach-npcm/platsmp.c
index 21633c70fe7f..41891d3aa124 100644
--- a/arch/arm/mach-npcm/platsmp.c
+++ b/arch/arm/mach-npcm/platsmp.c
@@ -5,12 +5,9 @@
 #define pr_fmt(fmt) "nuvoton,npcm7xx-smp: " fmt
 
 #include <linux/delay.h>
-#include <linux/device.h>
 #include <linux/smp.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
 #include <linux/of_address.h>
 #include <asm/cacheflush.h>
 #include <asm/smp.h>
-- 
2.40.1

