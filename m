Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EC175A7B0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjGTHWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjGTHWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:22:07 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795821998
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:22:04 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R63zG32VFzBRDsQ
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 15:22:02 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689837722; x=1692429723; bh=v7iw69mxg3QBIitceoQwmpcV5rP
        7d16JIacjEOzr9gM=; b=E/YINLxVeTo+Zy6P/B4BJv2wN1pCgt1xmH4R0ajLPun
        Y62vhHxpIF4zKsogrnOn+uhVUjnPn1NZW5jrqVGQNXVDjHqyUDFCuKyJ/Ul1Ig7k
        ts+8qjFy3mBcknjvJmpAznaG/sm7q65RhHTVAjFkZNpBrXoh4GgPc3TjFpQAZtR2
        n/pgbJ6WPUJcCmALC64gKSgD16+f1AB967Rua1ILkqCGhs9SN0AyTmRkM3ONOVtV
        e3k/+GzEsaNO2X3fqk1bwRxYsmPHqXo8Ykd+s3kUFLMhcELVBvL0NsS99nKj7MSb
        GI4PHmRICtW0xc0XQ8DNhEoLxFDKhjEqH17FcDEEIng==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bTWmjkS6HhTI for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 15:22:02 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R63zG0M6jzBRDs1;
        Thu, 20 Jul 2023 15:22:01 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 15:22:01 +0800
From:   hanyu001@208suo.com
To:     mpe@ellerman.id.au, npiggin@gmail.com, windhl@126.com,
        robh@kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] embedded6xx: holly: use seq_puts instead of seq_printf
In-Reply-To: <tencent_E0E757021CD56C9510E3C044A6B421B59E08@qq.com>
References: <tencent_E0E757021CD56C9510E3C044A6B421B59E08@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <2d238f3ebbd359d18eae523925d0c8bf@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch WARNINGS:

/platforms/embedded6xx/holly.c:199: WARNING: Prefer seq_puts to 
seq_printf
/platforms/embedded6xx/holly.c:200: WARNING: Prefer seq_puts to 
seq_printf

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  arch/powerpc/platforms/embedded6xx/holly.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/holly.c 
b/arch/powerpc/platforms/embedded6xx/holly.c
index 02ff260ae1ee..11820d0d22c4 100644
--- a/arch/powerpc/platforms/embedded6xx/holly.c
+++ b/arch/powerpc/platforms/embedded6xx/holly.c
@@ -196,8 +196,8 @@ static void __init holly_init_IRQ(void)

  static void holly_show_cpuinfo(struct seq_file *m)
  {
-    seq_printf(m, "vendor\t\t: IBM\n");
-    seq_printf(m, "machine\t\t: PPC750 GX/CL\n");
+    seq_puts(m, "vendor\t\t: IBM\n");
+    seq_puts(m, "machine\t\t: PPC750 GX/CL\n");
  }

  static void __noreturn holly_restart(char *cmd)
