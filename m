Return-Path: <linux-kernel+bounces-20239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08699827C4A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97808283C4E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 00:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AEB138A;
	Tue,  9 Jan 2024 00:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHpUklRV"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813FC635;
	Tue,  9 Jan 2024 00:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cd1a1c5addso28071591fa.1;
        Mon, 08 Jan 2024 16:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704761577; x=1705366377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ns81+2qq5q/MiVZ1HyELxVhRwQ1AGVaFpIYsF5PcvU8=;
        b=QHpUklRVVMotq1wCI1UKDMhYzeAEVWsL9aTe9mnSTVyDnatReUlFV8YgG82u1a75uG
         Ued1GS3Qmx0oFdganrGFpoZ3AaR73+sfPuJ4xSzeqfGbdk5PuhXQXnPnv1tKtOa9I2bx
         IQ+Ykda6CJDag0i4EJ1aA6etPRp+ZmuKztyuDrhfdmFSWyyJ+trLXV5hB6KQKgEGv6Yj
         wMqz4DJi1HeDMw5RdMNP+UpOxhvknoWS9IZuEnAQUsXxQUdYf+j7tT7AZHYUxlZBLJPt
         AyHAIm3Sw1qgHVdqMDkt4DYLXBp5nvaS4V6S01bjEAUPMZfpcGNrQ6Zl+cWwoywxJ5LG
         YGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704761577; x=1705366377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ns81+2qq5q/MiVZ1HyELxVhRwQ1AGVaFpIYsF5PcvU8=;
        b=JQfWIcZByTlPZKJNE4YYUvITTJQBJnDnHrb7deU+bWJwykoSpvFDudp8UMwU4ytpaM
         d9Rpf1I/ITANMwHVN/14pMVYutpUFkkkl0uV/kf6izJStkPyb2z6UaDaluYnYANCKKjL
         9vhLgTMAQWageIDx2V7StEgpXtp6kTk5dEETHHsGB/NT95MnkMbqdEJV0PZKXTCORcb8
         FNHDMiblGoRUwqH6WeBBHuYPXgtME1InFYxTedOQ0ehmq6Fxiad6LTaTH8O8fvWULlfR
         Mro8wS66LpJDIkO7mLh6Tjz3gPeMZd2HpBhrIfe88SPggWg8js2H8a+4Ez2LenM/7ngt
         XJdQ==
X-Gm-Message-State: AOJu0Yw6Sy5qght2Z0JlOsYf1+o+hcVcVP3qOnV0JA34anR1lemv9nCl
	Wq/oZTQRPq8mVq34dY7Bhm/yL+h8Cz8qgsWU6puIWgKSit0=
X-Google-Smtp-Source: AGHT+IEtfoapUrGx78KL3vW2i+Kbuu0w2ubd3F3CIu851yVKH9mVpx5OwEw+LbZthofdaxFixGqWX97MB7kU4P4OWz0=
X-Received: by 2002:a2e:b8c7:0:b0:2cd:662a:ecdb with SMTP id
 s7-20020a2eb8c7000000b002cd662aecdbmr65203ljp.62.1704761576999; Mon, 08 Jan
 2024 16:52:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b628a706-d356-4629-a433-59dfda24bb94@moroto.mountain>
In-Reply-To: <b628a706-d356-4629-a433-59dfda24bb94@moroto.mountain>
From: Steve French <smfrench@gmail.com>
Date: Mon, 8 Jan 2024 18:52:45 -0600
Message-ID: <CAH2r5mtoiRwB_yK-0VH6pirWCYMBgFNOY7Mt+RzYmFPmzh4epw@mail.gmail.com>
Subject: Re: [PATCH 1/3] cifs: delete unnecessary NULL checks in cifs_chan_update_iface()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Paulo Alcantara <pc@manguebit.com>, Ronnie Sahlberg <lsahlber@redhat.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

merged into cifs-2.6.git for-next, still reviewing the other two

On Mon, Jan 8, 2024 at 3:08=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> We return early if "iface" is NULL so there is no need to check here.
> Delete those checks.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  fs/smb/client/sess.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
>
> diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
> index a16e175731eb..775c6a4a2f4b 100644
> --- a/fs/smb/client/sess.c
> +++ b/fs/smb/client/sess.c
> @@ -467,27 +467,23 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct=
 TCP_Server_Info *server)
>                 kref_put(&old_iface->refcount, release_iface);
>         } else if (!chan_index) {
>                 /* special case: update interface for primary channel */
> -               if (iface) {
> -                       cifs_dbg(FYI, "referencing primary channel iface:=
 %pIS\n",
> -                                &iface->sockaddr);
> -                       iface->num_channels++;
> -                       iface->weight_fulfilled++;
> -               }
> +               cifs_dbg(FYI, "referencing primary channel iface: %pIS\n"=
,
> +                        &iface->sockaddr);
> +               iface->num_channels++;
> +               iface->weight_fulfilled++;
>         }
>         spin_unlock(&ses->iface_lock);
>
> -       if (iface) {
> -               spin_lock(&ses->chan_lock);
> -               chan_index =3D cifs_ses_get_chan_index(ses, server);
> -               if (chan_index =3D=3D CIFS_INVAL_CHAN_INDEX) {
> -                       spin_unlock(&ses->chan_lock);
> -                       return 0;
> -               }
> -
> -               ses->chans[chan_index].iface =3D iface;
> +       spin_lock(&ses->chan_lock);
> +       chan_index =3D cifs_ses_get_chan_index(ses, server);
> +       if (chan_index =3D=3D CIFS_INVAL_CHAN_INDEX) {
>                 spin_unlock(&ses->chan_lock);
> +               return 0;
>         }
>
> +       ses->chans[chan_index].iface =3D iface;
> +       spin_unlock(&ses->chan_lock);
> +
>         return rc;
>  }
>
> --
> 2.42.0
>
>


--=20
Thanks,

Steve

