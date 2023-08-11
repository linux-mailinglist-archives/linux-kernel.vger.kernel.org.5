Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AD1779578
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbjHKRAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjHKRAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:00:44 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D41C1FE3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:00:43 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-645181e1eaeso1326756d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691773242; x=1692378042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GN81mlwYORFhRTj6FOyt7GA2JW9k6WvS+ZcHfHG55ZQ=;
        b=4Ucv5w+pgHCsJN7X0yDEqftTBvBbegL+J4X2ZswadjcTqyicPHXACxnYZ7zOOyVouH
         OI4kyeRDAS7mxqfFE4+Q8C5HWz6TC6vAboTXjOjcC1RVhSB9I3+G2fSr2pHqhT3ShlmL
         N+VDQe7i0ik0wAQRBFY+fH51bwwdsKs71/bdMs/TaK+A+PRZWL/0N5t5JqqoNdfcBJAC
         SWqbDV4x/7HX8aqSdv7Cr6F6mEmXTFrrHDP4rkyAHnxAqIx1p6y89nOeZRXKqpP87B08
         Ve/0ppIQGoaNYrrb10aAk0e1PnlQDu+0M+Vm5fOOyiua+3fBLHNPxZCMWQCkjg8gpu5j
         eHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691773242; x=1692378042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GN81mlwYORFhRTj6FOyt7GA2JW9k6WvS+ZcHfHG55ZQ=;
        b=Z41nO6obEUeR419a0xKIL7DFsVCI82yz3Vf4aOv4sZx8Gu04nmzLPqFbQcT+iMAJBx
         mqCvKlqAgYbQzBivU3CG+OSwWmdRbjcI2/pPP7FCu1VCthKS9cLpCGGuefcREV+dcwPh
         zQJhFFnrGez+zIBkixDwH44v+GlQ3YRVOpv7Q2CFyemRE5lurcrrqIWeZriYRwUx6GFm
         ML4qceIcuIKVPP1/OkyqZAsCpdb8NVp01X4bahT0RzWDzXeKjMAfLxFZeGGg3jvj1Jfa
         KgRo34os3E+gvi2M2HBsM5A8q3yQIhw0Qk4gy7HX+HdrSpScPEhaxS24wrF7znBD17NE
         H1bw==
X-Gm-Message-State: AOJu0YzHxZ/8fWuygBxVjRvBG6oWomVhY28dsNctt66LRSSiDwrXhxRF
        rWK78l2uDMPhf9vcayW/QQypCYfX+zNazib2ud8V1A==
X-Google-Smtp-Source: AGHT+IEXXJuh8qCFeO3ZEW8PXwnEfitvzZ1EAizSAG56mLXGKE2nEdahC0tn0PZVxqW4qid29vQjPe23hUcyjCez7tc=
X-Received: by 2002:a0c:f1d3:0:b0:63d:6755:d1cb with SMTP id
 u19-20020a0cf1d3000000b0063d6755d1cbmr2161510qvl.16.1691773242229; Fri, 11
 Aug 2023 10:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230809071218.000335006@infradead.org> <20230809072200.543939260@infradead.org>
 <20230810115148.GEZNTPVLBmPL6uz4Af@fat_crate.local> <20230810123756.GY212435@hirez.programming.kicks-ass.net>
 <20230811070123.GD220434@hirez.programming.kicks-ass.net>
In-Reply-To: <20230811070123.GD220434@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 11 Aug 2023 10:00:31 -0700
Message-ID: <CAKwvOd=UXhDShdPsofrWScxdF-mTNnDTCNYZDP1rAhhKCB7jVA@mail.gmail.com>
Subject: Re: [RFC][PATCH 02/17] x86/cpu: Clean up SRSO return thunk mess
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, matz@suse.de, joao.moreira@intel.com,
        samitolvanen@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:01=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Thu, Aug 10, 2023 at 02:37:56PM +0200, Peter Zijlstra wrote:
>
> > After this patch things look equivalent to:
> >
> > SYM_FUNC_START(foo)
> >       ...
> >       ALTERNATIVE "ret; int3"
> >                   "jmp __x86_return_thunk", X86_FEATURE_RETHUNK
> >                   "jmp srso_return_thunk, X86_FEATURE_SRSO
> >                   "jmp srsi_alias_return_thunk", X86_FEATURE_SRSO_ALIAS
> > SYM_FUNC_END(foo)
> >
> > SYM_CODE_START(srso_return_thunk)
> >       UNWIND_HINT_FUNC
> >       ANNOTATE_NOENDBR
> >       call srso_safe_ret;
> >       ud2
> > SYM_CODE_END(srso_return_thunk)
> >
> > SYM_CODE_START(srso_alias_return_thunk)
> >       UNWIND_HINT_FUNC
> >       ANNOTATE_NOENDBR
> >       call srso_alias_safe_ret;
> >       ud2
> > SYM_CODE_END(srso_alias_return_thunk)
> >
>
> So it looks like the compilers are still not emitting int3 after jmp,
> even with the SLS options enabled :/
>
> This means the tail end of functions compiled with:
>
>   -mharden-sls=3Dall -mfunction-return=3Dthunk-extern
>
> Is still a regular: jmp __x86_return_thunk, no trailing trap.
>
>   https://godbolt.org/z/Ecqv76YbE

I don't have time to finish this today, but
https://reviews.llvm.org/D157734 should do what you're looking for, I
think.

>
> If we all could please finally fix that, then I can rewrite the above to
> effectively be:
>
> SYM_FUNC_START(foo)
>         ...
>         ALTERNATIVE "ret; int3"
>                     "jmp __x86_return_thunk", X86_FEATURE_RETHUNK
>                     "call srso_safe_ret, X86_FEATURE_SRSO
>                     "call srso_alias_safe_ret", X86_FEATURE_SRSO_ALIAS
>         int3 //  <--- *MISSING*
> SYM_FUNC_END(foo)
>
> Bonus points if I can compile time tell if a compiler DTRT, feature flag
> or what have you in the preprocessor would be awesome.

Probably not a preprocessor token; in the past I have made that
suggestion and the old guard informed me "no, too many preprocessor
tokens to lex, no more!"  I still disagree but that is a viewpoint I
can sympathize with, slightly.

Probably version checks for now on the SLS config (or version checks
on a new kconfig CONFIG_IMPROVED_SLS)

--=20
Thanks,
~Nick Desaulniers
