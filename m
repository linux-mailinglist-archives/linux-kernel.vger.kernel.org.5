Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D61A7892E5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 03:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjHZBLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 21:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjHZBLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 21:11:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7868198D;
        Fri, 25 Aug 2023 18:11:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42A1060C2B;
        Sat, 26 Aug 2023 01:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD5AC433CA;
        Sat, 26 Aug 2023 01:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693012269;
        bh=sr6TWPi1+0ni0dfdaA8biToHHsWF8rj3UNXFTjdgQqg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LFDuGJjdIJ05NeHkxqUWFOBvXW5vfKHFG3nCWEGaDSJKuNuDHiTZVHyI3nJOs3kZi
         MBymhL0e76l5oxResaBN688i87N2sZR31vFKUiLPZENBBR4NnooticvOZMsphn+seX
         pFU6DW4EMgp8HS4zjgw09QlVs7KfHNC0ypdrLr4OOGudbtXCrPXXE4oxnm8KkTfHGE
         HLNYOCROsOxfZuWsn7XC4FiNAGpVXqYecoooCCvT0OMj4DQMyBm5h3dbA2WEP+BhFN
         PLLg7dr20qMnDxW7+qSpyuU2a0IUxfMEakXCIwrNvBh08w/uDgAj19/AV2ULmHct4/
         2LbqOWIcTQbjw==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6bcac140aaaso1060480a34.2;
        Fri, 25 Aug 2023 18:11:09 -0700 (PDT)
X-Gm-Message-State: AOJu0YwOVepTJOqqhv/fIrOB8VsY6YcbMGVdj8JuC59waUMR73vzJNfl
        YALTvLOxmovIjpSnIkXpLHSokSZ0JU82XJs6qhQ=
X-Google-Smtp-Source: AGHT+IEoIxtEB6Zq+I8FOWyQEt255F1KHwGBLkNXDHI/c2eNT3AbfB0sYCmMMnw6x7WPre66TNyCp7vg0c/Op/toQGk=
X-Received: by 2002:a05:6870:d60c:b0:1ba:caf2:acc3 with SMTP id
 a12-20020a056870d60c00b001bacaf2acc3mr4384026oaq.5.1693012268806; Fri, 25 Aug
 2023 18:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230817012007.131868-1-senozhatsky@chromium.org>
 <CAK7LNASJWKSsdzn5ccgWaC35-XvHGU7pnE6C=eZFDbqrrghtdQ@mail.gmail.com>
 <20230820024519.GK907732@google.com> <CAK7LNAS9KC1GjPgadMEivSpy4TMYU8mQ+BrtfJpNs2kvhK18yA@mail.gmail.com>
 <20230820072119.GM907732@google.com> <20230820073332.GN907732@google.com>
 <CAK7LNARTZXvWD8PrA3bC+Ok7LK85qO=pkMs4kOPGn90OBooL6w@mail.gmail.com>
 <20230822061203.GA610023@google.com> <CAK7LNAS0qEZk+xAq84=7SuJSQz5F3dNBjYKPoeKTd_caq-QMKg@mail.gmail.com>
 <CAAFQd5DeDEhPUQScXB67v9giiV=G33L-YDdtF4e-+UcmBXG6jA@mail.gmail.com>
In-Reply-To: <CAAFQd5DeDEhPUQScXB67v9giiV=G33L-YDdtF4e-+UcmBXG6jA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 26 Aug 2023 10:10:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNATj-jnOLMkgzz=3MfqWgUjKF-MwSKQkr4hW0g7+tEsXUw@mail.gmail.com>
Message-ID: <CAK7LNATj-jnOLMkgzz=3MfqWgUjKF-MwSKQkr4hW0g7+tEsXUw@mail.gmail.com>
Subject: Re: [RFC][PATCH] kconfig: introduce listunknownconfig
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ying Sun <sunying@nj.iscas.ac.cn>,
        Jesse T <mr.bossman075@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 2:30=E2=80=AFPM Tomasz Figa <tfiga@chromium.org> wr=
ote:
>
> Hi Masahiro,
>
> On Thu, Aug 24, 2023 at 10:00=E2=80=AFAM Masahiro Yamada <masahiroy@kerne=
l.org> wrote:
> >
> > On Tue, Aug 22, 2023 at 4:30=E2=80=AFPM Sergey Senozhatsky
> > <senozhatsky@chromium.org> wrote:
> > >
> > > On (23/08/21 21:27), Masahiro Yamada wrote:
> > > >
> > > > My (original) hope was to add a single switch, KCONFIG_VERBOSE, to =
address both:
> > > >
> > > >   - A CONFIG option is hidden by unmet dependency (Ying Sun's case)
> > > >   - A CONFIG option no longer exists  (your case)
> > > >   - Anything else we need to be careful
> > >
> > > A quick question: is it too late to suggest an alternative name?
> > > Could KCONFIG_SANITY_CHECKS be a little cleaner? Because we basically
> > > run sanity checks on the config.
> >
> >
> > Ying's is not applied yet. So, it is not too late.
> >
> > But, I started to be a little worried
> > because it is unpredictable how many KCONFIG_* env
> > variables will increase until people are satisfied.
> >
>
> Is there really a problem with having those? There are a lot of
> different env variables affecting different parts of the kernel build.
> If they are useful, and even better, allow catching issues quickly,
> should we favor less options or usefulness for users?



I am considering how to implement it.



One way is to add env variables as a new request arises.

Sergey is doing two things by one option.


   KCONFIG_WARN_UNKNWON_SYMBOL : warn unknown symbol in input .config
or defconfig
   KCONFIG_WARN_TO_ERROR       : turn warnings into errors



Another way is to handle those as command line options.

  -Wunknown-symbol
  -Werror             (associated with W=3De)
  -Wall               (associated with W=3D1)



  $ make W=3D1e olddefconfig


will work to sanity check.





> > >
> > > And one more question: those sanity checks seem very reasonable.
> > > Is there any reason we would not want to keep them ON by default?
> > > And those brave souls, that do not wish for the tool to very that
> > > the .config is sane and nothing will get downgraded/disabled, can
> > > always set KCONFIG_SANITY_CHECKS to 0.
> >
> >
> > Kconfig is meant to resolve the dependency without causing an error.
> > If a feature is not available, it is automatically, silently hidden,
> > and that works well.
>
> How do you come to the conclusion that it works well? I've heard many
> people unhappy about the way Kconfig works. How does one know that
> something is missing (and should maybe be fixed?) if Kconfig silently
> hides it?


Kconfig has worked like that for a long time, but I do not know
how to detect non-existing symbols.




>
> >
> > When a compiler does not support a particular feature,
> > 'depends on $(cc-option )' hides that CONFIG option.
> > Kconfig is meant to work like that.
> >
> >
> >
> > For your case, it is case-by-case.
> >
> > Let's say a stale code is removed from upstream.
> >
> > After "obj-$(CONFIG_FOO) +=3D foo.o" is removed
> > from upstream, CONFIG_FOO in the .config is a "don't care".
> >
> > If it were an error, all arch/*/configs/*_defconfig
> > must be cleaned up at the same time.
> >
>
> I'd argue that clean up should actually happen. An identically named
> option could be added in the future again and mean something different
> and would end up accidentally selected by those old defconfigs.


For renaming, I agree with you.
All defconfig files should be updated to keep the equivalent behavior.

For code removal, defconfig cleaning can be deferred because
that would possibly cause conflicts across subsystems.

Reusing the same CONFIG name for different meaning must be
sorted out properly but that rarely happens, I guess.



> >
> > So, sometimes it is helpful, but sometimes noisy.
> >
> >
> >
> >
> > For the MFD_RK808 case particularly,
> > I believe Kconfig showed MFD_RK8XX_I2C
> > as a new option.
>
> Among tens or hundreds of other new options. Good luck making sure
> that you didn't miss it.
>
> >
> > Or, when you bumped to a new kernel version,
> > you could run 'make listnewconfig'.
> > (See 17baab68d337a0bf4654091e2b4cd67c3fdb44d8.
> > Redhat says they review every new config option.)
> >
>
> What is the listnewconfig supposed to show?


Documented in Documentation/kbuild/kconfig.rst
line 16 - 34.


>
> Regardless of that, shouldn't we strive to automate things rather than
> just put people at those and wasting the time they could spend on
> something more productive?
>
> >
> > If you had done a per-config review
> > you would have noticed
> > c20e8c5b1203af3726561ee5649b147194e0618e
> > before spending time on run-time debugging.
> >
>
> Instead, I'd have spent time on researching every single new Kconfig
> option just to realize that I don't care about it, except the single
> one that I needed. In fact, it wouldn't have even guaranteed tracking
> down the problem, because I don't necessarily have to know all the
> config options that are necessary for my board - how do you associate
> some MFD driver Kconfig option with an SD/MMC controller not working?





--
Best Regards
Masahiro Yamada
