Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0B676C1B2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 02:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjHBAzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 20:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjHBAzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 20:55:12 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46001269E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 17:55:10 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5221ee899a0so8263523a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 17:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690937708; x=1691542508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFc6KtDtqS8yIVjdabllS2g25EbuzBtEqWN/vJqgYpc=;
        b=dq6Zhf8C3OcxW3ll3KRSFyua9wyyLZCM2eBSEO1zCGZWGoLn0TZdsMwOTVMxD8vsVC
         3rbDxlR9vJU7o0rdy/8DGC7W0Q9xMqNxCTJonIpP39VEHPdEAoI/q26BS6KmFvOEZ36H
         AS8Dh00XFOgCdbI8pPBjrKdJD/kWMQ0ULtnLC3EHvgl1PyDi+jb3JZOhEtBANtWZYza3
         ztL98mHoLdCejDrO8MVtht54ha0j/bOC+PgbJWtZM8SQqoJchmZreeXtSQZIiKY3+Bnt
         paooDUQYoee6pRLSZ3rzSkVAFkPdgWJThVxFlr6vrxLbAynoL7CLd5hBqmx0+6dQykXv
         QA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690937708; x=1691542508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFc6KtDtqS8yIVjdabllS2g25EbuzBtEqWN/vJqgYpc=;
        b=S8Bs9meeclT6nflUognrnUwL5VbPclTTP2d0c8dRjnMKimQNvO9PNvgV9eB4858f3O
         /WLLwepQvpi6BRaQXfWDUbb5PfwqyeIKrR2d+MhpmBYHXiwho8QPkZB7qgJwMBFuesrV
         HBHOQenFvqnxAHiOVq8RNBVY+acZvuQjFrR+teBhhqqxizdyLDD1EpVx5CEINT1S/sJK
         XTXnwsz+/hZh2mw6Om0P0G1pPRFLnKlDFQV/ZvbyRBotL2LiDqv9tX8wPP4O9TrdorRd
         2Dk7jEAIBbRLrmpVRXXQ/PvXkxizFtDYeuA/WcRQZmXNES8weLobNvNUk7LdcbtyWApK
         UlOg==
X-Gm-Message-State: ABy/qLYct/GYTzOYeGSTuwOYadnCe6Xq0qdV82u2tw7mM7pvQ8cFlrwe
        xlDwzH+576mJQryKZsR2Fj+6ZRb/GfZIjVlGkwRLmKGh8YUe97QnRFf3mpcS4h0=
X-Google-Smtp-Source: APBJJlEpD75Ye4uyC9DUEuc0SCWDss42SjlbL4JrqOnsltQJqjzRz4LWoP0n1hYllFamW8mZirqJRiWhzz62/EtNwDI=
X-Received: by 2002:aa7:c0d5:0:b0:522:55bf:21af with SMTP id
 j21-20020aa7c0d5000000b0052255bf21afmr3564453edp.7.1690937708452; Tue, 01 Aug
 2023 17:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230801-drivers-net-wireless-intel-ipw2x00-v1-1-ffd185c91292@google.com>
 <202308011602.3CC1C0244C@keescook>
In-Reply-To: <202308011602.3CC1C0244C@keescook>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 1 Aug 2023 17:54:54 -0700
Message-ID: <CAFhGd8rrCgSa8BMOSxRFeto6w=Vn-SMdVU4Dg5zfSSLe5HBZ4w@mail.gmail.com>
Subject: Re: [PATCH] wifi: ipw2x00: replace deprecated strncpy with strscpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 4:25=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
>
> On Tue, Aug 01, 2023 at 09:53:36PM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings [=
1].
> >
> > We can massively simplify the implementation by removing the ternary
> > check for the smaller of `count` and `sizeof(buffer) - 1` as `strscpy`
> > guarantees NUL-termination of its destination buffer [2]. This also
> > means we do not need to explicity set the one past-the-last index to
> > zero as `strscpy` handles this.
> >
> > Furthermore, we can also utilize `strscpy`'s return value to populate
> > `len` and simply pass in `sizeof(buffer)` to the `strscpy` invocation
> > itself.
> >
> > [1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-=
nul-terminated-strings
> > [2]: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.=
html
> >
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> >  drivers/net/wireless/intel/ipw2x00/ipw2200.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net=
/wireless/intel/ipw2x00/ipw2200.c
> > index dfe0f74369e6..8f2a834dbe04 100644
> > --- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
> > +++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
> > @@ -1462,15 +1462,12 @@ static ssize_t scan_age_store(struct device *d,=
 struct device_attribute *attr,
> >       struct ipw_priv *priv =3D dev_get_drvdata(d);
> >       struct net_device *dev =3D priv->net_dev;
> >       char buffer[] =3D "00000000";
> > -     unsigned long len =3D
> > -         (sizeof(buffer) - 1) > count ? count : sizeof(buffer) - 1;
> >       unsigned long val;
> >       char *p =3D buffer;
> >
> >       IPW_DEBUG_INFO("enter\n");
> >
> > -     strncpy(buffer, buf, len);
> > -     buffer[len] =3D 0;
> > +     ssize_t len =3D strscpy(buffer, buf, sizeof(buffer));
>
> This means "len" could become -E2BIG, which changes the behavior of this
> function. The earlier manipulation of "len" seems to be trying to
> explicitly allow for truncation, though. (if buffer could hold more than
> "count", copy "count", otherwise copy less)
>
> So it looks like -E2BIG should be ignored here? But since this is a
> sysfs node (static DEVICE_ATTR_RW(scan_age)), I actually think the
> original code may be bugged: it should return how much was read from
> the input... and technically this was true, but it seems the intent
> is to consume the entire buffer and set a result. It's possible "len"
> is entirely unneeded and this should just return "count"?
>
> And, honestly, I think it's likely that most of this entire routine shoul=
d
> be thrown out in favor of just using kstrtoul() with base 0, as sysfs
> input buffers are always NUL-terminated. (See kernfs_fop_write_iter().)

Great suggestion, instead of v2'ing this patch I've opted to create a
new one due to it being slightly larger scope than just replacing
`strncpy`.

Patch:  https://lore.kernel.org/r/20230802-wifi-ipw2x00-refactor-v1-1-60476=
59410d4@google.com

>
>
> diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/w=
ireless/intel/ipw2x00/ipw2200.c
> index dfe0f74369e6..780f5613e279 100644
> --- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
> +++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
> @@ -1461,25 +1461,11 @@ static ssize_t scan_age_store(struct device *d, s=
truct device_attribute *attr,
>  {
>         struct ipw_priv *priv =3D dev_get_drvdata(d);
>         struct net_device *dev =3D priv->net_dev;
> -       char buffer[] =3D "00000000";
> -       unsigned long len =3D
> -           (sizeof(buffer) - 1) > count ? count : sizeof(buffer) - 1;
>         unsigned long val;
> -       char *p =3D buffer;
>
>         IPW_DEBUG_INFO("enter\n");
>
> -       strncpy(buffer, buf, len);
> -       buffer[len] =3D 0;
> -
> -       if (p[1] =3D=3D 'x' || p[1] =3D=3D 'X' || p[0] =3D=3D 'x' || p[0]=
 =3D=3D 'X') {
> -               p++;
> -               if (p[0] =3D=3D 'x' || p[0] =3D=3D 'X')
> -                       p++;
> -               val =3D simple_strtoul(p, &p, 16);
> -       } else
> -               val =3D simple_strtoul(p, &p, 10);
> -       if (p =3D=3D buffer) {
> +       if (kstrtoul(buf, 0, &val)) {
>                 IPW_DEBUG_INFO("%s: user supplied invalid value.\n", dev-=
>name);
>         } else {
>                 priv->ieee->scan_age =3D val;
> @@ -1487,7 +1473,7 @@ static ssize_t scan_age_store(struct device *d, str=
uct device_attribute *attr,
>         }
>
>         IPW_DEBUG_INFO("exit\n");
> -       return len;
> +       return count;
>  }
>
>  static DEVICE_ATTR_RW(scan_age);
>
>
> -Kees
>
> >
> >       if (p[1] =3D=3D 'x' || p[1] =3D=3D 'X' || p[0] =3D=3D 'x' || p[0]=
 =3D=3D 'X') {
> >               p++;
> >
> > ---
> > base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
> > change-id: 20230801-drivers-net-wireless-intel-ipw2x00-d7ee2dd17032
> >
> > Best regards,
> > --
> > Justin Stitt <justinstitt@google.com>
> >
>
> --
> Kees Cook
