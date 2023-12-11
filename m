Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1EF80D4A5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345244AbjLKRwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345238AbjLKRwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:52:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E2A115
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:51:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20010C433CB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 17:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702317097;
        bh=0ImBujzzz1HHKZSq3QS56Hx7Yt6KYZiEPa1oJkMxahY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O/W1i8Kl6afgjlt3xX10iXjrdNkJyzsk3aIzQp5VMYulWDcVnm2+ctkpLJ7FQE9/i
         ijtXtzlRvbK/4ZIwDAp8JyjRJdaNjShIJ2TGVluaKjQF++LYW7EC4jNP/mpnXcbc9P
         Pn/ad2MBBIqmN1RSApg4Y3ovhWJ1Yt9FpqcdXO8sNH4/PCi0NmpA8kW2+zW4R3deuq
         6JCX17Wcye21iFpDFdgOewktW66B/3zHSF88yKkBVTjYSFnCEHi0x8RkRHMa0v7Z4R
         EeimBHlCI16+WevWYPrL+a4/kki/+YFaEM/Ld4OzhVSnX4Pob4/iZl9XhIEv4ZfUK4
         QUbSn8CRoS2qQ==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-58cf894544cso2864763eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:51:37 -0800 (PST)
X-Gm-Message-State: AOJu0Yynh/jylFbpL7msAGx53RkzoR+8Al63BSm+WYM5BYko4kcfArd6
        hw4xUbhJYIrv7HYu/EvwieglyigeKx9jd2rTJLo=
X-Google-Smtp-Source: AGHT+IFdAQ1ileIMFF1YXjcM9eTHyZH2w6pxSWkWlWGs/l9LAiU1mKoeWX/q5Aum6nQ8MGC6cIHNGsj/A6+gCMtfEx8=
X-Received: by 2002:a05:6870:d8b:b0:1e9:96c6:e04c with SMTP id
 mj11-20020a0568700d8b00b001e996c6e04cmr4482005oab.32.1702317096384; Mon, 11
 Dec 2023 09:51:36 -0800 (PST)
MIME-Version: 1.0
References: <20230601075333.14021-1-ihuguet@redhat.com> <CAMZ6RqLoRVHD_M8Jh2ELurhL8E=HWt2DZZFGQvmfFyxKjtNKhg@mail.gmail.com>
 <874jiikr6e.fsf@meer.lwn.net> <CAMZ6RqLJmTjM0dYvixMEAo+uW+zfhdL1n4rnajsHCZcq971oRA@mail.gmail.com>
 <CACT4oudYAK07+PJzJMhTazKe3LP-F4tpQf8CF0vs1pJLEE_4aA@mail.gmail.com>
In-Reply-To: <CACT4oudYAK07+PJzJMhTazKe3LP-F4tpQf8CF0vs1pJLEE_4aA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 12 Dec 2023 02:50:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNATqNNVX8ECNoO82kY503ArfRPa9GdbYd9tOok_6tGOsew@mail.gmail.com>
Message-ID: <CAK7LNATqNNVX8ECNoO82kY503ArfRPa9GdbYd9tOok_6tGOsew@mail.gmail.com>
Subject: Re: [PATCH v4] Add .editorconfig file for basic formatting
To:     =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Jonathan Corbet <corbet@lwn.net>, ojeda@kernel.org,
        danny@kdrag0n.dev, jgg@nvidia.com, mic@digikod.net,
        linux-kernel@vger.kernel.org, joe@perches.com,
        linux@rasmusvillemoes.dk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 3:26=E2=80=AFPM =C3=8D=C3=B1igo Huguet <ihuguet@red=
hat.com> wrote:
>
> On Mon, Oct 23, 2023 at 8:19=E2=80=AFAM Vincent MAILHOL
> <mailhol.vincent@wanadoo.fr> wrote:
> >
> > On Mon. 23 Oct. 2023 at 11:28, Jonathan Corbet <corbet@lwn.net> wrote:
> > > Vincent MAILHOL <mailhol.vincent@wanadoo.fr> writes:
> > >
> > > > On Thu. 1 June 2023 at 16:53, =C3=8D=C3=B1igo Huguet <ihuguet@redha=
t.com> wrote:
> > > >> EditorConfig is a specification to define the most basic code form=
atting
> > > >> stuff, and it's supported by many editors and IDEs, either directl=
y or
> > > >> via plugins, including VSCode/VSCodium, Vim, emacs and more.
> > > >>
> > > >> It allows to define formatting style related to indentation, chars=
et,
> > > >> end of lines and trailing whitespaces. It also allows to apply dif=
ferent
> > > >> formats for different files based on wildcards, so for example it =
is
> > > >> possible to apply different configs to *.{c,h}, *.py and *.rs.
> > > >>
> > > >> In linux project, defining a .editorconfig might help to those peo=
ple
> > > >> that work on different projects with different indentation styles,=
 so
> > > >> they cannot define a global style. Now they will directly see the
> > > >> correct indentation on every fresh clone of the project.
> > > >>
> > > >> See https://editorconfig.org
> > > >>
> > > >> Co-developed-by: Danny Lin <danny@kdrag0n.dev>
> > > >> Signed-off-by: Danny Lin <danny@kdrag0n.dev>
> > > >> Signed-off-by: =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com>
> > > >> ---
> > > >
> > > > Is there any news for this patch? I would really love this to becom=
e mainstream.
> > >
> > > I have concerns about this patch that I have expressed in the past.
> > >
> > > I'm not going to apply it... since it's a global change that affects =
all
> > > kernel developers, I don't think I *should* apply it.  I would recomm=
end
> > > sending it directly to Linus; if you can get an ack from him, I'll ap=
ply
> > > it then.
> >
> > Hi Jonathan,
> >
> > Thanks for the comment, message taken.
> >
> > Hi =C3=8D=C3=B1igo,
> >
> > The last version of the patch being from you, would you like to bring
> > the topic to Linus yourself or shall I do it instead?
>
> I'm not doing kernel development lately, so please go ahead pushing
> this if you want.
>
> Anyway, note that, as discussed in the thread, it is incorrect to say
> that it will affect all kernel developers: most IDEs and editors only
> have "opt-in" support for editorconfig, and the few that are not
> "opt-in", are either "opt-out" or has a workaround (Kate).




Applied to linux-kbuild. Thanks.

We invested a significant amount of time in research and discussion,
and I do not want to lose our efforts.

If it turns out to be problematic, it is easy to revert it.
(although I do not think so, given the wide adoption in many projects.)




--
Best Regards
Masahiro Yamada
