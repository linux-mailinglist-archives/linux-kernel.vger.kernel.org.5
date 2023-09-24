Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B4D7AC93E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjIXN3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjIXN27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:28:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E19CD8;
        Sun, 24 Sep 2023 06:19:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DC9C433C8;
        Sun, 24 Sep 2023 13:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561547;
        bh=99ve1QrJHpvpwsdexG0vJdnYw/zOSr7iYVeeedJGTFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SCvzby5hKz84OuFUgzUqp4R/P7mcfbmOTAmekxYOE8t2K1XSldbiC2tLvivO99HMb
         kIuuzwGYPDmTs4XONB02MqRnqEOQhKT39V3gXevICAzmQgAyr0MfmAP2luEyEi4mC1
         l/ABZ3N/MnO768GqwXexiVuA/IdDquqRvVFnQkPcdRI6LwmGHPzFor9FpqttIVUnH2
         oVVwyLEYrN5CoWCWL/m0NFRpfTwzWTdBDx1fQSQiR8omDx/ApIpARl4Pc7NZophIcK
         nzVZ9dZbIDVm39n0Gj/Ryu8KjR8kW7Em3lmc2Iqv8ksYzLEL109FuOPEy+d3bw51lQ
         45DXnxfyAHvkQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        James.Bottomley@HansenPartnership.com, linux-parisc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 04/18] parisc: irq: Make irq_stack_union static to avoid sparse warning
Date:   Sun, 24 Sep 2023 09:18:41 -0400
Message-Id: <20230924131857.1276330-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131857.1276330-1-sashal@kernel.org>
References: <20230924131857.1276330-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.133
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
index e6cc38ef69458..5d9044e65a1a6 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -386,7 +386,7 @@ union irq_stack_union {
 	volatile unsigned int lock[1];
 };
 
-DEFINE_PER_CPU(union irq_stack_union, irq_stack_union) = {
+static DEFINE_PER_CPU(union irq_stack_union, irq_stack_union) = {
 		.slock = { 1,1,1,1 },
 	};
 #endif
-- 
2.40.1

