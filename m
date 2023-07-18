Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A576758684
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 23:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjGRVIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 17:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGRVIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 17:08:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854A2C0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:08:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EB6260B99
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 21:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C64C433C8;
        Tue, 18 Jul 2023 21:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689714531;
        bh=bS7sodMc9U6EXdQCKR4HDZSfu4d01HD5iH1k9Z5qlcY=;
        h=From:To:Cc:Subject:Date:From;
        b=nsHL/dP4LHKtzehJzgJX8IurW+ZE6pJP/dOu/kmoquz5x7Wrp/IYh7f6+GwCQQ5RW
         ZW05GNW0AzhRY0R0mmEgXYr+5lqn2yyAPtj2rLBIby63NhJkuvuN5HearsLP+n4FeO
         is1NRMdCLpHein7mJP4khiqnTbjS4q/JT1+ZrF76ih4oCe2bamSo4MhAeLJtPSjO9c
         ZbSpVeOPuQVJCRXhyfo+zXRoCfJYV9N7FAHgoUJAavzkFFpoNMXakEcd2dxpBY/umZ
         dEZgusadIVuP6cDDoHn0S3w+wzLv0CzB/G0qgdhO8AdJc7gzT04jft7MHiCZFi9KWj
         fBLU0D7gZWWWg==
Received: (nullmailer pid 1826560 invoked by uid 1000);
        Tue, 18 Jul 2023 21:08:50 -0000
From:   Rob Herring <robh@kernel.org>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: l2x0: Add explicit includes for init and types
Date:   Tue, 18 Jul 2023 15:08:38 -0600
Message-Id: <20230718210839.1824792-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cache-l2x0.h header uses u32 type and the __init and __iomem
attributes, so it should have explicit includes for those.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/include/asm/hardware/cache-l2x0.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index a6d4ee86ba54..5a7ee70f561c 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -9,6 +9,8 @@
 #define __ASM_ARM_HARDWARE_L2X0_H
 
 #include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/types.h>
 
 #define L2X0_CACHE_ID			0x000
 #define L2X0_CACHE_TYPE			0x004
-- 
2.40.1

