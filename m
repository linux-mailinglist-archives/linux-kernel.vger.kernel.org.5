Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D075880A944
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574345AbjLHQgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574539AbjLHQfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:35:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5FA1BD9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:35:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9608C433C8;
        Fri,  8 Dec 2023 16:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702053346;
        bh=Ho/kybth4D2azYyy3+MrZcuV5/UtWLUUn5wsZ3KGBaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jh+JoUBhx/n+uubL7szxJytPSQ53Zm47OjhmnBAd9ZX/l9qyt04gNFfuYtjHYCHwr
         pZUNCoaeFX9sJLhGo43RBkkne2uQhz9S/6kr6T9MrVqBOoCuMFkBC7UmlyLtyDwLzL
         WOFgLyrJtV5039Mohiw8mt+5WoReashV3Kmzs4eK4POOkTSyAQS4ISVh4vNanu7ZCj
         bRclPa490aWqumbrEIEdUjScW+5bw30KF2iCQxtDW+O3S68I0/hvGM5539BT0BwATO
         UpdF5GT6VWOrQkGh+heMG1R9FL+7ui9lsazW+Vwcjis4OxopQ3P2LonVxMxCgwOy3x
         5dQVm+RiHAoyA==
From:   Naveen N Rao <naveen@kernel.org>
To:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH 1/9] powerpc/ftrace: Fix indentation in ftrace.h
Date:   Fri,  8 Dec 2023 22:00:40 +0530
Message-ID: <9f058227bd9243f0842786ef7228d87ab10d29f6.1702045299.git.naveen@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702045299.git.naveen@kernel.org>
References: <cover.1702045299.git.naveen@kernel.org>
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

Replace seven spaces with a tab character to fix an indentation issue
reported by the kernel test robot.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311221731.alUwTDIm-lkp@intel.com/
Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 arch/powerpc/include/asm/ftrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 9e5a39b6a311..1ebd2ca97f12 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -25,7 +25,7 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 	if (IS_ENABLED(CONFIG_ARCH_USING_PATCHABLE_FUNCTION_ENTRY))
 		addr += MCOUNT_INSN_SIZE;
 
-       return addr;
+	return addr;
 }
 
 unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip,
-- 
2.43.0

