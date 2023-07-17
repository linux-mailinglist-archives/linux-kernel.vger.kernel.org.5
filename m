Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A28757027
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjGQXAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjGQXAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:00:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6D21993;
        Mon, 17 Jul 2023 16:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C902961313;
        Mon, 17 Jul 2023 23:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A22C433C8;
        Mon, 17 Jul 2023 23:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689634821;
        bh=cAiM9eQnv239SGvg9ZpCen1OKNqXuT++oKZ6/cQCWjE=;
        h=From:To:Cc:Subject:Date:From;
        b=ILFKQW8yp1MuTQIOKP1M2dSnYuMD0L10m5O5lbFTRkutLhW8dh/UxE8304Gpcp9zX
         2wu42Yq2Nf6kaDUNQLBzj7VzNaQsuIFbnFTqUUTY0FPoW++NuTKhfJ42+ln9B62i6A
         nAJal2nwdg8dCWdVlKXv8ORpFH5bROZ5Tb8mW1PyVQL01JeUAkfyURp1w9JRnnhZJD
         z2ywSEEK1U2Pe/WFDREIz+LqI7j22U3eAwMg5K6CVvQc9xs9hkTnZFrpw/vl9U+jmY
         XqSWX11YiMcCHnNJO9DmvOYM8kxOuWaJoUSkJy6ffuBDz7daUqX8AAW7IXARqJXd1p
         1j4rGrWef84qA==
Received: (nullmailer pid 3214338 invoked by uid 1000);
        Mon, 17 Jul 2023 22:56:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: shmobile: Drop unused includes
Date:   Mon, 17 Jul 2023 16:56:14 -0600
Message-Id: <20230717225614.3214179-1-robh@kernel.org>
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

of_platform.h is not needed, so drop it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 3edbf0719fb3..c38367a10c79 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -16,7 +16,6 @@
 #include <linux/of.h>
 #include <linux/of_clk.h>
 #include <linux/of_fdt.h>
-#include <linux/of_platform.h>
 #include <linux/psci.h>
 #include <asm/mach/arch.h>
 #include <asm/secure_cntvoff.h>
-- 
2.40.1

