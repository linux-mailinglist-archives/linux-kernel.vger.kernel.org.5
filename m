Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1B479F049
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjIMRSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjIMRS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:18:27 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D911BEB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:17:57 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52f33659d09so5550080a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694625475; x=1695230275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pAP4KF+8eSt4DS+aDaiAbwkQFXc4IntKwjogbQWvkE=;
        b=Zkizt3K/6JQhbNbiAQSCK4oPKwYNqHSmLhPylAGwL2oX0qAUlhRt3jiUWzBi4Tw6mH
         ji3Avi8ct1iybwrg7L+RJfHyOb130/ppqJtkbk/t12LPcrAXUZ1TenPOnIzPmF5i2e6x
         n4/ttav8vVvTfn/vDFMvLzxRJSMU/4nKU4HktGcwYw/v9kz6KWA7VNa5Xu+G2UI82WAn
         R1fiQ8dYMAjfzocejtWQtomzdcrzs64q42C4+5XbY1ewS/jAyXCcNVPYZU5r9Aw/48NA
         qQ2aLTaUnhq02jxuSJkNpoZ3zMjO477ywKFUfZWlEXO3kQOn9V1sEyH4dwP6+8WvxP6R
         iK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694625475; x=1695230275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pAP4KF+8eSt4DS+aDaiAbwkQFXc4IntKwjogbQWvkE=;
        b=uZgavmtPpNiCCG45DFliVAex2MYcfl6k+bxUlj8kD18CEEKZB7gfK8av7OXbMKzIrA
         Lt3bxPpiE0+qI1jUuqh1EIuuEqlD4LFImhvJvGNyVHjlX+73yUHW8aTKRjcx3bOK3xW3
         fiht6p+8QaN+CpcNUtbnglUw3VSKI+wVLZtGtAMuG1jXNEVn8AH4AwBiVMv7orAbisWJ
         CF6Stz9KZ05OpQe1vTds/z9FknW7mnyvsFGhBN7zEM+xoC7KbRi17qSawkKD29Q5oq4a
         r2I5p0gCjMbZTNJMzWVA9dOiLSylSjP47ZJtFbJRWqHZrRzuY2AX9DcyHso1gsIE5ZOc
         MbNg==
X-Gm-Message-State: AOJu0YxpCaRZ5c54N2o3N3zoMkrbUYARTKsasIz8RCYo/Ak0d09Wf+nZ
        tGauJMWQboIv37NsWHQqRRPsuJLOEG5qoaPd5xZKySJZfOyWvmBUnkguJw==
X-Google-Smtp-Source: AGHT+IFqxcXMoA6E1GUkSWls1FWKy8HwJzuDU4KTCHVS+I4u5BDYFDfxxCW1WjC6TToCE7Uzc7DOgsV532Bh4nDloHk=
X-Received: by 2002:a05:6402:3708:b0:52f:f696:197b with SMTP id
 ek8-20020a056402370800b0052ff696197bmr1293082edb.1.1694625475236; Wed, 13 Sep
 2023 10:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230913-strncpy-drivers-edac-edac_mc_sysfs-c-v1-1-d232891b05b0@google.com>
 <CAFhGd8pGikrizmQPF7qD6C4NcYqBVqECEUqb0j_4fuS3rqeeXA@mail.gmail.com> <SJ1PR11MB6083BEE91F07BC4077FE38F5FCF0A@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083BEE91F07BC4077FE38F5FCF0A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Wed, 13 Sep 2023 10:17:43 -0700
Message-ID: <CAFhGd8r1u+u-6j0eLSSy-dB5SuQdJr4_0faOeAFiTk_P4kXg5g@mail.gmail.com>
Subject: Re: [PATCH] EDAC/mc_sysfs: refactor deprecated strncpy
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 8:13=E2=80=AFAM Luck, Tony <tony.luck@intel.com> wr=
ote:
>
> > `strncpy` is deprecated for use on NUL-terminated destination strings [=
1].
> >
> > We should prefer more robust and less ambiguous string interfaces.
> >
> > A suitable replacement is `strscpy_pad` [2] due to the fact that it gua=
rantees
> > NUL-termination on the destination buffer whilst maintaining the
> > NUL-padding behavior that `strncpy` provides. This may not be strictly
> > necessary but as I couldn't understand what this code does I wanted to
> > ensure that the functionality is the same.
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Note: build-tested only.
> > ---
> >  drivers/edac/edac_mc_sysfs.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.=
c
> > index 15f63452a9be..b303309a63cf 100644
> > --- a/drivers/edac/edac_mc_sysfs.c
> > +++ b/drivers/edac/edac_mc_sysfs.c
> > @@ -229,8 +229,7 @@ static ssize_t channel_dimm_label_store(struct devi=
ce *dev,
> >         if (copy_count =3D=3D 0 || copy_count >=3D sizeof(rank->dimm->l=
abel))
> >                 return -EINVAL;
> >
> > -       strncpy(rank->dimm->label, data, copy_count);
> > -       rank->dimm->label[copy_count] =3D '\0';
> > +       strscpy_pad(rank->dimm->label, data, copy_count);
>
> That doc page says the problem with strncpy() is that it doesn't guarante=
e to
> NUL terminate the target string. But this code is aware of that limitatio=
n and
> zaps a '\0' at the end to be sure.
>
> So this code doesn't suffer from the potential problems.

Right, the original code did not have an existing bug due to the
reason you mentioned. However, I'm pretty keen on eliminating uses of
this interface treewide as there is always a more robust and less
ambiguous option.


>
> If it is going to be fixed, then some further analysis of the original co=
de
> would be wise. Just replacing with strscpy_pad() means the code probably
> still suffers from the "needless performance penalty" also mentioned in
> the deprecation document.
Got it, sending a v2 that prefers `strscpy` to `strscpy_pad` resolving
the performance issue.

>
> -Tony
>

Thanks for the timely review!
Justin
