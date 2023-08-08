Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37DF774E65
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 00:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjHHWe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 18:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjHHWev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 18:34:51 -0400
Received: from out-122.mta1.migadu.com (out-122.mta1.migadu.com [IPv6:2001:41d0:203:375::7a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A9F1BCD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 15:34:43 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691534080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OARNfgYqqI88j77QXNxHtR+yC6FyBlqX15NF2v91/5s=;
        b=lozfXp23rVPsktvtX0gQPBInuNuig15+ZDtuPcOb13UrzI+pPqoY2CJAbTcGLRNR3hpifa
        Lk4NFkJOW+/QvdT7VW8ZrfhLaMqDztMIWavX2Oj+hUmGh41afMdVPFemFneKZ857g5VIxG
        EVKpXS7FQqH0cq3Yd+NENo3KiAtV904=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Dave Airlie <airlied@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
        linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH v2 09/11] PCI/VGA: Fix a typo to the comments in vga_str_to_iostate() function
Date:   Wed,  9 Aug 2023 06:34:10 +0800
Message-Id: <20230808223412.1743176-10-sui.jingfeng@linux.dev>
In-Reply-To: <20230808223412.1743176-1-sui.jingfeng@linux.dev>
References: <20230808223412.1743176-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

s/chekcing/checking

While at it, convert the comments to the conventional multi-line style,
and rewrap to fill 78 columns.

Fixes: deb2d2ecd43d ("PCI/GPU: implement VGA arbitration on Linux")
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/pci/vgaarb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index d80d92e8012b..9f5cf6a6e3a2 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -79,14 +79,16 @@ static const char *vga_iostate_to_str(unsigned int iostate)
 
 static int vga_str_to_iostate(char *buf, int str_size, unsigned int *io_state)
 {
-	/* we could in theory hand out locks on IO and mem
-	 * separately to userspace but it can cause deadlocks */
+	/*
+	 * In theory, we could hand out locks on IO and MEM separately to
+	 * userspace, but this can cause deadlocks.
+	 */
 	if (strncmp(buf, "none", 4) == 0) {
 		*io_state = VGA_RSRC_NONE;
 		return 1;
 	}
 
-	/* XXX We're not chekcing the str_size! */
+	/* XXX We're not checking the str_size! */
 	if (strncmp(buf, "io+mem", 6) == 0)
 		goto both;
 	else if (strncmp(buf, "io", 2) == 0)
-- 
2.34.1

