Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F3075A442
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 04:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjGTCIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 22:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGTCIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 22:08:47 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5534E1FFE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 19:08:44 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5x1g1nVjzBRDrK
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:08:39 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689818917; x=1692410918; bh=op03lTFVycvrsoiSyYa7DnyLy2u
        Eg3gNJvz56AOcgYw=; b=pq+Qbs4OFTu0lz4egMGZQExWe6EmSX8prEmbfTWCURJ
        ck2+vPSdNp/tGva9IFvZNVgoOpXrBuEpTXcIMTSl00mPFZw27nPkI3Mdtd8++pNF
        RRyEMETPvMTHnZltTQuA2gka6qRHJI5yIOBC7Bm74unl+PiTTi8j85gAKw5Qs6GB
        6BPPVnf6xdeATF/exuQUNw9TGKQYterIjKAzLJVte2zhy/GI+mJcpGn3lEyddHoy
        /nY0TLzRtaLgCLINjqAKz6gzaLa5n6oaHE0uoDkVPLpsPUwvo406s1EPpKiItxIJ
        5l4o47cPRw4pQQUok61npPnKmnmOCd9rC6Cou3ya0Mg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Tu8elr19Dr0u for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 10:08:37 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5x1d4rCHzBJCNV;
        Thu, 20 Jul 2023 10:08:37 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 10:08:37 +0800
From:   sunran001@208suo.com
To:     bp@suse.de, arnd@arndb.de, ebiederm@xmission.com,
        brgerst@gmail.com, sohil.mehta@intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] compat: add missing spaces after ';'
In-Reply-To: <20230720020219.766-1-xujianghui@cdjrlc.com>
References: <20230720020219.766-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <164ef920bb0c98137824a729eb9ff13b@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove spaces to clear checkpatch errors.

ERROR: space required after that ';' (ctx:VxV)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  include/linux/compat.h | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 1cfa4f0f490a..2f6a62afe984 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -39,7 +39,7 @@
  #endif

  #ifndef __SC_DELOUSE
-#define __SC_DELOUSE(t,v) ((__force t)(unsigned long)(v))
+#define __SC_DELOUSE(t, v) ((__force t)(unsigned long)(v))
  #endif

  #ifndef COMPAT_SYSCALL_DEFINE0
@@ -72,7 +72,7 @@
  	__diag_push();								\
  	__diag_ignore(GCC, 8, "-Wattribute-alias",				\
  		      "Type aliasing is used to sanitize syscall arguments");\
-	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
+	asmlinkage long compat_sys##name(__MAP(x, __SC_DECL, __VA_ARGS__))	\
  		__attribute__((alias(__stringify(__se_compat_sys##name))));	\
  	ALLOW_ERROR_INJECTION(compat_sys##name, ERRNO);				\
  	static inline long 
__do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
