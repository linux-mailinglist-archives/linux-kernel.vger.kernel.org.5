Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977547AC8D6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjIXNUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjIXNTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:19:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497F110EB;
        Sun, 24 Sep 2023 06:17:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB1EC433CB;
        Sun, 24 Sep 2023 13:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561478;
        bh=bjOuFc5oRRZarY9pBsGbWGzxVE3cv/ySCwSk7YVSDEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ToVLBlmhVInFlrjsq2OQ1jy1AX3v2B1UTqQAP2RxN/TXUIywmWY7TkOc4N+FZLOD/
         9YgC7slafAL/WIHUe629BOz00azwDYfcOMlAnUlyBXgNyrWzLGlH6ZOiwianPhq5jf
         OfuVA158JUhCkDQpXXZEU2yobFfM7TtQv1pcZEx+eZBprG3AxZKdlBwCBzuD7toK/e
         1+q2xrfoJ0tJGQNPne/OYaDcTnII95gU+Gw2ejpw4tPCmAfurv9uwKTl2zHSZKPgXn
         L0TEZfvGXxKhiNyE7Mxl6pm+R185xRLuX6moXkmZwdjjCqanV2SVpI/YszdX5ArE2b
         sUUqKUGcGYKIA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        James.Bottomley@HansenPartnership.com, linux-parisc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/28] parisc: irq: Make irq_stack_union static to avoid sparse warning
Date:   Sun, 24 Sep 2023 09:17:22 -0400
Message-Id: <20230924131745.1275960-5-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131745.1275960-1-sashal@kernel.org>
References: <20230924131745.1275960-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.55
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
index b05055f3ba4b8..9ddb2e3970589 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -368,7 +368,7 @@ union irq_stack_union {
 	volatile unsigned int lock[1];
 };
 
-DEFINE_PER_CPU(union irq_stack_union, irq_stack_union) = {
+static DEFINE_PER_CPU(union irq_stack_union, irq_stack_union) = {
 		.slock = { 1,1,1,1 },
 	};
 #endif
-- 
2.40.1

