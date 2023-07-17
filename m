Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD712757032
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjGQXEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjGQXEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:04:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805D7EE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:03:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AE746131B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C7AC433C8;
        Mon, 17 Jul 2023 23:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689634885;
        bh=/kwANh+mU41sYBL/f/GaQRVCEPcgNtHVKDIA6DCSsZ0=;
        h=From:To:Cc:Subject:Date:From;
        b=rxt7lYKaBGrbPMbfRK8TG1v+/ApFv7RbzKZnykQIiUKGGxmwzuPiHD2S/iWtGfyND
         5thMQSIJjcKqIu18SdTHqibpIKnXGHsFABieXIxDI8h0R0MTeqTMRop0+2R6z80P8e
         SSto36nGI9R3FNR1HKq4tO9CNdqujx1n18ggoH9m68C2zLYGuz/70tamCka46VBx3G
         tyWfQ8w1Z9H9udIx/kHEKbsxAzh75EVKpsmCyynwhIKITUJsFm6fVyClrFoDcVNq+x
         ZdoDMCgLmZeUXc/xbby7sR6b1nHv4P1MnWpm83P3m+mKfF9vxg7yQ/AXwszrYEopFg
         ffMBSPt6TFFEQ==
Received: (nullmailer pid 3215170 invoked by uid 1000);
        Mon, 17 Jul 2023 22:56:51 -0000
From:   Rob Herring <robh@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dove: Drop unused includes
Date:   Mon, 17 Jul 2023 16:56:45 -0600
Message-Id: <20230717225645.3214989-1-robh@kernel.org>
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
 arch/arm/mach-dove/common.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index cd4ae7e4768d..3aea90bbb41a 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -9,8 +9,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/platform_data/dma-mv_xor.h>
 #include <linux/platform_data/usb-ehci-orion.h>
 #include <linux/platform_device.h>
-- 
2.40.1

