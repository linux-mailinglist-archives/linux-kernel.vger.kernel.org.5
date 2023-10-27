Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E887DA296
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 23:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346584AbjJ0VrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 17:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ0VrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 17:47:03 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058F0B0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 14:47:00 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 28E127A22EA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 21:47:00 +0000 (UTC)
Received: from pdx1-sub0-mail-a302.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id DFB367A22F9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 21:46:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1698443219; a=rsa-sha256;
        cv=none;
        b=aXANBskb1+Kng12hGqtJHfAKLGZXUHpfAEsJhctFex+N+UtEdg9L43VV7Cde7foyaH9iKA
        MaLs/RBGfxilRuQjggEy1tSrI7t1aKopH+vwuHFPzYoFV2c3A9LCT99PU1f7vzWFJhoPCZ
        dTB9ITkwg0sI97iOEvaVpCKluN3cwUf/o0icQ8xaq2Z7f1e7K9utrxNtsE6fKd/NQL5q7m
        HGEq09hTL0uhCby1qUR0iLf6lh8MLDIMGeW3v64x6RKwO8qBUuMxcI37scrxhIZluf2x+B
        KU0MYQTcfeGwFwCCQxT3SXpPqjneXQxtvIF8RoUq46HSBm+OZEAw7dVL0MHPkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1698443219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         dkim-signature; bh=JUpmUW5lV5go/OajmI3/1d9ZjKGRKa+65scvMbQY/vk=;
        b=JdvpeEt8qY74DQGksUbgmSKPep/8smFdDBTU5YW/My3k8IV22+HvdCBR9elab8TSQA5pJR
        DDusaTNkMqCxkeeiBJA/2QZo4COChuuvMsM5jCC69IG81j4o2kcfg+ht2wWNXLlbnvzKqj
        dc29FoCd4q85yQBIs0CE0tP7vXsa2KDS1g+joIqwsX1ZKnPULmRYzPlm3FX7ZXBtrF5gjP
        5oLmLGLIu0Fbi8jZUZrr3Q2gl1B95K9PdSEfa0YFx0y/XKsaMpfx+v/QdGltB+O5SQWiOj
        5wUUibPCkUkVAgosbq1RkCWlKG3blwbjjNsvA5RQTOMJVPmETOasupybCpuSMg==
ARC-Authentication-Results: i=1;
        rspamd-86646d89b6-6jlm5;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Coil-Language: 6413342511613361_1698443220036_3173107770
X-MC-Loop-Signature: 1698443220036:1527149510
X-MC-Ingress-Time: 1698443220036
Received: from pdx1-sub0-mail-a302.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.206.148 (trex/6.9.2);
        Fri, 27 Oct 2023 21:47:00 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a302.dreamhost.com (Postfix) with ESMTPSA id 4SHGTb1N9fzpK
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 14:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1698443219;
        bh=JUpmUW5lV5go/OajmI3/1d9ZjKGRKa+65scvMbQY/vk=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=VsiA8AVUfWorW32LYiaLgP281KPEpsVkgPRM4zVH/QbXXZqnL0oX3KHdXC9qXqGtm
         xkFO8YmAiW9RC1EiY+QDVNi+xjh4WEBBXKsu2tC/xbO7wuabG856mwCU5wd90bBQoL
         S3cgLX5EDukmI1gDg/TswfaYPB+E88/w4Om9BDlP76RBHgFUSzBZIYxM7tK3BzPEUQ
         KLCcmopm2uFFZZLVD51xcKyvqcwp9DQeLsECw2XZ3T61zOWSYhgWIY+Grv5sCXR8mi
         NscD7w6VpwPuHMaSKOxQfsU1pkZ0AaO6ORQ+mRtAVKCzGes151EjXrjQV478IAhGyQ
         RtKZABtt/N8VA==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e00e5
        by kmjvbox (DragonFly Mail Agent v0.12);
        Fri, 27 Oct 2023 14:46:26 -0700
Date:   Fri, 27 Oct 2023 14:46:26 -0700
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
Subject: [PATCH 0/2] Triggering a softlockup panic during SMP boot
Message-ID: <cover.1698441495.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This pair of patches was the result of an unsuccessful attempt to set
softlockup_panic before SMP boot.  The rationale for wanting to set this
parameter is that some of the VMs that my team runs will occasionally
get stuck while onlining the non-boot processors as part of SMP boot.

In the cases where this happens, we find out about it after the instance
successfully boots; however, the machines can get stuck for tens of
minutes at a time before finally completing onlining processors.  Since
we pay per minute for many of these VMs there were two goals for setting
this value on boot: first, fail fast and hope that a subsequent boot
attempt will be successful.  Second, a panic is a little easier to keep
track of, especially if we're scraping serial logs after the fact.  In
essence, the goal is to trigger the failure earlier and hopefully get
more useful information for further debugging the problem as well.

While testing to make sure that this value was getting correctly set on
boot, I ran into a pair of surprises.  First, when the softlockup_panic
parameter was migrated to a sysctl alias, it had the side effect of
setting the parameter value after SMP boot has occurred, when it used to
be set before this.  Second, testing revealed that even though the
aliases were being correctly processed, the kernel was reporting the
commandline arguments as unrecognized. This generated a message in the
logs about an unrecognized parameter (even though it was) and the
parameter was passed as an environment variable to init.

The first patch ensures that aliased sysctl arguments are not reported
as unrecognized boot arguments.

The second patch moves the setting of softlockup_panic earlier in boot,
where it can take effect before SMP boot beings.

Thanks,

-K

Krister Johansen (2):
  proc: sysctl: prevent aliased sysctls from getting passed to init
  watchdog: move softlockup_panic back to early_param

 fs/proc/proc_sysctl.c  | 8 +++++++-
 include/linux/sysctl.h | 6 ++++++
 init/main.c            | 4 ++++
 kernel/watchdog.c      | 7 +++++++
 4 files changed, 24 insertions(+), 1 deletion(-)

-- 
2.25.1

