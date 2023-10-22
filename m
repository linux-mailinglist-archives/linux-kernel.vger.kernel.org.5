Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E1F7D2690
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 00:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjJVWYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 18:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVWYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 18:24:30 -0400
X-Greylist: delayed 171 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 22 Oct 2023 15:24:27 PDT
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 986A999;
        Sun, 22 Oct 2023 15:24:27 -0700 (PDT)
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id E641A72C8D3;
        Mon, 23 Oct 2023 01:21:34 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id BB1367CFF64; Mon, 23 Oct 2023 01:21:34 +0300 (IDT)
Date:   Mon, 23 Oct 2023 01:21:34 +0300
From:   "Dmitry V. Levin" <ldv@strace.io>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/uapi: fix SHADOW_STACK_SET_TOKEN type
Message-ID: <20231022222134.GA5334@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the type of SHADOW_STACK_SET_TOKEN to match the type of the
corresponding "flags" argument of map_shadow_stack syscall which
is of type "unsigned int".

Fixes: c35559f94ebc3 ("x86/shstk: Introduce map_shadow_stack syscall")
Signed-off-by: Dmitry V. Levin <ldv@strace.io>
---
 arch/x86/include/uapi/asm/mman.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/mman.h b/arch/x86/include/uapi/asm/mman.h
index 46cdc941f958..8419e25bb617 100644
--- a/arch/x86/include/uapi/asm/mman.h
+++ b/arch/x86/include/uapi/asm/mman.h
@@ -6,7 +6,7 @@
 #define MAP_ABOVE4G	0x80		/* only map above 4GB */
 
 /* Flags for map_shadow_stack(2) */
-#define SHADOW_STACK_SET_TOKEN	(1ULL << 0)	/* Set up a restore token in the shadow stack */
+#define SHADOW_STACK_SET_TOKEN	(1U << 0)	/* Set up a restore token in the shadow stack */
 
 #include <asm-generic/mman.h>
 
-- 
ldv
