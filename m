Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC47575701A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 00:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjGQW7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 18:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjGQW7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 18:59:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E338610E6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:58:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34A15611E4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 22:58:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C50C433C7;
        Mon, 17 Jul 2023 22:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689634731;
        bh=0WDNgjhlcmVeTLKaQ94sg9uSk5NYPDOERFptFyvXPVA=;
        h=From:To:Cc:Subject:Date:From;
        b=TydzA7tsI77yqI5P/cSCWlAet7n4DO4HlWOA7aWaDRzLphlqbmCzyANVQ8A3gFco3
         bb/yfGz08SrFMumeuriJefYe5mIcUhhlkn7oCdton/IBgWHsTxb49Xpc4nhUchLkZ0
         dHQ6vlfGZxoFD//EAiwR6WDfuv8alUZNzEdnE1KZMpbNWh7kXf/E0gcnpFO0v5OstV
         KIoakP8ovSiwMEIf9a1amonVIhlQ+DB1XMTFff6mQtje/eFy/6Lvtb3qXrxf4n5x6j
         jCZKtQ4IW8JNWfjEfpddlcrfHRYYmsbsS3iaCLaqFx+B3tFQwXmt7+abYh6jksuHMn
         uy1AkfbNHhArA==
Received: (nullmailer pid 3213133 invoked by uid 1000);
        Mon, 17 Jul 2023 22:55:37 -0000
From:   Rob Herring <robh@kernel.org>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: pxa: Drop unused includes
Date:   Mon, 17 Jul 2023 16:55:34 -0600
Message-Id: <20230717225534.3213044-1-robh@kernel.org>
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
 arch/arm/mach-pxa/pxa-dt.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa-dt.c b/arch/arm/mach-pxa/pxa-dt.c
index 5e5d543fdf46..a292de91dce5 100644
--- a/arch/arm/mach-pxa/pxa-dt.c
+++ b/arch/arm/mach-pxa/pxa-dt.c
@@ -5,13 +5,7 @@
  *  Copyright (C) 2012 Daniel Mack
  */
 
-#include <linux/irq.h>
-#include <linux/irqdomain.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/time.h>
-#include "irqs.h"
 
 #include "generic.h"
 
-- 
2.40.1

