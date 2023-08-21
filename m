Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D0E782122
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjHUBTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjHUBTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:19:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B4FA2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 18:19:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3CAA62600
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D69C433C8;
        Mon, 21 Aug 2023 01:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692580771;
        bh=7OD1zp7lr2PeEyb0O+J7TBAKnhNO6d4kRxvr1UurTik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F59GOysqAGXkeXnL9vWGqNksVL1+q5aWBxtkN2TbI5k/4dOczZ6gZ/Fwtr7oUAms1
         B7kPx6ahvKp1ZOt9BY+ncB1OayolammlpJ9PcUmb6fzYKFDsW8IRHLksK1eTLpyZn1
         Y7ocf0BSyvXfbavZc3/PeR2jB6DyCabXybUuiuk1WbVG8vCxjQr7D2aoVqrFMnjarw
         OIOOXBIEgm3lz+tz3kAyBexX1od7rgNME6nzSecq0wL/5C6A/iEVMuXdDceZaiBbYv
         Zz5AVsH5SK3DSAuZDpvcsU8oFvz7H98k0r8HPcDkhMdXSiNbqSmL4uixEpKj8YvqRQ
         R5Zx5N2NKC5Mw==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 07/22] x86/srso: Remove default case in srso_select_mitigation()
Date:   Sun, 20 Aug 2023 18:19:04 -0700
Message-ID: <9e913c461707372017d8b9a53491dc8dcaff07dd.1692580085.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692580085.git.jpoimboe@kernel.org>
References: <cover.1692580085.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the default case so a compiler warning gets printed if we forget
one of the enums.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 579e06655613..cda4b5e6a362 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2485,9 +2485,6 @@ static void __init srso_select_mitigation(void)
 			pr_err("WARNING: kernel not compiled with CPU_SRSO.\n");
                 }
 		break;
-
-	default:
-		break;
 	}
 
 	pr_info("%s%s\n", srso_strings[srso_mitigation], (has_microcode ? "" : ", no microcode"));
-- 
2.41.0

