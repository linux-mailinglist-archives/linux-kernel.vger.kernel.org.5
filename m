Return-Path: <linux-kernel+bounces-22264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C30829B93
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9CB2283937
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CED48CE8;
	Wed, 10 Jan 2024 13:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gdd15CDR"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F7B219E4;
	Wed, 10 Jan 2024 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6810751e1fdso17086486d6.2;
        Wed, 10 Jan 2024 05:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704894349; x=1705499149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AImHcPePTa4X8irF6z53CgRBjh/qHTx0qzOkLCQqzVU=;
        b=Gdd15CDRoXytZXjCFzJwg5A21g742RADmsDoCxlanm0mJTjTUA19a12hkZRRRiF/RE
         pJ+dxHh0XhHb7bBH8VbxQ670RGU+WlAJjNmxJjGP6SNMDwcdVklbSv/8shg6xGraC02L
         XQSmcKsbGv2upscvdYvV5NVRC9EQnCOq20r19tGUU6VhT27FvaHQVT1oKZZ+7YJFiaj7
         wxbbWnR7xCWfYHi+vnlrkjMO+95MIPwrc1FJsqtLHHjwtgTDfb8G/3C8NG0D/BtKfT7w
         kBoyVpVgQdLxG0JNcRHfccpexM5va0BAjNlSl8ZjG9YYUcQN7mH5l8xwtJjI1kcozG4t
         VCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704894349; x=1705499149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AImHcPePTa4X8irF6z53CgRBjh/qHTx0qzOkLCQqzVU=;
        b=FYnH2+bsN0+6XpzkdkJaKvuAgTvbfNPv3SuD2FK7DK19YE2XuiGHZR60p1zOnj6EDi
         eKpEDA2fPxzOlI9azTKfgJzqwzaJoISjgBxw9PX7JvCZjjGxMrEEgZJFa7fOGBsW1mu5
         iMHUofuAU1wuMMcFGhD28rES1Pem+IQb2LotR3EroFFs28wl0XsBahrBBJ/+jLx4o/LX
         JEq9nqUk9CLb/j8CYhbAmNWHDM5/OZcS4dEqUIrtn6tnSMAlaEbOQVI5qbISVd7vb9iS
         thXZnDUBabeGVG5dxIVFF+HH8OVfxNt3q/xapL+SQSsZ14sjjDCTJ8RG5NaoF2QlZ+57
         kqYQ==
X-Gm-Message-State: AOJu0YxsNv/5iwC3u1Z0Kuv934gM1Rj4XOEwbEc4gTr04RUslWJ7jANX
	ivalLvtdXjWtW5Y6YwL6dS/7xf5WUN9BPN/5Pco=
X-Google-Smtp-Source: AGHT+IGjdFnr3WO7Ou/kYw1Yeqr+1mPCRTsBWXEkaPVirpKeMhwEm5irTrAYABsPlDlg5gW0dJ3F48qseuduVGTNbB8=
X-Received: by 2002:ad4:596f:0:b0:681:9cd:c96 with SMTP id eq15-20020ad4596f000000b0068109cd0c96mr1335715qvb.86.1704894348851;
 Wed, 10 Jan 2024 05:45:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de> <87b65f8e-abde-2aff-4da8-df6e0b464677@web.de>
 <05d334af-1a0f-4498-b57d-36a783288f07@web.de> <CAOQ4uxiRaTQyT1nxeRD7B89=VuA+KKEqi01LL1kqfJ17-qKKpw@mail.gmail.com>
 <d912872a-e70a-4e5d-aabe-26f289507f44@web.de> <CAOQ4uxjsuYy8BzgaHXaNa-S0+HZ_P-Fb1UEgOkbrdxQPz0Y6rQ@mail.gmail.com>
 <1df4916d-421c-4c87-8503-5a36934d03d8@web.de>
In-Reply-To: <1df4916d-421c-4c87-8503-5a36934d03d8@web.de>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 10 Jan 2024 15:45:37 +0200
Message-ID: <CAOQ4uxgx8m5Q6+DyfVaZUyFhFu_TAyOWLdHHUJfgOOkTDYMuiA@mail.gmail.com>
Subject: Re: [0/4] overlayfs: Adjustments for ovl_fill_super()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-unionfs@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 3:33=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> >>>> See also:
> >>>> https://lore.kernel.org/cocci/87b65f8e-abde-2aff-4da8-df6e0b464677@w=
eb.de/
> >>>> https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00115.html
> >>>
> >>> I will queue cleanup patches 1-2,
> >>
> >> Thanks for this positive feedback.
> >
> > Sorry, these patches do not apply to master branch and patch 1
> > is no longer correct in master branch and the new mount api changes.
>
> Do you want that I adapt the linked development ideas to the current situ=
ation
> a bit more?
>

No thanks.
Patch 1 just doesn't work for the new mount api.

>
> >>>                                   but I do not like patches 3/4 and 4=
/4.
> >>> I do not think that they make the code better to read or maintain.
> >>
> >> I would appreciate if the details for such change reluctance can be cl=
arified better.
> >
> > patch 3:
> > I much rather a single error handling label that takes care of
> > all the cleanups - it is harder to make mistakes and jump to
> > the wrong label when adding new error conditions.
>
> There are different coding style preferences involved.
>
> See also:
> https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+g=
oto+chain+when+leaving+a+function+on+error+when+using+and+releasing+resourc=
es
>

As long as coding styles are not mandatory
I prefer what we have right now.

>
> > patch 4:
> > Overlayfs uses this coding style all over the place
> >
> >   err =3D -ENOMEM;
> >   ofs->creator_cred =3D cred =3D prepare_creds();
> >   if (!cred)
> >       goto out_free_ofs;
> >
> > I don't see the benefit in making err =3D -ENOMEM conditional.
> > I don't see the style after your patch as clearly better than before.
>
> Can it be nicer to set error codes only in exceptional data processing si=
tuations?
>

It's a matter of taste.
I'll stay with what we have.

Thanks,
Amir.

