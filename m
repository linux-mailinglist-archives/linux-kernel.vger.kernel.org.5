Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E297B499C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 22:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbjJAUsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 16:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbjJAUso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 16:48:44 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D125EBA
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 13:48:41 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9b64b98656bso377466b.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 13:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696193320; x=1696798120; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T5nwqgL0/UCkT25jpZLet8OWaUvSFwUq172hL3LVY/g=;
        b=Z/ycTf54sspzNV6Y5WhlLdbLbhjju4KkI07srcIUlV3V8IKiHIgvTelXFHjls+RCvL
         69oJeV2ySwAce3LrhDViRcVzcrnvYgPm+tBusSWOdN8K4ub/MDzupT8zgOsqjYCjtvoY
         B1EKkWQw+3v5knBGPGTkzb1cTyaDXFXZTj8sM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696193320; x=1696798120;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5nwqgL0/UCkT25jpZLet8OWaUvSFwUq172hL3LVY/g=;
        b=aXZ06wSbKbFX6Lqp73ReCsr/v/bA9BR19x3HdOVQ36W56xhFgRcS8WsVCCKy2TY9FW
         f8de0F4Q0Fw4UjJyhFjAmNBVgvK/fGyuSo974LiXwpl19Cub80UYVna4jnHQSTRHbOHh
         DUfZZs+Nf/lCNxALc9A2mn8j/qqEkl5MpiykyHMva8vfdJWPRLoIMKi2RsCbNGm1X4c8
         xatuWCzW0PvuY+RVHi8QYzzTGSCfOrq5EgxjWC3hcHIOaLff3eiDzitjCwzfrwJmJl/Q
         I2lc1MxKcipIhI1XzbtrAFSIW236lrDnIMdeaNRVfKRPWT4Cxrs+aeEOPjiiRX4/5slx
         nabA==
X-Gm-Message-State: AOJu0YwqhUmuL90KGV5giYC41NyjjRIwvcm4bPJQ2Oy7Tnnam/PAGWxQ
        Hy/uJ7nqbQkShnDruWdcaQAGnCRUiVlpe5+zgis0kaWf
X-Google-Smtp-Source: AGHT+IFIFnemMLyNUTRbGIfV8qtB5J3U9ArQi755uEZrwHVuet+1A3PP9joAP/r6k9pqNf2ZOlUl5A==
X-Received: by 2002:a17:907:760f:b0:9b2:b633:ada2 with SMTP id jx15-20020a170907760f00b009b2b633ada2mr8598633ejc.36.1696193320243;
        Sun, 01 Oct 2023 13:48:40 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id lw3-20020a170906bcc300b009ae0042e48bsm15836568ejb.5.2023.10.01.13.48.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 13:48:39 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-307d58b3efbso13851704f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 13:48:38 -0700 (PDT)
X-Received: by 2002:a5d:67c4:0:b0:31f:f94f:e13f with SMTP id
 n4-20020a5d67c4000000b0031ff94fe13fmr8989234wrw.19.1696193318578; Sun, 01 Oct
 2023 13:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjrZgxjHZuXwrGeFnng_whUmtToCWE5GQ+HORhGSeiX8g@mail.gmail.com>
 <ZRhKq6e5nF/4ZIV1@fedora> <CAB=+i9QiJ=BXkQuCFJTh3dMXrkKQvVA2EM51Mj6SsDMimWQ71g@mail.gmail.com>
In-Reply-To: <CAB=+i9QiJ=BXkQuCFJTh3dMXrkKQvVA2EM51Mj6SsDMimWQ71g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 1 Oct 2023 13:48:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whosoBSLAWzSGUZ8s=UwAVG9rsQ9OVPvw97S2RRFGfk2A@mail.gmail.com>
Message-ID: <CAHk-=whosoBSLAWzSGUZ8s=UwAVG9rsQ9OVPvw97S2RRFGfk2A@mail.gmail.com>
Subject: Re: Linux 6.6-rc3 (DEBUG_VIRTUAL is unhappy on x86)
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Kaplan <David.Kaplan@amd.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Oct 2023 at 07:17, Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> >
> > > Peter Zijlstra (1):
> > >       x86,static_call: Fix static-call vs return-thunk
> >
> > Hello, the commit above caused a crash on x86 kernel with
> > CONFIG_DEBUG_VIRTUAL=y.
>
> OK, I looked into this a little bit, and it turns out that the problematic
> address here is from cleanup_trusted() in
> security/keys/trusted-keys/trusted_core.c.
> (and it's builtin due to CONFIG_TRUSTED_KEYS=y)
>
> The function is marked as __exit, so it does not fall within the
> 'core kernel text address range,' which is between _stext and _etext
> (or between _sinittext and _einittext). and thus __text_poke() thinks that
> it's vmalloc/module area.
>
> I think __text_poke() should be taught that functions marked as __exit
> also belong to kernel code just like __init.

I think your patch is fine (well, whitespace-damaged, but conceptually good).

But I also wonder about that

        static_call_cond(trusted_key_exit)();

in cleanup_trusted(). It seems all kinds of pointless to use static
calls for something that is done *once*. That's not an optimization,
that's honestly just _stupid_. It costs more to do the rewriting that
it does to just do the one dynamic indirect call.

Side note: the same is true of the init-time call, which does

                static_call_update(trusted_key_init,
                                   trusted_key_sources[i].ops->init);
                ...
                ret = static_call(trusted_key_init)();

which again is a *lot* more expensive than just doing the indirect
function call.

So while I don't think your patch is wrong, I do think that the cause
here is plain silly code, and that trusted key code simply should not
do the crazy thing it does (and that causes silly problems).

               Linus
