Return-Path: <linux-kernel+bounces-28373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F7982FDB7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 00:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7401F29D7E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3AB67C68;
	Tue, 16 Jan 2024 23:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDp6fpzO"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681EB67C5B;
	Tue, 16 Jan 2024 23:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705447062; cv=none; b=DJF7ZgmqieZBtywkb9js3x9PkBgwFCCI4ypkoE5JRnE/SqQOCYb/Hq8AQEOWoWAMwyaBNZXXjWadnxplSNSS38JNh3aNqagKxYDn5NgagwX6Y+KurgmBeiecfWHFNTRfksGjRa5Emy9pCxZ9rzT4KR+Z/P/OCp1QyeR6kZG/eao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705447062; c=relaxed/simple;
	bh=33l3Pw/ShMdGyM9eq8Q6qJOYs0Ey95awHOBXX/zSi64=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=hfUOeYl6hqnWZvqNttyX0UICSHYkXGxvxg90YSVdPrgPizeLAS5/cR4jfA+b2rGklsquqEuAx8fEYFJDYQH38hbe0F5I65G0dAlG7SydJy3pYrv5o1yNZ5l5zEH2drHHwDpupf5iNELUIUDZBMtGjR/jx/lUJgzfdT7swJsDoeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDp6fpzO; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cd880ceaf2so64878881fa.2;
        Tue, 16 Jan 2024 15:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705447058; x=1706051858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sgi/x32AtrRpAtlUrAUzikypQdqgt00q+aRRQsUjrKw=;
        b=QDp6fpzOcWn9HCAbnSB6Kc6j/U3tlRitJGyHy+vRk3bABk4Cb4uhHjff5WfWPcZ73f
         Yucy0oQeocQuU0WTztIuMLOiDTEqBNFgQMoICmr5SoU+XYt8evctDDKjRLChx8HaaE5r
         Zh3dMbkH4b06+c2f6wl+PqIYLCozc2P5JE1dbVIfyAd9BhiWcj1MEHuQP6P8p8cweQ6X
         yHdkyIofEnnb6Iuf/NmnL6YEI8aqA+oPgouTH7tZVBJePSOzYoRtfwA0I+Q216nhOiC1
         itcRRZQroZhFG0LI39QirAEI6r/ghzJyOUH6cYk2ttuxGa68ih/8qvgGaH7ZNMzYNdJN
         I2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705447058; x=1706051858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sgi/x32AtrRpAtlUrAUzikypQdqgt00q+aRRQsUjrKw=;
        b=gDxWG6dffW2Xg96J4Xtnc3MS6xWfeyxxHpaKWmEeEivc5yNcffo8o67KSGBsByNrhT
         nLVVRbOl/zvUNNdIB2ltyjLRbZ/uao+fN+/s1XBCCgoHDMl1lcpFglHcm3Zm17V2W4hA
         MdPqqvlra70wYYUhT9gB71bGISOt77ys79pXZOnxqFHO2gGwcGXD9QddOwJUKoPRgPfF
         YOk3+xHiebSfIz7ID0yKo2nMoSCceVnh9Dy8rJTkzTDtxUBeIUaOQrpRwwln3QACnn3J
         yXuikZn99Qdwxp8lLBiA9ozXV01UnHiVWPF/mAPDAeJsasiibMKs3A5uhiEoxYiu7wrV
         uFHQ==
X-Gm-Message-State: AOJu0YyUl/RsfJERUMh65pniMWvbNE5ywH3usXBnnv44FSkvFOoiTB2W
	9vUJ3xzenDFyxfW1kztyfugIeuhu29IgPwZ8ciF50XklJttb0Q==
X-Google-Smtp-Source: AGHT+IEsAm9zDWmYl8th45/sWyIYVODxCtIh83Fdjbug3h68CTsTNrN3iXVGpe173uP/14flCe4eqoOfSE/TuCY8deM=
X-Received: by 2002:a2e:9b0f:0:b0:2cc:ce6d:5ae5 with SMTP id
 u15-20020a2e9b0f000000b002ccce6d5ae5mr3869179lji.54.1705447057989; Tue, 16
 Jan 2024 15:17:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116105134.2245640-1-colin.i.king@gmail.com>
In-Reply-To: <20240116105134.2245640-1-colin.i.king@gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Tue, 16 Jan 2024 17:17:26 -0600
Message-ID: <CAH2r5mvf+ZMyqpnFQUaO=DWC8ixXspsjWKE7BxQ1wW4WuvTVcA@mail.gmail.com>
Subject: Re: [PATCH][next] cifs: remove redundant variable tcon_exist
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes - it looks like Shyam's commit made that variable obsolete.

Shyam/Paulo,
Let me know if any objections.  Will put into cifs-2.6.git for-next

commit 04909192ada3285070f8ced0af7f07735478b364 (tag: 6.7-rc4-smb3-client-f=
ixes)
Author: Shyam Prasad N <sprasad@microsoft.com>
Date:   Wed Dec 6 16:37:38 2023 +0000

    cifs: reconnect worker should take reference on server struct
unconditionally

    Reconnect worker currently assumes that the server struct
    is alive and only takes reference on the server if it needs
    to call smb2_reconnect.

    With the new ability to disable channels based on whether the
    server has multichannel disabled, this becomes a problem when
    we need to disable established channels. While disabling the
    channels and deallocating the server, there could be reconnect
    work that could not be cancelled (because it started).

    This change forces the reconnect worker to unconditionally
    take a reference on the server when it runs.

    Also, this change now allows smb2_reconnect to know if it was
    called by the reconnect worker. Based on this, the cifs_put_tcp_session
    can decide whether it can cancel the reconnect work synchronously or no=
t.

    Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
    Signed-off-by: Steve French <stfrench@microsoft.com>

On Tue, Jan 16, 2024 at 4:51=E2=80=AFAM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> The variable tcon_exist is being assigned however it is never read, the
> variable is redundant and can be removed.
>
> Cleans up clang scan build warning:
> warning: Although the value stored to 'tcon_exist' is used in
> the enclosing expression, the value is never actually readfrom
> 'tcon_exist' [deadcode.DeadStores]
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  fs/smb/client/smb2pdu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
> index bd25c34dc398..50f6bf16b624 100644
> --- a/fs/smb/client/smb2pdu.c
> +++ b/fs/smb/client/smb2pdu.c
> @@ -3918,7 +3918,7 @@ void smb2_reconnect_server(struct work_struct *work=
)
>         struct cifs_ses *ses, *ses2;
>         struct cifs_tcon *tcon, *tcon2;
>         struct list_head tmp_list, tmp_ses_list;
> -       bool tcon_exist =3D false, ses_exist =3D false;
> +       bool ses_exist =3D false;
>         bool tcon_selected =3D false;
>         int rc;
>         bool resched =3D false;
> @@ -3964,7 +3964,7 @@ void smb2_reconnect_server(struct work_struct *work=
)
>                         if (tcon->need_reconnect || tcon->need_reopen_fil=
es) {
>                                 tcon->tc_count++;
>                                 list_add_tail(&tcon->rlist, &tmp_list);
> -                               tcon_selected =3D tcon_exist =3D true;
> +                               tcon_selected =3D true;
>                         }
>                 }
>                 /*
> @@ -3973,7 +3973,7 @@ void smb2_reconnect_server(struct work_struct *work=
)
>                  */
>                 if (ses->tcon_ipc && ses->tcon_ipc->need_reconnect) {
>                         list_add_tail(&ses->tcon_ipc->rlist, &tmp_list);
> -                       tcon_selected =3D tcon_exist =3D true;
> +                       tcon_selected =3D true;
>                         cifs_smb_ses_inc_refcount(ses);
>                 }
>                 /*
> --
> 2.39.2
>
>


--=20
Thanks,

Steve

