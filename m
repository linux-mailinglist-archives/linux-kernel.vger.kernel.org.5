Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B430F7AC98C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjIXNch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjIXNcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:32:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D382B5B84;
        Sun, 24 Sep 2023 06:20:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B68C433BB;
        Sun, 24 Sep 2023 13:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561657;
        bh=OTE0OTbb8GhgTkY+kGlP6RqkSIA+gOgD7lqkw3P/ZDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WO1XzPLOrMHZaujN0/nhz6hYFntKt/kqBycxM+RQh+sxmv/swHUHEXpSHFca+D3IZ
         kBaEbH3vV+e5q9fRdyb0A0wQ+HC1/crMmvf9Y2Rlaj4ymYVH0nslZqyTfOzJKAIZHE
         Zv+zDTO4n5PocZL+qzV9u6faBc8rDh9DmHjA5OqaaWJpEbExfzRPgUW7INkK5ZcY9d
         i03vMNF2ZFe1VndHUVr2Wkn1ba3l97mHIF4dbDAIH1fSSkHTO4x6OM8V2oFiDcTPn6
         DOISke5Vhk8Tt7HP8cDKwK+YxG7SdO2zcr5YGXkYq6smdiPa13NF3k6bRYxDMZN5bo
         CFuhFxXUqFSIA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        James.Bottomley@HansenPartnership.com, linux-parisc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 3/6] parisc: irq: Make irq_stack_union static to avoid sparse warning
Date:   Sun, 24 Sep 2023 09:20:46 -0400
Message-Id: <20230924132050.1277021-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924132050.1277021-1-sashal@kernel.org>
References: <20230924132050.1277021-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.326
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Deller <deller@gmx.de>

[ Upstream commit b1bef1388c427cdad7331a9c8eb4ebbbe5b954b0 ]

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index c152c30c2d06d..11c1505775f87 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -392,7 +392,7 @@ union irq_stack_union {
 	volatile unsigned int lock[1];
 };
 
-DEFINE_PER_CPU(union irq_stack_union, irq_stack_union) = {
+static DEFINE_PER_CPU(union irq_stack_union, irq_stack_union) = {
 		.slock = { 1,1,1,1 },
 	};
 #endif
-- 
2.40.1

