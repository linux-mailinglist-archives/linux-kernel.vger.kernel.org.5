Return-Path: <linux-kernel+bounces-19017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF738266CE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 00:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBFE21F21629
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 23:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1F013AC9;
	Sun,  7 Jan 2024 23:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVCkn7Wq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFBC125C1;
	Sun,  7 Jan 2024 23:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cceb5f0918so11776691fa.2;
        Sun, 07 Jan 2024 15:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704671606; x=1705276406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6SvziE4SgCfcwKui6g6BHU6+IiHhzhISnq8zJn/xoM=;
        b=kVCkn7WqgUyhjOFlk6oXX7y1MAgta82/KlvEBeUFMjOiDXptJHGEuyhPQ29Xu1AGJv
         jM+EdMZpHVEjbfC2g7w+yY/yQ6czzGI5gWXABAyqeBrQD1qOGNl/0oQkWwoKGYvtx5FO
         KHEbp3L29gGCgCgveAnAzlsLzeiyvpslg8CKL0igEYJBp8MUouUhq4KAzLKnrPlOP3PB
         hiGHxZkPoG7bixCpsc/fwRmLcaPr6M5HA/XAh43mLiH4KwIMvyiXbvcvHQKZK6jT2DLA
         BD9wMgxWDV8iaqaUpsSXd+P3AWiOSSQJQa7XOUciLdOxDtOB5b5JbRpIpxbOUSMGr9f2
         UFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704671606; x=1705276406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6SvziE4SgCfcwKui6g6BHU6+IiHhzhISnq8zJn/xoM=;
        b=bBLelQjhfh5iRue7U/mcLJ7Q3P5GKEywah+Ilyh5gVSX3X0CZhz/xKGWlEo+7Rnprx
         Fuk6cjHIEtb9X6BpNzCEhXkOY2gWEiIFAHu5z3kSlxROcKj38RjrXCZi2VEsltD+wQ1Y
         e6eQ1DuTkLaQcT6MPv++yhtXGR5bXPZxjdQ82TJInN4YMXfGAuCEFqDb8adxEBT0iWoa
         rUzljHRHlzMrzynnSQR4GJ9zXxEKhQ+7CvpBJgwcoeuoTpYvoP8HC4/9hAqZQh2vWWLQ
         Fs07+byUlmkLX5NlymvMc59AO8PwptxNSftVxTmMM+A05t1tDT3j2ZjTK0zwTuYv1nT5
         KgSQ==
X-Gm-Message-State: AOJu0Yw4di7G8D0zf4+OnbmyJwom9mEHs8ivg3GX4Y0t21TGzE0OQbfS
	c4TCkIRnKCpdbRoxwAEUs0txec3X5Wq9DZ0IJLA=
X-Google-Smtp-Source: AGHT+IFBFU9yISxa+AzQx8WkCtCgDkQmcaheRLbvlBb2SzQmqCkKVHFqNkMJoJCz752eMMyAgHZRYKHRJ4QbZ9Oa+8I=
X-Received: by 2002:a05:651c:1694:b0:2cc:cbd9:b3d7 with SMTP id
 bd20-20020a05651c169400b002cccbd9b3d7mr609310ljb.28.1704671605784; Sun, 07
 Jan 2024 15:53:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102185933.64179-1-verdre@v0yd.nl> <20240102185933.64179-4-verdre@v0yd.nl>
 <CABBYNZLoivEW=yrDtTbu5SjGauESH0zHb7NXs0YaSKSKqre5GQ@mail.gmail.com>
 <7036c788-7d8c-4e36-8289-64f43a3f8610@v0yd.nl> <CABBYNZLBf24vkTWEgWd8jHBfwh8jA2wDUbZZUW7QGHuUax5jcw@mail.gmail.com>
 <9b728113-8bb5-44df-8ba8-b0ee535100c8@v0yd.nl>
In-Reply-To: <9b728113-8bb5-44df-8ba8-b0ee535100c8@v0yd.nl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sun, 7 Jan 2024 18:53:13 -0500
Message-ID: <CABBYNZKEM+pJ3jSuDEmATL+sPyHPaA3esNZNoq3VC2ZoTQeUUQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] Bluetooth: hci_event: Remove limit of 2 reconnection attempts
To: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Sun, Jan 7, 2024 at 5:20=E2=80=AFPM Jonas Dre=C3=9Fler <verdre@v0yd.nl> =
wrote:
>
> Hi Luiz,
>
> On 1/5/24 17:05, Luiz Augusto von Dentz wrote:
> > Hi Jonas,
> >
> > On Fri, Jan 5, 2024 at 10:54=E2=80=AFAM Jonas Dre=C3=9Fler <verdre@v0yd=
.nl> wrote:
> >>
> >> Hi Luiz,
> >>
> >> On 1/3/24 17:05, Luiz Augusto von Dentz wrote:
> >>> Hi Jonas,
> >>>
> >>> On Tue, Jan 2, 2024 at 1:59=E2=80=AFPM Jonas Dre=C3=9Fler <verdre@v0y=
d.nl> wrote:
> >>>>
> >>>> Since commit 4c67bc74f016b0d360b8573e18969c0ff7926974, we retry conn=
ecting
> >>>> later when we get a "Command Disallowed" error returned by "Create
> >>>> Connection".
> >>>>
> >>>> In this commit the intention was to retry only once, and give up if =
we see
> >>>> "Command Disallowed" again on the second try.
> >>>>
> >>>> This made sense back then when the retry was initiated *only* from t=
he
> >>>> "Connect Complete" event. If we received that event, we knew that no=
w the
> >>>> card now must have a "free slot" for a new connection request again.=
 These
> >>>> days we call hci_conn_check_pending() from a few more places though,=
 and
> >>>> in these places we can't really be sure that there's a "free slot" o=
n the
> >>>> card, so the second try to "Create Connection" might fail again.
> >>>>
> >>>> Deal with this by being less strict about these retries and try agai=
n
> >>>> every time we get "Command Disallowed" errors, removing the limitati=
on to
> >>>> only two attempts.
> >>>>
> >>>> Since this can potentially cause us to enter an endless cycle of
> >>>> reconnection attempts, we'll add some guarding against that with the=
 next
> >>>> commit.
> >>>
> >>> Don't see where you are doing such guarding, besides you seem to
> >>> assume HCI_ERROR_COMMAND_DISALLOWED would always means the controller
> >>> is busy, or something like that, but it could perform the connection
> >>> later, but that may not always be the case, thus why I think
> >>> reconnecting just a few number of times is better, if you really need
> >>> to keep retrying then this needs to be controlled by a policy in
> >>> userspace not hardcoded in the kernel, well I can even argument that
> >>> perhaps the initial number of reconnection shall be configurable so
> >>> one don't have to recompile the kernel if that needs changing.
> >>
> >> Yes, fair enough, the next commit assumes that COMMAND_DISALLOWED alwa=
ys
> >> means busy. The guarding is that we stop retrying as soon as there's n=
o
> >> (competing) ongoing connection attempt nor an active inquiry, which
> >> should eventually be the case no matter what, no?
> >>
> >> I agree it's probably still better to not rely on this fairly complex
> >> sanity check and keep the checking of attempts nonetheless.
> >>
> >> I think we could keep doing that if we check for
> >> !hci_conn_hash_lookup_state(hdev, ACL_LINK, BT_CONNECT) &&
> >> !test_bit(HCI_INQUIRY, &hdev->flags) in hci_conn_check_pending() befor=
e
> >> we actually retry, to make sure the retry counter doesn't get
> >> incremented wrongly. I'll give that a try.
> >
> > Perhaps I'm missing something, but it should be possible to block
> > concurrent access to HCI while a command is pending with use of
> > hci_cmd_sync, at least on LE we do that by waiting the connection
> > complete event so connection attempts are serialized but we don't seem
> > to be doing the same for BR/EDR.
> >
>
> That's a good point, it might even allow for a nice little cleanup
> because we can then cancel inquiries in hci_acl_create_connection()
> synchronously, too.
>
> Question is just whether there's any devices out there that actually do
> support paging with more than a single device at a time and if we want
> to support that?

I think the controller would serialize the paging anyway, so the fact
that we would serialize it on the host side might actually means that
we have a common behavior across controllers rather than having to
handle errors when the controller is not capable of serializing
connections by themselves.

> >
> >>>
> >>>> Signed-off-by: Jonas Dre=C3=9Fler <verdre@v0yd.nl>
> >>>> ---
> >>>>    net/bluetooth/hci_event.c | 7 ++++---
> >>>>    1 file changed, 4 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> >>>> index e8b4a0126..e1f5b6f90 100644
> >>>> --- a/net/bluetooth/hci_event.c
> >>>> +++ b/net/bluetooth/hci_event.c
> >>>> @@ -2323,12 +2323,13 @@ static void hci_cs_create_conn(struct hci_de=
v *hdev, __u8 status)
> >>>>
> >>>>           if (status) {
> >>>>                   if (conn && conn->state =3D=3D BT_CONNECT) {
> >>>> -                       if (status !=3D HCI_ERROR_COMMAND_DISALLOWED=
 || conn->attempt > 2) {
> >>>> +                       if (status =3D=3D HCI_ERROR_COMMAND_DISALLOW=
ED) {
> >>>> +                               conn->state =3D BT_CONNECT2;
> >>>> +                       } else {
> >>>>                                   conn->state =3D BT_CLOSED;
> >>>>                                   hci_connect_cfm(conn, status);
> >>>>                                   hci_conn_del(conn);
> >>>> -                       } else
> >>>> -                               conn->state =3D BT_CONNECT2;
> >>>> +                       }
> >>>>                   }
> >>>>           } else {
> >>>>                   if (!conn) {
> >>>> --
> >>>> 2.43.0
> >>>>
> >>>
> >>>
> >>
> >> Cheers,
> >> Jonas
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

