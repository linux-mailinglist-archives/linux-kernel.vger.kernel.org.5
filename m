Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4287757045
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjGQXLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjGQXLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:11:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3CA19A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B142261306
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF52C433C9;
        Mon, 17 Jul 2023 23:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689634906;
        bh=+jSyd4yYPFkn4CTeff0qyBq7GE2/s+SbphVWham7jkU=;
        h=From:To:Cc:Subject:Date:From;
        b=INF1QTWD3eFEnfRQ6Y2ri9rU6HDyxXVgWBPDW3PEX8BoQy+N1DdK1GgdkiRBwu26k
         vEQoYs+N7WyYymyxPFh1ULrvYgzinTnkyWL8olH8F5LHXzuMcNlVFOH7xYlVMHmtab
         0TurY6Fuhh0k4BfbkS2R75UEke+TQ5Wq4R6cv2vHjo5vaQdHrQ6RTghxm5uMqmfv5F
         8agYltOBGuiMDsQCSdKVia5AJF+HwETfuwrJjPPG3hCg9EvhQMzsNKCiEMUPVtTgCX
         SgMfEDtLV8FvhEjX/kPX2d63u3+BuXl8TS10zeT8uSaVD4WHkGJv8n/52kngWgEA8j
         tszfOAKXqKnDg==
Received: (nullmailer pid 3214750 invoked by uid 1000);
        Mon, 17 Jul 2023 22:56:36 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jean-Marie Verdun <verdun@hpe.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: hpe: Drop unused includes
Date:   Mon, 17 Jul 2023 16:56:30 -0600
Message-Id: <20230717225630.3214590-1-robh@kernel.org>
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
 arch/arm/mach-hpe/gxp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-hpe/gxp.c b/arch/arm/mach-hpe/gxp.c
index ef3341373006..581c8da517b8 100644
--- a/arch/arm/mach-hpe/gxp.c
+++ b/arch/arm/mach-hpe/gxp.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P. */
 
-#include <linux/of_platform.h>
 #include <asm/mach/arch.h>
 
 static const char * const gxp_board_dt_compat[] = {
-- 
2.40.1

