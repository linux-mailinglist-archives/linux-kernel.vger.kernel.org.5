Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025A37E3FD9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbjKGNNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbjKGNMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:12:54 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802BD59CC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:11:23 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so9705649a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 05:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699362682; x=1699967482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qm6N9dJ/FSSYVJxVKJ48BKdFLAoG420WN2Tv4cINOOM=;
        b=LGqxdy1jqhLql8hCqH4erJk5EUBF1yjw9ItFuSyUKv5kRMxnBPdkqHBvJElRCGs/Fg
         wciv7PeOPN/mxXhaWjFNeUJjrhYEMAyfYHPWVSRxKytGHlWcb3GtLEjXFxh3fS112mbw
         hv4AqpkOqQzUK92ZNpts6XgFPJX5Ztd4jJq7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699362682; x=1699967482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qm6N9dJ/FSSYVJxVKJ48BKdFLAoG420WN2Tv4cINOOM=;
        b=GvxYvvvBA05WLzrHYi9LO4dXxG+1k1FbEFBhUVKpQZwXZ4Pixvfq5a+l+m//136jls
         Q+JV9RKQzEhZa+M45mzN7mEgyMdtRbJTDq675Xkieoxuq+Mq3dZJ1XoDAcPJ4WG+imWO
         ktigGgdaqXw8wmeFkvpodVacTFr+POmN3kKx+lv8p/6UhnjL3KgnBn/BbttIgUqWT2kI
         U5QKAzkxQ0aAwQpudJ31hg9WKl5+cb3wuKXy7BdzTDAfX5IV12mg3IhlOXexjjMVPz6g
         1AfMu9G39UWEkzKwslQqBMvuIUvH0U3OBykkYwcz5CoqOv/ekEJREa8P1AFimNaCCyvR
         yGgw==
X-Gm-Message-State: AOJu0YwIF5UqAYzhwiSI8HWUHS3shvB30fKkwgbldm8ZsTS8QCX5j4ED
        47Jsplq145lNkn+03rZ/RuMh7TN5MV/cMK9JO8Sy1Q==
X-Google-Smtp-Source: AGHT+IFAt9ZvNXhAP24k2CMB3H8lR8ZLGxNoilWSXS9qb1pciEkcAkih+Vf7Ea6P/P+raouRDzcRzboDY2UxfiZqHd8=
X-Received: by 2002:a50:8e5d:0:b0:543:c50c:cacc with SMTP id
 29-20020a508e5d000000b00543c50ccaccmr13915784edx.41.1699362681654; Tue, 07
 Nov 2023 05:11:21 -0800 (PST)
MIME-Version: 1.0
References: <20231104194207.3370542-1-sjg@chromium.org> <20231104194207.3370542-3-sjg@chromium.org>
 <CAK7LNASVOdz2qdg5dwWN8HJwqJ1q_OgdeuapLhvmD6beavUqPg@mail.gmail.com>
In-Reply-To: <CAK7LNASVOdz2qdg5dwWN8HJwqJ1q_OgdeuapLhvmD6beavUqPg@mail.gmail.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Tue, 7 Nov 2023 06:11:04 -0700
Message-ID: <CAPnjgZ2yrk38kApMSiUOmsNM8M9cDa3gtH-ozJZzk=VjLh+PLQ@mail.gmail.com>
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

On Tue, 7 Nov 2023 at 03:13, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Sat, Nov 4, 2023 at 9:42=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > The use of single quotes in the image name causes them to appear in
> > the image description when the uImage is created. Use double quotes, to
> > avoid this.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Split double-quote change out into its own patch
> >
> >  scripts/Makefile.lib | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 68d0134bdbf9..03e79e319293 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -487,7 +487,7 @@ UIMAGE_OPTS-y ?=3D
> >  UIMAGE_TYPE ?=3D kernel
> >  UIMAGE_LOADADDR ?=3D arch_must_set_this
> >  UIMAGE_ENTRYADDR ?=3D $(UIMAGE_LOADADDR)
> > -UIMAGE_NAME ?=3D 'Linux-$(KERNELRELEASE)'
> > +UIMAGE_NAME ?=3D "Linux-$(KERNELRELEASE)"
> >
> >  quiet_cmd_uimage =3D UIMAGE  $@
> >        cmd_uimage =3D $(BASH) $(MKIMAGE) -A $(UIMAGE_ARCH) -O linux \
> > --
> > 2.42.0.869.gea05f2083d-goog
> >
>
>
> NACK.
>
>
> This is because you are doing *WRONG* in 3/3.
>
> Look at your code closely.
>
> https://lore.kernel.org/linux-kbuild/20231104194207.3370542-4-sjg@chromiu=
m.org/T/#me2fb68151d6f4f330808406f9a711fffee149529
>
>
>
> In the mainline kernel, the quotation appears
> only in the definition of UIMAGE_NAME.
>
>
> masahiro@zoe:~/ref/linux(master)$ git grep UIMAGE_NAME
> scripts/Makefile.lib:UIMAGE_NAME ?=3D 'Linux-$(KERNELRELEASE)'
> scripts/Makefile.lib:                   -n $(UIMAGE_NAME) -d $< $@
>
>
> The single quotes are consumed by shell.
>
>
>
>
>
>
> This is mainline + your patch set.
>
> masahiro@zoe:~/ref/linux(simon-v2)$ git grep UIMAGE_NAME
> scripts/Makefile.lib:UIMAGE_NAME ?=3D "Linux-$(KERNELRELEASE)"
> scripts/Makefile.lib:                   -n "$(UIMAGE_NAME)" -d $< $@
> scripts/Makefile.lib:                   --name "$(UIMAGE_NAME)" \
>
>
> You quoted the definition of UIMAGE_NAME,
> and also variable references.
>
>
>
>
> See how it is expanded.
>
>
> --name "$(UIMAGE_NAME)"
>
>
>  =3D=3D>
>
>
> --name ""Linux-$(KERNELRELEASE)""
>
>
>  =3D=3D>
>
>
> --name Linux-$(KERNELRELEASE)
>
>
>
>
> You added double quotes in a row, just to cancel it.

Yes, I understand that. But without the quotes in -n "$(UIMAGE_NAME)"
then the name cannot contain spaces. So we do need some sort of
quoting, right?

It just seems strange to use single quotes in a Makefile variable. I
found it confusing.

I think you are saying you want to keep the single quotes in the var
declaration and drop the quotes from the cmd_fit rule. I am OK with
that, but I do think it is unusual not to quote something which might
have spaces. It may cause confusion for others, as it did for me?

Anyway, I'll send a new version with the quoting reverted.

Regards,
Simon
