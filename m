Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197BA8044BF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376300AbjLECYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343995AbjLECYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:24:17 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85E3120;
        Mon,  4 Dec 2023 18:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=//+I9nJKyMpuRghj3X0j4P2zXXLqqi0x1CmprEq9zR0=; b=vGdbkFadAaGifPBF760FlXvvGI
        Mp7AJtOa4ZTPgNTqf5tNyeCBc50+9gRS1c3i3X5+pcnIVbOtDtxXEk0rgSQ7O7S1npt+q0ySg+Jti
        37XHYzVbUHeaKBVKCfA5oRh8Cc3FW2ZGLtA9r2kwffx7yJ9bUAO48dGXZt8ppIuEUjw5w9s0iycqg
        SdRSPaajNIYzXD+yy4lo7BD0kRFaEi5cwCnA4t8ER+xmztXw7PsRX0f1ceJF6YQriQNEt4WRJ0Ork
        fqPoCnxujcWoTq1vuqb7Bpjj99FSmxjGYLkoZBF0zlfQayOlOOjyKgCApnSFRC3Qf3uAl35/du78v
        8BZAj92A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rAL6k-00793G-0h;
        Tue, 05 Dec 2023 02:24:22 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     gus Gusenleitner Klaus <gus@keba.com>,
        Al Viro <viro@ftp.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v2 10/18] nios2: pull asm-generic/checksum.h
Date:   Tue,  5 Dec 2023 02:24:10 +0000
Message-Id: <20231205022418.1703007-19-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231205022418.1703007-1-viro@zeniv.linux.org.uk>
References: <20231205022100.GB1674809@ZenIV>
 <20231205022418.1703007-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/nios2/include/asm/checksum.h | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/nios2/include/asm/checksum.h b/arch/nios2/include/asm/checksum.h
index 69004e07a1ba..50694a0c5dd9 100644
--- a/arch/nios2/include/asm/checksum.h
+++ b/arch/nios2/include/asm/checksum.h
@@ -10,14 +10,10 @@
 #ifndef _ASM_NIOS_CHECKSUM_H
 #define _ASM_NIOS_CHECKSUM_H
 
-/* Take these from lib/checksum.c */
-extern __wsum csum_partial(const void *buff, int len, __wsum sum);
-extern __sum16 ip_fast_csum(const void *iph, unsigned int ihl);
-extern __sum16 ip_compute_csum(const void *buff, int len);
-
 /*
  * Fold a partial checksum
  */
+#define csum_fold csum_fold
 static inline __sum16 csum_fold(__wsum sum)
 {
 	__asm__ __volatile__(
@@ -60,11 +56,6 @@ static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
 	return sum;
 }
 
-static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
-					__u32 len, __u8 proto,
-					__wsum sum)
-{
-	return csum_fold(csum_tcpudp_nofold(saddr, daddr, len, proto, sum));
-}
+#include <asm-generic/checksum.h>
 
 #endif /* _ASM_NIOS_CHECKSUM_H */
-- 
2.39.2

