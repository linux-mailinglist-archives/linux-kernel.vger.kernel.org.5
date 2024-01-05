Return-Path: <linux-kernel+bounces-18043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD00A8257A9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37A7AB24F5F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B7631759;
	Fri,  5 Jan 2024 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+WibeVG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB6431721;
	Fri,  5 Jan 2024 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e7b51b0ceso685704e87.1;
        Fri, 05 Jan 2024 08:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704470734; x=1705075534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qG7h0/YILrsrk5oo7zlWFkHSU3WtGX1oWPuyrEu2RVk=;
        b=G+WibeVGrVnG2GJ/fjY4oWOnJ51JvniMq/gmnegM6gcuTOR98T8RU4o8Kk7kaZjd3Q
         iCiccdN//vEfPw4fB2WdiUbXdXPW6rzrX6EZr8I6kxqX9qTYNs4CkDytnl41U3WGWUsA
         Dsi1xJ/tamTd4PIzXanyEk4Izmb58GLbVSp9ehJ11I5m/K4XRdAojPplhyIzQRcXHBza
         pAZe7wgd9QGzKiwUkUMkpD6CwiuHA/0FJ0vw12Hspmi064Q2Spycg2e0V0xp2n1XTmIu
         EAHSFhZbqSeWFrfoL0o5LqsUuw+cTTifta5PpMOXJf/kWbdAHNMEd8HYO3tUxLdaVDso
         6yBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704470734; x=1705075534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qG7h0/YILrsrk5oo7zlWFkHSU3WtGX1oWPuyrEu2RVk=;
        b=WXxp5P9ITmIXWsjoD3jkj5RXC3bBdD51/O6zh+KKe0xYggIADef88cOv1nzskppuUh
         /cwwMwwImeeismki7/r7wEV2gkZkJd4/Elr90zf/HPX65Y9ptM+INHaSxUIb3KZn+uZY
         066Ss9dJrn/pE69TmJEPNZmo/ArJBNTXuxgsObZ5tqkQdK2Af1bALjIMqH1IdEImPEeu
         ZWnpxqORrrcx+oMnpR9LA0sSklbzBdmfBqeUF7ytVWkbMvLG5z6SLyaSpx/LNWEWQxrU
         cD6fA8ayb6wkfaqmAxgXaWK1n6EVZvATRY294rsCakTSc+zrSv6m/TcTTr3IYBkPxaMl
         m8lQ==
X-Gm-Message-State: AOJu0YyoGaGPdDzDkCSEqDGVQbiUOZ5hiNrgvnRi9uSKcQsREkt8tGUu
	CBEwMUUpso0pL27hCmS4qeM53c7HSS/fCq+fVDKRU4aq
X-Google-Smtp-Source: AGHT+IEdxBu0+eYuNso+/Ajx0LhT9L0UVb/yYMkkBJH15MAiSwAVu/qGeAyz1hYGN/3hxwdpi3nbQwMzmIuhjT2qYwU=
X-Received: by 2002:a19:4f47:0:b0:50e:a085:77c8 with SMTP id
 a7-20020a194f47000000b0050ea08577c8mr1268066lfk.9.1704470734017; Fri, 05 Jan
 2024 08:05:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102185933.64179-1-verdre@v0yd.nl> <20240102185933.64179-4-verdre@v0yd.nl>
 <CABBYNZLoivEW=yrDtTbu5SjGauESH0zHb7NXs0YaSKSKqre5GQ@mail.gmail.com> <7036c788-7d8c-4e36-8289-64f43a3f8610@v0yd.nl>
In-Reply-To: <7036c788-7d8c-4e36-8289-64f43a3f8610@v0yd.nl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 5 Jan 2024 11:05:21 -0500
Message-ID: <CABBYNZLBf24vkTWEgWd8jHBfwh8jA2wDUbZZUW7QGHuUax5jcw@mail.gmail.com>
Subject: Re: [PATCH 3/5] Bluetooth: hci_event: Remove limit of 2 reconnection attempts
To: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Fri, Jan 5, 2024 at 10:54=E2=80=AFAM Jonas Dre=C3=9Fler <verdre@v0yd.nl>=
 wrote:
>
> Hi Luiz,
>
> On 1/3/24 17:05, Luiz Augusto von Dentz wrote:
> > Hi Jonas,
> >
> > On Tue, Jan 2, 2024 at 1:59=E2=80=AFPM Jonas Dre=C3=9Fler <verdre@v0yd.=
nl> wrote:
> >>
> >> Since commit 4c67bc74f016b0d360b8573e18969c0ff7926974, we retry connec=
ting
> >> later when we get a "Command Disallowed" error returned by "Create
> >> Connection".
> >>
> >> In this commit the intention was to retry only once, and give up if we=
 see
> >> "Command Disallowed" again on the second try.
> >>
> >> This made sense back then when the retry was initiated *only* from the
> >> "Connect Complete" event. If we received that event, we knew that now =
the
> >> card now must have a "free slot" for a new connection request again. T=
hese
> >> days we call hci_conn_check_pending() from a few more places though, a=
nd
> >> in these places we can't really be sure that there's a "free slot" on =
the
> >> card, so the second try to "Create Connection" might fail again.
> >>
> >> Deal with this by being less strict about these retries and try again
> >> every time we get "Command Disallowed" errors, removing the limitation=
 to
> >> only two attempts.
> >>
> >> Since this can potentially cause us to enter an endless cycle of
> >> reconnection attempts, we'll add some guarding against that with the n=
ext
> >> commit.
> >
> > Don't see where you are doing such guarding, besides you seem to
> > assume HCI_ERROR_COMMAND_DISALLOWED would always means the controller
> > is busy, or something like that, but it could perform the connection
> > later, but that may not always be the case, thus why I think
> > reconnecting just a few number of times is better, if you really need
> > to keep retrying then this needs to be controlled by a policy in
> > userspace not hardcoded in the kernel, well I can even argument that
> > perhaps the initial number of reconnection shall be configurable so
> > one don't have to recompile the kernel if that needs changing.
>
> Yes, fair enough, the next commit assumes that COMMAND_DISALLOWED always
> means busy. The guarding is that we stop retrying as soon as there's no
> (competing) ongoing connection attempt nor an active inquiry, which
> should eventually be the case no matter what, no?
>
> I agree it's probably still better to not rely on this fairly complex
> sanity check and keep the checking of attempts nonetheless.
>
> I think we could keep doing that if we check for
> !hci_conn_hash_lookup_state(hdev, ACL_LINK, BT_CONNECT) &&
> !test_bit(HCI_INQUIRY, &hdev->flags) in hci_conn_check_pending() before
> we actually retry, to make sure the retry counter doesn't get
> incremented wrongly. I'll give that a try.

Perhaps I'm missing something, but it should be possible to block
concurrent access to HCI while a command is pending with use of
hci_cmd_sync, at least on LE we do that by waiting the connection
complete event so connection attempts are serialized but we don't seem
to be doing the same for BR/EDR.


> >
> >> Signed-off-by: Jonas Dre=C3=9Fler <verdre@v0yd.nl>
> >> ---
> >>   net/bluetooth/hci_event.c | 7 ++++---
> >>   1 file changed, 4 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> >> index e8b4a0126..e1f5b6f90 100644
> >> --- a/net/bluetooth/hci_event.c
> >> +++ b/net/bluetooth/hci_event.c
> >> @@ -2323,12 +2323,13 @@ static void hci_cs_create_conn(struct hci_dev =
*hdev, __u8 status)
> >>
> >>          if (status) {
> >>                  if (conn && conn->state =3D=3D BT_CONNECT) {
> >> -                       if (status !=3D HCI_ERROR_COMMAND_DISALLOWED |=
| conn->attempt > 2) {
> >> +                       if (status =3D=3D HCI_ERROR_COMMAND_DISALLOWED=
) {
> >> +                               conn->state =3D BT_CONNECT2;
> >> +                       } else {
> >>                                  conn->state =3D BT_CLOSED;
> >>                                  hci_connect_cfm(conn, status);
> >>                                  hci_conn_del(conn);
> >> -                       } else
> >> -                               conn->state =3D BT_CONNECT2;
> >> +                       }
> >>                  }
> >>          } else {
> >>                  if (!conn) {
> >> --
> >> 2.43.0
> >>
> >
> >
>
> Cheers,
> Jonas



--
Luiz Augusto von Dentz

