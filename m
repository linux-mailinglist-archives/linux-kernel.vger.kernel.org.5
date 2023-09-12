Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6553579D9ED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 22:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjILUMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 16:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjILUMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 16:12:52 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF67E4B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:12:48 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c1c66876aso772418866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694549567; x=1695154367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dELf8UBwcQIad2hf1gwWWXOeHH/qzD9ZkjJM29lBufQ=;
        b=OiCXJt4u6Qez/b1UcTCz2NeKl5Ub9gbIyo0XYhKwNW8Cmp2P2V6LGfoocYl5puo3ey
         msU23WCZSGDkzTZ5wQLWTfQ+tqLwdKFwuk0FL++1zuv6RWNPwSVxlVclHRsfrtVkytUi
         zHvr6qETB2D7jfmbOB8iy/Zk4oLwhy6OwuC0AutziWCxSbOMxjGAckpBI6cAIGSI1K8M
         idgCa3+QXTjDw0Ud/pglodVHxDSBEZiikGHQ9VjtVGvgXNr/uW8qrlbZ39kh85kSvLBY
         KPG+cKeGqYQGZuMFv58MUjTTGCwDYZKKfzneZEFoV2g7ISExhd+omFuXyv3GmjkpciYY
         j5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694549567; x=1695154367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dELf8UBwcQIad2hf1gwWWXOeHH/qzD9ZkjJM29lBufQ=;
        b=LDlI27tTrPr68JH0qzmlww/gMtcMu/wY9PxvPgWf9XDSu3yvZ8kevXI6m2EOUabLGh
         0PdIKd8OybtFojm4PYS4nsBWiGHA+pD11KHssOqX7UePFiRjR3sBFDcf3q/jM8b5keoq
         M96N1Tdzbld2QJ2EZwVAakqG8HeGm+PPdLV/4sxTANX7wepwr0VMSinAZZKREzMydprA
         5s+R+04Tq/lYDs9PgzbfmXc+Ft7JJEyGCe6evLARAP+7qSNVFAFB/BzSVyz+OkLSaE/q
         OJiXenFeTZlx9K2l38oW2JI8eiKqEQGtfNTem0h24VbCfz4gKeaOJVP93z0pk+Y3ey1L
         1J2A==
X-Gm-Message-State: AOJu0YwmGXBippl210tVQQYF4si6Pw7ZiZMJQtkLrokfluQuDQS6TPGp
        lXEjQUQIWhRROY9jAc80Zu8Owlmk5YevFluLfy2wlwy/txPhuyUgd3NBdA==
X-Google-Smtp-Source: AGHT+IFA71O/TusvmPfckZ425fl5twMGsWNyTgKIYB+dpo1zBfMhnPynfQtMXv5q68jWEe7bLYuGJjBOKblkkuDYSPs=
X-Received: by 2002:a17:907:2cf6:b0:9a9:f09d:7c10 with SMTP id
 hz22-20020a1709072cf600b009a9f09d7c10mr258133ejc.11.1694549566970; Tue, 12
 Sep 2023 13:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230911-strncpy-arch-um-os-linux-drivers-ethertap_user-c-v1-1-d9e53f52ab32@google.com>
 <CAMuHMdXJMZ6FebNn01C9EPsZAiJs-n5tp4j2hufAAr=zXOsSOQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXJMZ6FebNn01C9EPsZAiJs-n5tp4j2hufAAr=zXOsSOQ@mail.gmail.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 12 Sep 2023 13:12:35 -0700
Message-ID: <CAFhGd8r9Ow2xmJ++apef0rn2DHBhKm9BvfLooMTqzyaOhqbEgQ@mail.gmail.com>
Subject: Re: [PATCH] um,ethertap: refactor deprecated strncpy
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 12:36=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Justin,
>
> Thanks for your patch!
>
> On Mon, Sep 11, 2023 at 7:53=E2=80=AFPM Justin Stitt <justinstitt@google.=
com> wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings [=
1].
> >
> > `gate_buf` should always be NUL-terminated and does not require
> > NUL-padding. It is used as a string arg inside an argv array given to
>
> Can you please explain why it does not require NUL-padding?
> It looks like this buffer is passed eventually to a user space
> application, thus possibly leaking uninitialized stack data.

It looks like it's being passed as a list of command-line arguments in
`run_helper()`. Should this be NUL-padded due to its eventual use in
user space? If we think yes I can send a v2. Thanks for pointing this
out.


>
> > `run_helper()`. Due to this, let's use `strscpy` as it guarantees
> > NUL-terminated on the destination buffer preventing potential buffer
> > overreads [2].
> >
> > This exact invocation was changed from `strcpy` to `strncpy` in commit
> > 7879b1d94badb ("um,ethertap: use strncpy") back in 2015. Let's continue
> > hardening our `str*cpy` apis and use the newer and safer `strscpy`!
> >
> > Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on=
-nul-terminated-strings[1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Cc: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> >  arch/um/os-Linux/drivers/ethertap_user.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/um/os-Linux/drivers/ethertap_user.c b/arch/um/os-Linu=
x/drivers/ethertap_user.c
> > index 9483021d86dd..3363851a4ae8 100644
> > --- a/arch/um/os-Linux/drivers/ethertap_user.c
> > +++ b/arch/um/os-Linux/drivers/ethertap_user.c
> > @@ -105,7 +105,7 @@ static int etap_tramp(char *dev, char *gate, int co=
ntrol_me,
> >         sprintf(data_fd_buf, "%d", data_remote);
> >         sprintf(version_buf, "%d", UML_NET_VERSION);
> >         if (gate !=3D NULL) {
> > -               strncpy(gate_buf, gate, 15);
> > +               strscpy(gate_buf, gate, sizeof(gate_buf));
> >                 args =3D setup_args;
> >         }
> >         else args =3D nosetup_args;
> >
> > ---
> > base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> > change-id: 20230911-strncpy-arch-um-os-linux-drivers-ethertap_user-c-85=
9160d13f59
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
