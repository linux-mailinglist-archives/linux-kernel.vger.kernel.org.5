Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016C97D28FB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 05:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbjJWDTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 23:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjJWDTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 23:19:51 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A29F7;
        Sun, 22 Oct 2023 20:19:48 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507cee17b00so4088676e87.2;
        Sun, 22 Oct 2023 20:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698031187; x=1698635987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PoHxDhurNoi7ABAIOjydGemVbw76Jn6sMUFspJpsTdg=;
        b=aATVn9eqnz2f/mcbSdgngYVCiAzqqiBXGPHSJiBFj9uwLSdgaOwJ7ye4mi+EeZh5+G
         B8CyyaKBr3thcLn+9dmtzMYKkqVS1OzroCy7vxKoEPDrSHR76ptia/ptfdnFc9dSbjt5
         kKyINJxOkn/l1KwZunVjr5YjGUel9KYz/r2Qacu+1oAYSu2QZ1nZOCNEBQcv9IeYTa39
         nyCXVTMoWG/AqGkW913uwKm4al/fo4eoDg8uI9DlqzF2KYmcG5/elduaLObl/VZ3BfcV
         fz628qTpIhhSwnay2uh7vgrZ6CU/ZKmCi7mELapQm7aZwZy/vikl208Dm3GlxINoFA7N
         aeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698031187; x=1698635987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PoHxDhurNoi7ABAIOjydGemVbw76Jn6sMUFspJpsTdg=;
        b=vGwcvgEpYWmVugFWBMXp53eRZjOlzxfF5DaT4Mk6te0R53y+/9Fua2GcVM14QybLmm
         dqaM7QomkigG3a/rPf/QXs5Q36b1zSGvxq5H8rixwKGBPF/hi0SuDpmgjT+wYaek0LRX
         9xrxD/pQy5ZJxh0d5KWZdapJ8W8P8/bRPxOVHh8GCdYxLrhYb6pmVPXhNjRKuSVHrxNV
         ijlT8ZVLpNBbqqNmbJSZ8oA1to8fYc1GLWdvrqTWrdGHvEanGXDwij+0vYJQsww3pSXl
         3paej1oiKkauHRENWZLvgb3/DWGEAnai8ECgckFvnRYsvgdo9emIn7R4pMzQrD1QvEJa
         //iA==
X-Gm-Message-State: AOJu0YyqKvgHkxtNdce3ZwZ2ZBTEjxHU+8VAFjyaeNSSVoQquL/n6h11
        QCEQNFUiegOA4rqbfDksIu4CwooPV66sTfWUOLZ+KmuY
X-Google-Smtp-Source: AGHT+IEfZdoYjtp/SQVKQbfr7FTTTxJVVy+tG1DGFuvSJuUyhUJQFwv4G1ZGcA1OdREtN29We06C9NHHSNjMGV6Os9A=
X-Received: by 2002:ac2:5550:0:b0:503:258f:fd1b with SMTP id
 l16-20020ac25550000000b00503258ffd1bmr5613776lfk.18.1698031186879; Sun, 22
 Oct 2023 20:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231018151950.205265-1-masahiroy@kernel.org> <20231018151950.205265-4-masahiroy@kernel.org>
 <ZTDlrkTXnkVN1cff@krava> <CAEf4BzZm4h4q6k9ZhuT5qiWC9PYA+c7XwVFd68iAq4mtMJ-qhw@mail.gmail.com>
 <CAK7LNAR2kKwbzdFxfVXDxsy8pfyQDCR-BN=zpbcZg0JS9RpsKQ@mail.gmail.com>
 <CAEf4BzbYwEFSNTFjJyhYmOOK5iwHjFAdcArkUbcQz5ntRvOOvA@mail.gmail.com>
 <CAK7LNAQxFgOpuCBYPSx5Z6aw5MtKzPL39XLUvZuUBSyRGnOZUg@mail.gmail.com>
 <CAEf4BzZqpqo3j33FkH3QJwezbJwarr1dXs4fCsp5So12_5MmTg@mail.gmail.com> <CAK7LNATAuLXCvN5=WiaKv9G4uF-cC2gNe5V-6G55b6fxGNZpeA@mail.gmail.com>
In-Reply-To: <CAK7LNATAuLXCvN5=WiaKv9G4uF-cC2gNe5V-6G55b6fxGNZpeA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 22 Oct 2023 20:19:35 -0700
Message-ID: <CAEf4BzbUqNW5UnhV9bzevtsUUeALca7CthBtzz7NjMCu2ZFmsw@mail.gmail.com>
Subject: Re: [bpf-next PATCH v2 4/4] kbuild: refactor module BTF rule
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2023 at 1:24=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Sun, Oct 22, 2023 at 4:33=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sat, Oct 21, 2023 at 4:38=E2=80=AFAM Masahiro Yamada <masahiroy@kern=
el.org> wrote:
> > >
> > > On Sat, Oct 21, 2023 at 5:52=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Fri, Oct 20, 2023 at 12:03=E2=80=AFAM Masahiro Yamada <masahiroy=
@kernel.org> wrote:
> > > > >
> > > > > On Fri, Oct 20, 2023 at 7:55=E2=80=AFAM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Thu, Oct 19, 2023 at 1:15=E2=80=AFAM Jiri Olsa <olsajiri@gma=
il.com> wrote:
> > > > > > >
> > > > > > > On Thu, Oct 19, 2023 at 12:19:50AM +0900, Masahiro Yamada wro=
te:
> > > > > > > > newer_prereqs_except and if_changed_except are ugly hacks o=
f the
> > > > > > > > newer-prereqs and if_changed in scripts/Kbuild.include.
> > > > > > > >
> > > > > > > > Remove.
> > > > > > > >
> > > > > > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > Changes in v2:
> > > > > > > >   - Fix if_changed_except to if_changed
> > > > > > > >
> > > > > > > >  scripts/Makefile.modfinal | 25 ++++++-------------------
> > > > > > > >  1 file changed, 6 insertions(+), 19 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.m=
odfinal
> > > > > > > > index 9fd7a26e4fe9..fc07854bb7b9 100644
> > > > > > > > --- a/scripts/Makefile.modfinal
> > > > > > > > +++ b/scripts/Makefile.modfinal
> > > > > > > > @@ -19,6 +19,9 @@ vmlinux :=3D
> > > > > > > >  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> > > > > > > >  ifneq ($(wildcard vmlinux),)
> > > > > > > >  vmlinux :=3D vmlinux
> > > > > > > > +cmd_btf =3D ; \
> > > > > > > > +     LLVM_OBJCOPY=3D"$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLA=
GS) --btf_base vmlinux $@; \
> > > > > > > > +     $(RESOLVE_BTFIDS) -b vmlinux $@
> > > > > > > >  else
> > > > > > > >  $(warning Skipping BTF generation due to unavailability of=
 vmlinux)
> > > > > > > >  endif
> > > > > > > > @@ -41,27 +44,11 @@ quiet_cmd_ld_ko_o =3D LD [M]  $@
> > > > > > > >        cmd_ld_ko_o +=3D                                    =
             \
> > > > > > > >       $(LD) -r $(KBUILD_LDFLAGS)                           =
           \
> > > > > > > >               $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)   =
           \
> > > > > > > > -             -T scripts/module.lds -o $@ $(filter %.o, $^)
> > > > > > > > +             -T scripts/module.lds -o $@ $(filter %.o, $^)=
           \
> > > > > > > > +     $(cmd_btf)
> > > > > > > >
> > > > > > > > -quiet_cmd_btf_ko =3D BTF [M] $@
> > > > > > >
> > > > > > > nit not sure it's intentional but we no longer display 'BTF [=
M] ...ko' lines,
> > > > > > > I don't mind not displaying that, but we should mention that =
in changelog
> > > > > > >
> > > > > >
> > > > > > Thanks for spotting this! I think those messages are useful and
> > > > > > important to keep. Masahiro, is it possible to preserve them?
> > > > >
> > > > >
> > > > >
> > > > > No, I do not think so.
> > > > >
> > > >
> > > > That's too bad, I think it's a useful one.
> > >
> > >
> > >
> > > I prioritize that the code is correct.
> > >
> >
> > Could you please also prioritize not regressing informativeness of a
> > build log? With your changes it's not clear now if BTF was generated
> > or not for a kernel module, while previously it was obvious and was
> > easy to spot if for some reason BTF was not generated. I'd like to
> > preserve this
> > property, thank you.
> >
> > E.g, can we still have BTF generation as a separate command and do a
> > separate $(call if_changed,btf_ko)? Or something along those lines.
> > Would that work?
>
> If we have an intermediate file (say, *.no-btf.ko),
> it would make sense to have separate
> $(call if_changed,ld_ko_o) and $(call if_changed,btf_ko).

Currently we don't generate intermediate files, but we do rewrite
original .ko file as a post-processing step.

And that rewriting step might not happen depending on Kconfig and
toolchain (e.g., too old pahole makes it impossible to generate kernel
module BTF). And that's why having a separate BTF [M] message in the
build log is important.

>
>
>            LD                 RESOLVE_BTFIDS
>  *.mod.o  ------> *.no-btf.ko ------------> *.ko
>
>
> When vmlinux is changed, only the second step would
> be re-run, but that would require extra file copy.

Today we rewrite .ko with a new .ko ELF file which gains a new ELF
section (.BTF), so we already pay this price when BTF is enabled (if
that's your concern).

>
> Is this what you want to see?

I don't have strong preferences for exact implementation, but what you
propose will work, I think. What I'd like to avoid is unnecessarily
relinking .ko files if all we need to do is regenerate BTF.

>
>
>
>
>
> >
> > >
> > >
> > > >
> > > > > Your code is wrong.
> > > > >
> > > >
> > > > Could be, but note the comment you are removing:
> > > >
> > > > # Re-generate module BTFs if either module's .ko or vmlinux changed
> > > >
> > > > BTF has to be re-generated not just when module .ko is regenerated,
> > > > but also when the vmlinux image itself changes.
> > > >
> > > > I don't see where this is done with your changes. Can you please po=
int
> > > > it out explicitly?
> > >
> > >
> > >
> > > That is too obvious; %.ko depends on $(vmlinux).
> >
> > Thank you for your gracious answer. We used to not rebuild module's
> > .ko's when vmlinux didn't change (but we did regen BTFs), and that's
> > why I was confused. Now we forcefully recompile modules, which is a
> > change in behavior which would be nice to call out in the commit
> > message.
> >
> >
> > >
> > >
> > >
> > > %.ko: %.o %.mod.o scripts/module.lds $(vmlinux) FORCE
> > >
> > >
> > >
> > >
> > > --
> > > Best Regards
> > > Masahiro Yamada
>
>
>
> --
> Best Regards
> Masahiro Yamada
