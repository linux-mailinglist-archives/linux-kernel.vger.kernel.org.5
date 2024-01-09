Return-Path: <linux-kernel+bounces-20381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95F3827DEB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71E09286C13
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B14184C;
	Tue,  9 Jan 2024 04:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anM0WCK6"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D0C631;
	Tue,  9 Jan 2024 04:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cd0f4797aaso26855241fa.0;
        Mon, 08 Jan 2024 20:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704775342; x=1705380142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I63vcM6VvyO1LXNd6PYP30FAKknBe/hWRBhtNWHXuu0=;
        b=anM0WCK6YJMw9YjX5ZeeA5i1d8aH+yxf+cTmX4kGuGPDFBnQGwubavXZac8Id+feU+
         NFpfbvuHcgKueGUHlFKgj1AipXG0nUJSXXg/jwgaoz+7k7nnuVjMw0Ia8lHd8onUCRYF
         Y6+YyQDn21MLdPiV9Hw6zxREakp9c3t9T3fgyIMpKKqRwgLyrcxE4R7BOwozNZU3//kL
         B8lZak/qadzJETpFZB/HU7jQJwussDKB62USaKV6Jz84l+7xvUPvN9WPMxu0/yQa8N2n
         Wn+TxfDmj8E7LElp1f16r/k952dHMDl+vf/1dsKKagkSOgonimFt4LRYaYFGf+Qi4ZZo
         JzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704775342; x=1705380142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I63vcM6VvyO1LXNd6PYP30FAKknBe/hWRBhtNWHXuu0=;
        b=dls4HtXNPgIJpSsrpqBi9APlofwFIGuUeG6ZTDUDlPRHJ951cjfJPp7/Gy/o+1gHLz
         RAE80qA8YDpYRZl7Ocj9/hi4cCdwag4DZP3sXho6zPzDYfgrH5TlKUsvcXaamXA8VhEO
         0clU1ESPCHiNxXdQRSA4ZlXdd7POeYZodtFKFj5jBt4bVFb5U4YcI3kc3G8n8uLh524A
         X94BAURxt99YHh/J19CeuPQzZdL0keRJmo85AK4gZYxW9Ofm4Y+bRXYx4nWZkedTr3k0
         Ro9jv9zd+GvHH1UEIzl7ypfJtcMbPY5fyqoo+xTLSs8VVXjecCkX1b43U8aT3vYTGC+i
         zTXA==
X-Gm-Message-State: AOJu0Yy1zBT1eiBimqtyh9vVOX/R3hpB1p8xIEhz4sdAmy5WDx5cucqs
	kBeRncQNGD8rlP5KoEfE/g9r/7aM+yvkuGvK9fk=
X-Google-Smtp-Source: AGHT+IGlWO/crxssD7G8T7bGrJFxwh18/msP4T2w5C6mhigQ2+NmzCIZ8acYfvh7C5f8yyUTK3LWCZPhg4kznLXHX8w=
X-Received: by 2002:a2e:b88c:0:b0:2cd:494b:b4b4 with SMTP id
 r12-20020a2eb88c000000b002cd494bb4b4mr1626422ljp.16.1704775341837; Mon, 08
 Jan 2024 20:42:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b628a706-d356-4629-a433-59dfda24bb94@moroto.mountain> <eac139a7-76d4-4067-8c25-15e30692aaf9@moroto.mountain>
In-Reply-To: <eac139a7-76d4-4067-8c25-15e30692aaf9@moroto.mountain>
From: Steve French <smfrench@gmail.com>
Date: Mon, 8 Jan 2024 22:42:10 -0600
Message-ID: <CAH2r5mt5FhiU15UL62JfferJG_AfF4iw6nd96PnEusWPF40AEQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] cifs: make cifs_chan_update_iface() a void function
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
	Ronnie Sahlberg <lsahlber@redhat.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

merged into cifs-2.6.git for-next

On Mon, Jan 8, 2024 at 3:08=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> The return values for cifs_chan_update_iface() didn't match what the
> documentation said and nothing was checking them anyway.  Just make it
> a void function.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  fs/smb/client/cifsproto.h |  2 +-
>  fs/smb/client/sess.c      | 17 +++++++----------
>  2 files changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
> index afbab86331a1..a841bf4967fa 100644
> --- a/fs/smb/client/cifsproto.h
> +++ b/fs/smb/client/cifsproto.h
> @@ -656,7 +656,7 @@ cifs_chan_is_iface_active(struct cifs_ses *ses,
>                           struct TCP_Server_Info *server);
>  void
>  cifs_disable_secondary_channels(struct cifs_ses *ses);
> -int
> +void
>  cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *ser=
ver);
>  int
>  SMB3_request_interfaces(const unsigned int xid, struct cifs_tcon *tcon, =
bool in_mount);
> diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
> index 775c6a4a2f4b..f7b216dd06b2 100644
> --- a/fs/smb/client/sess.c
> +++ b/fs/smb/client/sess.c
> @@ -356,10 +356,9 @@ cifs_disable_secondary_channels(struct cifs_ses *ses=
)
>
>  /*
>   * update the iface for the channel if necessary.
> - * will return 0 when iface is updated, 1 if removed, 2 otherwise
>   * Must be called with chan_lock held.
>   */
> -int
> +void
>  cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *ser=
ver)
>  {
>         unsigned int chan_index;
> @@ -368,20 +367,19 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct=
 TCP_Server_Info *server)
>         struct cifs_server_iface *old_iface =3D NULL;
>         struct cifs_server_iface *last_iface =3D NULL;
>         struct sockaddr_storage ss;
> -       int rc =3D 0;
>
>         spin_lock(&ses->chan_lock);
>         chan_index =3D cifs_ses_get_chan_index(ses, server);
>         if (chan_index =3D=3D CIFS_INVAL_CHAN_INDEX) {
>                 spin_unlock(&ses->chan_lock);
> -               return 0;
> +               return;
>         }
>
>         if (ses->chans[chan_index].iface) {
>                 old_iface =3D ses->chans[chan_index].iface;
>                 if (old_iface->is_active) {
>                         spin_unlock(&ses->chan_lock);
> -                       return 1;
> +                       return;
>                 }
>         }
>         spin_unlock(&ses->chan_lock);
> @@ -394,7 +392,7 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct T=
CP_Server_Info *server)
>         if (!ses->iface_count) {
>                 spin_unlock(&ses->iface_lock);
>                 cifs_dbg(VFS, "server %s does not advertise interfaces\n"=
, ses->server->hostname);
> -               return 0;
> +               return;
>         }
>
>         last_iface =3D list_last_entry(&ses->iface_list, struct cifs_serv=
er_iface,
> @@ -434,7 +432,6 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct T=
CP_Server_Info *server)
>         }
>
>         if (list_entry_is_head(iface, &ses->iface_list, iface_head)) {
> -               rc =3D 1;
>                 iface =3D NULL;
>                 cifs_dbg(FYI, "unable to find a suitable iface\n");
>         }
> @@ -449,7 +446,7 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct T=
CP_Server_Info *server)
>                 }
>
>                 spin_unlock(&ses->iface_lock);
> -               return 0;
> +               return;
>         }
>
>         /* now drop the ref to the current iface */
> @@ -478,13 +475,13 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct=
 TCP_Server_Info *server)
>         chan_index =3D cifs_ses_get_chan_index(ses, server);
>         if (chan_index =3D=3D CIFS_INVAL_CHAN_INDEX) {
>                 spin_unlock(&ses->chan_lock);
> -               return 0;
> +               return;
>         }
>
>         ses->chans[chan_index].iface =3D iface;
>         spin_unlock(&ses->chan_lock);
>
> -       return rc;
> +       return;
>  }
>
>  /*
> --
> 2.42.0
>
>


--=20
Thanks,

Steve

