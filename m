Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102E1757020
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjGQXAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjGQXAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:00:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABF71707
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:59:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8905061305
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 22:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590B3C433C7;
        Mon, 17 Jul 2023 22:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689634774;
        bh=enN5F2+0Je/0v6QMpoi/1qi66psAbjn2StPITSeJgBc=;
        h=From:To:Cc:Subject:Date:From;
        b=moozdmoa3scQHo00xU4ljARmocTwJJQoK+w9IiQPvov1X3YWaAaJ+cX/s1sopljXO
         fwwDPLkNUDFzt9/0d+u84j+j03jJVWjf6BRyJoiXwo7s/RgvpJeXjxwVRB+1pNrzMV
         fIOb55meeS0BQnUi4BxeOH+9L7JOaNZue7j3kW5j7ytqyoTFayKodFdhn5HwsGSYBA
         mmd61rEzfsUU2CVH0pESz4MfGVD8pNjZAr9dri/E/mZx2LmaNbpMz9yHfEaa3pEGs6
         xwecH9u4/RvzsmvTLJj+T9vKyXz7Mgt+/YgRj2YW9uayuE7tcjckAn9CyCStX5fTHQ
         ZE9xumLQH3QvA==
Received: (nullmailer pid 3214522 invoked by uid 1000);
        Mon, 17 Jul 2023 22:56:28 -0000
From:   Rob Herring <robh@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: meson: Drop unused includes
Date:   Mon, 17 Jul 2023 16:56:23 -0600
Message-Id: <20230717225623.3214384-1-robh@kernel.org>
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

of_platform.h is not needed, so drop it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-meson/meson.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-meson/meson.c b/arch/arm/mach-meson/meson.c
index de56e707c7aa..d3ae89dd84bb 100644
--- a/arch/arm/mach-meson/meson.c
+++ b/arch/arm/mach-meson/meson.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2014 Carlo Caione <carlo@caione.org>
  */
 
-#include <linux/of_platform.h>
 #include <asm/mach/arch.h>
 
 static const char * const meson_common_board_compat[] = {
-- 
2.40.1

