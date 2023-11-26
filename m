Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B38E7F9356
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 16:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjKZPRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 10:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjKZPRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 10:17:12 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC41D110;
        Sun, 26 Nov 2023 07:17:18 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 317325C0131;
        Sun, 26 Nov 2023 10:17:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 26 Nov 2023 10:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1701011838; x=
        1701098238; bh=9BqopU5P2Px1rSuq122+Z/QyeeLtFNsRvUhaSSz0syw=; b=e
        zdyI/jxZYTzfUTEFLakFWlSynjXobfWGWzQIhm+OCpQslUXsbD7z/ZsLyz+/UGLL
        ozme/EpYJtKHNPpvvAyLCb1qPWQ2SOGNT/BoXXmP8GO3roa0KLKAg+HgO5eQF0zs
        VJkp9NVhkUWF+fHX5VmJ+d0SYHZO3akv6BdANvXzBgc86M07YEyp6a40JWeoFwV3
        WZE8yIxKeGHSBR4C+v0RBpQe7CtxUm+3xdtc733qs/kQzBEjGlwhDfkuS+OtHuhO
        uSI/N3P+IEh0OHbPfucwz0xThFixoapTz1mTMwJ56tr0BtwwtF9ECnXziUB4Epb8
        n6pK3l4evE2CgxYZ/z8Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701011838; x=
        1701098238; bh=9BqopU5P2Px1rSuq122+Z/QyeeLtFNsRvUhaSSz0syw=; b=s
        6+2g9E0kBaKNt/GTBJQPcSkV52YeUbnk23Qmv8F4LjozXhJBi6KzxzOZPSdtGW23
        t1PVFKSZBVaL+kwotHSI8tYjGQgzxWc3FD1vIeI/FFTAyy+iHpQg+ZSmk40J9Mg2
        pPbUw7QAo4xAhGq6WgcUJMxdv+/CemwsAVLdRBrPE6zdQ51e4UnSrQoQ29wHv097
        Lu30lsozzZm1uM6hJot/lps+i1GHf/+WAqST60ttWsbmnmz88O4Ve4bGfbsZpmsc
        dFiIqkJguKvJfmyVF0vscWrgI8WzHzSaRLkW3oeueXlwi7bYoyvy3xIvgodVnVet
        /6FKYRpb5CV8v6fzjU/9g==
X-ME-Sender: <xms:fmFjZVHcb8MYEf5Y8jy_X1bnNnINJghmgj7gHC0r8rY835tr5a_Fxg>
    <xme:fmFjZaWwM1etmahGMnCGxbML23RRHnzQZ0hmReHWoe1TMBXJqSBu0GN4V-rG88P2y
    JCKeX2BtZDW4xBEOtc>
X-ME-Received: <xmr:fmFjZXLMMnf2ydWX_wLLQl989NGHf18M6pJyDcmLYEpHH-t_92gIVLkGnCkJOXx5J8CCmYOZtcJPROxf4wXDKooE0v19HWwqcykvMaMi0Ph8lMhj8VIwzuuHyFKb7Ec>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehledgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpeejieehheekgedvjefhveekjefguddtfefhteehtdeiffelkeeiuedufeelkeej
    geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvh
    gvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:fmFjZbHkSv6Bi9DMqKFwwR4PIeq17dawpKkr0jdGr3X-0zGl7Haa3g>
    <xmx:fmFjZbUpyhweLucVUJgdVZSz8-uytRbk6Y_MyI7hNqgTDp7hJwTxmA>
    <xmx:fmFjZWP8Ts2hsREHkmZa_0uNf5SXNsFjj3BTXkB7hCk3c7eI3wflZQ>
    <xmx:fmFjZUu_RdsKn4Fz7lmkKtd2XMNHJ53_fiP_Q8X11tF84ghpMBZ8pQ>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Nov 2023 10:17:15 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] iommu: dart: Write to all DART_T8020_STREAM_SELECT
Date:   Sun, 26 Nov 2023 16:17:00 +0100
Message-Id: <20231126151701.16534-3-sven@svenpeter.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231126151701.16534-1-sven@svenpeter.dev>
References: <20231126151701.16534-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're about to add support for a DART variant that use more than 16
streams and requires writing to two separate stream select registers
when issuing TLB flushes.

Acked-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/apple-dart.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index ee05f4824bfa..8b6b0cdba9b5 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -368,12 +368,14 @@ apple_dart_t8020_hw_stream_command(struct apple_dart_stream_map *stream_map,
 			     u32 command)
 {
 	unsigned long flags;
-	int ret;
+	int ret, i;
 	u32 command_reg;
 
 	spin_lock_irqsave(&stream_map->dart->lock, flags);
 
-	writel(stream_map->sidmap[0], stream_map->dart->regs + DART_T8020_STREAM_SELECT);
+	for (i = 0; i < BITS_TO_U32(stream_map->dart->num_streams); i++)
+		writel(stream_map->sidmap[i],
+		       stream_map->dart->regs + DART_T8020_STREAM_SELECT + 4 * i);
 	writel(command, stream_map->dart->regs + DART_T8020_STREAM_COMMAND);
 
 	ret = readl_poll_timeout_atomic(
-- 
2.34.1

