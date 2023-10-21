Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7D87D1CDE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 13:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjJULiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 07:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJULiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 07:38:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496781A3;
        Sat, 21 Oct 2023 04:38:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7323C433C8;
        Sat, 21 Oct 2023 11:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697888281;
        bh=CItNLUhgPKWprZgDhoE5AHbH/bbnD7boGHI0AXjLGCI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K1RfshJfvG+iK1f5POzdM2+SCvqS01LqDm71qUBujpZCK0J9k5Epc0RxBLUn5QmNy
         uENT3RhYdkA+ycQxIUPo7eAfTWbRJw3Z/pcKEtg/9OYibGvV1tOlzydDRM5UAdBdcB
         pBBfgSs/1SorGnF4tBwLGCZqpi3QCbUwMvOVjnEJyt4jnaOlov0Pf9fE9IfmxIdIgq
         UpwXWZYylq4UwrRpu1quekYcVjKP8FsNaERavFI6uYCutglsIRZ0AczpeW/qXZ2gP8
         0HD4EScsNKpPEAXP/POpSPQDSkt1L3ntKcQ/PDNQDOi4nMy0Ci3wnVwlceX8p3z0Hy
         awP9Y4K/dKmuw==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1dd5b98d9aeso916386fac.0;
        Sat, 21 Oct 2023 04:38:01 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw+oDbnD3IIsXCttUb8bIDZJVMLGlJIRHV41hadFwNAGUyMxnLH
        31R0BOM9osM7qBsdkUFrcSJcCLMawne7v+MgWmA=
X-Google-Smtp-Source: AGHT+IGrABm4SR8tSQm9fY18WWVZBwn80V24irNVJmXvkmY/hGdMR4KZQw8iUGeT2hTqVr7lRaaqAYLvhGurv4IW+uc=
X-Received: by 2002:a05:6870:c087:b0:1e9:dfc3:1e6c with SMTP id
 c7-20020a056870c08700b001e9dfc31e6cmr4318161oad.28.1697888281221; Sat, 21 Oct
 2023 04:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231018151950.205265-1-masahiroy@kernel.org> <20231018151950.205265-4-masahiroy@kernel.org>
 <ZTDlrkTXnkVN1cff@krava> <CAEf4BzZm4h4q6k9ZhuT5qiWC9PYA+c7XwVFd68iAq4mtMJ-qhw@mail.gmail.com>
 <CAK7LNAR2kKwbzdFxfVXDxsy8pfyQDCR-BN=zpbcZg0JS9RpsKQ@mail.gmail.com> <CAEf4BzbYwEFSNTFjJyhYmOOK5iwHjFAdcArkUbcQz5ntRvOOvA@mail.gmail.com>
In-Reply-To: <CAEf4BzbYwEFSNTFjJyhYmOOK5iwHjFAdcArkUbcQz5ntRvOOvA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 21 Oct 2023 20:37:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQxFgOpuCBYPSx5Z6aw5MtKzPL39XLUvZuUBSyRGnOZUg@mail.gmail.com>
Message-ID: <CAK7LNAQxFgOpuCBYPSx5Z6aw5MtKzPL39XLUvZuUBSyRGnOZUg@mail.gmail.com>
Subject: Re: [bpf-next PATCH v2 4/4] kbuild: refactor module BTF rule
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, bpf@vger.kernel.org
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

On Sat, Oct 21, 2023 at 5:52=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Oct 20, 2023 at 12:03=E2=80=AFAM Masahiro Yamada <masahiroy@kerne=
l.org> wrote:
> >
> > On Fri, Oct 20, 2023 at 7:55=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Oct 19, 2023 at 1:15=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com=
> wrote:
> > > >
> > > > On Thu, Oct 19, 2023 at 12:19:50AM +0900, Masahiro Yamada wrote:
> > > > > newer_prereqs_except and if_changed_except are ugly hacks of the
> > > > > newer-prereqs and if_changed in scripts/Kbuild.include.
> > > > >
> > > > > Remove.
> > > > >
> > > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > > ---
> > > > >
> > > > > Changes in v2:
> > > > >   - Fix if_changed_except to if_changed
> > > > >
> > > > >  scripts/Makefile.modfinal | 25 ++++++-------------------
> > > > >  1 file changed, 6 insertions(+), 19 deletions(-)
> > > > >
> > > > > diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfina=
l
> > > > > index 9fd7a26e4fe9..fc07854bb7b9 100644
> > > > > --- a/scripts/Makefile.modfinal
> > > > > +++ b/scripts/Makefile.modfinal
> > > > > @@ -19,6 +19,9 @@ vmlinux :=3D
> > > > >  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> > > > >  ifneq ($(wildcard vmlinux),)
> > > > >  vmlinux :=3D vmlinux
> > > > > +cmd_btf =3D ; \
> > > > > +     LLVM_OBJCOPY=3D"$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --=
btf_base vmlinux $@; \
> > > > > +     $(RESOLVE_BTFIDS) -b vmlinux $@
> > > > >  else
> > > > >  $(warning Skipping BTF generation due to unavailability of vmlin=
ux)
> > > > >  endif
> > > > > @@ -41,27 +44,11 @@ quiet_cmd_ld_ko_o =3D LD [M]  $@
> > > > >        cmd_ld_ko_o +=3D                                          =
       \
> > > > >       $(LD) -r $(KBUILD_LDFLAGS)                                 =
     \
> > > > >               $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)         =
     \
> > > > > -             -T scripts/module.lds -o $@ $(filter %.o, $^)
> > > > > +             -T scripts/module.lds -o $@ $(filter %.o, $^)      =
     \
> > > > > +     $(cmd_btf)
> > > > >
> > > > > -quiet_cmd_btf_ko =3D BTF [M] $@
> > > >
> > > > nit not sure it's intentional but we no longer display 'BTF [M] ...=
ko' lines,
> > > > I don't mind not displaying that, but we should mention that in cha=
ngelog
> > > >
> > >
> > > Thanks for spotting this! I think those messages are useful and
> > > important to keep. Masahiro, is it possible to preserve them?
> >
> >
> >
> > No, I do not think so.
> >
>
> That's too bad, I think it's a useful one.



I prioritize that the code is correct.



>
> > Your code is wrong.
> >
>
> Could be, but note the comment you are removing:
>
> # Re-generate module BTFs if either module's .ko or vmlinux changed
>
> BTF has to be re-generated not just when module .ko is regenerated,
> but also when the vmlinux image itself changes.
>
> I don't see where this is done with your changes. Can you please point
> it out explicitly?



That is too obvious; %.ko depends on $(vmlinux).



%.ko: %.o %.mod.o scripts/module.lds $(vmlinux) FORCE




--=20
Best Regards
Masahiro Yamada
