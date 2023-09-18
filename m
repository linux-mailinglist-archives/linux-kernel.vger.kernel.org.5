Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCAE7A407A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 07:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239684AbjIRFbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 01:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239707AbjIRFbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 01:31:42 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC40123
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 22:31:34 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9ada6b0649fso539497866b.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 22:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695015093; x=1695619893; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7N4oxaoXR8OLM30Gi2Xbyz8uOSGQciA9cghxlboWMQY=;
        b=NT07OjnxtjYejDQJR3Lko+DNz6kAWwEwNj/ICyCsgDy3yy7DroOFMtdOv3KKfy41dV
         pzbu1ztm3L8F2AlviXymq0aKqLR6/8gmaWCE4Hu/sLTurUHXh/NwCKKnd5hVqA01ep0K
         XePqNvc+hhGXRr9SK9cqmEW/1b+XOl7+E13KuINd2IrdKUkpaiq+EjvlZ6qMAcKRMOZE
         iTSZ/SuoZLYiOuqNuekqtxR9RDs+4SdpsKDyhcHBX86j76JX9LC7nwEi7jWtPecuwYdq
         QSNikWYX0HkkpFvbSclDgoKBVqVgqWPvQaemmcwEbkc1Y7y4lPbO3TldgSAeADZNQHGc
         xWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695015093; x=1695619893;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7N4oxaoXR8OLM30Gi2Xbyz8uOSGQciA9cghxlboWMQY=;
        b=n0nclAkHQ+J+NdS//cY7a/kmAso+1c6fLPhSNKZbBvpaMhHTzY9i+h+vdakoyc0GEW
         tBSYd0QXSIPLCOvudqwFLV/x4l4wSP5D3iIGgx9mAwTNTCcyKn9F95R2Y1nj9izLfcZL
         9CwZ9qnqvFj2u+h7P4MkTzMRcnsk6VuFVmTup/eENFEw8QdzNwp/q2U2R7uebOurhzcL
         JSXQB7zG9TINvaMTa1xCKb73zLpVNwffJwPK5Ec3Jiq37dSWofANM/HdC221y03tu/AE
         FbpzVaWuJxMg6x9rpOdMyaxwvjNz5+LL8VZ9vksws5vOxgcSj6qDKavjPViAhpX98pvt
         Ctfw==
X-Gm-Message-State: AOJu0YycNBFXqPx+oxjWJcyuht4NqJ/N676n2DEt/OpmEnzsnfZGiHqk
        Fl6nCfdnD7uuFYwYVkPYptYeEkgVADiENtcD+im1Tg==
X-Google-Smtp-Source: AGHT+IHO/HLdvDCUNraq64Xji78XSyEnw6LFpBJZaR+ge9nW+ZQpcaVANqNFXDdUcfxdNuAUr/nDQPkAGcnk2kRbb4g=
X-Received: by 2002:a17:906:7398:b0:9ad:aa7d:946b with SMTP id
 f24-20020a170906739800b009adaa7d946bmr6494138ejl.8.1695015092846; Sun, 17 Sep
 2023 22:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230824-strncpy-drivers-accessibility-speakup-kobjects-c-v1-1-3a1ef1221e90@google.com>
 <202308251439.36BC33ADB2@keescook> <CAFhGd8r6A4VH5C=yF1WHKEPY86oh6PEzt6wuxPxsJAD0XKfrsQ@mail.gmail.com>
 <20230916230807.motaqyb5gqzqjvub@begin>
In-Reply-To: <20230916230807.motaqyb5gqzqjvub@begin>
From:   Justin Stitt <justinstitt@google.com>
Date:   Sun, 17 Sep 2023 22:31:20 -0700
Message-ID: <CAFhGd8rrHUGO424S54DN6yTH4YnOwo9UGhgffgoHfsANza8YHA@mail.gmail.com>
Subject: Re: [PATCH] accessibility: speakup: refactor deprecated strncpy
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Justin Stitt <justinstitt@google.com>,
        Kees Cook <keescook@chromium.org>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2023 at 4:08=E2=80=AFPM Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
>
> Hello,
>
> Justin Stitt, le ven. 25 ao=C3=BBt 2023 15:41:03 -0700, a ecrit:
> > Thanks for the review Kees and Samuel. Hoping to get this picked-up soo=
n :)
> >
> > FWIW, I've quickly copy/pasted Kees' suggested refactor of
> > synth_direct_store and rebased against v6.5-rc7 if anyone has the
> > means by which to test it.
> >
> > TEST PATCH BELOW
> > ---
> > From e7216bca30673a162660c51f8bad3b463d283041 Mon Sep 17 00:00:00 2001
> > From: Justin Stitt <justinstitt@google.com>
> > Date: Fri, 25 Aug 2023 22:32:03 +0000
> > Subject: [PATCH NEEDS TEST] synth_direct_store refactor to use synth_wr=
ite
> >
> > I've just copy/pasted Kees' suggestion here [1] and rebased it against
> > 6.5-rc7.
> >
> > This patch needs testing as it refactors behavior in synth_direct_store=
.
> >
> > [1]: https://lore.kernel.org/all/202308251439.36BC33ADB2@keescook/
> >
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
>
> Tested-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
>
> but please submit it properly :) It was completely mangled in the mail.

Got it, here's a v2:
https://lore.kernel.org/all/20230918-strncpy-drivers-accessibility-speakup-=
kobjects-c-v2-1-d5b1976c5dbf@google.com/

>
> > ---
> >  drivers/accessibility/speakup/kobjects.c | 25 +++++++++++-------------
> >  1 file changed, 11 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/accessibility/speakup/kobjects.c
> > b/drivers/accessibility/speakup/kobjects.c
> > index a7522d409802..0dfdb6608e02 100644
> > --- a/drivers/accessibility/speakup/kobjects.c
> > +++ b/drivers/accessibility/speakup/kobjects.c
> > @@ -413,27 +413,24 @@ static ssize_t synth_direct_store(struct kobject =
*kobj,
> >     struct kobj_attribute *attr,
> >     const char *buf, size_t count)
> >  {
> > - u_char tmp[256];
> > - int len;
> > - int bytes;
> > - const char *ptr =3D buf;
> > + char *unescaped;
> >   unsigned long flags;
> >
> >   if (!synth)
> >   return -EPERM;
> >
> > - len =3D strlen(buf);
> > + unescaped =3D kstrdup(buf, GFP_KERNEL);
> > + if (!unescaped)
> > + return -ENOMEM;
> > +
> > + string_unescape_any_inplace(unescaped);
> > +
> >   spin_lock_irqsave(&speakup_info.spinlock, flags);
> > - while (len > 0) {
> > - bytes =3D min_t(size_t, len, 250);
> > - strncpy(tmp, ptr, bytes);
> > - tmp[bytes] =3D '\0';
> > - string_unescape_any_inplace(tmp);
> > - synth_printf("%s", tmp);
> > - ptr +=3D bytes;
> > - len -=3D bytes;
> > - }
> > + synth_write(unescaped, strlen(unescaped));
> >   spin_unlock_irqrestore(&speakup_info.spinlock, flags);
> > +
> > + kfree(unescaped);
> > +
> >   return count;
> >  }
> >
> > --
> > 2.42.0.rc1.204.g551eb34607-goog
> >
>
> --
> Samuel
> ---
> Pour une =C3=A9valuation ind=C3=A9pendante, transparente et rigoureuse !
> Je soutiens la Commission d'=C3=89valuation de l'Inria.
