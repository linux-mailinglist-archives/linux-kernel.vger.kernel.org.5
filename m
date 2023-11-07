Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D1C7E41A4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbjKGONN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbjKGONL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:13:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D7FB4;
        Tue,  7 Nov 2023 06:13:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCD1C433CC;
        Tue,  7 Nov 2023 14:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699366388;
        bh=3uu3xjsMv/HWdiZjhGCNJwq0vWIfTCG/6H7qC0Pb8Ig=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FSkxVw21Z7If0wVbWvxaBgMv+hhbnv0GMpRhISsND3QGB2NXoAgELbfWiWgrlv88u
         JI4Q+pq0+WvPlPUn3GaAPLRRTu6dRuDhBdHsih+gihktGwjDHhth4mUAN+/i42vShP
         /LYTY8XjZreYIh56Tun6aEVex6spP6yg0APDv16tJpwf+J9an+WEAUmNeD6NljuFjT
         gPUjlVXvxL45UFpGYuAYLv5HwXcbnckqED7x44nNyzyK+JcfwATBmdfcEYyFoBY3wX
         wW4gbJvBPQ9nJnONPMNQguLdJ5tCOjET0rCDOeY5o0APQj+XQZVDNWZ8gxANn494dx
         aGg+tDaYPoNXA==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1e9a757e04eso3351814fac.0;
        Tue, 07 Nov 2023 06:13:08 -0800 (PST)
X-Gm-Message-State: AOJu0YwUk3KWDKJSJ552FHQRQYkGlGMXlJyca0kx0AtHKglbXLHaoPtr
        yslTBACATUXS7rktRo3R/1L5iNpHfYllUAIl5ws=
X-Google-Smtp-Source: AGHT+IFdb80DVsZYYRJCaxdJVKIa3zCvpWN1Lu6hUl5fhI39v7rD9Qg+0szgCCaj0ejCvw3Q2Tsvs3YRMqFaGfuGGWU=
X-Received: by 2002:a05:6870:1281:b0:1e9:fb1e:870a with SMTP id
 1-20020a056870128100b001e9fb1e870amr1317914oal.3.1699366387706; Tue, 07 Nov
 2023 06:13:07 -0800 (PST)
MIME-Version: 1.0
References: <20231104194207.3370542-1-sjg@chromium.org> <20231104194207.3370542-3-sjg@chromium.org>
 <CAK7LNASVOdz2qdg5dwWN8HJwqJ1q_OgdeuapLhvmD6beavUqPg@mail.gmail.com> <CAPnjgZ2yrk38kApMSiUOmsNM8M9cDa3gtH-ozJZzk=VjLh+PLQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ2yrk38kApMSiUOmsNM8M9cDa3gtH-ozJZzk=VjLh+PLQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 7 Nov 2023 16:12:30 +0200
X-Gmail-Original-Message-ID: <CAK7LNARzfMDBX9mhCaCV8QxpTic6A3JYOPBManJNh9Jas=-T9A@mail.gmail.com>
Message-ID: <CAK7LNARzfMDBX9mhCaCV8QxpTic6A3JYOPBManJNh9Jas=-T9A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm: boot: Use double quotes for image name
To:     Simon Glass <sjg@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Tom Rini <trini@konsulko.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,


On Tue, Nov 7, 2023 at 3:11=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Masahiro,
>
> On Tue, 7 Nov 2023 at 03:13, Masahiro Yamada <masahiroy@kernel.org> wrote=
:
> >
> > On Sat, Nov 4, 2023 at 9:42=E2=80=AFPM Simon Glass <sjg@chromium.org> w=
rote:
> > >
> > > The use of single quotes in the image name causes them to appear in
> > > the image description when the uImage is created. Use double quotes, =
to
> > > avoid this.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v2:
> > > - Split double-quote change out into its own patch
> > >
> > >  scripts/Makefile.lib | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > > index 68d0134bdbf9..03e79e319293 100644
> > > --- a/scripts/Makefile.lib
> > > +++ b/scripts/Makefile.lib
> > > @@ -487,7 +487,7 @@ UIMAGE_OPTS-y ?=3D
> > >  UIMAGE_TYPE ?=3D kernel
> > >  UIMAGE_LOADADDR ?=3D arch_must_set_this
> > >  UIMAGE_ENTRYADDR ?=3D $(UIMAGE_LOADADDR)
> > > -UIMAGE_NAME ?=3D 'Linux-$(KERNELRELEASE)'
> > > +UIMAGE_NAME ?=3D "Linux-$(KERNELRELEASE)"
> > >
> > >  quiet_cmd_uimage =3D UIMAGE  $@
> > >        cmd_uimage =3D $(BASH) $(MKIMAGE) -A $(UIMAGE_ARCH) -O linux \
> > > --
> > > 2.42.0.869.gea05f2083d-goog
> > >
> >
> >
> > NACK.
> >
> >
> > This is because you are doing *WRONG* in 3/3.
> >
> > Look at your code closely.
> >
> > https://lore.kernel.org/linux-kbuild/20231104194207.3370542-4-sjg@chrom=
ium.org/T/#me2fb68151d6f4f330808406f9a711fffee149529
> >
> >
> >
> > In the mainline kernel, the quotation appears
> > only in the definition of UIMAGE_NAME.
> >
> >
> > masahiro@zoe:~/ref/linux(master)$ git grep UIMAGE_NAME
> > scripts/Makefile.lib:UIMAGE_NAME ?=3D 'Linux-$(KERNELRELEASE)'
> > scripts/Makefile.lib:                   -n $(UIMAGE_NAME) -d $< $@
> >
> >
> > The single quotes are consumed by shell.
> >
> >
> >
> >
> >
> >
> > This is mainline + your patch set.
> >
> > masahiro@zoe:~/ref/linux(simon-v2)$ git grep UIMAGE_NAME
> > scripts/Makefile.lib:UIMAGE_NAME ?=3D "Linux-$(KERNELRELEASE)"
> > scripts/Makefile.lib:                   -n "$(UIMAGE_NAME)" -d $< $@
> > scripts/Makefile.lib:                   --name "$(UIMAGE_NAME)" \
> >
> >
> > You quoted the definition of UIMAGE_NAME,
> > and also variable references.
> >
> >
> >
> >
> > See how it is expanded.
> >
> >
> > --name "$(UIMAGE_NAME)"
> >
> >
> >  =3D=3D>
> >
> >
> > --name ""Linux-$(KERNELRELEASE)""
> >
> >
> >  =3D=3D>
> >
> >
> > --name Linux-$(KERNELRELEASE)
> >
> >
> >
> >
> > You added double quotes in a row, just to cancel it.
>
> Yes, I understand that. But without the quotes in -n "$(UIMAGE_NAME)"
> then the name cannot contain spaces. So we do need some sort of
> quoting, right?


Yes.

If you move the quoting to the variable reference,
it is acceptable because there is a good reason to do so.



UIMAGE_NAME ?=3D Linux-$(KERNELRELEASE)


            ...
             -n '$(UIMAGE_NAME)' -d $< $@


This is the correct change.



>
> It just seems strange to use single quotes in a Makefile variable. I
> found it confusing.


Right. Why don't you remove it, then?


For clarification, there is no concept of quoting in GNU Make.

The single quote character ' and the double quote character " are
just normal characters for Make.

GNU Make handles them just like alphabets and numbers.

GNU Make just replaces $(UIMAGE_NAME)
with 'Linux-$(KERNELRELEASE)' verbatim.


It is the _shell_ that understands the quoting.

Just in case here is the spec for
"2.2.2 Single-Quotes" vs "2.2.3 Double-Quotes"

https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html


Shell supports both single-quoting and double-quoting
for good reasons.

There is no good or bad because both of them are meaningful.






>
> I think you are saying you want to keep the single quotes in the var
> declaration and drop the quotes from the cmd_fit rule. I am OK with
> that, but I do think it is unusual not to quote something which might
> have spaces. It may cause confusion for others, as it did for me?
>
> Anyway, I'll send a new version with the quoting reverted.
>


Please move the single quotes as I suggested above.

The reason is because UIMAGE_NAME can be passed-in
by a user and it can contain whitespaces.





> Regards,
> Simon



--=20
Best Regards
Masahiro Yamada
