Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB6375701D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjGQW7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 18:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjGQW7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 18:59:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE261720
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:59:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61807612E4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 22:59:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78903C433C8;
        Mon, 17 Jul 2023 22:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689634739;
        bh=OHKw50Mnp6IqIoBaVgWlwfdcRU1mihMlftF0z/AodrQ=;
        h=From:To:Cc:Subject:Date:From;
        b=c56q138oKEMrQlOxMZJsyx+7zXfhMZsBBnY7YA/pInpXIXKi0jmtiLqvmyaD3ZcY/
         nMWCQiV0NvyeNls8TDujhTd5bu+5+34r3cHOLNodm1uRpuumMAwPoIWH5e61GifdHq
         gH9M6d4+0DoMHRqo4i9h7NnqJMvg78kz4iBprMhZcoGKK/8oVxIJFfttlbDWBKwXYz
         OLnyikNySserkrLNjNecU/DsP+8yvfUqd4L1XAn2CUFn0I26Y9fg+O5vFxAauuyCn1
         2vNOP7jSYa0WefP9H4cUfQYapIvF0A0LHSTY5S5Jt/CtOXFN2urXlwybj7eLw9Yz+5
         XlkjkSeSdPlfA==
Received: (nullmailer pid 3213747 invoked by uid 1000);
        Mon, 17 Jul 2023 22:56:00 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: mmp: Drop unused includes
Date:   Mon, 17 Jul 2023 16:55:57 -0600
Message-Id: <20230717225557.3213671-1-robh@kernel.org>
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
 arch/arm/mach-mmp/mmp-dt.c  | 3 ---
 arch/arm/mach-mmp/mmp2-dt.c | 4 ----
 arch/arm/mach-mmp/mmp3.c    | 4 ----
 3 files changed, 11 deletions(-)

diff --git a/arch/arm/mach-mmp/mmp-dt.c b/arch/arm/mach-mmp/mmp-dt.c
index 3f43c0867dca..8479996a8f2e 100644
--- a/arch/arm/mach-mmp/mmp-dt.c
+++ b/arch/arm/mach-mmp/mmp-dt.c
@@ -6,12 +6,9 @@
  *  Author: Haojian Zhuang <haojian.zhuang@marvell.com>
  */
 
-#include <linux/irqchip.h>
-#include <linux/of_platform.h>
 #include <linux/of_clk.h>
 #include <linux/clocksource.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/time.h>
 #include <asm/hardware/cache-tauros2.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-mmp/mmp2-dt.c b/arch/arm/mach-mmp/mmp2-dt.c
index 34a5fe4b3949..e5ddc327651b 100644
--- a/arch/arm/mach-mmp/mmp2-dt.c
+++ b/arch/arm/mach-mmp/mmp2-dt.c
@@ -6,13 +6,9 @@
  *  Author: Haojian Zhuang <haojian.zhuang@marvell.com>
  */
 
-#include <linux/io.h>
-#include <linux/irqchip.h>
-#include <linux/of_platform.h>
 #include <linux/of_clk.h>
 #include <linux/clocksource.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/time.h>
 #include <asm/hardware/cache-tauros2.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-mmp/mmp3.c b/arch/arm/mach-mmp/mmp3.c
index b0e86964f302..073a4ee219cb 100644
--- a/arch/arm/mach-mmp/mmp3.c
+++ b/arch/arm/mach-mmp/mmp3.c
@@ -5,10 +5,6 @@
  *  Copyright (C) 2019 Lubomir Rintel <lkundrak@v3.sk>
  */
 
-#include <linux/io.h>
-#include <linux/irqchip.h>
-#include <linux/of_platform.h>
-#include <linux/clk-provider.h>
 #include <asm/mach/arch.h>
 #include <asm/hardware/cache-l2x0.h>
 
-- 
2.40.1

