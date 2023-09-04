Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816C27910BF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 07:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351644AbjIDFK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 01:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbjIDFK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 01:10:59 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665FD109
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 22:10:55 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-411f5dd7912so8312881cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 22:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693804253; x=1694409053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXUZaycyRKFF7YD/xZN3g8M3+P9PTWamNfdRK18yuN0=;
        b=csTbv377JuwAxnoqJ6rOG3/O4YzvqguBB8nn8UMsj7imvRc7qbJAjyrZGDGYRl3uK5
         0ldLwwyhaHkz3E4yuyfurhks9yVexwEb5P3X3Awyn/OBObRme1PT/MpnXvrd5MIWwHNt
         WwvbQ5lY/NSD/NqP7t7sEMekMue9iUOmFEpQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693804253; x=1694409053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXUZaycyRKFF7YD/xZN3g8M3+P9PTWamNfdRK18yuN0=;
        b=VqPkp+VJrlPc75frYxn1msGa7BWTMOBxbXVmH2BN08FaEphHkBoLorIfKfkQMNO70J
         EDRlwWfpezBWqAIHs/EhcdeLKywCrXsOrbFDyRa7HiwKPMjwM3LRKcQk5O/MSv//1mfg
         1AA0krwfPKxwDIRMDLsHOhEfoltIAlQ4HtFgk3sqn6fXOuvNIQPXdBlxk3T3z4CCYulf
         rkY1UJnqlUF1mtnVAEIR8SEy+IOjVazZT8+J4P8ec9qVIqzsZm/3Wo+VXj4FxVacK1Nw
         6UXfRVWxi93dfGGfTjkglu0xAPDiguYZX4e0msEUdtypvPNJ8OTKeeMfi/L23oXU5u4C
         cHfQ==
X-Gm-Message-State: AOJu0YyU7bYwwz33CPrwdJh48PCTqpo6HXPTgqg1RehJvOenV2AcXhkO
        KpLNYyBuvdzmhRgiTSBo1JbExUqqcHEQRt3jE+Y=
X-Google-Smtp-Source: AGHT+IHXQSWlVtnMIE7HPQ0G6SCRW2cMsICn4JAcaQVALBe6HtKq4RKqyNB/vJCAkJL3Ljyc4wruFA==
X-Received: by 2002:a05:622a:15c6:b0:412:2ad4:fa1e with SMTP id d6-20020a05622a15c600b004122ad4fa1emr13794077qty.27.1693804253737;
        Sun, 03 Sep 2023 22:10:53 -0700 (PDT)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com. [209.85.219.54])
        by smtp.gmail.com with ESMTPSA id ke18-20020a05622a289200b003f6ac526568sm3344436qtb.39.2023.09.03.22.10.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 22:10:52 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-64a5bc53646so7580796d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 22:10:52 -0700 (PDT)
X-Received: by 2002:a0c:f58a:0:b0:64f:6cc4:63d1 with SMTP id
 k10-20020a0cf58a000000b0064f6cc463d1mr9212576qvm.6.1693804251772; Sun, 03 Sep
 2023 22:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230817012007.131868-1-senozhatsky@chromium.org>
 <CAK7LNASJWKSsdzn5ccgWaC35-XvHGU7pnE6C=eZFDbqrrghtdQ@mail.gmail.com>
 <20230820024519.GK907732@google.com> <CAK7LNAS9KC1GjPgadMEivSpy4TMYU8mQ+BrtfJpNs2kvhK18yA@mail.gmail.com>
 <20230820072119.GM907732@google.com> <20230820073332.GN907732@google.com>
 <CAK7LNARTZXvWD8PrA3bC+Ok7LK85qO=pkMs4kOPGn90OBooL6w@mail.gmail.com>
 <20230822061203.GA610023@google.com> <CAK7LNAS0qEZk+xAq84=7SuJSQz5F3dNBjYKPoeKTd_caq-QMKg@mail.gmail.com>
 <CAAFQd5DeDEhPUQScXB67v9giiV=G33L-YDdtF4e-+UcmBXG6jA@mail.gmail.com>
 <CAK7LNATj-jnOLMkgzz=3MfqWgUjKF-MwSKQkr4hW0g7+tEsXUw@mail.gmail.com>
 <CAAFQd5AhN5m8eaGsrKfh1gHPLiOVd9_3BwoHpr7u6iY92Ft-bg@mail.gmail.com> <CAK7LNAR6o=K=eGzi194Ly787Ji4Twfqq3dcr8NE5m23ayGM3Fg@mail.gmail.com>
In-Reply-To: <CAK7LNAR6o=K=eGzi194Ly787Ji4Twfqq3dcr8NE5m23ayGM3Fg@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 4 Sep 2023 14:10:34 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DTNfNDPtvFd-=kkGYY5nduLp3SLjzNmHPgu6QfQO3ypw@mail.gmail.com>
Message-ID: <CAAFQd5DTNfNDPtvFd-=kkGYY5nduLp3SLjzNmHPgu6QfQO3ypw@mail.gmail.com>
Subject: Re: [RFC][PATCH] kconfig: introduce listunknownconfig
To:     Masahiro Yamada <masahiroy@kernel.org>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 1, 2023 at 12:28=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Thu, Aug 31, 2023 at 11:30=E2=80=AFAM Tomasz Figa <tfiga@chromium.org>=
 wrote:
> >
> > On Sat, Aug 26, 2023 at 10:11=E2=80=AFAM Masahiro Yamada <masahiroy@ker=
nel.org> wrote:
> > >
> > > On Thu, Aug 24, 2023 at 2:30=E2=80=AFPM Tomasz Figa <tfiga@chromium.o=
rg> wrote:
> > > >
> > > > Hi Masahiro,
> > > >
> > > > On Thu, Aug 24, 2023 at 10:00=E2=80=AFAM Masahiro Yamada <masahiroy=
@kernel.org> wrote:
> > > > >
> > > > > On Tue, Aug 22, 2023 at 4:30=E2=80=AFPM Sergey Senozhatsky
> > > > > <senozhatsky@chromium.org> wrote:
> > > > > >
> > > > > > On (23/08/21 21:27), Masahiro Yamada wrote:
> > > > > > >
> > > > > > > My (original) hope was to add a single switch, KCONFIG_VERBOS=
E, to address both:
> > > > > > >
> > > > > > >   - A CONFIG option is hidden by unmet dependency (Ying Sun's=
 case)
> > > > > > >   - A CONFIG option no longer exists  (your case)
> > > > > > >   - Anything else we need to be careful
> > > > > >
> > > > > > A quick question: is it too late to suggest an alternative name=
?
> > > > > > Could KCONFIG_SANITY_CHECKS be a little cleaner? Because we bas=
ically
> > > > > > run sanity checks on the config.
> > > > >
> > > > >
> > > > > Ying's is not applied yet. So, it is not too late.
> > > > >
> > > > > But, I started to be a little worried
> > > > > because it is unpredictable how many KCONFIG_* env
> > > > > variables will increase until people are satisfied.
> > > > >
> > > >
> > > > Is there really a problem with having those? There are a lot of
> > > > different env variables affecting different parts of the kernel bui=
ld.
> > > > If they are useful, and even better, allow catching issues quickly,
> > > > should we favor less options or usefulness for users?
> > >
> > >
> > >
> > > I am considering how to implement it.
> > >
> > >
> > >
> > > One way is to add env variables as a new request arises.
> > >
> > > Sergey is doing two things by one option.
> > >
> > >
> > >    KCONFIG_WARN_UNKNWON_SYMBOL : warn unknown symbol in input .config
> > > or defconfig
> > >    KCONFIG_WARN_TO_ERROR       : turn warnings into errors
> > >
> > >
> > >
> > > Another way is to handle those as command line options.
> > >
> > >   -Wunknown-symbol
> > >   -Werror             (associated with W=3De)
> > >   -Wall               (associated with W=3D1)
> > >
> > >
> > >
> > >   $ make W=3D1e olddefconfig
> > >
> > >
> > > will work to sanity check.
> > >
> > >
> >
> > I see, I think I misunderstood your previous message, sorry. Agreed
> > that there could be other approaches than an environment variable and
> > a command line option could definitely work as well. I'll leave the
> > details to you and Sergey, but ideally we would have something that is
> > simple to use both in scripts (e.g. distro build systems) and in
> > manual build for end users
> >
> > >
> > >
> > >
> > > > > >
> > > > > > And one more question: those sanity checks seem very reasonable=
.
> > > > > > Is there any reason we would not want to keep them ON by defaul=
t?
> > > > > > And those brave souls, that do not wish for the tool to very th=
at
> > > > > > the .config is sane and nothing will get downgraded/disabled, c=
an
> > > > > > always set KCONFIG_SANITY_CHECKS to 0.
> > > > >
> > > > >
> > > > > Kconfig is meant to resolve the dependency without causing an err=
or.
> > > > > If a feature is not available, it is automatically, silently hidd=
en,
> > > > > and that works well.
> > > >
> > > > How do you come to the conclusion that it works well? I've heard ma=
ny
> > > > people unhappy about the way Kconfig works. How does one know that
> > > > something is missing (and should maybe be fixed?) if Kconfig silent=
ly
> > > > hides it?
> > >
> > >
> > > Kconfig has worked like that for a long time, but I do not know
> > > how to detect non-existing symbols.
> > >
> > >
> >
> > I think a tool to detect symbols present in old config, but missing in
> > new kernel solves the "upgraded config" part of the problem.
> >
> > The other part ("new config") would probably be solved by some kind of
> > a tool that looks at the currently present hardware and spews a list
> > of Kconfig options together with their dependencies, but arguably
> > that's not something that would be a part of Kconfig itself.
> >
> > For the graphical configuration tools like menuconfig I could imagine
> > that the options with unmet dependencies could be still displayed but
> > greyed out, so at least one can open the help for the item and check
> > which dependencies are missing.
>
>
> Yes. That idea exists, and at least for xconfig,
> I got a patch to grey out hidden options.
>
> https://lore.kernel.org/linux-kbuild/20200708133015.12286-1-maxime.chreti=
en@bootlin.com/
>
>
> I liked the idea, and suggested improvements, but did not receive v2.
>
> Maybe I could revisit it when I have some time,
> but I always have TODOs more than my capacity.
>

Let me see if I can do something about it. It sounds like a very
convenient thing, although I'd definitely prefer menuconfig over
xconfig.

>
>
> Anyway, I applied Sergey's patch, so the life of you guys
> will get a little easier.

Thanks a lot!

Best regards,
Tomasz
