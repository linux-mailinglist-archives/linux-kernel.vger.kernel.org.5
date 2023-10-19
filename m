Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491407CF90A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345636AbjJSMeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbjJSMeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:34:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BDC91
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:34:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 149331FD92;
        Thu, 19 Oct 2023 12:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1697718860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d1XD8Tivgfs/V20KsBORb03NdjwK0xhM0XL0CwsOTek=;
        b=zwqJQti2VvTxULYrqmG531tX/9ER3RdTKp60QJhyO+3jP9OiXNyIfRuvXrjKReOjQnZnXz
        rnby8/+p84eLfiGYz1dwJo3vOKFRiuy9sgU1MdlYV5jE6eh9i5QN4bIonRrhK0bIQFoW0J
        rqpswvpbTjhB7DztQgFpqxFBEmyQQwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1697718860;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d1XD8Tivgfs/V20KsBORb03NdjwK0xhM0XL0CwsOTek=;
        b=CmC3i6I7uxX/5ZHlKg1/pp05QqRZEnK5vgT1Yb+V408F3bvAEYFN5cbM/h0renJVa8Tbg3
        47a7TGIEsSdKIwBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEE311357F;
        Thu, 19 Oct 2023 12:34:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3XFCOEsiMWUhQgAAMHmgww
        (envelope-from <aporta@suse.de>); Thu, 19 Oct 2023 12:34:19 +0000
Date:   Thu, 19 Oct 2023 14:34:19 +0200
From:   Andrea della Porta <aporta@suse.de>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Andrea della Porta <andrea.porta@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nik.borisov@suse.com
Subject: Re: [PATCH 0/4] arm64: Make Aarch32 compatibility enablement
 optional at boot
Message-ID: <ZTEiS1G8rpvM5eAF@apocalypse>
Mail-Followup-To: Mark Rutland <mark.rutland@arm.com>,
        Andrea della Porta <andrea.porta@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, nik.borisov@suse.com
References: <cover.1697614386.git.andrea.porta@suse.com>
 <ZS_U9pqhLJ83h5Ig@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS_U9pqhLJ83h5Ig@FVFF77S0Q05N.cambridge.arm.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -10.60
X-Spamd-Result: default: False [-10.60 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[7];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:52 Wed 18 Oct     , Mark Rutland wrote:
> On Wed, Oct 18, 2023 at 01:13:18PM +0200, Andrea della Porta wrote:
> > Aarch32 compatibility mode is enabled at compile time through
> > CONFIG_COMPAT Kconfig option. This patchset lets 32-bit support
> > (for both processes and syscalls) be enabled at boot time using
> > a kernel parameter. Also, it provides a mean for distributions 
> > to set their own default without sacrificing compatibility support,
> > that is users can override default behaviour through the kernel
> > parameter.
> 
> Can you elaborate on *why* people want such a policy?
> 

Formerly, the reason was to reduce kernel attack surface by excluding
compat syscall, wherever applicable. Much less important but still a point,
I would also say this could be a good chance to get rid of somewhat old
and stale 32-bit libraries and programs, but this is of course debatable.

> > *** Notes about syscall management ***
> > VBAR_EL1 register, which holds the exception table address,
> > is setup very early in the boot process, before parse_early_param().
> > This means that it's not possible to access boot parameter before
> > setting the register. Also, setting the aforementioned register
> > for secondary cpus is done later in the boot flow.
> > Several ways to work around this has been considered, among which:
> > 
> > * resetting VBAR_EL1 to point to one of two vector tables (the
> >   former with 32-bit exceptions handler enabled and the latter
> >   pointing to unhandled stub, just as if CONFIG_COMPAT is enabled)
> >   depending on the proposed boot parameter. This has the disadvantage
> >   to produce a somewhat messy patchset involving several lines,
> >   has higher cognitive load since there are at least three places
> >   where the register is getting changed (not near to each other),
> >   and have implications on other code segments (namely kpti, kvm
> >   and vdso), requiring special care.
> > 
> > * patching the vector table contents once the early param is available.
> >   This has most of the implications of the previous option
> >   (except maybe not impacting other code segments), plus it sounds
> >   a little 'hackish'.
> > 
> > The chosen approach involves conditional executing 32-bit syscalls
> > depending on the parameter value.
> 
> Why does the compat syscall path need to do anything?

I probably didn't catch your point here, compat syscall does not need to do
anything and they do not (just like they works right now with CONFIG_COMPAT
alone), except for the conditional instruction that excludes them at runtime.
Of course this conditional *is* doing something and somewhat redundant if
compat is disabled, but in this scenario I think it's unavoidable.

> 
> On arm64 it's not possible to issue compat syscalls from a native 64-bit task.
> If you prevent the loading of AArch32 binaries, none of the compat syscalls
> will be reachable at all.
> 
> That's the proper way to implement this, and we already have logic for that as
> part of the mismatched AArch32 support.
> 
> > This of course results in a little performance loss, but has the following
> > advantages:
> 
> A performance loss for what relative to what?

of a compat syscall as it is now enabling CONFIG_COMPAT vs the patched
syscall handlers that need a further conditional instruction to check
whether comapt is enabled or not.

> 
> How much of a performance loss?

I did not take measurement yet since it was just a qualitative consideration
more than a quantitative one, also considering that chances are that it would
affect just very little population. The conditional instruction time taken
to execute is reasonably near to negligible if compared to any syscall execution.
