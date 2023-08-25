Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07952787FF6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237839AbjHYGdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241759AbjHYGdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:33:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E922AE6A;
        Thu, 24 Aug 2023 23:32:56 -0700 (PDT)
Received: from nazgul.tnic (unknown [78.130.214.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 091B91EC0338;
        Fri, 25 Aug 2023 08:32:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1692945170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1ajED1oD5nx23UIrWBju+LJ3AxllDZix/z+nQpHOySo=;
        b=jBoBW/bxYaFOppDjDyBZRyTM+dZL8mr7BKdoMHDCrK4md/lR8a85xGoNRA2Iszh2LF+Cyh
        HjJbMBf1i05SQIMrcfKyLWaSPgfFYf+snvvDOgVcmLTL0WLQdHJrgQ7tPqXu4TwkwpwuPC
        V+3AkVpF42vpeoj53h+QUS6zcdrDx34=
Date:   Fri, 25 Aug 2023 08:33:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, keescook@chromium.org,
        elver@google.com, dvyukov@google.com, glider@google.com
Subject: Re: [BUG] missing return thunk: __ret+0x5/0x7e-__ret+0x0/0x7e: e9 f6
 ff ff ff
Message-ID: <20230825063302.GBZOhLHgdvhIw1d6f1@fat_crate.local>
References: <4dc3d0ec-b827-4bce-8927-cfa5d837fd03@paulmck-laptop>
 <20230816181720.GNZN0SsKi/B4eCsZHu@fat_crate.local>
 <2023082458-vividness-habitable-cbc8@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023082458-vividness-habitable-cbc8@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 03:52:56PM +0200, Greg KH wrote:
> On Wed, Aug 16, 2023 at 08:17:20PM +0200, Borislav Petkov wrote:
> > Hey Paul,
> > 
> > On Wed, Aug 16, 2023 at 10:54:09AM -0700, Paul E. McKenney wrote:
> > > I hit the splat at the end of this message in recent mainline, and has
> > > appeared some time since v6.5-rc1.  Should I be worried?
> > 
> > does it go away if you try the latest tip:x86/urgent branch?
> 
> Note, this problem is showing up in the 6.1.y branch right now, due to
> one objtool patch not being able to be backported there easily (i.e. I
> tried and gave up.)
> 
> 4ae68b26c3ab ("objtool/x86: Fix SRSO mess") being the commit that I
> can't seem to get to work properly, my attempt can be seen here:
> 	https://lore.kernel.org/r/2023082212-pregnant-lizard-80e0@gregkh
> 
> Just a heads up as this will start to affect users of the next 6.1.y
> release, and probably older releases, as they are taking portions of the
> "fixes for fixes" but not the above mentioned one.

Hmm, Peter and I are away, I guess maybe Josh might have an idea how and
what to backport to 6.1 to get this sorted out...

CCed.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
