Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164107AC728
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 10:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjIXIv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 04:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIXIv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 04:51:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19F6AF;
        Sun, 24 Sep 2023 01:51:49 -0700 (PDT)
Date:   Sun, 24 Sep 2023 08:51:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695545508;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nsukY5lpS0m62Ya1g66/8kwo2fAp8RTtZtzXiRkR5lg=;
        b=jKVOuHssSJTMLPj/E1enpO3kKMv89SjRsxPKu2vUjc2COTNUHKRZWNtnVadqkj5qGMLr+b
        vHlqvYmsXRT0C4tjZ3rSsKdshWZsUvdDsRZCEEWTJViwd4q1EOIVCfXfEydxYruqTulCcv
        +0eOqflTcBd+sRVNmSo0xhgaj9SxW4L6kX8weWkrVk0cT3jRF2DdLsty7l3lWpHWud8k97
        zwWliOqXDJdt/RAq2eRvlY9PPPh4t+hUbWr7RFDiDyUbUrC4lHlSiLBUU3g1j3lCmeVqOf
        3NiUPBi3ku8Yz/TYlfippZ4ex0VOi1cEztDEkRM2YZgnru1X7cz5pJeeO1MkcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695545508;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nsukY5lpS0m62Ya1g66/8kwo2fAp8RTtZtzXiRkR5lg=;
        b=PuJ1IihydV7Waot1d+eYUZmXi/URkfKB/v7MLYLFiLLhWKS6lK2CuUnhI9MQYP5X3KOysA
        vR5LNTsxQ5IUleCg==
From:   "tip-bot2 for Christophe JAILLET" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/kgdb: Fix a kerneldoc warning when build with W=1
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Caad659537c1d4ebd86912a6f0be458676c8e69af=2E16954?=
 =?utf-8?q?01178=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
References: =?utf-8?q?=3Caad659537c1d4ebd86912a6f0be458676c8e69af=2E169540?=
 =?utf-8?q?1178=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
MIME-Version: 1.0
Message-ID: <169554550743.27769.9849615917462717503.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     841b8c99395c576d4585f443e38e8e9cc0db9e9e
Gitweb:        https://git.kernel.org/tip/841b8c99395c576d4585f443e38e8e9cc0db9e9e
Author:        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
AuthorDate:    Fri, 22 Sep 2023 18:46:49 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 24 Sep 2023 10:46:54 +02:00

x86/kgdb: Fix a kerneldoc warning when build with W=1

When compiled with W=1, the following warning is generated:

  arch/x86/kernel/kgdb.c:698: warning: Cannot understand  *
   on line 698 - I thought it was a doc line

Remove the corresponding empty comment line to fix the warning.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/aad659537c1d4ebd86912a6f0be458676c8e69af.1695401178.git.christophe.jaillet@wanadoo.fr
---
 arch/x86/kernel/kgdb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 3a43a2d..9c9faa1 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -695,7 +695,6 @@ void kgdb_arch_exit(void)
 }
 
 /**
- *
  *	kgdb_skipexception - Bail out of KGDB when we've been triggered.
  *	@exception: Exception vector number
  *	@regs: Current &struct pt_regs.
