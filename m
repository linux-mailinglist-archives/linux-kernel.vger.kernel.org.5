Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480E3757031
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjGQXDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjGQXDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:03:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A5210EF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:03:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B4C0612FE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E71C433C8;
        Mon, 17 Jul 2023 23:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689634897;
        bh=jzraEfolWN7cZy0bqIDhu0q8SbBl93cBmNxqGKhh5vE=;
        h=From:To:Cc:Subject:Date:From;
        b=T+TV6LBtUHYFVo0bcN6sYxWMhwkkZaclr6ngV3Cm+T7GZa85ItqM1GW+HrO7byzwG
         CRubkLrpOTOWCHsoHjqVYjARL0PUgf1kjcnyIJqxx0RO2VV95w/kEQCTSs7hmjIsu2
         Qz7fczsNO+xKHZF8YxT1FyxA97thXwnuS+NBikUH1PTAUOf7jQmyuoBUetENE2u8mG
         gFUz8WZ2wvk7G7FWuBMBw6z7iEM3LC0xmq769XVoB8JGViUfqf7q+1gk8hnWCyVKmT
         zHuOO/Wv46F1FKoy+eCZGMwl7H5xLWVS1vit0vYyW/78vVnuENki6bl62MmrQHh8ht
         YXUhEMO2yTrsQ==
Received: (nullmailer pid 3215382 invoked by uid 1000);
        Mon, 17 Jul 2023 22:57:00 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: berlin: Drop unused includes
Date:   Mon, 17 Jul 2023 16:56:54 -0600
Message-Id: <20230717225654.3215215-1-robh@kernel.org>
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

Several includes are not needed, so drop them.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-berlin/berlin.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-berlin/berlin.c b/arch/arm/mach-berlin/berlin.c
index 2424ad40190c..13d5c899f09e 100644
--- a/arch/arm/mach-berlin/berlin.c
+++ b/arch/arm/mach-berlin/berlin.c
@@ -8,11 +8,6 @@
  *  (c) Marvell International Ltd.
  */
 
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/of_platform.h>
-#include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 
 static const char * const berlin_dt_compat[] = {
-- 
2.40.1

