Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82037A0B48
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238901AbjINRHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjINRHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:07:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009E11FE1;
        Thu, 14 Sep 2023 10:07:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BAEC433C9;
        Thu, 14 Sep 2023 17:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694711266;
        bh=1r0+Zdvf3wZUhOn2z8iQ20YUkXarqeZelKafGh0Vb5A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dgOuqOeceJAGBoDw1c6Co4XoM8soxD7wU2eq/W6C+XZJf8V9pPkWgPUrUlgMqdE3b
         7xYGmNx7ifAr7G46/C+o5KAoAvIJ4MI02+388TPgweqM9yyb2nb7yh5f5l2NV928nf
         HzKsuBT45z22NndhQwRtqYlkQRwcL59p4AL6dcWrniocC5KhzYaAYr5W+KWH5R4SjY
         /XWnkWCC05FLEdCJ0xRIQIj/qbAcnkutGUaP4kvMC4UGWSzao6GMj9aQAUiHnnBESq
         vVnlhnJJave+UwMBOmYSqUrX9799zP1LRPBuB+sZtdYGRRK0lnWt4FYN4xQA72hY7A
         LNgnq+suizjiQ==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1c4c5375329so654198fac.2;
        Thu, 14 Sep 2023 10:07:46 -0700 (PDT)
X-Gm-Message-State: AOJu0YzkINIjBLZakX2ZPYndHH1n3qGrsnqeB5lQxKBZEUn3fQ1z6wd/
        BWdZKwzTf2JIFR7KCi2Mp6TEW3dpnTKzTGXVnFQ=
X-Google-Smtp-Source: AGHT+IET219ycfzqvgCfxsTzJ4o9BjENQN4pkEP9AJb/FkgP6cvm9VXtjdpkuI/I118jM3aYOVxfCXNlOBWd9cwQOT4=
X-Received: by 2002:a05:6871:60e:b0:1d5:a905:5681 with SMTP id
 w14-20020a056871060e00b001d5a9055681mr6469325oan.26.1694711265804; Thu, 14
 Sep 2023 10:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230913113801.1901152-1-arnd@kernel.org> <ZQISGujwlH00B8KJ@fjasle.eu>
 <b234530c-88fe-4a2a-993c-f1733fe4d0c1@app.fastmail.com> <ZQIcuVgaDmA+VdV0@fjasle.eu>
In-Reply-To: <ZQIcuVgaDmA+VdV0@fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 15 Sep 2023 02:07:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT9kO0RnNai5CuNgP3wgG+XQ2RqcSb2uAqP85P0PMN2tg@mail.gmail.com>
Message-ID: <CAK7LNAT9kO0RnNai5CuNgP3wgG+XQ2RqcSb2uAqP85P0PMN2tg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kbuild: explain handling optional dependencies
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 5:34=E2=80=AFAM Nicolas Schier <nicolas@fjasle.eu> =
wrote:
>
> On Wed, Sep 13, 2023 at 09:55:36PM +0200 Arnd Bergmann wrote:
> > On Wed, Sep 13, 2023, at 21:48, Nicolas Schier wrote:
> > > On Wed, Sep 13, 2023 at 01:37:52PM +0200 Arnd Bergmann wrote:
> > >
> > >>  Documentation/kbuild/kconfig-language.rst | 26 ++++++++++++++++++++=
+++
> > >>  1 file changed, 26 insertions(+)
> > >>
> > >> diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentati=
on/kbuild/kconfig-language.rst
> > >> index 858ed5d80defe..89dea587a469a 100644
> > >> --- a/Documentation/kbuild/kconfig-language.rst
> > >> +++ b/Documentation/kbuild/kconfig-language.rst
> > >> @@ -573,6 +573,32 @@ above, leading to:
> > >>    bool "Support for foo hardware"
> > >>    depends on ARCH_FOO_VENDOR || COMPILE_TEST
> > >>
> > >> +Optional dependencies
> > >> +~~~~~~~~~~~~~~~~~~~~~
> > >> +
> > >> +Some drivers are able to optionally use a feature from another modu=
le
> > >> +or build cleanly with that module disabled, but cause a link failur=
e
> > >> +when trying to use that loadable module from a built-in driver.
> > >> +
> > >> +The most common way to express this optional dependency in Kconfig =
logic
> > >> +uses the slighly counterintuitive
> > >
> > > slighly -> slightly
> >
> > Fixed, thanks
> >
> > > For better RST compliance: could you explicitly start the code block =
e.g. by
> > > appending '::' as in "... counterintuitive::"?
> >
> > Ok, done.
> >
> > >> +
> > >> +  config FOO
> > >> +  bool "Support for foo hardware"
> > >> +  depends on BAR || !BAR
> > >
> > > are you sure that this is enough?  While testing, I needed to explici=
tly use
> > > =3Dy|=3Dn:
> > >
> > >     depends on BAR=3Dy || BAR=3Dn
> > >
> > > to prevent FOO to be selectable iff BAR=3Dm.
> >
> > I see my problem, I made a different mistake here. Your version
> > is correct for a 'bool' symbol as I had here, but the intention
> > of this was to make it work for tristate symbols, which are the
> > interesting case. I've fixed it up this way now, hope it now makes
> > sense to you:
> >
> > --- a/Documentation/kbuild/kconfig-language.rst
> > +++ b/Documentation/kbuild/kconfig-language.rst
> > @@ -581,19 +581,19 @@ or build cleanly with that module disabled, but c=
ause a link failure
> >  when trying to use that loadable module from a built-in driver.
> >
> >  The most common way to express this optional dependency in Kconfig log=
ic
> > -uses the slighly counterintuitive
> > +uses the slightly counterintuitive::
> >
> >    config FOO
> > -       bool "Support for foo hardware"
> > +       tristate "Support for foo hardware"
> >         depends on BAR || !BAR
>
> ah, thanks, tristate kconfig symbols are really more interesting.


Both FOO and BAR MUST be tristate
to make this documentation sensible.


If FOO is bool type, "depends on BAR || !BAR"
becomes a no-op.

As you notice, FOO and BAR become independent of
each other.


You may wonder why.

Here, another unclear rule applies:

'depends on m' for a bool option is promoted to
'depends on y'.

https://github.com/torvalds/linux/blob/v6.5/scripts/kconfig/symbol.c#L214





--=20
Best Regards
Masahiro Yamada
