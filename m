Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFF175702C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjGQXCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjGQXCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:02:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E3019BB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:01:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D56926130A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C46BC433C8;
        Mon, 17 Jul 2023 23:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689634850;
        bh=RvoTzpwKhA1M1r5/nGYeh/awWwbP1a2wP04gRbhYb7s=;
        h=From:To:Cc:Subject:Date:From;
        b=f/rIQIYS+Wloa7zQlCa4eTNhkFeBRKjpzsJmQo2tdNl3CvuGIP9cFOvFsZSzoLgNe
         JAql1+hhhaa6EL8JrVyWHvRAgcXVT2oFefE0hNipW9MRWWYVCPZitZmJqWhLfYqAra
         RablUZPSlfvNI6YxL0wrD9J4qnSCYHtVt5PZz5RY2R8Ve71P4PuX4cOwvitxeKNn08
         KgYurGveoWqtA2zRF1I0y+4wVhJKeB/uaB5E6x7sPm+q6MlBrt/Ps0rgcLRnCjY+Q0
         0XHzCRvoQMqyGm2FYyxZbtubQ6f/azabD+uULKSDNa3k3PPmI7y3+Lglp9u46la/AH
         cVkZ4W2PAQ5Qw==
Received: (nullmailer pid 3215911 invoked by uid 1000);
        Mon, 17 Jul 2023 22:57:20 -0000
From:   Rob Herring <robh@kernel.org>
To:     Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <atenart@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: alpine: Drop unused includes
Date:   Mon, 17 Jul 2023 16:57:11 -0600
Message-Id: <20230717225712.3215695-1-robh@kernel.org>
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

of_platform.h is not needed, drop it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-alpine/alpine_machine.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-alpine/alpine_machine.c b/arch/arm/mach-alpine/alpine_machine.c
index d256a99e9b99..bc491bbbabf8 100644
--- a/arch/arm/mach-alpine/alpine_machine.c
+++ b/arch/arm/mach-alpine/alpine_machine.c
@@ -5,8 +5,6 @@
  * Copyright (C) 2015 Annapurna Labs Ltd.
  */
 
-#include <linux/of_platform.h>
-
 #include <asm/mach/arch.h>
 
 static const char * const al_match[] __initconst = {
-- 
2.40.1

