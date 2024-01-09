Return-Path: <linux-kernel+bounces-20380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF6F827DE7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237CF1F2456C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03A917C2;
	Tue,  9 Jan 2024 04:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b66GUwhk"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE9D6FA9;
	Tue,  9 Jan 2024 04:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cc7b9281d1so32478481fa.1;
        Mon, 08 Jan 2024 20:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704775307; x=1705380107; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I+MaGzSw3/QUMbGJ2pNKRoyhD2PK6ruOtlyc8Ghda58=;
        b=b66GUwhknG0m76sKmPJqBu39Ei4y1oNrQcwj8W7YhRgrN0nYxAJJey43l/lT7yYp1C
         avsMVU9GQLazIuKvKNqK+JqcL4ZZA4slKb6594/OT8wI0Cz4NvvL2ArnkL7fLZaSA1KB
         iAM+jgLQIYdhOufFo9n9wEYdaVfypQPsm8mT43rIsj6UH+n2g7kele7f93Lg6LBgJhLW
         K1c/AEIq6tI9LGIsndY+M3hzGPjLynbhGIfRXzv6ODMQ8gSeIF+wxwXGtdq7irgrPnz5
         A+jJaejJr0ydvsrPVdO5ui0pwifvT/BemdI3ea8VJaAOTXWP3Eybjiu85fqk/Jo4CJxY
         zbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704775307; x=1705380107;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+MaGzSw3/QUMbGJ2pNKRoyhD2PK6ruOtlyc8Ghda58=;
        b=JDi8prHgRrQOLCso3VtV75Qg5sOK+RIuRZZGxpuD/65zdW2SL2rRHzOSYXBFaK+n9y
         QRWSKMw24Rh9VIgRcQ9JhHZOf0eT9/upH7/vW68yc/pCXNRxpwbL+UsLZc4N+aWx2hv5
         /9xHCZU3OVuARw4LF45facV4al+eY+uTIdyBpkqLGMLz9A+KDgldpdbD/YwtZgKMJEz0
         nTxxV3RlzPvugBvWLvk07AyCz+9VotvresmTxJ+UHmPAAZq1/TMOg8Y3qOPttdbjTk//
         kNjliLagxf2xdBLYmb20vMwLZSl0GeIJIq2s7pudpKtWzRp5GrEMklQRvr7ypKINPqUF
         3t5w==
X-Gm-Message-State: AOJu0YxOw2tkWZ4UpROqDbIYViTNZh+xzu84MTCB7AoeBaSmr1SzlUx6
	ol4A1snj8nPRlDRdD2vDMhPyr5aHzvIfp0yMNFc=
X-Google-Smtp-Source: AGHT+IHRojv8WFvlgFekjmDbBFUJiTIDJoOTbnz/ONms9vEbYS7wEgh+m6mZOOBWaQrnrqhJlGEuRF4zd84jD6F8QXE=
X-Received: by 2002:a2e:8091:0:b0:2cd:13bf:78d7 with SMTP id
 i17-20020a2e8091000000b002cd13bf78d7mr2062772ljg.10.1704775306831; Mon, 08
 Jan 2024 20:41:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b628a706-d356-4629-a433-59dfda24bb94@moroto.mountain>
 <eac139a7-76d4-4067-8c25-15e30692aaf9@moroto.mountain> <4c6b12c9-0502-400a-b2ba-dad89ef4f652@wanadoo.fr>
In-Reply-To: <4c6b12c9-0502-400a-b2ba-dad89ef4f652@wanadoo.fr>
From: Steve French <smfrench@gmail.com>
Date: Mon, 8 Jan 2024 22:41:35 -0600
Message-ID: <CAH2r5mu0BnSuOcbG9L=Y0Hhe6GAtOxUJ1R4wkVmXn7A-Vgxndw@mail.gmail.com>
Subject: Re: [PATCH 2/3] cifs: make cifs_chan_update_iface() a void function
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, Ronnie Sahlberg <lsahlber@redhat.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000096091d060e7beea4"

--00000000000096091d060e7beea4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

added the trivial change Christophe Suggested


On Mon, Jan 8, 2024 at 1:09=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 08/01/2024 =C3=A0 10:08, Dan Carpenter a =C3=A9crit :
> > The return values for cifs_chan_update_iface() didn't match what the
> > documentation said and nothing was checking them anyway.  Just make it
> > a void function.
> >
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >   fs/smb/client/cifsproto.h |  2 +-
> >   fs/smb/client/sess.c      | 17 +++++++----------
> >   2 files changed, 8 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
> > index afbab86331a1..a841bf4967fa 100644
> > --- a/fs/smb/client/cifsproto.h
> > +++ b/fs/smb/client/cifsproto.h
> > @@ -656,7 +656,7 @@ cifs_chan_is_iface_active(struct cifs_ses *ses,
> >                         struct TCP_Server_Info *server);
> >   void
> >   cifs_disable_secondary_channels(struct cifs_ses *ses);
> > -int
> > +void
> >   cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *=
server);
> >   int
> >   SMB3_request_interfaces(const unsigned int xid, struct cifs_tcon *tco=
n, bool in_mount);
> > diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
> > index 775c6a4a2f4b..f7b216dd06b2 100644
> > --- a/fs/smb/client/sess.c
> > +++ b/fs/smb/client/sess.c
> > @@ -356,10 +356,9 @@ cifs_disable_secondary_channels(struct cifs_ses *s=
es)
> >
> >   /*
> >    * update the iface for the channel if necessary.
> > - * will return 0 when iface is updated, 1 if removed, 2 otherwise
> >    * Must be called with chan_lock held.
> >    */
> > -int
> > +void
> >   cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *=
server)
> >   {
> >       unsigned int chan_index;
> > @@ -368,20 +367,19 @@ cifs_chan_update_iface(struct cifs_ses *ses, stru=
ct TCP_Server_Info *server)
> >       struct cifs_server_iface *old_iface =3D NULL;
> >       struct cifs_server_iface *last_iface =3D NULL;
> >       struct sockaddr_storage ss;
> > -     int rc =3D 0;
> >
> >       spin_lock(&ses->chan_lock);
> >       chan_index =3D cifs_ses_get_chan_index(ses, server);
> >       if (chan_index =3D=3D CIFS_INVAL_CHAN_INDEX) {
> >               spin_unlock(&ses->chan_lock);
> > -             return 0;
> > +             return;
> >       }
> >
> >       if (ses->chans[chan_index].iface) {
> >               old_iface =3D ses->chans[chan_index].iface;
> >               if (old_iface->is_active) {
> >                       spin_unlock(&ses->chan_lock);
> > -                     return 1;
> > +                     return;
> >               }
> >       }
> >       spin_unlock(&ses->chan_lock);
> > @@ -394,7 +392,7 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct=
 TCP_Server_Info *server)
> >       if (!ses->iface_count) {
> >               spin_unlock(&ses->iface_lock);
> >               cifs_dbg(VFS, "server %s does not advertise interfaces\n"=
, ses->server->hostname);
> > -             return 0;
> > +             return;
> >       }
> >
> >       last_iface =3D list_last_entry(&ses->iface_list, struct cifs_serv=
er_iface,
> > @@ -434,7 +432,6 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct=
 TCP_Server_Info *server)
> >       }
> >
> >       if (list_entry_is_head(iface, &ses->iface_list, iface_head)) {
> > -             rc =3D 1;
> >               iface =3D NULL;
> >               cifs_dbg(FYI, "unable to find a suitable iface\n");
> >       }
> > @@ -449,7 +446,7 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct=
 TCP_Server_Info *server)
> >               }
> >
> >               spin_unlock(&ses->iface_lock);
> > -             return 0;
> > +             return;
> >       }
> >
> >       /* now drop the ref to the current iface */
> > @@ -478,13 +475,13 @@ cifs_chan_update_iface(struct cifs_ses *ses, stru=
ct TCP_Server_Info *server)
> >       chan_index =3D cifs_ses_get_chan_index(ses, server);
> >       if (chan_index =3D=3D CIFS_INVAL_CHAN_INDEX) {
> >               spin_unlock(&ses->chan_lock);
> > -             return 0;
> > +             return;
> >       }
> >
> >       ses->chans[chan_index].iface =3D iface;
> >       spin_unlock(&ses->chan_lock);
> >
> > -     return rc;
> > +     return;
>
> just remove this one?
>
> CJ
>
> >   }
> >
> >   /*
>
>


--=20
Thanks,

Steve

--00000000000096091d060e7beea4
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0017-cifs-remove-unneeded-return-statement.patch"
Content-Disposition: attachment; 
	filename="0017-cifs-remove-unneeded-return-statement.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lr5v6ymp0>
X-Attachment-Id: f_lr5v6ymp0

RnJvbSBhM2Y3NjNmZGNiMmY3ODRjMzU1YWVkNjZkZGFjNjc0OGZmOGRiZmE2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IE1vbiwgOCBKYW4gMjAyNCAyMjozNzoxMCAtMDYwMApTdWJqZWN0OiBbUEFUQ0ggMTcv
MTddIGNpZnM6IHJlbW92ZSB1bm5lZWRlZCByZXR1cm4gc3RhdGVtZW50CgpSZXR1cm4gc3RhdGVt
ZW50IHdhcyBub3QgbmVlZGVkIGF0IGVuZCBvZiBjaWZzX2NoYW5fdXBkYXRlX2lmYWNlCgpTdWdn
ZXN0ZWQtYnk6IENocmlzdG9waGUgSmFpbGxldCA8Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28u
ZnI+ClNpZ25lZC1vZmYtYnk6IFN0ZXZlIEZyZW5jaCA8c3RmcmVuY2hAbWljcm9zb2Z0LmNvbT4K
LS0tCiBmcy9zbWIvY2xpZW50L3Nlc3MuYyB8IDIgLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL3NtYi9jbGllbnQvc2Vzcy5jIGIvZnMvc21iL2NsaWVu
dC9zZXNzLmMKaW5kZXggZjdiMjE2ZGQwNmIyLi5jZGU4MTA0MmJlYmQgMTAwNjQ0Ci0tLSBhL2Zz
L3NtYi9jbGllbnQvc2Vzcy5jCisrKyBiL2ZzL3NtYi9jbGllbnQvc2Vzcy5jCkBAIC00ODAsOCAr
NDgwLDYgQEAgY2lmc19jaGFuX3VwZGF0ZV9pZmFjZShzdHJ1Y3QgY2lmc19zZXMgKnNlcywgc3Ry
dWN0IFRDUF9TZXJ2ZXJfSW5mbyAqc2VydmVyKQogCiAJc2VzLT5jaGFuc1tjaGFuX2luZGV4XS5p
ZmFjZSA9IGlmYWNlOwogCXNwaW5fdW5sb2NrKCZzZXMtPmNoYW5fbG9jayk7Ci0KLQlyZXR1cm47
CiB9CiAKIC8qCi0tIAoyLjQwLjEKCg==
--00000000000096091d060e7beea4--

