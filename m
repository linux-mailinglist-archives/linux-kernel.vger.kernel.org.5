Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F1D7E4210
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbjKGOsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjKGOr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:47:58 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD75126
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 06:47:55 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5435336ab0bso9935684a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 06:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699368473; x=1699973273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnbeJZKiQOh5K3sI9hqRkc3lnO9o5y6c5lTMMzgYvsY=;
        b=Wd6jZMYIKUVrbXfDv80Wl3lbCSL8R3DG36d9fS3jymZdlCv9YpCpSsQJlJOGiqCjpz
         NrNcrFy6r4KaZ8KiTnxGtcN1uG5/ETFWMxlSRIgs7uydT0w8PucrDzb2zsGFiSnG1UsN
         o57zbBcf11TKaipPZmVsH2Ba+sortTpcJIn3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699368473; x=1699973273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnbeJZKiQOh5K3sI9hqRkc3lnO9o5y6c5lTMMzgYvsY=;
        b=fg2A03jD5LWCxnfHlfWshVMNS/3k0809cbC/9iX6BiwP4oaUM32VT3gxVy5rLzTHTM
         ZoJw5SOxH5i54xDoqa8telbxngjAqvQEhGtKoUr/jM2x69J3EjXUD+OegbKMknWk1umN
         3bQ44LBnwfPD/a29TfB05j5aMdJlEM11sP9cu5xWJszCkLCvDnPSJJrJscUTSzZVq4J8
         44XSuswO3QtWRbSdmrmCxDJ35DQ6DGyquP7rmK1DJKWnlcFUp84/MWxlZAcwzRFvBO+G
         3cdaIdjTmeFOTMHEObIiA9aFlopDdbFy2TAWu0HdZ4Qv+Qt+1wCB/mr5wIzNmFGGGAH1
         GcPw==
X-Gm-Message-State: AOJu0YyJZE/9F+PpT3jG5qePmSFHuu/2EY6RY2zS100cQmHhQz7Mo6ut
        37WWWYr/kSfbG0cSjDzEKRILLBID9D4AJgCGu3Dlsg==
X-Google-Smtp-Source: AGHT+IENfNsJXAisXICQ9hXfEFELw1udePjhEHmkIST9uDdPVV64sOD6sNTW7nyc6dFHLgikhceAKATe9uLSfW7Kz5c=
X-Received: by 2002:a50:8adc:0:b0:543:c578:f9d2 with SMTP id
 k28-20020a508adc000000b00543c578f9d2mr15339820edk.2.1699368473317; Tue, 07
 Nov 2023 06:47:53 -0800 (PST)
MIME-Version: 1.0
References: <20231104194207.3370542-1-sjg@chromium.org> <20231104194207.3370542-3-sjg@chromium.org>
 <CAK7LNASVOdz2qdg5dwWN8HJwqJ1q_OgdeuapLhvmD6beavUqPg@mail.gmail.com>
 <CAPnjgZ2yrk38kApMSiUOmsNM8M9cDa3gtH-ozJZzk=VjLh+PLQ@mail.gmail.com> <CAK7LNARzfMDBX9mhCaCV8QxpTic6A3JYOPBManJNh9Jas=-T9A@mail.gmail.com>
In-Reply-To: <CAK7LNARzfMDBX9mhCaCV8QxpTic6A3JYOPBManJNh9Jas=-T9A@mail.gmail.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Tue, 7 Nov 2023 07:47:42 -0700
Message-ID: <CAPnjgZ27bsKOLwsK7nTw=3OEvdY4Yz5nZGsMNCmEzvsQPafjqw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm: boot: Use double quotes for image name
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Tom Rini <trini@konsulko.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Tue, 7 Nov 2023 at 07:13, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Hi Simon,
>
>
> On Tue, Nov 7, 2023 at 3:11=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > Hi Masahiro,
> >
> > On Tue, 7 Nov 2023 at 03:13, Masahiro Yamada <masahiroy@kernel.org> wro=
te:
> > >
> > > On Sat, Nov 4, 2023 at 9:42=E2=80=AFPM Simon Glass <sjg@chromium.org>=
 wrote:
> > > >
> > > > The use of single quotes in the image name causes them to appear in
> > > > the image description when the uImage is created. Use double quotes=
, to
> > > > avoid this.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > Changes in v2:
> > > > - Split double-quote change out into its own patch
> > > >
> > > >  scripts/Makefile.lib | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > > > index 68d0134bdbf9..03e79e319293 100644
> > > > --- a/scripts/Makefile.lib
> > > > +++ b/scripts/Makefile.lib
> > > > @@ -487,7 +487,7 @@ UIMAGE_OPTS-y ?=3D
> > > >  UIMAGE_TYPE ?=3D kernel
> > > >  UIMAGE_LOADADDR ?=3D arch_must_set_this
> > > >  UIMAGE_ENTRYADDR ?=3D $(UIMAGE_LOADADDR)
> > > > -UIMAGE_NAME ?=3D 'Linux-$(KERNELRELEASE)'
> > > > +UIMAGE_NAME ?=3D "Linux-$(KERNELRELEASE)"
> > > >
> > > >  quiet_cmd_uimage =3D UIMAGE  $@
> > > >        cmd_uimage =3D $(BASH) $(MKIMAGE) -A $(UIMAGE_ARCH) -O linux=
 \
> > > > --
> > > > 2.42.0.869.gea05f2083d-goog
> > > >
> > >
> > >
> > > NACK.
> > >
> > >
> > > This is because you are doing *WRONG* in 3/3.
> > >
> > > Look at your code closely.
> > >
> > > https://lore.kernel.org/linux-kbuild/20231104194207.3370542-4-sjg@chr=
omium.org/T/#me2fb68151d6f4f330808406f9a711fffee149529
> > >
> > >
> > >
> > > In the mainline kernel, the quotation appears
> > > only in the definition of UIMAGE_NAME.
> > >
> > >
> > > masahiro@zoe:~/ref/linux(master)$ git grep UIMAGE_NAME
> > > scripts/Makefile.lib:UIMAGE_NAME ?=3D 'Linux-$(KERNELRELEASE)'
> > > scripts/Makefile.lib:                   -n $(UIMAGE_NAME) -d $< $@
> > >
> > >
> > > The single quotes are consumed by shell.
> > >
> > >
> > >
> > >
> > >
> > >
> > > This is mainline + your patch set.
> > >
> > > masahiro@zoe:~/ref/linux(simon-v2)$ git grep UIMAGE_NAME
> > > scripts/Makefile.lib:UIMAGE_NAME ?=3D "Linux-$(KERNELRELEASE)"
> > > scripts/Makefile.lib:                   -n "$(UIMAGE_NAME)" -d $< $@
> > > scripts/Makefile.lib:                   --name "$(UIMAGE_NAME)" \
> > >
> > >
> > > You quoted the definition of UIMAGE_NAME,
> > > and also variable references.
> > >
> > >
> > >
> > >
> > > See how it is expanded.
> > >
> > >
> > > --name "$(UIMAGE_NAME)"
> > >
> > >
> > >  =3D=3D>
> > >
> > >
> > > --name ""Linux-$(KERNELRELEASE)""
> > >
> > >
> > >  =3D=3D>
> > >
> > >
> > > --name Linux-$(KERNELRELEASE)
> > >
> > >
> > >
> > >
> > > You added double quotes in a row, just to cancel it.
> >
> > Yes, I understand that. But without the quotes in -n "$(UIMAGE_NAME)"
> > then the name cannot contain spaces. So we do need some sort of
> > quoting, right?
>
>
> Yes.
>
> If you move the quoting to the variable reference,
> it is acceptable because there is a good reason to do so.
>
>
>
> UIMAGE_NAME ?=3D Linux-$(KERNELRELEASE)
>
>
>             ...
>              -n '$(UIMAGE_NAME)' -d $< $@
>
>
> This is the correct change.

OK.

>
>
>
> >
> > It just seems strange to use single quotes in a Makefile variable. I
> > found it confusing.
>
>
> Right. Why don't you remove it, then?
>
>
> For clarification, there is no concept of quoting in GNU Make.
>
> The single quote character ' and the double quote character " are
> just normal characters for Make.
>
> GNU Make handles them just like alphabets and numbers.
>
> GNU Make just replaces $(UIMAGE_NAME)
> with 'Linux-$(KERNELRELEASE)' verbatim.
>
>
> It is the _shell_ that understands the quoting.
>
> Just in case here is the spec for
> "2.2.2 Single-Quotes" vs "2.2.3 Double-Quotes"
>
> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html
>
>
> Shell supports both single-quoting and double-quoting
> for good reasons.
>
> There is no good or bad because both of them are meaningful.

Yes...I suppose I knew that Makefiles are completely literal, but
thanks for the pointers. I tend to use double quotes by default and
single quotes only when I have to...but it doesn't really matter so
long as it is consistent.

Anyway, moving the single quotes away from the var removes the
confusion I had at the start of all of this.

>
>
>
>
>
>
> >
> > I think you are saying you want to keep the single quotes in the var
> > declaration and drop the quotes from the cmd_fit rule. I am OK with
> > that, but I do think it is unusual not to quote something which might
> > have spaces. It may cause confusion for others, as it did for me?
> >
> > Anyway, I'll send a new version with the quoting reverted.
> >
>
>
> Please move the single quotes as I suggested above.
>
> The reason is because UIMAGE_NAME can be passed-in
> by a user and it can contain whitespaces.

OK, done in v4.

Regards,
Simon
