Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C948278F049
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242522AbjHaP24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjHaP2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:28:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6115CE4C;
        Thu, 31 Aug 2023 08:28:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BE96B8233A;
        Thu, 31 Aug 2023 15:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA20C433CD;
        Thu, 31 Aug 2023 15:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693495728;
        bh=S2JxCj+utsus7xUsAEYU9GApDgIxA0EMvwHxFuJAiQU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jk0IdTS2wLC9qkCP1fTeA9bx/huMU0IAykKLg48GjDyuA2JeSYrvdbOx2CbuH05Zs
         YIU396fiRdo3g8lnWTflw5kxtJZfAmhySiPdAJoZxXUkqZPpX85BF7i4ejt0Oyf/T8
         TWZzf2CF9dXUZrKmi6PPM49k1wmAPTxt99jKsPlFTfRjgdDNTo8FAQ2AkbdjYkV5UX
         cMOychn9KEij1GIQqc0BYIcEUGOaS+fYpMZQzVR3pV2l4GS9lpdNQX0c4EbIDgvYgu
         OBSiHqRAQGstbLelSPtHE+mjZaG0GbcR9wz8Yq3iUTXHv5rlj/OcWpEpri0v0ynbcj
         FSuyhLxI3SStw==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1c4cf775a14so520615fac.3;
        Thu, 31 Aug 2023 08:28:48 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx4zSizwmhug+XIDCXxNMDEpLa7cHf9xG0Ab9WkpwM+ZCpElb9e
        xA7YFLTVxbeQt0c2/ng3k/2rZnPvTxp0XhZ0hXg=
X-Google-Smtp-Source: AGHT+IFCiyR2gGxBqm1Lw/zYcW02ESnV4aEiiYEIvUoA7RtX3mNANDsc/ssaTIH99t7jiPNPGODPP18q5Ci4SbTLkos=
X-Received: by 2002:a05:6870:c108:b0:1bf:5559:4aaf with SMTP id
 f8-20020a056870c10800b001bf55594aafmr6163401oad.34.1693495727936; Thu, 31 Aug
 2023 08:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230817012007.131868-1-senozhatsky@chromium.org>
 <CAK7LNASJWKSsdzn5ccgWaC35-XvHGU7pnE6C=eZFDbqrrghtdQ@mail.gmail.com>
 <20230820024519.GK907732@google.com> <CAK7LNAS9KC1GjPgadMEivSpy4TMYU8mQ+BrtfJpNs2kvhK18yA@mail.gmail.com>
 <20230820072119.GM907732@google.com> <20230820073332.GN907732@google.com>
 <CAK7LNARTZXvWD8PrA3bC+Ok7LK85qO=pkMs4kOPGn90OBooL6w@mail.gmail.com>
 <20230822061203.GA610023@google.com> <CAK7LNAS0qEZk+xAq84=7SuJSQz5F3dNBjYKPoeKTd_caq-QMKg@mail.gmail.com>
 <CAAFQd5DeDEhPUQScXB67v9giiV=G33L-YDdtF4e-+UcmBXG6jA@mail.gmail.com>
 <CAK7LNATj-jnOLMkgzz=3MfqWgUjKF-MwSKQkr4hW0g7+tEsXUw@mail.gmail.com> <CAAFQd5AhN5m8eaGsrKfh1gHPLiOVd9_3BwoHpr7u6iY92Ft-bg@mail.gmail.com>
In-Reply-To: <CAAFQd5AhN5m8eaGsrKfh1gHPLiOVd9_3BwoHpr7u6iY92Ft-bg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 1 Sep 2023 00:28:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR6o=K=eGzi194Ly787Ji4Twfqq3dcr8NE5m23ayGM3Fg@mail.gmail.com>
Message-ID: <CAK7LNAR6o=K=eGzi194Ly787Ji4Twfqq3dcr8NE5m23ayGM3Fg@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 11:30=E2=80=AFAM Tomasz Figa <tfiga@chromium.org> w=
rote:
>
> On Sat, Aug 26, 2023 at 10:11=E2=80=AFAM Masahiro Yamada <masahiroy@kerne=
l.org> wrote:
> >
> > On Thu, Aug 24, 2023 at 2:30=E2=80=AFPM Tomasz Figa <tfiga@chromium.org=
> wrote:
> > >
> > > Hi Masahiro,
> > >
> > > On Thu, Aug 24, 2023 at 10:00=E2=80=AFAM Masahiro Yamada <masahiroy@k=
ernel.org> wrote:
> > > >
> > > > On Tue, Aug 22, 2023 at 4:30=E2=80=AFPM Sergey Senozhatsky
> > > > <senozhatsky@chromium.org> wrote:
> > > > >
> > > > > On (23/08/21 21:27), Masahiro Yamada wrote:
> > > > > >
> > > > > > My (original) hope was to add a single switch, KCONFIG_VERBOSE,=
 to address both:
> > > > > >
> > > > > >   - A CONFIG option is hidden by unmet dependency (Ying Sun's c=
ase)
> > > > > >   - A CONFIG option no longer exists  (your case)
> > > > > >   - Anything else we need to be careful
> > > > >
> > > > > A quick question: is it too late to suggest an alternative name?
> > > > > Could KCONFIG_SANITY_CHECKS be a little cleaner? Because we basic=
ally
> > > > > run sanity checks on the config.
> > > >
> > > >
> > > > Ying's is not applied yet. So, it is not too late.
> > > >
> > > > But, I started to be a little worried
> > > > because it is unpredictable how many KCONFIG_* env
> > > > variables will increase until people are satisfied.
> > > >
> > >
> > > Is there really a problem with having those? There are a lot of
> > > different env variables affecting different parts of the kernel build=
.
> > > If they are useful, and even better, allow catching issues quickly,
> > > should we favor less options or usefulness for users?
> >
> >
> >
> > I am considering how to implement it.
> >
> >
> >
> > One way is to add env variables as a new request arises.
> >
> > Sergey is doing two things by one option.
> >
> >
> >    KCONFIG_WARN_UNKNWON_SYMBOL : warn unknown symbol in input .config
> > or defconfig
> >    KCONFIG_WARN_TO_ERROR       : turn warnings into errors
> >
> >
> >
> > Another way is to handle those as command line options.
> >
> >   -Wunknown-symbol
> >   -Werror             (associated with W=3De)
> >   -Wall               (associated with W=3D1)
> >
> >
> >
> >   $ make W=3D1e olddefconfig
> >
> >
> > will work to sanity check.
> >
> >
>
> I see, I think I misunderstood your previous message, sorry. Agreed
> that there could be other approaches than an environment variable and
> a command line option could definitely work as well. I'll leave the
> details to you and Sergey, but ideally we would have something that is
> simple to use both in scripts (e.g. distro build systems) and in
> manual build for end users
>
> >
> >
> >
> > > > >
> > > > > And one more question: those sanity checks seem very reasonable.
> > > > > Is there any reason we would not want to keep them ON by default?
> > > > > And those brave souls, that do not wish for the tool to very that
> > > > > the .config is sane and nothing will get downgraded/disabled, can
> > > > > always set KCONFIG_SANITY_CHECKS to 0.
> > > >
> > > >
> > > > Kconfig is meant to resolve the dependency without causing an error=
.
> > > > If a feature is not available, it is automatically, silently hidden=
,
> > > > and that works well.
> > >
> > > How do you come to the conclusion that it works well? I've heard many
> > > people unhappy about the way Kconfig works. How does one know that
> > > something is missing (and should maybe be fixed?) if Kconfig silently
> > > hides it?
> >
> >
> > Kconfig has worked like that for a long time, but I do not know
> > how to detect non-existing symbols.
> >
> >
>
> I think a tool to detect symbols present in old config, but missing in
> new kernel solves the "upgraded config" part of the problem.
>
> The other part ("new config") would probably be solved by some kind of
> a tool that looks at the currently present hardware and spews a list
> of Kconfig options together with their dependencies, but arguably
> that's not something that would be a part of Kconfig itself.
>
> For the graphical configuration tools like menuconfig I could imagine
> that the options with unmet dependencies could be still displayed but
> greyed out, so at least one can open the help for the item and check
> which dependencies are missing.


Yes. That idea exists, and at least for xconfig,
I got a patch to grey out hidden options.

https://lore.kernel.org/linux-kbuild/20200708133015.12286-1-maxime.chretien=
@bootlin.com/


I liked the idea, and suggested improvements, but did not receive v2.

Maybe I could revisit it when I have some time,
but I always have TODOs more than my capacity.



Anyway, I applied Sergey's patch, so the life of you guys
will get a little easier.



--
Best Regards
Masahiro Yamada
