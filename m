Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634FC7D8C63
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 01:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345029AbjJZXzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 19:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJZXy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 19:54:57 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C125D47
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 16:54:55 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53fc7c67a41so5473851a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 16:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698364493; x=1698969293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAaMO15sOP8ipf1i58B2kwq6lW6S/mlb1MuQFi51atg=;
        b=aRPnoCjBRbSaph76FeHWW3gCs5yDx4o6TmolrI2c1TyLLg4hN6EIw3rQI5wkMW4+k7
         ehddxuQ6p0FXwx9xUknH6SCSgd1VlBqYENTru28gt3/1kpDD/tSeem9iEQIdAmrNClC5
         ypUohhq005JaPqiddwt19ycqFfHCrl1ZBLrEZKOq5BNouD3PISkXM5GDtZyXF6+DrMLi
         HhMPA1rbAcdtQTq/iUu4CCMF+fByus3I7vaqsy9Z47ufcaZNlI9LqtMi/UxtQfs4T5+H
         QNF4qtvDrnpI3DQu0+AH9J9gABXNMzMQjJ9WP46ONkJMX0GyB3OC18xVxf9wUm4mXl+l
         b9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698364493; x=1698969293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAaMO15sOP8ipf1i58B2kwq6lW6S/mlb1MuQFi51atg=;
        b=lm8AWGU+gjtJRfgoTvvfpHxHrCvX+zyO80e6pVidiZLudy9t1UxkrOjXVfDNZ/IVMb
         Aej2mF/zOsUkFN3Y55DGBD0e8aoaybAn7hoBR6bjpNCpspcr2LItvmEGEW+Tvkw++km0
         jH9jHtOgd8elKZVf/QHqpnZbHFa4DnZsAfAzUxYpl5F/oIfJqXJXq0vdTl4bNDanEZCo
         SkbbubaNoV0owHHXu1xJpHumyQF3R7KvGFbXyrutsjFBbQ9miVUsXoHDWwX4DTY22ZLT
         otUarMQzM7puajRdlUTpZLsh10ZV8rhO3cvxSgLfncmRlk2mL/sLRdVUnoZ/DVoQAQtf
         YrpQ==
X-Gm-Message-State: AOJu0YyLRd69nvu/CdJrWDGfMqtBcBuRMZyoRySy3rF8LymoVu4hQsZR
        ik5JoNMG3Ylsmm4bd2/3rk6k6WXgI2f7sf88PItY+4sXBtsREiuFmrqgKELGiyg=
X-Google-Smtp-Source: AGHT+IFgSYgDRXMomRCJLvfmtBG0oWjLSnEpDTrZuDKhKUfvgoZ6VAvavf/RCCAKcVAGSp5lLrwWL5ikv5eVrnLN/Ik=
X-Received: by 2002:a17:907:3e9f:b0:9b6:3be9:a8f with SMTP id
 hs31-20020a1709073e9f00b009b63be90a8fmr1446357ejc.20.1698364493482; Thu, 26
 Oct 2023 16:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230921-strncpy-drivers-iio-proximity-sx9324-c-v1-1-4e8d28fd1e7c@google.com>
 <20230923184751.41d52b9d@jic23-huawei>
In-Reply-To: <20230923184751.41d52b9d@jic23-huawei>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 26 Oct 2023 16:54:41 -0700
Message-ID: <CAFhGd8putfBJH+ox4rdX478qLd+iDDEssMV2CwfPBd=C_wJzqw@mail.gmail.com>
Subject: Re: [PATCH] iio: sx9324: replace deprecated strncpy
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sat, Sep 23, 2023 at 10:47=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Thu, 21 Sep 2023 07:01:01 +0000
> Justin Stitt <justinstitt@google.com> wrote:
>
> > `strncpy` is deprecated for use on NUL-terminated destination strings [=
1].
> >
> > We should prefer more robust and less ambiguous string interfaces.
> >
> > `prop` is defined as this string literal with size 30 (including null):
> > |       #define SX9324_PROXRAW_DEF "semtech,ph01-proxraw-strength"
> > |             char prop[] =3D SX9324_PROXRAW_DEF;
> >
> > Each of the strncpy->strscpy replacements involve string literals with =
a
> > size less than 30 which means there are no current problems with how
> > strncpy is used. However, let's move away from using strncpy entirely.
> >
> > A suitable replacement is `strscpy` [2] due to the fact that it
> > guarantees NUL-termination on the destination buffer without
> > unnecessarily NUL-padding.
> >
> > Moreover, let's opt for the more conventional `sizeof()` as opposed to
> > `ARRAY_SIZE` for these simple strings.
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > FWIW: It seems fragile to base future `prop` stores on the
> > size of it's default string.
>
> Agreed - can we just get rid of the copying?  Just set a const char *
> to point to appropriate string instead and use that?
>
> The dance is just about reasonable for the case where there is
> a string format being used to fill in the numbers, here I can't see any
> advantage at all. (for the other case, a kasprintf() or similar is probab=
ly
> more appropriate anyway) given this isn't a particular hot path.

I sent a [v2]! Can you see if this matches your vision here?

>
> Jonathan
> >
> > Note: build-tested
> > ---
> >  drivers/iio/proximity/sx9324.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9=
324.c
> > index 438f9c9aba6e..25ac2733bcef 100644
> > --- a/drivers/iio/proximity/sx9324.c
> > +++ b/drivers/iio/proximity/sx9324.c
> > @@ -937,11 +937,9 @@ sx9324_get_default_reg(struct device *dev, int idx=
,
> >       case SX9324_REG_AFE_CTRL4:
> >       case SX9324_REG_AFE_CTRL7:
> >               if (reg_def->reg =3D=3D SX9324_REG_AFE_CTRL4)
> > -                     strncpy(prop, "semtech,ph01-resolution",
> > -                             ARRAY_SIZE(prop));
> > +                     strscpy(prop, "semtech,ph01-resolution", sizeof(p=
rop));
> >               else
> > -                     strncpy(prop, "semtech,ph23-resolution",
> > -                             ARRAY_SIZE(prop));
> > +                     strscpy(prop, "semtech,ph23-resolution", sizeof(p=
rop));
> >
> >               ret =3D device_property_read_u32(dev, prop, &raw);
> >               if (ret)
> > @@ -1012,11 +1010,9 @@ sx9324_get_default_reg(struct device *dev, int i=
dx,
> >       case SX9324_REG_PROX_CTRL0:
> >       case SX9324_REG_PROX_CTRL1:
> >               if (reg_def->reg =3D=3D SX9324_REG_PROX_CTRL0)
> > -                     strncpy(prop, "semtech,ph01-proxraw-strength",
> > -                             ARRAY_SIZE(prop));
> > +                     strscpy(prop, "semtech,ph01-proxraw-strength", si=
zeof(prop));
> >               else
> > -                     strncpy(prop, "semtech,ph23-proxraw-strength",
> > -                             ARRAY_SIZE(prop));
> > +                     strscpy(prop, "semtech,ph23-proxraw-strength", si=
zeof(prop));
> >               ret =3D device_property_read_u32(dev, prop, &raw);
> >               if (ret)
> >                       break;
> >
> > ---
> > base-commit: 2cf0f715623872823a72e451243bbf555d10d032
> > change-id: 20230921-strncpy-drivers-iio-proximity-sx9324-c-8c3437676039
> >
> > Best regards,
> > --
> > Justin Stitt <justinstitt@google.com>
> >
>

[v2]: https://lore.kernel.org/r/20231026-strncpy-drivers-iio-proximity-sx93=
24-c-v2-1-cee6e5db700c@google.com

Thanks
Justin
