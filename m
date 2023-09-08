Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D925D7992C4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 01:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345161AbjIHXVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 19:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345155AbjIHXVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 19:21:08 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A416C18E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 16:21:04 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-26f49ad3b86so3423779a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 16:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694215264; x=1694820064; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4xItMDPGhESXDV62IMzztD/fCCrvJU426iFvnJNHE0=;
        b=AyBQCJdqRo3+WnFfncj95nZmWiaRBdFC+Co1Upspk/g+eC/XdMxtBxcCDLlc4JhZFf
         QuXDDSJFUHVCDhKUACPnNgCa10CeHS5mtPutN05mCvQwI+BpAHXvMr2BVwhQ8NMsKSr6
         7vv+BEvvAvQN6jOsyOCz+BggkPYKiEDmBeG3hwcMxIDHVvYBuoDv83gNOoy0xX4/NhRw
         f5S29j9u9qoBDiM2oWF9x/HH88CjSYl/22GYu2PPiutjhYvZvY7GmrQgJ3JhCBohciI6
         2p2x3ERXAINtD3dkHMWoi52pBFKZ7foJR70wfa0Yw/LyDWUGUibF7MLGpf8JArX3KpOv
         Hm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694215264; x=1694820064;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4xItMDPGhESXDV62IMzztD/fCCrvJU426iFvnJNHE0=;
        b=T73vXulu/UaNRKf28/CJKGs3VevvJ4/A/V/n7fuDUW2MZFDLpdDgyvQQHkmSyxhITs
         YlY54QdXeyu5jPR0AZDn5RJ13gneD0IfuhCoKUJ3IbfjK4iDYV+eCfiKPd+NmH03dFd7
         TwrIfM6XwhGQsZVOtatbkLVoSxqZaDUZAizXoKZ6+3OCJgVQmujVWi5u+OLlPo9k6XG2
         G7w7hRSwCD3UXZnJ6QrkVH0XJ8/fAfZXNz35wi9RPgpko3fQLzzjPlPBHBOaDlKUBFVu
         pVZecCJimaMe0Jr2AwglKw2J5+FU2BFY6L2F/je5pyaSEUNTiBHqXyLhfMQrqN+kFLSM
         /NZg==
X-Gm-Message-State: AOJu0Yz0J0fLzuyOc2vLTrGIbN12ee6lHdPfrSKWO4HtI2cZMM4SpVds
        uQfkXQmJkzYwDNvuNlhiBufu8XPEa28=
X-Google-Smtp-Source: AGHT+IFE29B61dYuVGgDcCzRdTE92sPgyGY4OZA3lF+ePPYMCJhBGsToMJI0H0PYnq8jSzPgW010WXJkLlc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:dc82:b0:26d:2126:aa49 with SMTP id
 j2-20020a17090adc8200b0026d2126aa49mr994341pjv.2.1694215264138; Fri, 08 Sep
 2023 16:21:04 -0700 (PDT)
Date:   Fri, 8 Sep 2023 16:21:02 -0700
In-Reply-To: <170e3110-e4c6-8060-3238-d2296b4f0d88@rasmusvillemoes.dk>
Mime-Version: 1.0
References: <20230804120536.2339722-1-linux@rasmusvillemoes.dk>
 <ZPtlxmdIJXOe0sEy@google.com> <170e3110-e4c6-8060-3238-d2296b4f0d88@rasmusvillemoes.dk>
Message-ID: <ZPusXvZwduHfxNnC@google.com>
Subject: Re: [PATCH v2] scripts/setlocalversion: also consider annotated tags
 of the form vx.y.z-${file_localversion}
From:   Sean Christopherson <seanjc@google.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2023, Rasmus Villemoes wrote:
> On 08/09/2023 20.19, Sean Christopherson wrote:
> > On Fri, Aug 04, 2023, Rasmus Villemoes wrote:
> >> obviously asks if $tag is an annotated tag, but it does not actually
> >> tell if the commit pointed to has any relation to HEAD. So remove both
> >> uses of --exact-match, and instead just ask if the description
> >> generated is identical to the tag we provided. Since we then already
> >> have the result of
> >>
> >>   git describe --match=$tag
> >>
> >> we also end up reducing the number of times we invoke "git describe".
> > 
> > Dropping "--exact-match" is resulting in unnacceptable latencies for me.  I don't
> > understand what this is trying to do well enough to make a suggestion, but something
> > has to change.
> 
> Hm, that's quite unexpected. I mean, before that commit, I think that
> setlocalversion, especially when run on some dev branch, would _also_
> end up doing at least one 'git describe --match=v6.5'. <goes digging>
> 
> Ah, so I assume that in your case you always end up in the
> 
>                 # If only the short version is requested, don't bother
>                 # running further git commands
>                 if $short; then
>                         echo "+"
>                         return
>                 fi
> 
> case, i.e. you do not have CONFIG_LOCALVERSION_AUTO=y. Can you confirm that?

Yep, the configs I build most frequently have CONFIG_LOCALVERSION_AUTO=n, and
I can induce the bad behavior before this patch by toggling that on.

> > E.g. on my build box, a single `git describe --match=v6.5` takes ~8.5 seconds,
> 
> That's a long time indeed. I don't really know why it can take that long.

I can't figure that either.  It's not always slow, just almost always slow.  I
assume it has something to do with the number of commits/objects/merges git has
to trawl through, but I don't fully understand the behavior.

E.g. if I do `git describe --match=v6.5-rc2` on a branch based on v6.5-rc2, it's
basically instant.  But if take that same branch and merge it on top of v6.5,
`git describe --match=v6.5` takes 8.5 seconds even though the number of delta
commits is only one higher.

> > whereas a complete from-scratch kernel build takes <30 seconds, and an incremental
> > build takes <2 seconds.  When build testing to-be-applied changes, I compile each
> > commit ~15 times (different x86 configs plus one for each other KVM architecture),
> > which makes the ~8.5 second delay beyond painful.
> 
> Sorry about that. I agree something needs to be done, but the commit
> above fixed a real problem with -rt kernels, and the refactoring just
> made it much easier to follow the logic IMO - and, for the
> CONFIG_LOCALVERSION_AUTO=y case, did reduce the number of times git
> describe gets invoked.
> 
> Until I have a bit more time to think, could you try setting the env var
> LOCALVERSION when building - it can be set to anything, including empty.
> Then if I'm reading the script right, the scm_version() function won't
> be called at all.

Nice!  That does the trick.  Adding a useful LOCALVERSION is trivially easy for
all my builds, and as a bonus it's useful info for my test kernels.

So unless other people complain, I'm totally ok to leave this alone and not spend
any more time on it.

Thanks much!
