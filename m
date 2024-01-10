Return-Path: <linux-kernel+bounces-22221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E56B829B18
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB64286BD8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49153487B7;
	Wed, 10 Jan 2024 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mz+pWCaQ"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485004878D;
	Wed, 10 Jan 2024 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-429b7910697so2824201cf.1;
        Wed, 10 Jan 2024 05:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704892759; x=1705497559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liSzDRZehByCujutdLomxYVsOIIXj62EeJs6zgUIbJ8=;
        b=Mz+pWCaQc/2MCe71Ji4K1RPrdSGnL350uFqBcCKfWHicrQJvpCaqhVvWzn86eRMoeA
         ejAqeKvbvh0w1nU6BayMuq9k2P+BHiUQl87cHjhlmE+pyslPkxlebwCWKUaX6ftQEWV+
         r/WN4Ff7fhySvTD7aT8mIOB1xb6DBHc6Ld2fwota6ZfHVviFYXv8pZ/RaP7Zhp3UXEmb
         fURKIdI9fdp2e9ZQozI/Oopnf2dwiGcUBUWOsPbZvBG2ynvh2+/QxZfH2kM+0B865TD1
         qDiE54hXpa1FeMnGP0NsEnoIBBWmDb0rguaO15QeNIzWc839Lq8dSdZLxwXbwCS9o/Oz
         3XIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704892759; x=1705497559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liSzDRZehByCujutdLomxYVsOIIXj62EeJs6zgUIbJ8=;
        b=Hceex1st0Ojyu7WtA/spyz1e7Gm8sZ35H3kD3DS+Za574F/qxIzZKX91dq06ZufNgB
         mFdKf2hNPWUw3k6K5BGfJPSq4Qe6Cq5uToZlBwe2H/2+7vcYp9fRMlNi6H9Uq2VFWFML
         oS1CRO1a8H47PaAtgPHZtH3yhx7wHLlwVp+LadRKXhmjlK6rPYgcOOiNFNFIuVBoKo6I
         xwyqcBdV2qc3/ZYW2j7S+BUm9ljeWcfjuPYJsRKNWWquqglAqtV8bk3VczCu2/7R3Gi0
         Rm/uIuPJCRBvi+2V9fxFHOLW0M+fVo1ovPNamhkWuucJQn2gk+uQQDsEeRyXeXg77Ald
         DM0Q==
X-Gm-Message-State: AOJu0Yz+5NDfERzf2sr6Noc/EMD2upz9uG4Q925+9QrQBNv/dNo2Ychv
	PaumJ1+kukvFZUhhfga9to5H0tTBtD9069slQyQ=
X-Google-Smtp-Source: AGHT+IGcrrq+I8hwbxPBmCgLqJ5ycxNtTDl/NpLbNNik/6JjZSHy04GALI6d2ZjfKUVwNJdXG6BXLL4eANYYYtYNHCc=
X-Received: by 2002:a05:6214:ac9:b0:67f:59a8:5d7f with SMTP id
 g9-20020a0562140ac900b0067f59a85d7fmr75196qvi.44.1704892759178; Wed, 10 Jan
 2024 05:19:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de> <87b65f8e-abde-2aff-4da8-df6e0b464677@web.de>
 <05d334af-1a0f-4498-b57d-36a783288f07@web.de> <CAOQ4uxiRaTQyT1nxeRD7B89=VuA+KKEqi01LL1kqfJ17-qKKpw@mail.gmail.com>
 <d912872a-e70a-4e5d-aabe-26f289507f44@web.de>
In-Reply-To: <d912872a-e70a-4e5d-aabe-26f289507f44@web.de>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 10 Jan 2024 15:19:07 +0200
Message-ID: <CAOQ4uxjsuYy8BzgaHXaNa-S0+HZ_P-Fb1UEgOkbrdxQPz0Y6rQ@mail.gmail.com>
Subject: Re: [0/4] overlayfs: Adjustments for ovl_fill_super()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-unionfs@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 3:01=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> >> See also:
> >> https://lore.kernel.org/cocci/87b65f8e-abde-2aff-4da8-df6e0b464677@web=
de/
> >> https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00115.html
> >
> > I will queue cleanup patches 1-2,
>
> Thanks for this positive feedback.

Sorry, these patches do not apply to master branch and patch 1
is no longer correct in master branch and the new mount api changes.

>
>
> >                                   but I do not like patches 3/4 and 4/4=
.
> > I do not think that they make the code better to read or maintain.
>
> I would appreciate if the details for such change reluctance can be clari=
fied better.

patch 3:
I much rather a single error handling label that takes care of
all the cleanups - it is harder to make mistakes and jump to
the wrong label when adding new error conditions.

patch 4:
Overlayfs uses this coding style all over the place

  err =3D -ENOMEM;
  ofs->creator_cred =3D cred =3D prepare_creds();
  if (!cred)
      goto out_free_ofs;

I don't see the benefit in making err =3D -ENOMEM conditional.
I don't see the style after your patch as clearly better than before.

Thanks,
Amir.

