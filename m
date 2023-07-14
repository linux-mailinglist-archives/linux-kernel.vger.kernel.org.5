Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A44F7531B9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbjGNGFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbjGNGE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:04:59 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F1F1FD6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 23:04:57 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2LY26j1kzBR9tG
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 14:04:54 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689314694; x=1691906695; bh=FwShXRD1xEwAzu/FcvJWhKIn8mO
        fV0/c0ARmVHgf/4k=; b=hyTlULIUQAGuVF7ai+I5H0rXUsbRRfnypjVcaf2U2jh
        0ysRdt6XrsXtzkF4L6vsOS/xn0CmvXH6J4tQvNTjjqj+qha+ERnMbwiXYNCDPAVk
        WMb2V/GmSsQPCnQ3EnAskovZU54tW6on0ehpPdpMeIbMPKstQ60nKZGOvR2FO31G
        0ab6X2+m/Tjvy5ZCwubID47W38QLBk8+0Y0fdh9szfx7KVq4qi/AAncpr7hJINUF
        uoiW8Xq7IMK2IWuq2qMTRNHPCfVhWyMjtMnDPN3Rbf66/UdJK4icS3MxJzACKfY6
        jCLLQmoSKMyTdFk5DXhI20n6c4617tXn5hseMIlDh+A==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uNMiLPkgERKq for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 14:04:54 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2LY22FVZzBR9t9;
        Fri, 14 Jul 2023 14:04:54 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 14:04:54 +0800
From:   chenqingyun001@208suo.com
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH]  arm64:Remove trailing semicolon in macros
In-Reply-To: <tencent_86E391FD1561C2F9983EBCDFCC18FAE4E00A@qq.com>
References: <tencent_86E391FD1561C2F9983EBCDFCC18FAE4E00A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <ee66d6ee28e89aeb6272287ab3b321a9@208suo.com>
X-Sender: chenqingyun001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macros should not use a trailing semicolon.

Signed-off-by: Qingyun Chen <chenqingyun001@208suo.com>
---
  arch/arm64/kernel/sys32.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/sys32.c b/arch/arm64/kernel/sys32.c
index fc40386afb1b..3557c210c7d7 100644
--- a/arch/arm64/kernel/sys32.c
+++ b/arch/arm64/kernel/sys32.c
@@ -123,7 +123,7 @@ COMPAT_SYSCALL_DEFINE6(aarch32_fallocate, int, fd, 
int, mode,
  }

  #undef __SYSCALL
-#define __SYSCALL(nr, sym)    asmlinkage long __arm64_##sym(const 
struct pt_regs *);
+#define __SYSCALL(nr, sym)    asmlinkage long __arm64_##sym(const 
struct pt_regs *)
  #include <asm/unistd32.h>

  #undef __SYSCALL
