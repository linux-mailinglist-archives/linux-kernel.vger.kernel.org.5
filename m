Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689388044BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346357AbjLECYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343982AbjLECYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:24:17 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A014F11F;
        Mon,  4 Dec 2023 18:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+ftBbukfbbgB/3/4QoTvmiqqpacNNyeFRNlaZmcdRVg=; b=ftqyCDwPPLwgkHLsUwmdm5vWdw
        3X8jVP2KGrZwzU8ISQlnPaZR+3nV/h0rwQIbnwWAHv1JjQIguquG0DAAe0sUN9N8xt5/zXi4eki8X
        5Kh6Y7Pfu7JuId3EUU+4h99/T757qoM7cEDBC4akHwXD2q9dUa9HQU87f2XAv0PFWsb2K/IZChimn
        CJYFuYkIe0OAGcQ6GhZBSkfItbtxgyBjxz+xF18eDfYyGKlSkQsp/iC8N8JSQdwZ39MnvdxcbYuF2
        h9ksaoDjqeqHqVYtW9jA9j4+Mij2xp6Nlz0H0vCfOtI4g/S4pijHmS6oZ2IxnLqQJw2z5eC2Yfod4
        ++f++LEQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rAL6j-007937-2f;
        Tue, 05 Dec 2023 02:24:21 +0000
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
Subject: [PATCH v2 09/18] mips: pull include of asm-generic/checksum.h out of #if
Date:   Tue,  5 Dec 2023 02:24:08 +0000
Message-Id: <20231205022418.1703007-17-viro@zeniv.linux.org.uk>
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
 arch/mips/include/asm/checksum.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
index 1e49fd107da1..061b56163668 100644
--- a/arch/mips/include/asm/checksum.h
+++ b/arch/mips/include/asm/checksum.h
@@ -12,9 +12,7 @@
 #ifndef _ASM_CHECKSUM_H
 #define _ASM_CHECKSUM_H
 
-#ifdef CONFIG_GENERIC_CSUM
-#include <asm-generic/checksum.h>
-#else
+#ifndef CONFIG_GENERIC_CSUM
 
 #include <linux/in6.h>
 
@@ -237,7 +235,8 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 	return csum_fold(sum);
 }
 
-#include <asm-generic/checksum.h>
 #endif /* CONFIG_GENERIC_CSUM */
 
+#include <asm-generic/checksum.h>
+
 #endif /* _ASM_CHECKSUM_H */
-- 
2.39.2

