Return-Path: <linux-kernel+bounces-15733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85477823100
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A16E1F24D00
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3FC1BDE3;
	Wed,  3 Jan 2024 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzqvguKC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEB51B281;
	Wed,  3 Jan 2024 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cce6bb9b48so53708711fa.1;
        Wed, 03 Jan 2024 08:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704297919; x=1704902719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xSmaxNNRur6EQbpLrc86FJLNqnjCzsSA88jkGjqdDk=;
        b=gzqvguKCU/DDtJNq0POQ03fdIaM7xLYUqjdovhnDX/Op5x/YhQz54e2g1lAp/AIDXO
         yMO63unfQzYz9v3FPU4VF5GiNk89y4FLsDRoSq3FzuApCuYEHd5OIB8TL8ky3AC4ZlX6
         EEvdU0VQxsHd1R0wFBBEVTuVgJ6nFd2jZhp4mn9XPL4sW9KLzZxVtLjgC4EFxr/SXAMz
         TqXdwX24dapAdoTeU5iS+lGaa/SUSTZ55XOqOM/jd6DRHrUlIfOUpxcjd2GlrB1aQjn8
         ZbalrFg/50u/HJTz77ljjM0DZWg9UJTk7y209XscHHnWIxw/M7d+as2Rpps1Ln/RMqjP
         4XeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704297919; x=1704902719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xSmaxNNRur6EQbpLrc86FJLNqnjCzsSA88jkGjqdDk=;
        b=GRShHbQKSqas2AZ/JiWbp+VLLK8Hp9VItI4fB1q0yyIJoz8K7OCTe/MzTbGv6wYo1f
         Sb2OqKq//h2a4Xfmar1OdqvTdxi+PZPh4aNrg0m6uumMUJ16UDl4brc7UAl+q/GwKYgj
         tLaIFuX1pZo40OT7hHrqZBJzFVPuY4y5Dk3lbgdG07VTs0av63YUXi4XD0wSkHdsrDqu
         6g7MqHuwV8Zm3uLbn53GYy9cXWNh1m2tjjcDtYJgoi0GC/5D0+WiTMpjpcab81BEML0e
         GuQb0jjMOjFPIrBJV8RuxoMnf0yY5ZA1CCYRXI4v9cY7Gg56bP79odWLktLybOg0IsBR
         xVSg==
X-Gm-Message-State: AOJu0Yw2Uf1vCihU8FAHcYU3qOQ5J1r8IfsTOKMiA/Se8gh3ypAcQrIn
	oEdkO58gSvWkSuKYL86fDefZZB8KX1ZgbuAeWM28rrA7Am8=
X-Google-Smtp-Source: AGHT+IFeXbNfc9PPeUFuM6/SEH6Mga7ci/PhjUGshLV+ygtgPd78rKp7oZmKPWKx3n84n1GtUKOkND5h70UMCiYlB9U=
X-Received: by 2002:a2e:9b95:0:b0:2cc:d45a:48ea with SMTP id
 z21-20020a2e9b95000000b002ccd45a48eamr2671783lji.56.1704297919417; Wed, 03
 Jan 2024 08:05:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102185933.64179-1-verdre@v0yd.nl> <20240102185933.64179-4-verdre@v0yd.nl>
In-Reply-To: <20240102185933.64179-4-verdre@v0yd.nl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 3 Jan 2024 11:05:05 -0500
Message-ID: <CABBYNZLoivEW=yrDtTbu5SjGauESH0zHb7NXs0YaSKSKqre5GQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] Bluetooth: hci_event: Remove limit of 2 reconnection attempts
To: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Tue, Jan 2, 2024 at 1:59=E2=80=AFPM Jonas Dre=C3=9Fler <verdre@v0yd.nl> =
wrote:
>
> Since commit 4c67bc74f016b0d360b8573e18969c0ff7926974, we retry connectin=
g
> later when we get a "Command Disallowed" error returned by "Create
> Connection".
>
> In this commit the intention was to retry only once, and give up if we se=
e
> "Command Disallowed" again on the second try.
>
> This made sense back then when the retry was initiated *only* from the
> "Connect Complete" event. If we received that event, we knew that now the
> card now must have a "free slot" for a new connection request again. Thes=
e
> days we call hci_conn_check_pending() from a few more places though, and
> in these places we can't really be sure that there's a "free slot" on the
> card, so the second try to "Create Connection" might fail again.
>
> Deal with this by being less strict about these retries and try again
> every time we get "Command Disallowed" errors, removing the limitation to
> only two attempts.
>
> Since this can potentially cause us to enter an endless cycle of
> reconnection attempts, we'll add some guarding against that with the next
> commit.

Don't see where you are doing such guarding, besides you seem to
assume HCI_ERROR_COMMAND_DISALLOWED would always means the controller
is busy, or something like that, but it could perform the connection
later, but that may not always be the case, thus why I think
reconnecting just a few number of times is better, if you really need
to keep retrying then this needs to be controlled by a policy in
userspace not hardcoded in the kernel, well I can even argument that
perhaps the initial number of reconnection shall be configurable so
one don't have to recompile the kernel if that needs changing.

> Signed-off-by: Jonas Dre=C3=9Fler <verdre@v0yd.nl>
> ---
>  net/bluetooth/hci_event.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index e8b4a0126..e1f5b6f90 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2323,12 +2323,13 @@ static void hci_cs_create_conn(struct hci_dev *hd=
ev, __u8 status)
>
>         if (status) {
>                 if (conn && conn->state =3D=3D BT_CONNECT) {
> -                       if (status !=3D HCI_ERROR_COMMAND_DISALLOWED || c=
onn->attempt > 2) {
> +                       if (status =3D=3D HCI_ERROR_COMMAND_DISALLOWED) {
> +                               conn->state =3D BT_CONNECT2;
> +                       } else {
>                                 conn->state =3D BT_CLOSED;
>                                 hci_connect_cfm(conn, status);
>                                 hci_conn_del(conn);
> -                       } else
> -                               conn->state =3D BT_CONNECT2;
> +                       }
>                 }
>         } else {
>                 if (!conn) {
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz

