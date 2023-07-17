Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5F575702B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjGQXBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjGQXBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:01:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C829198E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:00:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F97B612FC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA47C433C7;
        Mon, 17 Jul 2023 23:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689634835;
        bh=CFFXnlcMnxDOwZL3PJd+Nxs8WtSk2h/WV1vcVF+ZnZg=;
        h=From:To:Cc:Subject:Date:From;
        b=lVAJD3f1LvxkmYXcpjPxep1E4Zb3MLt0UcLZnNwo/9yv0GM6Ly9A53z9I8e0p+aCl
         aIzCLQQyGu1dZedB8uztpYnqHEBNQcjTzU/r6fTGAijrYqgVx0d+2dtw67OfMFXAZV
         hHPocx+WGAV1vl7pItGF5B3McyvYgcnDSXm7ULobP/VCMd3CSQti9bTKPGY/gGPhXB
         qQjtKPssPE2xkRZXc9CPYAxE/D7wbRUM+lvRX0VH9HLPAAMahMC4/9kg0yLqM5ngA3
         dJcLzDEBpEtnMqGKGa3ch/S18tgHbsjRI6gegHNhHCg4xKBkfILzVuXKLYp4n3Ld/c
         rMQgmDUPNlT5Q==
Received: (nullmailer pid 3213962 invoked by uid 1000);
        Mon, 17 Jul 2023 22:56:07 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: keystone: Drop unused includes
Date:   Mon, 17 Jul 2023 16:56:04 -0600
Message-Id: <20230717225604.3213832-1-robh@kernel.org>
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

of_platform.h include is not needed, so drop it. It implicitly includes
of.h (for now) which is needed.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-davinci/pdata-quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/pdata-quirks.c b/arch/arm/mach-davinci/pdata-quirks.c
index b8b5f1a5e092..b5b5c7bda61e 100644
--- a/arch/arm/mach-davinci/pdata-quirks.c
+++ b/arch/arm/mach-davinci/pdata-quirks.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2016 BayLibre, Inc
  */
 #include <linux/kernel.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 
 #include <media/i2c/tvp514x.h>
 #include <media/i2c/adv7343.h>
-- 
2.40.1

