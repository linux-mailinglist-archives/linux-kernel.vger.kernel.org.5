Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0427DA3F3
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 01:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346719AbjJ0XH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 19:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0XHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 19:07:23 -0400
Received: from grey.apple.relay.mailchannels.net (grey.apple.relay.mailchannels.net [23.83.208.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857381B5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 16:07:20 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B2418360C65
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 23:07:19 +0000 (UTC)
Received: from pdx1-sub0-mail-a302.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 7122F360ABD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 23:07:19 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1698448039; a=rsa-sha256;
        cv=none;
        b=NHwauG2xkRvbCSyPVJmDRLHH18/KR//Aym3qttLH1GqZ6DHYEOEATZQF7JLLQUAqhdgISI
        HbyY2MOCqP5Ep0syyUICNkFbDUhj+IAc1l6OHC84vpqw57Zsl/8NXyOBiTKfZQkRrIJj58
        32kqzcSmqLeSwY7jaYafLBi3QzX2Eoto4XRwCINGp/0aVu4YZWU19KUpBKukkNdFabxkJO
        bYl/ug+JCY84pVJzFsRFWn7fPN0sQcEWoHgzAulCmH56WZEvOBUbG8xnHvpX6iUARIQaHT
        wTadbTXe6HOQ2uvEuyOaCxFPu1lWpRb+7w6+qXo1fBYbg/6z2HI9z+7a3BPhEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1698448039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=/DyY7cJmX/lnCs62zn85UwYPi+9hM1KZgV6+bEf+HzQ=;
        b=hTz+eZHfiGQffpJkpBEr5eH8y92zGKFqmJWKlSBfcepEOCaSVsQj5CXtQVpEUV6JB3kfSg
        mLr+9i4KY1RMQT7/MkSCtxsb/xuFXTjx7EB/ydbFWfWlvdne/5FaQbAmqibEOFULEWqW06
        L23/jCgaCqx0kgO/Wo26iVD0UV8jrxPVomJzytPgQrd4OUYvfWGWH8jJPo8h0InQnXpW/u
        jQp0wUwnjLkr71NV0Zn+15JN1rDhzu3rGDAEKFatya3jWtXqEm5oEuxWvCOP2+ICayIqFv
        spMsny26BaOZ2BvPe7QauMVEYY2nVs80NAN890Vp5KS9FImVzNbZd89q69qLhA==
ARC-Authentication-Results: i=1;
        rspamd-86646d89b6-w424t;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Trail-Illustrious: 7b41d0094dd9e724_1698448039587_1850199775
X-MC-Loop-Signature: 1698448039587:3194314346
X-MC-Ingress-Time: 1698448039587
Received: from pdx1-sub0-mail-a302.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.104.29.7 (trex/6.9.2);
        Fri, 27 Oct 2023 23:07:19 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a302.dreamhost.com (Postfix) with ESMTPSA id 4SHJGG5XwSz1Nf
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 16:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1698448038;
        bh=/DyY7cJmX/lnCs62zn85UwYPi+9hM1KZgV6+bEf+HzQ=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=RHzNmQMNckqIXhiaHJ/ZVH+xZ3+FEh16zJhTgaWwzjQd2acjWz35NTvVOcYnAo+oD
         vERPoOyOwdQM2MEqvJZ9Ez+MxBqNjohBb6+Q35o8xpXlxRYiI3/uRNL1PZ/R8V0HsR
         +vN6W7u3ViUAEuYJ37+WMDEDIhk6a0HyLdTjxvtLDIWDT97hnq6fSjWGMWbS9HHPis
         BMTGu/FAnWlzN9yo+AQYCD6D21+XnbchQKvNQPkvD/JAkKNegJEtaho8jyVQXc8V2j
         4Dl5+anURU3aQdroGqtsX3T0efGmnVp5xzlNHggMyusw4ElsY1k7LdCS0TzA2Ibc0A
         m6todDjWvMKwA==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e00e5
        by kmjvbox (DragonFly Mail Agent v0.12);
        Fri, 27 Oct 2023 16:06:34 -0700
Date:   Fri, 27 Oct 2023 16:06:34 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
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
Subject: Re: [PATCH 0/2] Triggering a softlockup panic during SMP boot
Message-ID: <20231027230634.GE2105@templeofstupid.com>
References: <cover.1698441495.git.kjlx@templeofstupid.com>
 <ZTw0CACF3jtT3/dX@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTw0CACF3jtT3/dX@bombadil.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 03:04:56PM -0700, Luis Chamberlain wrote:
> On Fri, Oct 27, 2023 at 02:46:26PM -0700, Krister Johansen wrote:
> > Hi,
> > This pair of patches was the result of an unsuccessful attempt to set
> > softlockup_panic before SMP boot.  The rationale for wanting to set this
> > parameter is that some of the VMs that my team runs will occasionally
> > get stuck while onlining the non-boot processors as part of SMP boot.
> > 
> > In the cases where this happens, we find out about it after the instance
> > successfully boots; however, the machines can get stuck for tens of
> > minutes at a time before finally completing onlining processors.  Since
> > we pay per minute for many of these VMs there were two goals for setting
> > this value on boot: first, fail fast and hope that a subsequent boot
> > attempt will be successful.  Second, a panic is a little easier to keep
> > track of, especially if we're scraping serial logs after the fact.  In
> > essence, the goal is to trigger the failure earlier and hopefully get
> > more useful information for further debugging the problem as well.
> > 
> > While testing to make sure that this value was getting correctly set on
> > boot, I ran into a pair of surprises.  First, when the softlockup_panic
> > parameter was migrated to a sysctl alias, it had the side effect of
> > setting the parameter value after SMP boot has occurred, when it used to
> > be set before this.  Second, testing revealed that even though the
> > aliases were being correctly processed, the kernel was reporting the
> > commandline arguments as unrecognized. This generated a message in the
> > logs about an unrecognized parameter (even though it was) and the
> > parameter was passed as an environment variable to init.
> > 
> > The first patch ensures that aliased sysctl arguments are not reported
> > as unrecognized boot arguments.
> > 
> > The second patch moves the setting of softlockup_panic earlier in boot,
> > where it can take effect before SMP boot beings.
> 
> Sounds all great but I only got the cover letter, so may be resend?

Apologies, I'm not sure quite what went wrong there.  I've resent the
patches to the people in the To: of the original messages, in an attempt
to avoid sending copies to everybody a second time.

The entire set seems to have made it to lore:

https://lore.kernel.org/linux-fsdevel/ZTw0CACF3jtT3%2FdX@bombadil.infradead.org/T/#r831972d73aad653c3b732e4e36e743cd53673847

If you still haven't got the copies, please let me know and I'll see
if there's something else I can do to get them to you.

Sorry about this. :/

-K
