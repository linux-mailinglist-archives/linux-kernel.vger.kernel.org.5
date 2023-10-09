Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A007BEC95
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378659AbjJIVPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378747AbjJIVPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:15:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8061AD48
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:14:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0770C433C9;
        Mon,  9 Oct 2023 21:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696886078;
        bh=Xpx2wND1dP8kwl4XLDHrf+J72l89Jo1/DmvaVFMsN5E=;
        h=From:To:Cc:Subject:Date:From;
        b=CwgWaQj41Xgjp5Mabg+jK4oHXXb0Z0rZeD5Bu+l1pHm9Pf1X2Wnz/FSJTmfRwcqo1
         6983OL46CLXGOh5uj0mkDHINE7bJeQhe8ILvoiigoHtQMrBslKtXz6/ftBovCFMOyE
         iLiZCxutDaD3giIvCYLvtrYFMzFyidCZbAMLhNzhGh4MXXjRnj2xEdjECmnO3bxEeE
         Rb5WFg6jOekJNEG14WxpcMqMUm7mKctFe53rSr2emDSxoWIZKDYRGv7xw3KBhuz02v
         u4hu3KRnucZ3ts4rYcEzM5+Fz3n+mn52Oy/ZvnyHpauTa4CHchewEFTWL11hls/hMa
         p7z2tH2UXgq8A==
Received: (nullmailer pid 3246550 invoked by uid 1000);
        Mon, 09 Oct 2023 21:14:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: musb: Add missing of.h include
Date:   Mon,  9 Oct 2023 16:13:47 -0500
Message-ID: <20231009211356.3242037-17-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree.

Add of.h which is implicitly included by of_platform.h.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/usb/musb/da8xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index 912e32b78ac6..8abf3a567e30 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -17,6 +17,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
-- 
2.42.0

