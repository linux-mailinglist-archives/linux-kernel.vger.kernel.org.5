Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC3375C0E3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjGUIJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjGUIJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:09:24 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D478270A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:09:03 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6hyz08MHzBRDtd
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:08:59 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689926938; x=1692518939; bh=WO9OesZJO0OZ3dsby1KjHp/40kA
        D6UC7sDZL2hJgxPc=; b=p0gIqxroMQbD1Utj1eUX2BjWiJti+USbKUbMZkijnWM
        9tctpkViEDJ0IHc4RH9qMF2bOiPRE00KhjXXsjWEb0w5CzqK08Oa97KNk1DotJ30
        kZeXGeCpkP/AudHL3OeKd2HGNWALhGrA4DY3IabK9tMsGFoARbL0psJSo7uP5bzp
        EwIODa/bzkMe7JwkH6m013ag81waP0erILZoFJVZl0M538S2ABNxjIB9sjiOqZQg
        D/EG0hagQzArr5XLrQxXWDgTn46P3N46Z4pGGUUhU04cWQ2v0eqHVDv30JX+co2M
        6gKfpKW/gjY/AScM+WIHIGKfc7CqEoBFW57wRfnqeBg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TI6c0U1uA2HH for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jul 2023 16:08:58 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6hyy4ctCzBRDs4;
        Fri, 21 Jul 2023 16:08:58 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 21 Jul 2023 08:08:58 +0000
From:   sunran001@208suo.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] x86/head: "foo * bar" should be "foo *bar"
In-Reply-To: <20230721080703.5724-1-xujianghui@cdjrlc.com>
References: <20230721080703.5724-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <f7ca9b619b85ea1c2a07a045197f92bd@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  arch/x86/kernel/head64.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 49f7629b17f7..20d35bfd70af 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -445,7 +445,7 @@ static unsigned long get_cmd_line_ptr(void)

  static void __init copy_bootdata(char *real_mode_data)
  {
-	char * command_line;
+	char *command_line;
  	unsigned long cmd_line_ptr;

  	/*
@@ -471,7 +471,7 @@ static void __init copy_bootdata(char 
*real_mode_data)
  	sme_unmap_bootdata(real_mode_data);
  }

-asmlinkage __visible void __init __noreturn x86_64_start_kernel(char * 
real_mode_data)
+asmlinkage __visible void __init __noreturn x86_64_start_kernel(char 
*real_mode_data)
  {
  	/*
  	 * Build-time sanity checks on the kernel image and module
