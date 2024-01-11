Return-Path: <linux-kernel+bounces-23359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E5682AB94
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364D91F23852
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302BE14AB7;
	Thu, 11 Jan 2024 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpPhU3LX"
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C9012E56;
	Thu, 11 Jan 2024 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-dbd99c08cd6so4292450276.0;
        Thu, 11 Jan 2024 02:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704967612; x=1705572412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7JTktBkm8gFh5MXEfp0OQqBKw21f4L24D+M6JT7r1k=;
        b=QpPhU3LX2VVPNxtotFCkk1Z2lUcCVu1er5Wr2tsGua3aSRwdHrVNUqABf3RX0bdVP2
         sA62nroyfxpquAhIahrWso67+R0aIGRDz8gUXAzNdUXruELV7X1qDIqREQoi0ZIhIJ0j
         XAvnli+5rsmpohdyUEDqb+x8EXjnrgcEDTQZWtXKHd0Uukbulgq1/kQmK6LWVUQ7ibsb
         Fext+Dj6hPqj+sAkkOyIuq2hJni5tsAp4xhpJzPnTbRYx5+bombmeEWA5AOQoy1Zl78o
         mtLxtundVgJKuq5AE3VwJ0uMT9ph0AprRVRpbnQJpO67jKZ3slIDfST/jssP7329zj+J
         LWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704967612; x=1705572412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7JTktBkm8gFh5MXEfp0OQqBKw21f4L24D+M6JT7r1k=;
        b=mE7FOQmDbkbWcCbar5DRBZlPrX9xobz2NplWzjxksRcaDFNWNAh0a9JEN6eCpofpJ0
         6l2an7WQ3AMgTzKh5H8cDovIHtfcouY+D7Dszg+RWzjMjN8rKWpC9NuRjnhf53ejH+0A
         fnYb913G2jGNJktnCdZoCZPIFROkjTjPCqFhC7N51firo2JGuU6Qp89HSIOxZoMd4fx1
         6xtIGWq1GVMnqd6paoGjIGNmL6SHkP9nOooG5Hmj7fEyP4WRhrTs5H9JcBJzpYkzPg6d
         Fwd5Dlx3Fu4dVWv4NmaMOkSPj5rfGGnZMKdbg58vbVTYuDsa0xmKqECCIf9dPE//azz5
         KQTA==
X-Gm-Message-State: AOJu0YwgY52SohGmXxeSJca1Vh9o9JmFDutsBHuMUeui1RU3UWCmhKU8
	NtzH5egZ1jdDX7Y4BQcBgf8R2UpXqAz/9O0Maow=
X-Google-Smtp-Source: AGHT+IF6wjlAizgFZUgMEzjtBdfGS9VC4jcDFd/tbMntx/qBYZ4P0q27dNNItszMr0moC2PJZgedClyl1lVhkigPips=
X-Received: by 2002:a25:2d17:0:b0:dbe:3d4b:232 with SMTP id
 t23-20020a252d17000000b00dbe3d4b0232mr958989ybt.115.1704967612073; Thu, 11
 Jan 2024 02:06:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109031204.15552-1-menglong8.dong@gmail.com>
 <CADxym3azdds6dRDdvofHj1cxZ1QxcN1S8EkrLtYtKy4opoPrFw@mail.gmail.com>
 <CANn89i+G-4=70KA4DBJqmFRXH9T3_eaOUmVVDBDH9NWY2PNzwQ@mail.gmail.com> <CANn89iLe9q3EyouoiSfodGBuQd1bHo5BhQifk47L9gG7x29Gbg@mail.gmail.com>
In-Reply-To: <CANn89iLe9q3EyouoiSfodGBuQd1bHo5BhQifk47L9gG7x29Gbg@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 11 Jan 2024 18:06:40 +0800
Message-ID: <CADxym3YHYoLpDsJ1qx3p74eqGPV-CY8sOqxnX+VvzL8SegD_AQ@mail.gmail.com>
Subject: Re: [PATCH] net: tcp: accept old ack during closing
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 6:41=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Jan 10, 2024 at 11:25=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Wed, Jan 10, 2024 at 4:08=E2=80=AFAM Menglong Dong <menglong8.dong@g=
mail.com> wrote:
> > >
> >
> > >
> > > Oops, It should be "SKB_DR_SET(reason, NOT_SPECIFIED);" here.
> > > Sorry that I shouldn't be too confident to compile it.
> > >
> >
> > net-next is closed, come back in ~two weeks, thanks.

Okay, I'll send the V2 after two weeks.

>
> Also look at commit d0e1a1b5a833b625c ("tcp: better validation of
> received ack sequences"), for some context.

Yeah, I already analyzed this commit before. I think that the return
value of tcp_ack() mean different thing to SYN_SEND and FIN_WAIT1
if it is zero, and should be handled separately.

Anyway, we can discuss this part when the net-next is opened.

Thanks!
Menglong Dong

