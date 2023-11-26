Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841097F93B6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 17:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjKZQUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 11:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKZQUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 11:20:15 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D36ED3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 08:20:22 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 093F35C0162;
        Sun, 26 Nov 2023 11:20:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 26 Nov 2023 11:20:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1701015619; x=1701102019; bh=Qy
        P8UlmkQUxctXvsLY+u2IDuION9oeAKPUhsirOlXLA=; b=mz9yoPopTnP5Pp9VMl
        d2z+GxcdEHJ0tmL5X3c0HKcOBIgBBPogGES9smTlQf/Y7YpXCFNuyR/cbd4eblDR
        U6itJOlmN29E0epnkGmKfcmml1kGtIIC8knv6lWDBXqAyizfMmZZ8uixkEfL9s0l
        gz64qKje4FM0BruZ0MVm/5QhsyanRTIhxhKBvMRD0t46o+qW88VhK6tOT1V8nhgi
        NLeR2JdE2uT0WNdG6vPoFqDD+9uRIQTDDM19javDpLi8/BW3yD9a35v/LmdOCh+s
        GmtmzU+bP2ys02U4p/7K2B8wDTEsX3PfdUs0GrgusNVLm+cGbN0qyt8614odS95O
        qWqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701015619; x=1701102019; bh=QyP8UlmkQUxct
        XvsLY+u2IDuION9oeAKPUhsirOlXLA=; b=pYW6R4XCzRWd0vTqOJWtxZ77G2Xa0
        tiANXLIVKppJ2E10z+/38o4klXtIPbKRjbPZi0unsaPsdbWSkXKDPre2IDOZMDca
        3fMLyDSrRIdACt1SgcX6EPjR0nfz6GpRo0+KhEsos1aOIq+mwzrrF1IfPsMgU/Il
        Yl8JMJPkrG/dBGxFcUjkinRSPBoW+jCImanE7oeCzAwFjNv2KAgh7Cx44BwZ9/3Z
        ufgv2gtu5LCLod4X9+evU0B0azE0ziOhagcQNvM+MbNC/hxFh1X3IB5qZWRU/EUW
        dKzARYnqNs7VRYa86/mEFocyApbgQik8UTYqlJu27PmINuvmOk6wIaHQQ==
X-ME-Sender: <xms:QnBjZV5cDDVJbvYPtkQ9ryzJUBGmbD2Swxwsv6tnrPl-J-IJ84LjAQ>
    <xme:QnBjZS7k3aPMObtfVzaI_FLh7lerL1ppTkFc_zxCsNTVROm982brmjmpy70tFUk1b
    EwBe4F6TzWiM3VkB74>
X-ME-Received: <xmr:QnBjZcfTQ1ZYM3ZMwgmcFK02dJPttc8k5NWhdDdABE61PbtFU-gOoh70BYyH6DhOJBXz0cFJsFZn5rRrzkmDXqlVzYtDyXF7Qa_v-IC8OhLGXEZ4HMHvyGM_Y-ls3uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehledgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufhvvghnucfr
    vghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrh
    hnpeeludffieehueevtdffvedtueelleejuddugfettdevhfefffdvgffhjeehgfelleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnh
    esshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:QnBjZeJhfb2l1cvB8aiiCBBqvgCMwubJsyjh2Xg_Ow7bx5LS9IHGFw>
    <xmx:QnBjZZJ978hMrfxgmqD292uDOHG4gqeCceuXFraHAFZ8EMgsLww9MQ>
    <xmx:QnBjZXw_SJi0LXt1FRu8hOt0eZVit57-2ptaaCBAQ4rFAkl2M1B0uw>
    <xmx:Q3BjZQ88uzyYXxa_Wgbci8FNl3bKjHQRDhLuFwi9nEQcCcUWFenojA>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Nov 2023 11:20:16 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: dart: Use readl instead of readl_relaxed for consistency
Date:   Sun, 26 Nov 2023 17:20:09 +0100
Message-Id: <20231126162009.17934-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
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

While the readl_relaxed in apple_dart_suspend is correct the rest of the
driver uses the non-relaxed variants everywhere and the single
readl_relaxed is inconsistent and possibly confusing.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/apple-dart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 59cf256bf40f..c7f047ce0a7a 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -1272,7 +1272,7 @@ static __maybe_unused int apple_dart_suspend(struct device *dev)
 	unsigned int sid, idx;
 
 	for (sid = 0; sid < dart->num_streams; sid++) {
-		dart->save_tcr[sid] = readl_relaxed(dart->regs + DART_TCR(dart, sid));
+		dart->save_tcr[sid] = readl(dart->regs + DART_TCR(dart, sid));
 		for (idx = 0; idx < dart->hw->ttbr_count; idx++)
 			dart->save_ttbr[sid][idx] =
 				readl(dart->regs + DART_TTBR(dart, sid, idx));
-- 
2.34.1

