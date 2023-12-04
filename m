Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75799803216
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjLDL7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343915AbjLDL7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:59:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211961FEC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:57:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2163FC433CC;
        Mon,  4 Dec 2023 11:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701691078;
        bh=FOVbSQK19msCaYkNFzSQgPAl8qoB4jWxxmWQ3PGAOHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sR0thcYrUbsQ81aSgyW9X34S+S406cMGfLPksDNE5BQc8zRtMCvJLbelJcKJRa3LW
         3aIFLaU3XXTNT3EMelhYUu7Tx44s1DI61JZa2x/5a4zeqhiDO2FxtTZZnv6bCyqywf
         LhP0vtQ5KMKCDsTtKEWG8WL0Ef1wQToiUnGITW2HCmBzK3do0dN0Gzag5E/HaXZD2w
         OEy3IgT8o3ULCPev3H1kOf1Dm+GuIXhLRY2rTxA94ZKQEv37914w61CPaMMpD1D8eq
         O7YkFCmX8zHGZaFr3e9edlZDXjV/zk9fXrBHb093MCJTrRzPevk1t3LNdVuu2lhmZz
         OJm3OfOtBMqdg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-mips@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Stephen Rothwell" <sfr@rothwell.id.au>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Subject: [PATCH 20/20] mips: kexec: include linux/reboot.h
Date:   Mon,  4 Dec 2023 12:57:10 +0100
Message-Id: <20231204115710.2247097-21-arnd@kernel.org>
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

Two functions are provided for kexec, but the mips implementation is
missing the corresponding #include statment:

arch/mips/kernel/machine_kexec.c:136:1: error: no previous prototype for 'machine_shutdown' [-Werror=missing-prototypes]
arch/mips/kernel/machine_kexec.c:152:1: error: no previous prototype for 'machine_crash_shutdown' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/kernel/machine_kexec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/machine_kexec.c b/arch/mips/kernel/machine_kexec.c
index 432bfd3e7f22..4e3579bbd620 100644
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -8,6 +8,7 @@
 #include <linux/mm.h>
 #include <linux/delay.h>
 #include <linux/libfdt.h>
+#include <linux/reboot.h>
 
 #include <asm/cacheflush.h>
 #include <asm/page.h>
-- 
2.39.2

