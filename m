Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623B080320F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjLDL7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjLDL6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:58:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B5010C7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:57:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CD3C433CB;
        Mon,  4 Dec 2023 11:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701691068;
        bh=K/hCExDh0cBht9JYKXc5uzgnRoEPgJr0wTezykOGsCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ADQLkfR6/G5iW3ZcRBZsrLpUf7s7lsovxNQBaHMvyKPYeFp0oZCVZjDtndv5cqYGU
         lPehDNZvpC3yAwufw5khufsbAMNoUFlNIGaI1yaBHqFuz1YaRZn4DbGi+XyYodJY4q
         4FGW/Q8TD2NbPaDJTJzbPs5JocjhRDz/r10nks0EMew/v78e3FQ91HM77SxJFZmLZu
         K1u6XrPv6lv3yGQeOH0UHn1M2hB4siZN/MF+K3rFdNM/LfD4YlAX+aoDVXXwjSO94M
         13d6FrGBXNG0XJkWcWHV+bV0VVGwbcr/kC/CzRz4CGGN3Z74yD5c5PzADvR+dGvIGu
         TmWWTsA/e0SSw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-mips@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Stephen Rothwell" <sfr@rothwell.id.au>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Subject: [PATCH 15/20] mips: mt: include asm/mips_mt.h
Date:   Mon,  4 Dec 2023 12:57:05 +0100
Message-Id: <20231204115710.2247097-16-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204115710.2247097-1-arnd@kernel.org>
References: <20231204115710.2247097-1-arnd@kernel.org>
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

From: Arnd Bergmann <arnd@arndb.de>

These two functions have a global prototype but the header is not
included before the function definitions:

arch/mips/kernel/mips-mt.c:50:6: error: no previous prototype for 'mips_mt_regdump' [-Werror=missing-prototypes]
arch/mips/kernel/mips-mt.c:159:6: error: no previous prototype for 'mips_mt_set_cpuoptions' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/kernel/mips-mt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/mips-mt.c b/arch/mips/kernel/mips-mt.c
index f88b7919f11f..c07d64438b5b 100644
--- a/arch/mips/kernel/mips-mt.c
+++ b/arch/mips/kernel/mips-mt.c
@@ -19,6 +19,7 @@
 #include <asm/mipsmtregs.h>
 #include <asm/r4kcache.h>
 #include <asm/cacheflush.h>
+#include <asm/mips_mt.h>
 
 int vpelimit;
 
-- 
2.39.2

