Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075AB7DA2B0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 23:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346587AbjJ0V5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 17:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ0V5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 17:57:03 -0400
X-Greylist: delayed 570 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Oct 2023 14:56:59 PDT
Received: from grey.apple.relay.mailchannels.net (grey.apple.relay.mailchannels.net [23.83.208.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F09F1A1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 14:56:58 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id CDC3E5411F7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 21:47:27 +0000 (UTC)
Received: from pdx1-sub0-mail-a302.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 92A55540F8D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 21:47:27 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1698443247; a=rsa-sha256;
        cv=none;
        b=e9CtkjrwDZvCeRj8IlGuSZ9W+wTSSmw5XVfdw0vxFhh100afTVOZM6HLyGXvdr4Iwv0Tm5
        hoHkr80keu/F2gvctHYWzjhr/Xvmo5SvO9Po9Vp/YTwPeOGMY9WbZLlYnLAD97cnf25a1Z
        t5P3SESbO1ku32YXqTMQSglm7bs2l36/SkEIdwP8rktI9QtEpzTqa07IxgILko/ew3HQeE
        ZTiiqrwgs1m5yfvEqslDtnBJtqgVTH7+oiN8AuXZc/EFiCVy8GFyB+LD6D70kHotOH7OVZ
        an3tUmxkvKz4Eznzql7ifeE+TwDDBzLF4Wat9EpgOE2Ypt/MouwGYhaFUNwo2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1698443247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=z8DwCsUmhzn9nJRaTITwfCrjwQF9h/gGSt9j70sFpsU=;
        b=kyzp1PCuG23HaWkn/HM3qcLjAa1dhomnxQiiFml5WYsNQ4h5JFn83ud6/UaNMQkB3Yx7OU
        GKzCB8KTBmOmp8lt3UfQLmMUz4rQ+HVB1f4dlxxCQPTAUdMJFGFMFUBNALI3CPXl5bbLsF
        Vz9aFa6wHtPitCr0EipmeURRewh4wOYWdcmpVDWeL0tw+bF3vSL+N4d0Do4EUh1ikCklwz
        Z2ENcQSdrhb3o5JnM4umZVRPE8wfT04EHYl8FPSdonyH/lp3OHceaJo/bOsRjEs8afh+IB
        kgb75tweweyixX8uULptEf5GTL4/qsXEJFEF8R1vYcSHQ+mgcDpFBKW/Mc3HLA==
ARC-Authentication-Results: i=1;
        rspamd-86646d89b6-wxj67;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Abortive-Lonely: 56b0ceb93450b044_1698443247712_412827047
X-MC-Loop-Signature: 1698443247712:3137853346
X-MC-Ingress-Time: 1698443247712
Received: from pdx1-sub0-mail-a302.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.105.139 (trex/6.9.2);
        Fri, 27 Oct 2023 21:47:27 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a302.dreamhost.com (Postfix) with ESMTPSA id 4SHGV65ccvz1Nf
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 14:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1698443246;
        bh=z8DwCsUmhzn9nJRaTITwfCrjwQF9h/gGSt9j70sFpsU=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=XDfEhyGW2vb0LqrECobDGiTiXH3Ux9yIjvF2NSgoDkZ/fRHm/zRRIv3KEf10jj1D3
         62m0WZA15p8ub3nmfP0NMp4qJSO6wJTlf4OFNT/+gi7Q2Y5b6Y6fbAWEmtGh33SALO
         XUnAjRYLx7gRr/1eIlLkiTZ3SjFp5dR6+4vuYFKWzg7bEW4mRV1Xtzh7ty0hNfeGyY
         OcjxJBL9kHxuoclIJcwbxhvwUNEfVfjlFIs42rpfjm/9MWJBaxt9ynSgCsewyAK4xk
         xTekNxmxNhh64rMwolCPDlhh8Uc6E05Q/sdLoJ0oaM8TZZJnZpBdkRJcfKgftxyN53
         OyD8f1MifP9wA==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e00e5
        by kmjvbox (DragonFly Mail Agent v0.12);
        Fri, 27 Oct 2023 14:46:53 -0700
Date:   Fri, 27 Oct 2023 14:46:53 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Hildenbrand <david@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/2] watchdog: move softlockup_panic back to early_param
Message-ID: <019420f881ee8e2582870c2770759954835adfad.1698441495.git.kjlx@templeofstupid.com>
References: <cover.1698441495.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698441495.git.kjlx@templeofstupid.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting softlockup_panic from do_sysctl_args() causes it to take effect
later in boot.  The lockup detector is enabled before SMP is brought
online, but do_sysctl_args runs afterwards.  If a user wants to set
softlockup_panic on boot and have it trigger should a softlockup occur
during onlining of the non-boot processors, they could do this prior to
commit f117955a2255 ("kernel/watchdog.c: convert {soft/hard}lockup boot
parameters to sysctl aliases").  However, after this commit the value
of softlockup_panic is set too late to be of help for this type of
problem.  Restore the prior behavior.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Cc: stable@vger.kernel.org
Fixes: f117955a2255 ("kernel/watchdog.c: convert {soft/hard}lockup boot parameters to sysctl aliases")
---
 fs/proc/proc_sysctl.c | 1 -
 kernel/watchdog.c     | 7 +++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 1c9635dddb70..de484195f49f 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1576,7 +1576,6 @@ static const struct sysctl_alias sysctl_aliases[] = {
 	{"hung_task_panic",			"kernel.hung_task_panic" },
 	{"numa_zonelist_order",			"vm.numa_zonelist_order" },
 	{"softlockup_all_cpu_backtrace",	"kernel.softlockup_all_cpu_backtrace" },
-	{"softlockup_panic",			"kernel.softlockup_panic" },
 	{ }
 };
 
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index d145305d95fe..5cd6d4e26915 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -283,6 +283,13 @@ static DEFINE_PER_CPU(struct hrtimer, watchdog_hrtimer);
 static DEFINE_PER_CPU(bool, softlockup_touch_sync);
 static unsigned long soft_lockup_nmi_warn;
 
+static int __init softlockup_panic_setup(char *str)
+{
+	softlockup_panic = simple_strtoul(str, NULL, 0);
+	return 1;
+}
+__setup("softlockup_panic=", softlockup_panic_setup);
+
 static int __init nowatchdog_setup(char *str)
 {
 	watchdog_user_enabled = 0;
-- 
2.25.1

