Return-Path: <linux-kernel+bounces-28467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FA682FEE0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085561C22F89
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3435B2F2F;
	Wed, 17 Jan 2024 02:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlhVSMIJ"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04678BE7;
	Wed, 17 Jan 2024 02:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705459052; cv=none; b=u8+2iYA4f/NFYE3fLytTD/c7GpEvaXflq0rFUOSTu0fXASMlJAyooErP3fR2j2XDjHtT5SosGKdPVITdqprwiDt28cJshOl3xobBQXuwEs8hEyJdcbWsme3SXhXfK8+EErOWF7agepcOYXsMMLuSiaY0/jZ+KWLi5+RfjwyGFP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705459052; c=relaxed/simple;
	bh=jqF/9JyattymLAasEFYU0ECnHq4Ym/v6z/1MYMNrq4k=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=dLJG9k5DS33PXoPexiBG4fvhj0DVBVGqFGgSyaDI+QcwjFEn3UJ6iSf571B1RvPA7LHohUmPsKMM6E4rbHcpKG3rlHof82xIoTjxIDqmKeKfCO177lXRt3fgh9EkMMeUaMgRPOdkjTMkqTPcO1TiaPcOztlXD2BSGrcEUqTesZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlhVSMIJ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e7b273352so11710829e87.1;
        Tue, 16 Jan 2024 18:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705459049; x=1706063849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3RjXI7Hh+GcQdwAHGUx/B1j21tMhV8hXjVUFEyYY7M=;
        b=ZlhVSMIJy8fZPaCfQbkkcGEzwHFV5UV+8pRhPzqKv1fHcjMUTgN0v2O45lhcCujFS4
         YHuaB/xM3ImOvl4zT5TUL0vMyG2khEJYqS2wtDidZpqEBBrYbwBRNiSkr+jF1Egxsvqa
         aEsH2AylXhJ/E6yNST9mDlZ7XUhGEuBDUcJGNMhi0LWJ2E99ymcZsb6PODiS06ihflqK
         X+sqXb1NawkISWVgUR2qa0U7FHVLx7u779O2pulQhmNc7o2SvorlSWbNcs+B7bCVAUtv
         BfTr5wbALkjK3XQqXCmXYl157v+4WRJ8OSPM3CJhH9Pl7C74+IEMsJe40CiP+Vh+6krP
         srqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705459049; x=1706063849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3RjXI7Hh+GcQdwAHGUx/B1j21tMhV8hXjVUFEyYY7M=;
        b=RDdo0MMXSLeDu6Jz5Cw905xbfYF6kIzmjjbYFI/4m6kyl/nS6J36AraiOQKXQ8pDOY
         DLdqbbioki4G+jr0hKE3X+aPE6oMIomRs6MnlXX6dEqyCqE7DXJwVuC5hHuntZgpcnkr
         Lg8FgPDyWMq8QEO6IVpSRVsCyI5yuUWatCNNbzu0oc78FrihmFjC8T8vAioZnH1RzByd
         8tV5clTE9GX5+tSq9ZoObBhhTE7CNBKFqhjSezvhyP2cbdCwwfgdbrvUN7tklUvpTLGc
         8WmbMpzylnEO4Pq35P80UM2gq0FHSfJdsF7P33+2VXED778PMvaBpqd3sQjGlH4S8kxJ
         cJbA==
X-Gm-Message-State: AOJu0Yxky4bAPU6MJo4iYGt2iZEWqcOqBQG/xTUASTJxndgDoAjMOSNM
	qo9PcKg6hWRvJoJLUpn4NMMfwJtRwT84Xw1UtcYXjHpaOP4=
X-Google-Smtp-Source: AGHT+IHlXPl9sCwcU8NLqkeAGIFmND77BIJ3iqBjLxTebH9GSpRoUl2SIp24HhsdTysTuhb5izRfl7oqYQvfOMFfqp8=
X-Received: by 2002:ac2:5604:0:b0:50e:8ed1:cf10 with SMTP id
 v4-20020ac25604000000b0050e8ed1cf10mr2998703lfd.42.1705459048542; Tue, 16 Jan
 2024 18:37:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116105134.2245640-1-colin.i.king@gmail.com> <CAH2r5mvf+ZMyqpnFQUaO=DWC8ixXspsjWKE7BxQ1wW4WuvTVcA@mail.gmail.com>
In-Reply-To: <CAH2r5mvf+ZMyqpnFQUaO=DWC8ixXspsjWKE7BxQ1wW4WuvTVcA@mail.gmail.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Wed, 17 Jan 2024 08:07:17 +0530
Message-ID: <CANT5p=r=y4BN-1eeSur_zWCx=R1fn+8OU-3nv+AffraPjja+qQ@mail.gmail.com>
Subject: Re: [PATCH][next] cifs: remove redundant variable tcon_exist
To: Steve French <smfrench@gmail.com>
Cc: Colin Ian King <colin.i.king@gmail.com>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 4:47=E2=80=AFAM Steve French <smfrench@gmail.com> w=
rote:
>
> Yes - it looks like Shyam's commit made that variable obsolete.
>
> Shyam/Paulo,
> Let me know if any objections.  Will put into cifs-2.6.git for-next
>
> commit 04909192ada3285070f8ced0af7f07735478b364 (tag: 6.7-rc4-smb3-client=
-fixes)
> Author: Shyam Prasad N <sprasad@microsoft.com>
> Date:   Wed Dec 6 16:37:38 2023 +0000
>
>     cifs: reconnect worker should take reference on server struct
> unconditionally
>
>     Reconnect worker currently assumes that the server struct
>     is alive and only takes reference on the server if it needs
>     to call smb2_reconnect.
>
>     With the new ability to disable channels based on whether the
>     server has multichannel disabled, this becomes a problem when
>     we need to disable established channels. While disabling the
>     channels and deallocating the server, there could be reconnect
>     work that could not be cancelled (because it started).
>
>     This change forces the reconnect worker to unconditionally
>     take a reference on the server when it runs.
>
>     Also, this change now allows smb2_reconnect to know if it was
>     called by the reconnect worker. Based on this, the cifs_put_tcp_sessi=
on
>     can decide whether it can cancel the reconnect work synchronously or =
not.
>
>     Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
>     Signed-off-by: Steve French <stfrench@microsoft.com>
>
> On Tue, Jan 16, 2024 at 4:51=E2=80=AFAM Colin Ian King <colin.i.king@gmai=
l.com> wrote:
> >
> > The variable tcon_exist is being assigned however it is never read, the
> > variable is redundant and can be removed.
> >
> > Cleans up clang scan build warning:
> > warning: Although the value stored to 'tcon_exist' is used in
> > the enclosing expression, the value is never actually readfrom
> > 'tcon_exist' [deadcode.DeadStores]
> >
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > ---
> >  fs/smb/client/smb2pdu.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
> > index bd25c34dc398..50f6bf16b624 100644
> > --- a/fs/smb/client/smb2pdu.c
> > +++ b/fs/smb/client/smb2pdu.c
> > @@ -3918,7 +3918,7 @@ void smb2_reconnect_server(struct work_struct *wo=
rk)
> >         struct cifs_ses *ses, *ses2;
> >         struct cifs_tcon *tcon, *tcon2;
> >         struct list_head tmp_list, tmp_ses_list;
> > -       bool tcon_exist =3D false, ses_exist =3D false;
> > +       bool ses_exist =3D false;
> >         bool tcon_selected =3D false;
> >         int rc;
> >         bool resched =3D false;
> > @@ -3964,7 +3964,7 @@ void smb2_reconnect_server(struct work_struct *wo=
rk)
> >                         if (tcon->need_reconnect || tcon->need_reopen_f=
iles) {
> >                                 tcon->tc_count++;
> >                                 list_add_tail(&tcon->rlist, &tmp_list);
> > -                               tcon_selected =3D tcon_exist =3D true;
> > +                               tcon_selected =3D true;
> >                         }
> >                 }
> >                 /*
> > @@ -3973,7 +3973,7 @@ void smb2_reconnect_server(struct work_struct *wo=
rk)
> >                  */
> >                 if (ses->tcon_ipc && ses->tcon_ipc->need_reconnect) {
> >                         list_add_tail(&ses->tcon_ipc->rlist, &tmp_list)=
;
> > -                       tcon_selected =3D tcon_exist =3D true;
> > +                       tcon_selected =3D true;
> >                         cifs_smb_ses_inc_refcount(ses);
> >                 }
> >                 /*
> > --
> > 2.39.2
> >
> >
>
>
> --
> Thanks,
>
> Steve
>

The change looks good to me.

--=20
Regards,
Shyam

